import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';

class HorizontalMultiSelect<T> extends HookWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index, bool selected)
  itemBuilder;
  final Widget? firstChild;
  final Function(T item)? onItemSelected;
  final Function(T item)? onLongPress;
  final Widget? title;
  const HorizontalMultiSelect({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.firstChild,
    this.onItemSelected,
    this.onLongPress,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final selected = useState<int?>(null);
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
        return ItemChip(
          selected: selected.value == index,
          onTap: () {
            selected.value = index;
            onItemSelected?.call(item);
          },
          onLongPress: () => onLongPress?.call(item),
          child: itemBuilder(context, item, index, selected.value == index),
        );
      },
    );
  }
}
