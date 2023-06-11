import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class ConfirmCreationDialog extends HookConsumerWidget {
  final SimpleGroup group;
  const ConfirmCreationDialog({Key? key, required this.group})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffleListNotifier = ref.watch(raffleListProvider.notifier);

    void navigationPop() {
      Navigator.pop(context);
    }

    final animation = useAnimationController(
        duration: const Duration(milliseconds: 5000), initialValue: 0)
      ..repeat();

    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                  padding:
                      const EdgeInsets.all(20),
                  width: 250,
                  height: 350,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: TombolaColorConstants.gradient2,
                          blurRadius: 15,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: RadialGradient(
                          colors: const [
                            TombolaColorConstants.gradient1,
                            TombolaColorConstants.gradient2,
                          ],
                          transform: GradientRotation(
                              360 * animation.value * pi / 180),
                          center: Alignment.topLeft,
                          radius: 1.5)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                                "Voulez vous vraiment créer la tombola : ${group.name}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            ShrinkButton(
                              waitChild: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.grey.shade100,
                                          Colors.grey.shade200,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300
                                                .withOpacity(0.5),
                                            blurRadius: 10,
                                            offset: const Offset(2, 3))
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: TombolaColorConstants.textDark,
                                    ),
                                  )),
                              onTap: () async {
                                await tokenExpireWrapper(ref, () async {
                                  await raffleListNotifier.createRaffle(Raffle(
                                      name: "Tombola : ${group.name}",
                                      group: group,
                                      id: '',
                                      raffleStatusType:
                                          RaffleStatusType.creation));
                                  await raffleListNotifier.loadRaffleList();
                                  navigationPop();
                                });
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.grey.shade100,
                                          Colors.grey.shade200,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300
                                                .withOpacity(0.5),
                                            blurRadius: 10,
                                            offset: const Offset(2, 3))
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  child: const HeroIcon(
                                    HeroIcons.check,
                                    color: TombolaColorConstants.textDark,
                                    size: 40,
                                  )),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigationPop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        TombolaColorConstants.redGradient1,
                                        TombolaColorConstants.redGradient2,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: TombolaColorConstants
                                              .redGradient2
                                              .withOpacity(0.5),
                                          blurRadius: 10,
                                          offset: const Offset(2, 3))
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: const HeroIcon(HeroIcons.xMark,
                                    color: Colors.white, size: 40),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ])));
        });
  }
}
