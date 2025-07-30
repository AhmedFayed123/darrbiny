import 'package:darrbiny/core/components/widgets/custom_button.dart';
import 'package:darrbiny/core/constant/colors.dart';
import 'package:darrbiny/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../../generated/assets.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(title: 'المكافائات'),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kWhiteColor, kSecondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Image.asset(Assets.imagesImage30),
                    Text(
                      ' عند اشتراك كل متدربه جديده بالكود الخاص بكي تحصلي على نقطة تضاف الى رصيدك ويمكنك استبدالها بالمكافآت التاليه',
                      textAlign: TextAlign.center,
                      style: AppStyles.body20Regular400,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [Text('نسخ'), Icon(Icons.copy_rounded)],
                          ),
                          Text('darbny.appstore'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 45.h),
              AnimatedRadialGauge(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                radius: 80.r,
                value: 9,
                axis: GaugeAxis(
                  min: 0,
                  max: 10,
                  degrees: 360,
                  style: GaugeAxisStyle(
                    thickness: 20,
                    background: kWhiteColor,
                    segmentSpacing: 2,
                  ),
                  progressBar: GaugeProgressBar.rounded(color: kSecondaryColor),
                  pointer: null,
                ),
                builder:
                    (context, child, value) => Center(
                      child: Text(
                        '${value.toInt()} نقطة',
                        style: AppStyles.body20Regular400.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Text('1')),
                        ),
                        SizedBox(width: 8.w),
                        Text('ساعة ابل'),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: kLemonChiffon,
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      child: Row(
                        children: [
                          Text('05  نقطة'),
                          Icon(Icons.star_outline, color: Colors.amber),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'كم عدد النقاط التي تريد استبدالها ؟',
                      style: AppStyles.body13Regular400,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: TextField(
                        style: AppStyles.body13Regular400,
                        decoration: InputDecoration(
                          hintText: 'اكتب عدد النقاط هنا',
                          hintStyle: AppStyles.body13Regular400,
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Center(
                      child: SizedBox(
                        width: Get.width * 0.3,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: kSecondaryColor,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Text(
                            'تنفيذ',
                            style: AppStyles.body13Regular400.copyWith(
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_forward, color: kSecondaryColor),
                        SizedBox(width: 8.w),
                        Text(
                          'شروط وتعليمات الاستبدال',
                          style: AppStyles.body20Regular.copyWith(
                            color: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w),

                    Text(
                      'هذا نص يدل علي قيمة السياسة هذا نص يدل علي قيمة السياسةهذا نص يدل علي قيمة السياسةهذا نص يدل علي قيمة السياسةهذا نص يدل علي قيمة السياسةهذا نص يدل علي قيمة السياسة',
                      style: AppStyles.textStyle12regular400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
