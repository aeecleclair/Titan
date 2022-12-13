import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/vote/class/members.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/display_results.dart';
import 'package:myecl/vote/providers/pretendance_logo_provider.dart';
import 'package:myecl/vote/providers/pretendance_logos_provider.dart';
import 'package:myecl/vote/providers/pretendance_members.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/member_card.dart';
import 'package:myecl/vote/ui/pages/pretendance_pages/search_result.dart';
import 'package:myecl/vote/ui/section_chip.dart';
import 'package:myecl/vote/ui/text_entry.dart';

class EditPretendancePage extends HookConsumerWidget {
  const EditPretendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final key = GlobalKey<FormState>();
    final addMemberKey = GlobalKey<FormState>();
    final section = useState(ref.watch(sectionProvider));
    final pretendanceList = ref.watch(pretendanceListProvider);
    final pretendanceListNotifier = ref.watch(pretendanceListProvider.notifier);
    final sectionsNotifier = ref.watch(sectionPretendanceProvider.notifier);
    final pretendance = ref.watch(pretendanceProvider);
    final name = useTextEditingController(text: pretendance.name);
    final description = useTextEditingController(text: pretendance.description);
    final listType = useState(pretendance.listType);
    final usersNotifier = ref.watch(userList.notifier);
    final queryController = useTextEditingController();
    final role = useTextEditingController();
    final program = useTextEditingController(text: pretendance.program);
    final member = useState(SimpleUser.empty());
    final members = ref.watch(pretendanceMembersProvider);
    final membersNotifier = ref.watch(pretendanceMembersProvider.notifier);
    final pretendanceLogosNotifier =
        ref.watch(pretendanceLogosProvider.notifier);
    final logoNotifier = ref.watch(pretendenceLogoProvider.notifier);
    final logo = useState<String?>(null);
    final logoFile = useState<Image?>(null);
    final showNotifier = ref.watch(displayResult.notifier);
    ref.watch(pretendanceLogosProvider).whenData((value) {
      if (value[pretendance] != null) {
        value[pretendance]!.whenData((data) {
          if (data.isNotEmpty) {
            logoFile.value = data.first;
          }
        });
      }
    });
    final ImagePicker picker = ImagePicker();

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(VoteTextConstants.addPretendance,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 205, 205, 205)))),
            ),
            const SizedBox(height: 50),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: logoFile.value != null
                        ? Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: logo.value != null
                                    ? Image.file(
                                        File(logo.value!),
                                        fit: BoxFit.cover,
                                      ).image
                                    : logoFile.value!.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const HeroIcon(
                            HeroIcons.userCircle,
                            size: 160,
                            color: Colors.grey,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          logo.value = image.path;
                          logoFile.value = Image.file(File(image.path));
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.gradient2.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: const HeroIcon(
                          HeroIcons.photo,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       final XFile? image =
                  //           await picker.pickImage(source: ImageSource.camera);
                  //       if (image != null) {
                  //         logo.value = image.path;
                  //         logoFile.value = Image.file(File(image.path));
                  //       }
                  //     },
                  //     child: Container(
                  //       height: 40,
                  //       width: 40,
                  //       padding: const EdgeInsets.all(7),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         gradient: const LinearGradient(
                  //           colors: [
                  //             ColorConstants.gradient1,
                  //             ColorConstants.gradient2,
                  //           ],
                  //           begin: Alignment.topLeft,
                  //           end: Alignment.bottomRight,
                  //         ),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: ColorConstants.gradient2.withOpacity(0.3),
                  //             spreadRadius: 2,
                  //             blurRadius: 4,
                  //             offset: const Offset(2, 3),
                  //           ),
                  //         ],
                  //       ),
                  //       child: const HeroIcon(
                  //         HeroIcons.camera,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // if (logoFile.value != null)
                  //   Positioned(
                  //     bottom: -20,
                  //     right: 60,
                  //     child: GestureDetector(
                  //       onTap: () async {
                  //         // final value = await profilePictureNotifier
                  //         //     .setProfilePicture(ImageSource.camera);
                  //         // if (value != null) {
                  //         //   if (value) {
                  //         //     displayToastWithContext(
                  //         //         TypeMsg.msg, "Photo de profil changée");
                  //         //   } else {
                  //         //     displayToastWithContext(TypeMsg.error,
                  //         //         "Erreur lors du changement de photo de profil");
                  //         //   }
                  //         // }
                  //       },
                  //       child: Container(
                  //         height: 40,
                  //         width: 40,
                  //         padding: const EdgeInsets.all(7),
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           gradient: const LinearGradient(
                  //             colors: [
                  //               ColorConstants.gradient1,
                  //               ColorConstants.gradient2,
                  //             ],
                  //             begin: Alignment.topLeft,
                  //             end: Alignment.bottomRight,
                  //           ),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color:
                  //                   ColorConstants.gradient2.withOpacity(0.3),
                  //               spreadRadius: 2,
                  //               blurRadius: 4,
                  //               offset: const Offset(2, 3),
                  //             ),
                  //           ],
                  //         ),
                  //         child: const HeroIcon(
                  //           HeroIcons.sparkles,
                  //           color: Colors.white,
                  //           size: 10,
                  //         ),
                  //       ),
                  //     ),
                  //   )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextEntry(
                keyboardType: TextInputType.text,
                label: VoteTextConstants.name,
                suffix: '',
                isInt: false,
                controller: name,
              ),
            ),
            const SizedBox(height: 50),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  ...ListType.values.where((e) => e != ListType.blank).map(
                        (e) => SectionChip(
                          label: capitalize(e.toString().split('.').last),
                          selected: listType.value == e,
                          isAdmin: false,
                          onTap: () async {
                            listType.value = e;
                          },
                          onDelete: () {},
                        ),
                      ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextEntry(
                keyboardType: TextInputType.multiline,
                controller: description,
                isInt: false,
                label: VoteTextConstants.description,
                suffix: '',
              ),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  ...members.map(
                    (e) => MemberCard(
                      member: e,
                      onDelete: () async {
                        membersNotifier.removeMember(e);
                      },
                      onEdit: () {},
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InputDecorator(
                decoration: InputDecoration(
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: VoteTextConstants.addMember,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Form(
                  key: addMemberKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(children: <Widget>[
                          TextFormField(
                            onChanged: (newQuery) {
                              showNotifier.setId(true);
                              tokenExpireWrapper(ref, () async {
                                if (queryController.text.isNotEmpty) {
                                  await usersNotifier
                                      .filterUsers(queryController.text);
                                } else {
                                  usersNotifier.clear();
                                }
                              });
                            },
                            cursorColor: Colors.black,
                            controller: queryController,
                            decoration: const InputDecoration(
                              labelText: VoteTextConstants.members,
                              floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SearchResult(
                              borrower: member,
                              queryController: queryController),
                          TextEntry(
                              label: VoteTextConstants.role,
                              suffix: '',
                              isInt: false,
                              controller: role,
                              keyboardType: TextInputType.text),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () async {
                              if (addMemberKey.currentState == null) {
                                return;
                              }
                              if (member.value.id == '' || role.text == '') {
                                return;
                              }
                              if (addMemberKey.currentState!.validate()) {
                                final value = await membersNotifier.addMember(
                                    Member.fromSimpleUser(
                                        member.value, role.text));
                                if (value) {
                                  role.text = '';
                                  member.value = SimpleUser.empty();
                                  queryController.text = '';
                                } else {
                                  displayVoteToastWithContext(TypeMsg.error,
                                      VoteTextConstants.alreadyAddedMember);
                                }
                              }
                            },
                            child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          3, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Text(VoteTextConstants.add,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextEntry(
                keyboardType: TextInputType.multiline,
                label: VoteTextConstants.program,
                suffix: '',
                isInt: false,
                controller: program,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      tokenExpireWrapper(ref, () async {
                        final value =
                            await pretendanceListNotifier.updatePretendance(
                          Pretendance(
                            name: name.text,
                            id: pretendance.id,
                            description: description.text,
                            listType: listType.value,
                            members: members,
                            section: section.value,
                            program: program.text,
                          ),
                        );
                        if (value) {
                          displayVoteToastWithContext(
                              TypeMsg.msg, VoteTextConstants.editedPretendance);
                          pageNotifier.setVotePage(VotePage.admin);
                          pretendanceList.when(
                              data: (list) {
                                if (logo.value != null) {
                                  logoNotifier.updateLogo(
                                      pretendance.id, logo.value!);
                                  pretendanceLogosNotifier.setTData(
                                      pretendance,
                                      AsyncData([
                                        Image.file(
                                          File(logo.value!),
                                          fit: BoxFit.cover,
                                        ),
                                      ]));
                                }
                              },
                              error: (error, s) {},
                              loading: () {});
                          membersNotifier.clearMembers();
                          await sectionsNotifier.setTData(section.value,
                              await pretendanceListNotifier.copy());
                        } else {
                          displayVoteToastWithContext(
                              TypeMsg.error, VoteTextConstants.editingError);
                        }
                      });
                    } else {
                      displayToast(context, TypeMsg.error,
                          VoteTextConstants.incorrectOrMissingFields);
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                                3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Text(VoteTextConstants.edit,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                )),
            const SizedBox(height: 30),
          ]),
        ));
  }
}
