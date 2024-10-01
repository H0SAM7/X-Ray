
import 'package:flutter/material.dart';
import 'package:x_ray2/fetures/Notifications/views/widgets/notifi_view_item.dart';

class NotifiListView extends StatelessWidget {
  const NotifiListView({super.key, required this.notificationsList});
  final List<Map<String, String>> notificationsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notificationsList.length,
        itemBuilder: (context, ind) {
          final notification = notificationsList[ind];
          return NotificationViewItem(
              notificationTitle: notification['title'],
              notificationBody: notification['body']);
        });
  }
}
