import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'package:titan/chooser/ui/pages/finger_chooser_page.dart'
    deferred as finger_page;
import 'package:titan/drawer/class/module.dart';
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';

class ChooserRouter {
  final Ref ref;
  static const String root = '/chooser';
  static final Module module = Module(
    name: 'Finger Chooser',
    icon: const Left(HeroIcons.fingerPrint),
    root: ChooserRouter.root,
    selected: false,
  );
  ChooserRouter(this.ref);

  QRoute route() => QRoute(
    name: 'chooser',
    path: ChooserRouter.root,
    builder: () => finger_page.FingerChooserPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(finger_page.loadLibrary),
    ],
  );
}
