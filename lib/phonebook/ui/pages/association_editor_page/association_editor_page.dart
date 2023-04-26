import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/member_provider.dart';
import 'package:myecl/phonebook/providers/member_role_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/association_creation_page/kind_chip.dart';
import 'package:myecl/phonebook/ui/pages/association_editor_page/member_editable_card.dart';
import 'package:myecl/phonebook/ui/pages/association_editor_page/membership_dialog.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AssociationEditorPage extends HookConsumerWidget {
  const AssociationEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final association = ref.watch(associationProvider);
    final associationMemberListNotifier =
        ref.watch(associationMemberListProvider.notifier);
    final associationMemberList = ref.watch(associationMemberListProvider);
    final associationPictureNotifier =
        ref.watch(associationPictureProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    final kind = useState(association.kind);
    final name = useTextEditingController(text: association.name);
    final description = useTextEditingController(text: association.description);
    final controller = TextEditingController();
    final member = ref.watch(memberProvider);
    final memberRoleTags = ref.watch(memberRolesTagsProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Refresher(
      onRefresh: () async {
        await associationMemberListNotifier.loadMembers(association.id);
        await associationPictureNotifier.getAssociationPicture(association.id);
      },
      child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(PhonebookTextConstants.edit,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.gradient1)),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
            key: key,
            child: Column(children: [
              associationKinds.when(
                data: (value) {
                  return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: value.kinds
                              .map((e) => KindChip(
                                    label: e,
                                    selected: e == kind.value,
                                    onTap: () async {
                                      kind.value = e;
                                    },
                                  ))
                              .toList()));
                },
                error: (error, stack) {
                  return const Text(PhonebookTextConstants.errorKindsLoading);
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: TextFormField(
                                controller: name,
                                cursorColor: ColorConstants.gradient1,
                                decoration: InputDecoration(
                                    labelText: "Name",
                                    labelStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    suffixIcon: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const HeroIcon(
                                        HeroIcons.pencil,
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.gradient1))),
                                validator: (value) {
                                  if (value == null) {
                                    return PhonebookTextConstants
                                        .emptyFieldError;
                                  } else if (value.isEmpty) {
                                    return PhonebookTextConstants
                                        .emptyFieldError;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: TextFormField(
                                controller: description,
                                cursorColor: ColorConstants.gradient1,
                                decoration: InputDecoration(
                                    labelText: "Description",
                                    labelStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    suffixIcon: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const HeroIcon(
                                        HeroIcons.pencil,
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.gradient1))),
                                validator: (value) {
                                  if (value == null) {
                                    return PhonebookTextConstants
                                        .emptyFieldError;
                                  } else if (value.isEmpty) {
                                    return PhonebookTextConstants
                                        .emptyFieldError;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                    ShrinkButton(
                      waitChild: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.gradient2.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                              spreadRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (!key.currentState!.validate()) {
                          return;
                        }
                        if (kind.value == '') {
                          displayToastWithContext(TypeMsg.error,
                              PhonebookTextConstants.emptyKindError);
                          return;
                        }
                        await tokenExpireWrapper(ref, () async {
                          final value = await associationListNotifier
                              .updateAssociation(association.copyWith(
                                  name: name.text,
                                  description: description.text,
                                  kind: kind.value));
                          if (value) {
                            displayToastWithContext(TypeMsg.msg,
                                PhonebookTextConstants.updatedAssociation);
                          } else {
                            displayToastWithContext(TypeMsg.msg,
                                PhonebookTextConstants.updatingError);
                          }
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.gradient2.withOpacity(0.5),
                              blurRadius: 5,
                              offset: const Offset(2, 2),
                              spreadRadius: 2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          PhonebookTextConstants.edit,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              const Text(PhonebookTextConstants.members),
              const Spacer(),
              ShrinkButton(
                onTap: () async {
                  await tokenExpireWrapper(ref, () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MembershipDialog(
                              apparentNameController: controller,
                              title: PhonebookTextConstants.addMember,
                              defaultText: "",
                              onConfirm: () async {
                                debugPrint(
                                    "assciation: $association,\n member: ${member.toString()},\n memberRoleTags: $memberRoleTags,\n controller: ${controller.text}");
                                final value =
                                    await associationNotifier.addMember(
                                        association,
                                        member,
                                        memberRoleTags,
                                        controller.text);
                                if (value) {
                                  associationMemberListNotifier
                                      .loadMembers(association.id);
                                  displayToastWithContext(TypeMsg.msg,
                                      PhonebookTextConstants.addedMember);
                                } else {
                                  displayToastWithContext(TypeMsg.msg,
                                      PhonebookTextConstants.addingError);
                                }
                              });
                        });
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConstants.gradient1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...associationMemberList.when(
          data: (data) {
            return data
                .map((member) => MemberEditableCard(member: member))
                .toList();
          },
          error: (error, stackTrace) {
            return const [
              Text(PhonebookTextConstants.errorLoadAssociationMember),
            ];
          },
          loading: () => [
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ]),
    );
  }
}
