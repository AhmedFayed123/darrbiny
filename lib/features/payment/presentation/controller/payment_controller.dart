import 'package:get/get.dart';
import '../../../../core/services/service_locator.dart';
import '../../data/models/payment_post_model/Payment_post_model.dart';
import '../../data/models/payment_request_model/Payment_request_model.dart';
import '../../data/models/charge_model/charge_model.dart';
import '../../data/repos/payment_repo.dart';

class PaymentController extends GetxController {
  final PaymentRepo paymentRepo = sl<PaymentRepo>();

  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  Rx<PaymentPostModel?> paymentResponse = Rx<PaymentPostModel?>(null);
  Rx<ChargeModel?> chargeResponse = Rx<ChargeModel?>(null);

  Future<void> postPayment(
      PaymentRequestModel paymentRequestModel, {
        void Function(PaymentPostModel response)? onSuccess,
        void Function(String error)? onError,
      }) async {
    isLoading.value = true;
    error.value = '';

    final result = await paymentRepo.postPayment(paymentRequestModel);

    result.fold(
          (failure) {
        error.value = failure.message;
        if (onError != null) onError(failure.message);
      },
          (response) {
        paymentResponse.value = response;
        if (onSuccess != null) onSuccess(response);
      },
    );

    isLoading.value = false;
  }

  Future<void> getCharge(String chargeId, {
    void Function(ChargeModel response)? onSuccess,
    void Function(String error)? onError,
  }) async {
    isLoading.value = true;
    error.value = '';

    final result = await paymentRepo.getCharge(chargeId);

    result.fold(
          (failure) {
        error.value = failure.message;
        if (onError != null) onError(failure.message);
      },
          (response) {
        if (response.success == false) {
          final errorMsg = 'Charge verification failed';
          error.value = errorMsg;
          if (onError != null) onError(errorMsg);
        } else {
          chargeResponse.value = response;
          if (onSuccess != null) onSuccess(response);
        }
      },
    );

    isLoading.value = false;
  }
}
