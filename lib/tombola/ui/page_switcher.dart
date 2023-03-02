

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/ui/pages/add_edit_typetickets_page/add_edit_typetickets_page.dart';
import 'package:myecl/tombola/ui/pages/add_edit_lots_page/add_edit_lots_page.dart';
import 'package:myecl/tombola/ui/pages/create_add_edit_page/create_add_edit_page.dart';
import 'package:myecl/tombola/ui/pages/create_home_page/create_home_page.dart';
import 'package:myecl/tombola/ui/pages/main_page/main_page.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/ui/pages/buy_page/buy_page.dart';
import 'package:myecl/tombola/ui/pages/simu_tombola_page/simu_tombola_page.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/tombola_page.dart';
import 'package:myecl/tombola/ui/pages/admin_page/admin_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(tombolaPageProvider); //Returns the value exposed by a provider and rebuild the widget when that value changes. 
    switch (page) {
      
      case TombolaPage.main:
        return const MainPage();
      case TombolaPage.tombola:
        return const TombolaInfoPage();
      case TombolaPage.achats:
        return const AchatPage();
      case TombolaPage.create:
        return const CreateHomePage();
      case TombolaPage.addEditLots:
        return const AddEditLotsPage();
      case TombolaPage.addEditTypeTickets:
        return const AddEditTypeTicketsPage();
      case TombolaPage.simuTombola:
        return const simuTombolaPage();

      case TombolaPage.addEdit:
      return const CreateAddEditPage();
      case TombolaPage.admin:
      return const AdminHomePage();
      
    }
  }
}