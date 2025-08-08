class Instructor {
  Instructor({
      this.id, 
      this.firebaseUid, 
      this.name, 
      this.email, 
      this.emailVerifiedAt, 
      this.phoneVerifiedAt, 
      this.phone, 
      this.userType, 
      this.licenseNumber, 
      this.experienceYears, 
      this.bio, 
      this.status, 
      this.rate, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt,});

  Instructor.fromJson(dynamic json) {
    id = json['id'];
    firebaseUid = json['firebase_uid'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    phone = json['phone'];
    userType = json['user_type'];
    licenseNumber = json['license_number'];
    experienceYears = json['experience_years'];
    bio = json['bio'];
    status = json['status'];
    rate = json['rate'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  dynamic firebaseUid;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  String? phone;
  String? userType;
  String? licenseNumber;
  int? experienceYears;
  String? bio;
  String? status;
  String? rate;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firebase_uid'] = firebaseUid;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['phone_verified_at'] = phoneVerifiedAt;
    map['phone'] = phone;
    map['user_type'] = userType;
    map['license_number'] = licenseNumber;
    map['experience_years'] = experienceYears;
    map['bio'] = bio;
    map['status'] = status;
    map['rate'] = rate;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}