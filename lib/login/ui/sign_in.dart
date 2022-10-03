import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/tools/functions.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/login/ui/text_from_decoration.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
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
    final username = useTextEditingController();
    final password = useTextEditingController();
    final hidePass = useState(true);
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 16),
                    //   child: TextFormField(
                    //     decoration: signInRegisterInputDecoration(
                    //         isSignIn: true, hintText: LoginTextConstants.email),
                    //     controller: username,
                    //     keyboardType: TextInputType.emailAddress,
                    //     autofillHints: const [
                    //       AutofillHints.username,
                    //       AutofillHints.email,
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 16),
                    //     child: TextFormField(
                    //       decoration: signInRegisterInputDecoration(
                    //           isSignIn: true,
                    //           hintText: LoginTextConstants.password,
                    //           notifier: hidePass),
                    //       controller: password,
                    //       keyboardType: TextInputType.visiblePassword,
                    //       autofillHints: const [AutofillHints.password],
                    //       obscureText: hidePass.value,
                    //     )),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeroIcon(
                            HeroIcons.bolt,
                            color: LoginColorConstants.background,
                            size: 150,
                          ),
                          SignInBar(
                            isLoading: ref.watch(loadingrovider),
                            label: LoginTextConstants.signIn,
                            onPressed: () async {
                              await authNotifier.getTokenFromRequest(
                                  username.text, password.text);
                              ref.watch(authTokenProvider).when(
                                  data: (token) {},
                                  error: (e, s) {
                                    displayLoginToast(
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
