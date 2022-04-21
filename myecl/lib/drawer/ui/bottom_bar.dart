import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Container(
                width: 25,
              ),
              FaIcon(
                FontAwesomeIcons.gear,
                color: Colors.grey.shade100.withOpacity(0.6),
                size: 25,
              ),
              Container(
                width: 15,
              ),
              Text("Paramètres",
                  style: TextStyle(
                    color: Colors.grey.shade100.withOpacity(0.6),
                    fontSize: 15,
                  ))
            ],
          ),
        ),
        Container(
          height: 20,
        )
      ],
    );
  }
}
