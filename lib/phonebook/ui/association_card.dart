import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/associations_pictures_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class AssociationCard extends HookConsumerWidget {
  const AssociationCard({
    super.key,
    required this.association,
    required this.onClicked,
  });

  final Association association;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationPictures = ref.watch(associationPicturesProvider);
    final associationPicturesNotifier =
        ref.watch(associationPicturesProvider.notifier);
    final associationPictureNotifier =
        ref.watch(associationPictureProvider.notifier);

    return GestureDetector(
        onTap: () {
          onClicked();
        },
        child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(children: [
              associationPictures.when(
                data: (pictures) {
                  if (pictures[association] != null) {
                    return pictures[association]!.when(
                      data: (picture) {
                        if (picture.isNotEmpty) {
                          return Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: picture.first.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          associationPictureNotifier
                              .getAssociationPicture(association.id)
                              .then((value) {
                            associationPicturesNotifier.setTData(
                                association,
                                AsyncData([
                                  value.when(
                                    data: (picture) => picture,
                                    loading: () =>
                                        Image.asset("assets/images/logo.png"),
                                    error: (e, s) =>
                                        Image.asset("assets/images/logo.png"),
                                  )
                                ]));
                          });
                          return const HeroIcon(
                            HeroIcons.userCircle,
                            size: 40,
                          );
                        }
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      error: (e, s) {
                        return const Center(
                          child: Text(PhonebookTextConstants
                              .errorLoadAssociationPicture),
                        );
                      },
                    );
                  }
                  return const HeroIcon(
                    HeroIcons.userCircle,
                    size: 40,
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (e, s) {
                  return const Center(
                    child: Text(
                        PhonebookTextConstants.errorLoadAssociationPicture),
                  );
                },
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: Text(
                  association.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Text(
                association.kind,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])));
  }
}
