import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/constant/colors.dart';
import '../../../../generated/assets.dart';
import '../../../home/presentation/views/widgets/search_bar_widget.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  final List<Map<String, dynamic>> _messages = const [
    {
      'name': 'هاله غالي',
      'message': 'مرحباً هناك ، كيف الحال ؟',
      'time': 'ساعة',
      'image': Assets.imagesGirl,
      'unread': false,
      'online': true,
    },
    {
      'name': 'هيه محمد',
      'message': 'مرحباً هناك ، كيف الحال ؟',
      'time': 'ساعة',
      'image': Assets.imagesGirl,
      'unread': true,
      'online': true,
    },
    {
      'name': 'رغده علي',
      'message': 'مرحباً هناك ، كيف الحال ؟',
      'time': 'ساعة',
      'image': Assets.imagesGirl,
      'unread': true,
      'online': true,
    },
    {
      'name': 'ساره احمد',
      'message': 'مرحباً هناك ، كيف الحال ؟',
      'time': 'ساعة',
      'image': Assets.imagesGirl,
      'unread': true,
      'online': true,
    },
    {
      'name': 'دعاء احمد',
      'message': 'مرحباً هناك ، كيف الحال ؟',
      'time': 'ساعة',
      'image': Assets.imagesGirl,
      'unread': true,
      'online': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              const CustomAppBar(title: 'الرسائل'),
              const SearchBarWidget(),
              SizedBox(height: 12.h),
              Expanded(
                child: ListView.separated(
                  itemCount: _messages.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: _buildMessageItem(msg),
                      onDismissed: (direction) {
                        // هنا تقدر تحذف الرسالة من المصدر الفعلي
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> msg) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundImage: AssetImage(msg['image']),
              ),
              if (msg['online'])
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      msg['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    if (msg['unread']) ...[
                      SizedBox(width: 6.w),
                      Container(
                        width: 18.w,
                        height: 18.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 10.sp),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  msg['message'],
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                msg['time'],
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              SizedBox(height: 4.h),
              const Icon(Icons.done_all, size: 16, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
