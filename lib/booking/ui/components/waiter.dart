import 'package:flutter/material.dart';

class Waiter extends StatelessWidget {
  final Color color;
  const Waiter({super.key, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}
