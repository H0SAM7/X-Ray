
import 'package:flutter/material.dart';

class NotificationViewItem extends StatelessWidget {
  const NotificationViewItem({
    super.key,
    required this.notificationTitle,
    required this.notificationBody,
  });

  final String? notificationTitle;
  final String? notificationBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text(
            notificationTitle!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            notificationBody!,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        Divider(endIndent: 60,indent: 60,thickness: .35,),
      ],
    );
  }
}
