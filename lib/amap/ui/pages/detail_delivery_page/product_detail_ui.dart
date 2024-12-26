import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

class ProductDetailCard extends ConsumerWidget {
  final Product product;
  final int quantity;
  const ProductDetailCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return CardLayout(
      width: 130,
      height: 100,
      colors: [
        AMAPColors(isDarkTheme).lightGradientPrimary,
        AMAPColors(isDarkTheme).lightGradientSecondary,
      ],
      shadowColor: AMAPColors(isDarkTheme).textOnPrimary.withOpacity(0.3),
      padding: const EdgeInsets.only(left: 17.0, top: 5, right: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          AutoSizeText(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AMAPColors(isDarkTheme).secondaryGreen,
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            "${AMAPTextConstants.quantity} : $quantity",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            '${(product.price * quantity).toStringAsFixed(2)} €',
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AMAPColors(isDarkTheme).secondaryGreen,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
