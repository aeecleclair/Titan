import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';

class HorizontalMultiSelect<T> extends HookWidget {
  final List<T> items;
  final T? selectedItem;
  final Widget Function(BuildContext context, T item, int index, bool selected)
  itemBuilder;
  final Widget? firstChild;
  final Function(T item)? onItemSelected;
  final Function(T item)? onLongPress;
  final Function(T item1, T item2)? isEqual;
  final Widget? title;
  const HorizontalMultiSelect({
    super.key,
    required this.items,
    this.selectedItem,
    required this.itemBuilder,
    this.firstChild,
    this.onItemSelected,
    this.onLongPress,
    this.isEqual,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length + (firstChild != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == 0 && firstChild != null) {
          return firstChild!;
        }
        final item = items[index - (firstChild != null ? 1 : 0)];
        final selected = isEqual != null
            ? selectedItem != null
                  ? isEqual!(item, selectedItem as T)
                  : false
            : item == selectedItem;
        return ItemChip(
          selected: selected,
          onTap: () => onItemSelected != null ? onItemSelected!(item) : null,
          onLongPress: () => onLongPress != null ? onLongPress!(item) : null,
          child: itemBuilder(context, item, index, selected),
        );
      },
    );
  }
}
