import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class AccountButton extends StatelessWidget {
  final HeroIcons icon;
  final String title;
  final Future<dynamic> Function() onPressed;
  const AccountButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        WaitingButton(
          onTap: onPressed,
          builder: (child) => Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: [Color(0xff017f80), Color.fromARGB(255, 4, 84, 84)],
                center: Alignment.topLeft,
                radius: 1.5,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 4, 84, 84).withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: child,
          ),
          child: HeroIcon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff017f80),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
