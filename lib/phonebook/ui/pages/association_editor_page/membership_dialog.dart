import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/member_role_tags_provider.dart';
import 'package:myecl/phonebook/providers/roles_tags_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/association_editor_page/search_result.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class MembershipDialog extends HookConsumerWidget{
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

  String nameConstructor (List<String> names, List<bool> checked) {
    String name = '';
    for (int i = 0; i < names.length; i++) {
      if (checked[i]) {
        name ="$name, ${names[i]}";
      }
    }
    return name.substring(1, name.length);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesTags = ref.watch(rolesTagsProvider);
    final apparentName = useState(defaultText);
    final queryController =
        useTextEditingController(text: '');
    final usersNotifier = ref.watch(userList.notifier);
    final memberRoleTagsNotifier = ref.watch(memberRolesTagsProvider.notifier);

    List<bool> checked = [];
    apparentNameController.text = apparentName.value;
    return  AlertDialog(
        title: Center(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black)),
              color: Colors.white,
              ),
            child: Text(title, style: const TextStyle(fontSize: 20))
          )
          ),
        content: SizedBox(
            height: 400,
            child: Column(
            children: [
              const SizedBox(height: 25),
              const Text(PhonebookTextConstants.member),
              const SizedBox(height: 5),
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
                  checked = List.filled(data.tags.length, false);
                  return data.tags.map((e) => Row(
                  children: [
                    Text(e),
                    const Spacer(),
                    Checkbox(
                      value: false,
                      fillColor: MaterialStateProperty.all(Colors.black),
                      onChanged: (value) {
                        checked[data.tags.indexOf(e)] = value!;
                        debugPrint(checked.toString());
                        apparentName.value = nameConstructor(data.tags, checked);
                        apparentNameController.text = apparentName.value;
                        memberRoleTagsNotifier.setRoleTagsWithFilter(data.tags, checked);
                      },
                  )])).toList();
                },
                error: (e,s) => [const Text('Error')],
                loading: () => [const Text('Loading')],),
              const SizedBox(height: 5),
              const Text(PhonebookTextConstants.apparentName),
              TextField(
                controller: apparentNameController,
              )

            ],
        )),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: const Text(PhonebookTextConstants.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text(PhonebookTextConstants.validation),
          ),
        ],
      );
  }
}