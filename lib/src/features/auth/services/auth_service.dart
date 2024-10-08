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
          json: response.data, data: response.data['data']);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
