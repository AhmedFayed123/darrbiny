import 'package:darrbiny/features/home/presentation/views/widgets/trainer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller/home_controller.dart';

class TrainerList extends StatelessWidget {
  const TrainerList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.instructorsList.isEmpty) {
        return Center(
          child: Text(
            'لا يوجد مدربين حالياً',
            style: TextStyle(fontSize: 16.sp),
          ),
        );
      }

      return SizedBox(
        height: 230.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.instructorsList.length,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final instructor = controller.instructorsList[index];
            return TrainerItem(instructor: instructor);
          },
        ),
      );
    });
  }
}
