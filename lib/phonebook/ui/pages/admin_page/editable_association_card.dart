import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/delete_button.dart';
import 'package:myecl/phonebook/ui/edition_button.dart';

class EditableAssociationCard extends HookConsumerWidget {
  final Association association;
  final void Function() onEdit;
  final Future Function() onDelete;
  const EditableAssociationCard(
      {super.key,
      required this.association,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationPicture =
        ref.watch(associationPictureProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2)
          ]),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
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
          const SizedBox(width: 10),
          Text(
            association.name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(association.kind,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          EditionButton(onEdition: () async {
            onEdit();
          }),
          const SizedBox(width: 10),
          DeleteButton(onDelete: () async {
            await onDelete();
          }),


        ],
      ),
    );
  }
}
