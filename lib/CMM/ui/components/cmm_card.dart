import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/CMM/providers/ban_user_list_provider.dart';
import 'package:myecl/CMM/providers/hidden_cmm_list_provider.dart';
import 'package:myecl/CMM/providers/is_cmm_admin_provider.dart';
import 'package:myecl/CMM/providers/profile_picture_repository.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class CMMCard extends ConsumerStatefulWidget {
  final CMM cmm;
  final Uint8List image;
  final PageType page;
  const CMMCard(
      {super.key, required this.cmm, required this.image, required this.page});

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
    final hiddenCMMListNotifier = ref.watch(hiddenCMMProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
                if (widget.page == PageType.scrolling)
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
                                      color:
                                          Colors.black.withValues(alpha: 0.1),
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
                if (widget.page != PageType.myPost)
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
                if (widget.page == PageType.scrolling) ...[
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
                    icon: Icon(
                      Icons.keyboard_double_arrow_up,
                      size: 35,
                      color: upButtonColor,
                    ),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Cacher un meme",
                              descriptions:
                                  "Voulez-vous vraiment cacher ce meme ?",
                              onYes: () async {
                                final value = await hiddenCMMListNotifier
                                    .hideCMM(widget.cmm.id);
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    "Meme caché",
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    "Erreur lors l'invisibilisation du meme",
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.visibility_off_outlined,
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Bannir un utilisateur",
                              descriptions:
                                  "Voulez-vous vraiment bannir cet utilisateur ?",
                              onYes: () async {
                                final value = await banNotifier
                                    .banUser(widget.cmm.user.id);
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    "Utilisateur banni",
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    "Erreur lors du bannissement de l'utilisateur",
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.block,
                        size: 30,
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                ],
                if (widget.page == PageType.myPost) ...[
                  Text(
                    voteScore.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "Supprimer un meme",
                            descriptions:
                                "Voulez-vous vraiment supprimer ce meme ?",
                            onYes: () async {
                              final value =
                                  await cmmListNotifier.deleteCMM(widget.cmm);
                              if (value) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  "Meme supprimé",
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  "Erreur lors de la suppression du meme",
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                ],
                if (widget.page == PageType.hidden) ...[
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "Rendre visible un meme",
                            descriptions:
                                "Voulez-vous vraiment rendre à nouveau visible ce meme ?",
                            onYes: () async {
                              final value = await hiddenCMMListNotifier
                                  .showCMM(widget.cmm.id);
                              if (value) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  "Meme rendu visible",
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  "Erreur lors de la visibilisation du meme",
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.visibility_outlined,
                      color: Colors.green,
                      size: 30,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                ],
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
