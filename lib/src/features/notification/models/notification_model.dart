class NotificationModel {
  String id;
  String userId;
  String title;
  String message;
  bool read;
  DateTime createdAt;

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
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }

//write the copyWith
  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    bool? read,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
