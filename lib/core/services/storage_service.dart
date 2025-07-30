import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyAccountType = 'account_type';
  static const String _keyFirstLaunch = 'firstLaunch';
  static const String _keyLanguageCode = 'language_code';

  /// Save data by key (generic use)
  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Save user login session
  Future<void> saveLoginSession({
    required String accountType,
    required String token,
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final tokenKey = accountType == 'instructor' ? 'instructor_token' : 'learner_token';
    final idKey = accountType == 'instructor' ? 'instructor_id' : 'learner_id';
    final nameKey = accountType == 'instructor' ? 'instructor_name' : 'learner_name';
    final emailKey = accountType == 'instructor' ? 'instructor_email' : 'learner_email';

    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyAccountType, accountType);
    await prefs.setString(tokenKey, token);
    await prefs.setString(idKey, userId);
    await prefs.setString(nameKey, userName);
    await prefs.setString(emailKey, userEmail);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<String?> getAccountType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccountType);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accountType = await getAccountType();
    final tokenKey = accountType == 'instructor' ? 'instructor_token' : 'learner_token';
    return prefs.getString(tokenKey);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final accountType = await getAccountType();
    final idKey = accountType == 'instructor' ? 'instructor_id' : 'learner_id';
    return prefs.getString(idKey);
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> setFirstLaunch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLaunch, value);
  }

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstLaunch) ?? true;
  }

  Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguageCode, langCode);
  }

  Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLanguageCode);
  }
  Future<String?> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final accountType = prefs.getString(_keyAccountType);
    final token = accountType == 'instructor'
        ? prefs.getString('instructor_token')
        : prefs.getString('learner_token');

    if (token != null && token.isNotEmpty) {
      return accountType;
    }
    return null;
  }

}
