import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';
import 'package:cryptonia/src/features/profile/models/user_profile_model.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:dio/dio.dart';

class KycService {
  final String _path = "${AppConstants.baseUrl}kyc/";
  //send kyc otp
  Future<ApiResponse> sendOtp({
    required String token,
    required String number,
    required KycType type,
  }) async {
    try {
      String endpoint = "send";

      final Dio dio = Dio();

      final body = {"number": number, "type": type.value};
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

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

  //verify kyc otp
  Future<ApiResponse> verifyOtp({
    required String token,
    required String otp,
    required KycType type,
  }) async {
    try {
      String endpoint = "verify";

      final Dio dio = Dio();

      final body = {"type": type.value, "otp": otp};
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final response = await dio.post("$_path$endpoint", data: body);

      UserProfileModel profile =
          UserProfileModel.fromJson(response.data['data']);

      return ApiResponse.success(
        message: response.data['message'],
        data: profile,
      );
    } catch (e) {
      print("!==== Error verifying kyc");
      print(e);
      if (e is DioException) {
        print(e.response?.data);
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
