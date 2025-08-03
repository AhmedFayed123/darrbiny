import 'package:darrbiny/features/home/presentation/views/widgets/training_packages_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_app_bar.dart';
import '../../controller/home_controller/home_controller.dart';

class TrainingPackagesFullList extends StatelessWidget {
  const TrainingPackagesFullList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              const CustomAppBar(title: 'الباقات التدريبيه'),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.packagesList.isEmpty) {
                    return const Center(child: Text('لا توجد باقات حالياً'));
                  }

                  return ListView.separated(
                    itemCount: controller.packagesList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final package = controller.packagesList[index];
                      return TrainingPackageItem(package: package);
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
