import 'package:flutter/material.dart';

var lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.grey.shade300,
        primary: Colors.grey.shade200,
        secondary: Colors.grey.shade400,
        inversePrimary: Colors.grey.shade800));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: const Color.fromARGB(255, 17, 17, 17),
        primary: Colors.grey.shade900,
        secondary: Colors.grey.shade700,
        inversePrimary: Colors.grey.shade300));
