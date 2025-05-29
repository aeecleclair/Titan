import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/login/ui/app_sign_in.dart' deferred as app_sign_in;
import 'package:myecl/login/ui/pages/create_account_page/create_account_page.dart'
    deferred as create_account_page;
import 'package:myecl/login/ui/pages/forget_page/forget_page.dart'
    deferred as forget_page;
import 'package:myecl/login/ui/pages/recover_password/recover_password_page.dart'
    deferred as recover_password_page;
import 'package:myecl/login/ui/pages/register_page/register_page.dart'
    deferred as register_page;
import 'package:myecl/login/ui/web/web_sign_in.dart' deferred as web_sign_in;
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:myecl/tools/middlewares/deferred_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoginRouter {
  final Ref ref;
  static const String root = '/login';
  static const String createAccount = '/create_account';
  static const String forgotPassword = '/forgot_password';
  static const String mailReceived = '/mail_received';
  LoginRouter(this.ref);

  QRoute accountRoute() => QRoute(
    path: createAccount,
    builder: () => register_page.Register(),
    pageType: const QMaterialPage(),
    middleware: [DeferredLoadingMiddleware(register_page.loadLibrary)],
    children: [
      QRoute(
        path: mailReceived,
        pageType: const QMaterialPage(),
        builder: () => create_account_page.CreateAccountPage(),
        middleware: [
          DeferredLoadingMiddleware(create_account_page.loadLibrary),
        ],
      ),
    ],
  );

  QRoute passwordRoute() => QRoute(
    path: forgotPassword,
    builder: () => forget_page.ForgetPassword(),
    pageType: const QMaterialPage(),
    middleware: [DeferredLoadingMiddleware(forget_page.loadLibrary)],
    children: [
      QRoute(
        path: mailReceived,
        pageType: const QMaterialPage(),
        builder: () => recover_password_page.RecoverPasswordPage(),
        middleware: [
          DeferredLoadingMiddleware(recover_password_page.loadLibrary),
        ],
      ),
    ],
  );

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
