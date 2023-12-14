import 'package:flutter/material.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/elocaps/tools/constants.dart';

class PodiumCard extends StatelessWidget {
  const PodiumCard(
      {Key? key, required this.player, required this.index, required this.isMe})
      : super(key: key);

  final Player player;
  final int index;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final Color color = ElocapsColorConstant.podium_color[index];

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          isMe
              ? CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.network(
                        "https://www.gravatar.com/avatar/${player.user.id}?d=identicon",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.network(
                      "https://www.gravatar.com/avatar/${player.user.id}?d=identicon",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          const SizedBox(height: 7),
          Text(player.user.nickname ?? player.user.firstname,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.5),
                  color,
                ],
                center: Alignment.topLeft,
                radius: 1.5,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: 90.0 - 15 * index - (isMe ? 5 : 0),
            width: 60,
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              player.elo.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
