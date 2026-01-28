import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/ui/pages/admin_page/delete_button.dart';
import 'package:titan/phonebook/ui/pages/admin_page/edition_button.dart';

class EditableAssociationCard extends HookConsumerWidget {
  final Association association;
  final AssociationGroupement associationGroupement;
  final bool canDelete;
  final bool canEdit;
  final void Function() onEdit;
  final Future Function() onDelete;
  const EditableAssociationCard({
    super.key,
    required this.association,
    required this.associationGroupement,
    required this.canDelete,
    required this.canEdit,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: association.deactivated ? Colors.grey[500] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              association.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              associationGroupement.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              EditionButton(onEdition: onEdit, deactivated: !canEdit),
              const SizedBox(width: 5),
              DeleteButton(
                onDelete: onDelete,
                deactivated: !canDelete,
                deletion: association.deactivated,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
