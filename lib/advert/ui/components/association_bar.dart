import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';
import 'package:titan/advert/providers/selected_association_provider.dart';
import 'package:titan/advert/ui/components/association_item.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';

class AssociationBar extends HookConsumerWidget {
  final bool useUserAssociations;
  final bool multipleSelect;
  final bool isNotClickable;
  const AssociationBar({
    super.key,
    required this.multipleSelect,
    required this.useUserAssociations,
    this.isNotClickable = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedAssociationProvider);
    final selectedId = selected.map((e) => e.id).toList();
    final selectedNotifier = ref.read(selectedAssociationProvider.notifier);
    final associationList = useUserAssociations
        ? ref.watch(asyncMyAssociationListProvider)
        : ref.watch(associationListProvider);
    return AsyncChild(
      value: associationList,
      builder: (context, userAssociations) => HorizontalListView.builder(
        height: 66,
        items: userAssociations,
        itemBuilder: (context, e, i) {
          final selected = selectedId.contains(e.id);
          return AssociationItem(
            onTap: () {
              if (isNotClickable) {
                return;
              }
              if (multipleSelect) {
                selected
                    ? selectedNotifier.removeAssociation(e)
                    : selectedNotifier.addAssociation(e);
              } else {
                selectedNotifier.clearAssociation();
                if (!selected) {
                  selectedNotifier.addAssociation(e);
                }
              }
            },
            name: e.name,
            avatarName: e.name
                .split(' ')
                .take(2)
                .map((s) => s[0].toUpperCase())
                .join(),
            selected: selected,
          );
        },
      ),
    );
  }
}
