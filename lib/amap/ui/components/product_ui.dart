import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/card_button.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function() onEdit;
  final Future Function() onDelete;
  final bool showButton;
  static void noAction() {}
  static Future noAsyncAction() async {}
  const ProductCard(
      {super.key,
      required this.product,
      this.onEdit = noAction,
      this.onDelete = noAsyncAction,
      this.showButton = true});

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      width: 130,
      height: showButton ? 160 : 130,
      colors: const [
        AMAPColorConstants.lightGradient1,
        AMAPColorConstants.lightGradient2,
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0, top: 5, right: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            AutoSizeText(product.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.darkGreen)),
            const SizedBox(height: 4),
            AutoSizeText(product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 4),
            AutoSizeText('${product.price.toStringAsFixed(2)} €',
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AMAPColorConstants.darkGreen)),
            const Spacer(),
            showButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onEdit,
                        child: const CardButton(
                          gradient1: AMAPColorConstants.greenGradient2,
                          gradient2: AMAPColorConstants.textDark,
                          child:
                              HeroIcon(HeroIcons.pencil, color: Colors.white),
                        ),
                      ),
                      ShrinkButton(
                        onTap: onDelete,
                        builder: (child) => CardButton(
                            gradient1: AMAPColorConstants.redGradient1,
                            gradient2: AMAPColorConstants.redGradient2,
                            child: child),
                        child: const HeroIcon(HeroIcons.trash,
                            color: Colors.white),
                      )
                    ],
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                        "${AMAPTextConstants.quantity} : ${product.quantity}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AMAPColorConstants.darkGreen)),
                  ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
