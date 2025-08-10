class PaymentRequestModel {
  PaymentRequestModel({
      this.amount, 
      this.currency, 
      this.orderId, 
      this.description, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone, 
      this.countryCode,});

  PaymentRequestModel.fromJson(dynamic json) {
    amount = json['amount'];
    currency = json['currency'];
    orderId = json['order_id'];
    description = json['description'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
  }
  double? amount;
  String? currency;
  String? orderId;
  String? description;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['currency'] = currency;
    map['order_id'] = orderId;
    map['description'] = description;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    return map;
  }

}