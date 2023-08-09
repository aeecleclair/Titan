import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/ui/button.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/search.dart';
import 'package:myecl/user/class/list_users.dart';

class GamePage extends HookConsumerWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryController = useTextEditingController(text: "");
    return ElocapsTemplate(
        child: Column(
      children: [
        Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
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
              SearchResult(borrower: useState(SimpleUser(firstname: "rae", id: '5', name: 'jys', nickname: 'Bambou')), queryController: queryController),
            ],
          ),
        ),
        const SizedBox(height: 30),
        MyButton(text: "Lancer la partie"),
      ],
    ));
  }
}
