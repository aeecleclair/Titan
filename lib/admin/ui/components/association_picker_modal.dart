import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class AssociationPickerModal extends HookConsumerWidget {
  final Association selected;
  final void Function(Association association) onSelect;

  const AssociationPickerModal({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationList = ref.watch(associationListProvider);
    final query = useState('');
    final localizeWithContext = AppLocalizations.of(context)!;

    return BottomModalTemplate(
      title: localizeWithContext.paiementSelectAssociation,
      type: BottomModalType.main,
      child: Column(
        children: [
          CustomSearchBar(
            autofocus: true,
            onSearch: (value) => query.value = value.toLowerCase(),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280),
            child: AsyncChild(
              value: associationList,
              builder: (context, associations) {
                final filtered = query.value.isEmpty
                    ? [...associations]
                    : associations
                          .where(
                            (a) => a.name.toLowerCase().contains(query.value),
                          )
                          .toList();
                filtered.sort(
                  (a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                );
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _AssociationRow(
                        label: localizeWithContext.paiementNoAssociation,
                        isSelected: selected.id.isEmpty,
                        onTap: () {
                          onSelect(Association.empty());
                          Navigator.of(context).pop();
                        },
                      ),
                      ...filtered.map(
                        (association) => _AssociationRow(
                          label: association.name,
                          isSelected: selected.id == association.id,
                          onTap: () {
                            onSelect(association);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AssociationRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AssociationRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: ColorConstants.tertiary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            HeroIcon(
              isSelected ? HeroIcons.check : HeroIcons.plus,
              color: ColorConstants.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
