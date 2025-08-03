import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../../core/components/widgets/custom_button.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../../translations/language_controller.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      builder: (controller) {
        String currentLang = Get.locale?.languageCode ?? 'ar';
        String selectedLang = currentLang;

        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(title: 'اللغة'),
                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0.h),
                        child: Text(
                          'اختر اللغة',
                          style: AppStyles.textStyle16regular.copyWith(color: kBlackColor),
                        ),
                      ),
                      _buildLangOption(
                        langCode: 'ar',
                        title: 'العربية',
                        flagPath: Assets.imagesIconAr,
                        selectedLang: selectedLang,
                        onChanged: (val) => setState(() => selectedLang = val),
                      ),
                      SizedBox(height: 12.h),
                      _buildLangOption(
                        langCode: 'en',
                        title: 'الانجليزية',
                        flagPath: Assets.imagesIconEn,
                        selectedLang: selectedLang,
                        onChanged: (val) => setState(() => selectedLang = val),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'حفظ',
                        onPressed: () {
                          if (selectedLang != currentLang) {
                            Get.updateLocale(Locale(selectedLang));
                            controller.setLanguage(selectedLang);
                          }
                        },
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLangOption({
    required String langCode,
    required String title,
    required String flagPath,
    required String selectedLang,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: selectedLang == langCode ? kSecondaryColor : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: RadioListTile<String>(
        value: langCode,
        groupValue: selectedLang,
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppStyles.textStyle14500),
            Image.asset(flagPath, width: 28.w, height: 28.h),
          ],
        ),
        activeColor: kSecondaryColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
    );
  }
}
