// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:youapp_tester/features/horoscope/domain/entities/horoscope.dart';
import 'package:youapp_tester/features/horoscope/domain/usecases/get_horoscope.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/base_profile_card.dart';
import 'package:youapp_tester/features/zodiac/domain/entities/zodiac.dart';
import 'package:youapp_tester/features/zodiac/domain/usecases/get_zodiac.dart';

class AboutCard extends ProfileCard {
  final GlobalKey<FormBuilderState> formKey;
  final Profile? profile;
  AboutCard({
    super.key,
    required this.profile,
  }) : formKey = GlobalKey();

  @override
  String get title => "About";

  Map<String, dynamic> generateInitialValue(Profile profile) {
    return {
      "imageBytes": profile.imageBytes,
      "name": profile.name,
      "gender": profile.gender,
      "birthday": profile.birthday,
      "horoscope": profile.horoscope,
      "zodiac": profile.zodiac,
      "height": profile.height?.toString(),
      "weight": profile.weight?.toString(),
    };
  }

  @override
  ValueChanged<ProfileCardState>? get onClickSave => (ProfileCardState state) {
        BuildContext context = state.context;
        var formState = formKey.currentState;

        if (formState != null) {
          if (formState.saveAndValidate()) {
            var value = formState.value;

            Profile profile = this.profile ?? const Profile();

            profile = profile.copyWith(
              email: value['email'],
              username: value['username'],
              // imageBytes: value['imageBytes'],
              gender: value['gender'],
              name: value['name'],
              birthday: value['birthday'],
              height: double.tryParse(value['height']),
              weight: double.tryParse(value['weight']),
            );

            context.read<ProfileBloc>().add(
                  ProfileEventUpdateData(
                    accessToken:
                        context.read<LoginCubit>().state.getAccessToken(),
                    profile: profile,
                  ),
                );
          }
        }
      };

  @override
  Widget child(ProfileCardState state) {
    Profile? profile = this.profile;

    if (profile == null) {
      return Text(
        "Add in your your to help others know you better",
        style: Theme.of(state.context).textTheme.labelSmall?.copyWith(
            color: Theme.of(state.context)
                .textTheme
                .labelSmall
                ?.color
                ?.withOpacity(.5)),
      );
    }

    if (state.editMode) {
      return FormBuilder(
        key: formKey,
        skipDisabled: false,
        initialValue: generateInitialValue(profile),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormBuilderField<Uint8List>(
              name: "imageBytes",
              builder: (FormFieldState formFieldState) {
                var value = formFieldState.value;
                return ListTile(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();

                    /// Pick an image.
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      Uint8List readAsBytes = await image.readAsBytes();
                      formFieldState.didChange(readAsBytes);
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                    height: 58,
                    width: 58,
                    child: value == null
                        ? const Card(
                            elevation: 3,
                            child: Center(
                              child: Icon(Icons.add),
                            ),
                          )
                        : Image.memory(
                            value,
                            height: 58,
                            width: 58,
                            fit: BoxFit.cover,
                          ),
                  ),
                  title: const Text("Add Image"),
                );
              },
            ),
            const Gap(30),
            AboutTextField(
              label: "Display Name",
              name: "name",
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(state.context).nextFocus(),
            ),
            const Gap(12),
            AboutDropdownField<Gender>(
              label: "Gender",
              name: "gender",
              items: Gender.values
                  .map((e) => DropdownMenuItem(
                        alignment: Alignment.centerRight,
                        value: e,
                        child: Text(
                          ReCase(e.name).titleCase,
                          textAlign: TextAlign.end,
                        ),
                      ))
                  .toList(),
              onChanged: (_) => FocusScope.of(state.context).nextFocus(),
            ),
            const Gap(12),
            AboutDateTimePicker(
              label: "Birthday",
              name: "birthday",
              onChanged: (v) {
                if (v != null) {
                  var field = formKey.currentState?.fields['horoscope'];
                  var call = GetHoroscope().call(v);
                  field?.didChange(call);
                  var field2 = formKey.currentState?.fields['zodiac'];
                  var call2 = GetZodiac().call(v);
                  field2?.didChange(call2);
                }
              },
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(state.context).nextFocus(),
            ),
            const Gap(12),
            AboutDropdownField<Horoscope>(
              label: "Horoscope",
              name: "horoscope",
              items: Horoscope.values
                  .map((e) => DropdownMenuItem(
                        alignment: Alignment.centerRight,
                        value: e,
                        child: Text(
                          ReCase(e.name).titleCase,
                          textAlign: TextAlign.end,
                        ),
                      ))
                  .toList(),
              enabled: false,
            ),
            const Gap(12),
            AboutDropdownField<Zodiac>(
              label: "Zodiac",
              name: "zodiac",
              items: Zodiac.values
                  .map((e) => DropdownMenuItem(
                        alignment: Alignment.centerRight,
                        value: e,
                        child: Text(
                          ReCase(e.name).titleCase,
                          textAlign: TextAlign.end,
                        ),
                      ))
                  .toList(),
              enabled: false,
            ),
            const Gap(12),
            AboutTextField(
              label: "Height",
              name: "height",
              suffix: const Text('cm'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
              ],
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(state.context).nextFocus(),
            ),
            const Gap(12),
            AboutTextField(
              label: "Weight",
              name: "weight",
              suffix: const Text('Kg'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
              ],
              textInputAction: TextInputAction.done,
              onEditingComplete: () => FocusScope.of(state.context).unfocus(),
            ),
          ],
        ),
      );
    }

    var birthday = profile.birthday;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AboutCardDisplayRow(
          label: "Birthday",
          value: birthday == null
              ? "-"
              : "${DateFormat(datePattern).format(birthday)} (Age ${profile.age})",
        ),
        AboutCardDisplayRow(
          label: "Horoscope",
          value: ReCase(profile.horoscope?.name ?? "-").titleCase,
        ),
        AboutCardDisplayRow(
          label: "Zodiac",
          value: ReCase(profile.zodiac?.name ?? "-").titleCase,
        ),
        AboutCardDisplayRow(
          label: "Height",
          value: "${profile.height ?? "-"} cm",
        ),
        AboutCardDisplayRow(
          label: "Weight",
          value: "${profile.weight ?? "-"} Kg",
        ),
      ],
    );
  }
}

