import 'package:darrbiny/features/exercises/presentation/views/widgets/accepted_exercises_list.dart';
import 'package:darrbiny/features/exercises/presentation/views/widgets/completed_list.dart';
import 'package:darrbiny/features/exercises/presentation/views/widgets/pending_exercises_list.dart';
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
                CustomTabBar(tabText1: 'نشطة', tabText2: 'بالنتظار العروض', tabText3: 'المكتملة',),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 490.h,
                  child: TabBarView(
                    children: [
                      AcceptedExercisesList(),
                      PendingExercisesList(),
                      CompletedList(),
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

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.tabText1, required this.tabText2, required this.tabText3});

  final String tabText1;
  final String tabText2;
  final String tabText3;
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
          tabs:  [
            Tab(text: tabText1),
            Tab(text: tabText2),
            Tab(text: tabText3),
          ],
        ),
      ),
    );
  }
}
