import 'package:shared_preferences/shared_preferences.dart';

/// Generic typed singleton wrapper around [SharedPreferences].
///
/// Initialize in [main] via [PrefsService.init], then access anywhere via
/// [PrefsService.instance].
class PrefsService {
  PrefsService._(this._prefs);

  static late final PrefsService instance;

  /// Must be called once before accessing [instance].
  static void init(SharedPreferences prefs) {
    instance = PrefsService._(prefs);
  }

  final SharedPreferences _prefs;

  // -- bool --

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  // -- int --

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  // -- double --

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  Future<void> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  // -- String --

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  // -- String list --

  List<String> getStringList(String key, {List<String> defaultValue = const []}) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  Future<void> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  // -- remove --

  Future<void> remove(String key) {
    return _prefs.remove(key);
  }
}
