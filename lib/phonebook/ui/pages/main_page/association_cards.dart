import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class AssociationCards extends HookConsumerWidget {
  const AssociationCards({super.key,
      required this.association
  });

  final Association association;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationPicture = ref.watch(associationPictureProvider);
    
    return GestureDetector(
      onTap: () {
        associationNotifier.setAssociation(association);
        pageNotifier.setPhonebookPage(PhonebookPage.associationPage);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        
        child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
          
            child:
            associationPicture.when(data: (picture){
              return CircleAvatar(
              radius: 80,
              backgroundImage: picture.isEmpty ?
              const AssetImage('assets/images/profile.png') :
              Image.memory(picture).image,
            );
            }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, error: (e, s) {
            return const Center(
              child: Text(PhonebookTextConstants.errorLoadAssociationPicture),
            );
          }, 
          ),
          ),
          const SizedBox(width: 10),
          SizedBox(
              width: 200,
              child: Text(
                association.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      )
    )
    );                         
  }
}