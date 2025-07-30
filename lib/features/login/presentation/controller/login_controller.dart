import 'package:darrbiny/features/instructor_home/presentation/views/instructor_home_view.dart';
import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../data/repos/login_repo.dart';

class LoginController extends GetxController {
  final LoginRepo loginRepo = sl<LoginRepo>();

  late String accountType;

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

    try {
      final fullPhone = phoneNumber.value;

      final result = await loginRepo.login(
        phone: fullPhone,
        password: password.value,
        accountType: accountType,
      );

      result.fold(
            (failure) {
          Get.snackbar("فشل", "فشل تسجيل الدخول: ${failure.message}");
        },
            (data) async {
          final token = data['token'] as String;
          final user = data['user'] as Map<String, dynamic>;
          final userId = user['id']?.toString() ?? '';
          final userName = user['name'] ?? '';
          final userEmail = user['email'] ?? '';

          await storageService.saveLoginSession(
            accountType: accountType,
            token: token,
            userId: userId,
            userName: userName,
            userEmail: userEmail,
          );

          if (accountType == 'instructor') {
            await Get.offAll(() => const InstructorHomeView());
          } else if (accountType == 'learner') {
            await Get.offAll(() => const HomeView());
          } else {
            Get.snackbar("خطأ", "نوع حساب غير معروف");
          }
        },
      );

    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ غير متوقع: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
