import 'package:shared_preferences/shared_preferences.dart';

class Store {
  const Store._();

  static const String _tokenKey = "TOKEN";
  static const String _rolesKey = "ROLES";
  static const String _usernameKey = "USERNAME";
  static const String _userEmailKey = "EMAIL";
  static const String _userIdKey = "USERID";

  static Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  static Future<void> setRoles(List<String> roles) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(_rolesKey, roles);
  }

  static Future<void> setUsername(String username) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usernameKey, username);
  }

  static Future<void> setEmail(String email) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userEmailKey, email);
  }

  static Future<void> setUserId(int id) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_userIdKey, id);
  }

  static Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  static Future<List<String>?> getRoles() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(_rolesKey);
  }

  static Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_usernameKey);
  }

  static Future<String?> getEmail() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userEmailKey);
  }

  static Future<int?> getId() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_userIdKey);
  }

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
