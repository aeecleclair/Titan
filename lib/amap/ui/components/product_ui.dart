import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/providers/theme_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProductCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return CardLayout(
      id: product.id,
      width: 130,
      height: showButton ? 155 : 130,
      colors: [
        AMAPColors(isDarkTheme).lightGradientPrimary,
        AMAPColors(isDarkTheme).lightGradientSecondary,
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AMAPColors(isDarkTheme).secondaryGreen,
            ),
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            product.name,
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
            '${product.price.toStringAsFixed(2)} €',
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AMAPColors(isDarkTheme).secondaryGreen,
            ),
          ),
          const Spacer(),
          showButton
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: CardButton(
                        colors: [
                          AMAPColors(isDarkTheme).greenGradientSecondary,
                          AMAPColors(isDarkTheme).textOnPrimary,
                        ],
                        child: HeroIcon(
                          HeroIcons.pencil,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    WaitingButton(
                      onTap: onDelete,
                      builder: (child) => CardButton(
                        colors: [
                          AMAPColors(isDarkTheme).redGradientPrimary,
                          AMAPColors(isDarkTheme).redGradientSecondary,
                        ],
                        child: child,
                      ),
                      child: HeroIcon(
                        HeroIcons.trash,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "${AMAPTextConstants.quantity} : ${product.quantity}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AMAPColors(isDarkTheme).secondaryGreen,
                    ),
                  ),
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
