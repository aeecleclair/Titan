import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';

class ProductDetailCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const ProductDetailCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      width: 130,
      height: 100,
      colors: const [
        AMAPColorConstants.lightGradient1,
        AMAPColorConstants.lightGradient2,
      ],
      shadowColor: AMAPColorConstants.textDark.withValues(alpha: 0.3),
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AMAPColorConstants.darkGreen,
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            "${AMAPTextConstants.quantity} : $quantity",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            '${((product.price * quantity) / 100).toStringAsFixed(2)} €',
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AMAPColorConstants.darkGreen,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
