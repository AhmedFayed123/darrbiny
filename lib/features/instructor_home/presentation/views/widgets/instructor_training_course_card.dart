import 'package:darrbiny/core/components/widgets/custom_button.dart';
import 'package:darrbiny/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorTrainingCourseCard extends StatelessWidget {
  final String trainerName;
  final String trainerImageUrl;
  final double rating;
  final String fromDate;
  final String location;
  final String trainerCar;
  final String transportRequest;
  final int price;
  final String duration;
  final VoidCallback onPressed;
  final VoidCallback onTap;
  final bool isNew;
  const InstructorTrainingCourseCard({
    super.key,
    required this.trainerName,
    required this.trainerImageUrl,
    required this.rating,
    required this.fromDate,
    required this.location,
    required this.trainerCar,
    required this.transportRequest,
    required this.price,
    required this.duration, required this.onPressed, required this.onTap, required this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(.15),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "كورس تدريب",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1B2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Trainer Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(trainerImageUrl),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140.w,
                        child: Text(
                          trainerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            index < rating
                                ? Icons.star
                                : Icons.star_border_outlined,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isNew)
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF8B6EF6)),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'تواصل مع المتدربة',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        const Icon(Icons.location_on_outlined, color: kSecondaryColor),
                      ],
                    ),
                  ),
                )
              else
                const SizedBox(), // أو تجاهل else حسب الحالة
            ],
          ),

          SizedBox(height: 16.h),

          // Training Details
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: kSecondaryColor),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                _buildRow('التاريخ (من)', fromDate),
                // _buildRow('التاريخ (إلى)', toDate),
                _buildRow('مكان التدريب', location),
                _buildRow('سيارة المدربة', trainerCar),
                _buildRow('طلب نقل المتدرب', transportRequest),
                _buildRow('السعر', '$price ﷼', isPrice: true),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          CustomButton(text: 'اقبل الطلب', onPressed: onPressed)
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
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
                fontSize: isPrice ? 16 : 14,
                color: isPrice ? const Color(0xFF8B6EF6) : Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
