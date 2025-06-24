import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/pack_ticket.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/raffle_status_type.dart';
import 'package:titan/raffle/providers/tombola_logo_provider.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/raffle_page/confirm_payment.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class BuyPackTicket extends HookConsumerWidget {
  final PackTicket packTicket;
  final Raffle raffle;
  const BuyPackTicket({
    super.key,
    required this.packTicket,
    required this.raffle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tombolaLogos = ref.watch(tombolaLogosProvider);
    final tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
    final tombolaLogoNotifier = ref.watch(tombolaLogoProvider.notifier);
    return GestureDetector(
      onTap: () {
        if (raffle.raffleStatusType == RaffleStatusType.open) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmPaymentDialog(
                packTicket: packTicket,
                raffle: raffle,
              );
            },
          );
        }
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(231, 4, 0, 11).withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
          gradient: const RadialGradient(
            colors: [
              RaffleColorConstants.gradient1,
              RaffleColorConstants.gradient2,
            ],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(1, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Builder(
                      builder: (context) {
                        if (tombolaLogos[raffle.id] != null) {
                          return tombolaLogos[raffle.id]!.when(
                            data: (data) {
                              if (data.isNotEmpty) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
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
                                  tombolaLogoNotifier.getLogo(raffle.id).then((
                                    value,
                                  ) {
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
                            loading: () => const CircularProgressIndicator(),
                            error: (Object error, StackTrace? stackTrace) =>
                                const HeroIcon(HeroIcons.cubeTransparent),
                          );
                        } else {
                          return const HeroIcon(HeroIcons.cubeTransparent);
                        }
                      },
                    ),
                  ),
                  Text(
                    "${packTicket.price.toStringAsFixed(2)}€",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${packTicket.packSize} tickets",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: raffle.raffleStatusType != RaffleStatusType.open
                      ? [
                          RaffleColorConstants.redGradient1,
                          RaffleColorConstants.redGradient2,
                        ]
                      : [Colors.white, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  raffle.raffleStatusType == RaffleStatusType.open
                      ? "Acheter ce ticket"
                      : raffle.raffleStatusType == RaffleStatusType.lock
                      ? "Tombola fermée"
                      : "Pas encore disponible",
                  style: TextStyle(
                    color: raffle.raffleStatusType != RaffleStatusType.open
                        ? Colors.white
                        : RaffleColorConstants.gradient2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
