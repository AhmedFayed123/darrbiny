import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/constant/styles.dart';

class BankAccount extends StatelessWidget {
  const BankAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'الحساب البنكي'),
              SizedBox(height: 32.h),

              _sectionTitle('الحساب البنكي'),
              _profileField(hint: 'ادخل الحساب البنكي'),
              _sectionTitle('رقم الايبان'),
              _profileField(
                hint: 'ادخل رقم الاييان',
              ),
              _sectionTitle('اسم البنك'),
              _profileField(hint: 'بنك فيصل الاسلامي'),
              _sectionTitle('اختر الدولة'),
              _profileField(hint: 'السعوديه',),
              Spacer(),
              CustomButton(text: 'ارسال', onPressed: () {}),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(title, style: AppStyles.textStyle14500),
    );
  }

  Widget _profileField({
    required String hint,
    bool isPassword = false,
    Color? textColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        style: TextStyle(color: textColor ?? Colors.black, fontSize: 14.sp),
      ),
    );
  }
}
