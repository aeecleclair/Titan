import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SessionCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final String sessionName;

  const SessionCard({
    super.key,
    required this.onTap,
    required this.sessionName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = 300;
    double height = 100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(210, 227, 227, 227),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(2, 2),
              spreadRadius: 3,
              color: Color(0x33000000),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sessionName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Text(
              "Details",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
