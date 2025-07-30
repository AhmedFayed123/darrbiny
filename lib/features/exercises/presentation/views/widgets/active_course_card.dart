import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/colors.dart';

class ActiveCourseCard extends StatelessWidget {
  const ActiveCourseCard({
    super.key,
    required this.duration,
    required this.learnerImageUrl,
    required this.learnerName,
    required this.rating,
    required this.date,
    required this.price,
    required this.time,
  });

  final String duration;
  final String learnerImageUrl;
  final String learnerName;
  final double rating;
  final String date;
  final double price;
  final String time;

  @override
  Widget build(BuildContext context) {
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
          )
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
                  "كورس تدريب",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: kSecondaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1B2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    duration,
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

          // بيانات المتدرب + زر التواصل
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
                        learnerName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
            ],
          ),

          SizedBox(height: 16.h),

          // تفاصيل الكورس
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: kSecondaryColor),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              children: [
                _buildRow('التاريخ', date),
                _buildRow('الوقت', time),
                _buildRow('السعر', '$price ﷼', isPrice: true),
              ],
            ),
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isPrice = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF999999),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isPrice ? FontWeight.w700 : FontWeight.w500,
              fontSize: isPrice ? 15.sp : 14.sp,
              color: isPrice ? kSecondaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
