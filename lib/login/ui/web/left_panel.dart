import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/login/providers/animation_provider.dart';
import 'package:titan/login/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
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

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(getTitanLogo(), width: 70, height: 70),
                      const SizedBox(width: 20),
                      const Text(
                        'MyECL',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "-",
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "L'application de l'associatif centralien",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                flex: 5,
                child: SvgPicture.asset(
                  'assets/images/login.svg',
                  width: 350,
                  height: double.infinity,
                ),
              ),
              const SizedBox(height: 70),
              WaitingButton(
                onTap: () async {
                  await authNotifier.getTokenFromRequest();
                  ref
                      .watch(authTokenProvider)
                      .when(
                        data: (token) {
                          controller?.reverse();
                          QR.to(pathForwarding.path);
                        },
                        error: (e, s) {
                          displayToast(
                            context,
                            TypeMsg.error,
                            LoginTextConstants.loginFailed,
                          );
                        },
                        loading: () {
                          controller?.forward();
                        },
                      );
                },
                builder: (child) => Container(
                  width: 400,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF8A14),
                        Color.fromARGB(255, 255, 114, 0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          255,
                          114,
                          0,
                        ).withValues(alpha: 0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: child,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      LoginTextConstants.signIn,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
              const Spacer(flex: 3),
              SizedBox(width: double.infinity),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
