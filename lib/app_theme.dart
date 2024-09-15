import 'package:flutter/material.dart';

const colorGradient1 = Color(0XFF1F4247);
const colorGradient2 = Color(0XFF0D1D23);
const colorGradient3 = Color(0XFF09141A);

const colorBackground = Color(0XFF0E191F);

const goldGradient1 = Color(0xFF94783E);
const goldGradient2 = Color(0xFFF3EDA6);
const goldGradient3 = Color(0xFFF8FAE5);
const goldGradient4 = Color(0xFFFFE2BE);
const goldGradient5 = Color(0xFFD5BE88);
const goldGradient6 = Color(0xFFF8FAE5);
const goldGradient7 = Color(0xFFD5BE88);
const linearGradient = LinearGradient(
  colors: [
    goldGradient1, // 2%
    goldGradient2, // 22%
    goldGradient3, // 33%
    goldGradient4, // 49%
    goldGradient5, // 72%
    goldGradient6, // 81%
    goldGradient7, // 90%
  ],
  stops: [
    0.02, // 2%
    0.22, // 22%
    0.33, // 33%
    0.49, // 49%
    0.72, // 72%
    0.81, // 81%
    0.90, // 90%
  ],
);

ThemeData generateTheme(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: colorGradient1,
    ),
    scaffoldBackgroundColor: colorBackground,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.onBackground),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: goldGradient1),
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.white12,
      isDense: true,
    ),
    useMaterial3: true,
  );
}
