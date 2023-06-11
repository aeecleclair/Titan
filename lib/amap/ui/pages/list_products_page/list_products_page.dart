import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/amap_backgorund_painter.dart';
import 'package:myecl/amap/ui/pages/list_products_page/product_choice_button.dart';
import 'package:myecl/amap/ui/pages/list_products_page/list_products.dart';
import 'package:myecl/amap/ui/pages/list_products_page/pageview_dots.dart';

class ListProductPage extends HookConsumerWidget {
  const ListProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 0)
      ..repeat();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: AmapBackgroundPainter(animation: animation),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(1.0),
                Colors.white.withOpacity(0.8),
                Colors.white.withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ListProducts(), Dots(), Boutons()],
          ),
        ],
      ),
    );
  }
}
