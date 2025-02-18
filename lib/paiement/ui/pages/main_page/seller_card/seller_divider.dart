import 'package:flutter/material.dart';

class SellerDivider extends StatelessWidget {
  const SellerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 199, 90, 1),
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Text(
                "AEECL",
                style: TextStyle(
                  color: Color.fromARGB(255, 199, 90, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Color.fromARGB(255, 199, 90, 1),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
