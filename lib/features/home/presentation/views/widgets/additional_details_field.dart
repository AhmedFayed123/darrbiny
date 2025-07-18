// widgets/additional_details_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';

class AdditionalDetailsController extends GetxController {
  final TextEditingController notesController = TextEditingController();

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}

class AdditionalDetailsField extends StatelessWidget {
  const AdditionalDetailsField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdditionalDetailsController());

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
          Image.asset(Assets.imagesBin),
          SizedBox(height: 12.h),
          Text(
            'اكتب تفاصيل اضافيه',
            style: AppStyles.labelStyle18.copyWith(
              color: kOxfordBlue,
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: controller.notesController,
            maxLines: 4,
            style: AppStyles.textStyle14regular.copyWith(color: kOxfordBlue),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              labelText: 'اكتب هنا',
              alignLabelWithHint: true,
              labelStyle: AppStyles.textStyle14regular.copyWith(color: kGray400),
              hintText: 'اكتب هنا أي تفاصيل إضافية...',
              hintStyle: AppStyles.textStyle14regular.copyWith(color: kGray300),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: kPrimaryColor, width: 1.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
