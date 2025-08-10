import 'package:darrbiny/core/constant/styles.dart';
import 'package:darrbiny/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../home/presentation/controller/home_controller/home_controller.dart';
import '../../../data/models/charge_model/charge_model.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final ChargeModel chargeModel;

  const PaymentSuccessScreen({super.key, required this.chargeModel});


  @override
  Widget build(BuildContext context) {
    final data = chargeModel.data;
    final homeController = Get.find<HomeController>();

    return Obx(() {
      // حالة التحميل أثناء إرسال طلب الحجز
      if (homeController.isSubmittingRequest.value) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('جاري تأكيد الحجز...'),
              ],
            ),
          ),
        );
      }

      // حالة الخطأ في إرسال طلب الحجز
      if (homeController.submitError.isNotEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: Text('خطأ في الحجز', style: AppStyles.textStyle14500),
            backgroundColor: Colors.red,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    homeController.submitError.value,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      homeController.submitError.value = '';
                      if (homeController.tempBookingRequest != null) {
                        homeController.submitRequest(
                          homeController.tempBookingRequest!,
                        );
                      }
                    },
                    child: const Text(
                      "إعادة المحاولة",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      // حالة عدم وجود بيانات الدفع
      if (data == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text("خطأ في الدفع", style: AppStyles.textStyle14500),
            backgroundColor: Colors.red,
          ),
          body: const Center(
            child: Text(
              "لا توجد بيانات دفع متاحة",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        );
      }

      // إرسال طلب الحجز إذا كان موجودًا ولم يتم إرساله بعد
      if (homeController.tempBookingRequest != null) {
        homeController.submitRequest(homeController.tempBookingRequest!);
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('جاري تأكيد الحجز...'),
              ],
            ),
          ),
        );
      }

      // عرض شاشة النجاح بعد تأكيد الحجز
      String formattedDate = '';
      if (data.transaction?.date?.completed != null) {
        formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(
          DateTime.fromMillisecondsSinceEpoch(
            data.transaction!.date!.completed!,
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "تمت العملية بنجاح",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 80,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "رقم العملية: ${data.id ?? ''}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "رقم الطلب: ${data.metadata?.orderId ?? ''}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "المبلغ: ${data.amount} ${data.currency}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "الحالة: ${data.status ?? ''}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "طريقة الدفع: ${data.card?.brand ?? ''} (${data.card?.scheme ?? ''})",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "التاريخ: $formattedDate",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "تم تأكيد حجزك بنجاح",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.offAll(() => HomeView());
                },
                child: const Text(
                  "العودة للصفحة الرئيسية",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    });

  }

}
