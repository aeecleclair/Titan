import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/user/providers/profile_picture_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class MemberCard extends HookConsumerWidget {
  const MemberCard({super.key, required this.member});

  final CompleteMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final memberNotifier = ref.watch(completeMemberProvider.notifier);
    final profilePicture = ref.watch(profilePictureProvider);
    final association = ref.watch(associationProvider);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    

    //profilePictureNotifier.getProfilePicture(member.member.id);
    return GestureDetector(
        onTap: () {
          memberNotifier.setCompleteMember(member);
          pageNotifier.setPhonebookPage(PhonebookPage.memberDetail);
          profilePictureNotifier.getProfilePicture(member.member.id);
        },
        child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
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
                  child: profilePicture.when(
                    data: (picture) {
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: picture.isEmpty
                            ? const AssetImage('assets/images/logo_alpha.png')
                            : Image.memory(picture).image,
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
                            PhonebookTextConstants.errorLoadProfilePicture),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "${member.member.name} ${member.member.firstname} (${member.member.nickname})",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        member.member.email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(member.memberships.firstWhere((element) => element.association.id == association.id).apparentName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
              ],
            )));
  }
}
