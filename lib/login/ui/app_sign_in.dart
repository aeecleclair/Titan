import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/providers/animation_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/auth_page.dart';
import 'package:myecl/login/ui/components/sign_in_up_bar.dart';
import 'package:myecl/router.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/routing/providers/auth_redirect_service_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AppSignIn extends HookConsumerWidget {
  const AppSignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authTokenProvider.notifier);
    final controller = ref.watch(backgroundAnimationProvider);

    final forwardedFrom =
        QR.params[forwardedFromKey]?.toString() ?? AppRouter.root;
    final redirectPath = ref.watch(
      authRedirectServiceProvider.select(
        (service) => service.getRedirect(forwardedFrom),
      ),
    );

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
                          isLoading: ref.watch(isAuthLoadingProvider),

                          label: LoginTextConstants.signIn,
                          onPressed: () async {
                            await authNotifier.signIn();
                            ref
                                .watch(authTokenProvider)
                                .when(
                                  data: (token) {
                                    QR.to(redirectPath ?? AppRouter.root);
                                  },
                                  error: (e, s) {
                                    displayToast(
                                      context,
                                      TypeMsg.error,
                                      LoginTextConstants.loginFailed,
                                    );
                                  },
                                  loading: () {},
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          splashColor: const Color.fromRGBO(255, 255, 255, 1),
                          onTap: () {
                            QR.to(LoginRouter.createAccount);
                            controller?.forward();
                          },
                          child: const Text(
                            LoginTextConstants.createAccount,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          splashColor: const Color.fromRGBO(255, 255, 255, 1),
                          onTap: () {
                            QR.to(LoginRouter.forgotPassword);
                            controller?.forward();
                          },
                          child: const Text(
                            LoginTextConstants.forgotPassword,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
