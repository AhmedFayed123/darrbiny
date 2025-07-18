import 'dart:io';

import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/auth_base_screen.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/styles.dart';
import '../../../../generated/assets.dart';
import '../../../instructor_home/presentation/views/instructor_home_view.dart';
import '../controllers/upload_photos_controller.dart';

class UploadDrivingPhoto extends StatelessWidget {
  const UploadDrivingPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadPhotosController());

    return AuthBaseScreen(
      headerImage: Image.asset(
        Assets.imagesImage32,
        height: 128.h,
        width: 128.w,
        fit: BoxFit.scaleDown,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Text('رفع صورة القيادة', style: AppStyles.body16),
          SizedBox(height: 24.h),
          InkWell(
            onTap: () => controller.pickDrivingImage(),
            child: Obx(() {
              return DottedBorder(
                color: kSecondaryColor,
                strokeWidth: 2,
                dashPattern: [8, 4],
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                child: Container(
                  height: 145.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: controller.selectedDrivingImage.value == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.imagesUploadMedia),
                      Text(
                        'رفع صورة القيادة',
                        style: AppStyles.body16.copyWith(color: kSecondaryColor),
                      ),
                    ],
                  )
                      : Image.file(
                    controller.selectedDrivingImage.value!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 145.h,
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 28.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'التالي',
                    onPressed: () {
                      Get.offAll(InstructorHomeView());
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    text: 'ليس الان',
                    activeColor: kPrimaryColor,
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
