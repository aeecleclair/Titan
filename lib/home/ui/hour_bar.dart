import 'package:flutter/material.dart';

class HourBar extends StatelessWidget {
  const HourBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> hourBar = [];
    for (int i = 0; i < 24; i++) {
      hourBar.add(Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 3,
              width: 40,
              color: Colors.grey.shade500.withOpacity(0.4),
            ),
            Row(
              children: [
                const SizedBox(width: 40),
                Text("$i:00",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700)),
              ],
            ),
            Container(
              height: 3,
              width: 20,
              color: Colors.grey.shade500.withOpacity(0.2),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
    }
    hourBar.add(
      Container(
        height: 3,
        width: 40,
        color: Colors.grey.shade500.withOpacity(0.4),
      ),
    );
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: hourBar);
  }
}
