import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/calendar/router.dart';
import 'package:myecl/centralisation/router.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/purchases/router.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/recommendation/router.dart';
import 'package:myecl/tools/class/module_router.dart';
import 'package:myecl/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ModuleRouterList {
  final ProviderRef ref;
  late List<ModuleRouter> moduleRouterList;
  ModuleRouterList(this.ref) {
    moduleRouterList = [
      AdvertRouter(ref),
      AmapRouter(ref),
      BookingRouter(ref),
      CalendarRouter(ref),
      CentralisationRouter(ref),
      CinemaRouter(ref),
      EventRouter(ref),
      LoanRouter(ref),
      PhRouter(ref),
      PhonebookRouter(ref),
      PurchasesRouter(ref),
      RaffleRouter(ref),
      RecommendationRouter(ref),
      VoteRouter(ref),
    ];
  }

  List<QRoute> getRoutes() {
    return moduleRouterList.map((e) => e.route()).toList();
  }
}

class ModuleList {
  late List<Module> moduleList;
  ModuleList() {
    moduleList = [
      AdvertRouter.module,
      AmapRouter.module,
      BookingRouter.module,
      CalendarRouter.module,
      CentralisationRouter.module,
      CinemaRouter.module,
      EventRouter.module,
      LoanRouter.module,
      PhRouter.module,
      PhonebookRouter.module,
      PurchasesRouter.module,
      RaffleRouter.module,
      RecommendationRouter.module,
      VoteRouter.module,
    ];
  }
}
