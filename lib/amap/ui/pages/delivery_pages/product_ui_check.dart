import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/providers/theme_provider.dart';

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
    final isDarkTheme = ref.watch(themeProvider);
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
                checkColor: AMAPColors(isDarkTheme).background,
                activeColor: AMAPColors(isDarkTheme).secondaryFixedGreen,
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
