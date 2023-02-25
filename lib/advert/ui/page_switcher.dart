import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/ui/pages/add_edit_advert_page.dart';
import 'package:myecl/advert/ui/pages/admin_page.dart';
import 'package:myecl/advert/ui/pages/detail_dart.dart';
import 'package:myecl/advert/ui/pages/main_page/main_page.dart';


class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(advertPageProvider);
    switch (page) {
      case AdvertPage.main:
        return const MainPage();
      case AdvertPage.admin:
        return const AdminPage();
      case AdvertPage.detailFromMainPage:
        return const DetailPage();
      case AdvertPage.detailFromAdminPage:
        return const DetailPage();
      case AdvertPage.addEditAdvert:
        return const AddEditAdvertPage();
      default:
        return const Text('Unknown page');
    }
  }
}
