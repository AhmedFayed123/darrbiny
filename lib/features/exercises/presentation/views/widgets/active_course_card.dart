import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/colors.dart';

class ActiveCourseCard extends StatelessWidget {
  const ActiveCourseCard({
    super.key,
    required this.durationDays,
    required this.learnerImageUrl,
    required this.instructorName,
    required this.rating,
    required this.date,
    required this.price,
    required this.time,
    required this.durationHours,
    required this.packName, required this.onTap,
  });

  final String? durationDays;
  final String? packName;
  final String? durationHours;
  final String learnerImageUrl;
  final String instructorName;
  final String rating;
  final String date;
  final String? price;
  final String time;
  final VoidCallback onTap;

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
                _buildRow('النوع', time),
                _buildRow('السعر', '$price ﷼', isPrice: true),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onTap,
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
                        'عرض التفاصيل',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w,),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: kNegativeTrendColor),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Center(
                      child: Text(
                        'الغاء الحجز',
                        style: TextStyle(
                          color: kNegativeTrendColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
