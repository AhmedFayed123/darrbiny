import 'package:get/get.dart';
import 'package:darrbiny/features/message/data/models/conversations_model/Conversations_model.dart';
import 'package:darrbiny/features/message/data/models/send_message_model/Send_message_model.dart';
import 'package:darrbiny/features/message/data/models/start_conversation_model/Start_conversation_model.dart';
import 'package:darrbiny/features/message/data/repos/chat_repo.dart';
import '../../../../core/services/service_locator.dart';

class ChatController extends GetxController {
  final ChatRepo chatRepo = sl<ChatRepo>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var conversationsList = <ConversationsModel>[].obs;

  var isSending = false.obs;
  var sendError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getConversations();
  }

  Future<void> getConversations() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await chatRepo.getConversations();

    result.fold(
          (failure) => errorMessage.value = failure.message,
          (data) => conversationsList.assignAll(data),
    );

    isLoading.value = false;
  }

  Future<StartConversationModel?> startConversation(int otherUserId) async {
    isSending.value = true;
    sendError.value = '';

    final result = await chatRepo.startConversations(otherUserId);

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
}
