import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/member_pictures_provider.dart';
import 'package:titan/phonebook/providers/profile_picture_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/tools/function.dart';
import 'package:titan/phonebook/ui/pages/association_page/card_field.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class WebMemberCard extends HookConsumerWidget {
  const WebMemberCard({
    super.key,
    required this.member,
    required this.association,
  });

  final CompleteMember member;
  final Association association;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberNotifier = ref.watch(completeMemberProvider.notifier);

    final memberPictures = ref.watch(
      memberPicturesProvider.select((value) => value[member]),
    );
    final memberPicturesNotifier = ref.watch(memberPicturesProvider.notifier);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);

    Membership? assoMembership = member.memberships.firstWhereOrNull(
      (memberships) =>
          memberships.associationId == association.id &&
          memberships.mandateYear == association.mandateYear,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: GestureDetector(
        onTap: () {
          memberNotifier.setCompleteMember(member);
          QR.to(PhonebookRouter.root + PhonebookRouter.memberDetail);
        },
        child: CardLayout(
          color: getColorFromTagList(
            ref,
            member.memberships
                .firstWhere(
                  (element) =>
                      element.associationId == association.id &&
                      element.mandateYear == association.mandateYear,
                )
                .rolesTags,
          ),
          margin: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            .getProfilePicture(member.member.id),
                        loadingBuilder: (context) => const CircleAvatar(
                          radius: 40,
                          child: CircularProgressIndicator(),
                        ),
                        dataBuilder: (context, data) => CircleAvatar(
                          radius: 40,
                          backgroundImage: data.first.image,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (member.member.nickname != null) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  member.member.nickname!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SelectableText(
                                  "(${member.member.name} ${member.member.firstname})",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 115, 115, 115),
                                  ),
                                ),
                              ],
                            ),
                          ] else
                            SelectableText(
                              "${member.member.name} ${member.member.firstname}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CardField(
                                  label: PhonebookTextConstants.promotion,
                                  value: member.member.promotion == 0
                                      ? PhonebookTextConstants.promoNotGiven
                                      : member.member.promotion < 100
                                      ? "20${member.member.promotion}"
                                      : member.member.promotion.toString(),
                                ),
                                CardField(
                                  label: PhonebookTextConstants.email,
                                  value: member.member.email,
                                ),
                                if (member.member.phone != null)
                                  CardField(
                                    label: PhonebookTextConstants.phone,
                                    value: member.member.phone!,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.right,
                          assoMembership == null
                              ? PhonebookTextConstants.noMemberRole
                              : assoMembership.apparentName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (member.member.nickname != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                              member.member.nickname!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SelectableText(
                              "(${member.member.name} ${member.member.firstname})",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromARGB(255, 115, 115, 115),
                              ),
                            ),
                          ],
                        ),
                      ] else
                        SelectableText(
                          "${member.member.name} ${member.member.firstname}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      const SizedBox(height: 5),
                      CardField(
                        label: PhonebookTextConstants.promotion,
                        value: member.member.promotion == 0
                            ? PhonebookTextConstants.promoNotGiven
                            : member.member.promotion < 100
                            ? "20${member.member.promotion}"
                            : member.member.promotion.toString(),
                      ),
                      if (constraints.maxWidth > 500)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CardField(
                                label: PhonebookTextConstants.email,
                                value: member.member.email,
                              ),
                              if (member.member.phone != null)
                                CardField(
                                  label: PhonebookTextConstants.phone,
                                  value: member.member.phone!,
                                ),
                            ],
                          ),
                        )
                      else
                        Column(
                          children: [
                            CardField(
                              label: PhonebookTextConstants.email,
                              value: member.member.email,
                              showLabel: false,
                            ),
                            if (member.member.phone != null)
                              CardField(
                                label: PhonebookTextConstants.phone,
                                value: member.member.phone!,
                                showLabel: false,
                              ),
                          ],
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        textAlign: TextAlign.right,
                        assoMembership == null
                            ? PhonebookTextConstants.noMemberRole
                            : assoMembership.apparentName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
