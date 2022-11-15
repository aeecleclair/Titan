import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class SignIn extends HookConsumerWidget {
  const SignIn(
      {Key? key,
      required this.onRegisterPressed,
      required this.onForgetPressed})
      : super(key: key);

  final VoidCallback onRegisterPressed, onForgetPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    return AutofillGroup(
        child: Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeroIcon(
                            HeroIcons.bolt,
                            color: ColorConstants.background2,
                            size: 150,
                          ),
                          SignInBar(
                            isLoading: ref.watch(loadingrovider),
                            label: LoginTextConstants.signIn,
                            onPressed: () async {
                              await authNotifier.getTokenFromRequest();
                              ref.watch(authTokenProvider).when(
                                  data: (token) {},
                                  error: (e, s) {
                                    displayToast(
                                        context, TypeMsg.error, e.toString());
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
                                onRegisterPressed();
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
                                onForgetPressed();
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
    ));
  }
}
