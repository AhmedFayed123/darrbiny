class BookingRequestModel {
  BookingRequestModel({
      this.learnerId, 
      this.instructorId, 
      this.packageId, 
      this.startDate, 
      this.locationCity, 
      this.locationArea, 
      this.hasLearnerCar, 
      this.requiresTransport, 
      this.totalPrice, 
      this.type, 
      this.notes,});

  BookingRequestModel.fromJson(dynamic json) {
    learnerId = json['learner_id'];
    instructorId = json['instructor_id'];
    packageId = json['package_id'];
    startDate = json['start_date'];
    locationCity = json['location_city'];
    locationArea = json['location_area'];
    hasLearnerCar = json['has_learner_car'];
    requiresTransport = json['requires_transport'];
    totalPrice = json['total_price'];
    type = json['type'];
    notes = json['notes'];
  }
  int? learnerId;
  int? instructorId;
  int? packageId;
  String? startDate;
  String? locationCity;
  String? locationArea;
  bool? hasLearnerCar;
  bool? requiresTransport;
  String? totalPrice;
  String? type;
  String? notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['learner_id'] = learnerId;
    map['instructor_id'] = instructorId;
    map['package_id'] = packageId;
    map['start_date'] = startDate;
    map['location_city'] = locationCity;
    map['location_area'] = locationArea;
    map['has_learner_car'] = hasLearnerCar;
    map['requires_transport'] = requiresTransport;
    map['total_price'] = totalPrice;
    map['type'] = type;
    map['notes'] = notes;
    return map;
  }

}