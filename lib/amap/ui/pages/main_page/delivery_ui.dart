import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

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
    final isDarkTheme = ref.watch(themeProvider);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              (selected && showSelected)
                  ? AMAPColors(isDarkTheme).greenGradientSecondary
                  : Theme.of(context).colorScheme.surface,
              (selected && showSelected)
                  ? AMAPColors(isDarkTheme).textOnPrimary
                  : Theme.of(context).colorScheme.surface,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color:
                  AMAPColors(isDarkTheme).textOnPrimary.withValues(alpha: 0.2),
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
              Text(
                '${AMAPTextConstants.the} ${processDate(delivery.deliveryDate)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: (selected && showSelected)
                      ? Theme.of(context).colorScheme.onSecondary
                      : AMAPColors(isDarkTheme).textOnPrimary,
                ),
              ),
              const Spacer(),
              Text(
                "${delivery.products.length} ${AMAPTextConstants.product}${delivery.products.length != 1 ? "s" : ""}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: (selected && showSelected)
                      ? Theme.of(context).colorScheme.onSecondary
                      : AMAPColors(isDarkTheme).textOnSecondary,
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
