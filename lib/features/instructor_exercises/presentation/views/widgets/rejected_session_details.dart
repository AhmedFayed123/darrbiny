import 'package:darrbiny/core/components/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../exercises/data/models/sessions_per_request_model/Data.dart'
    show Data;
import '../../../../exercises/presentation/controllers/learner_exercises_controller.dart';
import '../../controllers/instructor_exercises_controller.dart';

class RejectedSessionDetails extends StatelessWidget {
  const RejectedSessionDetails({super.key, required this.requestId});

  final int requestId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnerExercisesController());
    controller.getSessionsPerRequest(requestId: requestId);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 8.h),
          child: Column(
            children: [
              CustomAppBar(title: 'جدول المتابعة'),
              Obx(() {
                final sessions = controller.sessionsPerRequestModel.value?.data;
                if (sessions == null) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (sessions.isEmpty) {
                  return const Expanded(
                    child: Center(child: Text("لا توجد جلسات مرفوضة.")),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(12.w),
                    itemCount: sessions.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final session = sessions[index];
                      return _buildRejectedSessionCard(session, controller);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRejectedSessionCard(
      Data session,
      LearnerExercisesController controller,
      ) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تفاصيل الجلسة',
              style: AppStyles.textStyle16regular.copyWith(
                color: kSecondaryColor,
              ),
            ),
            SizedBox(height: 10.h),
            _buildRow('التاريخ', session.date ?? ''),
            _buildRow('الوقت', '${session.startTime} - ${session.endTime}'),
            _buildRow('الحالة', session.status ?? ''),
            SizedBox(height: 16.h),

            if ((session.status?.toLowerCase().contains('pending') ?? false) ||
                (session.status?.contains('قيد الانتظار') ?? false))
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onRejectSession(controller, session.id!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    "رفض الجلسة",
                    style: AppStyles.textStyle16regular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
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
              color: const Color(0xFF666666),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: isPrice ? FontWeight.w700 : FontWeight.w500,
                fontSize: isPrice ? 15.sp : 14.sp,
                color: isPrice ? kSecondaryColor : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onRejectSession(LearnerExercisesController controller, int sessionId) {
    final TextEditingController reasonController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text("سبب الرفض", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("يرجى كتابة سبب رفض الجلسة:"),
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
              final instructorExercisesController = Get.put(
                InstructorExercisesController(),
              );
              final reason = reasonController.text.trim();
              if (reason.isEmpty) {
                Get.snackbar("تنبيه", "يرجى إدخال سبب الرفض");
                return;
              }

              instructorExercisesController.rejectSession(
                sessionId: sessionId,
                reason: reason,
                onSuccess: () {
                  Get.back();
                  Get.snackbar("تم", "تم رفض الجلسة بنجاح");
                  controller.fetchRequests();
                },
                onError: (message) {
                  Get.snackbar("خطأ", message);
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
}
