import 'dart:ui' show Locale;

import 'package:get/get.dart';

import '../core/services/storage_service.dart';

class LanguageController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  void toggleLanguage() async {
    final current = Get.locale?.languageCode ?? 'ar';
    final newLang = current == 'ar' ? 'en' : 'ar';

    // حدّث واجهة التطبيق
    Get.updateLocale(Locale(newLang));

    // احفظ الاختيار
    await _storage.saveLanguage(newLang);
  }
}
