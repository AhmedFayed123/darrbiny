// fancy_bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../generated/assets.dart';
import '../../controller/navigation_controller.dart';

class FancyBottomNavBar extends StatelessWidget {
  const FancyBottomNavBar({super.key});

  static const _bgColor  = Color(0xFFF0EDFF);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: _bgColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -4),
              blurRadius: 25,
              color: kBlackColor.withOpacity(.08),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _NavItem(index: 0, label: 'الرئيسية',  svgAsset: Assets.svgHome),
            _NavItem(index: 2, label: 'الرسائل',   svgAsset: Assets.svgCaht),
            _NavItem(index: 1, label: 'التدريبات', svgAsset: Assets.svgCalendar),
            _NavItem(index: 3, label: 'حسابي',     svgAsset: Assets.svgIcon),

          ],
        ),
      ),
    );
  }
}

/// عنصر واحد داخل شريط التنقّل
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.label,
    required this.svgAsset, // ← بدّل icon بـ svgAsset
  });

  final int index;
  final String label;
  final String svgAsset; // مثال: 'assets/icons/home.svg'

  @override
  Widget build(BuildContext context) {
    final NavigationController c = Get.find();

    return Expanded(
      child: InkWell(
        onTap: () => c.changeIndex(index),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Obx(
              () {
            final bool isSelected = c.currentIndex.value == index;
            final Color currentColor =
            isSelected ? kSecondaryColor : kLightGrey;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SVG بدل Icon
                SvgPicture.asset(
                  svgAsset,
                  width: 26.6.w,
                  height: 26.6.w,
                  colorFilter: ColorFilter.mode(currentColor, BlendMode.srcIn),
                ),
                SizedBox(height: 4.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: currentColor,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}