import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/elocaps/ui/search.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/user/providers/user_provider.dart';

class PlayerForm extends HookConsumerWidget {
  const PlayerForm({Key? key, required this.num,required this.queryController}) : super(key: key);

  final int num;
  final TextEditingController queryController;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final user = ref.watch(userProvider);
    
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
            borrower: useState(user.toSimpleUser()),
            queryController: queryController)
      ],
    );
  }
}
