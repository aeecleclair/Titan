import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/associations_pictures_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssociationCard extends HookConsumerWidget {
  const AssociationCard({
    super.key,
    required this.association,
    required this.onClicked,
    required this.giveMemberRole,
  });

  final Association association;
  final VoidCallback onClicked;
  final bool giveMemberRole;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationPictures = ref.watch(associationPicturesProvider);
    final associationPicturesNotifier =
        ref.watch(associationPicturesProvider.notifier);
    final associationPictureNotifier =
        ref.watch(associationPictureProvider.notifier);
    final member = ref.watch(completeMemberProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
          onTap: onClicked,
          child: Container(
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
                Text(
                  association.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  giveMemberRole
                      ? member.memberships
                          .firstWhere((element) =>
                              element.association.id == association.id)
                          .apparentName
                      : association.kind,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]))),
    );
  }
}
