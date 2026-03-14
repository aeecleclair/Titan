import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/advert/ui/components/special_action_button.dart';
import 'package:titan/shotgun/router.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class ShotgunMainPage extends ConsumerWidget {
  const ShotgunMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShotgunTemplate(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Shotgun",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
                const Spacer(),
                if (true) ...[
                  const SizedBox(width: 10),
                  SpecialActionButton(
                    icon: HeroIcon(HeroIcons.userGroup, color: Colors.white),
                    name: "Admin",
                    onTap: () {
                      showCustomBottomModal(
                        context: context,
                        ref: ref,
                        modal: BottomModalTemplate(
                          title: "Admin",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Button(
                                text: "Créer un shotgun",
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  QR.to(
                                    ShotgunRouter.root + ShotgunRouter.create,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Button(
                                text: "Gérer les shotgun de l'association",
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  QR.to(
                                    ShotgunRouter.root + ShotgunRouter.manage,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
