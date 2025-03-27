import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/seed-library/providers/is_seed_library_admin_provider.dart';
import 'package:myecl/seed-library/ui/pages/add_edit_species_page/add_edit_species_page.dart';
import 'package:myecl/seed-library/ui/pages/edit_plant_detail_page/edit_plant_detail_page.dart';
import 'package:myecl/seed-library/ui/pages/edit_presentation_page/edit_information_page.dart';
import 'package:myecl/seed-library/ui/pages/information_page/text.dart';
import 'package:myecl/seed-library/ui/pages/main_page/main_page.dart';
import 'package:myecl/seed-library/ui/pages/plant_detail_page/plant_detail_page.dart';
import 'package:myecl/seed-library/ui/pages/plants_page/plants_page.dart';
import 'package:myecl/seed-library/ui/pages/plant_deposit_page/plant_deposit_page.dart';
import 'package:myecl/seed-library/ui/pages/species_page/species_page.dart';
import 'package:myecl/seed-library/ui/pages/stock_page/stocks_page.dart';
import 'package:myecl/tools/middlewares/admin_middleware.dart';
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
        builder: () => SeedLibraryMainPage(),
        middleware: [
          AuthenticatedMiddleware(ref),
        ],
        children: [
          QRoute(
              path: SeedLibraryRouter.information,
              builder: () => InformationPage(),
              children: [
                QRoute(
                    path: SeedLibraryRouter.editInformation,
                    builder: () => EditInformationPage(),
                    middleware: [
                      AdminMiddleware(ref, isSeedLibraryAdminProvider),
                    ]),
              ]),
          QRoute(
            path: species,
            builder: () => SpeciesPage(),
            children: [
              QRoute(
                path: addEditSpecies,
                builder: () => AddEditSpeciesPage(),
              ),
            ],
            middleware: [
              AdminMiddleware(ref, isSeedLibraryAdminProvider),
            ],
          ),
          QRoute(
            path: plants,
            builder: () => PlantsPage(),
            middleware: [],
            children: [
              QRoute(
                path: plantDetail,
                builder: () => EditPlantDetailPage(),
              ),
            ],
          ),
          QRoute(
            path: stock,
            builder: () => StockPage(),
            children: [
              QRoute(
                path: plantDetail,
                builder: () => PlantDetailPage(),
              ),
            ],
          ),
          QRoute(
            path: seedDeposit,
            builder: () => PlantDepositPage(),
          ),
        ],
      );
}
