class NotificationModel {
  String id;
  String userId;
  String title;
  String subtitle;
  String message;
  DateTime createdAt;
  bool isRead;
  static List<NotificationModel> notifications = [];

  NotificationModel({
    this.id = '',
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
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      subtitle: map['subtitle'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      isRead: map['isRead'] ?? false,
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
    id: 'notif_1',
    userId: '1',
    subtitle: 'Welcome',
    title: 'Welcome to Our App',
    message: 'Thank you for joining us! We hope you enjoy your experience.',
    createdAt: DateTime.now(),
  );

  static final NotificationModel reminderNotification = NotificationModel(
    id: 'notif_2',
    userId: '1',
    subtitle: 'Pay today',
    title: 'Upconing Installment',
    message: '''Hi Phuc Hung,
Your next installment payment of for Iphone 15 Pro Max is due on 20/06/2025.

Avoid late fees! Thank you for your prompt payment.
Need help? Contact us at 0912812382.''',
    createdAt: DateTime.now(),
  );
}


