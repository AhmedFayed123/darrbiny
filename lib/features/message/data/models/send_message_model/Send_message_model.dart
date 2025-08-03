class SendMessageModel {
  SendMessageModel({
      this.conversationId, 
      this.senderId, 
      this.message, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  SendMessageModel.fromJson(dynamic json) {
    conversationId = json['conversation_id'];
    senderId = json['sender_id'];
    message = json['message'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? conversationId;
  int? senderId;
  String? message;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['conversation_id'] = conversationId;
    map['sender_id'] = senderId;
    map['message'] = message;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}