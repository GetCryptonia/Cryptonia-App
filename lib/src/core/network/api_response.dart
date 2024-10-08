import 'package:dio/dio.dart';

enum Status { success, error }

class ApiResponse<T> {
  Status status;
  String message;
  String? errorMessage;
  dynamic data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.errorMessage,
    this.data,
  });

  factory ApiResponse.success({
    required String message,
    dynamic data,
  }) {
    return ApiResponse(
      message: message,
      status: Status.success,
      errorMessage: null,
      data: data,
    );
  }

  factory ApiResponse.dioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiResponse(
          message: 'Connection timeout',
          errorMessage: 'Please check your internet connection and try again',
          status: Status.error,
        );

      case DioExceptionType.connectionError:
        return ApiResponse(
          message: 'Unable to connect',
          errorMessage: 'Please check your connection and try again.',
          status: Status.error,
        );

      case DioExceptionType.badResponse:
        final data = e.response?.data;

        print(data);

        return ApiResponse(
          message: data['message'],
          errorMessage: data['error'],
          status: Status.error,
        );

      case DioExceptionType.unknown:
        return ApiResponse(
          message: 'Unknown error.',
          errorMessage: 'An unknown error occurred. Please try again later.',
          status: Status.error,
        );

      default:
        return ApiResponse(
          message: 'Error',
          errorMessage: 'An error occurred. Please try again later.',
          status: Status.error,
        );
    }
  }

  factory ApiResponse.exception(String error,
      [String title = 'An error occurred']) {
    return ApiResponse(
      message: title,
      errorMessage: error,
      status: Status.error,
    );
  }
}
