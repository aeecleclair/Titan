import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/providers/is_cmm_admin_provider.dart';
import 'package:myecl/CMM/providers/profile_picture_repository.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class CMMCard extends ConsumerWidget {
  final String string;
  const CMMCard({
    super.key,
    required this.string,
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.orange, width: 4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            print("pressed");
                          },
                          icon: const Icon(
                            Icons.arrow_upward,
                            size: 20, // Ajustez la taille de l'icône
                          ),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 40, // Largeur du bouton
                            minHeight: 40, // Hauteur du bouton
                          ),
                        ),
                        Text("500"),
                        IconButton(
                          onPressed: () {
                            print("pressed");
                          },
                          icon: const Icon(
                            Icons.arrow_downward,
                            size: 20, // Ajustez la taille de l'icône
                          ),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                            minWidth: 40, // Largeur du bouton
                            minHeight: 40, // Hauteur du bouton
                          ),
                        ),
                        if (isAdmin)
                          ElevatedButton(
                            onPressed: () {
                              print("pressed");
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              Icons.delete,
                              size: 10,
                            ),
                          ),
                        if (isAdmin)
                          ElevatedButton(
                            onPressed: () {
                              print("pressed");
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              Icons.block,
                              size: 10,
                            ),
                          ),
                      ],
                    ),
                    Spacer(),
                    Text("Foucauld Bellanger (Ñool)"),
                    AsyncChild(
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
                                  radius: 15,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
