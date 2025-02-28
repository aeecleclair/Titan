import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/order_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/functions.dart';

class CollectionSlotSelector extends HookConsumerWidget {
  final AmapSlotType collectionSlot;
  const CollectionSlotSelector({super.key, required this.collectionSlot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final isSelected = collectionSlot == order.collectionSlot;
    final isFirst = AmapSlotType.values.first == collectionSlot;
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
                ? Colors.white.withValues(alpha: 0.7)
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              capitalize(collectionSlot.name.split(".")[1]),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AMAPColorConstants.greenGradient2
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
