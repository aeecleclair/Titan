import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';

class AssociationEditorPage extends HookConsumerWidget {
  const AssociationEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    Association association = ref.watch(associationProvider);
    String text = "";
    if (association.id == "") {
      text = "Ajouter une association";
    }
    else {
      text = "Modifier une association";
    }
    return Expanded(
      child: Column(children: [
        Center(
          child : Text(text, style: const TextStyle(fontSize: 20))),
            Row(
              children: const [
                Text("Nom de l'association", style: TextStyle(fontSize: 20)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom de l\'association',
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.red
                ),
              child: GestureDetector(
                child: const Center(child : Text("Insérer option image", style: TextStyle(fontSize: 20))),
                onTap: () {
                  pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
                },
              )),
            Row(children: [ 
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/2.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red
                      ),
                    child: const Center(child : Text("Annuler", style: TextStyle(fontSize: 20))),),
                  onTap: () {
                    pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/2.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red
                      ),
                    child: const Center(child : Text("Valider", style: TextStyle(fontSize: 20))),
                  ),
                    onTap: () {
                      pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
                    },
                )
                
            ]),
      ]));
  }
}