
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class TimelineSteps extends StatelessWidget {
  const TimelineSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStep(
          title: 'تحصلي',
          description: [
            'كل المدربات سعوديات معتمدات وخبرات متنوعة',
            'نضمن لك تجربة آمنة وسلسة',
            'إذا ما استفدتِ من الجلسة، تواصلي مع الدعم أو مساعدتك يفضل يرجع فلوسك في أمان',
          ],
          isFirst: true,
        ),
        _buildStep(
          title: 'اختاري',
          description: [
            'اختاري الخدمة اللي تناسبك',
            'حددي الوقت والمدربة المناسبين لك',
          ],
        ),
        _buildStep(
          title: 'ابدئي',
          description: [
            'ادفعي رسوم تأكيد الحجز',
            'استمتعي بجلسة من أفضل المدربات',
            'لتغيير الأنسب',
          ],
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildStep({
    required String title,
    required List<String> description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kSecondaryColor,
              ),
              child: const Icon(Icons.check, size: 16, color: Colors.white),
            ),

            // الخط الفاصل
            if (!isLast)
              Container(
                width: 2.w,
                height: 60.h,
                color: kSecondaryColor,
              ),
          ],
        ),

        SizedBox(width: 12.w),

        // النصوص
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.labelStyle.copyWith(color: kSecondaryColor),
              ),
              SizedBox(height: 4.h),
              ...description.map(
                    (text) => Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(color: Colors.black),
                      ),
                      Expanded(
                        child: Text(
                          text,
                          style: AppStyles.textStyle12regular.copyWith(color: kGray400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ],
    );
  }
}
