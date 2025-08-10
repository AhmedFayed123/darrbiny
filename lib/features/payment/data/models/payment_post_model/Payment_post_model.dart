class PaymentPostModel {
  PaymentPostModel({
      this.success, 
      this.redirectUrl, 
      this.chargeId,});

  PaymentPostModel.fromJson(dynamic json) {
    success = json['success'];
    redirectUrl = json['redirect_url'];
    chargeId = json['charge_id'];
  }
  bool? success;
  String? redirectUrl;
  String? chargeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['redirect_url'] = redirectUrl;
    map['charge_id'] = chargeId;
    return map;
  }

}