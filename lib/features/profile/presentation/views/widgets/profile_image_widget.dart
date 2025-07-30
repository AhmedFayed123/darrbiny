import 'package:darrbiny/core/constant/colors.dart';
import 'package:darrbiny/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  final String profileName;
  final String profileEmail;
  final double size;

  const ProfileImageWidget({
    super.key,
    required this.imageUrl,
    this.size = 85.0,
    required this.profileName,
    required this.profileEmail,
  });

  bool _isNetworkImage(String url) {
    return url.startsWith('http') || url.startsWith('https');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: imageUrl.isNotEmpty
              ? (_isNetworkImage(imageUrl)
              ? NetworkImage(imageUrl)
              : AssetImage(imageUrl)) as ImageProvider
              : null,
          child: imageUrl.isEmpty
              ? Icon(Icons.person, size: size * 0.6, color: Colors.grey)
              : null,
        ),
        SizedBox(height: 8.h),
        Text(profileName, style: AppStyles.body20Regular),
        SizedBox(height: 8.h),
        Text(
          profileEmail,
          style: AppStyles.body16.copyWith(color: kSecondaryColor),
        ),
      ],
    );
  }
}
