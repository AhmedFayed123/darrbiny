import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/instructor_home/data/repos/instructor_home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/storage_service.dart';
import '../models/instructor_home_list_model/Instructor_home_list_model.dart';

class InstructorHomeRepoImpl extends InstructorHomeRepo {
  @override
  Future<Either<Failure, InstructorHomeListModel>> getInstructorHomeList() async {
    try {
      final String? instructorId = await StorageService().getUserId();

      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.instructorsHomeList,
        data: {"instructor_id": instructorId},
      );
      print('object');
      print(instructorId);
      print(response.data);
      return right(InstructorHomeListModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> generalRequestsClaim(int packageId) async{
    try {
      final String? instructorId = await StorageService().getUserId();
      final Response response = await DioHelper.postData(
        url: "${AppEndpoints.requestsClaim}/$packageId",
        data: {"instructor_id": instructorId},
      );
      print("aha");
      print(response.data);
      print(instructorId);
      print(packageId);

      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> privateRequestsAccept(int packageId) async{
    try {
      final String? instructorId = await StorageService().getUserId();
      final Response response = await DioHelper.postData(
        url: "${AppEndpoints.requestsAccept}/$packageId",
        data: {"instructor_id": instructorId},
      );
      print("aha2");
      print('ooooooooooo${response.data}');
      print(instructorId);
      print(packageId);
      return right(response.data);
    } on DioException catch (e) {
      print('jjjjjjjj');
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      print('lllllllllll');
      return left(ServerFailure(e.toString()));
    }
  }
}
