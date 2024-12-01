import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:dio/dio.dart';

class OrderService {
  final String _path = "${AppConstants.baseUrl}orders/";
  //send kyc otp
  Future<ApiResponse> fetchOrders(String token) async {
    try {
      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final response = await dio.get(_path);

      final data = response.data;

      List<OrderModel> orders =
          data['data'].map<OrderModel>((e) => OrderModel.fromJson(e)).toList();

      return ApiResponse.success(message: data['message'], data: orders);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  //send kyc otp
  Future<ApiResponse> filterOrders({
    required String token,
    required TransactionStatus status,
    required DateTime? startDate,
    required DateTime? endDate,
  }) async {
    try {
      const String endpoint = 'filter';

      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});
      dio.options.queryParameters.addAll({
        "status": status.name,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      });

      final response = await dio.get("$_path$endpoint");

      final data = response.data;

      List<OrderModel> orders =
          data['data'].map<OrderModel>((e) => OrderModel.fromJson(e)).toList();

      return ApiResponse.success(message: data['message'], data: orders);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  Future<ApiResponse> cancelOrder({
    required String token,
    required String orderId,
  }) async {
    try {
      final String endpoint = 'cancel/$orderId/';

      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final response = await dio.put("$_path$endpoint");

      final data = response.data;

      OrderModel order = OrderModel.fromJson(data['data']);

      return ApiResponse.success(message: data['message'], data: order);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  Future<ApiResponse> fetchOrderById({
    required String token,
    required String orderId,
  }) async {
    try {
      final String endpoint = '$orderId/';

      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final response = await dio.get("$_path$endpoint");

      final data = response.data;

      OrderModel order = OrderModel.fromJson(data['data']);

      return ApiResponse.success(message: data['message'], data: order);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
