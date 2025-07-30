import 'dart:ui' show Locale;
import 'package:get/get.dart';
import '../core/services/storage_service.dart';

class LanguageController extends GetxController {
  final StorageService _storage = Get.find<StorageService>();

  Future<void> setLanguage(String langCode) async {
    // احفظ اللغة
    await _storage.saveLanguage(langCode);

    // حدث الواجهة
    Get.updateLocale(Locale(langCode));
  }
}
