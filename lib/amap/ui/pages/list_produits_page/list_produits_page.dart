import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/amap_backgorund_painter.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/boutons_choix_produits.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/list_produits.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/point_affichage.dart';

class ListProductPage extends HookConsumerWidget {
  const ListProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 200), initialValue: 0)
      ..repeat();
    return SizedBox(
      height: MediaQuery.of(context).size.height - 82,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 122,
                child: CustomPaint(
                  painter: AmapBackgroundPainter(animation: animation),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [ListProducts(), Dots(), Boutons()],
          ),
        ],
      ),
    );
  }
}
