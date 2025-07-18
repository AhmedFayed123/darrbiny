
import 'package:darrbiny/features/home/presentation/views/widgets/course_details_view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../data/models/packages_list_model/Packages.dart';
import 'more_details_view.dart';

class CourseDetailsView extends StatelessWidget {
  final Packages package;

  const CourseDetailsView({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              CustomAppBar(title: 'تفاصيل الكورس'),
              CourseDetailsViewContainer(package: package),
              const Spacer(),
              CustomButton(
                text: 'استمرار',
                onPressed: () {
                  Get.to(() => MoreDetailsView(learnerId: 1, packageId: package.id??1, totalPrice: package.price??"",));
                },
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
