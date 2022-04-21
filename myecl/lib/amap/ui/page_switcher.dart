import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/amap/ui/pages/cmd_page/affichage_commandes.dart';
import 'package:myecl/amap/ui/pages/list_produits_page/list_produits_page.dart';
import 'package:myecl/amap/ui/pages/main_page/text.dart';
import 'package:myecl/amap/ui/pages/modif_produits/modif_produit.dart';
import 'package:myecl/amap/ui/pages/page_scheme.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    switch (page) {
      case 0:
        return const PageScheme(subPage: ListeCommandes());
      case 1:
        return const PageScheme(subPage: TextPresentation());
      case 2:
        return const ListProduitPage();
      case 3:
        return const AdminPage();
      case 4:
        return const ModifProduit();
      default:
        return const PageScheme(subPage: ListeCommandes());
    }
  }
}
