
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(onTap: ()=>Get.back(),child: Icon(Icons.arrow_back,size: 34,)),
        Text(title,style: AppStyles.labelStyle.copyWith(color: kSecondaryColor),),
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: kWhiteColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Badge(
            alignment: Alignment.topRight,
            offset: const Offset(1, -1),
            smallSize: 6,
            backgroundColor: Colors.red,
            child: SvgPicture.asset(
              Assets.svgVector,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.contain,
            ),
          ),
        )
      ],
    );
  }
}
