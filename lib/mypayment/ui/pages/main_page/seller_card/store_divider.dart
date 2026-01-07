import 'package:flutter/material.dart';

class StoreDivider extends StatelessWidget {
  final String name;
  const StoreDivider({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 5),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: Color.fromARGB(255, 0, 29, 29), thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Divider(color: Color.fromARGB(255, 0, 29, 29), thickness: 1),
          ),
        ],
      ),
    );
  }
}
