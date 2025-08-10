import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/notifications/data/models/get_notification_model/Get_notification_model.dart';
import 'package:darrbiny/features/notifications/data/repos/notification_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/storage_service.dart';

class NotificationRepoImpl extends NotificationRepo{
  @override
  Future<Either<Failure, GetNotificationModel>> postNotification() async{
    try {
      final String? userId = await StorageService().getUserId();

      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.notifications,
        data: {"user_id": userId},
      );

      return right(GetNotificationModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}