
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../data/models/instructors_list_model/Instructors_list_model.dart';

class TrainerItem extends StatelessWidget {
  final InstructorModel instructor;

  const TrainerItem({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  Assets.imagesImage,
                  width: double.infinity,
                  height: 110.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  instructor.name ?? '',
                  style: AppStyles.textStyle16regular.copyWith(color: kBlackColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                instructor.rate ?? '0.0',
                style: AppStyles.textStyle16regular.copyWith(color: kBlackColor),
              ),
              SizedBox(width: 2.w),
              Icon(Icons.star, size: 18.sp, color: const Color(0xFFFFD336)),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              SvgPicture.asset(Assets.svgLocation, color: kLightGrey),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  "غير محدد", // لو جالك city من الـ API حطه هنا
                  style: AppStyles.textStyle14regular,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SizedBox(
                width: 56.w,
                height: 24.h,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(right: 28.w, child: _buildAvatar(Assets.imagesEllipse21)),
                    Positioned(right: 14.w, child: _buildAvatar(Assets.imagesEllipse23)),
                    Positioned(right: 0, child: _buildAvatar(Assets.imagesEllipse25)),
                  ],
                ),
              ),
              Text('24 متدرب', style: AppStyles.textStyle14regular),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String asset) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: ClipOval(child: Image.asset(asset, fit: BoxFit.cover)),
    );
  }
}
