import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../core/constant/styles.dart';
import '../../core/constant/colors.dart';
import '../../core/services/storage_service.dart'; // ← استيراد الخدمة الموحدة

//============================================================
// GetX Controller يعتمد على StorageService
//============================================================
class OnboardingController extends GetxController {
  static const int pagesCount = 3;

  final introKey = GlobalKey<IntroductionScreenState>();
  final RxInt pageIndex = 0.obs;
  final StorageService _storage = StorageService();

  void onPageChanged(int idx) => pageIndex.value = idx;

  Future<void> nextOrFinish(VoidCallback finish) async {
    if (pageIndex.value == pagesCount - 1) {
      await _storage.setFirstLaunch(false);
      finish();
    } else {
      introKey.currentState?.next();
    }
  }

  Future<void> skipToHome(VoidCallback finish) async {
    await _storage.setFirstLaunch(false);
    finish();
  }

  static Future<bool> needsOnboarding() async => StorageService().isFirstLaunch();
}

//============================================================
// Onboarding Screen
//============================================================
class OnboardingScreen extends StatelessWidget {
  final VoidCallback onFinished;
  const OnboardingScreen({super.key, required this.onFinished});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      init: OnboardingController(),
      builder: (c) {
        return IntroductionScreen(
          key: c.introKey,
          globalBackgroundColor: kSecondaryColor,
          pages: _pages(c),
          onChange: c.onPageChanged,
          showNextButton: false,
          showSkipButton: false,
          showDoneButton: false,
          dotsDecorator: const DotsDecorator(
            size: Size.zero,
            activeSize: Size.zero,
            color: Colors.transparent,
            activeColor: Colors.transparent,
          ),
          globalFooter: Padding(
            padding: EdgeInsets.only(bottom: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => c.nextOrFinish(onFinished),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 66.w,
                        height: 66.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kPrimaryColor, width: 3),
                        ),
                      ),
                      Container(
                        width: 46.w,
                        height: 46.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        ),
                        child: const Icon(Icons.arrow_forward, size: 22, color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                GestureDetector(
                  onTap: () => c.skipToHome(onFinished),
                  child: Text('تخطى', style: AppStyles.body20),
                ),
              ],
            ),
          ),
          curve: Curves.easeInOut,
          controlsMargin: EdgeInsets.zero,
          controlsPadding: EdgeInsets.zero,
        );
      },
    );
  }

  //========================================================//
  // Pages + Custom Dots (داخل المحتوى)
  //========================================================//
  List<PageViewModel> _pages(OnboardingController c) => [
    _page(c, 'assets/images/onboarding1.png', 'ابدأ بعد',
        'دعم غير محدود لتحقيق حلمك في القيادة\nمعنا تصنع لحظاتٍ سعيدة بثقة وتمكين'),
    _page(c, 'assets/images/onboarding2.png', 'ابتسامتك في دليل نجاحنا',
        'مارسي دروس قيادة بكل سهولة\nاكتشفي متعة القيادة مع أفضل المدربات.'),
    _page(c, 'assets/images/onboarding3.png', 'دربني',
        'دروس قيادة مرنة وممتعة مصممة خصيصًا\nلتطلق ثقتك نحو استقلالك مع مدرباتٍ خبيرات.'),
  ];

  PageViewModel _page(OnboardingController c, String img, String title, String body) => PageViewModel(
    titleWidget: const SizedBox.shrink(),
    bodyWidget: _OnboardContent(controller: c, title: title, body: body),
    useScrollView: false,
    decoration: const PageDecoration(
      imagePadding: EdgeInsets.zero,
      contentMargin: EdgeInsets.zero,
      bodyFlex: 0,
      imageFlex: 3,
      pageColor: kSecondaryColor,
    ),
    image: _OnboardImage(imagePath: img),
  );
}

//============================================================
// Helper Widgets
//============================================================
class _OnboardImage extends StatelessWidget {
  final String imagePath;
  const _OnboardImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imagePath, fit: BoxFit.cover),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [kSecondaryColor.withOpacity(.99), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardContent extends StatelessWidget {
  final OnboardingController controller;
  final String title;
  final String body;
  const _OnboardContent({required this.controller, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              OnboardingController.pagesCount,
                  (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 8.h,
                width: controller.pageIndex.value == i ? 24.w : 8.w,
                decoration: BoxDecoration(
                  color: kWhiteColor.withOpacity(controller.pageIndex.value == i ? 1 : .4),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )),
          SizedBox(height: 32.h),
          Text(title, textAlign: TextAlign.center, style: AppStyles.headingStyle),
          SizedBox(height: 12.h),
          Text(body, textAlign: TextAlign.center, style: AppStyles.body20),
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}