import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:x_ray2/fetures/ai/views/ml_model.dart';
import 'package:x_ray2/fetures/auth/presentation/views/add_detailes_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/forget_password_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/login_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/register_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/verification_view.dart';
import 'package:x_ray2/fetures/home/views/history_view.dart';
import 'package:x_ray2/fetures/home/views/home_view.dart';
import 'package:x_ray2/fetures/home/views/notifi_view.dart';
import 'package:x_ray2/fetures/splash/views/start_view.dart';
import 'package:x_ray2/navigation_bar.dart';

abstract class AppRoutes {
  static String? initialRoute = StartView.id;
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginView.id: (context) => const LoginView(),
    RegisterView.id: (context) => const RegisterView(),
    HomeView.id: (context) => const HomeView(),
    StartView.id: (context) => const StartView(),
    VerificationView.id: (context) => const VerificationView(),
    ImageClassificationScreen.id: (context) => ImageClassificationScreen(),
    CustomBottomNavigationBar.id: (context) => CustomBottomNavigationBar(),
    HistoryView.id: (context) => HistoryView(),
    NotifiView.id: (context) => NotifiView(),
    ForgetPasswordView.id: (context) => ForgetPasswordView(),
    AddDetailesView.id: (context) => AddDetailesView(),
  };
}
