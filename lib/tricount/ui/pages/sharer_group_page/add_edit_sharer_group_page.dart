import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/tools/constants.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/search_result.dart';
import 'package:myecl/tricount/ui/pages/sharer_group_page/sharer_group_member_chip_list.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddEditSharerGroupPage extends HookConsumerWidget {
  const AddEditSharerGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroup = ref.watch(sharerGroupProvider);
    final usersNotifier = ref.watch(userList.notifier);
    final isEdit = sharerGroup.id != SharerGroup.empty().id;
    final name = useTextEditingController();
    final queryController = useTextEditingController();
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
                      ]))
                ]))));
  }
}
