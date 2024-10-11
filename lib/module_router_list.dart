import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/calendar/router.dart';
import 'package:myecl/centralisation/router.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/purchases/router.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/recommendation/router.dart';
import 'package:myecl/tools/class/module_router.dart';
import 'package:myecl/vote/router.dart';

class ModulesRouterList {
  final ProviderRef ref;
  static late List<ModuleRouter> routers;

  ModulesRouterList(this.ref) {
    routers = [
      CalendarRouter(ref),
      CentralisationRouter(ref),
      PhRouter(ref),
      CinemaRouter(ref),
      AmapRouter(ref),
      BookingRouter(ref),
      LoanRouter(ref),
      PhonebookRouter(ref),
      PurchasesRouter(ref),
      RecommendationRouter(ref),
      AdvertRouter(ref),
      EventRouter(ref),
      VoteRouter(ref),
      RaffleRouter(ref),
    ];
  }
}
