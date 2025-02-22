import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/meme/providers/ban_user_list_provider.dart';
import 'package:myecl/meme/providers/meme_pictures_provider.dart';
import 'package:myecl/meme/providers/hidden_meme_list_provider.dart';
import 'package:myecl/meme/providers/is_meme_admin_provider.dart';
import 'package:myecl/phonebook/providers/profile_picture_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class MemeCard extends ConsumerWidget {
  final String memeId;
  final Uint8List image;
  final PageType page;
  const MemeCard({
    super.key,
    required this.memeId,
    required this.image,
    required this.page,
  });

  get memePictures => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isMemeAdminProvider);
    final memeListNotifier = ref.watch(memeListProvider.notifier);
    final banNotifier = ref.watch(bannedUsersProvider.notifier);
    final hiddenMemeListNotifier = ref.watch(hiddenMemeListProvider.notifier);
    final memeList = ref.watch(memeListProvider);
    final memePictures =
        ref.watch(memePicturesProvider.select((value) => value[memeId]));
    final memePicturesNotifier = ref.watch(memePicturesProvider.notifier);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: memeList,
      builder: (context, memeList) {
        final meme = memeList.where((e) => e.id == memeId).first;

        return Center(
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
                    if (page == PageType.scrolling)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoLoaderChild(
                          group: memePictures,
                          notifier: memePicturesNotifier,
                          mapKey: memeId,
                          loader: (ref) => profilePictureNotifier
                              .getProfilePicture(meme.user.id),
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
                    if (page != PageType.myPost)
                      Text(
                        meme.user.nickname != null
                            ? meme.user.nickname!
                            : "${meme.user.firstname} ${meme.user.name}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onDoubleTap: () {
                      if (meme.myVote == null) {
                        memeListNotifier.addVoteToMeme(meme, true);
                        // _changeColor(true, Colors.green);
                        // updateVote(true, 1);
                        // updateMyVote(true);
                      } else if (!meme.myVote!) {
                        memeListNotifier.updateVoteToMeme(meme, true);
                        // _changeColor(true, Colors.green);
                        // _changeColor(false, Colors.grey);
                        // updateVote(true, 2);
                        // updateMyVote(true);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height - 327,
                          maxWidth: double.infinity,
                        ),
                        child: meme.status == "neutral"
                            ? Image.memory(
                                image,
                                fit: BoxFit.cover,
                              )
                            : Stack(
                                children: [
                                  // Image de fond
                                  Image.memory(
                                    image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  // Filtre gris semi-transparent
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.black.withValues(
                                      alpha: 0.3,
                                    ), // Opacité réglable
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
                    if (page == PageType.scrolling) ...[
                      IconButton(
                        onPressed: () {
                          if (meme.myVote == null) {
                            memeListNotifier.addVoteToMeme(meme, true);
                            // _changeColor(true, Colors.green);
                            // updateVote(true, 1);
                            // updateMyVote(true);
                          } else if (!meme.myVote!) {
                            memeListNotifier.updateVoteToMeme(meme, true);
                            // _changeColor(true, Colors.green);
                            // _changeColor(false, Colors.grey);
                            // updateVote(true, 2);
                            // updateMyVote(true);
                          } else if (meme.myVote!) {
                            memeListNotifier.deleteVoteToMeme(meme);
                            // _changeColor(true, Colors.grey);
                            // updateVote(true, null);
                            // updateMyVote(null);
                          }
                        },
                        icon: Icon(
                          Icons.keyboard_double_arrow_up,
                          size: 35,
                          color: meme.myVote == null
                              ? Colors.grey
                              : meme.myVote!
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                      Text(
                        meme.voteScore.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          if (meme.myVote == null) {
                            memeListNotifier.addVoteToMeme(meme, false);
                            // _changeColor(false, Colors.red);
                            // updateVote(false, -1);
                            // updateMyVote(false);
                          } else if (meme.myVote!) {
                            memeListNotifier.updateVoteToMeme(meme, false);
                            // _changeColor(true, Colors.grey);
                            // _changeColor(false, Colors.red);
                            // updateVote(false, -2);
                            // updateMyVote(false);
                          } else if (!meme.myVote!) {
                            memeListNotifier.deleteVoteToMeme(meme);
                            // _changeColor(false, Colors.grey);
                            // updateVote(false, null);
                            // updateMyVote(null);
                          }
                        },
                        icon: Icon(
                          Icons.keyboard_double_arrow_down,
                          size: 35,
                          color: meme.myVote == null
                              ? Colors.grey
                              : meme.myVote!
                                  ? Colors.grey
                                  : Colors.red,
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
                                  title: MemeTextConstant.hideMeme,
                                  descriptions: MemeTextConstant.wantToHideMeme,
                                  onYes: () async {
                                    final value = await hiddenMemeListNotifier
                                        .hideMeme(meme.id);
                                    if (value) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        MemeTextConstant.hiddenMeme,
                                      );
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        MemeTextConstant.errorHiddingMeme,
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
                                  title: MemeTextConstant.banUser,
                                  descriptions: MemeTextConstant.wantToBanUser,
                                  onYes: () async {
                                    final value =
                                        await banNotifier.banUser(meme.user.id);
                                    if (value) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        MemeTextConstant.bannedUser,
                                      );
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        MemeTextConstant.errorBanningUser,
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
                    if (page == PageType.myPost) ...[
                      Text(
                        meme.voteScore.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: MemeTextConstant.deleteMeme,
                                descriptions: MemeTextConstant.wantToDeleteMeme,
                                onYes: () async {
                                  final value =
                                      await memeListNotifier.deleteMeme(meme);
                                  if (value) {
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      MemeTextConstant.deletedMeme,
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      MemeTextConstant.errorDeletingMeme,
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
                    if (page == PageType.hidden) ...[
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: MemeTextConstant.showMeme,
                                descriptions: MemeTextConstant.wantToShowMeme,
                                onYes: () async {
                                  final value = await hiddenMemeListNotifier
                                      .showMeme(meme.id);
                                  if (value) {
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      MemeTextConstant.showedMeme,
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      MemeTextConstant.errorShowingMeme,
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
      },
    );
  }
}
