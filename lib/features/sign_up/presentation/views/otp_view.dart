import 'package:darrbiny/features/sign_up/presentation/views/widgets/otp_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/components/widgets/auth_base_screen.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/styles.dart';
import '../../../../generated/assets.dart';
import '../controllers/otp_controller.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return AuthBaseScreen(
      headerImage: Image.asset(Assets.imagesCuateotp),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ادخال رمز التحقق لتفعيل الحساب!',
                style: AppStyles.headingStyle.copyWith(color: kGray600)),
            SizedBox(height: 8.h),
            Text(
              'تحقق من الرسائل الخاصة برقم هاتفك ${controller.formattedPhone ?? ""}',
              style: AppStyles.body16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 28.h),
              child: Column(
                children: [
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    alignment: WrapAlignment.center,
                    children: List.generate(6, (index) => SizedBox(
                      width: 45.w,
                      height: 55.h,
                      child: OtpBox(index: index),
                    )),
                  ),

                  SizedBox(height: 32.h),
                  Obx(() => CustomButton(
                    text: 'التالي',
                    isActive: controller.isOtpComplete,
                    isLoading: controller.isVerifying.value,
                    onPressed: () {
                      if (controller.isOtpComplete) {
                        controller.verifyOtpAndSendTokenToBackend();
                      } else {
                        controller.checkError();
                      }
                    },
                  )),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        final remaining = controller.secondsRemaining.value;
                        final min = (remaining ~/ 60).toString().padLeft(2, '0');
                        final sec = (remaining % 60).toString().padLeft(2, '0');
                        return Text.rich(
                          TextSpan(
                            text: 'إعادة الإرسال بعد ',
                            style: AppStyles.body16,
                            children: [
                              TextSpan(
                                text: '$min:$sec ثانية',
                                style: AppStyles.body16.copyWith(
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      Obx(() => TextButton(
                        onPressed: controller.secondsRemaining.value == 0
                            ? controller.resendCode
                            : null,
                        child: Text(
                          'إعادة إرسال',
                          style: AppStyles.body16.copyWith(
                            color: controller.secondsRemaining.value == 0
                                ? kSecondaryColor
                                : kGray300,
                          ),
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
