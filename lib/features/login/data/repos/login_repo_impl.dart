import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:darrbiny/core/errors/server_failures.dart';

import 'package:darrbiny/features/login/data/repos/login_repo.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.login,
        data: {
          'phone': phone,
          'password': password,
        },
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
