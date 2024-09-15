// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:youapp_tester/base/widget/golden_link.dart';
import 'package:youapp_tester/base/widget/password_form_field.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/login/presentation/pages/login_page.dart';
import 'package:youapp_tester/routing/app_router.dart';

class RegisterPage extends LoginPage {
  const RegisterPage({
    super.key,
    super.from,
  });

  @override
  LoginPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends LoginPageState {
  @override
  Column build3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(60),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Register",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(25),
        FormBuilderTextField(
          autofillHints: const [AutofillHints.email],
          name: "email",
          decoration: const InputDecoration(
            hintText: "Enter Email",
          ),
          validator: FormBuilderValidators.required(),
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        const Gap(15),
        FormBuilderTextField(
          autofillHints: const [AutofillHints.newUsername],
          name: "username",
          decoration: const InputDecoration(
            hintText: "Create Username",
          ),
          validator: FormBuilderValidators.required(),
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        const Gap(15),
        PasswordFormField(
          autofillHints: const [AutofillHints.newPassword],
          name: 'password',
          hintText: "Create Password",
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(8)
          ]),
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        const Gap(15),
        Builder(builder: (context) {
          return PasswordFormField(
            autofillHints: const [AutofillHints.newPassword],
            name: 'password_confirmation',
            hintText: "Confirm Password",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(8),
              (v) {
                var value2 = FormBuilder.of(context)?.fields['password']?.value;
                if (value2 is String) {
                  return FormBuilderValidators.equal<String>(
                    value2,
                    errorText: "Password Confirmation didn't match",
                  ).call(v);
                }

                return null;
              }
            ]),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          );
        }),
        const Gap(15),
        ValueListenableBuilder<bool>(
            valueListenable: isFormValid,
            builder: (context, state, _) {
              return FilledButton(
                onPressed: state
                    ? () {
                        register(context);
                      }
                    : null,
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: state
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: loginBtnGradient,
                        )
                      : null,
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
        const Gap(52),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 13),
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                "Have an account? ",
              ),
              GoldenLink(
                "Login Here",
                onTap: () {
                  LoginRoute(from: widget.from).push(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void register(BuildContext context) {
    var formState = formKey.currentState;

    if (formState != null) {
      if (formState.saveAndValidate()) {
        var value = formState.value;

        String email = (value['email'] as String);
        String username = (value['username'] as String);
        String password = (value['password'] as String);

        context.read<LoginCubit>().register(
              email: email,
              username: username,
              password: password,
            );
        TextInput.finishAutofillContext(shouldSave: true);
      }
    }
  }
}
