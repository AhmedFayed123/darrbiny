import 'Instructor.dart';

class Data {
  Data({
      this.id, 
      this.requestId, 
      this.instructorId, 
      this.learnerId, 
      this.date, 
      this.startTime, 
      this.endTime, 
      this.price, 
      this.status, 
      this.completedAt, 
      this.notes, 
      this.rejectionReason, 
      this.rate, 
      this.createdAt, 
      this.updatedAt, 
      this.instructor, 
      this.courseRequest,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    requestId = json['request_id'];
    instructorId = json['instructor_id'];
    learnerId = json['learner_id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
    status = json['status'];
    completedAt = json['completed_at'];
    notes = json['notes'];
    rejectionReason = json['rejection_reason'];
    rate = json['rate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    instructor = json['instructor'] != null ? Instructor.fromJson(json['instructor']) : null;
    courseRequest = json['course_request'];
  }
  int? id;
  int? requestId;
  int? instructorId;
  int? learnerId;
  String? date;
  String? startTime;
  String? endTime;
  String? price;
  String? status;
  String? completedAt;
  String? notes;
  dynamic rejectionReason;
  String? rate;
  String? createdAt;
  String? updatedAt;
  Instructor? instructor;
  dynamic courseRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['request_id'] = requestId;
    map['instructor_id'] = instructorId;
    map['learner_id'] = learnerId;
    map['date'] = date;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['price'] = price;
    map['status'] = status;
    map['completed_at'] = completedAt;
    map['notes'] = notes;
    map['rejection_reason'] = rejectionReason;
    map['rate'] = rate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (instructor != null) {
      map['instructor'] = instructor?.toJson();
    }
    map['course_request'] = courseRequest;
    return map;
  }

}