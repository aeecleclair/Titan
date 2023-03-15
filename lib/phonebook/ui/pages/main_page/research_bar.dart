import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ResearchBar extends HookConsumerWidget {
  const ResearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationListNotifier =
        ref.watch(allAssociationListProvider.notifier);
    final focusNode = useFocusNode();
    final editingController = useTextEditingController();
    return Container(
        width: 300,
        child: TextField(
          onChanged: (value) {
            tokenExpireWrapper(ref, () async {
              if (editingController.text.isNotEmpty) {
                await associationListNotifier
                    .loadAssociations(editingController.text);
              } else {
                await associationListNotifier.loadAssociations();
              }
            });
          },
          focusNode: focusNode,
          controller: editingController,
          cursorColor: PhonebookColorConstants.textDark,
          decoration: const InputDecoration(
              labelText: PhonebookTextConstants.associationPure,
              labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PhonebookColorConstants.textDark),
              suffixIcon: Icon(
                Icons.search,
                color: PhonebookColorConstants.textDark,
                size: 30,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PhonebookColorConstants.textDark,
                ),
              )),
        ));
  }
}
