import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/tombola/ui/pages/lots_pages/add_edit_lot_page.dart';
import 'package:myecl/tombola/ui/pages/main_page/main_page.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/tombola_page.dart';
import 'package:myecl/tombola/ui/pages/type_ticket_pages/add_edit_type_ticket_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(tombolaPageProvider);
    switch (page) {
      case TombolaPage.main:
        return const MainPage();
      case TombolaPage.detail:
        return const TombolaInfoPage();
      case TombolaPage.addEditLot:
        return const AddEditLotPage();
      case TombolaPage.addEditTypeTicketSimple:
        return const AddEditTypeTicketSimplePage();
      case TombolaPage.admin:
        return const AdminPage();
    }
  }
}
