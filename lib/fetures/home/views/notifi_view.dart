import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x_ray2/core/utils/assets.dart';
import 'package:x_ray2/fetures/splash/views/start_view.dart';

class NotifiView extends StatelessWidget {
  const NotifiView({super.key});
  static String id = 'NotifiView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                Assets.imagesNotifications), // Replace with your image asset
            SizedBox(height: 20),
            Text(
              'No notification, yet!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // NotificationMessage()
          ],
        ),
      ),
    );
  }
}
