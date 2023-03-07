import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/ui/pages/create_add_edit_page/create_add_edit_page.dart';
import 'package:myecl/tombola/ui/pages/create_home_page/create_home_page.dart';
import 'package:myecl/tombola/ui/pages/main_page/main_page.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/tombola_page.dart';
import 'package:myecl/tombola/ui/pages/admin_page/admin_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(
        tombolaPageProvider); //Returns the value exposed by a provider and rebuild the widget when that value changes.
    switch (page) {
      case TombolaPage.main:
        return const MainPage();
      case TombolaPage.tombola:
        return const TombolaInfoPage();
      case TombolaPage.create:
        return const CreateHomePage();

      case TombolaPage.addEdit:
        return const CreateAddEditPage();
      case TombolaPage.admin:
        return const AdminHomePage();
    }
  }
}
