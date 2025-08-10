import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/instructor_home_list_model/Instructor_home_list_model.dart';

abstract class InstructorHomeRepo {
  Future<Either<Failure, InstructorHomeListModel>> getInstructorHomeList();
  Future<Either<Failure, Map<String,dynamic>>> generalRequestsClaim(int packageId);
  Future<Either<Failure, Map<String,dynamic>>> privateRequestsAccept(int packageId);

}