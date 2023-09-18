import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/card_button.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/tools/ui/text_entry.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/vote/class/members.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/providers/display_results.dart';
import 'package:myecl/vote/providers/contender_logo_provider.dart';
import 'package:myecl/vote/providers/contender_logos_provider.dart';
import 'package:myecl/vote/providers/contender_members.dart';
import 'package:myecl/vote/providers/contender_list_provider.dart';
import 'package:myecl/vote/providers/contender_provider.dart';
import 'package:myecl/vote/providers/sections_contender_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/components/member_card.dart';
import 'package:myecl/vote/ui/pages/contender_pages/search_result.dart';
import 'package:myecl/vote/ui/pages/admin_page/section_chip.dart';
import 'package:myecl/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditContenderPage extends HookConsumerWidget {
  const AddEditContenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final addMemberKey = GlobalKey<FormState>();
    final section = useState(ref.watch(sectionProvider));
    final contenderListNotifier = ref.read(contenderListProvider.notifier);
    final sectionsNotifier = ref.read(sectionContenderProvider.notifier);
    final contender = ref.watch(contenderProvider);
    final isEdit = contender.id != Contender.empty().id;
    final name = useTextEditingController(text: contender.name);
    final description = useTextEditingController(text: contender.description);
    final listType = useState(contender.listType);
    final usersNotifier = ref.read(userList.notifier);
    final queryController = useTextEditingController();
    final role = useTextEditingController();
    final program = useTextEditingController(text: contender.program);
    final member = useState(SimpleUser.empty());
    final members = ref.watch(contenderMembersProvider);
    final membersNotifier = ref.read(contenderMembersProvider.notifier);
    final contenderLogosNotifier = ref.read(contenderLogosProvider.notifier);
    final logoNotifier = ref.read(contenderLogoProvider.notifier);
    final logo = useState<Uint8List?>(null);
    final logoFile = useState<Image?>(null);
    final showNotifier = ref.read(displayResult.notifier);
    ref.watch(contenderLogosProvider).whenData((value) {
      if (value[contender] != null) {
        value[contender]!.whenData((data) {
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

    return VoteTemplate(
      child: SingleChildScrollView(
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
                            color: Color.fromARGB(255, 149, 149, 149)))),
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
                                      ? Image.memory(
                                          logo.value!,
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
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            if (kIsWeb) {
                              logo.value = await image.readAsBytes();
                              logoFile.value = Image.network(image.path);
                            } else {
                              final file = File(image.path);
                              logo.value = await file.readAsBytes();
                              logoFile.value = Image.file(file);
                            }
                          }
                        },
                        child: const CardButton(
                          gradient1: ColorConstants.gradient1,
                                gradient2: ColorConstants.gradient2,
                          child: HeroIcon(
                            HeroIcons.photo,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextEntry(
                  label: VoteTextConstants.name,
                  controller: name,
                ),
              ),
              const SizedBox(height: 50),
              HorizontalListView(
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
                  label: VoteTextConstants.description,
                ),
              ),
              const SizedBox(height: 30),
              HorizontalListView(
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
                            TextEntry(
                              label: VoteTextConstants.members,
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
                              color: Colors.black,
                              controller: queryController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SearchResult(
                                borrower: member,
                                queryController: queryController),
                            TextEntry(
                                label: VoteTextConstants.role,
                                controller: role),
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
                  controller: program,
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ShrinkButton(
                  builder: (child) => Container(
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
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: child),
                  onTap: () async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      await tokenExpireWrapper(ref, () async {
                        final contenderList = ref.watch(contenderListProvider);
                        Contender newContender = Contender(
                          name: name.text,
                          id: isEdit ? contender.id : '',
                          description: description.text,
                          listType: listType.value,
                          members: members,
                          section: section.value,
                          program: program.text,
                        );
                        final value = isEdit
                            ? await contenderListNotifier
                                .updateContender(newContender)
                            : await contenderListNotifier
                                .addContender(newContender);
                        if (value) {
                          QR.back();
                          if (isEdit) {
                            displayVoteToastWithContext(TypeMsg.msg,
                                VoteTextConstants.editedPretendance);
                            contenderList.when(
                                data: (list) {
                                  if (logo.value != null) {
                                    Future.delayed(
                                        const Duration(milliseconds: 1), () {
                                      contenderLogosNotifier.setTData(
                                          contender, const AsyncLoading());
                                    });
                                    logoNotifier.updateLogo(
                                        contender.id, logo.value!);
                                    contenderLogosNotifier.setTData(
                                        contender,
                                        AsyncData([
                                          Image.memory(
                                            logo.value!,
                                            fit: BoxFit.cover,
                                          ),
                                        ]));
                                  }
                                },
                                error: (error, s) {},
                                loading: () {});
                          } else {
                            displayVoteToastWithContext(TypeMsg.msg,
                                VoteTextConstants.addedPretendance);
                            contenderList.when(
                                data: (list) {
                                  final newContender = list.last;
                                  if (logo.value != null) {
                                    Future.delayed(
                                        const Duration(milliseconds: 1), () {
                                      contenderLogosNotifier.setTData(
                                          contender, const AsyncLoading());
                                    });
                                    logoNotifier.updateLogo(
                                        newContender.id, logo.value!);
                                    contenderLogosNotifier.setTData(
                                        newContender,
                                        AsyncData([
                                          Image.memory(
                                            logo.value!,
                                            fit: BoxFit.cover,
                                          )
                                        ]));
                                  }
                                },
                                error: (error, s) {},
                                loading: () {});
                          }
                          membersNotifier.clearMembers();
                          await sectionsNotifier.setTData(section.value,
                              await contenderListNotifier.copy());
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
                  child: const Text(VoteTextConstants.edit,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
            ]),
          )),
    );
  }
}
