import 'package:darrbiny/features/home/presentation/views/widgets/training_packages_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home_controller/home_controller.dart';

class TrainingPackageList extends StatelessWidget {
  const TrainingPackageList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.packagesList.isEmpty) {
        return const Center(child: Text('لا توجد باقات حالياً'));
      }

      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.packagesList.length >= 3
            ? 3
            : controller.packagesList.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final package = controller.packagesList[index];
          return TrainingPackageItem(package: package);
        },
      );
    });
  }
}
