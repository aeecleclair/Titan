import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/associations_pictures_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

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
          child: CardLayout(
              margin: EdgeInsets.zero,
              child: Row(children: [
                AutoLoaderChild(
                  value: associationPictures,
                  notifier: associationPicturesNotifier,
                  mapKey: association,
                  loader: (association) => associationPictureNotifier
                      .getAssociationPicture(association.id),
                  dataBuilder: (context, value) => Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: value.first.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  association.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  giveMemberRole
                      ? member.memberships
                          .firstWhere((element) =>
                              element.associationId == association.id)
                          .apparentName
                      : association.kind,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])),
        ));
  }
}
