import 'package:darrbiny/features/instructor_home/presentation/views/instructor_home_view.dart';
import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../../data/repos/login_repo.dart';

class LoginController extends GetxController {
  final LoginRepo loginRepo = sl<LoginRepo>();

  var isLoading = false.obs;
  var countryCode = '966'.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;
  final StorageService storageService = StorageService();

  void updatePhoneNumber(String phone) {
    phoneNumber.value = phone;
  }

  void updateCountryCode(String code) {
    countryCode.value = code;
  }

  void updatePassword(String pass) {
    password.value = pass;
  }

  Future<void> loginWithApi() async {
    isLoading.value = true;

    final fullPhone = phoneNumber.value;

    final result = await loginRepo.login(
      phone: fullPhone,
      password: password.value,
    );

    result.fold(
          (failure) {
        Get.snackbar("فشل", "فشل تسجيل الدخول: ${failure.message}");
      },
          (data) {
        Get.offAll(() => const InstructorHomeView());
      },
    );

    isLoading.value = false;
  }
}
