import 'package:flutter/widgets.dart';
import 'package:titan/tools/plausible/plausible.dart';

class PlausibleObserver extends NavigatorObserver {
  final Plausible plausible;

  PlausibleObserver(this.plausible);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      plausible.event(route.settings.name!);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute?.settings.name != null) {
      plausible.event(previousRoute!.settings.name!);
    }
  }
}
