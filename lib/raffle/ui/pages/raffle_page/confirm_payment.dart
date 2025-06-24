import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/pack_ticket.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/providers/tombola_logo_provider.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/raffle/providers/user_amount_provider.dart';
import 'package:titan/raffle/providers/user_tickets_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class ConfirmPaymentDialog extends HookConsumerWidget {
  final PackTicket packTicket;
  final Raffle raffle;
  const ConfirmPaymentDialog({
    super.key,
    required this.packTicket,
    required this.raffle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAmount = ref.watch(userAmountProvider);
    final userAmountNotifier = ref.watch(userAmountProvider.notifier);
    final userTicketListNotifier = ref.watch(userTicketListProvider.notifier);
    final tombolaLogos = ref.watch(tombolaLogosProvider);
    final tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
    final tombolaLogoNotifier = ref.watch(tombolaLogoProvider.notifier);

    double b = 0;
    userAmount.maybeWhen(
      data: (u) {
        b = u.balance;
      },
      orElse: () {},
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    void navigationPop() {
      Navigator.pop(context);
    }

    final animation = useAnimationController(
      duration: const Duration(milliseconds: 10000),
      initialValue: 0,
    )..repeat();

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 300,
            height: 450,
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.5),
                              blurRadius: 15,
                              offset: const Offset(2, 3),
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Builder(
                            builder: (context) {
                              if (tombolaLogos[raffle.id] != null) {
                                return tombolaLogos[raffle.id]!.when(
                                  data: (data) {
                                    if (data.isNotEmpty) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                        child: data.first,
                                      );
                                    } else {
                                      Future.delayed(
                                        const Duration(milliseconds: 1),
                                        () {
                                          tombolaLogosNotifier.setTData(
                                            raffle.id,
                                            const AsyncLoading(),
                                          );
                                        },
                                      );
                                      tokenExpireWrapper(ref, () async {
                                        tombolaLogoNotifier
                                            .getLogo(raffle.id)
                                            .then((value) {
                                              tombolaLogosNotifier.setTData(
                                                raffle.id,
                                                AsyncData([value]),
                                              );
                                            });
                                      });
                                      return const HeroIcon(
                                        HeroIcons.cubeTransparent,
                                      );
                                    }
                                  },
                                  loading: () =>
                                      const CircularProgressIndicator(),
                                  error:
                                      (Object error, StackTrace? stackTrace) =>
                                          const HeroIcon(
                                            HeroIcons.cubeTransparent,
                                          ),
                                );
                              } else {
                                return const HeroIcon(
                                  HeroIcons.cubeTransparent,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Text(
                        "${packTicket.price} €",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${packTicket.packSize} tickets",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AutoSizeText(
                    raffle.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    bottom: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      WaitingButton(
                        waitingColor: RaffleColorConstants.textDark,
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
                          if (b < packTicket.price) {
                            displayToastWithContext(
                              TypeMsg.error,
                              "Vous n'avez pas assez d'argent",
                            );
                          } else {
                            await tokenExpireWrapper(ref, () async {
                              final value = await userTicketListNotifier
                                  .buyTicket(packTicket);
                              if (value) {
                                userAmountNotifier.updateCash(
                                  -packTicket.price.toDouble(),
                                );
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  RaffleTextConstants.boughtTicket,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  RaffleTextConstants.addingError,
                                );
                              }
                              navigationPop();
                            });
                          }
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
