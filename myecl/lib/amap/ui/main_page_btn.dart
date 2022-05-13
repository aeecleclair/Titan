import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/ui/top_button.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';

class MainPageBtn extends HookConsumerWidget {
  const MainPageBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final isAdmin = ref.watch(isAmapAdminProvider);
    List<Widget> btns = [
      TopButton(
          text: "Mes Commandes",
          selected: page == 0,
          onclick: () {
            pageNotifier.setAmapPage(0);
          }),
      TopButton(
          text: "Présentation",
          selected: page == 1,
          onclick: () {
            pageNotifier.setAmapPage(1);
          }),
    ];

    if (isAdmin) {
      btns.add(TopButton(
          text: "Administrateur",
          selected: page == 3,
          onclick: () {
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
