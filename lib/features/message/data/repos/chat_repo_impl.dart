import 'package:darrbiny/features/message/data/models/send_message_model/Send_message_model.dart';
import 'package:darrbiny/features/message/data/models/start_conversation_model/Start_conversation_model.dart';
import 'package:darrbiny/features/message/data/models/user_conversation/User_coversation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/server_failures.dart';
import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/storage_service.dart';
import '../models/conversations_model/Conversations_model.dart';
import 'chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  @override
  Future<Either<Failure, List<ConversationsModel>>> getConversations(int conversationId) async {
    try {

      final response = await DioHelper.getData(
        url: "${AppEndpoints.getChatMessages}/$conversationId",
      );

      final List<dynamic> rawList = response.data;
      final conversations =
          rawList.map((json) => ConversationsModel.fromJson(json)).toList();

      return right(conversations);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StartConversationModel>> startConversations(
    int otherUserId,
  ) async {
    try {
      final String? userId = await StorageService().getUserId();

      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.startChatMessages,
        data: {"user_id": userId, "other_user_id": otherUserId},
      );

      return right(StartConversationModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SendMessageModel>> sendMessage(
    int conversationId,
    String message,
  ) async {
    try {
      final String? userId = await StorageService().getUserId();

      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.chatMessage,
        data: {
          "conversation_id": conversationId,
          "sender_id": userId,
          "message": message,
        },
      );

      return right(SendMessageModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserConversation>>> getUserConversations()async {
    try {
      final String? userId = await StorageService().getUserId();

      final response = await DioHelper.getData(
        url: "${AppEndpoints.chatConversationUser}/$userId",
      );

      final List<dynamic> rawList = response.data;
      final conversations =
      rawList.map((json) => UserConversation.fromJson(json)).toList();

      return right(conversations);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


}
