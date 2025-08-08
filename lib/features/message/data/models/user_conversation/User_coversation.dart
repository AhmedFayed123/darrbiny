import 'UserOne.dart';
import 'UserTwo.dart';
import 'Messages.dart';

class UserConversation {
  UserConversation({
      this.id, 
      this.userOneId, 
      this.userTwoId, 
      this.createdAt, 
      this.updatedAt, 
      this.userOne, 
      this.userTwo, 
      this.messages,});

  UserConversation.fromJson(dynamic json) {
    id = json['id'];
    userOneId = json['user_one_id'];
    userTwoId = json['user_two_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userOne = json['user_one'] != null ? UserOne.fromJson(json['user_one']) : null;
    userTwo = json['user_two'] != null ? UserTwo.fromJson(json['user_two']) : null;
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }
  int? id;
  int? userOneId;
  int? userTwoId;
  String? createdAt;
  String? updatedAt;
  UserOne? userOne;
  UserTwo? userTwo;
  List<Messages>? messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_one_id'] = userOneId;
    map['user_two_id'] = userTwoId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (userOne != null) {
      map['user_one'] = userOne?.toJson();
    }
    if (userTwo != null) {
      map['user_two'] = userTwo?.toJson();
    }
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}