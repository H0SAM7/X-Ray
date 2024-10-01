import 'package:flutter/material.dart';
import 'package:x_ray2/core/utils/assets.dart';

class NoNoitifiView extends StatelessWidget {
  const NoNoitifiView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
  
        Align(
          
          child: Image.asset(Assets.imagesNotifications)),
        SizedBox(height: 20),
        Text(
          'No notification, yet!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
             SizedBox(height: 10),
      ],
    );
  }
}
