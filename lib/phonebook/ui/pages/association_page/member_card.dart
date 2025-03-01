import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/phonebook/providers/member_pictures_provider.dart';
import 'package:myecl/phonebook/providers/profile_picture_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/tools/function.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberCard extends HookConsumerWidget {
  const MemberCard({
    super.key,
    required this.member,
    required this.association,
  });

  final MemberComplete member;
  final AssociationComplete association;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberNotifier = ref.watch(completeMemberProvider.notifier);

    final memberPictures =
        ref.watch(memberPicturesProvider.select((value) => value[member]));
    final memberPicturesNotifier = ref.watch(memberPicturesProvider.notifier);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);

    MembershipComplete? assoMembership = member.memberships.firstWhereOrNull(
      (memberships) =>
          memberships.associationId == association.id &&
          memberships.mandateYear == association.mandateYear,
    );

    return GestureDetector(
      onTap: () {
        memberNotifier.setCompleteMember(member);
        QR.to(PhonebookRouter.root + PhonebookRouter.memberDetail);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: CardLayout(
          color: getColorFromTagList(
            ref,
            member.memberships
                .firstWhere(
                  (element) =>
                      element.associationId == association.id &&
                      element.mandateYear == association.mandateYear,
                )
                .roleTags,
          ),
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: AutoLoaderChild(
                      group: memberPictures,
                      notifier: memberPicturesNotifier,
                      mapKey: member,
                      loader: (ref) => profilePictureNotifier
                          .getProfilePicture(member.id),
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
                  const SizedBox(width: 10),
                  if ((member.nickname != null) &&
                      (member.nickname != "")) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.nickname!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "(${member.name} ${member.firstname})",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 115, 115, 115),
                          ),
                        ),
                      ],
                    ),
                  ] else
                    Text(
                      "${member.name} ${member.firstname}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
              Flexible(
                child: Text(
                  textAlign: TextAlign.right,
                  assoMembership == null
                      ? PhonebookTextConstants.noMemberRole
                      : assoMembership.roleName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
