// ignore_for_file: constant_identifier_names

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/ph/ui/pages/last_ph.dart';
import 'package:myecl/ph/ui/pages/main_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhRouter {
  final ProviderRef ref;
  static const String root = '/ph';
  static const String last_ph = '/last_ph';
  static final Module module = Module(
      name: "Ph",
      icon: const Left(HeroIcons.gift),
      root: PhRouter.root,
      selected: false);
  PhRouter(this.ref);
  QRoute route() =>
      QRoute(path: PhRouter.root, builder: () => const PhMainPage(), children: [
        QRoute(
          path: last_ph,
          builder: () => const LastPhPage(),
        ),
      ]);
}
