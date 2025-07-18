
import 'package:darrbiny/features/home/presentation/views/widgets/search_bar_widget.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/time_line_steps.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/trainer_list.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/training_package_list.dart';
import 'package:darrbiny/features/home/presentation/views/widgets/video_thumbnail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/see_all_raw.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';
import '../../controller/home_controller/home_controller.dart';
import 'home_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key}) {
    Get.put(HomeController());
  }

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
              SearchBarWidget(),
              VideoThumbnailWidget(),
              CustomSeeAllRow(
                title: 'الباقات التدريبيه',
                allTitle: 'عرض المزيد',
                onPressed: () {},
                isSeeAll: true,
              ),
              const TrainingPackageList(),
              CustomSeeAllRow(
                title: 'ابرز المدربين',
                allTitle: 'شاهد الكل',
                onPressed: () {},
                isSeeAll: true,
              ),
              const TrainerList(),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.svgHelp),
                  SizedBox(height: 8.h),
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
