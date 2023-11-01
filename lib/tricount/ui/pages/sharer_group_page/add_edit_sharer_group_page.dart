import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/providers/sharer_group_list_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/tools/constants.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/search_result.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/sharer_group_member_chip_list.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditSharerGroupPage extends HookConsumerWidget {
  const AddEditSharerGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroup = ref.watch(sharerGroupProvider);
    final sharerGroupListNotifier = ref.watch(sharerGroupListProvider.notifier);
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SharerGroupMemberChipList(),
                  ),
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
                                  equilibriumTransactions: [],
                                  id: '',
                                  name: name.text,
                                  sharers: sharerGroup.sharers,
                                  totalAmount: 0.0,
                                  transactions: []);
                              final value = isEdit
                                  ? await sharerGroupListNotifier
                                      .updateSharerGroup(newSharerGroup)
                                  : await sharerGroupListNotifier
                                      .addSharerGroup(newSharerGroup);
                              if (value) {
                                QR.back();
                                if (isEdit) {
                                  displayToastWithContext(TypeMsg.msg,
                                      RaffleTextConstants.updatedSharerGroup);
                                } else {
                                  displayToastWithContext(TypeMsg.msg,
                                      RaffleTextConstants.addedSharerGroup);
                                }
                              } else {
                                if (isEdit) {
                                  displayToastWithContext(TypeMsg.error,
                                      RaffleTextConstants.updatingError);
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      RaffleTextConstants.addingError);
                                }
                              }
                            });
                          },
                          child: Text(
                              isEdit
                                  ? RaffleTextConstants.edit
                                  : RaffleTextConstants.add,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        )
                      ]))
                ]))));
  }
}
