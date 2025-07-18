
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../generated/assets.dart';
import '../../../../home/presentation/views/home_view.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              CustomAppBar(title: 'تفاصيل الدفع'),
              SizedBox(height: 28.h),
              SvgPicture.asset(Assets.svgSuccess),
              SizedBox(height: 28.h),
              ConfirmationWidget(),
              Spacer(),
              CustomButton(text: 'العودة للرئيسيه', onPressed: (){Get.offAll(HomeView());}),
              SizedBox(height: 32,),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationWidget extends StatelessWidget {
  const ConfirmationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main confirmation message
          Text(
            'لقد أرسلنا إرسالة تأكيده بالبريد الإلكتروني',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),

          SizedBox(height: 20),

          // Date section
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                '26 - 10 - 2026',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Divider
          Divider(color: Colors.grey[300]),

          SizedBox(height: 10),

          // Footer with Driving Academy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الرئيسة',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Driving Academy',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}