import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/ui/pages/add_cmd_page/add_cmd_page.dart';
import 'package:myecl/amap/ui/pages/add_solde_page/add_solde_page.dart';
import 'package:myecl/amap/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/amap/ui/pages/cmd_page/affichage_commandes.dart';
import 'package:myecl/amap/ui/pages/delivery_page/delivery_page.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/list_produits_page.dart';
import 'package:myecl/amap/ui/pages/main_page/text.dart';
import 'package:myecl/amap/ui/page_scheme.dart';
import 'package:myecl/amap/ui/pages/modif_produits/modif_produit.dart';
import 'package:myecl/amap/ui/pages/solde_page/solde_pages.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    switch (page) {
      case AmapPage.main:
        return const PageScheme(subPage: ListeOrders());
      case AmapPage.pres:
        return const PageScheme(subPage: TextPresentation());
      case AmapPage.products:
        return const ListProductPage();
      case AmapPage.admin:
        return const AdminPage();
      case AmapPage.modif:
        return const ModifProduct();
      case AmapPage.addCmd:
        return const AddCmdPage();
      case AmapPage.delivery:
        return const DeliveryPage();
      case AmapPage.solde:
        return const SoldePage();
      case AmapPage.addSolde:
        return const AddSoldePage();
      default:
        return const PageScheme(subPage: ListeOrders());
    }
  }
}
