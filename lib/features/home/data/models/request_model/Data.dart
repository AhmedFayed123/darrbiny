class Data {
  Data({
      this.learnerId, 
      this.instructorId, 
      this.packageId, 
      this.locationCity, 
      this.locationArea, 
      this.hasLearnerCar, 
      this.requiresTransport, 
      this.totalPrice, 
      this.type, 
      this.notes, 
      this.status, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Data.fromJson(dynamic json) {
    learnerId = json['learner_id'];
    instructorId = json['instructor_id'];
    packageId = json['package_id'];
    locationCity = json['location_city'];
    locationArea = json['location_area'];
    hasLearnerCar = json['has_learner_car'];
    requiresTransport = json['requires_transport'];
    totalPrice = json['total_price'];
    type = json['type'];
    notes = json['notes'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? learnerId;
  dynamic instructorId;
  int? packageId;
  String? locationCity;
  String? locationArea;
  bool? hasLearnerCar;
  bool? requiresTransport;
  int? totalPrice;
  String? type;
  String? notes;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['learner_id'] = learnerId;
    map['instructor_id'] = instructorId;
    map['package_id'] = packageId;
    map['location_city'] = locationCity;
    map['location_area'] = locationArea;
    map['has_learner_car'] = hasLearnerCar;
    map['requires_transport'] = requiresTransport;
    map['total_price'] = totalPrice;
    map['type'] = type;
    map['notes'] = notes;
    map['status'] = status;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}