// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:shutup/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  
  bool get isDarkMode => _themeData == darkMode;
  
}
