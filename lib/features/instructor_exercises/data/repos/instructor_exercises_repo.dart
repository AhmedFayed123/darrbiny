import 'package:darrbiny/features/instructor_exercises/data/models/completed_rates/Completed_rates.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/instructor_response_model/instructor_response_model.dart';

abstract class InstructorExercisesRepo {
  Future<Either<Failure, InstructorLessonRequestsResponse>> requestsInstructor();
  Future<Either<Failure, List<CompletedRates>>> completedRates();

}