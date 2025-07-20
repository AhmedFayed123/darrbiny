import 'package:darrbiny/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorTrainingCourseCard extends StatelessWidget {
  final String trainerName;
  final String trainerImageUrl;
  final double rating;
  final String fromDate;
  final String toDate;
  final String location;
  final String trainerCar;
  final String transportRequest;
  final int price;
  final String duration;

  const InstructorTrainingCourseCard({
    super.key,
    required this.trainerName,
    required this.trainerImageUrl,
    required this.rating,
    required this.fromDate,
    required this.toDate,
    required this.location,
    required this.trainerCar,
    required this.transportRequest,
    required this.price,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),

            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(.15),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r)),
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
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(trainerImageUrl),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trainerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF8B6EF6)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Text(
                      'موقع المتدربة',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 6.w,),
                    const Icon(Icons.location_on_outlined, color: kSecondaryColor),

                  ],
                ),
              ),

            ],
          ),

          SizedBox(height: 16.h),


          // تفاصيل التدريب
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: kSecondaryColor),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                _buildRow('التاريخ ( من )', fromDate),
                _buildRow('التاريخ ( الى )', toDate),
                _buildRow('مكان التدريب', location),
                _buildRow('سيارة المدربة', trainerCar),
                _buildRow('طلب نقل المتدرب', transportRequest),
                _buildRow('السعر', '$price ﷼', isPrice: true),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // العرض + السعر
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: kSecondaryColor,
                width: 1.2,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'اكتب سعرك هنا',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(.15),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 8.h),
                      foregroundColor: kSecondaryColor,
                      minimumSize: const Size(0, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'قدم عرض',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
              fontSize: isPrice ? 16 : 14,
              color: isPrice ? const Color(0xFF8B6EF6) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
