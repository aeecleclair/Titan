import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';

class AssociationGroupementBar extends HookConsumerWidget {
  AssociationGroupementBar({
    super.key,
    this.editable = false,
    this.scrollDirection = Axis.horizontal,
  });
  final dataKey = GlobalKey();
  final bool editable;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupement = ref.watch(associationGroupementProvider);
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationGroupementList = ref.watch(
      associationGroupementListProvider,
    );
    final associationGroupementListNotifier = ref.watch(
      associationGroupementListProvider.notifier,
    );

    void showSnackBarWithContext(String message) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    void popWithContext() {
      Navigator.of(context).pop();
    }

    void showEditDialog(AssociationGroupement item) => showCustomBottomModal(
      ref: ref,
      context: context,
      modal: BottomModalTemplate(
        title: item.name,
        actions: [
          Button(
            text: "Modifier",
            onPressed: () {
              associationGroupementNotifier.setAssociationGroupement(item);
              QR.to(
                PhonebookRouter.root +
                    PhonebookRouter.admin +
                    PhonebookRouter.addEditAssociation +
                    PhonebookRouter.addEditGroupement,
              );
            },
          ),
          SizedBox(height: 30),
          Button.danger(
            text: "Supprimer",
            onPressed: () async {
              final result = await associationGroupementListNotifier
                  .deleteAssociationGroupement(item);
              if (result && context.mounted) {
                popWithContext();
                showSnackBarWithContext("Groupe supprimé");
              }
              if (!result && context.mounted) {
                showSnackBarWithContext(
                  "Une erreur est survenue lors de la suppression du groupe",
                );
              }
            },
          ),
        ],
        child: SizedBox.shrink(),
      ),
    );

    useEffect(() {
      Future(() {
        if (associationGroupement.id != "") {
          Scrollable.ensureVisible(
            dataKey.currentContext!,
            duration: const Duration(milliseconds: 500),
            alignment: 0.5,
          );
        }
      });
      return;
    }, [dataKey]);
    return AsyncChild(
      value: associationGroupementList,
      builder: (context, associationGroupements) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: scrollDirection == Axis.horizontal
            ? 40
            : min(associationGroupements.length * 50, 220),
        child: ListView.builder(
          scrollDirection: scrollDirection,
          itemCount: editable
              ? associationGroupements.length + 1
              : associationGroupements.length,
          itemBuilder: (context, index) {
            if (editable && index == 0) {
              return ItemChip(
                key: Key("add"),
                scrollDirection: scrollDirection,
                onTap: () {
                  associationGroupementNotifier.resetAssociationGroupement();
                  QR.to(
                    PhonebookRouter.root +
                        PhonebookRouter.admin +
                        PhonebookRouter.addEditAssociation +
                        PhonebookRouter.addEditGroupement,
                  );
                },
                child: Text("+", style: TextStyle(fontWeight: FontWeight.bold)),
              );
            }
            final item = associationGroupements[editable ? index - 1 : index];
            final selected = associationGroupement.id == item.id;
            return ItemChip(
              key: selected ? dataKey : null,
              scrollDirection: scrollDirection,
              selected: selected,
              onTap: () {
                associationGroupement.id != item.id
                    ? associationGroupementNotifier.setAssociationGroupement(
                        item,
                      )
                    : associationGroupementNotifier
                          .resetAssociationGroupement();
              },
              onLongPress: () => showEditDialog(item),
              child: Text(
                item.name,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
