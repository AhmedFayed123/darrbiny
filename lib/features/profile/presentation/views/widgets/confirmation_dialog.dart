import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key, required this.onConfirm, required this.onCancel, required this.image, required this.title, required this.desc});

  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String image;
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: 100.h,
              width: 100.h,
            ),
            SizedBox(height: 24.h),

            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),

            Text(
              desc,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),

            CustomButton(
              text: 'نعم',
              onPressed: onConfirm,
              activeColor: Colors.red,
              textStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              height: 50.h,
            ),
            SizedBox(height: 12.h),

            CustomButton(
              text: 'لا',
              onPressed: onCancel,
              activeColor: const Color(0xFFF2F2F2),
              textStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              height: 50.h,
            ),
          ],
        ),
      ),
    );  }
}
