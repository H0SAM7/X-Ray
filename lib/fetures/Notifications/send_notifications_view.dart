import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/widgets/custom_alert.dart';
import 'package:x_ray2/core/widgets/custom_button.dart';
import 'package:x_ray2/fetures/Notifications/services/send_notifications.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_text_field.dart';

class NotifactionsSendView extends StatefulWidget {
  const NotifactionsSendView({super.key});

  @override
  _NotifactionsSendViewState createState() => _NotifactionsSendViewState();
}

class _NotifactionsSendViewState extends State<NotifactionsSendView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitlecontroller = TextEditingController();

  String accessToken = '';

  getToken() async {
    var mytoken = await FirebaseMessaging.instance.getToken();
    log(mytoken.toString());
  }

  @override
  void initState() {
    getToken();
    super.initState();
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    try {
      final serviceAccountJson = await rootBundle.loadString(
          'assets/files/x-ray-2c7c1-firebase-adminsdk-797z4-9805dcd09d.json');

      final accountCredentials = ServiceAccountCredentials.fromJson(
        json.decode(serviceAccountJson),
      );

      const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = http.Client();
      try {
        final accessCredentials =
            await obtainAccessCredentialsViaServiceAccount(
          accountCredentials,
          scopes,
          client,
        );

        setState(() {
          accessToken = accessCredentials.accessToken.data;
        });

        log('Access Token: $accessToken');
      } catch (e) {
        log('Error obtaining access token: $e');
      } finally {
        client.close();
      }
    } catch (e) {
      log('Error loading service account JSON: $e');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    subTitlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Access Token Example'),
      ),
      body: Column(
        children: [
          CustomTextFrom(
            hint: '',
            label: "title",
            onChanged: (value) {
              titleController.text = value;
            },
          ),
          CustomTextFrom(
            hint: '',
            label: "subtitle",
            onChanged: (value) {
              subTitlecontroller.text = value;
            },
          ),
          CustomButton(
            label: 'Send',
            color: blueColor,
            txtColor: Colors.white,
            onTap: () async {
              try {
                await NotificationsServices().sendNotification(
                    titleController.text, subTitlecontroller.text, accessToken);
                showCustomAlert(
                    context: context,
                    type: AlertType.success,
                    title: '',
                    description: 'Send done',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    actionTitle: 'Ok');
                log('send message done');
              } catch (e) {
                log('send message err:$e');
              }
            },
          ),
          IconButton(
              onPressed: () async {
                await NotificationsServices().sendNotification(
                    'welcome', 'can i help you?', accessToken);
                log('send message done');
              },
              icon: Icon(
                Icons.import_contacts,
                size: 150,
              )),
        ],
      ),
    );
  }
}
