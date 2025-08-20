import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/login/ui/auth_page.dart';
import 'package:titan/login/ui/components/sign_in_up_bar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSignIn extends HookConsumerWidget {
  const AppSignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    final pathForwarding = ref.read(pathForwardingProvider);

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
                          label: AppLocalizations.of(context)!.loginSignIn,
                          onPressed: () async {
                            await authNotifier.getTokenFromRequest();
                            ref
                                .watch(authTokenProvider)
                                .when(
                                  data: (token) {
                                    QR.to(pathForwarding.path);
                                  },
                                  error: (e, s) {
                                    displayToast(
                                      context,
                                      TypeMsg.error,
                                      AppLocalizations.of(
                                        context,
                                      )!.loginLoginFailed,
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
                          onTap: () async {
                            await launchUrl(
                              Uri.parse("${getTitanHost()}calypsso/register"),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.loginCreateAccount,
                            style: const TextStyle(
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
                          onTap: () async {
                            await launchUrl(
                              Uri.parse("${getTitanHost()}calypsso/recover"),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.loginForgotPassword,
                            style: const TextStyle(
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
