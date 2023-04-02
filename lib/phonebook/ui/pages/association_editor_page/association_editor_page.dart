import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/phonebook/ui/pages/association_editor_page/member_editable_card.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AssociationEditorPage extends HookConsumerWidget {
  const AssociationEditorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationMemberListNotifier = ref.watch(associationMemberListProvider.notifier);
    final associationMemberList = ref.watch(associationMemberListProvider);
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
    return Refresher(
      onRefresh: () async {
        await associationMemberListNotifier.loadMembers(association.id);
        await associationPictureNotifier.getAssociationPicture(association.id);
      },
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
            associationMemberList.when(
              data: (members) {
                return Column(
                  children: members.map((member) => 
                    MemberEditableCard(member: member)
                  ).toList()
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (e, s) {
                //return const Center(
                //  child: Text(PhonebookTextConstants.errorLoadAssociationMember),
                List<CompleteMember> fakeMembers = [CompleteMember.empty()];
                return Column(
                  children: fakeMembers.map((member) => 
                    MemberEditableCard(member: member)
                  ).toList()
                );
              },
            ),
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
                    //to complete
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
                      //to complete
                    },
                )
                
            ]),
      ]));
  }
}