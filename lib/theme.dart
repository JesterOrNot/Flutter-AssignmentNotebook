import 'package:flutter/material.dart';

class FlutterBookTheme with ChangeNotifier {
  static bool isDarkMode = true;

  ThemeMode currentTheme() {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
