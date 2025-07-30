import 'User.dart';

class LearnersProfileUpdate {
  LearnersProfileUpdate({
      this.message, 
      this.user, 
      this.profileImageUrl,});

  LearnersProfileUpdate.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    profileImageUrl = json['profile_image_url'];
  }
  String? message;
  User? user;
  String? profileImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['profile_image_url'] = profileImageUrl;
    return map;
  }

}