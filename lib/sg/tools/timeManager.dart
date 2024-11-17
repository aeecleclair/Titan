import 'dart:async';
import 'package:flutter/material.dart';

class TimeDifferenceWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onTimeElapsed;
  final bool b;

  const TimeDifferenceWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onTimeElapsed,
    required this.b,
  });

  @override
  _TimeDifferenceWidgetState createState() => _TimeDifferenceWidgetState();
}

class _TimeDifferenceWidgetState extends State<TimeDifferenceWidget> {
  late Timer _timer;
  late Duration _difference;

  @override
  void initState() {
    super.initState();
    _updateDifference();
    _scheduleNextUpdate();
  }

  void _updateDifference() {
    setState(() {
      _difference = widget.b
          ? widget.startDate.difference(DateTime.now())
          : DateTime.now().difference(widget.endDate);

      // Vérifie si le temps est écoulé et déclenche l'action
      if (_difference.inSeconds <= 1) {
        widget.onTimeElapsed(); // Appel du callback
      }
    });
  }

  void _scheduleNextUpdate() {
    Duration refreshInterval;
    if (_difference.inMinutes < 60) {
      refreshInterval = const Duration(seconds: 1);
    } else if (_difference.inHours < 24) {
      refreshInterval = const Duration(minutes: 1);
    } else if (_difference.inHours < 24) {
      refreshInterval = const Duration(hours: 1);
    } else {
      refreshInterval = const Duration(hours: 1);
    }

    _timer = Timer(refreshInterval, () {
      _updateDifference();
      _scheduleNextUpdate();
    });
  }

  String _getFormattedDifference() {
    if (_difference.inSeconds < 60) {
      return widget.b
          ? "Dans ${_difference.inSeconds} s"
          : "Il y a ${_difference.inSeconds} s";
    } else if (_difference.inMinutes < 60) {
      int seconds = _difference.inSeconds % 60;
      return widget.b
          ? "Dans ${_difference.inMinutes} min $seconds s"
          : "Il y a ${_difference.inMinutes} min $seconds s";
    } else if (_difference.inHours < 24) {
      int minutes = _difference.inMinutes % 60;
      return widget.b
          ? "Dans ${_difference.inHours} h $minutes min"
          : "Il y a ${_difference.inHours} h $minutes min";
    } else {
      int hours = _difference.inHours % 24;
      return widget.b
          ? "Dans ${_difference.inDays} j $hours h"
          : "Il y a ${_difference.inDays} j $hours h";
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getFormattedDifference(),
      style: const TextStyle(fontSize: 15),
    );
  }
}
