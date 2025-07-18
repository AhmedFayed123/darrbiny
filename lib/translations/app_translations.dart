import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'hello': 'Hello',
      'change_language': 'Change Language',
    },
    'ar': {
      'hello': 'مرحبا',
      'change_language': 'تغيير اللغة',
    },
  };
}
