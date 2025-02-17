import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/meme/providers/ban_user_list_provider.dart';
import 'package:myecl/meme/providers/meme_pictures_provider.dart';
import 'package:myecl/meme/providers/hidden_meme_list_provider.dart';
import 'package:myecl/meme/providers/is_meme_admin_provider.dart';
import 'package:myecl/phonebook/providers/profile_picture_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class MemeCard extends ConsumerStatefulWidget {
  final Meme meme;
  final Uint8List image;
  final PageType page;
  const MemeCard({
    super.key,
    required this.meme,
    required this.image,
    required this.page,
  });

  @override
  MemeCardState createState() => MemeCardState();
}

class MemeCardState extends ConsumerState<MemeCard> {
  final GlobalKey _key = GlobalKey();
  late Color upButtonColor;
  late Color downButtonColor;
  late int voteScore;
  late bool? myVote;
  @override
  void initState() {
    super.initState();
    upButtonColor = (widget.meme.myVote != null && widget.meme.myVote!)
        ? Colors.green
        : Colors.grey;
    downButtonColor = (widget.meme.myVote != null && !widget.meme.myVote!)
        ? Colors.red
        : Colors.grey;
    voteScore = widget.meme.voteScore;
    myVote = widget.meme.myVote;
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

  void updateVote(bool up, int? i) {
    setState(() {
      if (i != null) {
        voteScore = voteScore + i;
      } else {
        if (up) {
          voteScore = voteScore - 1;
        } else {
          voteScore = voteScore + 1;
        }
      }
    });
  }

  void updateMyVote(bool? b) {
    setState(() {
      myVote = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = ref.watch(isMemeAdminProvider);
    final memeListNotifier = ref.watch(memeListProvider.notifier);
    final banNotifier = ref.watch(bannedUsersProvider.notifier);
    final hiddenMemeListNotifier = ref.watch(hiddenMemeListProvider.notifier);
    final memePictures =
        ref.watch(memePicturesProvider.select((value) => value[widget.meme]));
    final memePicturesNotifier = ref.watch(memePicturesProvider.notifier);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
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
                    child: AutoLoaderChild(
                      group: memePictures,
                      notifier: memePicturesNotifier,
                      mapKey: widget.meme,
                      loader: (ref) => profilePictureNotifier
                          .getProfilePicture(widget.meme.user.id),
                      loadingBuilder: (context) => const CircleAvatar(
                        radius: 20,
                        child: CircularProgressIndicator(),
                      ),
                      dataBuilder: (context, data) => CircleAvatar(
                        radius: 20,
                        backgroundImage: data.first.image,
                      ),
                    ),
                  ),
                if (widget.page != PageType.myPost)
                  Text(
                    widget.meme.user.nickname != null
                        ? widget.meme.user.nickname!
                        : "${widget.meme.user.firstname} ${widget.meme.user.name}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onDoubleTap: () {
                  if (myVote == null) {
                    memeListNotifier.addVoteToMeme(widget.meme, true);
                    _changeColor(true, Colors.green);
                    updateVote(true, 1);
                    updateMyVote(true);
                  } else if (!myVote!) {
                    memeListNotifier.updateVoteToMeme(widget.meme, true);
                    _changeColor(true, Colors.green);
                    _changeColor(false, Colors.grey);
                    updateVote(true, 2);
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
                    child: widget.meme.status == "neutral"
                        ? Image.memory(
                            widget.image,
                            fit: BoxFit.cover,
                          )
                        : Stack(
                            children: [
                              // Image de fond
                              Image.memory(
                                widget.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              // Filtre gris semi-transparent
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.black
                                    .withValues(alpha: 0.3), // Opacité réglable
                              ),
                              // Icône "œil caché" au centre
                              Center(
                                child: Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                  size: 50, // Taille réglable
                                ),
                              ),
                            ],
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
                        memeListNotifier.addVoteToMeme(widget.meme, true);
                        _changeColor(true, Colors.green);
                        updateVote(true, 1);
                        updateMyVote(true);
                      } else if (!myVote!) {
                        memeListNotifier.updateVoteToMeme(widget.meme, true);
                        _changeColor(true, Colors.green);
                        _changeColor(false, Colors.grey);
                        updateVote(true, 2);
                        updateMyVote(true);
                      } else if (myVote!) {
                        memeListNotifier.deleteVoteToMeme(widget.meme);
                        _changeColor(true, Colors.grey);
                        updateVote(true, null);
                        updateMyVote(null);
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
                        memeListNotifier.addVoteToMeme(widget.meme, false);
                        _changeColor(false, Colors.red);
                        updateVote(false, -1);
                        updateMyVote(false);
                      } else if (myVote!) {
                        memeListNotifier.updateVoteToMeme(widget.meme, false);
                        _changeColor(true, Colors.grey);
                        _changeColor(false, Colors.red);
                        updateVote(false, -2);
                        updateMyVote(false);
                      } else if (!myVote!) {
                        memeListNotifier.deleteVoteToMeme(widget.meme);
                        _changeColor(false, Colors.grey);
                        updateVote(false, null);
                        updateMyVote(null);
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
                                final value = await hiddenMemeListNotifier
                                    .hideMeme(widget.meme.id);
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
                                    .banUser(widget.meme.user.id);
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
                              final value = await memeListNotifier
                                  .deleteMeme(widget.meme);
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
                              final value = await hiddenMemeListNotifier
                                  .showMeme(widget.meme.id);
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
