import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeType _currentThemeType = ThemeType.light;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentThemeType =
    _currentThemeType == ThemeType.light ? ThemeType.dark : ThemeType.light;
    _currentTheme = _currentThemeType == ThemeType.light
        ? ThemeData.light()
        : ThemeData.dark();
    notifyListeners();
  }
}
