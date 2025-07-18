// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isActive;
  final bool isLoading; // ✅ الجديد
  final double height;
  final double borderRadius;
  final Color activeColor;
  final Color inactiveColor;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActive = true,
    this.isLoading = false, // ✅ القيمة الافتراضية
    this.height = 48,
    this.borderRadius = 12,
    this.activeColor = kSecondaryColor,
    this.inactiveColor = const Color(0xFFC7C7CC),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isActive && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? activeColor : inactiveColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          elevation: isActive ? 2 : 0,
        ),
        child: isLoading
            ? SizedBox(
          height: 24.h,
          width: 24.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
          ),
        )
            : Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: 16.sp,
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
