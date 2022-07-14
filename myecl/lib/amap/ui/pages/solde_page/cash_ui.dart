import 'package:flutter/material.dart';
import 'package:myecl/amap/class/cash.dart';

class CashUi extends StatelessWidget {
  final Cash c;
  final int i;
  const CashUi({Key? key, required this.c, required this.i}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 70,
          alignment: Alignment.center,
          child: Text(
            c.balance.toString(),
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}