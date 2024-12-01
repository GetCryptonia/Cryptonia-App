import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/transaction/models/rate_model.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:dio/dio.dart';

class TransactionService {
  final String _path = AppConstants.baseUrl;

  Future<ApiResponse> getRate(String token) async {
    try {
      String endpoint = "rates";

      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      print("$_path$endpoint");

      final response = await dio.get("$_path$endpoint");

      final data = response.data;

      RateModel rate = RateModel.fromJson(data['data']);
      return ApiResponse.success(message: response.data['message'], data: rate);
    } catch (e) {
      if (e is DioException) {
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }

  Future<ApiResponse> createOrder({
    required String token,
    required num tokenAmount,
    required String bankAccountId,
    required TokenType tokenType,
    required String sessionId,
  }) async {
    try {
      String endpoint = "sell";

      final Dio dio = Dio();
      dio.options.headers.addAll({"Authorization": "Bearer $token"});

      final body = {
        "symbol": tokenType.symbol,
        "tokenAmount": tokenAmount,
        "bankAccountId": bankAccountId,
        "sessionId": sessionId,
      };

      final response = await dio.post("$_path$endpoint", data: body);

      final data = response.data;

      OrderModel order = OrderModel.fromJson(data['data']);

      return ApiResponse.success(
          message: response.data['message'], data: order);
    } catch (e) {
      print('Error: $e');
      if (e is DioException) {
        print(e.response?.data);
        return ApiResponse.dioException(e);
      } else {
        return ApiResponse.exception(e.toString());
      }
    }
  }
}
