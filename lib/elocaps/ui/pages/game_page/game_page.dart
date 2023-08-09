import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/search.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class GamePage extends HookConsumerWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryController = useTextEditingController(text: "");
    final usersNotifier = ref.watch(userList.notifier);

    return ElocapsTemplate(
        child: Column(
      children: [
        Form(
          key: key,
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
                  labelText: "Joueur 1",
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
              SearchResult(
                  borrower: useState(SimpleUser(
                      firstname: "rae",
                      id: '5',
                      name: 'jys',
                      nickname: 'Bambou')),
                  queryController: queryController),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const RadialGradient(
                    center: Alignment
                        .center, 
                    radius: 0.5, 
                    colors: [
                      Color.fromARGB(71, 242, 73, 0),
                      Color.fromARGB(255, 253, 203, 85),
                      Color.fromARGB(255, 255, 243, 134),
                      Colors.white
                    ], 
                  ),
                ),
                child: const Text(
                  "+",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 242, 73, 0),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        const MyButton(text: "Lancer la partie"),
      ],
    ));
  }
}
