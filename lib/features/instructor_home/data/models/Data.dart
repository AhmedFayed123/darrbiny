import 'Instructor.dart';

class Data {
  Data({
      this.id, 
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
      this.status, 
      this.notes, 
      this.rejectionReason, 
      this.createdAt, 
      this.updatedAt, 
      this.instructor,});

  Data.fromJson(dynamic json) {
    id = json['id'];
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
    status = json['status'];
    notes = json['notes'];
    rejectionReason = json['rejection_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    instructor = json['instructor'] != null ? Instructor.fromJson(json['instructor']) : null;
  }
  int? id;
  int? learnerId;
  int? instructorId;
  int? packageId;
  dynamic startDate;
  String? locationCity;
  String? locationArea;
  bool? hasLearnerCar;
  bool? requiresTransport;
  String? totalPrice;
  String? type;
  String? status;
  String? notes;
  dynamic rejectionReason;
  String? createdAt;
  String? updatedAt;
  Instructor? instructor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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
    map['status'] = status;
    map['notes'] = notes;
    map['rejection_reason'] = rejectionReason;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (instructor != null) {
      map['instructor'] = instructor?.toJson();
    }
    return map;
  }

}