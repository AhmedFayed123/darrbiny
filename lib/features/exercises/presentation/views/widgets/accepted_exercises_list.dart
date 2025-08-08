import 'package:darrbiny/features/exercises/presentation/views/widgets/accept_exercise_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/assets.dart';
import '../../../../message/presentation/views/chat_start_view.dart';
import '../../controllers/learner_exercises_controller.dart';
import 'active_course_card.dart';

class AcceptedExercisesList extends StatelessWidget {
  const AcceptedExercisesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnerExercisesController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.activeRequests.isEmpty) {
        return Center(child: Text('لا يوجد كورسات نشطة حاليًا'));
      }

      return ListView.separated(
        itemCount: controller.activeRequests.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final exercise = controller.activeRequests[index];

          return ActiveCourseCard(
            durationDays: exercise.package.daysCount.toString() ?? "",
            durationHours: exercise.package.hoursCount.toString() ?? "",
            learnerImageUrl: Assets.imagesGirl,
            instructorName: exercise.instructor?.name ?? "",
            rating: exercise.instructor?.rate ?? "",
            date: exercise.startDate ?? "",
            price: exercise.totalPrice ?? "",
            time: exercise.type ?? "",
            packName: exercise.package.name,
            onTap: () {
              Get.to(
                () => Material(
                  child: AcceptExerciseDetails(
                    requestId: exercise.id,
                    rating: exercise.instructor?.rate ?? "",
                    date: exercise.startDate ?? "",
                    learnerImageUrl: Assets.imagesGirl,
                    instructorName: exercise.instructor?.name ?? "",
                    packName: exercise.package.name,
                    durationHours: exercise.package.hoursCount.toString() ?? "",
                    durationDays: exercise.package.daysCount.toString() ?? "",
                    price: exercise.totalPrice ?? "",

                    time: exercise.type ?? "",
                    onTap: () {
                      Get.to(
                        () => ChatStartView(
                          otherUserId: exercise.instructorId ?? 0,
                          userName: exercise.instructor?.name ?? "",
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
