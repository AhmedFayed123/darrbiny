class BookingRequest {
  final int learnerId;
  final int instructorId;
  final int packageId;
  final String startDate;
  final String locationCity;
  final String locationArea;
  final bool hasLearnerCar;
  final bool requiresTransport;
  final String totalPrice;
  final String type;
  final String notes;

  BookingRequest({
    required this.learnerId,
    required this.instructorId,
    required this.packageId,
    required this.startDate,
    required this.locationCity,
    required this.locationArea,
    required this.hasLearnerCar,
    required this.requiresTransport,
    required this.totalPrice,
    required this.type,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
    "learner_id": learnerId,
    "instructor_id": instructorId,
    "package_id": packageId,
    "start_date": startDate,
    "location_city": locationCity,
    "location_area": locationArea,
    "has_learner_car": hasLearnerCar,
    "requires_transport": requiresTransport,
    "total_price": totalPrice,
    "type": type,
    "notes": notes,
  };
}
