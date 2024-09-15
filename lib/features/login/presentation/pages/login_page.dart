import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_tester/app_theme.dart';
import 'package:youapp_tester/base/widget/you_app_scaffold.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/base/widget/golden_link.dart';
import 'package:youapp_tester/base/widget/password_form_field.dart';
import 'package:youapp_tester/routing/app_router.dart';

class LoginPage extends StatefulWidget {
  final String? from;

  const LoginPage({
    super.key,
    this.from,
  });

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GlobalKey<FormBuilderState> formKey = GlobalKey();
  ValueNotifier<bool> isFormValid = ValueNotifier(false);

  void checkFormValid() {
    formKey.currentState?.validate(focusOnInvalid: false);
    isFormValid.value = formKey.currentState?.isValid ?? false;
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state) {
          case LoginInitial():
            EasyLoading.dismiss();
            return;
          case LoginLoading():
            EasyLoading.show();
            return;
          case LoginSuccess():
            EasyLoading.dismiss();
            GoRouter.of(context).replace(widget.from ?? '/');

            return;
          case LoginFailed():
            EasyLoading.dismiss();
            EasyLoading.showError(state.e.toString());
            return;
        }
      },
      child: AutofillGroup(
        child: FormBuilder(
          key: formKey,
          onChanged: () {
            checkFormValid();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: YouAppScaffold(
            backgroundColor: Colors.transparent,
            appBar:
                /*  CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                previousPageTitle: "Back",
              ), */

                AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: (GoRouter.of(context).canPop())
                  ? InkWell(
                      onTap: () => GoRouter.of(context).pop(),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chevron_left),
                          Text("Back"),
                        ],
                      ),
                    )
                  : null,
            ),
            body: Theme(
              data: loginThemeData(context),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: build3(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column build3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(60),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Login",
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
          autofillHints: const [AutofillHints.username],
          name: "username",
          decoration: const InputDecoration(
            hintText: "Enter Username",
          ),
          validator: FormBuilderValidators.required(),
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        const Gap(15),
        PasswordFormField(
          autofillHints: const [AutofillHints.password],
          name: "password",
          hintText: "Enter Password",
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(8)
          ]),
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        const Gap(15),
        ValueListenableBuilder<bool>(
            valueListenable: isFormValid,
            builder: (context, state, _) {
              return FilledButton(
                onPressed: state
                    ? () {
                        login(context);
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
                      "Login",
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
                "No account? ",
              ),
              GoldenLink(
                "Register Here",
                onTap: () {
                  RegisterRoute(from: widget.from).push(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void login(BuildContext context) {
    var formState = formKey.currentState;

    if (formState != null) {
      if (formState.saveAndValidate()) {
        var value = formState.value;

        String email = (value['email'] as String);
        String username = (value['username'] as String);
        String password = (value['password'] as String);

        context.read<LoginCubit>().login(
              email: email,
              username: username,
              password: password,
            );

        TextInput.finishAutofillContext(shouldSave: true);
      }
    }
  }
}

const LinearGradient loginBtnGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF62CDCB),
    Color(0xFF4599DB),
  ],
);
ThemeData loginThemeData(BuildContext context) => Theme.of(context).copyWith(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onBackground),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: goldGradient2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.white12,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ).copyWith(
        backgroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return loginBtnGradient.colors.first.withOpacity(.85);
          }
          return Colors.transparent;
        }),
        shadowColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.transparent;
          }

          return loginBtnGradient.colors.first;
        }),
        elevation: MaterialStateProperty.resolveWith<double>((states) {
          if (states.contains(MaterialState.disabled)) {
            return 0;
          }

          return 10;
        }),
      ),
    ));
