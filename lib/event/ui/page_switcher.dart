import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/providers/event_page_provider.dart';
import 'package:myecl/event/ui/pages/add_page/add_event_page.dart';
import 'package:myecl/event/ui/pages/main_page/main_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(eventPageProvider);
    switch (page) {
      case EventPage.main:
        return const MainPage();
      case EventPage.addEvent:
        return const AddEventPage();
    }
  }
}
