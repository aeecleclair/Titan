import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/paiement_page_provider.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_page.dart';
import 'package:myecl/paiement/ui/pages/pay_page/pay_page.dart';
import 'package:myecl/paiement/ui/pages/qr_page/qr_page.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scan_page.dart';
import 'package:myecl/paiement/ui/pages/stats_page/stats_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(paiementPageProvider);
    switch (page) {
      case PaiementPage.main:
        return const MainPage();
      case PaiementPage.scan:
        return const ScanPage();
      case PaiementPage.pay:
        return const PayPage();
      case PaiementPage.qr:
        return const QrPage();
      case PaiementPage.stats:
        return const StatsPage();
    }
  }
}
