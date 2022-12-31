import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<bool> setString(String key, String value) async {
    final prefs = await getInstance();
    return prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await getInstance();
    return prefs.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    final prefs = await getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await getInstance();
    return prefs.getBool(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final prefs = await getInstance();
    return prefs.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> setDouble(String key, double value) async {
    final prefs = await getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final prefs = await getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await getInstance();
    return prefs.setStringList(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    final prefs = await getInstance();
    return prefs.getStringList(key);
  }

  static Future<bool> remove(String key) async {
    final prefs = await getInstance();
    return prefs.remove(key);
  }

  static Future<bool> clear() async {
    final prefs = await getInstance();
    return prefs.clear();
  }

  static Future<bool> containsKey(String key) async {
    final prefs = await getInstance();
    return prefs.containsKey(key);
  }

  static Future<Set<String>> getKeys() async {
    final prefs = await getInstance();
    return prefs.getKeys();
  }
}
