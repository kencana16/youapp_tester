import 'package:flutter/material.dart';
import 'package:youapp_tester/app_theme.dart';

class GoldenWidget extends StatelessWidget {
  const GoldenWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return linearGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      );
      },
      child: child,
    );
  }
}
