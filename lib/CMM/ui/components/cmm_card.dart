import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/providers/is_cmm_admin_provider.dart';
import 'package:myecl/CMM/providers/profile_picture_repository.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/user/class/list_users.dart';

class CMMCard extends ConsumerWidget {
  final String string;
  final SimpleUser user;
  final int vote;
  final int score;
  const CMMCard({
    super.key,
    required this.string,
    required this.user,
    required this.vote,
    required this.score,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isCMMAdminProvider);
    final profilePicture = ref.watch(profilePictureProvider);
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
                                    color: Colors.black.withOpacity(0.1),
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
                  user.nickname != ""
                      ? user.nickname!
                      : "${user.firstname} ${user.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onDoubleTap: () => print("liked"),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 250,
                      maxWidth: double.infinity, // Max width
                    ),
                    child: Image.asset(
                      string,
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
                        print("pressed");
                      },
                      icon: Icon(
                        Icons.keyboard_double_arrow_up,
                        size: 35,
                        color: vote > 0
                            ? Colors.green
                            : Colors.grey, // Ajustez la taille de l'icône
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40, // Largeur du bouton
                        minHeight: 40, // Hauteur du bouton
                      ),
                    ),
                    Text(
                      score.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        print("pressed");
                      },
                      icon: Icon(
                        Icons.keyboard_double_arrow_down,
                        size: 35,
                        color: vote < 0 ? Colors.red : Colors.grey,
                        // Ajustez la taille de l'icône
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40, // Largeur du bouton
                        minHeight: 40, // Hauteur du bouton
                      ),
                    ),
                    if (isAdmin)
                      IconButton(
                        onPressed: () {
                          print("pressed");
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 30, // Ajustez la taille de l'icône
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40, // Largeur du bouton
                          minHeight: 40, // Hauteur du bouton
                        ),
                      ),
                    if (isAdmin)
                      IconButton(
                        onPressed: () {
                          print("pressed");
                        },
                        icon: const Icon(
                          Icons.block,
                          size: 30, // Ajustez la taille de l'icône
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40, // Largeur du bouton
                          minHeight: 40, // Hauteur du bouton
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
