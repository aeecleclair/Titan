import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/providers/animation_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LeftPanel extends HookConsumerWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    final pathForwarding = ref.read(pathForwardingProvider);
    final controller = ref.watch(backgroundAnimationProvider);
    final isLoading = ref
        .watch(loadingProvider)
        .maybeWhen(data: (data) => data, orElse: () => false);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 100,
          ),
          Flexible(
              child: SvgPicture.asset('assets/images/login.svg', width: 350)),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: WaitingButton(
              onTap: () async {
                await authNotifier.getTokenFromRequest();
                ref.watch(authTokenProvider).when(
                    data: (token) {
                      QR.to(pathForwarding.path);
                    },
                    error: (e, s) {
                      displayToast(context, TypeMsg.error,
                          LoginTextConstants.loginFailed);
                    },
                    loading: () {});
              },
              builder: (child) => Container(
                  width: 400,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF8A14),
                        Color.fromARGB(255, 255, 114, 0)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 114, 0)
                            .withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: child),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(LoginTextConstants.signIn,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const HeroIcon(
                            HeroIcons.arrowRight,
                            color: Colors.white,
                            size: 35.0,
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  QR.to(LoginRouter.createAccount);
                  controller?.forward();
                },
                child: const Text(LoginTextConstants.createAccount,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 48, 48, 48))),
              ),
              GestureDetector(
                onTap: () {
                  QR.to(LoginRouter.forgotPassword);
                  controller?.forward();
                },
                child: const Text(LoginTextConstants.forgotPassword,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 48, 48, 48))),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
