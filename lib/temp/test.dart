import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
   TestView({super.key});
  final List<String> imageUrls = [
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
  ];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(imageUrls[index]);
        },
      );
  }
}