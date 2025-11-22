import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_kind_provider.dart';
import 'package:titan/phonebook/providers/association_member_sorted_list_provider.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/phonebook/providers/is_phonebook_admin_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/pages/association_page/member_card.dart';
import 'package:titan/phonebook/ui/pages/association_page/web_member_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

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
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );
    final isPresident = ref.watch(isAssociationPresidentProvider);
    final kindNotifier = ref.watch(associationKindProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationMemberListNotifier.loadMembers(
            association.id,
            association.mandateYear.toString(),
          );
          await associationPictureNotifier.getAssociationPicture(
            association.id,
          );
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    association.name,
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        association.kind,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: associationMemberSortedList
                                  .map(
                                    (completeMember) =>
                                        completeMember.member.email,
                                  )
                                  .join(","),
                            ),
                          ).then((value) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              PhonebookTextConstants.emailListCopied,
                            );
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400.withValues(
                                  alpha: 0.3,
                                ),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(2, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const HeroIcon(
                            HeroIcons.documentDuplicate,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    association.description,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${PhonebookTextConstants.activeMandate} ${association.mandateYear}",
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  AsyncChild(
                    value: associationMemberList,
                    builder: (context, associationMembers) =>
                        associationMembers.isEmpty
                        ? const Text(PhonebookTextConstants.noMember)
                        : Column(
                            children: associationMemberSortedList
                                .map(
                                  (member) => kIsWeb
                                      ? WebMemberCard(
                                          member: member,
                                          association: association,
                                        )
                                      : MemberCard(
                                          member: member,
                                          association: association,
                                        ),
                                )
                                .toList(),
                          ),
                  ),
                ],
              ),
              if (isPresident)
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      kindNotifier.setKind(association.kind);
                      QR.to(
                        PhonebookRouter.root +
                            PhonebookRouter.associationDetail +
                            PhonebookRouter.editAssociation,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const RadialGradient(
                          colors: [
                            Color.fromARGB(255, 98, 98, 98),
                            Color.fromARGB(255, 27, 27, 27),
                          ],
                          center: Alignment.topLeft,
                          radius: 1.3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              27,
                              27,
                              27,
                            ).withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                              3,
                              3,
                            ), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const HeroIcon(
                        HeroIcons.pencil,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
