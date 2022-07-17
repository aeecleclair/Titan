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
      case 0:
        return const PageScheme(subPage: ListeOrders());
      case 1:
        return const PageScheme(subPage: TextPresentation());
      case 2:
        return const ListProductPage();
      case 3:
        return const AdminPage();
      case 4:
        return const ModifProduct();
      case 5:
        return const AddCmdPage();
      case 6:
        return const DeliveryPage();
      case 7:
        return const SoldePage();
      case 8:
        return const AddSoldePage();
      default:
        return const PageScheme(subPage: ListeOrders());
    }
  }
}
