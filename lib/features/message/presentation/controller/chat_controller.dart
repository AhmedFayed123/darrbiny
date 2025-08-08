import 'dart:async';
import 'package:get/get.dart';
import 'package:darrbiny/features/message/data/models/conversations_model/Conversations_model.dart';
import 'package:darrbiny/features/message/data/models/send_message_model/Send_message_model.dart';
import 'package:darrbiny/features/message/data/models/start_conversation_model/Start_conversation_model.dart';
import 'package:darrbiny/features/message/data/models/user_conversation/User_coversation.dart';
import 'package:darrbiny/features/message/data/repos/chat_repo.dart';
import '../../../../core/services/service_locator.dart';

class ChatController extends GetxController {
  final ChatRepo chatRepo = sl<ChatRepo>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var conversationsList = <ConversationsModel>[].obs;

  var isSending = false.obs;
  var sendError = ''.obs;

  var userConversationsList = <UserConversation>[].obs;
  var userConversationsError = ''.obs;
  var isUserConversationsLoading = false.obs;

  Timer? _autoRefreshTimer;

  Future<void> getConversations(int conversationId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await chatRepo.getConversations(conversationId);

    result.fold(
          (failure) => errorMessage.value = failure.message,
          (data) => conversationsList.assignAll(data),
    );

    isLoading.value = false;
  }

  Future<StartConversationModel?> startConversation(int otherUserId) async {
    isSending.value = true;
    sendError.value = '';
    print("🔁 Starting conversation with $otherUserId");

    final result = await chatRepo.startConversations(otherUserId);

    return result.fold(
          (failure) {
        sendError.value = failure.message;
        isSending.value = false;
        print("❌ startConversation failed: ${failure.message}");
        return null;
      },
          (data) {
        isSending.value = false;
        print("✅ Conversation started with ID: ${data.id}");
        return data;
      },
    );
  }


  Future<SendMessageModel?> sendMessage({
    required int conversationId,
    required String message,
  }) async {
    isSending.value = true;
    sendError.value = '';

    final result = await chatRepo.sendMessage(conversationId, message);

    return result.fold(
          (failure) {
        sendError.value = failure.message;
        isSending.value = false;
        return null;
      },
          (data) {
        isSending.value = false;
        return data;
      },
    );
  }

  Future<void> getUserConversations() async {
    isUserConversationsLoading.value = true;
    userConversationsError.value = '';

    final result = await chatRepo.getUserConversations();

    result.fold(
          (failure) => userConversationsError.value = failure.message,
          (data) => userConversationsList.assignAll(data),
    );

    isUserConversationsLoading.value = false;
  }

  void startAutoRefresh() {
    _autoRefreshTimer?.cancel(); // Cancel any existing timer
    _autoRefreshTimer = Timer.periodic(Duration(seconds: 20), (_) {
      getUserConversations();
    });
  }

  void stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    getUserConversations();
    startAutoRefresh();
  }

  @override
  void onClose() {
    stopAutoRefresh();
    super.onClose();
  }
}
