
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/auth_base_screen.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../../../core/components/widgets/custom_form_field.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/styles.dart';
import '../../../../generated/assets.dart';
import '../../../login/presentation/views/login_view.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key, required this.flag});

  final String flag;
  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SignUpController());
    signupController.accountType = flag;

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return AuthBaseScreen(
      headerImage: Image.asset(Assets.imagesLogo),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('أهلاً بك', style: AppStyles.headingStyle.copyWith(color: kGray600)),
          Text('قم بإدخال بياناتك لإنشاء الحساب', style: AppStyles.body16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 28.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomFormField(
                    labelText: 'الاسم بالكامل',
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(Icons.perm_identity),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الاسم الكامل';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
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
                      signupController.updatePhoneNumber(value);
                    },
                    onCountryChanged: (country) {
                      signupController.updateCountryCode(country.phoneCode);
                    },
                  ),SizedBox(height: 16.h),
                  CustomFormField(
                    labelText: 'كلمة المرور',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      }
                      if (value.length < 8) {
                        return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomFormField(
                    labelText: 'تأكيد كلمة المرور',
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء تأكيد كلمة المرور';
                      }
                      if (value != passwordController.text) {
                        return 'كلمتا المرور غير متطابقتين';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 32.h),
                  Obx(() => CustomButton(
                    text: 'التالي',
                    isLoading: signupController.isLoading.value,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        signupController.updateFullName(nameController.text);
                        signupController.updatePassword(passwordController.text);
                        signupController.sendOtp();
                      }
                    },
                  )),
                  SizedBox(height: 16.h),
                  CustomButton(
                    text: 'تسجيل دخول',
                    activeColor: kPrimaryColor,
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    onPressed: () {
                      Get.offAll(() => LoginView(flag: flag,));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
