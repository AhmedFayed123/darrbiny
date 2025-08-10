import 'package:darrbiny/core/components/widgets/custom_app_bar.dart';
import 'package:darrbiny/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../data/models/sessions_per_request_model/Data.dart';
import '../../controllers/learner_exercises_controller.dart';

class AcceptExerciseDetails extends StatelessWidget {
  const AcceptExerciseDetails({
    super.key,
    required this.requestId,
    required this.rating,
    required this.date,
    this.price,
    this.durationDays,
    this.packName,
    this.durationHours,
    required this.learnerImageUrl,
    required this.instructorName,
    required this.time,
    required this.onTap,
  });

  final int requestId;
  final String rating;
  final String date;
  final String? price;
  final String? durationDays;
  final String? packName;
  final String? durationHours;
  final String learnerImageUrl;
  final String time;
  final String instructorName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnerExercisesController());
    final double parsedRating = double.tryParse(rating) ?? 0.0;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 8.h),
          child: Column(
            children: [
              CustomAppBar(title: 'التفاصيل'),
              SizedBox(height: 16.h),
              Container(
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
                    _buildHeader(),
                    SizedBox(height: 16.h),
                    _buildInstructorInfo(parsedRating),
                    SizedBox(height: 16.h),
                    _buildCourseDetails(),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Obx(() {
                final sessions = controller.sessionsPerRequestModel.value?.data;
                if (sessions == null) {
                  controller.getSessionsPerRequest(requestId: requestId);
                  return const Center(child: CircularProgressIndicator());
                }

                if (sessions.isEmpty) {
                  return const Text("لا توجد جلسات بعد.");
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sessions.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    return _buildSessionCard(session, controller);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1B2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              "$durationDays أيام ($durationHours ساعات)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorInfo(double rating) {
    return Row(
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
                    if (index < rating.floor()) {
                      return Icon(Icons.star, color: Colors.amber, size: 16.sp);
                    } else if (index < rating && rating - index >= 0.5) {
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
          onTap: onTap,
          child: Container(
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
        ),
      ],
    );
  }

  Widget _buildCourseDetails() {
    return Container(
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

  Widget _buildSessionCard(
      Data session,
      LearnerExercisesController controller,
      ) {
    final isCompleted = (session.status ?? '').contains('مكتملة') ||
        (session.status ?? '').toLowerCase().contains('completed');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('التاريخ', session.date ?? ''),
            _buildRow('الوقت', '${session.startTime} - ${session.endTime}'),
            _buildRow('الحالة', session.status ?? ''),
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isCompleted) ...[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _onCompleteSession(controller, session.id!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text("اكتملت", style: AppStyles.textStyle16regular),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _onCancelSession(controller, session.id!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text("إلغاء", style: AppStyles.textStyle16regular),
                    ),
                  ),
                ],
                if (isCompleted) ...[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _onRateSession(controller, session.id!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text("تقييم", style: AppStyles.textStyle16regular),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _onRateSession(LearnerExercisesController controller, int sessionId) {
    final TextEditingController notesController = TextEditingController();
    RxDouble selectedRating = 0.0.obs;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text("تقييم الجلسة", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  return IconButton(
                    icon: Icon(
                      selectedRating.value >= starIndex
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      selectedRating.value = starIndex.toDouble();
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "اكتب ملاحظاتك هنا (اختياري)...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedRating.value == 0.0) {
                Get.snackbar(
                  "خطأ",
                  "يرجى اختيار التقييم",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              controller.rateSession(
                sessionId: sessionId,
                rate: selectedRating.value.toInt().toString(),
                notes: notesController.text.trim(),
                onSuccess: () {
                  Get.back();
                  Get.snackbar(
                    "تم",
                    "تم إرسال التقييم بنجاح",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                onError: (msg) {
                  Get.snackbar(
                    "خطأ",
                    msg,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kSecondaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text("إرسال"),
          ),
        ],
      ),
    );
  }

  void _onCancelSession(LearnerExercisesController controller, int sessionId) {
    final TextEditingController reasonController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text("سبب الإلغاء", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "يرجى كتابة سبب إلغاء الجلسة:",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                hintText: "اكتب السبب هنا...",
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("إلغاء", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              if (reason.isNotEmpty) {
                controller.cancelSession(
                  sessionId: sessionId,
                  reason: reason,
                  onSuccess: () {
                    Get.back();
                    Get.snackbar(
                      "تم",
                      "تم إلغاء الجلسة بنجاح",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  },
                );
                controller.getSessionsPerRequest(requestId: requestId);
                controller.fetchRequests();
              } else {
                Get.snackbar(
                  "خطأ",
                  "يرجى كتابة سبب الإلغاء",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kSecondaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text("إرسال"),
          ),
        ],
      ),
    );
  }

  void _onCompleteSession(
    LearnerExercisesController controller,
    int sessionId,
  ) {
    controller.completeSession(
      sessionId: sessionId,
      onSuccess: () => Get.snackbar("تم", "تم تأكيد الجلسة"),
    );
    controller.getSessionsPerRequest(requestId: requestId);
    controller.fetchRequests();
  }
}
