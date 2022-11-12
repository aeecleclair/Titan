import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/login/ui/text_from_decoration.dart';
import 'package:myecl/tools/functions.dart';

class ForgetPassword extends HookConsumerWidget {
  const ForgetPassword(
      {Key? key, required this.onSignInPressed, required this.onMailRecieved})
      : super(key: key);

  final VoidCallback onSignInPressed, onMailRecieved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final email = useTextEditingController();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onSignInPressed,
                child: const HeroIcon(
                  HeroIcons.chevronLeft,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LoginTextConstants.forgetPassword,
                  style: GoogleFonts.elMessiri(
                      textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: AutofillGroup(
                      child: TextFormField(
                        controller: email,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: signInRegisterInputDecoration(
                          isSignIn: false,
                          hintText: LoginTextConstants.email,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SignUpBar(
                    label: LoginTextConstants.recover,
                    isLoading: ref.watch(loadingrovider),
                    onPressed: () async {
                      final value =
                          await signUpNotifier.recoverUser(email.text);
                      if (value) {
                        displayToastWithContext(
                            TypeMsg.msg, LoginTextConstants.sendedResetMail);
                        email.clear();
                      } else {
                        displayToastWithContext(
                            TypeMsg.error, LoginTextConstants.mailSendingError);
                      }
                    },
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            splashColor: const Color.fromRGBO(255, 255, 255, 1),
                            onTap: () {
                              onSignInPressed();
                            },
                            child: const Text(
                              LoginTextConstants.signIn,
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
                            splashColor: const Color.fromRGBO(255, 255, 255, 1),
                            onTap: () {
                              onMailRecieved();
                            },
                            child: const Text(
                              LoginTextConstants.recievedMail,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                            ),
                          )),
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
