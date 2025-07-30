import 'package:darrbiny/core/components/widgets/custom_button.dart';
import 'package:darrbiny/core/constant/colors.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/balance_card.dart';
import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/constant/styles.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'المحفظة'),
              SizedBox(height: 32.h),
              BalanceCard(balance: 22.2),
              SizedBox(height: 32.h),
              _sectionTitle('السحب النقدي'),
              _profileField(hint: 'اكتب المبلغ'),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 24.0.h),
                child: Text('ادخل بيانات حسابك البنكي',style: AppStyles.textStyle16regular.copyWith(color: kBlackColor),),
              ),
              _sectionTitle('اسم صاحب الحساب'),
              _profileField(hint: 'اكتب الاسم'),
              _sectionTitle('رقم الايبان'),
              _profileField(hint: 'ادخل رقم الاييان'),
              _sectionTitle('اسم البنك'),
              _profileField(hint: 'بنك فيصل الاسلامي'),
              _sectionTitle('اختر الدولة'),
              _profileField(hint: 'السعوديه'),
              SizedBox(height: 24.h,),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 24.0.h),
                child: Text('اخر المعاملات',style: AppStyles.textStyle16regular.copyWith(color: kBlackColor),),
              ),
              TransactionItem(
                amount: '740',
                status: 'ناجحة',
                statusColor: Colors.green,
                description: 'تم التحويل إلى ****6763',
                date: '٤ أغسطس',
                time: '20:31',
              ),
              TransactionItem(
                amount: '740',
                status: 'قيد المراجعة',
                statusColor: Colors.orange,
                description: 'طلبك قيد المراجعة من قبل جود بلس',
                date: '٤ أغسطس',
                time: '20:31',
              ),
              TransactionItem(
                amount: '740',
                status: 'مرفوضة',
                statusColor: Colors.red,
                description: 'هناك خطأ في بياناتك',
                date: '٤ أغسطس',
                time: '20:31',
              ),
              SizedBox(height: 24.h,),
              CustomButton(text: 'تاكيد', onPressed: (){}),
              SizedBox(height: 24.h,),
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
