import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/boutons_choix_produits.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/list_produits.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/point_affichage.dart';

class ListProductPage extends HookConsumerWidget {
  const ListProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [ListProducts(), Dots(), Boutons()],
    );
  }
}
