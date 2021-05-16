import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  var _language = 'en';
  var _fontFamily = 'Roboto';
  var _fontSize = 18.0;
  var _isDarkTheme = false;
  var _color = Colors.orange;

  String get language => _language;
  setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  String get fontFamily => _fontFamily;
  setFontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    notifyListeners();
  }

  double get fontSize => _fontSize;
  setFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }

  bool get isDarkTheme => _isDarkTheme;
  setIsDarkTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }

  Color get color => _color;
  setColor(Color color) {
    _color = color;
    notifyListeners();
  }
}