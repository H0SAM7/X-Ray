import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:x_ray2/fetures/auth/presentation/views/login_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/register_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/verification_view.dart';
import 'package:x_ray2/fetures/home/views/chat_view.dart';
import 'package:x_ray2/fetures/home/views/home_view.dart';
import 'package:x_ray2/fetures/splash/views/start_view.dart';

abstract class AppRoutes {
  static String? initialRoute = StartView.id;
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginView.id: (context) => const LoginView(),
    RegisterView.id: (context) => const RegisterView(),
    HomeView.id: (context) => const HomeView(),
    StartView.id: (context) => const StartView(),
    VerificationView.id: (context) => const VerificationView(),
        ChatView.id: (context) => const ChatView(),





  };
}
