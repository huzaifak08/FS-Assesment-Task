import 'package:shared_preferences/shared_preferences.dart';

final String _accessTokenKey = "fs_access_token";
final String _refreshTokenKey = "fs_refresh_token";
final String _themeKey = "fs_app_theme";

class SpHelper {
  // Store Access Token:
  static void addOrUpdateAccessToken(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(_accessTokenKey, value);
  }

  // Get Access Token:
  static Future<String?> readAccessToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final interest = sp.getString(_accessTokenKey);
    return interest;
  }

  // Remove Access Token:
  static Future<bool> removeAccessToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(_accessTokenKey);
  }

  // Store Refresh Token:
  static void addOrUpdateRefreshToken(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(_refreshTokenKey, value);
  }

  // Get Refresh Token:
  static Future<String?> readRefreshToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final interest = sp.getString(_refreshTokenKey);
    return interest;
  }

  // Remove Refresh Token:
  static Future<bool> removeRefreshToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(_refreshTokenKey);
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
    sp.remove(_refreshTokenKey);
    sp.remove(_themeKey);
  }
}
