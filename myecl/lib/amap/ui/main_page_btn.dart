import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/ui/top_button.dart';
import 'package:myecl/reservation/providers/is_admin_provider.dart';


/// Les boutons pour changer de page
class MainPageBtn extends HookConsumerWidget {
  const MainPageBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final isAdmin = ref.watch(isAdminProvider);
    List<Widget> btns = [
      // Le bouton pour aller sur la page des commandes
      TopButton(text: "Mes commandes", selected: page == 0, onclick: () {
        pageNotifier.setAmapPage(0);
      }),
      // Le bouton pour aller sur la page de présentation
      TopButton(text: "Présentation", selected: page == 1, onclick: () {
        pageNotifier.setAmapPage(1);
      }),
    ];
    // Si la personne est administrateur AMAP
    if (isAdmin) {
      // Le bouton pour aller sur la page administrateur
      btns.add(TopButton(text: "Administrateur", selected: page == 3, onclick: () {
        pageNotifier.setAmapPage(3);
      }));
    }
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 100,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: btns,
          ),
        ));
  }
}
