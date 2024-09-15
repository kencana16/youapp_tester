import 'package:flutter/material.dart';
import 'package:youapp_tester/base/widget/golden_widget.dart';

class GoldenLink extends StatelessWidget {
  const GoldenLink(
    this.text, {
    super.key,
    this.style,
    this.onTap,
  });

  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GoldenWidget(
        child: Text(text,
            style: (style ?? const TextStyle()).copyWith(
                decoration: TextDecoration.combine([
              if (onTap != null) TextDecoration.underline,
            ]))),
      ),
    );
  }
}
