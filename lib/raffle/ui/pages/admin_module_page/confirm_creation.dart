import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/raffle_status_type.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class ConfirmCreationDialog extends HookConsumerWidget {
  final SimpleGroup group;
  const ConfirmCreationDialog({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffleListNotifier = ref.watch(raffleListProvider.notifier);

    void navigationPop() {
      Navigator.pop(context);
    }

    final animation = useAnimationController(
      duration: const Duration(milliseconds: 5000),
      initialValue: 0,
    )..repeat();

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 250,
            height: 350,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: RaffleColorConstants.gradient2,
                  blurRadius: 15,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: RadialGradient(
                colors: const [
                  RaffleColorConstants.gradient1,
                  RaffleColorConstants.gradient2,
                ],
                transform: GradientRotation(360 * animation.value * pi / 180),
                center: Alignment.topLeft,
                radius: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Voulez vous vraiment créer la tombola : ${group.name}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    WaitingButton(
                      waitingColor: Colors.black,
                      builder: (child) => Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade200,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300.withValues(
                                alpha: 0.5,
                              ),
                              blurRadius: 10,
                              offset: const Offset(2, 3),
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: child,
                      ),
                      onTap: () async {
                        await tokenExpireWrapper(ref, () async {
                          await raffleListNotifier.createRaffle(
                            Raffle(
                              name: "Tombola : ${group.name}",
                              group: group,
                              id: '',
                              raffleStatusType: RaffleStatusType.creation,
                            ),
                          );
                          await raffleListNotifier.loadRaffleList();
                          navigationPop();
                        });
                      },
                      child: const HeroIcon(
                        HeroIcons.check,
                        color: RaffleColorConstants.textDark,
                        size: 40,
                      ),
                    ),
                    const Spacer(flex: 3),
                    GestureDetector(
                      onTap: () {
                        navigationPop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              RaffleColorConstants.redGradient1,
                              RaffleColorConstants.redGradient2,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: RaffleColorConstants.redGradient2
                                  .withValues(alpha: 0.5),
                              blurRadius: 10,
                              offset: const Offset(2, 3),
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const HeroIcon(
                          HeroIcons.xMark,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
