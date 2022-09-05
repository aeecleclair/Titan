import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
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
          text: AMAPTextConstants.myOrders,
          selected: page == AmapPage.main,
          onclick: () {
            pageNotifier.setAmapPage(AmapPage.main);
          }),
      TopButton(
          text: AMAPTextConstants.presentation,
          selected: page == AmapPage.pres,
          onclick: () {
            pageNotifier.setAmapPage(AmapPage.pres);
          }),
    ];

    if (isAdmin) {
      btns.add(TopButton(
          text: AMAPTextConstants.admin,
          selected: page == AmapPage.admin,
          onclick: () {
            pageNotifier.setAmapPage(AmapPage.admin);
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
