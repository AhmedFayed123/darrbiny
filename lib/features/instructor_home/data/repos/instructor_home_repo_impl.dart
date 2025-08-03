import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/instructor_home/data/models/Instructor_home_list_model.dart';
import 'package:darrbiny/features/instructor_home/data/repos/instructor_home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/storage_service.dart';

class InstructorHomeRepoImpl extends InstructorHomeRepo {
  @override
  Future<Either<Failure, InstructorHomeListModel>> getInstructorHomeList() async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.instructorsHomeList,
        data: {"instructor_id": await StorageService().getUserId()},
      );
      return right(InstructorHomeListModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
