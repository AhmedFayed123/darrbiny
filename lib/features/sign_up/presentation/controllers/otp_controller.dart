import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_button.dart';
import '../../../../generated/assets.dart';
import '../../../login/presentation/views/login_view.dart';

class OtpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var otpDigits = List<String>.filled(5, "").obs;
  var isError = false.obs;
  var showError = false.obs;
  var isVerifying = false.obs;

  var secondsRemaining = 90.obs;
  Timer? _timer;

  late String verificationId;
  String? formattedPhone; // ← للعرض فقط

  String get otpCode => otpDigits.join();
  bool get isOtpComplete => !otpDigits.any((d) => d.isEmpty);

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is Map) {
      verificationId = args['verId'];
      formattedPhone = args['phone'];
    } else {
      Get.snackbar("خطأ", "لم يتم توفير بيانات التحقق");
    }

    startTimer();
  }


  void updateDigit(int index, String value) {
    otpDigits[index] = value;
    if (showError.value) checkError();
  }

  void checkError() {
    showError.value = true;
    isError.value = otpDigits.any((d) => d.isEmpty);
  }

  void startTimer() {
    _timer?.cancel();
    secondsRemaining.value = 90;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void resendCode() {
    // مبدئيًا: هذا placeholder — لاحقًا اربطه بـ SignUpController
    Get.snackbar("تم الإرسال", "تم إرسال رمز جديد بنجاح");
    otpDigits.value = List<String>.filled(5, "");
    startTimer();
  }

  Future<void> verifyOtpAndSendTokenToBackend() async {
    isVerifying.value = true;

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final token = await userCredential.user?.getIdToken();

      if (token != null) {
        print("✅ User token: $token");

        // TODO: أرسل التوكن للباك إند هنا
        Get.defaultDialog(
          title: "تم التحقق",
          titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.imagesSuccess, 
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              const Text(
                "تم إنشاء حسابك بنجاح",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          confirm:CustomButton(text: 'Login', onPressed: ()=>Get.offAll(LoginView()))
        );
      } else {
        Get.snackbar("خطأ", "لم يتم استلام التوكن");
      }
    } catch (e) {
      Get.snackbar("فشل التحقق", "رمز التحقق غير صالح أو منتهي");
    } finally {
      isVerifying.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
