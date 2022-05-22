import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/login/ui/text_from_decoration.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';

class SignIn extends HookConsumerWidget {
  const SignIn({Key? key, required this.onRegisterPressed}) : super(key: key);

  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authTokenProvider.notifier);
    final auth = ref.read(authTokenProvider);
    final username = useTextEditingController();
    final password = useTextEditingController();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bon\nRetour",
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
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        decoration: signInInputDecoration(hintText: "Email"),
                        controller: username,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextFormField(
                          decoration:
                              signInInputDecoration(hintText: "Mot de passe"),
                          controller: password,
                        )),
                    SignInBar(
                      isLoading: ref.watch(loadingrovider),
                      label: "Se connecter",
                      onPressed: () {
                        authNotifier.getTokenFromRequest(
                            username.text, password.text);
                        auth.when(
                            data: (token) {
                              // authNotifier.storeToken();
                            },
                            error: (e, s) {
                              displayToast(
                                  context, TypeMsg.error, e.toString());
                            },
                            loading: () {});
                      },
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          splashColor: const Color.fromRGBO(255, 255, 255, 1),
                          onTap: () {
                            onRegisterPressed();
                          },
                          child: const Text(
                            "Créer un compte",
                            style: TextStyle(
                              color: ColorConstants.darkBlue,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
