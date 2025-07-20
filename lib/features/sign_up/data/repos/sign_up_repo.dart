import 'dart:io';

import 'package:darrbiny/features/sign_up/data/models/sign_up_request_model/Instructor_sign_up_request_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';

abstract class SignUpRepo {
  Future<Either<Failure, Map<String, dynamic>>> postRequestWithPhotos({
    required int id,
    required File drivingImage,
    required File nationalIdImage,
    required File carImage,
  });
  Future<Either<Failure, Map<String, dynamic>>> instructorSignUp(InstructorSignUpRequestModel instructorSignUpRequestModel);

}