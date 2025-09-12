import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/providers/delivery_provider.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/functions.dart';

class DeliveryUi extends HookConsumerWidget {
  final Delivery delivery;
  final VoidCallback onTap;
  final bool showSelected;
  const DeliveryUi({
    super.key,
    required this.delivery,
    required this.onTap,
    this.showSelected = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDelivery = ref.watch(deliveryProvider);
    final selected = selectedDelivery.id == delivery.id;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              (selected && showSelected)
                  ? AMAPColorConstants.greenGradient2
                  : Colors.white,
              (selected && showSelected)
                  ? AMAPColorConstants.textDark
                  : Colors.white,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AMAPColorConstants.textDark.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${delivery.name} ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: (selected && showSelected)
                          ? Colors.white
                          : AMAPColorConstants.textDark,
                    ),
                  ),
                  Text(
                    '${AMAPTextConstants.the} ${processDate(delivery.deliveryDate)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: (selected && showSelected)
                          ? Colors.white
                          : AMAPColorConstants.textDark,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "${delivery.products.length} ${AMAPTextConstants.product}${delivery.products.length != 1 ? "s" : ""}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: (selected && showSelected)
                      ? Colors.white
                      : AMAPColorConstants.textLight,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
