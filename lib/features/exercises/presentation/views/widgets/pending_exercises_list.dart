import 'package:darrbiny/features/exercises/presentation/views/widgets/pending_exercises_item.dart';
import 'package:darrbiny/features/home/presentation/views/more_details_view.dart';
import 'package:darrbiny/features/message/presentation/views/chat_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';
import '../../../../message/presentation/views/chat_start_view.dart';
import '../../controllers/learner_exercises_controller.dart';

class PendingExercisesList extends StatelessWidget {
  const PendingExercisesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnerExercisesController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.primaryRequests.isEmpty) {
        return Center(child: Text('لا يوجد كورسات بانتظار العروض حاليًا'));
      }

      return ListView.separated(
        itemCount: controller.primaryRequests.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final exercise = controller.primaryRequests[index];
          return PendingExercisesItem(
            durationDays: exercise.package.daysCount.toString() ?? "",
            durationHours: exercise.package.hoursCount.toString() ?? "",
            learnerImageUrl: Assets.imagesGirl,
            instructorName: exercise.instructor?.name ?? "",
            rating: exercise.instructor?.rate ?? "",
            price: exercise.totalPrice ?? "",
            packName: exercise.package.name,
            instructorMessage: exercise.instructor?.bio,
            onTap: () {
              Get.to(() => ChatStartView(otherUserId: exercise.instructorId??0, userName: exercise.instructor?.name??""));
            }, onTap2: () {
              Get.to(()=>MoreDetailsView(learnerId: exercise.learnerId, packageId: exercise.packageId, totalPrice: exercise.package.price, packageName: exercise.package.name,));
          },
          );
        },
      );
    });
  }
}
