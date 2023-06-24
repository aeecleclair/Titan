import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/login/ui/background_painter.dart';
import 'package:myecl/login/ui/create_account_page.dart';
import 'package:myecl/login/ui/forget.dart';
import 'package:myecl/login/ui/recover_password.dart';
import 'package:myecl/login/ui/register.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoginRouter {
  final ProviderRef ref;
  static const String root = '/login';
  static const String createAccount = '/create_account';
  static const String forgotPassword = '/forgot_password';
  static const String mailReceived = '/mail_received';
  late List<QRoute> routes = [];
  LoginRouter(this.ref) {
    routes = [
      QRoute(
          path: createAccount,
          builder: () => const Register(),
          pageType: QCustomPage(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return Scaffold(
                body: Stack(
                  children: [
                    SizedBox.expand(
                      child: CustomPaint(
                        painter: BackgroundPainter(
                          animation: animation,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Center(child: child),
                    ),
                  ],
                ),
              );
            },
          ),
          children: [
            QRoute(
                path: mailReceived, builder: () => const CreateAccountPage()),
          ]),
      QRoute(
          path: forgotPassword,
          builder: () => const ForgetPassword(),
          pageType: QCustomPage(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return Scaffold(
                body: Stack(
                  children: [
                    SizedBox.expand(
                      child: CustomPaint(
                        painter: BackgroundPainter(
                          animation: animation,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Center(child: child),
                    ),
                  ],
                ),
              );
            },
          ),
          children: [
            QRoute(
                path: mailReceived, builder: () => const RecoverPasswordPage()),
          ]),
    ];
  }
}
