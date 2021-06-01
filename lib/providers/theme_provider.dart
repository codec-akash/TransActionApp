import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This is theme data

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xff009688),
  accentColor: Color(0xff42A5F5),
  backgroundColor: Color(0xff42A5F5),
  textTheme:
      GoogleFonts.playfairDisplayTextTheme().apply(bodyColor: Colors.black),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green[800],
  accentColor: Colors.deepOrangeAccent,
  backgroundColor: Colors.blueGrey[800],
  textTheme:
      GoogleFonts.playfairDisplayTextTheme().apply(bodyColor: Colors.white),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _savePrefs();
    notifyListeners();
  }

  initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    await initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
