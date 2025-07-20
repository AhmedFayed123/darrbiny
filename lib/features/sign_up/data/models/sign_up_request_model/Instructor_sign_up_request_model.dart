class InstructorSignUpRequestModel {
  InstructorSignUpRequestModel({
      this.idToken, 
      this.name, 
      this.phone, 
      this.password, 
      this.passwordConfirmation,});

  InstructorSignUpRequestModel.fromJson(dynamic json) {
    idToken = json['idToken'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }
  String? idToken;
  String? name;
  String? phone;
  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idToken'] = idToken;
    map['name'] = name;
    map['phone'] = phone;
    map['password'] = password;
    map['password_confirmation'] = passwordConfirmation;
    return map;
  }

}