import 'package:flutter/material.dart';

class changeTheme with ChangeNotifier {
  ThemeData _themeData;

  changeTheme(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme)
  {
  _themeData = theme;
  notifyListeners();
  }
}
