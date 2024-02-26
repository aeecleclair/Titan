import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/profile_pictures_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/ui/copiabled_text.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/phonebook/providers/profile_picture_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class MemberCard extends HookConsumerWidget {
  const MemberCard({super.key, required this.member});

  final CompleteMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberNotifier = ref.watch(completeMemberProvider.notifier);
    final association = ref.watch(associationProvider);
    final profilePictures = ref.watch(profilePicturesProvider);
    final profilePicturesNotifier = ref.watch(profilePicturesProvider.notifier);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);

    return GestureDetector(
        onTap: () {
          memberNotifier.setCompleteMember(member);
          QR.to(PhonebookRouter.root + PhonebookRouter.memberDetail);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CardLayout(
              margin: EdgeInsets.zero,
              child: Row(
                children: [
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
                      child: AutoLoaderChild(
                        value: profilePictures,
                        notifier: profilePicturesNotifier,
                        mapKey: member,
                        loader: (member) => profilePictureNotifier
                            .getProfilePicture(member.member.id),
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
                      )),
                  const SizedBox(width: 20),
                  if (!kIsWeb) ...[
                    if (member.member.nickname != null)
                      CopiabledText(
                        data: member.member.nickname!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        flex: 1,
                      ),
                    CopiabledText(
                      data: "${member.member.name} ${member.member.firstname}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: member.member.nickname != null
                            ? const Color.fromARGB(255, 115, 115, 115)
                            : Colors.black,
                      ),
                      flex: 1,
                    ),
                    CopiabledText(
                        data: member.member.email,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        flex: 1),
                    if (member.member.phone != null)
                      CopiabledText(
                          data: member.member.phone!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          flex: 1),
                    CopiabledText(
                        data: member.memberships
                            .firstWhere((element) =>
                                element.associationId == association.id)
                            .apparentName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        flex: 1)
                  ] else ...[
                    if (member.member.nickname != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.member.nickname!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${member.member.name} ${member.member.firstname}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 115, 115, 115),
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        "${member.member.name} ${member.member.firstname}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    const Spacer(flex: 1),
                    Text(
                      member.memberships
                          .firstWhere((element) =>
                              element.associationId == association.id)
                          .apparentName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              )),
        ));
  }
}
