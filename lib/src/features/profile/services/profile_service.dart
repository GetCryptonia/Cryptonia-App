import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/profile/models/user_profile_model.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:dio/dio.dart';

class ProfileService {
  final String _path = "${AppConstants.baseUrl}auth/";

  //change email
  Future<ApiResponse> changeEmail({
    required String otp,
    required String token,
    required String email,
    required String password,
  }) async {
    try {
      String endpoint = "change-email";

      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final body = {"otp": otp, "email": email, "password": password};

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

  //get account
  Future<ApiResponse> getAccount(String token) async {
    try {
      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final response = await dio.get(_path);

      final data = response.data;

      UserProfileModel profile = UserProfileModel.fromJson(data['data']);

      return ApiResponse.success(
        message: data['message'],
        data: profile,
      );
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //edit account
  Future<ApiResponse> editAccount({
    required String token,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    try {
      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      Map<String, dynamic> body = {
        "firstName": firstName,
        "lastName": lastName,
        "username": username
      };

      final response = await dio.put(_path, data: body);

      final data = response.data;

      UserProfileModel profile = UserProfileModel.fromJson(data['data']);

      return ApiResponse.success(
        message: data['message'],
        data: profile,
      );
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //delete account
  Future<ApiResponse> deleteAccount({
    required String token,
    required String otp,
    required String password,
  }) async {
    try {
      final Dio dio = Dio();

      dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      Map<String, dynamic> body = {"otp": otp, "password": password};

      final response = await dio.delete(_path, data: body);

      final data = response.data;

      return ApiResponse.success(message: data['message']);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
