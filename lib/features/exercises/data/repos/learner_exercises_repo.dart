import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/learner_lesson_requests_response.dart';

abstract class LearnerExercisesRepo {
  Future<Either<Failure, LearnerLessonRequestsResponse>> requestsLearner();

}