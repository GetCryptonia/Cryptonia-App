class NotificationModel {
  String id;
  String userId;
  String title;
  String message;
  bool read;
  String createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.read,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      userId: json['userId'],
      title: json['title'],
      message: json['message'],
      read: json['read'],
      createdAt: json['createdAt'],
    );
  }
}
