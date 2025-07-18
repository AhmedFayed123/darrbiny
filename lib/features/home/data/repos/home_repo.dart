import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/instructors_list_model/Instructors_list_model.dart';
import '../models/packages_list_model/Packages_list_model.dart';
import '../models/request_model/Request_model.dart';
import '../models/request_model/request_request/Request_request.dart';
import '../models/single_package_model/single_package_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, PackagesListModel>> getPackagesList();
  Future<Either<Failure, List<InstructorModel>>> getInstructorsList();
  Future<Either<Failure, SinglePackageModel>> getSinglePackage(int id);
  Future<Either<Failure, RequestModel>> postRequest(RequestRequest requestRequest);
}