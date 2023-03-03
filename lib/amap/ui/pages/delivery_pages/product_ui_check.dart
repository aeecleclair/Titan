import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/constants.dart';

class ProductUi extends ConsumerWidget {
  final Product p;
  final Function onclick;
  final bool isModif;
  const ProductUi(
      {Key? key, required this.p, required this.onclick, required this.isModif})
      : super(key: key);

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
                p.name,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 15,
                ),
                Container(
                  width: 50,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${p.price.toStringAsFixed(2)}€",
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  width: 15,
                ),
                Checkbox(
                  value: isModif,
                  checkColor: AMAPColorConstants.background,
                  activeColor: AMAPColorConstants.green2,
                  onChanged: (value) {
                    onclick();
                  },
                )
              ],
            ),
          ],
        ));
  }
}
