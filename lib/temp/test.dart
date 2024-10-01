
// import 'dart:convert';
// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;
// import 'package:x_ray2/services/send_notifications.dart';





// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String accessToken = '';

//   getToken() async {
//     var mytoken = await FirebaseMessaging.instance.getToken();
//     print(mytoken);
//   }

//   @override
//   void initState() {
//     getToken();
//     super.initState();
//     getAccessToken();
//   }

//   Future<void> getAccessToken() async {
//     try {
//       final serviceAccountJson = await rootBundle.loadString(
//           'assets/files/x-ray-2c7c1-firebase-adminsdk-797z4-9805dcd09d.json');
          

//       final accountCredentials = ServiceAccountCredentials.fromJson(
//         json.decode(serviceAccountJson),
//       );

//       const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

//       final client = http.Client();
//       try {
//         final accessCredentials =
//             await obtainAccessCredentialsViaServiceAccount(
//           accountCredentials,
//           scopes,
//           client,
//         );

//         setState(() {
//           accessToken = accessCredentials.accessToken.data;
//         });

//         log('Access Token: $accessToken');
//       } catch (e) {
//         log('Error obtaining access token: $e');
//       } finally {
//         client.close();
//       }
//     } catch (e) {
//       log('Error loading service account JSON: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Access Token Example'),
//       ),
//       body: Center(
//         child: IconButton(onPressed: ()async{
//         await  NotificationsServices().sendMessage('welcome','hosam');
//         log('send message done');
//         }, icon: Icon(Icons.import_contacts))
//       ),
//     );
//   }
// }
