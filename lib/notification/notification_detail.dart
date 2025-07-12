import 'package:flutter/material.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Upconing Installment',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text('''Hi Phuc Hung,
Your next installment payment of for Iphone 15 Pro Max is due on 15/06/2025.

Avoid late fees! Thank you for your prompt payment.
Need help? Contact us at 0912812382.
''', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
