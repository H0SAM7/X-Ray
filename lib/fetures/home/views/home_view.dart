import 'package:flutter/material.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/fetures/ai/views/ml_model.dart';
import 'package:x_ray2/fetures/home/views/history_view.dart';
import 'package:x_ray2/fetures/home/views/notifi_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Doctor",
          style: AppStyles.styleMeduim24,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, NotifiView.id);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Hosam',
                    style:
                        AppStyles.poppinsStylebold20.copyWith(color: blueColor),
                  ),
                  Text(
                    'Welcom To My Doctor App',
                    style: AppStyles.style12.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                    thickness: .5,
                  )
                ],
              )),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ImageClassificationScreen.id);
                        },
                        icon: const Icon(
                          Icons.upload_file,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Go To Analyze',
                          style: AppStyles.styleMeduim24
                              .copyWith(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, HistoryView.id);
                      },
                      icon: const Icon(
                        Icons.history,
                        color: Colors.white,
                      ),
                      label: Text(
                        'View History',
                        style: AppStyles.poppinsStylebold20
                            .copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF03DAC5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
