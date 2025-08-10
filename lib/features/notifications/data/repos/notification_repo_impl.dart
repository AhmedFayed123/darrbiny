import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/notifications/data/models/get_notification_model/Get_notification_model.dart';
import 'package:darrbiny/features/notifications/data/repos/notification_repo.dart';
import 'package:dartz/dartz.dart';

class NotificationRepoImpl extends NotificationRepo{
  @override
  Future<Either<Failure, GetNotificationModel>> postNotification() async{
    // TODO: implement postNotification
    throw UnimplementedError();
  }
}