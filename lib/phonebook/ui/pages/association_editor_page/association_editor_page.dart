import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class AssociationEditorPage extends HookConsumerWidget {
  const AssociationEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    Association association = ref.watch(associationProvider);
    final associationPicture = ref.watch(associationPictureProvider);
    final associationPictureNotifier = ref.watch(associationPictureProvider.notifier);
    String text = "";
    if (association.id == "") {
      text = "Ajouter une association";
    }
    else {
      text = "Modifier une association";
    }
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
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
                            onTap: () async {
                              final value = await associationPictureNotifier
                                  .setAssociationPicture(ImageSource.gallery, association.id);
                              if (value != null) {
                                if (value) {
                                  displayToastWithContext(
                                      TypeMsg.msg,
                                      PhonebookTextConstants
                                          .updatedAssociationPicture);
                                } else {
                                  displayToastWithContext(
                                      TypeMsg.error,
                                      PhonebookTextConstants
                                          .tooHeavyAssociationPicture);
                                }
                              } else {
                                displayToastWithContext(TypeMsg.error,
                                    PhonebookTextConstants.errorAssociationPicture);
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    ColorConstants.gradient1,
                                    ColorConstants.gradient2,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstants.gradient2
                                        .withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: const HeroIcon(
                                HeroIcons.photo,
                                color: Colors.white,
                              ),
                            ),
                          ),),
            Row(children: [ 
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/2.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.red
                      ),
                    child: const Center(child : Text(PhonebookTextConstants.cancel, style: TextStyle(fontSize: 20))),),
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
                    child: const Center(child : Text(PhonebookTextConstants.validation, style: TextStyle(fontSize: 20))),
                  ),
                    onTap: () {
                      pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
                    },
                )
                
            ]),
      ]));
  }
}