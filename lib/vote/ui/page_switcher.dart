import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/ui/pages/pretendance_pages/add_pretendance.dart';
import 'package:myecl/vote/ui/pages/pretendance_pages/edit_pretendance.dart';
import 'package:myecl/vote/ui/pages/section_pages/add_section.dart';
import 'package:myecl/vote/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/vote/ui/pages/main_page/main_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(votePageProvider);
    switch (page) {
      case VotePage.main:
        return const MainPage();
      case VotePage.admin:
        return const AdminPage();
      case VotePage.addSection:
        return const AddSectionPage();
      case VotePage.addPretendance:
        return const AddPretendancePage();
      case VotePage.editPretendance:
        return const EditPretendancePage();
    }
  }
}
