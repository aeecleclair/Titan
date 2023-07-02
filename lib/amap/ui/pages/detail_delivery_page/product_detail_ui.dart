import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProductDetailCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const ProductDetailCard(
      {super.key,
      required this.product,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: 130,
        height: 100,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            colors: [
              AMAPColorConstants.lightGradient1,
              AMAPColorConstants.lightGradient2
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
              AutoSizeText(product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AMAPColorConstants.darkGreen)),
              const SizedBox(height: 4),
              AutoSizeText("${AMAPTextConstants.quantity} : $quantity",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 4),
              AutoSizeText('${(product.price * quantity).toStringAsFixed(2)} €',
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AMAPColorConstants.darkGreen)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
