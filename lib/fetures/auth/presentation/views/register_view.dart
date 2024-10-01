import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/core/widgets/custom_alert.dart';
import 'package:x_ray2/core/widgets/custom_progress_hud.dart';
import 'package:x_ray2/fetures/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:x_ray2/fetures/auth/presentation/views/add_detailes_view.dart';
import 'package:x_ray2/fetures/auth/presentation/views/login_view.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/auth_titile.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_text_field.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/google_button.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/or_widget.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/signup_bottun.dart';
import 'package:x_ray2/navigation_bar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password, name, phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, CustomBottomNavigationBar.id);
        } else if (state is AuthFailure) {
          showCustomAlert(
            context: context,
            type: AlertType.error,
            title: 'Error',
            description: state.errMessage,
            onPressed: () {
              Navigator.pop(context);
            },
            actionTitle: 'OK',
          );
        } else if (state is LoginWithGoogle) {
          Navigator.pushReplacementNamed(context, AddDetailesView.id);
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          inAsyncCall: state is AuthLoading,
          child: AbsorbPointer(
            absorbing: state is AuthLoading,
            child: Scaffold(
              body: Container(
                color: blueColor,
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    const TitleWidget(
                      title: "Sign Up",
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  CustomTextFrom(
                                    hint: 'Enter Your Name',
                                    label: "Name",
                                    onChanged: (value) {
                                      name = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFrom(
                                    hint: 'Enter Your Email',
                                    label: "Email",
                                    onChanged: (value) {
                                      email = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFrom(
                                    hint: 'Enter Your Phone Number',
                                    label: 'Phone Number',
                                    onChanged: (value) {
                                      phone = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Phone Number';
                                      } else if (value.length != 8) {
                                        return 'Please Enter Correct Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFrom(
                                    hint: 'Enter Your Password',
                                    label: 'Password',
                                    isPasswordField: true,
                                    onChanged: (value) {
                                      password = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, LoginView.id);
                                      },
                                      child: Text(
                                        "all ready have account?",
                                        style: AppStyles.style12,
                                      ),
                                    ),
                                  ),
                                  // CustomAuthButton(
                                  //   label: 'Send',
                                  //   onTap: () async {
                                  //     if (formKey.currentState!.validate()) {
                                  //       await BlocProvider.of<AuthCubit>(
                                  //               context)
                                  //           .register(
                                  //               email: email!,
                                  //               password: password!);
                                  //     }
                                  //   },
                                  // ),
                                  SignUpButton(
                                    text: "SIGN UP",
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .register(
                                                email: email!,
                                                password: password!,
                                                phone: phone!,
                                                userName: name!);
                                        await FirebaseMessaging.instance
                                            .subscribeToTopic('all');
                                
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const OrWidget(),

                                  GoogleButton(
                                    onTap: () async {
                                      await BlocProvider.of<AuthCubit>(context)
                                          .signInWithGoogle();
                                      await FirebaseMessaging.instance
                                          .subscribeToTopic('all');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
