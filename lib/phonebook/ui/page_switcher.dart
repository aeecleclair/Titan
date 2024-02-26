import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/phonebook/ui/pages/association_creation_page/association_creation_page.dart';
import 'package:myecl/phonebook/ui/pages/association_editor_page/association_editor_page.dart';
import 'package:myecl/phonebook/ui/pages/association_page/association_page.dart';
import 'package:myecl/phonebook/ui/pages/main_page/main_page.dart';
import 'package:myecl/phonebook/ui/pages/member_detail_page/member_detail_page.dart';
import 'package:myecl/phonebook/ui/pages/membership_editor_page/membership_editor_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(phonebookPageProvider);
    switch (page) {
      case PhonebookPage.main:
        return const MainPage();
      case PhonebookPage.admin:
        return const AdminPage();
      case PhonebookPage.memberDetail:
        return const MemberDetailPage();
      case PhonebookPage.associationEditor:
        return const AssociationEditorPage();
      case PhonebookPage.associationPage:
        return const AssociationPage();
      case PhonebookPage.associationCreation:
        return const AssociationCreationPage();
      case PhonebookPage.membershipEdition:
        return const MembershipEditorPage();
      default:
        return const Text('Unknown page');
    }
  }
}