import 'dart:ui' show Locale;


import 'package:darrbiny/translations/app_translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/constant/colors.dart';
import 'core/constant/strings.dart';
import 'core/constant/styles.dart';
import 'core/network/dio_helper/dio_helper.dart';
import 'core/services/service_locator.dart';
import 'core/services/storage_service.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/onboarding/welcome_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // منع التدوير
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // خدماتك الحالية
  await ServiceLocator().init();
  await DioHelper.init();
  await GetStorage.init();
  await Firebase.initializeApp();
  // ●ــــــــ أضفنا خدمة التخزين واللغة المحفوظة ــــــــ●
  final storageService = Get.put(StorageService(), permanent: true);
  final savedLangCode = await storageService.getLanguage() ?? 'ar';

  runApp(MyApp(initialLangCode: savedLangCode));
}

/// Application entry‑point. The splash screen is generated natively via the
/// `flutter_native_splash` package, so no runtime splash widget is required.
class MyApp extends StatelessWidget {
  final String initialLangCode;

  const MyApp({super.key, required this.initialLangCode});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return FutureBuilder<bool>(
          future: OnboardingController.needsOnboarding(),
          // ← التحقق من أول تشغيل
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // شاشة تحميل مؤقتة
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            }

            final shouldShowOnboarding = snapshot.data!;
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appName,

              // ـــــــــــــــــــــ الثيم ـــــــــــــــــــــ
              theme: ThemeData(
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color(0xFFF4F4F4),
                ),
                scaffoldBackgroundColor: kBackgroundColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: Color(0xFFF4F4F4),
                  iconTheme: IconThemeData(color: kBlackColor),
                  titleTextStyle: AppStyles.textStyle16regular,
                ),
                fontFamily: Strings.kPoppins,
                useMaterial3: true,
              ),

              // ـــــــــــــــــــــ الترجمة ـــــــــــــــــــــ
              translations: AppTranslations(),
              locale: Locale(initialLangCode),
              // ← اللغة المحفوظة
              fallbackLocale: const Locale('ar'),

              // ــــــــــــــــ الشاشة الأولى ــــــــــــــــ
              home:
                  shouldShowOnboarding
                      ? OnboardingScreen(
                        onFinished: () => Get.offAll(const WelcomeView()),
                      )
                      : const WelcomeView(),
            );
          },
        );
      },
    );
  }
}
