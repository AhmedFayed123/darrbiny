import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/learner_profile_model/Learner_profile_model.dart';
import '../../data/repos/profile_repo.dart';

class InstructorProfileController extends GetxController {
  final ProfileRepo profileRepo = sl<ProfileRepo>();

  var isLoading = false.obs;
  var instructorProfile = Rxn<LearnerProfileModel>();
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInstructorProfile();
  }

  void fetchInstructorProfile() async {
    isLoading.value = true;
    error.value = '';

    final result = await profileRepo.postInstructorProfile();

    result.fold(
      (failure) {
        error.value = failure.message;
      },
      (profile) {
        instructorProfile.value = profile;
      },
    );

    isLoading.value = false;
  }

  void updateInstructorProfile({
    required String name,
    required String imagePath,
  }) async {
    isLoading.value = true;
    error.value = '';

    final result = await profileRepo.postInstructorUpdateProfile(
      name: name,
      filePath: imagePath,
    );

    result.fold((failure) => error.value = failure.message, (success) {
      fetchInstructorProfile();
      Get.snackbar("تم التحديث", "تم تحديث بيانات الملف الشخصي بنجاح");
    });

    isLoading.value = false;
  }
}
