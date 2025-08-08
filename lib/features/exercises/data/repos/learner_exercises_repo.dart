import 'package:darrbiny/features/exercises/data/models/sessions_per_request_model/Sessions_per_request_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/learner_lesson_requests_response.dart';

abstract class LearnerExercisesRepo {
  Future<Either<Failure, LearnerLessonRequestsResponse>> requestsLearner();
  Future<Either<Failure, Map<String,dynamic>>> sessionsComplete(int sessionId);
  Future<Either<Failure, Map<String,dynamic>>> sessionsCancel(String msg,int sessionId);
  Future<Either<Failure, Map<String,dynamic>>> sessionsRate(String notes,int sessionId,String rate);
  Future<Either<Failure, SessionsPerRequestModel>> sessionsPerRequest(int sessionId);

}