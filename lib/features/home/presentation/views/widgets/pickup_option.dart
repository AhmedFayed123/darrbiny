
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';

class PickupController extends GetxController {
  final selectedOption = 'نعم'.obs;

  void selectOption(String option) {
    selectedOption.value = option;
  }

  bool get requiresTransport => selectedOption.value == 'نعم';
}

class PickupOption extends StatelessWidget {
  const PickupOption({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PickupController());

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
          Image.asset(Assets.imagesRoute),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'هل ترغب أن تقوم المدربة بأخذك وارجاعك لموقعك؟',
                  style: AppStyles.textStyle14regular.copyWith(
                    color: kOxfordBlue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(
                () => Row(
              children: [
                Expanded(
                  child: _SelectableOption(
                    title: 'نعم',
                    selected: controller.selectedOption.value == 'نعم',
                    onTap: () => controller.selectOption('نعم'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _SelectableOption(
                    title: 'لا',
                    selected: controller.selectedOption.value == 'لا',
                    onTap: () => controller.selectOption('لا'),
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
  final bool selected;
  final VoidCallback onTap;

  const _SelectableOption({
    required this.title,
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
        child: Center(
          child: Text(
            title,
            style: AppStyles.body20.copyWith(
              color: selected ? kSecondaryColor : kGraniteGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
