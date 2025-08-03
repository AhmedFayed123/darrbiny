import 'package:get/get.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../data/models/instructors_list_model/Instructors_list_model.dart';
import '../../../data/models/packages_list_model/Packages.dart';

import '../../../data/models/request_model/booking_model/Booking_model.dart';
import '../../../data/models/request_model/booking_request_model/Booking_request_model.dart';
import '../../../data/repos/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo = sl<HomeRepo>();

  var isLoading = false.obs;
  var packagesList = <Packages>[].obs;
  var instructorsList = <InstructorModel>[].obs;
  var selectedPackage = Rxn<Packages>();
  var errorMessage = ''.obs;

  var submittedRequest = Rxn<BookingModel>();

  @override
  void onInit() {
    super.onInit();
    fetchPackagesList();
    fetchInstructorsList();
  }

  Future<void> refreshData() async {
    errorMessage.value = '';
    await fetchPackagesList();
  }

  Future<void> fetchPackagesList() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final result = await homeRepo.getPackagesList();
      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          print("❌ Error fetching packages list: ${failure.message}");
        },
            (packagesModel) {
          packagesList.assignAll(packagesModel.packages ?? []);
          print("✅ Packages fetched: ${packagesModel.packages}");
        },
      );
    } catch (e) {
      errorMessage.value = "Error loading packages: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchInstructorsList() async {
    final result = await homeRepo.getInstructorsList();
    result.fold(
          (failure) {
        errorMessage.value = failure.message;
      },
          (list) {
        instructorsList.assignAll(list);
      },
    );
  }

  Future<void> fetchSinglePackage(int id) async {
    final result = await homeRepo.getSinglePackage(id);
    result.fold(
          (failure) {
        errorMessage.value = failure.message;
        selectedPackage.value = null;
      },
          (data) {
        selectedPackage.value = data.package;
        print("✅ Package fetched: ${data.package?.name}");
      },
    );
  }

  Future<void> submitRequest(BookingRequestModel requestRequest) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      print("Sending request: ${requestRequest.toJson()}");
      final result = await homeRepo.postRequest(requestRequest);
      print("Raw response: $result");

      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          print("❌ Failed to post request: ${failure.message}");
          print("Full failure details: $failure");
        },
            (data) {
          print("Response data: $data"); // Add this line
          submittedRequest.value = data;
          print("✅ Request submitted successfully: ${data.data!.id}");
        },
      );
    } catch (e, stack) {
      errorMessage.value = 'Exception: ${e.toString()}';
      print("Full exception: $e");
      print("Stack trace: $stack");
    } finally {
      isLoading.value = false;
    }
  }
}
