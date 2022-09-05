import 'package:flutter/material.dart';

class Event {
  String title;
  Color color;
  DateTime startTime;
  DateTime endTime;
  Event(
      {required this.title,
      required this.color,
      required this.startTime,
      required this.endTime});
}
