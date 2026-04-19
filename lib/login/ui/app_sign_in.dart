import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/login/ui/auth_page.dart';
import 'package:titan/login/ui/components/sign_in_up_bar.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:titan/super_admin/providers/permissions_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSignIn extends HookConsumerWidget {
  const AppSignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    final pathForwarding = ref.read(pathForwardingProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final pathForwardingNotifier = ref.watch(pathForwardingProvider.notifier);
    final versionVerifier = ref.watch(versionVerifierProvider);
    final asyncUser = ref.watch(asyncUserProvider);
    final permissions = ref.watch(permissionsProvider);
    final modules = ref.watch(modulesProvider);

    // Check if we're waiting for user/permissions/modules after login
    final isUserLoaded = !asyncUser.isLoading && asyncUser.hasValue;
    final isPermissionsLoaded = !permissions.isLoading && permissions.hasValue;
    final isModulesLoaded = modules.isNotEmpty;
    final isWaitingForData =
        isLoggedIn &&
        (!isUserLoaded || !isPermissionsLoaded || !isModulesLoaded);

    useEffect(
      () {
        if (isLoggedIn &&
            !versionVerifier.isLoading &&
            isUserLoaded &&
            isPermissionsLoaded &&
            isModulesLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final currentPath = ref.read(pathForwardingProvider);
            final targetPath =
                currentPath.path == "/" || currentPath.path == "/login"
                ? FeedRouter.root
                : currentPath.path;
            if (!currentPath.isLoggedIn) {
              pathForwardingNotifier.login();
            }
            QR.to(targetPath);
          });
        }
        return null;
      },
      [isLoggedIn, versionVerifier.isLoading, asyncUser, permissions, modules],
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
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        getAppName(),
                        maxLines: 1,
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
                  const Spacer(flex: 3),
                ],
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
                                data: (data) => data || isWaitingForData,
                                orElse: () => isWaitingForData,
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
                          color: ColorConstants.tertiary,
                          icon: const HeroIcon(
                            HeroIcons.arrowRight,
                            color: ColorConstants.tertiary,
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
