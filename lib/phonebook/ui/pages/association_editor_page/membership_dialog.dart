import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:myecl/phonebook/providers/member_role_tags_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/association_editor_page/search_result.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:tuple/tuple.dart';

class MembershipDialog extends HookConsumerWidget {
  const MembershipDialog({
    Key? key,
    required this.apparentNameController,
    required this.title,
    required this.defaultText,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final String defaultText;
  final VoidCallback onConfirm;
  final TextEditingController apparentNameController;

  String nameConstructor(Tuple2<RolesTags, List<bool>> data) {
    String name = '';
    for (int i = 0; i < data.item2.length; i++) {
      if (data.item2[i]) {
        name = "$name, ${data.item1.tags[i]}";
      }
    }
    if (name == "") {
      return "";
    }
    return name.substring(1, name.length);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesTags = ref.watch(rolesTagsProvider);
    final apparentName = useState(defaultText);
    final queryController = useTextEditingController(text: '');
    final usersNotifier = ref.watch(userList.notifier);
    final memberRoleTagsNotifier = ref.watch(memberRolesTagsProvider.notifier);
    final rolesTagsNotifier = ref.watch(rolesTagsProvider.notifier);

    List<bool> checked = [];
    apparentNameController.text = apparentName.value;
    return AlertDialog(
      title: Center(
          child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)),
                color: Colors.white,
              ),
              child: Text(title, style: const TextStyle(fontSize: 20)))),
      content: SizedBox(
        height: 390,
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                tokenExpireWrapper(ref, () async {
                  if (queryController.text.isNotEmpty) {
                    await usersNotifier.filterUsers(queryController.text);
                  } else {
                    usersNotifier.clear();
                  }
                });
              },
              cursorColor: Colors.black,
              controller: queryController,
              decoration: const InputDecoration(
                labelText: PhonebookTextConstants.member,
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SearchResult(queryController: queryController),
            ...rolesTags.when(
              data: (data) {
                return data.item1.tags
                    .map((e) => Row(children: [
                          Text(e),
                          const Spacer(),
                          Checkbox(
                            value: data.item2[data.item1.tags.indexOf(e)],
                            fillColor: MaterialStateProperty.all(Colors.black),
                            onChanged: (value) {
                              checked = data.item2;
                              checked[data.item1.tags.indexOf(e)] = value!;
                              debugPrint(checked.toString());
                              apparentName.value = nameConstructor(data);
                              apparentNameController.text = apparentName.value;
                              memberRoleTagsNotifier
                                  .setRoleTagsWithFilter(data);
                            },
                          )
                        ]))
                    .toList();
              },
              error: (e, s) => [const Text('Error')],
              loading: () => [const Text('Loading')],
            ),
            const SizedBox(height: 5),
            const Text(PhonebookTextConstants.apparentName),
            TextField(
              controller: apparentNameController,
            )
          ],
        )),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(PhonebookTextConstants.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
            rolesTagsNotifier.resetChecked();
          },
          child: const Text(PhonebookTextConstants.validation),
        ),
      ],
    );
  }
}
