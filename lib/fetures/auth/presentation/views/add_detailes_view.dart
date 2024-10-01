import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:x_ray2/core/errors/failure.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/custom_text_field.dart';
import 'package:x_ray2/fetures/auth/presentation/widgets/signup_bottun.dart';
import 'package:x_ray2/fetures/splash/views/widgets/custom_show_dialog2.dart';
import 'package:x_ray2/navigation_bar.dart';

class AddDetailesView extends StatefulWidget {
  const AddDetailesView({super.key});
  static String id = 'AddDetailesView';
  @override
  State<AddDetailesView> createState() => _AddDetailesViewState();
}

class _AddDetailesViewState extends State<AddDetailesView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Complete Details",
          style: AppStyles.styleMeduim24,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
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
                SignUpButton(
                  text: "SIGN UP",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseFirestore.instance.collection('users').add({
                          "userName": name,
                          "phone": phone,
                        });
                        Navigator.pushReplacementNamed(
                            context, CustomBottomNavigationBar.id);
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
