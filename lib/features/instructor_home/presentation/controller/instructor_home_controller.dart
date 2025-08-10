import 'package:darrbiny/features/instructor_home/presentation/views/widgets/instructor_home_view_body.dart';
import 'package:darrbiny/features/message/presentation/views/message_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../../instructor_exercises/presentation/views/instructor_exercises_view.dart';
import '../../../profile/presentation/views/instructor_profile_view.dart';
import '../../data/models/instructor_home_list_model/Instructor_home_list_model.dart';
import '../../data/repos/instructor_home_repo.dart';

class InstructorHomeController extends GetxController {
  final InstructorHomeRepo _repo = sl<InstructorHomeRepo>();

  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  var homeData = Rxn<InstructorHomeListModel>();

  Future<void> fetchHomeData() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    final result = await _repo.getInstructorHomeList();

    result.fold(
          (failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
          (instructorHomeList) {
        homeData.value = instructorHomeList;
        print('homeData');
        print(homeData.value);
      },
    );

    isLoading.value = false;
  }

  Future<void> claimGeneralRequest({
    required int packageId,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final result = await _repo.generalRequestsClaim(packageId);

    result.fold(
          (failure) => onError(failure.message),
          (data) => onSuccess(),
    );
  }

  Future<void> acceptPrivateRequest({
    required int packageId,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final result = await _repo.privateRequestsAccept(packageId);

    result.fold(
          (failure) => onError(failure.message),
          (data) => onSuccess(),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }
}


class InstructorNavigationController extends GetxController{
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    InstructorHomeViewBody(),
    InstructorExercisesView(),
    MessageView(),
    InstructorProfileView(),
  ];

  void changeIndex(int index) => currentIndex.value = index;
}