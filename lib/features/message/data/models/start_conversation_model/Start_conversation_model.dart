class StartConversationModel {
  StartConversationModel({
      this.id, 
      this.userOneId, 
      this.userTwoId, 
      this.createdAt, 
      this.updatedAt,});

  StartConversationModel.fromJson(dynamic json) {
    id = json['id'];
    userOneId = json['user_one_id'];
    userTwoId = json['user_two_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userOneId;
  int? userTwoId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_one_id'] = userOneId;
    map['user_two_id'] = userTwoId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}