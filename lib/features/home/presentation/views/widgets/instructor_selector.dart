
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';

class InstructorController extends GetxController {
  final mode = 'جميع المدربات'.obs;
  final selectedInstructor = RxString('');

  final instructors = [
    {
      'id': 1,
      'name': 'هبة احمد',
      'details': 'درب أكثر من + 23',
    },
    {
      'id': 2,
      'name': 'ليلى الحسيني',
      'details': 'درب أكثر من + 23',
    },
    {
      'id': 3,
      'name': 'هالة محمد',
      'details': 'درب أكثر من + 23',
    },
    {
      'id': 4,
      'name': 'يوست عبدالله',
      'details': 'درب أكثر من + 23',
    },
    {
      'id': 5,
      'name': 'سارة العتيبي',
      'details': 'درب أكثر من + 23',
    },
  ];

  /// ✅ تستخدم عند إرسال البيانات للـ API
  int? get selectedInstructorId {
    if (mode.value == 'جميع المدربات') return null;
    final instructor = instructors.firstWhereOrNull(
          (inst) => inst['name'] == selectedInstructor.value,
    );
    return instructor?['id'] as int?;
  }
}

class InstructorSelector extends StatelessWidget {
  const InstructorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InstructorController());

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
          Image.asset(Assets.imagesAvatargroup),
          SizedBox(height: 12.h),
          Text(
            'لمن تريد ان ترسل طلبك ؟',
            style: AppStyles.labelStyle18.copyWith(
              color: kOxfordBlue,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() => Row(
            children: [
              Expanded(
                child: _SelectableOption(
                  title: 'جميع المدربات',
                  selected: controller.mode.value == 'جميع المدربات',
                  onTap: () {
                    controller.mode.value = 'جميع المدربات';
                    controller.selectedInstructor.value = '';
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _SelectableOption(
                  title: 'اختيار مدربة',
                  selected: controller.mode.value == 'اختيار مدربة',
                  onTap: () {
                    controller.mode.value = 'اختيار مدربة';
                    _showInstructorsBottomSheet(context, controller);
                  },
                  showArrow: true,
                ),
              ),
            ],
          )),
          Obx(() {
            if (controller.mode.value == 'اختيار مدربة' &&
                controller.selectedInstructor.value.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  'المدربة المختارة: ${controller.selectedInstructor.value}',
                  style: AppStyles.body16.copyWith(color: kOxfordBlue),
                ),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  void _showInstructorsBottomSheet(BuildContext context, InstructorController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            top: 16.r,
            left: 16.r,
            right: 16.r,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.r,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'اختر مدربة',
                style: AppStyles.labelStyle18.copyWith(color: kOxfordBlue),
              ),
              SizedBox(height: 16.h),
              ...controller.instructors.map((instructor) {
                final name = instructor['name'] as String;
                final details = instructor['details'] as String;

                final isSelected = controller.selectedInstructor.value == name;
                return _InstructorTile(
                  name: name,
                  details: details,
                  isSelected: isSelected,
                  onTap: () {
                    controller.selectedInstructor.value = name;
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}

class _InstructorTile extends StatelessWidget {
  final String name;
  final String details;
  final bool isSelected;
  final VoidCallback onTap;

  const _InstructorTile({
    required this.name,
    required this.details,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: isSelected ? kSecondaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? kSecondaryColor : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: kSecondaryColor.withOpacity(0.2),
              child: Icon(Icons.person, size: 24.r, color: kSecondaryColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppStyles.body16.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kOxfordBlue,
                    ),
                  ),
                  Text(
                    details,
                    style: AppStyles.body16.copyWith(color: kGraniteGray),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: kSecondaryColor, size: 24.r),
          ],
        ),
      ),
    );
  }
}

class _SelectableOption extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final bool showArrow;

  const _SelectableOption({
    required this.title,
    required this.selected,
    required this.onTap,
    this.showArrow = false,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppStyles.body20.copyWith(
                color: selected ? kSecondaryColor : kGraniteGray,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            if (showArrow) ...[
              SizedBox(width: 6.w),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: selected ? kSecondaryColor : kGraniteGray,
                size: 20.r,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
