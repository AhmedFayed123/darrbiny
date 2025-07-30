import 'dart:async';
import 'package:darrbiny/features/sign_up/presentation/controllers/sign_up_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../generated/assets.dart';
import '../../../login/presentation/views/login_view.dart';
import '../../data/models/sign_up_request_model/Instructor_sign_up_request_model.dart';
import '../../data/repos/sign_up_repo.dart';

class OtpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String accountType;

  var otpDigits = List<String>.filled(6, "").obs;
  var isError = false.obs;
  var showError = false.obs;
  var isVerifying = false.obs;
  var secondsRemaining = 90.obs;
  Timer? _timer;

  late String verificationId;
  String? formattedPhone;
  String? phoneNumberForResend;

  String get otpCode => otpDigits.join();

  bool get isOtpComplete => !otpDigits.any((d) => d.isEmpty);

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is Map) {
      verificationId = args['verId'];
      formattedPhone = args['phone'];
      phoneNumberForResend = formattedPhone;
      accountType = args['accountType'] ?? 'learner';

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

  void resendCode() async {
    if (phoneNumberForResend == null) {
      Get.snackbar("خطأ", "رقم الهاتف غير متوفر لإعادة الإرسال");
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumberForResend!,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) {
          // يمكن استخدامه لاحقًا لتسجيل الدخول التلقائي
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("فشل", "فشل في إرسال الرمز: ${e.message}");
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
          otpDigits.value = List<String>.filled(6, "");
          startTimer();
          Get.snackbar("تم الإرسال", "تم إرسال رمز جديد بنجاح");
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء إعادة الإرسال");
    }
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

      print(token);
      print('tllllllll');
      if (token != null) {
        final signUpController = Get.find<SignUpController>();
        final signUpRepo = sl<SignUpRepo>();

        final requestModel = InstructorSignUpRequestModel(
          idToken: token,
          name: signUpController.fullName.value,
          phone: signUpController.phoneNumber.value,
          password: signUpController.password.value,
          passwordConfirmation: signUpController.password.value,
        );

        final result = await signUpRepo.signUp(requestModel, accountType);

        result.fold(
          (failure) {
            Get.snackbar("خطأ", "فشل تسجيل الحساب: ${failure.message}");
          },
          (data) {
            Get.defaultDialog(
              title: "تم التحقق",
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.imagesSuccess, width: 100, height: 100),
                  const SizedBox(height: 16),
                  const Text(
                    "تم إنشاء حسابك بنجاح",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              confirm: CustomButton(
                text: 'تسجيل الدخول',
                onPressed: () => Get.offAll(LoginView(flag: accountType)),
              ),
            );
          },
        );
      } else {
        Get.snackbar("خطأ", "لم يتم استلام التوكن");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'session-expired') {
        Get.snackbar(
          "انتهت الجلسة",
          "رمز التحقق منتهي. أعد الإرسال وحاول مرة أخرى",
        );
      } else if (e.code == 'invalid-verification-code') {
        Get.snackbar("رمز خاطئ", "رمز التحقق الذي أدخلته غير صحيح");
      } else {
        Get.snackbar("خطأ", "حدث خطأ: ${e.message}");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ غير متوقع: ${e.toString()}");
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
