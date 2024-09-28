
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:x_ray2/constants.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.h = 24, this.w = 32});
  final double? h;
  final double? w;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: h,
      width: w,
      child: const LoadingIndicator(
          indicatorType: Indicator.lineScalePulseOut,
          colors: [
            blueColor,
            Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
          ]),
    ));
  }
}
