import 'package:darrbiny/features/message/data/models/conversations_model/Conversations_model.dart';
import 'package:darrbiny/features/message/data/models/send_message_model/Send_message_model.dart';
import 'package:darrbiny/features/message/data/models/start_conversation_model/Start_conversation_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/user_conversation/User_coversation.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<ConversationsModel>>> getConversations(int conversationId);
  Future<Either<Failure, List<UserConversation>>> getUserConversations();
  Future<Either<Failure, StartConversationModel>> startConversations(int otherUserId);
  Future<Either<Failure, SendMessageModel>> sendMessage(int conversationId,String message);

}