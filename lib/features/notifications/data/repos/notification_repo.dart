import 'package:darrbiny/features/notifications/data/models/get_notification_model/Get_notification_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';

abstract class NotificationRepo {
  Future<Either<Failure, GetNotificationModel>> postNotification();

}