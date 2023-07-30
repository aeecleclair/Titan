import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/class/account_type.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/auth_page.dart';
import 'package:myecl/login/ui/components/sign_in_up_bar.dart';
import 'package:myecl/login/ui/components/text_from_decoration.dart';
import 'package:myecl/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';

class Register extends HookConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final mail = useTextEditingController();
    final hidePass = useState(true);
    final key = GlobalKey<FormState>();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return LoginTemplate(
      callback: (AnimationController controller) {
        if (!controller.isCompleted) {
          controller.forward();
        }
      },
      child: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    QR.to(LoginRouter.root);
                  },
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
                    LoginTextConstants.createAccountTitle,
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
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: AutofillGroup(
                            child: TextFormField(
                          controller: mail,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          decoration: signInRegisterInputDecoration(
                              isSignIn: false,
                              hintText: LoginTextConstants.email),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LoginTextConstants.emailEmpty;
                            }
                            RegExp regExp =
                                RegExp(LoginTextConstants.emailRegExp);
                            if (!regExp.hasMatch(value)) {
                              return LoginTextConstants.emailInvalid;
                            }
                            return null;
                          },
                        ))),
                    const SizedBox(
                      height: 30,
                    ),
                    SignInUpBar(
                        label: LoginTextConstants.create,
                        isLoading: ref.watch(loadingProvider).maybeWhen(
                            data: (data) => data, orElse: () => false),
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            final value = await signUpNotifier.createUser(
                                mail.text, AccountType.student);
                            if (value) {
                              hidePass.value = true;
                              mail.clear();
                              QR.to(LoginRouter.createAccount +
                                  LoginRouter.mailReceived);
                              displayToastWithContext(
                                  TypeMsg.msg, LoginTextConstants.sendedMail);
                            } else {
                              displayToastWithContext(TypeMsg.error,
                                  LoginTextConstants.mailSendingError);
                            }
                          } else {
                            displayToastWithContext(
                                TypeMsg.error, LoginTextConstants.emailInvalid);
                          }
                        }),
                    const Spacer(),
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
                                QR.to(LoginRouter.root);
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
                              splashColor:
                                  const Color.fromRGBO(255, 255, 255, 1),
                              onTap: () {
                                QR.to(LoginRouter.createAccount +
                                    LoginRouter.mailReceived);
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
      ),
    );
  }
}
