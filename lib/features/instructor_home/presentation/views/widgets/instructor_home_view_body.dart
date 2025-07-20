import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/see_all_raw.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../home/presentation/views/widgets/home_app_bar.dart';
import '../../../../home/presentation/views/widgets/time_line_steps.dart';
import '../../../../home/presentation/views/widgets/video_thumbnail_widget.dart';
import '../../controller/instructor_home_controller.dart';
import 'instructor_training_course_card.dart';

class InstructorHomeViewBody extends StatelessWidget {
  const InstructorHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InstructorHomeController());

    return SafeArea(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final dataList = controller.homeData.value?.data ?? [];

        return SingleChildScrollView(
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = dataList[index];
                    return InstructorTrainingCourseCard(
                      trainerName: item.instructor?.name ?? 'غير معروف',
                      trainerImageUrl: Assets.imagesGirl,
                      rating: double.tryParse(item.instructor?.rate ?? '0') ?? 0.0,
                      fromDate: item.startDate ?? 'لم يحدد بعد',
                      toDate: '', // مش موجود عندك تواريخ انتهاء في الـ API
                      location: '${item.locationCity ?? ''} - ${item.locationArea ?? ''}',
                      trainerCar: item.hasLearnerCar == true ? 'نعم' : 'لا',
                      transportRequest: item.requiresTransport == true ? 'نعم' : 'لا',
                      price: int.tryParse(item.totalPrice?.split('.').first ?? '0') ?? 0,
                      duration: item.type ?? '',
                    )
                    ;
                  },
                ),
                SizedBox(height: 24.h),
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
        );
      }),
    );
  }
}
