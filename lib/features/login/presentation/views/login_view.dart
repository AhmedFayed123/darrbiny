
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/auth_base_screen.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../../../core/components/widgets/custom_form_field.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/styles.dart';
import '../../../../generated/assets.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../sign_up/presentation/views/sign_up_view.dart';
import '../../../sign_up/presentation/views/upload_driving_photo.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    final formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController();

    return AuthBaseScreen(
      headerImage: Image.asset(Assets.imagesCuate),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
          top: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('أهلاً بك', style: AppStyles.headingStyle.copyWith(color: kGray600)),
            Text('قم بتسجيل الدخول', style: AppStyles.body16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 28.h),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      labelText: 'رقم الهاتف',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      isCountryPicker: true,
                      initialCountryCode: 'SA',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال رقم الهاتف';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        loginController.updatePhoneNumber(value);
                      },
                      onCountryChanged: (country) {
                        loginController.updateCountryCode(country.phoneCode ?? '966');
                      },
                    ),
                    SizedBox(height: 32.h),
                    Obx(() => CustomButton(
                      text: 'التالي',
                      isLoading: loginController.isLoading.value,
                      onPressed: () {
                        Get.offAll(() => const UploadDrivingPhoto());

                        // if (formKey.currentState!.validate()) {
                        //   loginController.loginWithPhone();
                        // }
                      },
                    )),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: 'إنشاء حساب',
                      activeColor: kPrimaryColor,
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      onPressed: () {
                        Get.offAll(const SignUpView());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
