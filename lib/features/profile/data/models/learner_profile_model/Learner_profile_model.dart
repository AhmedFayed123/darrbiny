class LearnerProfileModel {
  LearnerProfileModel({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.userType, 
      this.status, 
      this.profileImageUrl,});

  LearnerProfileModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['user_type'];
    status = json['status'];
    profileImageUrl = json['profile_image_url'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? userType;
  String? status;
  String? profileImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['user_type'] = userType;
    map['status'] = status;
    map['profile_image_url'] = profileImageUrl;
    return map;
  }

}