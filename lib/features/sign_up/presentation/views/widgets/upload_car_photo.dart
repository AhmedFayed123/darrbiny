import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/components/widgets/auth_base_screen.dart';
import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../instructor_home/presentation/views/instructor_home_view.dart';
import '../../controllers/upload_photos_controller.dart';

class UploadCarPhoto extends StatelessWidget {
  const UploadCarPhoto({super.key});

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadPhotosController());

    return AuthBaseScreen(
      headerImage: Image.asset(
        Assets.imagesCar,
        height: 128.h,
        width: 128.w,
        fit: BoxFit.scaleDown,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Text('رفع صورة السيارة', style: AppStyles.body16),
          SizedBox(height: 24.h),
          InkWell(
            onTap: () => controller.pickCarImage(),
            child: Obx(() {
              return DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: [8, 4],
                strokeWidth: 2,
                color: kSecondaryColor,
                child: Container(
                  height: 145.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: controller.selectedCarImage.value == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.imagesUploadMedia),
                      Text(
                        'رفع صورة السيارة',
                        style: AppStyles.body16.copyWith(
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  )
                      : Image.file(
                    controller.selectedCarImage.value!,
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
                    onPressed: () async {


                      final result = await controller.uploadPhotos();

                      result.fold(
                            (failure) => Get.snackbar('فشل', failure.message),
                            (data) {
                          log("✅ Uploaded URLs: $data");
                          Get.snackbar('تم بنجاح', data['message']);
                          Get.offAll(InstructorHomeView());
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomButton(
                    text: 'ليس الآن',
                    activeColor: kPrimaryColor,
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    onPressed: () {
                      Get.offAll(InstructorHomeView());
                    },
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
