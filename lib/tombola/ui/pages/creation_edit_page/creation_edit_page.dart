
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/providers/cash_provider.dart';
import 'package:myecl/tombola/providers/prize_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/raffle_stats_provider.dart';
import 'package:myecl/tombola/providers/pack_ticket_provider.dart';
import 'package:myecl/tombola/providers/tombola_logo_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/blue_btn.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/ticket_handler.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/prize_handler.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/winning_ticket_handler.dart';
import 'package:myecl/tombola/ui/text_entry.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class CreationPage extends HookConsumerWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final raffle = ref.watch(raffleProvider);
    final raffleListNotifier = ref.read(raffleListProvider.notifier);
    final raffleStats = ref.watch(raffleStatsProvider);
    final cashNotifier = ref.read(cashProvider.notifier);
    final packTicketListNotifier = ref.read(packTicketListProvider.notifier);
    final prizeListNotifier = ref.read(prizeListProvider.notifier);
    final tombolaLogoNotifier = ref.watch(tombolaLogoProvider.notifier);

    final name = useTextEditingController(text: raffle.name);

    final logo = useState<String?>(null);
    final ImagePicker picker = ImagePicker();

    return Refresher(
        onRefresh: () async {
          await cashNotifier.loadCashList();
          await packTicketListNotifier.loadPackTicketList();
          await prizeListNotifier.loadPrizeList();
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const RadialGradient(
                        colors: [
                          TombolaColorConstants.gradient2,
                          Colors.black,
                        ],
                        radius: 6.0,
                        tileMode: TileMode.mirror,
                        center: Alignment.topLeft,
                      ).createShader(bounds),
                  child: Center(
                      child: Form(
                          key: formKey,
                          child: TextEntry(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TombolaTextConstants.fillField;
                                }
                                return null;
                              },
                              textEditingController: name,
                              keyboardType: TextInputType.text)))),
            ),
            Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: ShrinkButton(
                    waitChild:
                        const BlueBtn(text: TombolaTextConstants.waiting),
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await tokenExpireWrapper(ref, () async {
                          await raffleListNotifier.updateRaffle(raffle.copyWith(
                              name: name.text,
                              description: raffle.description,
                              raffleStatusType: raffle.raffleStatusType));
                        });
                        pageNotifier.setTombolaPage(TombolaPage.main);// TombolaPage.detail mais problème à regler
                      }
                    },
                    child: const BlueBtn(text: "Changez le nom"))),
            const SizedBox(
              height: 32,
            ),
            raffle.raffleStatusType != RaffleStatusType.lock
                ? const TicketHandler()
                : const WinningTicketHandler(),
            const SizedBox(
              height: 12,
            ),
            const PrizeHandler(),
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerLeft,
                child: const Text("Changer le logo de la tombola",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: TombolaColorConstants.textDark)),
              ),
              GestureDetector(
                onTap: () async {
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    logo.value = image.path;
                    tombolaLogoNotifier.updateLogo(raffle.id, await image.readAsBytes());
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
                        TombolaColorConstants.gradient1,
                        TombolaColorConstants.gradient2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: TombolaColorConstants.gradient2.withOpacity(0.3),
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
            ]),
            raffle.raffleStatusType != RaffleStatusType.lock
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    child: ShrinkButton(
                        waitChild:
                            const BlueBtn(text: TombolaTextConstants.waiting),
                        onTap: () async {
                          await tokenExpireWrapper(ref, () async {
                            await showDialog(
                                context: context,
                                builder: (context) => CustomDialogBox(
                                      title: raffle.raffleStatusType ==
                                              RaffleStatusType.creation
                                          ? TombolaTextConstants.openRaffle
                                          : TombolaTextConstants.closeRaffle,
                                      descriptions: raffle.raffleStatusType ==
                                              RaffleStatusType.creation
                                          ? TombolaTextConstants
                                              .openRaffleDescription
                                          : TombolaTextConstants
                                              .closeRaffleDescription,
                                      onYes: () async {
                                        switch (raffle.raffleStatusType) {
                                          case RaffleStatusType.creation:
                                            await raffleListNotifier.openRaffle(
                                                raffle.copyWith(
                                                    description:
                                                        raffle.description,
                                                    raffleStatusType:
                                                        RaffleStatusType.open));
                                            break;
                                          case RaffleStatusType.open:
                                            await raffleListNotifier.lockRaffle(
                                              raffle.copyWith(
                                                  description:
                                                      raffle.description,
                                                  raffleStatusType:
                                                      RaffleStatusType.lock),
                                            );
                                            break;
                                          default:
                                        }
                                      },
                                    ));
                          });
                          pageNotifier.setTombolaPage(TombolaPage.main);
                        },
                        child: BlueBtn(
                            text:
                                raffle.raffleStatusType == RaffleStatusType.open
                                    ? TombolaTextConstants.close
                                    : TombolaTextConstants.open)),
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
                                          color: TombolaColorConstants.textDark,
                                          fontSize: 30),
                                    ),
                                    const Text(
                                      "Tickets",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: TombolaColorConstants.textDark,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                            error: (e, s) => const Text("Error"),
                            loading: () => const Center(
                                  child: CircularProgressIndicator(
                                    color: TombolaColorConstants.textDark,
                                  ),
                                )),
                        const Spacer(),
                        raffleStats.when(
                            data: (stats) => Column(
                                  children: [
                                    Text(
                                      "${stats.amountRaised.toStringAsFixed(2)} €",
                                      style: const TextStyle(
                                          color: TombolaColorConstants.textDark,
                                          fontSize: 30),
                                    ),
                                    const Text(
                                      "Récoltés",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: TombolaColorConstants.textDark,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                            error: (e, s) => const Text("Error"),
                            loading: () => const Center(
                                  child: CircularProgressIndicator(
                                    color: TombolaColorConstants.textDark,
                                  ),
                                )),
                        const Spacer(),
                      ],
                    ),
                  ),
          ],
        ));
  }
}
