import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';
import '../../../../instructor_home/presentation/controller/instructor_home_controller.dart';
import '../../../../instructor_home/presentation/views/widgets/instructor_training_course_card.dart';
import '../../../../message/presentation/views/chat_start_view.dart';
import '../../controllers/instructor_exercises_controller.dart';

class InstructorNewList extends StatelessWidget {
  const InstructorNewList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InstructorExercisesController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.primaryRequests.isEmpty) {
        return Center(child: Text('لا يوجد كورسات مكتمله حاليًا'));
      }

      return ListView.separated(
        itemCount: controller.primaryRequests.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final exercise = controller.primaryRequests[index];

          return InstructorTrainingCourseCard(
            trainerName: exercise.instructor?.name ?? 'غير معروف',
            trainerImageUrl: Assets.imagesGirl,
            rating: double.tryParse(exercise.instructor?.rate ?? '0') ?? 0.0,
            fromDate: exercise.startDate ?? 'لم يحدد بعد',
            location: '${exercise.locationCity ?? ''} - ${exercise.locationArea ?? ''}',
            trainerCar: exercise.hasLearnerCar == true ? 'نعم' : 'لا',
            transportRequest: exercise.requiresTransport == true ? 'نعم' : 'لا',
            price: int.tryParse(exercise.totalPrice.split('.').first ?? '0') ?? 0,
            duration: exercise.type ?? '',
            isNew: true,
            onTap: () {
            Get.to(
                  () => ChatStartView(
                otherUserId: int.tryParse(exercise.learnerId.toString() ?? '0') ?? 0,
                userName: exercise.learner.name,
              ),
            );
          },
            onPressed: () {
              final homeController = Get.find<InstructorHomeController>();

              final packageId = exercise.id;
              final requestType = exercise.type.toLowerCase() ?? '';

              if (requestType == 'private') {
                homeController.acceptPrivateRequest(
                  packageId: packageId ?? 0,
                  onSuccess: () {
                    Get.snackbar("تم", "تم قبول الطلب الخاص بنجاح");
                    homeController.fetchHomeData();
                  },
                  onError: (error) {
                    Get.snackbar("خطأ", error);
                  },
                );
              } else if (requestType == 'general') {
                homeController.claimGeneralRequest(
                  packageId: packageId ?? 0,
                  onSuccess: () {
                    Get.snackbar("تم", "تم المطالبة بالطلب العام بنجاح");
                    homeController.fetchHomeData();
                  },
                  onError: (error) {
                    Get.snackbar("خطأ", error);
                  },
                );
              } else {
                Get.snackbar("تنبيه", "نوع الطلب غير معروف");
              }
            },

          );
        },
      );
    });
  }

}
