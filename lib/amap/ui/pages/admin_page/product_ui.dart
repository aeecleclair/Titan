import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function() onEdit, onDelete;
  const ProductCard(
      {super.key,
      required this.product,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: 130,
        height: 145,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            colors: [
              Color.fromARGB(223, 182, 212, 10),
              Color.fromARGB(255, 108, 147, 0),
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
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
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
                      color: Color.fromARGB(255, 32, 67, 0))),
              const SizedBox(height: 2),
              AutoSizeText(product.category,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 2),
              AutoSizeText('${product.price} €',
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 32, 67, 0))),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AMAPColorConstants.greenGradient2,
                            AMAPColorConstants.textDark,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  AMAPColorConstants.textDark.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 3))
                        ],
                      ),
                      child:
                          const HeroIcon(HeroIcons.pencil, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AMAPColorConstants.redGradient1,
                            AMAPColorConstants.redGradient2,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: AMAPColorConstants.redGradient2
                                  .withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 3))
                        ],
                      ),
                      child:
                          const HeroIcon(HeroIcons.trash, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
