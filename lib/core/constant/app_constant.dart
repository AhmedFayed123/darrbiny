import 'package:intl/intl.dart';

class AppConstant {
  static const String baseUrl = 'https://darrbiny.com/darrbiny/api/';
  static const String kToken = 'token';

  static String currentLanguage =
  Intl.getCurrentLocale() == 'en_US' ? 'en' : 'ar';
}