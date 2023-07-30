import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/login/ui/create_account_page.dart';
import 'package:myecl/login/ui/forget.dart';
import 'package:myecl/login/ui/recover_password.dart';
import 'package:myecl/login/ui/register.dart';
import 'package:myecl/login/ui/sign_in.dart';
import 'package:myecl/tools/middlewares/authenticated_middleware.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoginRouter {
  final ProviderRef ref;
  static const String root = '/login';
  static const String createAccount = '/create_account';
  static const String forgotPassword = '/forgot_password';
  static const String mailReceived = '/mail_received';
  LoginRouter(this.ref);

  QRoute accountRoute() => QRoute(
          path: createAccount,
          builder: () => const Register(),
          pageType: const QMaterialPage(),
          children: [
            QRoute(
              path: mailReceived,
              pageType: const QMaterialPage(),
              builder: () => const CreateAccountPage(),
            ),
          ]);

  QRoute passwordRoute() => QRoute(
          path: forgotPassword,
          builder: () => const ForgetPassword(),
          pageType: const QMaterialPage(),
          children: [
            QRoute(
              path: mailReceived,
              pageType: const QMaterialPage(),
              builder: () => const RecoverPasswordPage(),
            ),
          ]);

  QRoute route() => QRoute(
        path: LoginRouter.root,
        builder: () => const SignIn(),
        pageType: const QMaterialPage(),
        middleware: [AuthenticatedMiddleware(ref)],
      );
}
