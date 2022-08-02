import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/solde_page/cash_ui.dart';
import 'package:myecl/amap/ui/refresh_indicator.dart';

class SoldePage extends HookConsumerWidget {
  const SoldePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashList = ref.watch(cashProvider);
    final cashListNotifier = ref.watch(cashProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    var listWidgetCash = [];
    cashList.when(
      data: (cash) {
        if (cash.isNotEmpty) {
          listWidgetCash.addAll([
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Liste des utilisateurs",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorConstants.textDark,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]);
          for (Cash c in cash) {
            listWidgetCash.add(CashUi(c: c, i: cash.indexOf(c)));
          }
        } else {
          listWidgetCash.add(Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text(
                  "Pas d'utilisateur actuellement",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ));
        }
      },
      error: (error, s) {
        listWidgetCash.add(Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                "Pas d'utilisateur actuellement",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
      },
      loading: () {
        listWidgetCash.add(Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorConstants.textDark,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
      },
    );

    return Refresh(
      keyRefresh: GlobalKey<RefreshIndicatorState>(),
      onRefresh: () async {
        cashListNotifier.loadCashList();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ...listWidgetCash,
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const GreenBtn(text: "Ajouter un utilisateur"),
              onTap: () {
                pageNotifier.setAmapPage(AmapPage.addSolde);
              },
            )
          ],
        ),
      ),
    );
  }
}
