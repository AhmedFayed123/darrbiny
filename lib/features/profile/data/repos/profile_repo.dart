import 'package:darrbiny/features/profile/data/models/learner_profile_model/Learner_profile_model.dart';
import 'package:darrbiny/features/profile/data/models/learners_profile_update/Learners_profile_update.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';

abstract class ProfileRepo {
  Future<Either<Failure, LearnerProfileModel>> postLearnerProfile();
  Future<Either<Failure, LearnerProfileModel>> postInstructorProfile();

  Future<Either<Failure, LearnersProfileUpdate>> postLearnerUpdateProfile({
    required String name,
    required String filePath,
  });

  Future<Either<Failure, LearnersProfileUpdate>> postInstructorUpdateProfile({
    required String name,
    required String filePath,
  });
}
