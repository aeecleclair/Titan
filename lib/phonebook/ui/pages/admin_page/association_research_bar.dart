import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AssociationResearchBar extends HookConsumerWidget {
  const AssociationResearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationListNotifier =
        ref.watch(associationListProvider.notifier);
    final focusNode = useFocusNode();
    final editingController = useTextEditingController();
    return Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: 300,
        child: TextField(
          onChanged: (value) {
            associationListNotifier.setAssociationList(associationListNotifier.filterAssociations(value));
          },
          focusNode: focusNode,
          controller: editingController,
          cursorColor: PhonebookColorConstants.textDark,
          decoration: const InputDecoration(
              labelText: PhonebookTextConstants.associationPureSearch,
              labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PhonebookColorConstants.textDark),
              suffixIcon: Icon(
                Icons.search,
                color: PhonebookColorConstants.textDark,
                size: 30,
              )),
        ));
  }
}
