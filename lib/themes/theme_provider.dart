import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'darkmode.dart';
import 'lightmode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  bool _isDarkMode = false;
  bool _isLoading = true; // Prevent UI flickering on startup

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading; // Expose loading state

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? darkTheme : lightTheme;

    await _saveTheme(
        _isDarkMode); // Ensure save is completed before updating UI
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = _isDarkMode ? darkTheme : lightTheme;

    _isLoading = false; // Mark as loaded
    notifyListeners();
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isDarkMode', isDark); // Ensure completion before UI update
  }
}
