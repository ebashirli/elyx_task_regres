import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static SharedPreferences? _preferences;

  static const _keyToken = "token";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setToken(String email) async =>
      await _preferences?.setString(_keyToken, email);

  static Future<String?> getToken() async => _preferences?.getString(_keyToken);

  static Future removeToken() async => await _preferences?.remove(_keyToken);
}
