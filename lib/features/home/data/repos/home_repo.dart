import 'package:darrbiny/features/home/data/models/request_model/booking_request_model/Booking_request_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/instructors_list_model/Instructors_list_model.dart';
import '../models/packages_list_model/Packages_list_model.dart';
import '../models/request_model/booking_model/Booking_model.dart';
import '../models/single_package_model/single_package_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, PackagesListModel>> getPackagesList();
  Future<Either<Failure, List<InstructorModel>>> getInstructorsList();
  Future<Either<Failure, SinglePackageModel>> getSinglePackage(int id);
    Future<Either<Failure, BookingModel>> postRequest(BookingRequestModel requestRequest);
}