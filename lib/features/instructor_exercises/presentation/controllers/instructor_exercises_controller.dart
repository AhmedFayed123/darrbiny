import 'package:get/get.dart';

import '../../../../core/services/service_locator.dart';
import '../../../exercises/presentation/controllers/learner_exercises_controller.dart';
import '../../data/models/completed_rates/Completed_rates.dart';
import '../../data/models/instructor_response_model/instructor_response_model.dart';
import '../../data/repos/instructor_exercises_repo.dart';

class InstructorExercisesController extends BaseExercisesController<InstructorLessonRequestsResponse> {
  final InstructorExercisesRepo instructorExercisesRepo = sl<InstructorExercisesRepo>();
  final RxList<CompletedRates> completedRates = <CompletedRates>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompletedRates();
  }
  @override
  Future<void> fetchRequests() async {
    isLoading.value = true;
    error.value = '';
    clearRequests();

    final result = await instructorExercisesRepo.requestsInstructor();

    result.fold(
          (failure) => error.value = failure.message,
          (response) {
        lessonRequestsResponse.value = response;
        handleResponse(response);
      },
    );

    isLoading.value = false;
  }
  Future<void> fetchCompletedRates() async {
    isLoading.value = true;

    final result = await instructorExercisesRepo.completedRates();

    result.fold(
          (failure) {
        Get.snackbar('خطأ', failure.message);
      },
          (response) {
        print('Fetched completed rates: ${response.length}');
        completedRates.assignAll(response);
      },
    );

    isLoading.value = false;
  }
  Future<void> rejectSession({
    required int sessionId,
    required String reason,
    void Function()? onSuccess,
    void Function(String message)? onError,
  }) async {
    final result = await instructorExercisesRepo.sessionsReject(reason, sessionId);

    result.fold(
          (failure) {
        error.value = failure.message;
        print('❌ Session Rejection Failed: ${failure.message}');
        if (onError != null) onError(failure.message);
      },
          (response) {
        print('✅ Session Rejected: $response');
        if (onSuccess != null) onSuccess();
        fetchRequests();
      },
    );
  }

}