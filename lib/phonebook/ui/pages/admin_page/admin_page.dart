import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    return Expanded(
      child: Column(children: [
        const Center(
          child : Text("Admin Page", style: TextStyle(fontSize: 40))),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.red
              ),
            child: GestureDetector(
              child: const Center(child : Text("Manage Association", style: TextStyle(fontSize: 40))),
              onTap: () {
                pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
              },
        ))),
        Expanded(
          child : Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.red
              ),
            child: GestureDetector(
              child: const Center( child : Text("Edit Role", style: TextStyle(fontSize: 40))),
              onTap: () {
                pageNotifier.setPhonebookPage(PhonebookPage.editRole);
              },
        )))
      ]));
  }
}
