class Data {
  Data({
      this.message, 
      this.sender,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    sender = json['sender'];
  }
  String? message;
  String? sender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['sender'] = sender;
    return map;
  }

}