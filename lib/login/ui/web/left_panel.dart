import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class LeftPanel extends HookConsumerWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    final pathForwarding = ref.read(pathForwardingProvider);
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
                      Text(
                        getAppName(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "-",
                        style: TextStyle(
                          fontSize: 25,
                          color: ColorConstants.onTertiary,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        "L'application de l'associatif centralien",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.onTertiary,
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
              Expanded(flex: 5, child: Image.asset('assets/images/login.webp')),
              const SizedBox(height: 70),
              WaitingButton(
                onTap: () async {
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
                            AppLocalizations.of(context)!.loginLoginFailed,
                          );
                        },
                        loading: () {},
                      );
                },
                builder: (child) => Container(
                  width: 400,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [ColorConstants.main, ColorConstants.onMain],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.onMain.withValues(alpha: 0.2),
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
                    Text(
                      AppLocalizations.of(context)!.loginSignIn,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.background,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(
                                color: ColorConstants.background,
                              ),
                            )
                          : const HeroIcon(
                              HeroIcons.arrowRight,
                              color: ColorConstants.background,
                              size: 35.0,
                            ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(
                          Uri.parse("${getTitanHost()}calypsso/register"),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.loginCreateAccount,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: ColorConstants.onTertiary,
                        ),
                      ),
                    ),
                    const Spacer(flex: 4),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(
                          Uri.parse("${getTitanHost()}calypsso/recover"),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.loginForgotPassword,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: ColorConstants.onTertiary,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
