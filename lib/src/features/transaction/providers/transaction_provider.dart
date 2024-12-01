import 'dart:async';

import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/history/services/order_service.dart';
import 'package:cryptonia/src/features/transaction/models/rate_model.dart';
import 'package:cryptonia/src/features/transaction/services/transaction_service.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  final TransactionService _service = TransactionService();

  TokenType tokenTypeEnum = TokenType.usdTBnb;
  TokenType get token => tokenTypeEnum;
  set token(token) {
    tokenTypeEnum = token;
    notifyListeners();
  }

  num? orderAmount;
  num? get amount => orderAmount;
  set amount(num? value) {
    orderAmount = value;
    notifyListeners();
  }

  OrderModel? sellOrderModel;
  OrderModel? get sellOrder => sellOrderModel;
  set sellOrder(OrderModel? value) {
    sellOrderModel = value;
    notifyListeners();
  }

  void loopFetchOrder(VoidCallback onCompleted) async {
    if (sellOrder == null) return;

    String? token = AuthProvider().token;

    if (token == null) return;

    final res = await OrderService()
        .fetchOrderById(token: token, orderId: sellOrder!.id);

    if (res.status != Status.success) return;

    sellOrder = res.data as OrderModel;

    if (sellOrder!.status == TransactionStatus.completed) {
      onCompleted();
      return;
    }

    await Future.delayed(const Duration(minutes: 1));

    loopFetchOrder(onCompleted);
  }

  RateModel? rateModel;
  RateModel? get rate => rateModel;
  set rate(RateModel? value) {
    rateModel = value!;
    notifyListeners();
  }

  //fetch rates
  Future<ApiResponse> fetchRates() async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    final res = await _service.getRate(token);

    if (res.status == Status.success) {
      rate = res.data as RateModel;
      print('Fetched rate: ${rate?.fiatAmount}');
    }

    return res;
  }

  //loop through to fetch rates every 30 seconds
  void fetchRatesLoop() async {
    await fetchRates();
    await Future.delayed(const Duration(seconds: 30));
    fetchRatesLoop();
  }

  //create sell order
  Future<ApiResponse> createSellOrder({
    required String bankAccountId,
    required String sessionId,
  }) async {
    String? accessToken = AuthProvider().token;

    if (accessToken == null) {
      return ApiResponse.exception("Couldn't perform request");
    }

    if (amount == null) return ApiResponse.exception("Amount is required");

    final res = await _service.createOrder(
      token: accessToken,
      tokenAmount: amount!,
      bankAccountId: bankAccountId,
      tokenType: token,
      sessionId: sessionId,
    );

    if (res.status == Status.success) {
      sellOrder = res.data as OrderModel;
    }

    return res;
  }
}
