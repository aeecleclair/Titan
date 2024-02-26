import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/member_role_tags_provider.dart';
import 'package:myecl/phonebook/ui/delete_button.dart';
import 'package:myecl/phonebook/ui/edition_button.dart';
import 'package:myecl/phonebook/ui/pages/association_editor_page/membership_dialog.dart';
import 'package:myecl/phonebook/ui/text_input_dialog.dart';
import 'package:myecl/tools/functions.dart';
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
    final controller = TextEditingController();
    final associationMembersNotifier =
        ref.watch(associationMemberListProvider.notifier);
    final memberRoleTags = ref.watch(memberRolesTagsProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }


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
                const Spacer(),
                Text(member.memberships.firstWhere((element) => element.association.id == association.id).apparentName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                EditionButton(onEdition: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MembershipDialog(
                            apparentNameController: controller,
                            title: PhonebookTextConstants.editMembership,
                            defaultText: member.memberships.firstWhere((element) => element.association.id == association.id).apparentName,
                            onConfirm: () async {
                              final result = await associationNotifier.updateMember(
                                  association,
                                  member.toMember(),
                                  memberRoleTags,
                                  controller.text);
                              if (result) {
                                await associationMembersNotifier.loadMembers(association.id);
                                displayToastWithContext(TypeMsg.msg, PhonebookTextConstants.updatedMember);
                              } else {
                                displayToastWithContext(TypeMsg.error, PhonebookTextConstants.updatingError);
                              }
                            });
                      });
                }),
                const SizedBox(width: 10),
                DeleteButton(onDelete: 
                  () async {
                    final result = await associationNotifier.deleteMember(association, member);
                    await associationMembersNotifier.loadMembers(association.id);
                    if (result) {
                      displayToastWithContext(TypeMsg.msg, PhonebookTextConstants.deletedMember);
                    } else {
                      displayToastWithContext(TypeMsg.error, PhonebookTextConstants.deletingError);
                    }
                  },)
              ],
            ));
  }
}
