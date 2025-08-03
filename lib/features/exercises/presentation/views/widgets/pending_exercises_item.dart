import 'package:darrbiny/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../generated/assets.dart';

class PendingExercisesItem extends StatelessWidget {
  const PendingExercisesItem({super.key, this.durationDays, this.packName, this.durationHours, required this.learnerImageUrl, required this.instructorName, required this.rating, this.price, this.carModel, this.instructorMessage,});

  final String? durationDays;
  final String? packName;
  final String? durationHours;
  final String learnerImageUrl;
  final String instructorName;
  final String rating;
  final String? price;
  final String? carModel;
  final String? instructorMessage;


  @override
  Widget build(BuildContext context) {
    final double parsedRating = double.tryParse(rating) ?? 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان والمدة
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$packName",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: kSecondaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1B2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    "$durationDays ايام($durationHours ساعات)",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: AssetImage(learnerImageUrl),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        instructorName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      Row(
                        children: List.generate(5, (index) {
                          if (index < parsedRating.floor()) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.sp,
                            );
                          } else if (index < parsedRating &&
                              parsedRating - index >= 0.5) {
                            return Icon(
                              Icons.star_half,
                              color: Colors.amber,
                              size: 16.sp,
                            );
                          } else {
                            return Icon(
                              Icons.star_border,
                              color: Colors.amber,
                              size: 16.sp,
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: kSecondaryColor),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    'تواصل مع المدربة',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Assets.imagesBabyCar,width: 32.w,),
                Text("$carModel",style: AppStyles.textStyle14500,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "السعر",
                        style: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$price ﷼',
                        style: TextStyle(
                          fontWeight:  FontWeight.w700,
                          fontSize: 15.sp ,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Text("رسالة المدربة",style: AppStyles.textStyle12regular400,),

          Text("$instructorMessage",style: AppStyles.textStyle14500,),

          SizedBox(height: 12.h),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Center(
                child: Text(
                  'اختر هذا العرض',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
