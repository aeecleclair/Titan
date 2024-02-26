import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/completeMember.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';

class AssociationPage extends HookConsumerWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationNotifier = ref.watch(associationProvider.notifier);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final search = useState("");
    return Column(children: [
                  const Text(PhonebookTextConstants.phonebookSearchField),
                  const SizedBox(
                      width: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (String value) {
                        search.value = value;
                      },
                    )),
                  ElevatedButton(
                    onPressed: (){
                      associationNotifier.setAssociation(Association.empty());
                      pageNotifier.setPhonebookPage(PhonebookPage.associationEditor);
                      }, 
                    child: const Text(PhonebookTextConstants.addAssociation)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    color: Colors.black,
                    height: 2,
                  ),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(1),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          "Nom $index Prénom $index (Surnom $index)")),
                                ],
                              ),
                              subtitle: Text("Email: $index"),
                              onTap: () {
                                associationNotifier.setAssociation(
                                    Association.empty());
                                pageNotifier.setPhonebookPage(
                                    PhonebookPage.associationEditor);
                              },
                            ));
                          }))]);
  }
}