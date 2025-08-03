import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/errors/server_failures.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../models/instructors_list_model/Instructors_list_model.dart';
import '../models/packages_list_model/Packages_list_model.dart';
import '../models/request_model/booking_model/Booking_model.dart';
import '../models/request_model/booking_request_model/Booking_request_model.dart';
import '../models/single_package_model/single_package_model.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo{
  @override
  Future<Either<Failure, PackagesListModel>> getPackagesList() async{
    try {
      final response = await DioHelper.getData(
          url: AppEndpoints.packagesList,
    );
    print(response.data);
    return right(PackagesListModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InstructorModel>>> getInstructorsList() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.instructorsList,
      );
      print(response.data);

      List<InstructorModel> instructors = (response.data as List)
          .map((e) => InstructorModel.fromJson(e))
          .toList();

      return right(instructors);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SinglePackageModel>> getSinglePackage(int id) async{
    try {
      final response = await DioHelper.getData(
        url: "${AppEndpoints.singlePackage}/$id",
      );
      print(response.data);
      return right(SinglePackageModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingModel>> postRequest(BookingRequestModel requestRequest) async{
    try {
      final Response response = await DioHelper.postData(
        url: AppEndpoints.requests,
        data: requestRequest,
      );
      print("✅ Response data from server: ${response.data}");
      return right(BookingModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }



}