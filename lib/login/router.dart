import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/login/ui/app_sign_in.dart' deferred as app_sign_in;
import 'package:titan/login/ui/web/web_sign_in.dart' deferred as web_sign_in;
import 'package:titan/tools/middlewares/authenticated_middleware.dart';
import 'package:titan/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoginRouter {
  final Ref ref;
  static const String root = '/login';
  static const String createAccount = '/create_account';
  static const String forgotPassword = '/forgot_password';
  static const String mailReceived = '/mail_received';
  LoginRouter(this.ref);

  QRoute route() => QRoute(
    path: LoginRouter.root,
    builder: () => (kIsWeb && ref.watch(isWebFormatProvider))
        ? web_sign_in.WebSignIn()
        : app_sign_in.AppSignIn(),
    pageType: const QMaterialPage(),
    middleware: [
      AuthenticatedMiddleware(ref),
      DeferredLoadingMiddleware(
        (kIsWeb && ref.watch(isWebFormatProvider))
            ? web_sign_in.loadLibrary
            : app_sign_in.loadLibrary,
      ),
    ],
  );
}
