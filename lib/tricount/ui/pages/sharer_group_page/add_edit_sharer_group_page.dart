import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/class/sharer_group_membership.dart';
import 'package:myecl/tricount/providers/membership_list_provider.dart';
import 'package:myecl/tricount/providers/membership_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_membership_map_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_member_list_provider.dart';
import 'package:myecl/tricount/tools/constants.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/add_members_to_sharer_group_card.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/search_result.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/sharer_group_member_chip_list.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditSharerGroupPage extends HookConsumerWidget {
  const AddEditSharerGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider).id;
    final membership = ref.watch(sharerGroupMembershipProvider);
    final sharerGroupNotifier = ref.watch(sharerGroupProvider.notifier);
    final sharerGroupMap = ref.watch(sharerGroupMapProvider);
    final sharerGroupMapNotifier = ref.watch(sharerGroupMapProvider.notifier);
    final membershipListNotifier = ref.watch(membershipListProvider.notifier);
    final sharerGroup =
        membership.userId != SharerGroupMembership.empty().userId
            ? sharerGroupMap.maybeWhen(
                orElse: () => SharerGroup.empty(),
                data: (value) => value[membership]!.maybeWhen(
                    orElse: () => SharerGroup.empty(),
                    data: (value) => value.first))
            : SharerGroup.empty();
    final sharerGroupMemberList = ref.watch(sharerGroupMemberListProvider);
    final sharerGroupMemberListNotifier =
        ref.watch(sharerGroupMemberListProvider.notifier);
    final usersNotifier = ref.watch(userList.notifier);
    final isEdit = sharerGroup.id != SharerGroup.empty().id;
    final name = useTextEditingController(text: isEdit ? sharerGroup.name : "");
    final queryController = useTextEditingController();
    final key = GlobalKey<FormState>();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return TricountTemplate(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
                key: key,
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [
                        const SizedBox(height: 30),
                        AlignLeftText(
                          isEdit
                              ? TricountTextConstants.editGroup
                              : TricountTextConstants.addGroup,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 30),
                        TextEntry(
                          label: TricountTextConstants.name,
                          controller: name,
                        ),
                      ])),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SharerGroupMemberChipList(
                      members:
                          isEdit ? sharerGroup.members : sharerGroupMemberList,
                      canDelete: !isEdit,
                      onDeleted: (member) {
                        sharerGroupMemberListNotifier.removeMember(member);
                      },
                    ),
                  ),
                  if (isEdit)
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: AddMembersToSharerGroupCard()),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [
                        TextEntry(
                          label: TricountTextConstants.member,
                          onChanged: (value) {
                            tokenExpireWrapper(ref, () async {
                              if (queryController.text.isNotEmpty) {
                                await usersNotifier
                                    .filterUsers(queryController.text);
                              } else {
                                usersNotifier.clear();
                              }
                            });
                          },
                          canBeEmpty: true,
                          controller: queryController,
                        ),
                        const SizedBox(height: 20),
                        SearchResult(queryController: queryController),
                        const SizedBox(height: 50),
                        WaitingButton(
                          builder: (child) => AddEditButtonLayout(
                              color: const Color(0xff09263D), child: child),
                          onTap: () async {
                            if (key.currentState == null) {
                              return;
                            }
                            if (!key.currentState!.validate()) {
                              return;
                            }
                            await tokenExpireWrapper(ref, () async {
                              SharerGroup newSharerGroup = SharerGroup(
                                  balances: [],
                                  id: '',
                                  name: name.text,
                                  members: sharerGroupMemberList,
                                  total: 0.0,
                                  transactions: []);
                              if (isEdit) {
                                final value = await sharerGroupNotifier
                                    .updateSharerGroup(newSharerGroup);
                                if (value) {
                                  sharerGroupMapNotifier.setTData(
                                      membership, AsyncData([newSharerGroup]));
                                  QR.back();
                                  displayToastWithContext(TypeMsg.msg,
                                      TricountTextConstants.updatedSharerGroup);
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      TricountTextConstants.updatingError);
                                }
                              } else {
                                final sharerGroup = await sharerGroupNotifier
                                    .addSharerGroup(newSharerGroup);
                                if (sharerGroup.id != SharerGroup.empty().id) {
                                  final newMembership = SharerGroupMembership(
                                      position: 0,
                                      active: true,
                                      sharerGroupId: sharerGroup.id,
                                      userId: userId);
                                  await membershipListNotifier
                                      .fakeAddMembership(newMembership);
                                  sharerGroupMapNotifier.addT(newMembership);
                                  sharerGroupMapNotifier.setTData(
                                      newMembership, AsyncData([sharerGroup]));
                                  QR.back();
                                  displayToastWithContext(TypeMsg.msg,
                                      TricountTextConstants.addedSharerGroup);
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      TricountTextConstants.addingError);
                                }
                              }
                            });
                          },
                          child: Text(
                              isEdit
                                  ? TricountTextConstants.edit
                                  : TricountTextConstants.add,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        )
                      ]))
                ]))));
  }
}
