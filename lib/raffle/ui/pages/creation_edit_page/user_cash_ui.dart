import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/cash.dart';
import 'package:titan/raffle/providers/cash_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class UserCashUi extends HookConsumerWidget {
  final Cash cash;
  const UserCashUi({super.key, required this.cash});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flipped = useState(true);
    final amount = useTextEditingController();
    final key = GlobalKey<FormState>();
    bool isFront = true;
    double anglePlus = 0;
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    void displayVoteWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    isFrontImage(double abs) {
      const degrees90 = pi / 2;
      const degrees270 = 3 * pi / 2;

      return abs <= degrees90 || abs >= degrees270;
    }

    toggle() {
      flipped.value = !flipped.value;
      if (flipped.value) {
        controller.reverse();
        isFront = true;
        anglePlus = 0;
      } else {
        controller.forward();
        isFront = false;
        anglePlus = pi;
      }
    }

    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double angle = controller.value * -pi;
          if (isFront) angle += anglePlus;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(angle);
          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: isFrontImage(angle.abs())
                ? Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const RadialGradient(
                          colors: [
                            RaffleColorConstants.gradient1,
                            RaffleColorConstants.gradient2,
                          ],
                          center: Alignment.topLeft,
                          radius: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: RaffleColorConstants.textDark.withValues(
                              alpha: 0.2,
                            ),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17.0,
                          vertical: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            AutoSizeText(
                              cash.user.nickname ?? cash.user.firstname,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            AutoSizeText(
                              cash.user.nickname != null
                                  ? '${cash.user.firstname} ${cash.user.name}'
                                  : cash.user.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: RaffleColorConstants.textDark,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  '${cash.balance.toStringAsFixed(2)} €',
                                  maxLines: 1,
                                  minFontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const HeroIcon(
                                  HeroIcons.plus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  )
                : Transform(
                    transform: Matrix4.identity()..rotateX(pi),
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: const RadialGradient(
                            colors: [
                              RaffleColorConstants.gradient1,
                              RaffleColorConstants.gradient2,
                            ],
                            center: Alignment.topLeft,
                            radius: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: RaffleColorConstants.textDark.withValues(
                                alpha: 0.2,
                              ),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Form(
                            key: key,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                    controller: amount,
                                    keyboardType: TextInputType.number,
                                    validator: (value) => value!.isEmpty
                                        ? RaffleTextConstants.add
                                        : null,
                                    cursorColor: RaffleColorConstants.textDark,
                                    decoration: const InputDecoration(
                                      suffixText: '€',
                                      suffixStyle: TextStyle(
                                        color: RaffleColorConstants.textDark,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: RaffleColorConstants.textDark,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                WaitingButton(
                                  builder: (child) => child,
                                  onTap: () async {
                                    if (key.currentState == null) {
                                      return;
                                    }
                                    if (key.currentState!.validate()) {
                                      await tokenExpireWrapper(ref, () async {
                                        await ref
                                            .read(cashProvider.notifier)
                                            .updateCash(
                                              cash,
                                              int.parse(amount.text),
                                            )
                                            .then((value) {
                                              if (value) {
                                                key.currentState!.reset();
                                                toggle();
                                                displayVoteWithContext(
                                                  TypeMsg.msg,
                                                  RaffleTextConstants
                                                      .updatedAmount,
                                                );
                                              } else {
                                                displayVoteWithContext(
                                                  TypeMsg.error,
                                                  RaffleTextConstants
                                                      .updatingError,
                                                );
                                              }
                                            });
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
