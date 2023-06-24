import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:animations/animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/background_painter.dart';
import 'package:myecl/login/ui/create_account_page.dart';
import 'package:myecl/login/ui/forget.dart';
import 'package:myecl/login/ui/recover_password.dart';
import 'package:myecl/login/ui/register.dart';
import 'package:myecl/login/ui/sign_in.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> showSignInPage = useValueNotifier(true);
    final ValueNotifier<bool> showRegisterPage = useValueNotifier(false);
    final ValueNotifier<bool> showActivationPage = useValueNotifier(false);
    final ValueNotifier<bool> showResetPage = useValueNotifier(false);
    AnimationController controller =
        useAnimationController(duration: const Duration(seconds: 2));
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: controller,
              ),
            ),
          ),
          SafeArea(
            child: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: ValueListenableBuilder<bool>(
                        valueListenable: showSignInPage,
                        builder: (context, value, child) {
                          return SizedBox.expand(
                              child: PageTransitionSwitcher(
                                  reverse: !value,
                                  duration: const Duration(milliseconds: 800),
                                  transitionBuilder:
                                      (child, animation, secondaryAnimation) {
                                    return SharedAxisTransition(
                                      animation: animation,
                                      secondaryAnimation: secondaryAnimation,
                                      transitionType:
                                          SharedAxisTransitionType.vertical,
                                      fillColor: Colors.transparent,
                                      child: child,
                                    );
                                  },
                                  child: value
                                      ? const SignIn(
                                          key: ValueKey(
                                              LoginTextConstants.signIn),
                                        )
                                      : showRegisterPage.value
                                          ? ValueListenableBuilder<bool>(
                                              valueListenable:
                                                  showActivationPage,
                                              builder: (context, value, child) {
                                                return SizedBox.expand(
                                                    child:
                                                        PageTransitionSwitcher(
                                                            reverse: !value,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        800),
                                                            transitionBuilder:
                                                                (child,
                                                                    animation,
                                                                    secondaryAnimation) {
                                                              return SharedAxisTransition(
                                                                animation:
                                                                    animation,
                                                                secondaryAnimation:
                                                                    secondaryAnimation,
                                                                transitionType:
                                                                    SharedAxisTransitionType
                                                                        .vertical,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                child: child,
                                                              );
                                                            },
                                                            child: value
                                                                ? const CreateAccountPage()
                                                                : const Register(
                                                                    key: ValueKey(
                                                                        LoginTextConstants
                                                                            .register),
                                                                  )));
                                              })
                                          : ValueListenableBuilder<bool>(
                                              valueListenable: showResetPage,
                                              builder: (context, value, child) {
                                                return SizedBox.expand(
                                                    child:
                                                        PageTransitionSwitcher(
                                                            reverse: !value,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        800),
                                                            transitionBuilder:
                                                                (child,
                                                                    animation,
                                                                    secondaryAnimation) {
                                                              return SharedAxisTransition(
                                                                animation:
                                                                    animation,
                                                                secondaryAnimation:
                                                                    secondaryAnimation,
                                                                transitionType:
                                                                    SharedAxisTransitionType
                                                                        .vertical,
                                                                fillColor: Colors
                                                                    .transparent,
                                                                child: child,
                                                              );
                                                            },
                                                            child: value
                                                                ? const RecoverPasswordPage()
                                                                : const ForgetPassword(
                                                                    key: ValueKey(
                                                                        LoginTextConstants
                                                                            .forgetPassword),
                                                                  )));
                                              },
                                            )));
                        }))),
          ),
        ],
      ),
    );
  }
}
