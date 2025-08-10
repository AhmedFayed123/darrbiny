import 'Data.dart';

class Notifications {
  Notifications({
      this.id, 
      this.type, 
      this.notifiableType, 
      this.notifiableId, 
      this.data, 
      this.readAt, 
      this.createdAt, 
      this.updatedAt,});

  Notifications.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  dynamic readAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['notifiable_type'] = notifiableType;
    map['notifiable_id'] = notifiableId;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['read_at'] = readAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}