import 'package:darrbiny/core/errors/server_failures.dart';
import 'package:darrbiny/features/payment/data/models/charge_model/charge_model.dart';
import 'package:darrbiny/features/payment/data/models/payment_post_model/Payment_post_model.dart';
import 'package:darrbiny/features/payment/data/models/payment_request_model/Payment_request_model.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepo {
  Future<Either<Failure,PaymentPostModel>> postPayment(PaymentRequestModel paymentRequestModel);
  Future<Either<Failure,ChargeModel>> getCharge(String chargeId);
}