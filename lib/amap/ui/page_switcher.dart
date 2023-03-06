import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/ui/pages/delivery_pages/add_edit_delivery_cmd_page.dart';
import 'package:myecl/amap/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/amap/ui/pages/detail_delivery_page/detail_page.dart';
import 'package:myecl/amap/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/amap/ui/pages/list_products_page/list_products_page.dart';
import 'package:myecl/amap/ui/pages/main_page/main_page.dart';
import 'package:myecl/amap/ui/pages/presentation_page/text.dart';
import 'package:myecl/amap/ui/pages/product_pages/add_edit_product.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(amapPageProvider);
    switch (page) {
      case AmapPage.main:
        return const MainPage();
      case AmapPage.pres:
        return const PresentationPage();
      case AmapPage.addProducts:
        return const ListProductPage();
      case AmapPage.admin:
        return const AdminPage();
      case AmapPage.addEditProduct:
        return const AddEditProduct();
      case AmapPage.addEditDelivery:
        return const AddEditDeliveryPage();
      case AmapPage.detailPage:
        return const DetailPage();
      case AmapPage.deliveryDetail:
        return const DetailDeliveryPage();
    }
  }
}
