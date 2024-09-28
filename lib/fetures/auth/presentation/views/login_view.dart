import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/core/utils/assets.dart';
import 'package:x_ray2/core/widgets/custom_alert.dart';
import 'package:x_ray2/core/widgets/custom_progress_hud.dart';
import 'package:x_ray2/fetures/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:x_ray2/fetures/auth/presentation/views/register_view.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/auth_titile.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_send_button.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_text_field.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/google_button.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/or_widget.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/signup_bottun.dart';
import 'package:x_ray2/fetures/home/views/home_view.dart';
import 'package:x_ray2/navigation_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email, password;
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
                    const TitleWidget(title: "Sign In",),
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
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  CustomTextFrom(
                                    hint: 'Enter Your Email',
                                    label: 'Email',
                                    onChanged: (value) {
                                      email = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFrom(
                                    hint: 'Enter Your Password',
                                    label: 'password',
                                    isPasswordField: true,
                                    onChanged: (value) {
                                      password = value;
                                    },
                                  ),
                              
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, RegisterView.id);
                                      },
                                      child: Text(
                                        'Forget Password?',
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
                                  //           .login(
                                  //               email: email!,
                                  //               password: password!);
                                  //     }
                                  //   },
                                  // ),
                                  SignUpButton(
                                    text: "SIGN IN",
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        await BlocProvider.of<AuthCubit>(
                                                context)
                                            .login(
                                                email: email!,
                                                password: password!);
                                      }
                                    },
                                  ),
                                      const OrWidget(),
                                      
                                  GoogleButton(
                                    onTap: () async {
                                      await BlocProvider.of<AuthCubit>(context)
                                          .signInWithGoogle();
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RegisterView.id);
                                    },
                                    child: Text(
                                      'Create Account.',
                                      style: AppStyles.style12,
                                    ),
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
