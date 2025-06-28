import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/ui/styleguide/styleguide_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class StyleGuideRouter {
  final Ref ref;
  static const String root = '/styleguide';
  static final Module module = Module(
    name: "Style Guide",
    description: "Explore the UI components and styles used in Titan",
    root: StyleGuideRouter.root,
  );
  StyleGuideRouter(this.ref);
  QRoute route() => QRoute(
    name: "styleguide",
    path: StyleGuideRouter.root,
    builder: () => const StyleGuidePage(),
  );
}
