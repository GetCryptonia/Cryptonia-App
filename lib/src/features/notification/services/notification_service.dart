import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/notification/models/notification_model.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:dio/dio.dart';

class NotificationService {
  final String _path = "${AppConstants.baseUrl}notifications/";
  //send kyc otp
  Future<ApiResponse> fetchNotifications(String token) async {
    try {
      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final response = await dio.get(_path);

      final data = response.data;

      List<NotificationModel> notifications = data['data']
          .map<NotificationModel>((e) => NotificationModel.fromJson(e))
          .toList();

      return ApiResponse.success(message: data['message'], data: notifications);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //send kyc otp
  Future<ApiResponse> markAsRead(String token, List<String> ids) async {
    try {
      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});
      final body = {"notificationIds": ids};

      final response = await dio.put(_path, data: body);

      return ApiResponse.success(message: response.data['message']);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
