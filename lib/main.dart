import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_ray2/bloc_observer.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/models/search_model.dart';
import 'package:x_ray2/core/routes/app_routes.dart';
import 'package:x_ray2/fetures/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:x_ray2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
    await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserever();
    Hive.registerAdapter(SearchModelAdapter());
  await Hive.openBox<SearchModel>(kSearchHistoryBox);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applicatio
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initialRoute,
      ),
    );
  }
}



