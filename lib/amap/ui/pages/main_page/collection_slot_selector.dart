import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

class CollectionSlotSelector extends HookConsumerWidget {
  final CollectionSlot collectionSlot;
  const CollectionSlotSelector({super.key, required this.collectionSlot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final isSelected = collectionSlot == order.collectionSlot;
    final isFirst = CollectionSlot.values.first == collectionSlot;
    final isDarkTheme = ref.watch(themeProvider);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          orderNotifier.setOrder(
            order.copyWith(
              collectionSlot: collectionSlot,
            ),
          );
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isFirst ? 22 : 0),
              bottomLeft: Radius.circular(isFirst ? 22 : 0),
              topRight: Radius.circular(!isFirst ? 22 : 0),
              bottomRight: Radius.circular(!isFirst ? 22 : 0),
            ),
            color: isSelected
                ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.7)
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              capitalize(uiCollectionSlotToString(collectionSlot)),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AMAPColors(isDarkTheme).greenGradientSecondary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
