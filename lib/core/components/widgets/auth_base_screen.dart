// lib/core/components/widgets/auth_base_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/assets.dart';
import '../../constant/colors.dart';

class AuthBaseScreen extends StatelessWidget {
  final Widget child;
  final Widget? headerImage;
  final EdgeInsetsGeometry? bodyPadding;

  /// ارتفاع المنطقة البنفسجية كنسبة من الشاشة
  final double headerHeightFactor;

  final String darkCurveAsset;
  final String lightCurveAsset;

  const AuthBaseScreen({
    super.key,
    required this.child,
    this.headerImage,
    this.bodyPadding,
    this.headerHeightFactor = .42,
    this.darkCurveAsset = Assets.svgDarkCurveAsset,
    this.lightCurveAsset = Assets.svgLightCurveAsset,
  });

  @override
  Widget build(BuildContext context) {
    final headerH = headerHeightFactor.sh;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              lightCurveAsset,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              darkCurveAsset,
              fit: BoxFit.fitWidth,
            ),
          ),

          // 2️⃣ الدائرة التزيينية
          Positioned(
            top: headerH ,
            left: 15.w,
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kSecondaryColor,
              ),
            ),
          ),

          // 3️⃣ صورة الهيدر
          if (headerImage != null)
            Positioned(
              top: headerH * .15,
              left: 0,
              right: 0,
              child: SizedBox(
                height: headerH * .60,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: headerImage!,
                ),
              ),
            ),

          // 4️⃣ المحتوى
          Positioned.fill(
            child: Padding(
              padding: bodyPadding ??
                  EdgeInsets.only(
                    top: headerH + 24.h,
                    left: 24.w,
                    right: 24.w,
                  ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
