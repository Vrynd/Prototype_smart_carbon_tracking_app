import 'package:flutter/material.dart';
import 'package:smart_carbon_tracking/core/themes/app_font.dart';

class MyTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: MyFont.displayLarge,
      displayMedium: MyFont.displayMedium,
      displaySmall:MyFont.displaySmall,
      headlineLarge: MyFont.headlineLarge,
      headlineMedium: MyFont.headlineMedium,
      headlineSmall: MyFont.headlineSmall,
      titleLarge: MyFont.titleLarge,
      titleMedium: MyFont.titleMedium,
      titleSmall: MyFont.titleSmall,
      bodyLarge: MyFont.bodyLarge,
      bodyMedium: MyFont.bodyMedium,
      bodySmall: MyFont.bodySmall,
      labelLarge: MyFont.labelLarge,
      labelMedium: MyFont.labelMedium,
      labelSmall: MyFont.labelSmall,
    );
  }

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF63A002),
      brightness: Brightness.light,
    ),
    textTheme: _textTheme,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF63A002),
      brightness: Brightness.dark,
    ),
    textTheme: _textTheme,
    useMaterial3: true,
  );
}

extension ThemeExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}