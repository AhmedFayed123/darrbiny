import 'package:get/get.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../data/models/instructors_list_model/Instructors_list_model.dart';
import '../../../data/models/packages_list_model/Packages.dart';
import '../../../data/models/request_model/booking_model/Booking_model.dart';
import '../../../data/models/request_model/booking_request_model/Booking_request_model.dart';
import '../../../data/repos/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo = sl<HomeRepo>();

  // حالات التحميل
  var isLoading = false.obs;
  var isSubmittingRequest = false.obs;
  var isFetchingInstructors = false.obs;

  // البيانات
  var packagesList = <Packages>[].obs;
  var instructorsList = <InstructorModel>[].obs;
  var selectedPackage = Rxn<Packages>();

  // حالات الأخطاء
  var errorMessage = ''.obs;
  var submitError = ''.obs;

  // بيانات الحجز
  BookingRequestModel? tempBookingRequest;
  var submittedRequest = Rxn<BookingModel>();

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    await fetchPackagesList();
    await fetchInstructorsList();
  }

  Future<void> refreshData() async {
    errorMessage.value = '';
    await fetchPackagesList();
  }

  Future<void> fetchPackagesList() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await homeRepo.getPackagesList();

      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          print("❌ Error fetching packages: ${failure.message}");
        },
            (packagesModel) {
          packagesList.assignAll(packagesModel.packages ?? []);
          print("✅ Packages fetched (${packagesModel.packages?.length ?? 0} items)");
        },
      );
    } catch (e) {
      errorMessage.value = "حدث خطأ في تحميل الباقات: ${e.toString()}";
      print("Exception in fetchPackagesList: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchInstructorsList() async {
    if (isFetchingInstructors.value) return;

    try {
      isFetchingInstructors.value = true;

      final result = await homeRepo.getInstructorsList();

      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          print("❌ Error fetching instructors: ${failure.message}");
        },
            (list) {
          instructorsList.assignAll(list);
          print("✅ Instructors fetched (${list.length} items)");
        },
      );
    } catch (e) {
      errorMessage.value = "حدث خطأ في تحميل المدربين";
      print("Exception in fetchInstructorsList: $e");
    } finally {
      isFetchingInstructors.value = false;
    }
  }

  Future<void> fetchSinglePackage(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      selectedPackage.value = null;

      final result = await homeRepo.getSinglePackage(id);

      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          print("❌ Error fetching package $id: ${failure.message}");
        },
            (data) {
          selectedPackage.value = data.package;
          print("✅ Package ${data.package?.name} fetched");
        },
      );
    } catch (e) {
      errorMessage.value = "حدث خطأ في تحميل الباقة";
      print("Exception in fetchSinglePackage: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> submitRequest(BookingRequestModel request) async {
    try {
      isSubmittingRequest.value = true;
      submitError.value = '';

      print("📨 Submitting booking request: ${request.toJson()}");

      final result = await homeRepo.postRequest(request);

      var success = false;

      await result.fold(
            (failure) async {
          submitError.value = failure.message;
          print("❌ Failed to submit request: ${failure.message}");
          success = false;
        },
            (data) async {
          submittedRequest.value = data;
          print("✅ Booking submitted successfully (ID: ${data.data?.id})");
          success = true;
        },
      );

      return success;
    } catch (e, stack) {
      submitError.value = 'حدث خطأ غير متوقع في الحجز';
      print("Exception in submitRequest: $e");
      print("Stack trace: $stack");
      return false;
    } finally {
      isSubmittingRequest.value = false;
    }
  }

  void clearTempBooking() {
    tempBookingRequest = null;
    submittedRequest.value = null;
  }

  void resetErrors() {
    errorMessage.value = '';
    submitError.value = '';
  }
}