
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class VisaCardItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String logoUrl;

  const VisaCardItem({
    super.key,
    required this.title,
    required this.logoUrl,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Logo SVG
            SvgPicture.network(
              logoUrl,
              height: 32,
              width: 48,
              placeholderBuilder: (context) => const SizedBox(
                height: 32,
                width: 48,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
            SizedBox(width: 8.w,),
            // Text
            Expanded(
              child: Text(
                title,
                style: AppStyles.body16.copyWith(color: Color(0xFF151522)),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
