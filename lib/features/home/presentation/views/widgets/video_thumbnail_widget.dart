// video_thumbnail_widget.dart
import 'package:darrbiny/features/home/presentation/views/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';

class VideoThumbnailWidget extends StatelessWidget {
  const VideoThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const VideoPlayerScreen()),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 180.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8C8BFF), Color(0xFF9EE3FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),

            Positioned(
              bottom: -30,
              left: 0,
              child: Image.asset(
                Assets.imagesGirl,
                height: 195.h,
                fit: BoxFit.contain,
              ),
            ),

            Positioned(
              left: 16.w,
              top: 16.h,
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 28),
              ),
            ),

            Positioned(
              right: 16.w,
              top: 56.h,
              child: Text(
                'كيف تستخدم\nتطبيق دِرْبني',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right,
              ),
            ),

            Positioned(
              bottom: 12.h,
              left: 16.w,
              right: 16.w,
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
