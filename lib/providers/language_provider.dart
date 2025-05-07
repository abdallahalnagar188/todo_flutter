import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLocale = "en";

  LanguageProvider() {
    init();
  }

  Future<void> init() async {
    await readSavedLang();
  }

  void setLanguage(String languageCode) {
    currentLocale = languageCode;
    savedLang();
    notifyListeners();
  }

  Future<void> readSavedLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentLocale = prefs.getString("lang") ?? 'en';
    notifyListeners();
  }

  Future<void> savedLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", currentLocale);
  }
}
