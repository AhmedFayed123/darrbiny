import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/constant/colors.dart';
import '../../../../generated/assets.dart';
import '../../../home/presentation/views/widgets/search_bar_widget.dart';
import '../../data/models/conversations_model/Conversations_model.dart';
import '../controller/chat_controller.dart';

class MessageView extends StatelessWidget {
  MessageView({super.key});

  final ChatController controller = Get.put(ChatController());

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
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  }

                  final messages = controller.conversationsList;

                  if (messages.isEmpty) {
                    return const Center(child: Text("لا توجد رسائل."));
                  }

                  return ListView.separated(
                    itemCount: messages.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final msg = messages[index];
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
                          controller.conversationsList.removeAt(index);
                          // مكن تبعت هنا API لحذف المحادثة
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageItem(ConversationsModel msg) {
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
                backgroundImage: AssetImage(Assets.imagesGirl),
              ),
              if (true) // ممكن تعدلها حسب الحالة الحقيقية للـ online
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
                    Expanded(
                      child: Text(
                        msg.sender?.name ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    if ((msg.isRead ?? 1) == 0)
                      Container(
                        width: 18.w,
                        height: 18.h,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 10.sp),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  msg.message ?? '',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                msg.createdAt?.substring(11, 16) ?? '',
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
