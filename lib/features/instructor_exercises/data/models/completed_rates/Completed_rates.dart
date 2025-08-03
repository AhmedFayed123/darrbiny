import 'Learner.dart';

class CompletedRates {
  CompletedRates({
      this.id, 
      this.learnerId, 
      this.rating, 
      this.comment, 
      this.createdAt, 
      this.learner,});

  CompletedRates.fromJson(dynamic json) {
    id = json['id'];
    learnerId = json['learner_id'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
    learner = json['learner'] != null ? Learner.fromJson(json['learner']) : null;
  }
  int? id;
  int? learnerId;
  String? rating;
  String? comment;
  String? createdAt;
  Learner? learner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['learner_id'] = learnerId;
    map['rating'] = rating;
    map['comment'] = comment;
    map['created_at'] = createdAt;
    if (learner != null) {
      map['learner'] = learner?.toJson();
    }
    return map;
  }

}