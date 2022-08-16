import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/ui/pages/add_asso_page/add_asso_page.dart';
import 'package:myecl/admin/ui/pages/add_member_page/add_member_page.dart';
import 'package:myecl/admin/ui/pages/asso_page/asso_page.dart';
import 'package:myecl/admin/ui/pages/edit_page/edit_page.dart';
import 'package:myecl/admin/ui/pages/main_page/main_page.dart';
class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(adminPageProvider);
    switch (page) {
      case AdminPage.main:
        return const MainPage();
      case AdminPage.asso:
        return const AssoPage();
      case AdminPage.addAsso:
        return const AddAssoPage();
      case AdminPage.addMember:
        return const AddMemberPage();
      case AdminPage.edit:
        return const EditPage();
    }
  }
}
