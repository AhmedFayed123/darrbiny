import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_app_bar.dart';
import '../../../../core/constant/colors.dart';
import '../../../../generated/assets.dart';
import '../../../home/presentation/views/widgets/search_bar_widget.dart';
import '../../data/models/user_conversation/UserOne.dart';
import '../../data/models/user_conversation/UserTwo.dart';
import '../../data/models/user_conversation/User_coversation.dart';
import '../controller/chat_controller.dart';
import 'chat_details_view.dart';


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
              // const SearchBarWidget(),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => controller.getUserConversations(),
                  icon: Icon(Icons.refresh),
                  label: Text("تحديث"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(() {
                  if (controller.isUserConversationsLoading.value) {
                    final conversations = controller.userConversationsList;
                    return ListView.separated(
                      itemCount: conversations.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
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
                          onDismissed: (direction) {
                            controller.userConversationsList.removeAt(index);
                            // لو عايز كمان تحذف من السيرفر، ضيف هنا كود الحذف
                          },
                          child: InkWell(
                            onTap: () async {
                              await Get.to(() => ChatDetailView(
                                conversationId: conversation.id!,
                                userName: conversation.userTwo?.name ?? '',
                              ));
                              // بعد الرجوع من صفحة الشات، نعمل تحديث
                              controller.getUserConversations();
                            },
                            child: _buildMessageItem(conversation),
                          ),
                        );
                      },
                    );
                  }

                  if (controller.userConversationsError.isNotEmpty) {
                    return Center(child: Text(controller.userConversationsError.value));
                  }

                  final conversations = controller.userConversationsList;

                  if (conversations.isEmpty) {
                    return const Center(child: Text("لا توجد محادثات."));
                  }

                  return ListView.separated(
                    itemCount: conversations.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
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
                        onDismissed: (direction) {
                          controller.userConversationsList.removeAt(index);
                          // لو عايز كمان تحذف من السيرفر، ضيف هنا كود الحذف
                        },
                        child: InkWell(
                          onTap: () async {
                            await Get.to(() => ChatDetailView(
                              conversationId: conversation.id!,
                              userName: conversation.userTwo?.name ?? '',
                            ));
                            // بعد الرجوع من صفحة الشات، نعمل تحديث
                            controller.getUserConversations();
                          },
                          child: _buildMessageItem(conversation),
                        ),
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

  Widget _buildMessageItem(UserConversation conversation) {
    dynamic userDynamic = conversation.userTwo ?? conversation.userOne;

    String userName = '';
    if (userDynamic is UserOne) {
      userName = userDynamic.name ?? 'اسم غير معروف';
    } else if (userDynamic is UserTwo) {
      userName = userDynamic.name ?? 'اسم غير معروف';
    } else {
      userName = 'اسم غير معروف';
    }

    final lastMessage = (conversation.messages?.isNotEmpty ?? false)
        ? conversation.messages!.last
        : null;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundImage: AssetImage(Assets.imagesGirl),
              ),
              Positioned(
                bottom: 2,
                right: 2,
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
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      lastMessage?.createdAt?.substring(11, 16) ?? '',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage?.message ?? '',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if ((lastMessage?.isRead ?? 1) == 0)
                      Container(
                        margin: EdgeInsets.only(left: 6.w),
                        width: 18.w,
                        height: 18.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
