// تحكم أساسي للطلبات
import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../../instructor_exercises/data/models/instructor_response_model/instructor_response_model.dart';
import '../../data/models/learner_lesson_requests_response.dart';
import '../../data/repos/learner_exercises_repo.dart';

abstract class BaseExercisesController<T extends BaseLessonRequestsResponse> extends GetxController {
  final isLoading = false.obs;
  final error = ''.obs;
  final lessonRequestsResponse = Rxn<T>();

  final primaryRequests = <LessonRequest>[].obs;
  final activeRequests = <LessonRequest>[].obs;
  final completedRequests = <LessonRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> fetchRequests();

  Future<void> refreshRequests() async {
    await fetchRequests();
  }

  LessonRequest? getRequestById(int id) {
    final allRequests = [
      ...primaryRequests,
      ...activeRequests,
      ...completedRequests,
    ];
    return allRequests.firstWhereOrNull((request) => request.id == id);
  }

  void clearRequests() {
    primaryRequests.clear();
    activeRequests.clear();
    completedRequests.clear();
  }

  void handleResponse(T? response) {
    if (response != null) {
      primaryRequests.assignAll(response.primaryRequests);
      activeRequests.assignAll(response.activeRequests);
      completedRequests.assignAll(response.completedRequests);
    }
  }
}
class LearnerExercisesController extends BaseExercisesController<LearnerLessonRequestsResponse> {
  final LearnerExercisesRepo learnerExercisesRepo = sl<LearnerExercisesRepo>();

  @override
  Future<void> fetchRequests() async {
    isLoading.value = true;
    error.value = '';
    clearRequests();

    final result = await learnerExercisesRepo.requestsLearner();

    result.fold(
          (failure) {
            print(failure.message);
            print('aaaa');
            return error.value = failure.message;
          },
          (response) {
        lessonRequestsResponse.value = response;
        handleResponse(response);
        print('pppppp');
        print(lessonRequestsResponse);
      },
    );

    isLoading.value = false;
  }
}