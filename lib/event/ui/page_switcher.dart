import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/event/ui/pages/event_pages/add_edit_event_page.dart';
import 'package:myecl/event/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/event/ui/pages/main_page/main_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(eventPageProvider);
    switch (page) {
      case EventPage.main:
        return const MainPage();
      case EventPage.addEditEventFromAdmin:
        return const AddEditEventPage();
      case EventPage.addEditEventFromMain:
        return const AddEditEventPage();
      case EventPage.eventDetailfromModuleFromMain:
        return const DetailPage(
          isAdmin: false,
        );
      case EventPage.eventDetailfromModuleFromAdmin:
        return const DetailPage(
          isAdmin: true,
        );
      case EventPage.eventDetailfromCalendar:
        return const DetailPage(
          isAdmin: false,
        );
      case EventPage.admin:
        return const AdminPage();
    }
  }
}
