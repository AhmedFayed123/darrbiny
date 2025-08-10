import 'package:darrbiny/features/home/presentation/views/widgets/additional_details_field.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/car_training_option.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/date_picker_field.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/instructor_selector.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/location_selector.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/pickup_option.dart';
import 'package:darrbiny/features/payment/presentation/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../data/models/request_model/booking_request_model/Booking_request_model.dart';
import '../controller/home_controller/home_controller.dart';

class MoreDetailsView extends StatelessWidget {
  final int learnerId;
  final int packageId;
  final String totalPrice;
  final String packageName;

  const MoreDetailsView({
    super.key,
    required this.learnerId,
    required this.packageId,
    required this.totalPrice, required this.packageName,
  });

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationController());
    final dateController = Get.put(DatePickerController());
    final carController = Get.put(CarTrainingController());
    final pickupController = Get.put(PickupController());
    final instructorController = Get.put(InstructorController());
    final notesController = Get.put(AdditionalDetailsController());
    final homeController = Get.find<HomeController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              children: [
                CustomAppBar(title: 'تفاصيل الكورس'),
                SizedBox(height: 48.h),
                const DatePickerField(),
                SizedBox(height: 20.h),
                const LocationSelector(),
                SizedBox(height: 20.h),
                const CarTrainingOption(),
                SizedBox(height: 20.h),
                const PickupOption(),
                SizedBox(height: 20.h),
                const InstructorSelector(),
                SizedBox(height: 20.h),
                const AdditionalDetailsField(),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'استمرار',
                  onPressed: () async {
                    if (dateController.selectedDate.value == null) {
                      Get.snackbar(
                        "خطأ",
                        "الرجاء اختيار تاريخ البدء",
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: Colors.white,
                      );
                      return;
                    }

                    final request = BookingRequestModel(
                      learnerId: learnerId,
                      instructorId: instructorController.selectedInstructorId,
                      packageId: packageId,
                      startDate: dateController.formattedDate.value,
                      locationCity: locationController.cityController.value.text,
                      locationArea: locationController.areaController.value.text,
                      hasLearnerCar: carController.selectedOption.value == 'لدي سيارة',
                      requiresTransport: pickupController.selectedOption.value == 'نعم',
                      totalPrice: totalPrice,
                      type: instructorController.mode.value == 'اختيار مدربة' &&
                          instructorController.selectedInstructor.value.isNotEmpty
                          ? 'private'
                          : 'general',
                      notes: notesController.notesController.value.text,
                    );

                    homeController.tempBookingRequest = request;

                    String orderId = packageName + totalPrice + locationController.cityController.value.text;
                    Get.to(() => PaymentScreen(
                      amount: double.tryParse(totalPrice) ?? 0.0,
                      orderId: orderId,
                    ))?.then((success) {
                      if (success == false) {
                        homeController.tempBookingRequest = null;
                      }
                    });
                  },
                ),                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
