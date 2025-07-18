// services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    // تحقق من بيانات تسجيل الدخول (مثلاً باستخدام API)
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setBool('isLoggedIn', true);
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('isLoggedIn');
  }

  Future<bool> checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
