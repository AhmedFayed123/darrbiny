import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../views/otp_view.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var countryCode = '966'.obs;
  var verificationId = ''.obs;
  var password = ''.obs;

  void updateFullName(String name) {
    fullName.value = name.trim();
  }

  void updatePhoneNumber(String number) {
    phoneNumber.value = number.trim().replaceAll(' ', '').replaceAll('-', '');
  }

  void updateCountryCode(String code) {
    countryCode.value = code;
  }

  void updatePassword(String pass) {
    password.value = pass.trim();
  }

  Future<void> sendOtp() async {
    final fullPhone = '+${countryCode.value}${phoneNumber.value}';

    isLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          String message = e.message ?? "حدث خطأ في إرسال الرمز";

          if (e.code == 'invalid-phone-number') {
            message = 'رقم الهاتف غير صالح. يرجى التأكد من صحته.';
          }

          Get.snackbar("فشل التحقق", message);
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          isLoading.value = false;
          Get.to(() => OtpView(), arguments: {
            'verId': verId,
            'phone': phoneNumber.value,
          });
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
