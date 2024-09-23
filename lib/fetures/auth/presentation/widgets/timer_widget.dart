import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:x_ray2/constants.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key, this.onEnd});
  final void Function()? onEnd;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TimerCountdown(
        format: CountDownTimerFormat.secondsOnly,
        endTime: DateTime.now().add(const Duration(seconds: timerCounter)),
        onEnd: onEnd,
        timeTextStyle: const TextStyle(fontSize: 24),
      ),
    );
  }
}

