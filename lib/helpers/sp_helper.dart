import 'package:shared_preferences/shared_preferences.dart';

final String _accessTokenKey = "fs_access_token";
final String _themeKey = "fs_app_theme";

class SpHelper {
  // Store Access Token:
  static Future<bool> addOrUpdateAccessToken(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(_accessTokenKey, value);
  }

  // Get Access Token:
  static Future<String?> readAccessToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString(_accessTokenKey);
    return accessToken;
  }

  // Remove Access Token:
  static Future<bool> removeAccessToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(_accessTokenKey);
  }

  // Save Theme Mode:
  static void addOrUpdateThemeMode(String modeName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(_themeKey, modeName);
  }

  // Get Theme Mode:
  static Future<String?> getThemeMode() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final theme = sp.getString(_themeKey);
    return theme;
  }

  // Remove Theme:
  static Future<bool> removeThemeMode() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(_themeKey);
  }

  // Signout:
  static Future<void> removeAllData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(_accessTokenKey);
    sp.remove(_themeKey);
  }
}