class AboutCardDisplayRow extends StatelessWidget {
  final String label;
  final String value;

  const AboutCardDisplayRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label : ",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color
                      ?.withOpacity(.50),
                ),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class AboutTextField extends StatelessWidget {
  final String label;
  final String name;
  final Widget? suffix;
  final FormFieldValidator<String?>? validator;
  final ValueTransformer<String?>? valueTransformer;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool enabled;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;

  const AboutTextField({
    super.key,
    required this.label,
    required this.name,
    this.suffix,
    this.validator,
    this.valueTransformer,
    this.inputFormatters,
    this.keyboardType,
    this.enabled = true,
    this.onEditingComplete,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(.85),
                ),
          ),
        ),
        const Gap(16),
        Expanded(
          flex: 2,
          child: FormBuilderTextField(
            textAlign: TextAlign.end,
            enabled: enabled,
            name: name,
            decoration: InputDecoration(suffix: suffix),
            validator: validator,
            valueTransformer: valueTransformer,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
          ),
        )
      ],
    );
  }
}

class AboutDropdownField<T> extends StatelessWidget {
  final String label;
  final String name;
  final List<DropdownMenuItem<T>> items;
  final FormFieldValidator<T?>? validator;
  final ValueTransformer<T?>? valueTransformer;
  final bool enabled;
  final ValueChanged<T?>? onChanged;

  const AboutDropdownField({
    super.key,
    required this.label,
    required this.name,
    required this.items,
    this.validator,
    this.valueTransformer,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(.85),
                ),
          ),
        ),
        const Gap(16),
        Expanded(
          flex: 2,
          child: FormBuilderDropdown(
            enabled: enabled,
            name: name,
            items: items,
            validator: validator,
            valueTransformer: valueTransformer,
            alignment: AlignmentDirectional.bottomCenter,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}

class AboutDateTimePicker extends StatelessWidget {
  final String label;
  final String name;
  final FormFieldValidator<DateTime?>? validator;
  final ValueTransformer<DateTime?>? valueTransformer;
  final ValueChanged<DateTime?>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;

  const AboutDateTimePicker({
    super.key,
    required this.label,
    required this.name,
    this.validator,
    this.valueTransformer,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(.85),
                ),
          ),
        ),
        const Gap(16),
        Expanded(
          flex: 2,
          child: FormBuilderDateTimePicker(
            textAlign: TextAlign.end,
            name: name,
            format: DateFormat(datePattern),
            validator: validator,
            valueTransformer: valueTransformer,
            inputType: InputType.date,
            onChanged: onChanged,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
          ),
        )
      ],
    );
  }
}

const String datePattern = 'dd/MM/yyyy';

Uint8List generateRandomUintList({
  int length = 10,
}) {
  Random random = Random();
  return Uint8List.fromList(List<int>.generate(
          length, (_) => random.nextInt(256)) // values between 0 and 255
      );
}
