import 'package:darrbiny/features/exercises/presentation/views/widgets/active_course_card.dart';
import 'package:darrbiny/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/widgets/custom_app_bar.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'الاشتراكات'),
                SizedBox(height: 24.h),
                _CustomTabBar(),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 300.h,
                  child: TabBarView(
                    children: [
                      ActiveCourseCard(duration: '5 ايام ( 10 ساعات', learnerImageUrl: Assets.imagesGirl, learnerName: 'ساره احمد', rating: 3, date: '24 \\ 12 \\ 2025', price: 1000, time: '10 صباحاً',),
                      Center(child: Text('بالانتظار')),
                      Center(child: Text('المكتملة')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        tabBarTheme: const TabBarTheme(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
      ),
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: const Color(0xffF9F9F9),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: TabBar(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          labelPadding: EdgeInsets.zero,
          indicator: BoxDecoration(
            color: const Color(0xffE5DBF9),
            borderRadius: BorderRadius.circular(28.r),
          ),
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelColor: Colors.black,
          unselectedLabelColor: const Color(0xFF9B9B9B),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'نشطة'),
            Tab(text: 'بالانتظار العروض'),
            Tab(text: 'المكتملة'),
          ],
        ),
      ),
    );
  }
}
