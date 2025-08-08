import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/exercises/data/models/sessions_per_request_model/Sessions_per_request_model.dart';
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> sessionsCancel(String msg, int sessionId) async {
    try {
      final formData = FormData.fromMap({
        'rejection_reason': msg,
      });

      final Response response = await DioHelper.postData(
        url: "sessions/$sessionId/cancel",
        data: formData,
        isMultipart: true
      );

      print('iiiii');
      print(response.data);
      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Map<String, dynamic>>> sessionsComplete(int sessionId) async{
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: "sessions/$sessionId/complete",
        data: {},
      );
      print('iiiii');
      print(response.data);
      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> sessionsRate(String notes, int sessionId, String rate)async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: "sessions/$sessionId/rate",
        data: {
          "rate":rate,
          "notes":notes
        },
      );
      print('iiiii');
      print(response.data);
      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SessionsPerRequestModel>> sessionsPerRequest(int sessionId) async{
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.requestsSessions,
        data: {
          "request_id" : sessionId
        },
      );
      print('iiiii');
      print(response.data);
      return right(SessionsPerRequestModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}