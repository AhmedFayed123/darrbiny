//
// import 'package:darrbiny/features/payment/presentation/views/widgets/payment_options_list.dart';
// import 'package:darrbiny/features/payment/presentation/views/widgets/payment_success_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/components/widgets/custom_app_bar.dart';
// import '../../../../core/components/widgets/custom_button.dart';
//
// class PaymentOptionsView extends StatelessWidget {
//   const PaymentOptionsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//           child: Column(
//             children: [
//               CustomAppBar(title: 'تفاصيل الدفع'),
//               const SizedBox(height: 16),
//               const VisaCardList(), // بدون تغيير
//               const Spacer(),
//               CustomButton(text: 'استمرار', onPressed: () {Get.to(SuccessView());}),
//               SizedBox(height: 32.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
