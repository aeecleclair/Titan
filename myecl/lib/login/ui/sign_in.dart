import 'package:flutter/material.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/login/ui/sign_in_up_bar.dart';
import 'package:myecl/login/ui/test_from_decoration.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key, required this.onRegisterPressed}) : super(key: key);

  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) {
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
                      decoration: signInInputDecoration(hintText: "Email")
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                        decoration: signInInputDecoration(hintText: "Mot de passe"))),
                  SignInBar(
                    isLoading: true,
                    label: "Se connecter",
                    onPressed: () {},
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
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
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}