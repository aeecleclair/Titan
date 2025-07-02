import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/login/class/account_type.dart';
import 'package:titan/login/providers/sign_up_provider.dart';
import 'package:titan/login/router.dart';
import 'package:titan/login/tools/constants.dart';
import 'package:titan/login/ui/auth_page.dart';
import 'package:titan/login/ui/components/sign_in_up_bar.dart';
import 'package:titan/login/ui/components/text_from_decoration.dart';
import 'package:titan/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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
                    AppLocalizations.of(context)!.loginCreateAccountTitle,
                    style: GoogleFonts.elMessiri(
                      textStyle: const TextStyle(
                        fontSize: 30,
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
                            hintText: AppLocalizations.of(context)!.loginEmail,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.loginEmailEmpty;
                            }
                            RegExp regExp = RegExp(emailRegExp);
                            if (!regExp.hasMatch(value)) {
                              return AppLocalizations.of(
                                context,
                              )!.loginEmailInvalid;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SignInUpBar(
                      label: AppLocalizations.of(context)!.loginCreate,
                      isLoading: ref
                          .watch(loadingProvider)
                          .maybeWhen(data: (data) => data, orElse: () => false),
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          final value = await signUpNotifier.createUser(
                            mail.text,
                            AccountType.student,
                          );
                          if (value) {
                            hidePass.value = true;
                            mail.clear();
                            QR.to(
                              LoginRouter.createAccount +
                                  LoginRouter.mailReceived,
                            );
                            displayToastWithContext(
                              TypeMsg.msg,
                              AppLocalizations.of(context)!.loginSendedMail,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              AppLocalizations.of(
                                context,
                              )!.loginMailSendingError,
                            );
                          }
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            AppLocalizations.of(context)!.loginEmailInvalid,
                          );
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
                              QR.to(LoginRouter.root);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.loginSignIn,
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
                            onTap: () {
                              QR.to(
                                LoginRouter.createAccount +
                                    LoginRouter.mailReceived,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.loginRecievedMail,
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
      ),
    );
  }
}
