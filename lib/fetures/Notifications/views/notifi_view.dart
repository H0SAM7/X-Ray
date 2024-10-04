import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/fetures/Notifications/views/widgets/no_notifi_view.dart';
import 'package:x_ray2/fetures/Notifications/views/widgets/notifi_list_view.dart';
import 'package:x_ray2/fetures/splash/views/start_view.dart';

class NotifiView extends StatefulWidget {
  const NotifiView({super.key});
  static String id = 'NotifiView';

  @override
  State<NotifiView> createState() => _NotifiViewState();
}

class _NotifiViewState extends State<NotifiView> {
  String? notificationTitle;
  String? notificationBody;
  List<Map<String, String>> _notifications = [];
  Timer? _clearNotificationTimer;

  Future<void> storeNotifications(
      List<Map<String, String>> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsAsString =
        notifications.map((notification) => jsonEncode(notification)).toList();
    await prefs.setStringList('notifications', notificationsAsString);
  }

  Future<void> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedNotifications = prefs.getStringList('notifications');

    if (storedNotifications != null) {
      setState(() {
        _notifications = storedNotifications
            .map((notificationString) =>
                Map<String, String>.from(jsonDecode(notificationString)))
            .toList();
      });
    }
  }

  void startClearNotificationTimer() {
    _clearNotificationTimer?.cancel(); // Cancel any previous timer
    _clearNotificationTimer = Timer(Duration(days: 7), () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('notifications');
      setState(() {
        _notifications.clear();
      });
    });
  }

  @override
  void dispose() {
    _clearNotificationTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadNotifications();

    //getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      // Check if the message contains a notification
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification!.body}');
        String title = message.notification!.title ?? "No Title";
        String body = message.notification!.body ?? "No Body";

        setState(() {
          // Add the new notification to the list
          _notifications.add({'title': title, 'body': body});
        });
        storeNotifications(_notifications);

        // Clear notifications after a temporary period
        startClearNotificationTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Divider(), 
        ),
        title: Text(
          'Notifications',
          style: AppStyles.poppinsStylebold20,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  PopupMenuItem(
                    child: TextButton.icon(
                        label: Text('Clear All'),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('notifications');
                          setState(() {
                            _notifications.clear();
                          });
                        },
                        icon: Icon(Icons.clear)),
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        label: Text('log out'),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(context, StartView.id);
                        },
                        icon: Icon(Icons.logout)),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Center(
        child: (_notifications.isNotEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(),
                  Expanded(
                    child: NotifiListView(
                      notificationsList: _notifications,
                    ),
                  ),
                ],
              )
            : NoNoitifiView(),
      ),
    );
  }
}
