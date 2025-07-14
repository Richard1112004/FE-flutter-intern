import 'package:begining/model/notification.dart';
import 'package:flutter/material.dart';

class NotificationDetail extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDetail({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'refresh');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                notification.title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 0),
            Text(notification.message, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
