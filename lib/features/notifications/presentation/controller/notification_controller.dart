import 'package:darrbiny/features/notifications/data/models/get_notification_model/Get_notification_model.dart';
import 'package:darrbiny/features/notifications/data/repos/notification_repo.dart';
import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';

class NotificationController extends GetxController {
  final NotificationRepo notificationRepo = sl<NotificationRepo>();

  var isLoading = false.obs;
  var notifications = Rxn<GetNotificationModel>();
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    isLoading.value = true;
    error.value = '';

    final result = await notificationRepo.postNotification();

    result.fold(
          (failure) {
        error.value = failure.message;
      },
          (data) {
        notifications.value = data;
      },
    );

    isLoading.value = false;
  }
}
