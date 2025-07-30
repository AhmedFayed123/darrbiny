import 'package:get/get.dart';
import 'package:darrbiny/features/profile/data/models/learner_profile_model/Learner_profile_model.dart';
import 'package:darrbiny/features/profile/data/repos/profile_repo.dart';

import '../../../../core/services/service_locator.dart';

class LearnerProfileController extends GetxController {
  final ProfileRepo profileRepo = sl<ProfileRepo>();

  var isLoading = false.obs;
  var learnerProfile = Rxn<LearnerProfileModel>();
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLearnerProfile();
  }

  void fetchLearnerProfile() async {
    isLoading.value = true;
    error.value = '';

    final result = await profileRepo.postLearnerProfile();

    result.fold(
          (failure) {
        error.value = failure.message;
      },
          (profile) {
        learnerProfile.value = profile;
      },
    );

    isLoading.value = false;
  }

  void updateProfile({required String name, required String imagePath}) async {
    isLoading.value = true;
    error.value = '';

    final result = await profileRepo.postLearnerUpdateProfile(
      name: name,
      filePath: imagePath,
    );

    result.fold(
          (failure) => error.value = failure.message,
          (success) {
        fetchLearnerProfile();
        Get.snackbar("تم التحديث", "تم تحديث بيانات الملف الشخصي بنجاح");
      },
    );

    isLoading.value = false;
  }

}
