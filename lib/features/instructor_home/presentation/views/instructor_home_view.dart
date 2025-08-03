import 'package:darrbiny/features/instructor_home/presentation/controller/instructor_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/presentation/views/widgets/bottom_nav_bar.dart';

class InstructorHomeView extends StatelessWidget {
  const InstructorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final InstructorNavigationController controller = Get.put(InstructorNavigationController());

    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: FancyBottomNavBar(controller: controller,),
    );
  }

}
