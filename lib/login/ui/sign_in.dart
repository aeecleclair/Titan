import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/main_page.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    final pathForwarding = ref.read(pathForwardingProvider);
    return LoginTemplate(
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
                  child: Text("MyECL",
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
                            SignInBar(
                              isLoading: ref.watch(loadingrovider).when(
                                  data: (data) => data,
                                  error: (e, s) => false,
                                  loading: () => false),
                              label: LoginTextConstants.signIn,
                              onPressed: () async {
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
                                  QR.to(LoginRouter.createAccount);
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
                                  QR.to(LoginRouter.forgotPassword);
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
      )),
    );
  }
}
