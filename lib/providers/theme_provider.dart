import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider();

  ThemeMode get themeMode => _themeMode;

  // Always return light mode
  bool get isDark => false;
} 