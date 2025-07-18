import 'package:flutter/material.dart';

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // مدة الكورس
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
            const SizedBox(height: 12),

            // كورس تدريب + بيانات المدربة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "كورس تدريب",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(trainerImageUrl),
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
              ],
            ),
            const SizedBox(height: 12),

            // الموقع
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Color(0xFF8B6EF6)),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF8B6EF6)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'موقع المتدربة',
                    style: TextStyle(
                      color: Color(0xFF8B6EF6),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // تفاصيل التدريب
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFEAE6F9)),
                borderRadius: BorderRadius.circular(16),
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

            const SizedBox(height: 16),

            // العرض + السعر
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'اكتب سعرك هنا',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE1D7FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    'قدم عرض',
                    style: TextStyle(
                      color: Color(0xFF6A4CD4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
            value,
            style: TextStyle(
              fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
              fontSize: isPrice ? 16 : 14,
              color: isPrice ? const Color(0xFF8B6EF6) : Colors.black,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
