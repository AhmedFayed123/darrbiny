import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/instructor_exercises/data/models/completed_rates/Completed_rates.dart';
import 'package:darrbiny/features/instructor_exercises/data/repos/instructor_exercises_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/storage_service.dart';
import '../models/instructor_response_model/instructor_response_model.dart';

class InstructorExercisesRepoImpl extends InstructorExercisesRepo{
  @override
  Future<Either<Failure, InstructorLessonRequestsResponse>> requestsInstructor()async {
    try {
      final String? instructorId = await StorageService().getUserId();

      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.requestsInstructor,
        data: {"instructor_id": instructorId},
      );
      return right(InstructorLessonRequestsResponse.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CompletedRates>>> completedRates() async {
    try {
      final String? instructorId = await StorageService().getUserId();

      final Response response = await DioHelper.getData(
        url: '${AppEndpoints.ratingsInstructor}/$instructorId',
      );

      print('object');
      print(response.data);
      final List data = response.data;
      final rates = data.map((e) => CompletedRates.fromJson(e)).toList();
      return right(rates);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}