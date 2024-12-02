import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/history/models/order_month.dart';
import 'package:cryptonia/src/features/history/services/order_service.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:flutter/material.dart';

class HistoryProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

  void clearAll() {
    order = null;
    orders = [];
    notifyListeners();
  }

  OrderModel? currentOrder;
  OrderModel? get order => currentOrder;
  set order(OrderModel? value) {
    currentOrder = value;
    notifyListeners();
  }

  List<OrderModel> allOrders = [];
  List<OrderModel> get orders => allOrders;
  set orders(List<OrderModel> value) {
    allOrders = value;
    notifyListeners();
  }

  List<OrderMonth> orderDates(List<OrderModel> values) {
    //fetch stuff like (oct 2024) based on the orders
    List<OrderMonth> dates = [];

    for (var order in values) {
      OrderMonth month = OrderMonth(
        month: order.createdAt.month,
        year: order.createdAt.year,
      );

      if (dates
          .where((e) => e.year == month.year && e.month == month.month)
          .toList()
          .isEmpty) {
        dates.add(month);
      }
    }

    return dates;
  }

  List<OrderModel> allFilteredOrders = [];
  List<OrderModel> get filteredOrders => allFilteredOrders;
  set filteredOrders(List<OrderModel> value) {
    allFilteredOrders = value;
    notifyListeners();
  }

  //fetch orders
  Future<ApiResponse> fetchOrders() async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    final res = await _orderService.fetchOrders(token);

    if (res.status == Status.success) {
      orders = res.data as List<OrderModel>;
    }

    return res;
  }

  //filter orders
  Future<ApiResponse> filterOrders({
    required TransactionStatus status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    final res = await _orderService.filterOrders(
        token: token, status: status, startDate: startDate, endDate: endDate);

    if (res.status == Status.success) {
      filteredOrders = res.data as List<OrderModel>;
    }

    return res;
  }

  //cancel an order
  Future<ApiResponse> cancelOrder(String orderId) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception("Couldn't perform request");

    final res = await _orderService.cancelOrder(token: token, orderId: orderId);

    if (res.status == Status.success) {
      order = res.data as OrderModel;
      List<OrderModel> orderList = orders.map((e) {
        if (e.id == orderId) {
          e.status = TransactionStatus.cancelled;
        }
        return e;
      }).toList();

      orders = orderList;
    }

    return res;
  }
}
