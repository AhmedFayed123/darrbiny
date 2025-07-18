import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/navigation_controller.dart';
import 'widgets/bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: const FancyBottomNavBar(),
    );
  }
}
