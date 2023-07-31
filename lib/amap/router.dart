import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';
import 'package:myecl/amap/ui/pages/admin_page/admin_page.dart';
import 'package:myecl/amap/ui/pages/delivery_pages/add_edit_delivery_cmd_page.dart';
import 'package:myecl/amap/ui/pages/detail_delivery_page/detail_page.dart';
import 'package:myecl/amap/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/amap/ui/pages/list_products_page/list_products_page.dart';
import 'package:myecl/amap/ui/pages/main_page/main_page.dart';
import 'package:myecl/amap/ui/pages/presentation_page/text.dart';
import 'package:myecl/amap/ui/pages/product_pages/add_edit_product.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AmapRouter {
  final ProviderRef ref;
  static const String root = '/amap';
  static const String admin = '/admin';
  static const String addEditDelivery = '/add_edit_delivery';
  static const String detailDelivery = '/detail_delivery';
  static const String detailOrder = '/detail_order';
  static const String listProduct = '/list_product';
  static const String presentation = '/presentation';
  static const String addEditProduct = '/add_edit_product';
  static final Module module = Module(
    name: "Amap",
    icon: const Left(HeroIcons.shoppingCart),
    root: AmapRouter.root,
    selected: false,
  );
  AmapRouter(this.ref);

  QRoute route() => QRoute(
        path: AmapRouter.root,
        builder: () => const AmapMainPage(),
        middleware: [AuthenticatedMiddleware(ref)],
        children: [
          QRoute(path: admin, builder: () => const AdminPage(), middleware: [
            AdminMiddleware(ref, isAmapAdminProvider),
          ], children: [
            QRoute(
                path: addEditDelivery,
                builder: () => const AddEditDeliveryPage()),
            QRoute(path: addEditProduct, builder: () => const AddEditProduct()),
            QRoute(
                path: detailDelivery,
                builder: () => const DetailDeliveryPage()),
          ]),
          QRoute(path: listProduct, builder: () => const ListProductPage()),
          QRoute(path: detailOrder, builder: () => const DetailPage()),
          QRoute(path: presentation, builder: () => const PresentationPage()),
        ],
      );
}
