// fancy_bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../generated/assets.dart';
import '../../controller/navigation_controller.dart';

class FancyBottomNavBar extends StatelessWidget {
  final GetxController controller;

  const FancyBottomNavBar({super.key, required this.controller});

  static const _bgColor = Color(0xFFF0EDFF);

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
          children: [
            _NavItem(index: 0, label: 'الرئيسية', svgAsset: Assets.svgHome, controller: controller),
            _NavItem(index: 2, label: 'الرسائل', svgAsset: Assets.svgCaht, controller: controller),
            _NavItem(index: 1, label: 'التدريبات', svgAsset: Assets.svgCalendar, controller: controller),
            _NavItem(index: 3, label: 'حسابي', svgAsset: Assets.svgIcon, controller: controller),
          ],
        ),
      ),
    );
  }
}
class _NavItem extends StatelessWidget {
  final int index;
  final String label;
  final String svgAsset;
  final GetxController controller;

  const _NavItem({
    required this.index,
    required this.label,
    required this.svgAsset,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final RxInt currentIndex = (controller as dynamic).currentIndex;

    return Expanded(
      child: InkWell(
        onTap: () => (controller as dynamic).changeIndex(index),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Obx(() {
          final bool isSelected = currentIndex.value == index;
          final Color currentColor = isSelected ? kSecondaryColor : kLightGrey;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        }),
      ),
    );
  }
}
