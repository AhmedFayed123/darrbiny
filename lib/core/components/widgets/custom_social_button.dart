import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/sizes.dart';
import '../../constant/styles.dart';
import '../../settings/theme.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.buttonColor = Colors.white,
    this.textColor = Colors.black,
    this.borderColor = Colors.grey,
    this.borderRadius = 50.0,
  });

  final String title;
  final VoidCallback onPressed;
  final String icon;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.2.w,
          ),
          borderRadius:
          BorderRadius.circular(kBorderRadius),
          color: buttonColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 25.w,
                height: 25.h,
              ),
              Text(
                title,
                style: AppStyles.textStyle14w500.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
