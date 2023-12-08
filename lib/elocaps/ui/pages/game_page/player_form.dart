import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/elocaps/ui/pages/game_page/search.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class PlayerForm extends HookConsumerWidget {
  const PlayerForm({Key? key, required this.num,required this.queryController,required this.user}) : super(key: key);

  final int num;
  final TextEditingController queryController;
  final ValueNotifier<SimpleUser> user;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);

    
    return Column(
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
          decoration: InputDecoration(
            labelText: "Joueur $num",
            floatingLabelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SearchResult(
            user: user,
            queryController: queryController)
      ],
    );
  }
}