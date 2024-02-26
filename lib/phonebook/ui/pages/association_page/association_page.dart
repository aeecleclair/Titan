import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_admin_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/association_page/member_card.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AssociationPage extends HookConsumerWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationPicture = ref.watch(associationPictureProvider);
    final associationMemberList = ref.watch(associationMemberListProvider);
    final associationMemberListNotifier =
        ref.watch(associationMemberListProvider.notifier);
    final associationPictureNotifier =
        ref.watch(associationPictureProvider.notifier);
    final isPresident = ref.watch(isAssociationPresidentProvider);

    return PhonebookTemplate(
        child: Refresher(
            onRefresh: () async {
              await associationMemberListNotifier.loadMembers(
                  association.id, association.mandateYear.toString());
              await associationPictureNotifier
                  .getAssociationPicture(association.id);
            },
            child: Stack(children: [
              Column(children: [
                const Text(PhonebookTextConstants.associationDetail,
                    style: TextStyle(fontSize: 30)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: associationPicture.when(
                    data: (picture) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: picture.image,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                ),
                const SizedBox(height: 20),
                Text(
                  association.name,
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(association.kind,
                    style: const TextStyle(fontSize: 20, color: Colors.black)),
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
                const SizedBox(
                  height: 20,
                ),
                associationMemberList.when(
                  data: (members) {
                    return Column(
                        children: members
                            .map((member) => MemberCard(member: member))
                            .toList());
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (e, s) {
                    return const Center(
                      child: Text(
                          PhonebookTextConstants.errorLoadAssociationMember),
                    );
                  },
                )
              ]),
              if (isPresident)
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      QR.to(PhonebookRouter.root +
                          PhonebookRouter.editAssociation);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ]),
                      child: const Row(
                        children: [
                          HeroIcon(HeroIcons.userGroup, color: Colors.white),
                          SizedBox(width: 10),
                          Text(PhonebookTextConstants.admin,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
            ])));
  }
}
