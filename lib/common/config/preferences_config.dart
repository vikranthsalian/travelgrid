import 'package:shared_preferences/shared_preferences.dart';

class PreferenceConfig {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> get _instance async =>
      _preferences??= await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _preferences = await _instance;
    return _preferences;
  }

  static String? getString(String key, [String? defValue = ""]) {
    String? value = _preferences!.getString(key) ?? defValue;
    return value != defValue ? value : defValue;
  }

  static Future<bool> setString(String key, String value) {
    return _preferences!.setString(key, (value) != "" ? value : "" );
  }

  static List<String>? getStringList(String key,
      [List<String>? defValue = const []]) {
    return _preferences!.getStringList(key) ?? defValue;
  }

  static Future<bool> setStringList(String key, List<String> stringsList) {
    return _preferences!.setStringList(key, stringsList);
  }

  static bool? getBool(String key, [bool defValue = false]) {
    return _preferences!.getBool(key) ?? defValue;
  }

  static Future<bool> setBool(String key, bool value) {
    return _preferences!.setBool(key, value);
  }

  static double? getDouble(String key, [double defValue = 0.0]) {
    return _preferences!.getDouble(key) ?? defValue;
  }

  static Future<bool> setDouble(String key, double value) {
    return _preferences!.setDouble(key, value);
  }

  static Future<bool> removeKey(String key) {
    return _preferences!.remove(key);
  }

  static bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }

  static Future<bool> clearPreference() async {
    return await _preferences!.clear();
  }
}
