import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/login/providers/animation_provider.dart';
import 'package:titan/login/tools/constants.dart';
import 'package:titan/login/ui/auth_page.dart';
import 'package:titan/login/ui/components/sign_in_up_bar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AppSignIn extends HookConsumerWidget {
  const AppSignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    final pathForwarding = ref.read(pathForwardingProvider);
    final controller = ref.watch(backgroundAnimationProvider);

    return LoginTemplate(
      callback: (AnimationController controller) {
        if (controller.isCompleted) {
          controller.reverse();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "MyECL",
                  style: GoogleFonts.elMessiri(
                    textStyle: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image(image: AssetImage(getTitanLogo())),
                        ),
                        SignInUpBar(
                          isLoading: ref
                              .watch(loadingProvider)
                              .maybeWhen(
                                data: (data) => data,
                                orElse: () => false,
                              ),
                          label: LoginTextConstants.signIn,
                          onPressed: () async {
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
                          color: ColorConstants.background2,
                          icon: const HeroIcon(
                            HeroIcons.arrowRight,
                            color: ColorConstants.background2,
                            size: 35.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
