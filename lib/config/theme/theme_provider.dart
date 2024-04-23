import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  set ThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

}