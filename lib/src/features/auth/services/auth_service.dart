import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:dio/dio.dart';

class AuthService {
  final String _path = "${AppConstants.baseUrl}auth/";

  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      String endpoint = "login";

      final Dio dio = Dio();

      final body = {"email": email, "password": password};

      final response = await dio.post("$_path$endpoint", data: body);

      return ApiResponse.success(
        message: response.data['message'],
        data: response.data['data'],
      );
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  Future<ApiResponse> signUp({
    required String email,
    required String username,
    required String password,
    required String avatar,
    required String? referralCode,
  }) async {
    try {
      String endpoint = "signup";

      final Dio dio = Dio();

      final body = {
        "username": username,
        "email": email,
        "password": password,
        "avatar": avatar,
        "currency": 'NGN',
        "referralCode": referralCode
      };

      final response = await dio.post("$_path$endpoint", data: body);

      return ApiResponse.success(
        message: response.data['message'],
        data: response.data['data'],
      );
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  Future<ApiResponse> sendOtp(String email) async {
    try {
      String endpoint = "otp";

      final Dio dio = Dio();

      final body = {"email": email};

      final response = await dio.post("$_path$endpoint", data: body);

      return ApiResponse.success(message: response.data['message']);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  Future<ApiResponse> changePassword({
    required String email,
    required String password,
    required String otp,
  }) async {
    try {
      String endpoint = "change-password";

      final Dio dio = Dio();

      final body = {"otp": otp, "email": email, "password": password};

      final response = await dio.put("$_path$endpoint", data: body);

      return ApiResponse.success(message: response.data['message']);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  Future<ApiResponse> verifyEmail(
      {required String otp, required String token}) async {
    try {
      String endpoint = "verify-email";

      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final body = {"otp": otp};

      final response = await dio.put("$_path$endpoint", data: body);

      return ApiResponse.success(
        message: response.data['message'],
        data: response.data['data'],
      );
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
