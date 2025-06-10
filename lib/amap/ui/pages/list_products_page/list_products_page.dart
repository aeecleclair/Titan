import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/amap/tools/amap_background_painter.dart';
import 'package:titan/amap/ui/amap.dart';
import 'package:titan/amap/ui/pages/list_products_page/product_choice_button.dart';
import 'package:titan/amap/ui/pages/list_products_page/list_products.dart';
import 'package:titan/amap/ui/pages/list_products_page/page_view_dots.dart';

class ListProductPage extends HookConsumerWidget {
  const ListProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 200),
    )..repeat();
    return AmapTemplate(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
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
                    Colors.white,
                    Colors.white.withValues(alpha: 0.8),
                    Colors.white.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ListProducts(), Dots(), ProductChoiceButton()],
            ),
          ],
        ),
      ),
    );
  }
}
