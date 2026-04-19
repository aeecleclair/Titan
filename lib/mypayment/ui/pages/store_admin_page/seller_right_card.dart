import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/seller.dart';
import 'package:titan/mypayment/class/user_store.dart';
import 'package:titan/mypayment/providers/selected_store_provider.dart';
import 'package:titan/mypayment/providers/store_sellers_list_provider.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class _SellerRightsModal extends StatefulWidget {
  final Seller me;
  final Seller storeSeller;
  final List<Widget> icons;
  final List<String> labels;
  final List<bool> sellerRights;
  final bool isStructureAdmin;
  final bool amIAdmin;
  final UserStore store;

  const _SellerRightsModal({
    required this.me,
    required this.storeSeller,
    required this.icons,
    required this.labels,
    required this.sellerRights,
    required this.isStructureAdmin,
    required this.amIAdmin,
    required this.store,
  });

  @override
  State<_SellerRightsModal> createState() => _SellerRightsModalState();
}

class _SellerRightsModalState extends State<_SellerRightsModal> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer(
          builder: (context, ref, _) {
            final sellerStoreNotifier = ref.watch(
              sellerStoreProvider(widget.store.id).notifier,
            );

            void displayToastWithContext(TypeMsg type, String msg) {
              displayToast(context, type, msg);
            }

            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: Text(
                    "${AppLocalizations.of(context)!.paiementRightsOf} ${widget.storeSeller.user.nickname ?? ("${widget.storeSeller.user.firstname} ${widget.storeSeller.user.name}")}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 29, 29),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                for (var i = 0; i < widget.icons.length; i++)
                  if (i < 5 || widget.isStructureAdmin)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          widget.icons[i],
                          const SizedBox(width: 15),
                          Text(
                            widget.labels[i],
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 29, 29),
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          if (widget.me.canManageSellers && !widget.isStructureAdmin)
                            Checkbox(
                              value: widget.sellerRights[i],
                              activeColor: const Color(0xff204550),
                              visualDensity: const VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                              onChanged: (value) async {
                                await tokenExpireWrapper(ref, () async {
                                  final rightsUpdatedMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.paiementRightsUpdated;
                                  final rightsUpdateErrorMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.paiementRightsUpdateError;
                              final value = await sellerStoreNotifier
                                  .updateStoreSeller(
                                    widget.storeSeller.copyWith(
                                      canBank: i == 0
                                          ? !widget.sellerRights[0]
                                          : widget.sellerRights[0],
                                      canSeeHistory: i == 1
                                          ? !widget.sellerRights[1]
                                          : widget.sellerRights[1],
                                      canCancel: i == 2
                                          ? !widget.sellerRights[2]
                                          : widget.sellerRights[2],
                                      canManageSellers: i == 3
                                          ? !widget.sellerRights[3]
                                          : widget.sellerRights[3],
                                      canManageEvent: i == 4
                                          ? !widget.sellerRights[4]
                                          : widget.sellerRights[4],
                                    ),
                                  );
                                  if (value) {
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      rightsUpdatedMsg,
                                    );
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      rightsUpdateErrorMsg,
                                    );
                                  }
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                if (widget.me.canManageSellers && !widget.isStructureAdmin)
                  GestureDetector(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => CustomDialogBox(
                          title: AppLocalizations.of(
                            context,
                          )!.paiementDeleteStore,
                          descriptions: AppLocalizations.of(
                            context,
                          )!.paiementDeleteSellerDescription,
                          onYes: () {
                            tokenExpireWrapper(ref, () async {
                              final deleteSellerMsg = AppLocalizations.of(
                                context,
                              )!.paiementDeletedSeller;
                              final deletingSellerErrorMsg =
                                  AppLocalizations.of(
                                    context,
                                  )!.paiementDeletingSellerError;
                              final value = await sellerStoreNotifier
                                  .deleteStoreSeller(widget.storeSeller);
                              if (value) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  deleteSellerMsg,
                                );
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  deletingSellerErrorMsg,
                                );
                              }
                            });
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AddEditButtonLayout(
                        colors: const [
                          Color(0xFF9E131F),
                          Color(0xFF590512),
                        ],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const HeroIcon(
                              HeroIcons.trash,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.paiementDeleteSeller,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SellerRightCard extends ConsumerWidget {
  final Seller me;
  final Seller storeSeller;
  const SellerRightCard({
    super.key,
    required this.me,
    required this.storeSeller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(selectedStoreProvider);
    final rightsIcons = [];
    final rightsLabel = [];

    final amIAdmin = me.userId == store.structure.managerUser.id;

    final isStructureAdmin =
        storeSeller.userId == store.structure.managerUser.id;

    final icons =
        [
              HeroIcons.viewfinderCircle,
              HeroIcons.wallet,
              HeroIcons.xMark,
              HeroIcons.userGroup,
              HeroIcons.ticket,
            ]
            .map(
              (e) => CardButton(
                size: 35,
                colors: const [
                  Color.fromARGB(255, 6, 75, 75),
                  Color.fromARGB(255, 0, 29, 29),
                ],
                child: HeroIcon(e, color: Colors.white, size: 20),
              ),
            )
            .toList();
    icons.add(
      const CardButton(
        size: 35,
        colors: [
          Color.fromARGB(255, 255, 119, 7),
          Color.fromARGB(255, 186, 84, 1),
        ],
        child: HeroIcon(HeroIcons.userGroup, color: Colors.white, size: 20),
      ),
    );

    final labels = [
      AppLocalizations.of(context)!.paiementBank,
      AppLocalizations.of(context)!.paiementSeeHistory,
      AppLocalizations.of(context)!.paiementRefuseTransactions,
      AppLocalizations.of(context)!.paiementManageSellers,
      AppLocalizations.of(context)!.paiementManageEvents,
      AppLocalizations.of(context)!.paiementStructureAdmin,
    ];

    List<bool> sellerRights = [
      storeSeller.canBank,
      storeSeller.canSeeHistory,
      storeSeller.canCancel,
      storeSeller.canManageSellers,
      storeSeller.canManageEvent,
    ];

    for (var i = 0; i < sellerRights.length; i++) {
      if (sellerRights[i]) {
        rightsLabel.add(labels[i]);
        rightsIcons.add(icons[i]);
      }
    }

    if (isStructureAdmin) {
      rightsLabel.add(labels[4]);
      rightsIcons.add(icons[4]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ref.read(navbarVisibilityProvider.notifier).hide();
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            scrollControlDisabledMaxHeightRatio:
                (((!amIAdmin || isStructureAdmin) ? 80 : 100) +
                    45 * icons.length) /
                MediaQuery.of(context).size.height,
            builder: (context) {
              return _SellerRightsModal(
                me: me,
                storeSeller: storeSeller,
                icons: icons,
                labels: labels,
                sellerRights: sellerRights,
                isStructureAdmin: isStructureAdmin,
                amIAdmin: amIAdmin,
                store: store,
              );
            },
          ).whenComplete(() {
            ref.read(navbarVisibilityProvider.notifier).show();
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                storeSeller.user.nickname ??
                    ("${storeSeller.user.firstname} ${storeSeller.user.name}"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 29, 29),
                  fontSize: 14,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 25 * icons.length.toDouble() + 15,
              height: 40,
              child: Stack(
                children: List.generate(rightsIcons.length, (index) {
                  return Positioned(
                    left: (icons.length - rightsIcons.length + index) * 25,
                    child: rightsIcons[index],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
