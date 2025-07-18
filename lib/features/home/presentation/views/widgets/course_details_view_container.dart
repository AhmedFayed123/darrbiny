import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../features/home/data/models/packages_list_model/Packages.dart';
import '../../../../../generated/assets.dart';

class CourseDetailsViewContainer extends StatelessWidget {
  final Packages package;

  const CourseDetailsViewContainer({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              Assets.imagesCoursedetails,
              width: double.infinity,
              height: 181.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                package.name ?? '',
                style: AppStyles.labelStyle.copyWith(color: kOxfordBlue),
              ),
              Text(
                'تبدأ من ${package.price ?? "0"}\$',
                style: AppStyles.labelStyle18,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            package.description ?? '',
            style: AppStyles.textStyle14500,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: kLemonChiffon,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '100\$ ريال/رسوم تأكيد',
                  style: AppStyles.textStyle14500.copyWith(color: kOxfordBlue),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: kMostlyWhite,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'مناسب للمبتدئات',
                  style: AppStyles.textStyle12regular.copyWith(
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildRightsSection(),
        ],
      ),
    );
  }

  Widget _buildRightsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: kMostlyWhite,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: kChiragMehta,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(Assets.svgTerm),
              ),
              SizedBox(width: 8.w),
              Text(
                'حقوق المتدربة',
                style: AppStyles.textStyle12regular.copyWith(
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint('إمكانية تغبير المدربة إذا لم تكن الخدمة مرضية.'),
              _buildBulletPoint('حرية قبول أو رفض العروض دون التزام.'),
              _buildBulletPoint('حماية كاملة لبياناتك الشخصية.'),
              _buildBulletPoint('جميع المدريات معتمدات ومونوفات.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 14, height: 1.4, color: Color(0xFF3D3750)),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4, color: Color(0xFF3D3750)),
            ),
          ),
        ],
      ),
    );
  }
}
