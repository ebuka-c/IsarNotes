import 'package:flutter/material.dart';

import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  //initially light Theme
  ThemeData _themeData = lightMode;

  //getter method to access the theme
  ThemeData get themeData => _themeData;

  //getter method to see if we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  //setter method to set the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //toggle Theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
