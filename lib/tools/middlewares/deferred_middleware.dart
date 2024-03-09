import 'package:qlevar_router/qlevar_router.dart';

class DeferredLoadingMiddleware extends QMiddleware {
  final Future<dynamic> Function() loader;

  DeferredLoadingMiddleware(this.loader);

  @override
  Future<void> onEnter() async {
    await loader();
  }
}
