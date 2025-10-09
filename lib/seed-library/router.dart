import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:titan/seed-library/ui/pages/add_edit_species_page/add_edit_species_page.dart'
    deferred as add_edit_species_page;
import 'package:titan/seed-library/ui/pages/edit_plant_detail_page/edit_plant_detail_page.dart'
    deferred as edit_plant_detail_page;
import 'package:titan/seed-library/ui/pages/edit_presentation_page/edit_information_page.dart'
    deferred as edit_information_page;
import 'package:titan/seed-library/ui/pages/information_page/text.dart'
    deferred as information_page;
import 'package:titan/seed-library/ui/pages/main_page/main_page.dart'
    deferred as main_page;
import 'package:titan/seed-library/ui/pages/plant_detail_page/plant_detail_page.dart'
    deferred as plant_detail_page;
import 'package:titan/seed-library/ui/pages/plants_page/plants_page.dart'
    deferred as plants_page;
import 'package:titan/seed-library/ui/pages/plant_deposit_page/plant_deposit_page.dart'
    deferred as plant_deposit_page;
import 'package:titan/seed-library/ui/pages/species_page/species_page.dart'
    deferred as species_page;
import 'package:titan/seed-library/ui/pages/stock_page/stocks_page.dart'
    deferred as stocks_page;
import 'package:titan/tools/middlewares/admin_middleware.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
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
  static const String information = '/information';
  static const String editInformation = '/edit_information';

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
    builder: () => main_page.SeedLibraryMainPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(main_page.loadLibrary),
    ],
    children: [
      QRoute(
        path: SeedLibraryRouter.information,
        builder: () => information_page.InformationPage(),
        middleware: [DeferredLoadingMiddleware(information_page.loadLibrary)],
        children: [
          QRoute(
            path: SeedLibraryRouter.editInformation,
            builder: () => edit_information_page.EditInformationPage(),
            middleware: [
              AdminMiddleware(ref, isSeedLibraryAdminProvider),
              DeferredLoadingMiddleware(edit_information_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: species,
        builder: () => species_page.SpeciesPage(),
        middleware: [
          AdminMiddleware(ref, isSeedLibraryAdminProvider),
          DeferredLoadingMiddleware(species_page.loadLibrary),
        ],
        children: [
          QRoute(
            path: addEditSpecies,
            builder: () => add_edit_species_page.AddEditSpeciesPage(),
            middleware: [
              DeferredLoadingMiddleware(add_edit_species_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: plants,
        builder: () => plants_page.PlantsPage(),
        middleware: [DeferredLoadingMiddleware(plants_page.loadLibrary)],
        children: [
          QRoute(
            path: plantDetail,
            builder: () => edit_plant_detail_page.EditPlantDetailPage(),
            middleware: [
              DeferredLoadingMiddleware(edit_plant_detail_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: stock,
        builder: () => stocks_page.StockPage(),
        middleware: [DeferredLoadingMiddleware(stocks_page.loadLibrary)],
        children: [
          QRoute(
            path: plantDetail,
            builder: () => plant_detail_page.PlantDetailPage(),
            middleware: [
              DeferredLoadingMiddleware(plant_detail_page.loadLibrary),
            ],
          ),
        ],
      ),
      QRoute(
        path: seedDeposit,
        builder: () => plant_deposit_page.PlantDepositPage(),
        middleware: [DeferredLoadingMiddleware(plant_deposit_page.loadLibrary)],
      ),
    ],
  );
}
