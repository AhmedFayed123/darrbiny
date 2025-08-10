// controllers/date_picker_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class DatePickerController extends GetxController {
  final selectedDate = Rx<DateTime?>(null);
  final formattedDate = ''.obs;

  void setDate(DateTime date) {
    selectedDate.value = date;
    formattedDate.value =
    "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }
}

class DatePickerField extends StatelessWidget {
  const DatePickerField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DatePickerController>();

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
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                controller.setDate(picked);
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
                    controller.selectedDate.value == null
                        ? 'اختر التاريخ'
                        : DateFormat('dd/MM/yyyy').format(controller.selectedDate.value!),
                    style: AppStyles.textStyle16regular.copyWith(color: kGray400),
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