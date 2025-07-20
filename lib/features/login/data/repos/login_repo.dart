import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';

abstract class LoginRepo {
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String phone,
    required String password,
  });
}