import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Exception error;
  const ErrorPage({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
