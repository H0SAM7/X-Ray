
import 'package:flutter/material.dart';
import 'package:x_ray2/core/utils/app_styles.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key, this.onTap, this.child, this.color, this.height,
  });
 final Color? color;
 final double? height;
  final Widget? child;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height:height?? 50,
        width: 300,
        decoration: BoxDecoration(
          color: color?? const Color.fromARGB(255, 68, 92, 212),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: child
        ),
      ),
    );
  }
}