import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/fetures/home/views/chat_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'X-RAY',
          style: AppStyles.styleMeduim24,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
Navigator.pushNamed(context, ChatView.id);              },
              icon: const Icon(Icons.add_a_photo,color: Colors.white,),
              label: Text(
                'Send New Image',
                style: AppStyles.styleMeduim24.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Logic to view history
              },
              icon: const Icon(Icons.history, color: Colors.white,),
              label: Text(
                'View History',
                style:
                    AppStyles.poppinsStylebold20.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF03DAC5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

