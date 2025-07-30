import 'package:darrbiny/core/constant/styles.dart';
import 'package:darrbiny/features/profile/presentation/views/wallet_view.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/confirmation_dialog.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/profile_image_widget.dart';
import 'package:darrbiny/features/profile/presentation/views/widgets/rewards_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/constant/colors.dart';
import '../../../../generated/assets.dart';
import '../controllers/learner_profile_controller.dart';
import 'bank_account.dart';
import 'edit_profile_view.dart';
import 'language_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final LearnerProfileController controller = Get.put(LearnerProfileController());

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
                  return Center(child: Text('Error: ${controller.error.value}'));
                }

                final profile = controller.learnerProfile.value;
                if (profile == null) {
                  return const Center(child: Text('لا توجد بيانات.'));
                }

                return Center(
                  child: ProfileImageWidget(
                    imageUrl: profile.profileImageUrl ?? Assets.imagesGirl,
                    profileName: profile.name ?? 'غير معروف',
                    profileEmail: profile.email ??profile.phone?? 'غير متوفر',
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
                        Get.to(EditProfileView());
                      },
                    ),
                    _profileSectionTile(
                      title: 'الحساب البنكي',
                      icon: Icons.attach_money,
                      onTap: (){
                        Get.to(BankAccount());
                      }
                    ),
                    _profileSectionTile(
                      title: 'مكافآتي',
                      icon: Icons.card_giftcard,
                      iconColor: kPositiveTrendColor,
                      onTap: (){
                        Get.to(RewardsView());
                      }
                    ),
                    _profileSectionTile(
                      title: 'المحفظة',
                      icon: Icons.account_balance_wallet,
                      iconColor: kSecondaryColor,
                      onTap: (){Get.to(WalletView());}
                    ),
                    _profileSectionTile(
                      title: 'حذف حسابي',
                      icon: Icons.delete_forever_outlined,
                      iconColor: Colors.red,
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmationDialog(
                            onConfirm: () {
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                            }, image: Assets.imagesTrash2, title: 'حذف الجساب', desc: 'هل انت متأكد انك تريد حذف الحساب',
                          ),
                        );
                      }
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
                    _supportSectionTile(
                      title: 'سياسة الخصوصية',
                      icon: Icons.lock,
                    ),
                    _supportSectionTile(title: 'FAQ', icon: Icons.help_outline),
                    _supportSectionTile(
                      title: 'تذاكر الدعم',
                      icon: Icons.support_agent,
                    ),
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
          builder: (_) => ConfirmationDialog(
            onConfirm: () {
              Get.back();
            },
            onCancel: () {
              Get.back();
            }, image: Assets.imagesLogout, title: 'تسجيل خروج!', desc: 'هل انت متأكد انك تريد تسجيل خروج؟',
          ),
        );      },
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
