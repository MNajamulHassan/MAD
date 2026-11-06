import 'package:shared_preferences/shared_preferences.dart';

/// Saves one account on the device using SharedPreferences.
class AuthService {
  static const _nameKey = 'fe_user_name';
  static const _emailKey = 'fe_user_email';
  static const _passwordKey = 'fe_user_password';

  static Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email.trim().toLowerCase());
    await prefs.setString(_passwordKey, password);
  }

  /// Returns the user's name if the details match, otherwise null.
  static Future<String?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_emailKey);
    final savedPassword = prefs.getString(_passwordKey);

    if (savedEmail == null || savedPassword == null) return null;
    if (savedEmail == email.trim().toLowerCase() && savedPassword == password) {
      return prefs.getString(_nameKey) ?? 'Foodie';
    }
    return null;
  }

  /// Name and email of the saved account (for the profile screen).
  static Future<Map<String, String>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_nameKey) ?? 'Foodie',
      'email': prefs.getString(_emailKey) ?? 'no email saved',
    };
  }
}
