import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:animations/animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/background_painter.dart';
import 'package:myecl/login/ui/register.dart';
import 'package:myecl/login/ui/sign_in.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> _showSignInPage = useValueNotifier(true);
    AnimationController _controller =
        useAnimationController(duration: const Duration(seconds: 2));
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller,
              ),
            ),
          ),
          Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _showSignInPage,
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
                                  ? SignIn(
                                      key: const ValueKey(LoginTextConstants.signIn),
                                      onRegisterPressed: () {
                                        _showSignInPage.value = false;
                                        _controller.forward();
                                      },
                                    )
                                  : Register(
                                      key: const ValueKey(LoginTextConstants.register),
                                      onSignInPressed: () {
                                        _showSignInPage.value = true;
                                        _controller.reverse();
                                      },
                                    )));
                    },
                  )))
        ],
      ),
    );
  }
}
