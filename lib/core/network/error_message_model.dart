class ErrorMessageModel {
  final int statusCode;
  final String statusMessage;
  final bool success;
  ErrorMessageModel({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });
  factory ErrorMessageModel.fromjson(Map<String, dynamic> json) {
    return ErrorMessageModel(
        statusCode: json['status_code'] ?? 404,
        statusMessage: json['status_message'] ?? '',
        success: json['success'] ?? false);
  }
}
