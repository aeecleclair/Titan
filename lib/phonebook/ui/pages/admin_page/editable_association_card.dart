import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/associations_pictures_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/delete_button.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/edition_button.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class EditableAssociationCard extends HookConsumerWidget {
  final Association association;
  final void Function() onEdit;
  final Future Function() onDelete;
  const EditableAssociationCard(
      {super.key,
      required this.association,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationPictures = ref.watch(associationPicturesProvider);
    final associationPicturesNotifier =
        ref.watch(associationPicturesProvider.notifier);
    final associationPictureNotifier =
        ref.watch(associationPictureProvider.notifier);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2)
          ]),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
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
                      Future.delayed(
                          const Duration(milliseconds: 1),
                          () => associationPicturesNotifier.setTData(
                              association, const AsyncLoading()));
                      tokenExpireWrapper(ref, () async {
                        associationPictureNotifier
                            .getAssociationPicture(association.id)
                            .then((value) {
                          associationPicturesNotifier.setTData(
                              association, AsyncData([value]));
                        });
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
                      child: Text(
                          PhonebookTextConstants.errorLoadAssociationPicture),
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
                child: Text(PhonebookTextConstants.errorLoadAssociationPicture),
              );
            },
          ),
          const SizedBox(width: 10),
          Text(
            association.name,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(association.kind,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          EditionButton(onEdition: onEdit),
          const SizedBox(width: 10),
          DeleteButton(onDelete: onDelete),
        ],
      ),
    );
  }
}
