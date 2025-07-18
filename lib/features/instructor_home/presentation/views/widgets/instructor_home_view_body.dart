import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/components/widgets/see_all_raw.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../home/presentation/views/widgets/home_app_bar.dart';
import '../../../../home/presentation/views/widgets/search_bar_widget.dart';
import '../../../../home/presentation/views/widgets/time_line_steps.dart';
import '../../../../home/presentation/views/widgets/video_thumbnail_widget.dart';
import 'instructor_training_course_card.dart';

class InstructorHomeViewBody extends StatelessWidget {
  const InstructorHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(),
              SizedBox(height: 12.h),
              VideoThumbnailWidget(),
              CustomSeeAllRow(
                title: 'الطلبات الجديدة',
                allTitle: 'عرض المزيد',
                onPressed: () {},
                isSeeAll: true,
              ),
              InstructorTrainingCourseCard(
                trainerName: "ساره احمد",
                trainerImageUrl: "https://i.imgur.com/your_image.jpg",
                rating: 5,
                fromDate: "24 يناير",
                toDate: "30 يناير",
                location: "مدينة الرياض، الحي الاول",
                trainerCar: "سيارة المدربه",
                transportRequest: "اخذ وارجاع",
                price: 1000,
                duration: "5 أيام ( 10 ساعات )",
              ),

              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.svgHelp),
                  SizedBox(width: 8.h),
                  Text(
                    'كيف نعمل',
                    style: AppStyles.labelStyle.copyWith(color: kBlackColor),
                  ),
                ],
              ),
              TimelineSteps(),
            ],
          ),
        ),
      ),
    );
  }
}
