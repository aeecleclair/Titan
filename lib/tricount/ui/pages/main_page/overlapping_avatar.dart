import 'package:flutter/material.dart';
import 'package:myecl/user/class/list_users.dart';

class OverlappingAvatar extends StatelessWidget {
  final List<SimpleUser> users;
  const OverlappingAvatar({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final numberToDisplay = users.length > 5 ? 4 : users.length;
    final displayRemaining = users.length != numberToDisplay;
    return Stack(
      children: [
        for (var i = 0; i < numberToDisplay; i++)
          Positioned(
            right:
                22.0 * (numberToDisplay - i - 1 + (displayRemaining ? 1 : 0)),
            top: 0,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xff1C4668),
                foregroundColor: const Color(0xffF6F4EB),
                child: Text(users[i].nickname != null
                    ? users[i].nickname!.substring(0, 3)
                    : ""),
              ),
            ),
          ),
        if (displayRemaining)
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xff1C4668),
                foregroundColor: const Color(0xffF6F4EB),
                child: Text("+${users.length - numberToDisplay}"),
              ),
            ),
          )
      ],
    );
  }
}
