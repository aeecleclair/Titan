import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/components/edit_delete_button.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function() onEdit;
  final Future Function() onDelete;
  final bool showButton;
  const ProductCard(
      {super.key,
      required this.product,
      required this.onEdit,
      required this.onDelete,
      this.showButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: 130,
        height: showButton ? 160 : 130,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            colors: [
              AMAPColorConstants.lightGradient1,
              AMAPColorConstants.lightGradient2,
            ],
            center: Alignment.topLeft,
            radius: 1.2,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AMAPColorConstants.textDark.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
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
                          child: const EditDeleteButton(
                            gradient1: AMAPColorConstants.greenGradient2,
                            gradient2: AMAPColorConstants.textDark,
                            child:
                                HeroIcon(HeroIcons.pencil, color: Colors.white),
                          ),
                        ),
                        ShrinkButton(
                            waitChild: const EditDeleteButton(
                                gradient1: AMAPColorConstants.redGradient1,
                                gradient2: AMAPColorConstants.redGradient2,
                                child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                )),
                            onTap: onDelete,
                            child: const EditDeleteButton(
                              gradient1: AMAPColorConstants.redGradient1,
                              gradient2: AMAPColorConstants.redGradient2,
                              child: HeroIcon(HeroIcons.trash,
                                  color: Colors.white),
                            ))
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
      ),
    );
  }
}
