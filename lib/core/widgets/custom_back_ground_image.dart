import 'package:flutter/material.dart';

class CustomBackGroundImage extends StatelessWidget {
  const CustomBackGroundImage({
    super.key,
    required this.size, required this.child,
  });
final Widget child;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage(Assets.imagesBackground),
        //   fit: BoxFit.fill,
        // ),
      ),
      child: child
    );
  }
}
