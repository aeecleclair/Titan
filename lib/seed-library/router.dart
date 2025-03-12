import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/seed-library/ui/pages/loan-detail_page/loan_detail_page.dart';
import 'package:myecl/seed-library/ui/pages/main_page/main_page.dart';
import 'package:myecl/seed-library/ui/pages/stock_page/stock_page.dart';
import 'package:myecl/seed-library/ui/pages/add_seed_deposit_page/add_seed_deposit_page.dart';
import 'package:myecl/seed-library/ui/seed_deposit_page/seed_deposit_page.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SeedLibraryRouter {
  final Ref ref;
  static const String root = '/seed_library';
  static const String admin = '/admin';
  static const String plants = '/plants';
  static const String userEditPlant = '/edit_plant';
  static const String plantDetail = '/plant_detail';
  static const String addEditPlant = '/add_edit_plant';
  static const String species = '/species';
  static const String addEditSpecies = '/add_edit_species';
  static const String stock = '/stock';
  static const String loanDetail = '/loan_detail';
  static const String addStock = '/add_stock';
  static const String seedDeposit = '/seed_deposit';
  static const String addSeedDeposit = '/add_seed_deposit';
  SeedLibraryRouter(this.ref);
  static final Module module = Module(
    name: "Grainothèque",
    icon: const Left(HeroIcons.inboxStack),
    root: SeedLibraryRouter.root,
    selected: false,
  );

  QRoute route() => QRoute(
        name: "SeedLibrary",
        path: SeedLibraryRouter.root,
        builder: () => SeedLibraryMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
        ],
        children: [
          QRoute(
            path: admin,
            builder: () => AdminPage(),
            middleware: [
              AdminMiddleware(ref, isAdminProvider),
            ],
            children: [
              QRoute(
                path: plants,
                builder: () => AdminPlantPage(),
                children: [
                  QRoute(
                    path: addEditPlant,
                    builder: () => AddEditPlantPage(),
                  ),
                ],
              ),
              QRoute(
                path: stock,
                builder: () => AdminStockPage(),
                children: [
                  QRoute(
                    path: addStock,
                    builder: () => AddStockPage(),
                  ),
                ],
              ),
              QRoute(
                path: species,
                builder: () => AdminSpeciesPage(),
                children: [
                  QRoute(
                    path: addEditSpecies,
                    builder: () => AddEditSpeciesPage(),
                  ),
                ],
              ),
            ],
          ),
          QRoute(
            path: plants,
            builder: () => PlantsPage(),
            middleware: [],
            children: [
              QRoute(
                path: plantDetail,
                builder: () => PlantDetailPage(),
                children: [
                  QRoute(
                    path: userEditPlant,
                    builder: () => UserEditPlantPage(),
                  ),
                ],
              ),
            ],
          ),
          QRoute(
            path: stock,
            builder: () => StockPage(),
            children: [
              QRoute(
                path: loanDetail,
                builder: () => LoanDetailPage(),
              ),
            ],
          ),
          QRoute(
            path: seedDeposit,
            builder: () => SeedDepositPage(),
            children: [
              QRoute(
                path: addSeedDeposit,
                builder: () => AddSeedDepositPage(),
              ),
            ],
          ),
        ],
      );
}
