import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/core/utils/assets.dart';
import 'package:x_ray2/core/widgets/custom_alert.dart';
import 'package:x_ray2/core/widgets/custom_progress_hud.dart';
import 'package:x_ray2/fetures/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:x_ray2/fetures/auth/presentation/views/register_view.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_send_button.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_text_field.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/google_button.dart';
import 'package:x_ray2/fetures/home/views/home_view.dart';

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
          Navigator.pushReplacementNamed(context, HomeView.id);
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
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    height:
                        MediaQuery.of(context).size.height, // Set a height
              
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(Assets.imagesFrame),
                              Text(
                                'Sign in Now',
                                style: AppStyles.poppinsStylebold20.copyWith(
                                  color: const Color(0xff253274)
                                ),
                              ),
                            ],
                          ),
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
                            Navigator.pushNamed(context, RegisterView.id);
                            },
                            child: Text(
                              'Forget Password?',
                              style: AppStyles.style12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomAuthButton(
                          label: 'Send',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await BlocProvider.of<AuthCubit>(context)
                                  .login(email: email!, password: password!);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GoogleButton(
                          onTap: () async {
                            await BlocProvider.of<AuthCubit>(context)
                                .signInWithGoogle();
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterView.id);
                          },
                          child: Text(
                            'Create Account.',
                            style: AppStyles.style12,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Spacer(),
                        Image.asset(
                          Assets.imagesPatterns,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
