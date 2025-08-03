import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../../generated/assets.dart';
import '../../controller/instructor_home_controller.dart';
import 'instructor_training_course_card.dart';

class InstructorTrainingList extends StatelessWidget {
  const InstructorTrainingList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InstructorHomeController>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              const CustomAppBar(title: 'الطلبات الجديدة'),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final dataList = controller.homeData.value?.data ?? [];

                  if (dataList.isEmpty) {
                    return const Center(child: Text("لا توجد طلبات حالياً"));
                  }

                  return ListView.separated(
                    itemCount: dataList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = dataList[index];

                      return InstructorTrainingCourseCard(
                        trainerName: item.instructor?.name ?? 'غير معروف',
                        trainerImageUrl: Assets.imagesGirl,
                        rating: double.tryParse(item.instructor?.rate ?? '0') ?? 0.0,
                        fromDate: item.startDate ?? 'لم يحدد بعد',
                        toDate: '',
                        location: '${item.locationCity ?? ''} - ${item.locationArea ?? ''}',
                        trainerCar: item.hasLearnerCar == true ? 'نعم' : 'لا',
                        transportRequest: item.requiresTransport == true ? 'نعم' : 'لا',
                        price: int.tryParse(item.totalPrice?.split('.').first ?? '0') ?? 0,
                        duration: item.type ?? '',
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
