import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/utils/assets.dart';
import 'package:x_ray2/core/widgets/custom_back_ground_image.dart';
import 'package:x_ray2/core/widgets/custom_button.dart';
import 'package:x_ray2/fetures/auth/presentation/views/register_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/verification_view.dart';
import 'package:x_ray2/fetures/home/views/home_view.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});
  static String id = 'StartView';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
   // final s = S.of(context);
    return Scaffold(
      body: CustomBackGroundImage(
        size: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  Expanded(child: SvgPicture.asset(Assets.imagesStart)),
            // Expanded(child: SvgPicture.asset(Assets.imagesLetsGo)),
            SizedBox(
              height: size.height * .1,
            ),
            Expanded(
              child: Image.asset(Assets.imagesLogo),
            ),
            // Expanded(
            //     child: Text(
            //   s.learn_any_time,
            //   style: AppStyles.styleMeduim24,
            // )),
            CustomButton(
              label: 'Start',
              color: blueColor,
              txtColor: Colors.white,
              onTap: () {
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    Navigator.pushNamed(context, RegisterView.id);
                    log('User is currently signed out!');
                  } else {
                    if (user.emailVerified) {
                      Navigator.pushReplacementNamed(context, HomeView.id);
                      log('User is signed in!');
                    } else if (!user.emailVerified) {
                      Navigator.pushNamed(
                          context, VerificationView.id);
                    } else {
                      Navigator.pushNamed(context, RegisterView.id);
                    }
                  }
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
