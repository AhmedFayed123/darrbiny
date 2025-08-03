import 'Sender.dart';

class ConversationsModel {
  ConversationsModel({
      this.id, 
      this.conversationId, 
      this.senderId, 
      this.message, 
      this.isRead, 
      this.createdAt, 
      this.updatedAt, 
      this.sender,});

  ConversationsModel.fromJson(dynamic json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    senderId = json['sender_id'];
    message = json['message'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
  }
  int? id;
  int? conversationId;
  int? senderId;
  String? message;
  int? isRead;
  String? createdAt;
  String? updatedAt;
  Sender? sender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['conversation_id'] = conversationId;
    map['sender_id'] = senderId;
    map['message'] = message;
    map['is_read'] = isRead;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    return map;
  }

}