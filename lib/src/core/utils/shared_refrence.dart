import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final String _chooseLang = "chooseLang";
  late SharedPreferences _prefs;
  static SharedPreferencesService? _instance;

  SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    if (_instance == null) {
      _instance = SharedPreferencesService._internal();
    }
    return _instance!;
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> init() async {
    await _initPrefs();
  }

  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Future<void> saveInt(String key, int value) async {
  //   await _prefs.setInt(key, value);
  // }

  // int getInt(String key) {
  //   return _prefs.getInt(key);
  // }

  // Future<void> saveBool(String key, bool value) async {
  //   await _prefs.setBool(key, value);
  // }
  // //  Future<void> remove(String key) async {
  //   await _prefs.remove(key);
  // }

  bool getIsSelectedLange() {
    return _prefs.getBool(_chooseLang) ?? false;
  }

  Future<void> setIsSelectedLange(bool value) async {
    await _prefs.setBool(_chooseLang, value);
  }
}
