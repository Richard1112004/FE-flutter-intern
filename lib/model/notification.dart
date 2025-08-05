class NotificationModel {
  int id;
  String userId;
  String title;
  String subtitle;
  String message;
  DateTime createdAt;
  bool isRead;
  static List<NotificationModel> notifications = [];

  NotificationModel({
    this.id = 0,
    required this.userId,
    required this.subtitle,
    required this.title,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  }) {
    notifications.add(this);
  }

  // Factory constructor for creating Notification from Map
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? 0,
      userId: map['user']?['id'].toString() ?? '',
      title: map['title'] ?? '',
      subtitle: map['subTitle'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      isRead: map['read'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Notification{id: $id, userId: $userId, title: $title, message: $message, createdAt: $createdAt, isRead: $isRead}';
  }

  static List<NotificationModel> getMockNotifications() {
    return notifications;
  }

  static final NotificationModel welcomeNotification = NotificationModel(
    id: 1,
    userId: '1',
    subtitle: 'Welcome',
    title: 'Welcome to Our App',
    message: 'Thank you for joining us! We hope you enjoy your experience.',
    createdAt: DateTime.now(),
  );

  static final NotificationModel reminderNotification = NotificationModel(
    id: 2,
    userId: '1',
    subtitle: 'Pay today',
    title: 'Upconing Installment',
    message: '''Hi Phuc Hung,
Your next installment payment of for Iphone 15 Pro Max is due on 20/06/2025.

Avoid late fees! Thank you for your prompt payment.
Need help? Contact us at 0912812382.''',
    createdAt: DateTime.now(),
  );

  static void clearNotifications() {
    notifications.clear();
  }
}


