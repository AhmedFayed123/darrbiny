import 'package:darrbiny/features/profile/presentation/controllers/instructor_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../profile/presentation/controllers/learner_profile_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<LearnerProfileController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 4.w),
            Obx(() {
              final name =
                  profileController.learnerProfile.value?.name ?? '';
              return Text(
                  ' اهلا$name',
                style: AppStyles.labelStyle.copyWith(color: kSecondaryColor),
              );
            }),
          ],
        ),
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: kWhiteColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Badge(
            alignment: Alignment.topRight,
            offset: const Offset(1, -1),
            smallSize: 6,
            backgroundColor: Colors.red,
            child: SvgPicture.asset(
              Assets.svgVector,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

class InstructorHomeAppBar extends StatelessWidget{
  const InstructorHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<InstructorProfileController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 4.w),
            Obx(() {
              final name =
                  profileController.instructorProfile.value?.name ?? '';
              return Text(
                ' اهلا$name',
                style: AppStyles.labelStyle.copyWith(color: kSecondaryColor),
              );
            }),
          ],
        ),
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: kWhiteColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Badge(
            alignment: Alignment.topRight,
            offset: const Offset(1, -1),
            smallSize: 6,
            backgroundColor: Colors.red,
            child: SvgPicture.asset(
              Assets.svgVector,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }


}