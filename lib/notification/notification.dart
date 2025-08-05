import 'package:begining/api/notification/notificationAPI.dart';
import 'package:begining/model/notification.dart';
import 'package:begining/notification/notification_detail.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationApi _notificationApi = NotificationApi();
  void _goToNotificationPage(NotificationModel notification) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetail(notification: notification),
      ),
    );

    if (result == 'refresh') {
      setState(() {
        print('Cart has been refreshed after placing an order');
      });
    }
  }

  Widget notificationItem(
    NotificationModel notification,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () async {
        await _notificationApi.updateNotificationRead(
          notificationId: notification.id,
          isRead: true,
        );
        _goToNotificationPage(notification);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.grey[50] : Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: notification.isRead ? Colors.grey[200]! : Colors.blue[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead ? Colors.transparent : Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: notification.isRead
                          ? FontWeight.w500
                          : FontWeight.w600,
                      color: notification.isRead
                          ? Colors.grey[700]
                          : Colors.blue,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    notification.subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      color: notification.isRead
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              notification.createdAt.toLocal().toString().split(' ')[0],
              style: TextStyle(
                fontSize: 14,
                color: notification.isRead
                    ? Colors.grey[500]
                    : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _notificationApi.getAllNotifications(),
        builder: (context, AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          NotificationModel.notifications = snapshot.data!;
          print(
            "NotificationModel.notifications: $NotificationModel.notifications",
          );
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You have ${NotificationModel.notifications.length} notifications${NotificationModel.notifications.where((n) => !n.isRead).length > 0 ? ' (${NotificationModel.notifications.where((n) => !n.isRead).length} unread)' : ''}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...List.generate(
                  NotificationModel.notifications.length,
                  (i) => Column(
                    children: [
                      SizedBox(height: 30),
                      notificationItem(
                        NotificationModel.notifications[i],
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
