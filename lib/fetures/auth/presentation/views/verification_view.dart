
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/fetures/auth/presentation/views/register_view.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/timer_widget.dart';
import 'package:x_ray2/fetures/home/views/home_view.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});
  static String id = 'VerificationView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececec),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //    Expanded(child: Image.asset(Assets.imagesVerification)),
          //  SvgPicture.asset(Assets.imagesVerifiedCheck),
        //  Expanded(child: Image.asset(Assets.imagesVerification)),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
               'Check inbox',
                style: AppStyles.poppinsStylebold20,
              ),
            ),
          ),
          TimerWidget(
            onEnd: () {
              Navigator.pushReplacementNamed(
                  context,
                  FirebaseAuth.instance.currentUser!.emailVerified
                      ? HomeView.id
                      : RegisterView.id);
            
             },
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
