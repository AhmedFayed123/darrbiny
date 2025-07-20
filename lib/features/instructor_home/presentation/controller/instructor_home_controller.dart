

import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/models/Instructor_home_list_model.dart';
import '../../data/repos/instructor_home_repo.dart';

class InstructorHomeController extends GetxController {
  final InstructorHomeRepo _repo = sl<InstructorHomeRepo>();

  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  var homeData = Rxn<InstructorHomeListModel>();

  Future<void> fetchHomeData(int instructorId) async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    final result = await _repo.getInstructorHomeList(instructorId);

    result.fold(
          (failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
          (instructorHomeList) {
        homeData.value = instructorHomeList;
      },
    );


    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    // Replace with actual instructor ID
    fetchHomeData(1);
  }
}
