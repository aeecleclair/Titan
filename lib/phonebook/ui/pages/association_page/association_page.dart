import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_member_sorted_list_provider.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/ui/components/member_card.dart';
import 'package:titan/phonebook/ui/pages/association_page/association_edition_modal.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';

class AssociationPage extends HookConsumerWidget {
  const AssociationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationMemberList = ref.watch(associationMemberListProvider);
    final associationMemberSortedList = ref.watch(
      associationMemberSortedListProvider,
    );
    final associationMemberListNotifier = ref.watch(
      associationMemberListProvider.notifier,
    );
    final associationPicture = ref.watch(associationPictureProvider);
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );
    final isPresident = ref.watch(isAssociationPresidentProvider);
    final associationGroupement = ref.watch(associationGroupementProvider);

    final localizeWithContext = AppLocalizations.of(context)!;
    return PhonebookTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await associationMemberListNotifier.loadMembers(
            association.id,
            association.mandateYear,
          );
          await associationPictureNotifier.getAssociationPicture(
            association.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              AsyncChild(
                value: associationPicture,
                builder: (context, image) {
                  return Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: image.image,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      association.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 40, color: Colors.black),
                    ),
                  ),
                  if (isPresident) ...[
                    const SizedBox(width: 10),
                    CustomIconButton.secondary(
                      onPressed: () {
                        showCustomBottomModal(
                          context: context,
                          modal: AssociationEditionModal(
                            association: association,
                            groupement: associationGroupement,
                          ),
                          ref: ref,
                        );
                      },
                      icon: const HeroIcon(HeroIcons.pencilSquare, size: 30),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              Text(
                associationGroupement.name,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                localizeWithContext.phonebookTerm(association.mandateYear),
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Text(
                association.description,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 20),
              AsyncChild(
                value: associationMemberList,
                builder: (context, associationMembers) =>
                    associationMembers.isEmpty
                    ? Text(localizeWithContext.phonebookNoMember)
                    : Column(
                        children: associationMemberSortedList
                            .map(
                              (member) => MemberCard(
                                member: member,
                                association: association,
                                deactivated: false,
                              ),
                            )
                            .toList(),
                      ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
