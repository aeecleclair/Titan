import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/CMM/providers/cmm_ban_provider.dart';
import 'package:myecl/CMM/providers/is_cmm_admin_provider.dart';
import 'package:myecl/CMM/providers/profile_picture_repository.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class CMMCard extends ConsumerStatefulWidget {
  final CMM cmm;
  final Uint8List image;
  const CMMCard({
    super.key,
    required this.cmm,
    required this.image,
  });

  @override
  CMMCardState createState() => CMMCardState();
}

class CMMCardState extends ConsumerState<CMMCard> {
  final GlobalKey _key = GlobalKey();
  late Color upButtonColor;
  late Color downButtonColor;
  late int voteScore;
  late bool? myVote;
  @override
  void initState() {
    super.initState();
    upButtonColor = (widget.cmm.myVote != null && widget.cmm.myVote!)
        ? Colors.green
        : Colors.grey;
    downButtonColor = (widget.cmm.myVote != null && !widget.cmm.myVote!)
        ? Colors.red
        : Colors.grey;
    voteScore = widget.cmm.voteScore;
    myVote = widget.cmm.myVote;
  }

  void _changeColor(bool up, Color color) {
    if (up) {
      setState(() {
        upButtonColor = color;
      });
    } else {
      setState(() {
        downButtonColor = color;
      });
    }
  }

  void updateVote(int i) {
    setState(() {
      voteScore = voteScore + i;
    });
  }

  void updateMyVote(bool b) {
    setState(() {
      myVote = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isCMMAdminProvider);
    final profilePicture = ref.watch(profilePictureProvider);
    final cmmListNotifier = ref.watch(cmmListProvider.notifier);
    final banNotifier = ref.watch(bannedUsersProvider.notifier);
    return Center(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AsyncChild(
                    value: profilePicture,
                    builder: (context, file) => Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: file.isEmpty
                                    ? AssetImage(getTitanLogo())
                                    : Image.memory(file).image,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  widget.cmm.user.nickname != null
                      ? widget.cmm.user.nickname!
                      : "${widget.cmm.user.firstname} ${widget.cmm.user.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onDoubleTap: () {
                  if (myVote == null) {
                    cmmListNotifier.addVoteToCMM(widget.cmm, true);
                    _changeColor(true, Colors.green);
                    updateVote(1);
                    updateMyVote(true);
                  } else if (!myVote!) {
                    cmmListNotifier.updateVoteToCMM(widget.cmm, true);
                    _changeColor(true, Colors.green);
                    _changeColor(false, Colors.grey);
                    updateVote(2);
                    updateMyVote(true);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 320,
                      maxWidth: double.infinity,
                    ),
                    child: Image.memory(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (myVote == null) {
                          cmmListNotifier.addVoteToCMM(widget.cmm, true);
                          _changeColor(true, Colors.green);
                          updateVote(1);
                          updateMyVote(true);
                        } else if (!myVote!) {
                          cmmListNotifier.updateVoteToCMM(widget.cmm, true);
                          _changeColor(true, Colors.green);
                          _changeColor(false, Colors.grey);
                          updateVote(2);
                          updateMyVote(true);
                        }
                      },
                      icon: Icon(Icons.keyboard_double_arrow_up,
                          size: 35, color: upButtonColor),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                    Text(
                      voteScore.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        if (myVote == null) {
                          cmmListNotifier.addVoteToCMM(widget.cmm, false);
                          _changeColor(false, Colors.red);
                          updateVote(-1);
                          updateMyVote(false);
                        } else if (myVote!) {
                          cmmListNotifier.updateVoteToCMM(widget.cmm, false);
                          _changeColor(true, Colors.grey);
                          _changeColor(false, Colors.red);
                          updateVote(-2);
                          updateMyVote(false);
                        }
                      },
                      icon: Icon(
                        Icons.keyboard_double_arrow_down,
                        size: 35,
                        color: downButtonColor,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                    if (isAdmin)
                      IconButton(
                        onPressed: () {
                          print("pressed");
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 30,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                    if (isAdmin)
                      IconButton(
                        onPressed: () {
                          banNotifier.banUser(widget.cmm.user.id);
                        },
                        icon: const Icon(
                          Icons.block,
                          size: 30,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
