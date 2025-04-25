import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';


class AppModel extends ChangeNotifier {
  late Locale _activeLanguage;

  AppModel() {
    _activeLanguage = const Locale('ar');
    initializeLanguage();
  }

  Locale get activeLanguage => _activeLanguage;

  Future<void> initializeLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('selectedLanguage');

    if (selectedLanguage != null) {
      _activeLanguage = Locale(selectedLanguage);
    }

    notifyListeners();
  }

  Future<void> setActiveLanguageCode(String languageCode) async {
    _activeLanguage = Locale(languageCode);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
  }

  Future<void> toggleLanguage() async {
    _activeLanguage = (_activeLanguage.languageCode == 'ar')
        ? const Locale('en')
        : const Locale('ar');

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', _activeLanguage.languageCode);
  }
}

final appModelProvider = ChangeNotifierProvider((ref) => AppModel());
double roundToDecimal(double number, int decimalPlaces) {
  num mod = pow(10.0, decimalPlaces);
  return (number * mod).round() / mod;
}