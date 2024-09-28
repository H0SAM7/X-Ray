
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 167,
      width: double.infinity,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

