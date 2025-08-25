import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/providers/member_pictures_provider.dart';
import 'package:titan/phonebook/providers/profile_picture_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:titan/phonebook/ui/pages/association_members_page/member_edition_modal.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class MemberCard extends HookConsumerWidget {
  const MemberCard({
    super.key,
    required this.member,
    required this.association,
    required this.deactivated,
    this.editable = false,
  });

  final CompleteMember member;
  final Association association;
  final bool deactivated;
  final bool editable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    final memberNotifier = ref.watch(completeMemberProvider.notifier);

    final memberPictures = ref.watch(
      memberPicturesProvider.select((value) => value[member]),
    );
    final memberPicturesNotifier = ref.watch(memberPicturesProvider.notifier);

    Membership assoMembership = getMembershipForAssociation(
      member,
      association,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListItemTemplate(
        title:
            "${(member.member.nickname ?? member.getName())} - ${assoMembership.apparentName}",
        subtitle: member.member.nickname != null
            ? "${member.member.firstname} ${member.member.name}"
            : null,
        icon: AutoLoaderChild(
          group: memberPictures,
          notifier: memberPicturesNotifier,
          mapKey: member,
          loader: (ref) =>
              profilePictureNotifier.getProfilePicture(member.member.id),
          loadingBuilder: (context) => const CircleAvatar(
            radius: 20,
            child: CircularProgressIndicator(),
          ),
          dataBuilder: (context, data) => CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            backgroundImage: Image(image: data.first.image).image,
          ),
        ),
        onTap: editable
            ? () {
                showCustomBottomModal(
                  ref: ref,
                  context: context,
                  modal: MemberEditionModal(
                    member: member,
                    membership: assoMembership,
                  ),
                );
              }
            : () {
                memberNotifier.setCompleteMember(member);
                QR.to(PhonebookRouter.root + PhonebookRouter.memberDetail);
              },
        trailing: editable
            ? const HeroIcon(
                HeroIcons.chevronUpDown,
                color: ColorConstants.tertiary,
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
