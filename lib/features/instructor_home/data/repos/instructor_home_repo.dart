import 'package:darrbiny/features/instructor_home/data/models/Instructor_home_list_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';

abstract class InstructorHomeRepo {
  Future<Either<Failure, InstructorHomeListModel>> getInstructorHomeList(int id);

}