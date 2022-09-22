import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/class/account_type.dart';
import 'package:myecl/login/providers/sign_up_provider.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/tools/functions.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/login/ui/text_from_decoration.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/functions.dart';

class Register extends HookConsumerWidget {
  const Register({Key? key, required this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final username = useTextEditingController();
    final password = useTextEditingController();
    final hidePass = useState(true);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LoginTextConstants.createAccountTitle,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                          controller: username,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          decoration: signInRegisterInputDecoration(
                              isSignIn: false,
                              hintText: LoginTextConstants.email))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      controller: password,
                      obscureText: hidePass.value,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration: signInRegisterInputDecoration(
                          isSignIn: false,
                          hintText: LoginTextConstants.password,
                          notifier: hidePass),
                    ),
                  ),
                  SignUpBar(
                    label: LoginTextConstants.create,
                    isLoading: ref.watch(loadingrovider),
                    onPressed: () async {
                      final value = await signUpNotifier.createUser(
                          username.text, password.text, AccountType.student);
                      if (value) {
                        displayLoginToast(context, TypeMsg.msg,
                            LoginTextConstants.sendedMail);
                      } else {
                        displayLoginToast(context, TypeMsg.error,
                            LoginTextConstants.mailSendingError);
                      }
                    },
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
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
                    ),
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
