// controllers/date_picker_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class DatePickerController extends GetxController {
  final selectedDate = ''.obs;

  void setDate(String date) {
    selectedDate.value = date;
  }
}

class DatePickerField extends StatelessWidget {
  const DatePickerField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DatePickerController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر تاريخ',
          style: AppStyles.textStyle14500.copyWith(color: kGray400),
        ),
        SizedBox(height: 8.h),
        Obx(
          () => InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                final formatted =
                    "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                controller.setDate(formatted);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedDate.value.isEmpty
                        ? 'اختر التاريخ'
                        : controller.selectedDate.value,
                    style: AppStyles.textStyle16regular.copyWith(color: kGray400)
                  ),
                  const Icon(Icons.calendar_month_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
