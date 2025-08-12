import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/raffle_status_type.dart';
import 'package:titan/raffle/providers/cash_provider.dart';
import 'package:titan/raffle/providers/prize_list_provider.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/raffle/providers/raffle_provider.dart';
import 'package:titan/raffle/providers/raffle_stats_provider.dart';
import 'package:titan/raffle/providers/pack_ticket_list_provider.dart';
import 'package:titan/raffle/providers/tombola_logo_provider.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/raffle/providers/winning_ticket_list_provider.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/components/blue_btn.dart';
import 'package:titan/raffle/ui/pages/creation_edit_page/prize_handler.dart';
import 'package:titan/raffle/ui/pages/creation_edit_page/ticket_handler.dart';
import 'package:titan/raffle/ui/pages/creation_edit_page/winning_ticket_handler.dart';
import 'package:titan/raffle/ui/raffle.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/ui/widgets/image_picker_on_tap.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class CreationPage extends HookConsumerWidget {
  const CreationPage({super.key});

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
    final winningTicketListNotifier = ref.watch(
      winningTicketListProvider.notifier,
    );

    final name = useTextEditingController(text: raffle.name);
    final ImagePicker picker = ImagePicker();

    final raffleLogoNotifier = ref.watch(tombolaLogoProvider.notifier);
    final logo = useState<Uint8List?>(null);
    final logoFile = useState<Image?>(null);
    final tombolaLogos = ref.watch(tombolaLogosProvider);

    if (tombolaLogos[raffle.id] != null) {
      tombolaLogos[raffle.id]!.whenData((data) {
        if (data.isNotEmpty) {
          logoFile.value = data.first;
        }
      });
    }

    void displayRaffleToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return RaffleTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await cashNotifier.loadCashList();
          await packTicketListNotifier.loadPackTicketList();
          await prizeListNotifier.loadPrizeList();
        },
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.raffleEditRaffle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 149, 149, 149),
                  ),
                ),
              ),
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
                          color: Colors.black.withValues(alpha: 0.1),
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
                  if (raffle.raffleStatusType == RaffleStatusType.creation)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: ImagePickerOnTap(
                        picker: picker,
                        imageBytesNotifier: logo,
                        imageNotifier: logoFile,
                        displayToastWithContext: displayRaffleToastWithContext,
                        imageQuality: 20,
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
                                    .withValues(alpha: 0.3),
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
                    label: AppLocalizations.of(context)!.raffleName,
                    enabled:
                        raffle.raffleStatusType == RaffleStatusType.creation,
                    controller: name,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: WaitingButton(
                builder: (child) => BlueBtn(child: child),
                onTap: () async {
                  if (raffle.raffleStatusType == RaffleStatusType.creation &&
                      formKey.currentState!.validate()) {
                    await tokenExpireWrapper(ref, () async {
                      Raffle newRaffle = raffle.copyWith(
                        name: name.text,
                        description: raffle.description,
                        raffleStatusType: raffle.raffleStatusType,
                      );
                      await raffleListNotifier.updateRaffle(newRaffle);
                    });
                    raffleList.when(
                      data: (list) async {
                        if (logo.value != null) {
                          raffleLogoNotifier.updateLogo(raffle.id, logo.value!);
                          QR.to(RaffleRouter.root + RaffleRouter.detail);
                        }
                      },
                      error: (error, s) {},
                      loading: () {},
                    );
                  }
                },
                child: Text(AppLocalizations.of(context)!.raffleEdit),
              ),
            ),
            const SizedBox(height: 40),
            raffle.raffleStatusType != RaffleStatusType.lock
                ? const TicketHandler()
                : const WinningTicketHandler(),
            const SizedBox(height: 30),
            const PrizeHandler(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.raffleEditRaffle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RaffleColorConstants.textDark,
                ),
              ),
            ),
            raffle.raffleStatusType != RaffleStatusType.lock
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    child: WaitingButton(
                      builder: (child) => BlueBtn(child: child),
                      onTap: () async {
                        await tokenExpireWrapper(ref, () async {
                          await showDialog(
                            context: context,
                            builder: (context) => CustomDialogBox(
                              title:
                                  raffle.raffleStatusType ==
                                      RaffleStatusType.creation
                                  ? AppLocalizations.of(
                                      context,
                                    )!.raffleOpenRaffle
                                  : AppLocalizations.of(
                                      context,
                                    )!.raffleCloseRaffle,
                              descriptions:
                                  raffle.raffleStatusType ==
                                      RaffleStatusType.creation
                                  ? AppLocalizations.of(
                                      context,
                                    )!.raffleOpenRaffleDescription
                                  : AppLocalizations.of(
                                      context,
                                    )!.raffleCloseRaffleDescription,
                              onYes: () async {
                                switch (raffle.raffleStatusType) {
                                  case RaffleStatusType.creation:
                                    await raffleListNotifier.openRaffle(
                                      raffle.copyWith(
                                        description: raffle.description,
                                        raffleStatusType: RaffleStatusType.open,
                                      ),
                                    );
                                    QR.back();
                                    break;
                                  case RaffleStatusType.open:
                                    await raffleListNotifier.lockRaffle(
                                      raffle.copyWith(
                                        description: raffle.description,
                                        raffleStatusType: RaffleStatusType.lock,
                                      ),
                                    );
                                    prizeList.whenData((prizes) {
                                      for (var prize in prizes) {
                                        if (prize.raffleId == raffle.id) {
                                          winningTicketListNotifier.drawPrize(
                                            prize,
                                          );
                                        }
                                      }
                                    });
                                    QR.back();
                                    break;
                                  default:
                                }
                              },
                            ),
                          );
                        });
                      },
                      child: BlueBtn(
                        child: Text(
                          raffle.raffleStatusType == RaffleStatusType.open
                              ? AppLocalizations.of(context)!.raffleClose
                              : AppLocalizations.of(context)!.raffleOpen,
                        ),
                      ),
                    ),
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
                                  fontSize: 30,
                                ),
                              ),
                              const Text(
                                "Tickets",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: RaffleColorConstants.textDark,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          error: (e, s) => const Text("Error"),
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: RaffleColorConstants.textDark,
                            ),
                          ),
                        ),
                        const Spacer(),
                        raffleStats.when(
                          data: (stats) => Column(
                            children: [
                              Text(
                                "${stats.amountRaised.toStringAsFixed(2)} €",
                                style: const TextStyle(
                                  color: RaffleColorConstants.textDark,
                                  fontSize: 30,
                                ),
                              ),
                              const Text(
                                "Récoltés",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: RaffleColorConstants.textDark,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          error: (e, s) => const Text("Error"),
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: RaffleColorConstants.textDark,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
