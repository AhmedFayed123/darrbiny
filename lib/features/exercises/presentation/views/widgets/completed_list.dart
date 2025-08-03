import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';
import '../../controllers/learner_exercises_controller.dart';
import 'completed_list_item.dart';

class CompletedList extends StatelessWidget {
  const CompletedList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnerExercisesController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.completedRequests.isEmpty) {
        return Center(child: Text('لا يوجد كورسات مكتمله حاليًا'));
      }

      return ListView.separated(
        itemCount: controller.completedRequests.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final exercise = controller.completedRequests[index];

          return CompletedListItem(
            durationDays: exercise.package.daysCount.toString() ?? "",
            durationHours: exercise.package.hoursCount.toString() ?? "",
            learnerImageUrl: Assets.imagesGirl,
            instructorName: exercise.instructor?.name ?? "",
            rating: exercise.instructor?.rate ?? "",
            price: exercise.totalPrice ?? "",
            packName: exercise.package.name,
            date: exercise.startDate ?? "",
          );
        },
      );
    });
  }
}
