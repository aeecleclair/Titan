import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/tools/constants.dart';

class ProductUi extends ConsumerWidget {
  final Product product;
  final Function onclick;
  final bool isModification;
  const ProductUi({
    super.key,
    required this.product,
    required this.onclick,
    required this.isModification,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 55,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 15),
              Container(
                width: 50,
                alignment: Alignment.centerRight,
                child: Text(
                  "${product.price.toStringAsFixed(2)}€",
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(width: 15),
              Checkbox(
                value: isModification,
                checkColor: AMAPColorConstants.background,
                activeColor: AMAPColorConstants.green2,
                onChanged: (value) {
                  onclick();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
