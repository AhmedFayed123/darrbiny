import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../views/otp_view.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // الحالة
  var isLoading = false.obs;

  // البيانات
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var countryCode = '966'.obs; // ← كود الدولة الافتراضي (السعودية)
  var verificationId = ''.obs;

  /// تحديث الاسم
  void updateFullName(String name) {
    fullName.value = name.trim();
  }

  /// تحديث رقم الهاتف
  void updatePhoneNumber(String number) {
    phoneNumber.value = number.trim().replaceAll(' ', '').replaceAll('-', '');
  }

  /// تحديث كود الدولة (عند تغيير الدولة من picker)
  void updateCountryCode(String code) {
    countryCode.value = code;
  }

  /// إرسال رمز التحقق
  Future<void> sendOtp() async {
    final fullPhone = '+${countryCode.value}${phoneNumber.value}';

    isLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          // اختياري: تسجيل مباشر لو الكود اتلقط تلقائيًا
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          String message = e.message ?? "حدث خطأ في إرسال الرمز";

          if (e.code == 'invalid-phone-number') {
            message = 'رقم الهاتف غير صالح. يرجى التأكد من صحته.';
          }

          Get.snackbar("فشل التحقق", message);
          print('message');
          print(message);
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          isLoading.value = false;
          Get.to(
                () => OtpView(),
            arguments: {
              'verId': verId,
              'phone': phoneNumber,
            },
          );

        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("خطأ", "حدث خطأ غير متوقع أثناء إرسال الكود");
    }
  }
}
