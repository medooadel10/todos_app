import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  void setIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool('isDark') ?? false;
    await prefs.setBool('isDark', !isDark);
    this.isDark = !isDark;
    notifyListeners();
  }

  bool isDark = false;
  void getIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool('isDark') ?? false;
    this.isDark = isDark;
    notifyListeners();
  }
}
