import 'package:darrbiny/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        title: Text("الإشعارات",style: AppStyles.textStyle14500,),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text("حدث خطأ: ${controller.error.value}"));
        }

        final notificationsList = controller.notifications.value?.notifications ?? [];

        if (notificationsList.isEmpty) {
          return const Center(child: Text("لا توجد إشعارات"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: notificationsList.length,
          itemBuilder: (context, index) {
            final item = notificationsList[index];
            final message = item.data?.message ?? "";
            final createdAt = item.createdAt ?? "";

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue),
                title: Text(message, style: const TextStyle(fontSize: 14)),
                subtitle: Text(
                  createdAt.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
