import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function()? onEdit;
  final Future Function()? onDelete;
  final bool showButton;
  const ProductCard({
    super.key,
    required this.product,
    this.onEdit,
    this.onDelete,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      id: product.id,
      width: 130,
      height: showButton ? 155 : 130,
      colors: const [
        AMAPColorConstants.lightGradient1,
        AMAPColorConstants.lightGradient2,
      ],
      padding: const EdgeInsets.only(left: 17.0, top: 5, right: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          AutoSizeText(
            product.category,
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
            product.name,
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
            '${product.price.toStringAsFixed(2)} €',
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AMAPColorConstants.darkGreen,
            ),
          ),
          const Spacer(),
          showButton
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: const CardButton(
                        colors: [
                          AMAPColorConstants.greenGradient2,
                          AMAPColorConstants.textDark,
                        ],
                        child: HeroIcon(HeroIcons.pencil, color: Colors.white),
                      ),
                    ),
                    WaitingButton(
                      onTap: onDelete,
                      builder: (child) => CardButton(
                        colors: const [
                          AMAPColorConstants.redGradient1,
                          AMAPColorConstants.redGradient2,
                        ],
                        child: child,
                      ),
                      child: const HeroIcon(
                        HeroIcons.trash,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "${AMAPTextConstants.quantity} : ${product.quantity}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AMAPColorConstants.darkGreen,
                    ),
                  ),
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
