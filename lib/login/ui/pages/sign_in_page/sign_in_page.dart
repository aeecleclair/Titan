import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/auth_page.dart';
import 'package:myecl/login/ui/components/sign_in_up_bar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({super.key});

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
      child: AutofillGroup(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(LoginTextConstants.appName,
                        style: GoogleFonts.elMessiri(
                            textStyle: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
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
                              const Expanded(
                                child: Image(
                                  image: AssetImage('assets/images/logo.png'),
                                ),
                              ),
                              SignInUpBar(
                                isLoading: ref.watch(loadingProvider).maybeWhen(
                                    data: (data) => data, orElse: () => false),
                                label: LoginTextConstants.signIn,
                                onPressed: () async {
                                  await authNotifier.getTokenFromRequest();
                                  ref.watch(authTokenProvider).when(
                                      data: (token) {
                                        QR.to<void>(pathForwarding.path);
                                      },
                                      error: (e, s) {
                                        displayToast(context, TypeMsg.error,
                                            LoginTextConstants.loginFailed);
                                      },
                                      loading: () {});
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
                        const Spacer(
                          flex: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  splashColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  onTap: () {
                                    QR.to<void>(LoginRouter.createAccount);
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
                                )),
                            Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  splashColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  onTap: () {
                                    QR.to<void>(LoginRouter.forgotPassword);
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
                                )),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
