import 'package:darrbiny/features/profile/presentation/views/widgets/instructor_edit_profile.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/wallet_view.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/confirmation_dialog.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/profile_image_widget.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/rewards_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/styles.dart';
import '../../../../generated/assets.dart';
import '../../../sign_up/presentation/views/sign_up_view.dart';
import '../controllers/instructor_profile_controller.dart';
import 'widgets/bank_account.dart';
import 'widgets/edit_profile_view.dart';
import 'widgets/language_view.dart';

class InstructorProfileView extends StatelessWidget {
  const InstructorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final InstructorProfileController controller = Get.put(
      InstructorProfileController(),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(title: 'الملف الشخصي'),
              SizedBox(height: 24.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.isNotEmpty) {
                  print('Error: ${controller.error.value}');
                  return Center(
                    child: Column(
                      children: [
                        Text('لا توجد بيانات.'),
                        SizedBox(height: 3.h,),
                        CustomButton(text: 'سجل الدخول', onPressed: () {Get.to(SignUpView(flag: 'instructor'));}),
                      ],
                    ),
                  );
                }

                final profile = controller.instructorProfile.value;
                if (profile == null) {
                  return Center(
                    child: Column(
                      children: [
                        Text('لا توجد بيانات.'),
                        SizedBox(height: 3.h,),
                        CustomButton(text: 'سجل الدخول', onPressed: () {Get.to(SignUpView(flag: 'instructor'));}),
                      ],
                    ),
                  );
                }

                return Center(
                  child: ProfileImageWidget(
                    imageUrl: profile.profileImageUrl ?? Assets.imagesGirl,
                    profileName: profile.name ?? 'غير معروف',
                    profileEmail: profile.email ?? profile.phone ?? 'غير متوفر',
                  ),
                );
              }),
              SizedBox(height: 24.h),

              _sectionTitle('حساب'),
              Container(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: Column(
                  children: [
                    _profileSectionTile(
                      title: 'حسابي',
                      icon: Icons.person,
                      iconColor: kPositiveTrendColor,
                      onTap: () {
                        Get.to(InstructorEditProfile());
                      },
                    ),
                    _profileSectionTile(
                      title: 'الدفع',
                      icon: Icons.attach_money,
                      onTap: () {
                        Get.to(BankAccount());
                      },
                    ),
                    _profileSectionTile(
                      title: 'المحفظة',
                      icon: Icons.account_balance_wallet,
                      iconColor: kSecondaryColor,
                      onTap: () {
                        Get.to(WalletView());
                      },
                    ),
                    _profileSectionTile(
                      title: 'مكافآتي',
                      icon: Icons.card_giftcard,
                      iconColor: kPositiveTrendColor,
                      onTap: () {
                        Get.to(RewardsView());
                      },
                    ),
                    _profileSectionTile(
                      title: 'حذف حسابي',
                      icon: Icons.delete_forever_outlined,
                      iconColor: Colors.red,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => ConfirmationDialog(
                            onConfirm: () {
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                            },
                            image: Assets.imagesTrash2,
                            title: 'حذف الجساب',
                            desc: 'هل انت متأكد انك تريد حذف الحساب',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              _sectionTitle('إعدادات التطبيق'),
              Container(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: Column(
                  children: [
                    _settingsSectionTile(
                      title: 'اللغة',
                      trailing: _languageChip(),
                    ),
                    _switchTile(title: 'الإشعارات', value: true),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              _sectionTitle('الدعم'),

              Container(
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: Column(
                  children: [
                    _supportSectionTile(
                      title: 'سياسة الاستخدام',
                      icon: Icons.description,
                    ),
                    _supportSectionTile(title: 'FAQ', icon: Icons.help_outline),

                    _supportSectionTile(title: 'تواصل معنا', icon: Icons.link),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              _logoutTile(context),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: AppStyles.body20Regular.copyWith(color: kSecondaryColor),
      ),
    );
  }

  Widget _profileSectionTile({
    required String title,
    required IconData icon,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor ?? kGray600),
      title: Text(title),
      trailing: const Icon(Icons.chevron_left),
      onTap: onTap,
    );
  }

  Widget _settingsSectionTile({
    required String title,
    required Widget trailing,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.language, color: kNeutralTrendColor),
      title: Text(title),
      trailing: trailing,
      onTap: () {
        Get.to(LanguageView());
      },
    );
  }

  Widget _switchTile({required String title, required bool value}) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      secondary: const Icon(Icons.notifications, color: kButtonSecondaryColor),
      value: value,
      onChanged: (val) {},
    );
  }

  Widget _supportSectionTile({required String title, required IconData icon}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_left),
      onTap: () {},
    );
  }

  Widget _logoutTile(BuildContext context) {
    return ListTile(
      tileColor: Colors.red.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text(
        'تسجيل خروج',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder:
              (_) => ConfirmationDialog(
            onConfirm: () {
              Get.back();
            },
            onCancel: () {
              Get.back();
            },
            image: Assets.imagesLogout,
            title: 'تسجيل خروج!',
            desc: 'هل انت متأكد انك تريد تسجيل خروج؟',
          ),
        );
      },
    );
  }

  Widget _languageChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('العربية'),
          SizedBox(width: 4),
          Icon(Icons.language, size: 18),
        ],
      ),
    );
  }
}
