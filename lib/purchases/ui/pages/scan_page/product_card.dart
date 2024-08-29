import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/class/product.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class ProductCard extends HookConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onClicked,
  });

  final Product product;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: onClicked,
        child: CardLayout(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.nameFR} / ${product.nameEN}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${product.ticketMaxUse} scan${(product.ticketMaxUse ?? 0) > 1 ? 's' : ""} maximun - Valide jusqu'au ${product.ticketExpiration != null ? processDate(product.ticketExpiration!) : ""}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
