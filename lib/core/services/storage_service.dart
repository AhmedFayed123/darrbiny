import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyUserLoggedIn = 'user_logged_in';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyFirstLaunch = 'firstLaunch';
  static const String _keyToken = 'user_token';
  static const String _keyUserId = 'user_id';
  static const String _keyLanguageCode  = 'language_code';

  Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguageCode, langCode);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguageCode);
  }
  // تخزين قيمة في SharedPreferences
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // استرجاع قيمة من SharedPreferences
  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // حذف قيمة من SharedPreferences
  Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // حفظ بيانات الجلسة (المستخدم)
  Future<void> saveUserSession({
    required int userId,
    required String userName,
    required String userEmail,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyUserLoggedIn, true);
    await prefs.setInt(_keyUserId, userId);
    await prefs.setString(_keyUserName, userName);
    await prefs.setString(_keyUserEmail, userEmail);
    await prefs.setString(_keyToken, token);
  }

  // استرجاع بيانات المستخدم
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userName': prefs.getString(_keyUserName) ?? '',
      'userEmail': prefs.getString(_keyUserEmail) ?? '',
      'token': prefs.getString(_keyToken) ?? '',
    };
  }

  // التحقق من حالة تسجيل الدخول
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyUserLoggedIn) ?? false;
  }

  // استرجاع التوكن
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  // تسجيل الخروج
// تسجيل الخروج
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // تخزين حالة الإطلاق الأول
  Future<void> setFirstLaunch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLaunch, value);
  }

  // استرجاع حالة الإطلاق الأول
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstLaunch) ?? true;
  }
}
