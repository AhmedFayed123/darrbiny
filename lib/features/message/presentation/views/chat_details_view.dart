import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';

import '../../../../core/services/storage_service.dart';
import '../controller/chat_controller.dart';

class ChatDetailView extends StatefulWidget {
  final int conversationId;
  final String userName;

  const ChatDetailView({
    super.key,
    required this.conversationId,
    required this.userName,
  });

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final ChatController controller = Get.find();
  final TextEditingController messageController = TextEditingController();
  final currentUserId = StorageService().getUserId();

  @override
  void initState() {
    super.initState();
    controller.getConversations(widget.conversationId);

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));
      if (!mounted) return false;
      await controller.getConversations(widget.conversationId);
      return true;
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: kSecondaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                final messages = controller.conversationsList;
                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.all(16.w),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - 1 - index];
                    final isMine = message.senderId == currentUserId;

                    return Align(
                      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        padding: EdgeInsets.all(12.w),
                        constraints: BoxConstraints(maxWidth: 250.w),
                        decoration: BoxDecoration(
                          color: isMine ? kSecondaryColor : Colors.grey.shade200,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                            bottomLeft: isMine ? Radius.circular(12.r) : Radius.zero,
                            bottomRight: isMine ? Radius.zero : Radius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          message.message ?? '',
                          style: TextStyle(
                            color: isMine ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              final messages = controller.conversationsList;
              return ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(16.w),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - 1 - index];
                  final isMine = message.senderId == currentUserId;

                  return Align(
                    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      padding: EdgeInsets.all(12.w),
                      constraints: BoxConstraints(maxWidth: 250.w),
                      decoration: BoxDecoration(
                        color: isMine ? kSecondaryColor : Colors.grey.shade200,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                          bottomLeft: isMine ? Radius.circular(12.r) : Radius.zero,
                          bottomRight: isMine ? Radius.zero : Radius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        message.message ?? '',
                        style: TextStyle(
                          color: isMine ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Obx(() => controller.isSending.value
                    ? const CircularProgressIndicator()
                    : IconButton(
                  icon: Icon(Icons.send, color: kSecondaryColor),
                  onPressed: () async {
                    final text = messageController.text.trim();
                    if (text.isNotEmpty) {
                      final sent = await controller.sendMessage(
                        conversationId: widget.conversationId,
                        message: text,
                      );
                      messageController.clear();
                      if (sent != null) {
                        controller.getConversations(widget.conversationId);
                        messageController.clear();
                      }
                    }
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
