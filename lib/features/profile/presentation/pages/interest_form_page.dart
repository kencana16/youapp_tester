import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_tester/app_theme.dart';
import 'package:youapp_tester/base/widget/golden_widget.dart';
import 'package:youapp_tester/base/widget/you_app_scaffold.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';

import '../../domain/entities/profile.dart';
import '../bloc/profile_bloc.dart';

class InterestFormPage extends StatefulWidget {
  const InterestFormPage({
    super.key,
  });

  @override
  State<InterestFormPage> createState() => _InterestFormPageState();
}

class _InterestFormPageState extends State<InterestFormPage> {
  GlobalKey<FormBuilderState> formKey = GlobalKey();
  ValueNotifier<bool> isFormValid = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }

        if (state is ProfileFound) {
          context.pop();
        }
      },
      child: BlocSelector<ProfileBloc, ProfileState, Profile?>(
        selector: (state) {
          if (state is ProfileFound) return state.profile;

          return null;
        },
        builder: (context, profile) {
          return FormBuilder(
            key: formKey,
            initialValue: {"interests": profile?.interests?.toSet()},
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: YouAppScaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
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
                actions: [
                  GoldenWidget(
                    child: TextButton(
                      onPressed: onSavePressed,
                      child: const Text("Save"),
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(60),
                    GoldenWidget(
                        child: Text(
                      "Tell everyone about yourself",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                    const Gap(12),
                    Text(
                      "What interest you?",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Gap(25),
                    FormBuilderField<Set<String>>(
                      builder: (state) {
                        var controller = TextEditingController();
                        Set<String> data = state.value ?? {};

                        var focusNode = FocusNode();
                        return InputDecorator(
                          decoration: const InputDecoration(),
                          child: Wrap(
                            spacing: 4,
                            children: [
                              ...data.map((e) => InputChip(
                                    label: Text(e),
                                    onDeleted: () {
                                      var tempData = data.toList();
                                      tempData.removeWhere(
                                          (element) => element == e);
                                      state.didChange(tempData.toSet());
                                    },
                                  )),
                              TextField(
                                focusNode: focusNode,
                                controller: controller,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    filled: false),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (v) {
                                  var tempData = data.toList();
                                  tempData.add(v);
                                  state.didChange(tempData.toSet());
                                  focusNode.requestFocus();
                                },
                                autofocus: true,
                              )
                            ],
                          ),
                        );
                      },
                      name: "interests",
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onSavePressed() {
    var formState = formKey.currentState;

    if (formState != null) {
      if (formState.saveAndValidate()) {
        var value = formState.value;

        List<String>? valueInterests =
            (value['interests'] as Set<String>?)?.toList();

        context.read<ProfileBloc>().add(
              ProfileEventUpdateInterests(
                accessToken: context.read<LoginCubit>().state.getAccessToken(),
                interests: valueInterests ?? [],
              ),
            );
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
