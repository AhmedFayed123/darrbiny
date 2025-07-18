import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/colors.dart';
import '../../constant/icons.dart';
import '../../constant/styles.dart';

class CustomSeeAllRow extends StatelessWidget {
  const CustomSeeAllRow({super.key, required this.title, required this.onPressed, required this.isSeeAll, required this.allTitle});

  final String title;
  final String allTitle;
  final VoidCallback onPressed;
  final bool isSeeAll;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyles.labelStyle.copyWith(color: kBlackColor),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Row(
              children: [
                Text(
                  isSeeAll?allTitle:'',
                  style: AppStyles.labelStyle.copyWith(color: kSecondaryColor),
                ),
                Icon(
                  isSeeAll?AppIcons.arrow_forward:null,
                  color: kPrimaryTextColor,
                  size: 12,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
