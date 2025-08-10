import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/tools/ui/styleguide/styleguide_page.dart';
import 'package:qlevar_router/qlevar_router.dart';

class StyleGuideRouter {
  final Ref ref;
  static const String root = '/styleguide';
  static final Module module = Module(
    getName: (context) => AppLocalizations.of(context)!.moduleStyleGuide,
    getDescription: (context) =>
        AppLocalizations.of(context)!.moduleStyleGuideDescription,
    root: StyleGuideRouter.root,
  );
  StyleGuideRouter(this.ref);
  QRoute route() => QRoute(
    name: "styleguide",
    path: StyleGuideRouter.root,
    builder: () => const StyleGuidePage(),
  );
}
