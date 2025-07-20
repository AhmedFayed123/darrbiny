import 'dart:io';

import 'package:darrbiny/features/sign_up/data/models/sign_up_request_model/Instructor_sign_up_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:darrbiny/core/constant/app_endpoints.dart';
import 'package:darrbiny/features/sign_up/data/repos/sign_up_repo.dart';

import '../../../../core/errors/server_failures.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';

class SignUpRepoImpl extends SignUpRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> postRequestWithPhotos({
    required int id,
    required File drivingImage,
    required File nationalIdImage,
    required File carImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        'car_image': await MultipartFile.fromFile(carImage.path, filename: 'car.jpg'),
        'license_image': await MultipartFile.fromFile(drivingImage.path, filename: 'driving.jpg'),
        'profile_image': await MultipartFile.fromFile(nationalIdImage.path, filename: 'national_id.jpg'),
      });

      final response = await DioHelper.postDataWithoutToken(
        url: "${AppEndpoints.instructorsDocuments}/$id",
        data: formData,
      );
      print('photos');
      print(response.data as Map<String, dynamic>);

      return right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> instructorSignUp(InstructorSignUpRequestModel instructorSignUpRequestModel) async{
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.instructorsRegister,
        data: instructorSignUpRequestModel.toJson(),
      );
      if (response.data is Map<String, dynamic>) {
        return right(response.data as Map<String, dynamic>);
      } else {
        return left(ServerFailure("Unexpected response format"));
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
