
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/components/widgets/custom_button.dart';
import '../../core/constant/colors.dart';
import '../home/presentation/views/home_view.dart';
import '../sign_up/presentation/views/sign_up_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'مدرب',
                onPressed: () {
                  Get.offAll(SignUpView());
                },
              ),
              SizedBox(height: 16.h),
              CustomButton(
                text: 'متدرب',
                onPressed: () {
                  Get.offAll(HomeView());
                },
                activeColor: kPrimaryColor,
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
