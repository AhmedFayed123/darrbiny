import '../../../../exercises/data/models/learner_lesson_requests_response.dart';

class User {
  final int id;
  final String? firebaseUid;
  final String name;
  final String? email;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final String phone;
  final String userType;
  final String? licenseNumber;
  final int? experienceYears;
  final String? bio;
  final String status;
  final String rate;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    this.firebaseUid,
    required this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.phone,
    required this.userType,
    this.licenseNumber,
    this.experienceYears,
    this.bio,
    required this.status,
    required this.rate,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
}

class Package {
  final int id;
  final String name;
  final String description;
  final int daysCount;
  final int hoursCount;
  final String price;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  Package({
    required this.id,
    required this.name,
    required this.description,
    required this.daysCount,
    required this.hoursCount,
    required this.price,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      daysCount: json['days_count'],
      hoursCount: json['hours_count'],
      price: json['price'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Session {
  final int id;
  final int requestId;
  final int instructorId;
  final int learnerId;
  final String date;
  final String startTime;
  final String endTime;
  final String price;
  final String status;
  final String? completedAt;
  final String? notes;
  final String? rejectionReason;
  final String rate;
  final String createdAt;
  final String updatedAt;

  Session({
    required this.id,
    required this.requestId,
    required this.instructorId,
    required this.learnerId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.status,
    this.completedAt,
    this.notes,
    this.rejectionReason,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      requestId: json['request_id'],
      instructorId: json['instructor_id'],
      learnerId: json['learner_id'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      price: json['price'],
      status: json['status'],
      completedAt: json['completed_at'],
      notes: json['notes'],
      rejectionReason: json['rejection_reason'],
      rate: json['rate'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class LessonRequest {
  final int id;
  final int learnerId;
  final int? instructorId;
  final int packageId;
  final String? startDate;
  final String locationCity;
  final String locationArea;
  final bool hasLearnerCar;
  final bool requiresTransport;
  final String totalPrice;
  final String type;
  final String status;
  final String? notes;
  final String? rejectionReason;
  final String createdAt;
  final String updatedAt;
  final List<Session> sessions;
  final User learner;
  final User? instructor;
  final Package package;

  LessonRequest({
    required this.id,
    required this.learnerId,
    required this.instructorId,
    required this.packageId,
    this.startDate,
    required this.locationCity,
    required this.locationArea,
    required this.hasLearnerCar,
    required this.requiresTransport,
    required this.totalPrice,
    required this.type,
    required this.status,
    this.notes,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
    required this.sessions,
    required this.learner,
    required this.instructor,
    required this.package,
  });

  factory LessonRequest.fromJson(Map<String, dynamic> json) {
    return LessonRequest(
      id: json['id'] ?? 0,
      learnerId: json['learner_id'] ?? 0,
      instructorId: json['instructor_id'],
      packageId: json['package_id'] ?? 0,
      startDate: json['start_date'],
      locationCity: json['location_city'] ?? '',
      locationArea: json['location_area'] ?? '',
      hasLearnerCar: json['has_learner_car'] ?? false,
      requiresTransport: json['requires_transport'] ?? false,
      totalPrice: json['total_price'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'],
      rejectionReason: json['rejection_reason'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      sessions: json['sessions'] != null
          ? (json['sessions'] as List).map((i) => Session.fromJson(i)).toList()
          : [],
      learner: User.fromJson(json['learner']),
      instructor: json['instructor'] != null
          ? User.fromJson(json['instructor'])
          : null, // ✅ null check
      package: Package.fromJson(json['package']),
    );
  }
}

// نموذج خاص بالمعلم
class InstructorLessonRequestsResponse extends BaseLessonRequestsResponse {
  InstructorLessonRequestsResponse({
    required List<LessonRequest> newRequests,
    required super.activeRequests,
    required super.completedRequests,
  }) : super(
    primaryRequests: newRequests,
  );

  factory InstructorLessonRequestsResponse.fromJson(Map<String, dynamic> json) {
    return InstructorLessonRequestsResponse(
      newRequests: (json['new'] as List? ?? [])
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