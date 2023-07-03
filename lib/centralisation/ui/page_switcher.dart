import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/centralisation/providers/centralisation_page_provider.dart';
import 'package:myecl/centralisation/ui/pages/Main.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(centralisationPageProvider);
    switch (page) {
      case CentralisationPage.main:
        return LinksScreen();
    }
  }
}
