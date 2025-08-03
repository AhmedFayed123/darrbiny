import 'package:darrbiny/features/instructor_exercises/presentation/views/widgets/instructor_active_list.dart';
import 'package:darrbiny/features/instructor_exercises/presentation/views/widgets/instructor_completed_list.dart';
import 'package:darrbiny/features/instructor_exercises/presentation/views/widgets/instructor_new_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../exercises/presentation/views/exercises_view.dart';

class InstructorExercisesView extends StatelessWidget {
  const InstructorExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'الاشتراكات'),
                SizedBox(height: 24.h),
                CustomTabBar(tabText1: 'الجديدة', tabText2: 'النشطة', tabText3: 'المكتملة',),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 480.h,
                  child: TabBarView(
                    children: [
                      InstructorNewList(),
                      InstructorActiveList(),
                      InstructorCompletedList(),
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
