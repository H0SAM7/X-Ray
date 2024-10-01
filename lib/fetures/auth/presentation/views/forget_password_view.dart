import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_ray2/core/errors/failure.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/fetures/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:x_ray2/fetures/auth/presentation/views/login_view.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_text_field.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/signup_bottun.dart';
import 'package:x_ray2/fetures/splash/views/widgets/custom_show_dialog2.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});
  static String id = 'ForgetPasswordView';

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Forget Pssword",
          style: AppStyles.styleMeduim24,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFrom(
              hint: 'Enter Your Email',
              label: 'Email',
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20),
            SignUpButton(
                text: 'Send',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission logic
                    try {
                      await BlocProvider.of<AuthCubit>(context)
                          .forgotPassword(email: email!);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmationDialog2(
                                title: 'Reset Password',
                                content:
                                    'A link to reset your password has been sent.',
                                onConfirm: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginView.id);
                                },
                                action: 'OK');
                          });
                    } catch (e) {
                       showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmationDialog2(
                          title: 'Error',
                          content: FirebaseFailure.fromFirebaseException(
                                  e as Exception)
                              .errMessage
                              .toString(),
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                          action: 'OK');
                          });
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
