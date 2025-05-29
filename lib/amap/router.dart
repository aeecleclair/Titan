import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/providers/is_amap_admin_provider.dart';
import 'package:myecl/amap/ui/pages/admin_page/admin_page.dart'
    deferred as admin_page;
import 'package:myecl/amap/ui/pages/delivery_pages/add_edit_delivery_cmd_page.dart'
    deferred as add_edit_delivery_cmd_page;
import 'package:myecl/amap/ui/pages/detail_delivery_page/detail_page.dart'
    deferred as detail_delivery_page;
import 'package:myecl/amap/ui/pages/detail_page/detail_page.dart'
    deferred as detail_page;
import 'package:myecl/amap/ui/pages/list_products_page/list_products_page.dart'
    deferred as list_products_page;
import 'package:myecl/amap/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:myecl/amap/ui/pages/presentation_page/text.dart'
    deferred as presentation_page;
import 'package:myecl/amap/ui/pages/product_pages/add_edit_product.dart'
    deferred as add_edit_product;
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AmapRouter {
  final Ref ref;
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
    name: "amap",
    path: AmapRouter.root,
    builder: () => main_page.AmapMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: admin,
        builder: () => admin_page.AdminPage(),
        middleware: [
          AdminMiddleware(ref, isAmapAdminProvider),
          DeferredLoadingMiddleware(admin_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: addEditDelivery,
            builder: () => add_edit_delivery_cmd_page.AddEditDeliveryPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_delivery_cmd_page.loadLibrary),
            ],
          ),
          QRoute(
            path: addEditProduct,
            builder: () => add_edit_product.AddEditProduct(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_product.loadLibrary),
            ],
          ),
          QRoute(
            path: detailDelivery,
            builder: () => detail_delivery_page.DetailDeliveryPage(),
            middleware: [
              DeferredLoadingMiddleware(detail_delivery_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: listProduct,
        builder: () => list_products_page.ListProductPage(),
        middleware: [DeferredLoadingMiddleware(list_products_page.loadLibrary)],
      ),
      QRoute(
        path: detailOrder,
        builder: () => detail_page.DetailPage(),
        middleware: [DeferredLoadingMiddleware(detail_page.loadLibrary)],
      ),
      QRoute(
        path: presentation,
        builder: () => presentation_page.PresentationPage(),
        middleware: [DeferredLoadingMiddleware(presentation_page.loadLibrary)],
      ),
    ],
  );
}
