import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class EventCountdown extends StatelessWidget {
  final DateTime duration;

  const EventCountdown({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: 20,
      build: (BuildContext context, double time) => Text(
        time.toString(),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      interval: Duration(milliseconds: 100),
      onFinished: () {
        print('Timer is done!');
      },
    );
  }
}
