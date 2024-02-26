import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/user/providers/profile_picture_provider.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class MemberEditableCard extends HookConsumerWidget {
  const MemberEditableCard({super.key, required this.member});

  final CompleteMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberNotifier = ref.watch(completeMemberProvider.notifier);
    final profilePicture = ref.watch(profilePictureProvider);
    final association = ref.watch(associationProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    
    return Container(
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
                            PhonebookTextConstants.errorLoadAssociationPicture),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 400,
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
                SizedBox(
                  width: 200,
                  child: Center(
                    child : Row(
                      children: member.memberships.where((element) => element.association.id == association.id).map((e) =>
                        Text(
                        e.apparentName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )).toList()
                      )
                  )
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: const HeroIcon(HeroIcons.pencil,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: (){
                    associationNotifier.deleteMember(association ,member, );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: const HeroIcon(HeroIcons.trash,
                        color: Colors.black),
                  ),
                ),
              ],
            ));
  }
}
