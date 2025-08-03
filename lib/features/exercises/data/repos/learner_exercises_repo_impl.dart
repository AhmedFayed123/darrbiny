import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/exercises/data/repos/learner_exercises_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/storage_service.dart';
import '../models/learner_lesson_requests_response.dart';

class LearnerExercisesRepoImpl extends LearnerExercisesRepo{
  @override
  Future<Either<Failure, LearnerLessonRequestsResponse>> requestsLearner() async{
    try {
      final String? learnerId = await StorageService().getUserId();

      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.requestsLearner,
        data: {"learner_id": learnerId},
      );
      print('iiiii');
      print(response.data);
      return right(LearnerLessonRequestsResponse.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}