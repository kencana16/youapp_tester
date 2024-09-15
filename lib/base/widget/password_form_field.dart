import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:youapp_tester/base/widget/golden_widget.dart';

class PasswordFormField extends StatefulWidget {
  final String name;
  final String? hintText;
  final FormFieldValidator<String?>? validator;
  final Iterable<String>? autofillHints;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;

  const PasswordFormField({
    super.key,
    required this.name,
    this.hintText,
    this.validator,
    this.autofillHints,
    this.onEditingComplete,
    this.textInputAction,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscureText = true;
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      autofillHints: widget.autofillHints,
      focusNode: focusNode,
      name: widget.name,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: GoldenWidget(
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ),
      buildCounter: (context,
          {required currentLength, required isFocused, required maxLength}) {
        if (focusNode.hasFocus == false) return const SizedBox.shrink();

        return Text(
          '$currentLength',
          semanticsLabel: 'character count',
          style: const TextStyle(fontSize: 8),
        );
      },
      obscureText: obscureText,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
