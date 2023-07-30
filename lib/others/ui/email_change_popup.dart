import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/shrink_button.dart';
import 'package:myecl/user/providers/user_provider.dart';

class Consts {
  Consts._();

  static const double padding = 30.0;
  static const double avatarRadius = 60.0;
  static const Color greenGradient1 = Color(0xff79a400);
  static const Color greenGradient2 = Color(0xff387200);
  static const Color redGradient1 = Color(0xFF9E131F);
  static const Color redGradient2 = Color(0xFF590512);
  static const String description =
      "L'administration a décidé de changer les adresses mails des étudiants.\nPour être sur de recevoir les mails en cas de perte du mot de passe, merci de renseigner la nouvelle (normalement elle est déjà préremplie 😉).";
}

class EmailChangeDialog extends HookConsumerWidget {
  const EmailChangeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final userNotifier = ref.watch(asyncUserProvider.notifier);
    final newEmail = '${user.email.split('@')[0]}@etu.ec-lyon.fr';
    final emailController = useTextEditingController(text: newEmail);
    final formKey = GlobalKey<FormState>();
    final checkAnimationController = useAnimationController(
        duration: const Duration(milliseconds: 500), initialValue: 0);
    final checkAnimation = CurvedAnimation(
        parent: checkAnimationController, curve: Curves.bounceOut);
    final ValueNotifier<AsyncValue> currentState =
        useState(AsyncError("", StackTrace.current));
    final displayForm = useState(true);
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            height: 500,
            padding: const EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: const EdgeInsets.only(top: Consts.avatarRadius),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                const Text(
                  "Changer d'adresse mail",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16.0),
                displayForm.value
                    ? Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            const Text(
                              Consts.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 48.0),
                            TextFormField(
                              controller: emailController,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                labelText: "Nouvelle adresse mail",
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return LoanTextConstants.noValue;
                                } else if (value.isEmpty) {
                                  return LoanTextConstants.noValue;
                                } else if (!isStudent(value)) {
                                  return "Adresse mail invalide";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 72.0),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Colors.black87,
                                            Colors.black,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 2.0,
                                            offset: const Offset(1.0, 2.0),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                          child: Text(
                                        "Annuler",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                  ShrinkButton(
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        currentState.value =
                                            const AsyncLoading();
                                        final result =
                                            await userNotifier.askMailMigration(
                                                emailController.text);
                                        if (result) {
                                          currentState.value =
                                              const AsyncData("");
                                          checkAnimationController.forward();
                                          displayForm.value = false;
                                        } else {
                                          currentState.value = AsyncError(
                                              "Une erreur est survenue",
                                              StackTrace.current);
                                        }
                                      }
                                    },
                                    builder: (child) => Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade300,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 2.0,
                                              offset: const Offset(1.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: child),
                                    waitingColor: Colors.black,
                                    child: const Center(
                                      child: Text(
                                        "Confirmer",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              const Text(
                                "Un mail de confirmation a été envoyé à l'adresse suivante, pour confirmer le changement :",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                emailController.text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 100,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 2.0,
                                        offset: const Offset(1.0, 2.0),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Text("Fermer",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Positioned(
              left: Consts.padding,
              right: Consts.padding,
              child: currentState.value.when(
                data: (data) => AnimatedBuilder(
                    animation: checkAnimationController,
                    builder: (context, child) {
                      return Container(
                          width: Consts.avatarRadius * 2,
                          height: Consts.avatarRadius * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Consts.greenGradient1,
                                Consts.greenGradient2,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Consts.greenGradient2.withOpacity(0.3),
                                blurRadius: 10.0,
                                offset: const Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 60 * checkAnimation.value,
                            ),
                          ));
                    }),
                loading: () => Container(
                    width: Consts.avatarRadius * 2,
                    height: Consts.avatarRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Consts.redGradient1,
                          Consts.redGradient2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Consts.redGradient2.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )),
                error: (error, stack) => Container(
                    width: Consts.avatarRadius * 2,
                    height: Consts.avatarRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Consts.redGradient1,
                          Consts.redGradient2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Consts.redGradient2.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: HeroIcon(
                        HeroIcons.exclamationCircle,
                        size: 60,
                        color: Colors.white,
                      ),
                    )),
              )),
        ]));
  }
}
