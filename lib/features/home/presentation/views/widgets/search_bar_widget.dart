import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'البحث عن مدرِّبة أو مدينة',
            hintStyle: AppStyles.textStyle12regular,

            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
              child: SvgPicture.asset(
                Assets.svgSearch,
                width: 14.w,
                height: 14.h,
                fit: BoxFit.contain,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 14.w,
              minHeight: 14.h,
            ),

            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ),
    );
  }
}
