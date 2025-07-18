class InstructorModel {
  InstructorModel({
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
    this.updatedAt,
  });

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

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'],
      firebaseUid: json['firebase_uid'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      phoneVerifiedAt: json['phone_verified_at'],
      phone: json['phone'],
      userType: json['user_type'],
      licenseNumber: json['license_number'],
      experienceYears: json['experience_years'],
      bio: json['bio'],
      status: json['status'],
      rate: json['rate'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firebase_uid': firebaseUid,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone_verified_at': phoneVerifiedAt,
      'phone': phone,
      'user_type': userType,
      'license_number': licenseNumber,
      'experience_years': experienceYears,
      'bio': bio,
      'status': status,
      'rate': rate,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
