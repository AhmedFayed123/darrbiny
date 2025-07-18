import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';

class CarTrainingController extends GetxController {
  final selectedOption = 'لدي سيارة'.obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }

  bool get hasLearnerCar => selectedOption.value == 'لدي سيارة';
}

class CarTrainingOption extends StatelessWidget {
  const CarTrainingOption({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarTrainingController());

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(Assets.imagesBabyCar),
          ),
          SizedBox(height: 8.h),
          Text(
            'هل لديك سيارة للتدريب عليها ام تدريب بسيارة المدربة ؟',
            style: AppStyles.labelStyle18.copyWith(color: kOxfordBlue),
          ),
          SizedBox(height: 16.h),
          Obx(
                () => Row(
              children: [
                Expanded(
                  child: _SelectableOption(
                    title: 'نعم',
                    subtitle: 'لدي سيارة',
                    selected: controller.selectedOption.value == 'لدي سيارة',
                    onTap: () => controller.selectOption('لدي سيارة'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _SelectableOption(
                    title: 'لا',
                    subtitle: 'التدريب بسيارة المدربة',
                    selected: controller.selectedOption.value == 'التدريب بسيارة المدربة',
                    onTap: () => controller.selectOption('التدريب بسيارة المدربة'),
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

class _SelectableOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableOption({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: selected ? kSecondaryColor : kGraniteGray,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppStyles.body20.copyWith(
                color: selected ? kSecondaryColor : kGraniteGray,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: AppStyles.textStyle14regular.copyWith(
                color: selected ? kSecondaryColor : kGraniteGray,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
