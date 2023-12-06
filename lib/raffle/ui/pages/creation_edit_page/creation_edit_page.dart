import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/raffle/providers/cash_provider.dart';
import 'package:myecl/raffle/providers/prize_list_provider.dart';
import 'package:myecl/raffle/providers/raffle_list_provider.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/providers/raffle_stats_provider.dart';
import 'package:myecl/raffle/providers/pack_ticket_list_provider.dart';
import 'package:myecl/raffle/providers/tombola_logo_provider.dart';
import 'package:myecl/raffle/providers/tombola_logos_provider.dart';
import 'package:myecl/raffle/providers/winning_ticket_list_provider.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/components/blue_btn.dart';
import 'package:myecl/raffle/ui/pages/creation_edit_page/prize_handler.dart';
import 'package:myecl/raffle/ui/pages/creation_edit_page/ticket_handler.dart';
import 'package:myecl/raffle/ui/pages/creation_edit_page/winning_ticket_handler.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CreationPage extends HookConsumerWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    final raffle = ref.watch(raffleProvider);
    final raffleList = ref.watch(raffleListProvider);
    final raffleListNotifier = ref.read(raffleListProvider.notifier);
    final raffleStats = ref.watch(raffleStatsProvider);
    final cashNotifier = ref.read(cashProvider.notifier);
    final packTicketListNotifier = ref.read(packTicketListProvider.notifier);
    final prizeListNotifier = ref.read(prizeListProvider.notifier);
    final prizeList = ref.watch(prizeListProvider);
    final winningTicketListNotifier =
        ref.watch(winningTicketListProvider.notifier);

    final name = useTextEditingController(text: raffle.name);
    final ImagePicker picker = ImagePicker();

    final raffleLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
    final raffleLogoNotifier = ref.watch(tombolaLogoProvider.notifier);
    final logo = useState<Uint8List?>(null);
    final logoFile = useState<Image?>(null);
    ref.watch(tombolaLogosProvider).whenData((value) {
      if (value[raffle] != null) {
        value[raffle]!.whenData((data) {
          if (data.isNotEmpty) {
            logoFile.value = data.first;
          }
        });
      }
    });

    return RaffleTemplate(
      child: Refresher(
          onRefresh: () async {
            await cashNotifier.loadCashList();
            await packTicketListNotifier.loadPackTicketList(raffle.id);
            await prizeListNotifier.loadPrizeList(raffle.id);
          },
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(RaffleTextConstants.editRaffle,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 149, 149, 149)))),
            ),
            const SizedBox(height: 50),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: logoFile.value != null
                        ? Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: logo.value != null
                                    ? Image.memory(
                                        logo.value!,
                                        fit: BoxFit.cover,
                                      ).image
                                    : logoFile.value!.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const HeroIcon(
                            HeroIcons.userCircle,
                            size: 160,
                            color: Colors.grey,
                          ),
                  ),
                  if (raffle.status == RaffleStatusType.creation)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () async {
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 20);
                          if (image != null) {
                            if (kIsWeb) {
                              logo.value = await image.readAsBytes();
                              logoFile.value = Image.network(image.path);
                            } else {
                              final file = File(image.path);
                              logo.value = await file.readAsBytes();
                              logoFile.value = Image.file(file);
                            }
                            raffleLogoNotifier.updateLogo(
                                raffle.id, logo.value!);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                RaffleColorConstants.gradient1,
                                RaffleColorConstants.gradient2,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: RaffleColorConstants.gradient2
                                    .withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),
                          child: const HeroIcon(
                            HeroIcons.photo,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                  child: Form(
                      key: formKey,
                      child: TextEntry(
                          label: RaffleTextConstants.name,
                          enabled: raffle.status == RaffleStatusType.creation,
                          controller: name,
                          keyboardType: TextInputType.text))),
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: WaitingButton(
                    builder: (child) => BlueBtn(child: child),
                    onTap: () async {
                      if (raffle.status == RaffleStatusType.creation &&
                          formKey.currentState!.validate()) {
                        await tokenExpireWrapper(ref, () async {
                          RaffleComplete newRaffle = raffle.copyWith(
                            name: name.text,
                            description: raffle.description,
                            status: raffle.status,
                          );
                          await raffleListNotifier.updateRaffle(newRaffle);
                        });
                        raffleList.when(
                            data: (list) async {
                              if (logo.value != null) {
                                raffleLogoNotifier.updateLogo(
                                    raffle.id, logo.value!);
                                raffleLogosNotifier.setTData(
                                    raffle,
                                    AsyncData([
                                      Image.memory(
                                        logo.value!,
                                        fit: BoxFit.cover,
                                      ),
                                    ]));
                                QR.to(RaffleRouter.root + RaffleRouter.detail);
                              }
                            },
                            error: (error, s) {},
                            loading: () {});
                      }
                    },
                    child: const Text(RaffleTextConstants.edit))),
            const SizedBox(
              height: 40,
            ),
            raffle.status != RaffleStatusType.lock
                ? const TicketHandler()
                : const WinningTicketHandler(),
            const SizedBox(
              height: 30,
            ),
            const PrizeHandler(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerLeft,
              child: const Text(RaffleTextConstants.editRaffle,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RaffleColorConstants.textDark)),
            ),
            raffle.status != RaffleStatusType.lock
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    child: WaitingButton(
                        builder: (child) => BlueBtn(child: child),
                        onTap: () async {
                          await tokenExpireWrapper(ref, () async {
                            await showDialog(
                                context: context,
                                builder: (context) => CustomDialogBox(
                                      title: raffle.status ==
                                              RaffleStatusType.creation
                                          ? RaffleTextConstants.openRaffle
                                          : RaffleTextConstants.closeRaffle,
                                      descriptions: raffle.status ==
                                              RaffleStatusType.creation
                                          ? RaffleTextConstants
                                              .openRaffleDescription
                                          : RaffleTextConstants
                                              .closeRaffleDescription,
                                      onYes: () async {
                                        switch (raffle.status) {
                                          case RaffleStatusType.creation:
                                            await raffleListNotifier.openRaffle(
                                                raffle.copyWith(
                                                    description:
                                                        raffle.description,
                                                    status:
                                                        RaffleStatusType.open));
                                            QR.back();
                                            break;
                                          case RaffleStatusType.open:
                                            await raffleListNotifier.lockRaffle(
                                              raffle.copyWith(
                                                  description:
                                                      raffle.description,
                                                  status:
                                                      RaffleStatusType.lock),
                                            );
                                            prizeList.whenData((prizes) {
                                              for (var prize in prizes) {
                                                if (prize.raffleId ==
                                                    raffle.id) {
                                                  winningTicketListNotifier
                                                      .drawPrize(prize);
                                                }
                                              }
                                            });
                                            QR.back();
                                            break;
                                          default:
                                        }
                                      },
                                    ));
                          });
                        },
                        child: BlueBtn(
                            child: Text(raffle.status == RaffleStatusType.open
                                ? RaffleTextConstants.close
                                : RaffleTextConstants.open))),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        const Spacer(),
                        raffleStats.when(
                            data: (stats) => Column(
                                  children: [
                                    Text(
                                      stats.ticketsSold.toString(),
                                      style: const TextStyle(
                                          color: RaffleColorConstants.textDark,
                                          fontSize: 30),
                                    ),
                                    const Text(
                                      "Tickets",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: RaffleColorConstants.textDark,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                            error: (e, s) => const Text("Error"),
                            loading: () => const Center(
                                  child: CircularProgressIndicator(
                                    color: RaffleColorConstants.textDark,
                                  ),
                                )),
                        const Spacer(),
                        raffleStats.when(
                            data: (stats) => Column(
                                  children: [
                                    Text(
                                      "${stats.amountRaised.toStringAsFixed(2)} €",
                                      style: const TextStyle(
                                          color: RaffleColorConstants.textDark,
                                          fontSize: 30),
                                    ),
                                    const Text(
                                      "Récoltés",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: RaffleColorConstants.textDark,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                            error: (e, s) => const Text("Error"),
                            loading: () => const Center(
                                  child: CircularProgressIndicator(
                                    color: RaffleColorConstants.textDark,
                                  ),
                                )),
                        const Spacer(),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 30,
            )
          ])),
    );
  }
}
