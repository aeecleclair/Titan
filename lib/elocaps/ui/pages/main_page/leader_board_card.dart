import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/class/player.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/user/providers/profile_picture_provider.dart';

class LeaderBoardCard extends HookConsumerWidget {
  final Player player;
  final int index;
  final bool isMe;
  const LeaderBoardCard({
    super.key,
    required this.player,
    required this.index,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePicture = ref.watch(profilePictureProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      child: Row(
        children: [
          Text(
            index.toString().padLeft(2, '0'),
            style: const TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.user.nickname ?? player.user.firstname,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${player.elo}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 20),
                  AsyncChild(
                    value: profilePicture,
                    builder: (context, profile) {
                      return isMe
                          ? CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: Image.memory(
                                    profile,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.memory(
                                  profile,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                    },
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
