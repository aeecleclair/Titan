import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/providers/email_popup_state_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/user/providers/user_provider.dart';

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 50.0;
  static const Color greenGradient1 = Color(0xff79a400);
  static const Color greenGradient2 = Color(0xff387200);
  static const Color redGradient1 = Color(0xFF9E131F);
  static const Color redGradient2 = Color(0xFF590512);
  static const String titleMigration = "Accès à l'application restreint";
  static const String descriptionMigration =
      "Vous avez créé un compte avec une adresse mail qui n'est pas une adresse centralienne.\n\nPour avoir un accès complet à cette application vous devez changer cette adresse mail.";
}

class EmailChangeDialog extends HookConsumerWidget {
  const EmailChangeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayForm = useState(true);
    final emailController = useTextEditingController();
    final user = ref.watch(userProvider);
    final userNotifier = ref.watch(asyncUserProvider.notifier);
    final emailPopupStateNotifier = ref.read(emailPopupStateProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    print(emailController.text);

    useEffect(() {
      return () {
        final newEmail =
            '${removeDiacritics(user.firstname.toLowerCase())}.${removeDiacritics(user.name.toLowerCase())}@etu.ec-lyon.fr';
        emailController.text = newEmail;
      };
    }, []);

    return GestureDetector(
      onTap: emailPopupStateNotifier.close,
      child: Container(
        height: double.infinity,
        color: Colors.black54,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(
              left: Consts.padding,
              right: Consts.padding,
              top: MediaQuery.of(context).size.height * 0.20,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
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
                        Consts.titleMigration,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      displayForm.value
                          ? Column(
                              children: [
                                Text(
                                  Consts.descriptionMigration,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 15.0),
                                TextEntry(
                                  controller: emailController,
                                  label: "Nouvelle adresse mail",
                                ),
                                const SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: emailPopupStateNotifier.close,
                                      child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                                              color: Colors.black.withValues(
                                                alpha: 0.3,
                                              ),
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
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    WaitingButton(
                                      onTap: () async {
                                        if (emailController.text.isEmpty) {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            "L'adresse mail ne peut pas être vide.",
                                          );
                                          return;
                                        } else if (RegExp(
                                              r'^[\w\-.]+@etu(-enise)?\.ec-lyon\.fr$',
                                            ).hasMatch(emailController.text) ==
                                            false) {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            "L'adresse mail doit être une adresse centralienne valide.",
                                          );
                                          return;
                                        }
                                        final result = await userNotifier
                                            .askMailMigration(
                                              emailController.text,
                                            );
                                        if (result) {
                                          displayForm.value = false;
                                        } else {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            "Une erreur est survenue lors de la demande de changement d'adresse mail.",
                                          );
                                        }
                                      },
                                      waitingColor: Colors.black,
                                      builder: (child) => Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Colors.grey.shade300,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withValues(
                                                alpha: 0.3,
                                              ),
                                              blurRadius: 2.0,
                                              offset: const Offset(1.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: child,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Confirmer",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                children: [
                                  const Text(
                                    "Un mail de confirmation a été envoyé à l'adresse suivante, pour confirmer le changement :",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16.0),
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
                                  const SizedBox(height: 30.0),
                                  GestureDetector(
                                    onTap: emailPopupStateNotifier.close,
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade300,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withValues(
                                              alpha: 0.3,
                                            ),
                                            blurRadius: 2.0,
                                            offset: const Offset(1.0, 2.0),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Fermer",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
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
                Positioned(
                  left: Consts.padding,
                  right: Consts.padding,
                  child: !displayForm.value
                      ? Container(
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
                                color: Consts.greenGradient2.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 10.0,
                                offset: const Offset(0.0, 10.0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        )
                      : Container(
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
                                color: Consts.redGradient2.withValues(
                                  alpha: 0.3,
                                ),
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
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
