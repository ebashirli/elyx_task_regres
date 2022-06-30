import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static SharedPreferences? _preferences;

  static const _keyToken = "token";
  static const _keyEmail = "id";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
      await _preferences?.setString(_keyToken, token);

  static String? getToken() => _preferences?.getString(_keyToken);

  static removeToken() => _preferences?.remove(_keyToken);

  static Future setEmail(String email) async =>
      await _preferences?.setString(_keyEmail, email);

  static String? getEmail() => _preferences?.getString(_keyEmail);

  static removeEmail() => _preferences?.remove(_keyEmail);
}
