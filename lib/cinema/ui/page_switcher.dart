import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/cinema/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';
import 'package:myecl/cinema/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/cinema/ui/pages/main_page/main_page.dart';
import 'package:myecl/cinema/ui/pages/session_pages/add_session.dart';
import 'package:myecl/cinema/ui/pages/session_pages/edit_session.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(cinemaPageProvider);
    switch (page) {
      case CinemaPage.main:
        return const MainPage();
      case CinemaPage.admin:
        return const AdminPage();
      case CinemaPage.detailFromMainPage:
        return const DetailPage();
      case CinemaPage.detailFromAdminPage:
        return const DetailPage();
      case CinemaPage.addSession:
        return const AddSessionPage();
      case CinemaPage.editSession:
        return const EditSessionPage();
    }
  }
}
