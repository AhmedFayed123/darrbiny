import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  // Factory method to create ServerFailure from DioException
  factory ServerFailure.fromDioError(DioException dioError) {
    final errorMessage = dioError.message ?? 'Unknown error';
    print('DioException: $errorMessage');
    print('DioException Type: ${dioError.type}');
    print('Response Data: ${dioError.response?.data}');
    print('Status Code: ${dioError.response?.statusCode}');

    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with the server.');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with the server.');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with the server.');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioExceptionType.cancel:
        return const ServerFailure('Request to the server was canceled.');

      case DioExceptionType.unknown:
        if (dioError.message != null && dioError.message!.contains('SocketException')) {
          return const ServerFailure('No internet connection.');
        }
        return ServerFailure('Unexpected error: ${dioError.error?.toString() ?? 'Unknown error'}');

      default:
        return const ServerFailure('An unknown error occurred, please try again.');
    }
  }

  // Factory method to create ServerFailure from the response
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    print('Handling error response: StatusCode = $statusCode, Response = $response');

    if (statusCode == null) {
      return const ServerFailure('An unknown error occurred, please try again.');
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        final errorMessage = response?['message'] ??
            response?['error']?['message'] ??
            'Unauthorized request.';
        return ServerFailure(errorMessage);

      case 404:
        return ServerFailure(response?['message'] ?? 'The requested resource was not found.');

      case 500:
        return const ServerFailure('Internal server error, please try later.');

      default:
        return ServerFailure('Error $statusCode: ${response?['message'] ?? 'An error occurred, please try again.'}');
    }
  }
}
