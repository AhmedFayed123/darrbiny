import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/payment/data/models/charge_model/charge_model.dart';
import 'package:darrbiny/features/payment/data/models/payment_post_model/Payment_post_model.dart';
import 'package:darrbiny/features/payment/data/models/payment_request_model/Payment_request_model.dart';
import 'package:darrbiny/features/payment/data/repos/payment_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';

class PaymentRepoImpl extends PaymentRepo{
  @override
  Future<Either<Failure, PaymentPostModel>> postPayment(PaymentRequestModel paymentRequestModel) async{
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.tapCharge,
        data: paymentRequestModel.toJson(),
      );
      return right(PaymentPostModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChargeModel>> getCharge(String chargeId) async{
    try {
      final Response response = await DioHelper.getDataWithoutToken(
        url: "${AppEndpoints.tapCharge}/$chargeId",
      );
      return right(ChargeModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}