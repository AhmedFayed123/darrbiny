// قاعدة أساسية لنموذج الطلبات
import '../../../instructor_exercises/data/models/instructor_response_model/instructor_response_model.dart';

abstract class BaseLessonRequestsResponse {
  final List<LessonRequest> primaryRequests; // pending للطالب / new للمعلم
  final List<LessonRequest> activeRequests;
  final List<LessonRequest> completedRequests;

  BaseLessonRequestsResponse({
    required this.primaryRequests,
    required this.activeRequests,
    required this.completedRequests,
  });
}

// نموذج خاص بالطالب
class LearnerLessonRequestsResponse extends BaseLessonRequestsResponse {
  LearnerLessonRequestsResponse({
    required List<LessonRequest> pendingRequests,
    required super.activeRequests,
    required super.completedRequests,
  }) : super(
    primaryRequests: pendingRequests,
  );

  factory LearnerLessonRequestsResponse.fromJson(Map<String, dynamic> json) {
    return LearnerLessonRequestsResponse(
      pendingRequests: (json['pending'] as List? ?? [])
          .map((i) => LessonRequest.fromJson(i))
          .toList(),
      activeRequests: (json['active'] as List? ?? [])
          .map((i) => LessonRequest.fromJson(i))
          .toList(),
      completedRequests: (json['completed'] as List? ?? [])
          .map((i) => LessonRequest.fromJson(i))
          .toList(),
    );
  }
}

