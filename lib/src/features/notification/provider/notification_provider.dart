import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/notification/models/notification_model.dart';
import 'package:cryptonia/src/features/notification/services/notification_service.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationService _service = NotificationService();

  void clearAll() {
    notification = null;
    notificationList = [];
    notifyListeners();
  }

  NotificationModel? currentNotification;
  NotificationModel? get notification => currentNotification;
  set notification(NotificationModel? value) {
    currentNotification = value;
    notifyListeners();
  }

  List<NotificationModel> notificationList = [];
  List<NotificationModel> get notifications => notificationList;
  set notifications(List<NotificationModel> value) {
    notificationList = value;
    notifyListeners();
  }

  void markAsRead(List<String> ids) {
    for (var e in notificationList) {
      if (ids.contains(e.id)) {
        e.read = true;
      }
    }
    notifyListeners();
  }

  Future<ApiResponse> fetchNotifications() async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception('Cannot process request');

    final res = await _service.fetchNotifications(token);

    if (res.status == Status.success && res.data != null) {
      notifications = res.data as List<NotificationModel>;
    }

    return res;
  }

  Future<ApiResponse> markAllAsRead() async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception('Cannot process request');

    final res = await _service.markAsRead(
      token,
      notifications
          .where((e) => e.read == false)
          .toList()
          .map((n) => n.id)
          .toList(),
    );

    for (var e in notifications) {
      e = e.copyWith(read: true);
    }
    notifyListeners();

    return res;
  }

  Future<ApiResponse> editToken(String fcmToken) async {
    String? token = AuthProvider().token;

    if (token == null) return ApiResponse.exception('Cannot process request');

    final res = await _service.editToken(token, fcmToken);

    notifyListeners();

    return res;
  }
}
