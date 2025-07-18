import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../home/presentation/views/home_view.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var countryCode = '966'.obs;
  var phoneNumber = ''.obs;

  void updatePhoneNumber(String phone) {
    phoneNumber.value = phone;
  }

  void updateCountryCode(String code) {
    countryCode.value = code;
  }

  Future<void> loginWithPhone() async {
    final fullPhone = '+${countryCode.value}${phoneNumber.value}';

    isLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhone,
        timeout: const Duration(seconds: 60),

        // ✅ تسجيل مباشر بدون كود يدوي
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            isLoading.value = false;
            Get.offAll(() => const HomeView());
          } catch (_) {
            isLoading.value = false;
            Get.snackbar("فشل الدخول", "تعذر تسجيل الدخول تلقائياً");
          }
        },

        // ❌ لو الرقم مش صحيح أو غير مدعوم
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          String message = e.message ?? "فشل في التحقق";
          if (e.code == 'invalid-phone-number') {
            message = 'رقم الهاتف غير صالح.';
          }
          Get.snackbar("فشل التحقق", message);
        },

        // ⛔️ مش هنبعت كود
        codeSent: (_, __) {
          isLoading.value = false;
          Get.snackbar("معلومة", "لم يتم تسجيل الدخول تلقائياً، حاول من جهاز آخر");
        },

        codeAutoRetrievalTimeout: (_) {
          isLoading.value = false;
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "حدث خطأ أثناء تسجيل الدخول");
    }
  }
}
