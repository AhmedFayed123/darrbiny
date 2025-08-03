import 'package:darrbiny/features/instructor_exercises/presentation/views/widgets/instructor_completed_list_item.dart';
import 'package:darrbiny/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/instructor_exercises_controller.dart';

class InstructorCompletedList extends StatelessWidget {
  const InstructorCompletedList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InstructorExercisesController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.completedRates.isEmpty) {
        return Center(child: Text('لا يوجد كورسات مكتمله حاليًا'));
      }

      return ListView.separated(
        itemCount: controller.completedRates.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final exercise = controller.completedRates[index];

          return InstructorCompletedListItem(
            trainerImageUrl: Assets.imagesGirl,
            trainerName: exercise.learner?.name ?? '',
            rating: double.tryParse(exercise.rating ?? '0') ?? 0.0,
            comment: exercise.comment ?? '',
          );
        },
      );
    });
  }
}
