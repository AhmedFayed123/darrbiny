import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';
import '../controller/chat_controller.dart';
import 'chat_details_view.dart';

class ChatStartView extends StatefulWidget {
  final int otherUserId;
  final String userName;

  const ChatStartView({
    super.key,
    required this.otherUserId,
    required this.userName,
  });

  @override
  State<ChatStartView> createState() => _ChatStartViewState();
}

class _ChatStartViewState extends State<ChatStartView> {
  final ChatController controller = Get.find();

  Future<void> _startConversation() async {
    final conversation = await controller.startConversation(widget.otherUserId);
    if (conversation != null) {
      Get.to(() => ChatDetailView(
        conversationId: conversation.id??0,
        userName: widget.userName,
      ));
    } else {
      Get.snackbar('خطأ', 'لم يتم بدء المحادثة');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: kSecondaryColor,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startConversation,
          style: ElevatedButton.styleFrom(
            backgroundColor: kSecondaryColor,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'ابدأ المحادثة',
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
