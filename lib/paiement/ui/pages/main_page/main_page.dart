import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/paiement/class/payment_request.dart';
import 'package:titan/paiement/class/request_validation.dart';
import 'package:titan/paiement/providers/has_accepted_tos_provider.dart';
import 'package:titan/paiement/providers/my_wallet_provider.dart';
import 'package:titan/paiement/providers/payment_requests_provider.dart';
import 'package:titan/paiement/providers/tos_provider.dart';
import 'package:titan/paiement/providers/is_payment_admin.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';
import 'package:titan/paiement/providers/my_stores_provider.dart';
import 'package:titan/paiement/providers/register_provider.dart';
import 'package:titan/paiement/providers/should_display_tos_dialog.dart';
import 'package:titan/paiement/tools/key_service.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/paiment_delegate_modal.dart';
import 'package:titan/paiement/ui/pages/main_page/account_card/account_card.dart';
import 'package:titan/paiement/ui/pages/main_page/tos_dialog.dart';
import 'package:titan/paiement/ui/pages/main_page/account_card/last_transactions.dart';
import 'package:titan/paiement/ui/pages/main_page/flip_card.dart';
import 'package:titan/paiement/ui/pages/main_page/seller_card/store_card.dart';
import 'package:titan/paiement/ui/pages/main_page/seller_card/store_list.dart';
import 'package:titan/paiement/ui/paiement.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';

class PaymentMainPage extends HookConsumerWidget {
  const PaymentMainPage({super.key});

  static final Set<String> _handledKeys = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    resetHandledKeys() {
      _handledKeys.clear();
    }

    final shouldDisplayTosDialog = ref.watch(shouldDisplayTosDialogProvider);
    final shouldDisplayTosDialogNotifier = ref.read(
      shouldDisplayTosDialogProvider.notifier,
    );
    final hasAcceptedToSNotifier = ref.read(hasAcceptedTosProvider.notifier);
    final tos = ref.watch(tosProvider);
    final tosNotifier = ref.read(tosProvider.notifier);
    final registerNotifier = ref.read(registerProvider.notifier);
    final mySellers = ref.watch(myStoresProvider);
    final mySellersNotifier = ref.read(myStoresProvider.notifier);
    final myHistoryNotifier = ref.read(myHistoryProvider.notifier);
    final myWalletNotifier = ref.read(myWalletProvider.notifier);
    final isAdmin = ref.watch(isStructureAdminProvider);
    final flipped = useState(true);
    final paymentRequests = ref.watch(paymentRequestsProvider);
    final paymentRequestsNotifier = ref.read(paymentRequestsProvider.notifier);
    final hasShownRequestModal = useState(false);

    ref.listen(pathForwardingProvider, (previous, next) async {
      final params = next.queryParameters;
      if (params != null &&
          params["code"] == "succeeded" &&
          !_handledKeys.contains("code")) {
        _handledKeys.add("code");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          displayToast(
            context,
            TypeMsg.msg,
            AppLocalizations.of(context)!.paiementSuccededTransaction,
          );
        });
      }
      await mySellersNotifier.getMyStores();
      await myHistoryNotifier.getHistory();
      await myWalletNotifier.getMyWallet();
    });

    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0,
    );

    toggle() {
      flipped.value = !flipped.value;
      if (flipped.value) {
        controller.reverse();
        ref.invalidate(myWalletProvider);
        ref.invalidate(myHistoryProvider);
      } else {
        controller.forward();
      }
    }

    Future<void> showRequestModal(PaymentRequest request) async {
      final keyService = KeyService();
      await showCustomBottomModal(
        context: context,
        ref: ref,
        modal: PaimentDelegateModal(
          itemTitle: request.name,
          itemDescription: request.storeNote ?? '',
          itemPrice: request.total,
          onConfirm: () async {
            final keyId = await keyService.getKeyId();
            final keyPair = await keyService.getKeyPair();
            if (keyId == null || keyPair == null) {
              if (context.mounted) {
                Navigator.of(context).pop();
                displayToast(
                  context,
                  TypeMsg.error,
                  AppLocalizations.of(context)!.paiementPaymentRequestError,
                );
              }
              return;
            }
            final now = DateTime.now();
            final validationData = RequestValidationData(
              requestId: request.id,
              key: keyId,
              iat: now,
              tot: request.total,
            );
            final dataToSign = jsonEncode(validationData.toJson());
            final signature = await keyService.signMessage(
              keyPair,
              dataToSign.codeUnits,
            );
            final validation = RequestValidation(
              requestId: request.id,
              key: keyId,
              iat: now,
              tot: request.total,
              signature: base64Encode(signature.bytes),
            );
            final success = await paymentRequestsNotifier.acceptRequest(
              request,
              validation,
            );
            if (context.mounted) {
              Navigator.of(context).pop();
              displayToast(
                context,
                success ? TypeMsg.msg : TypeMsg.error,
                success
                    ? AppLocalizations.of(
                        context,
                      )!.paiementPaymentRequestAccepted
                    : AppLocalizations.of(context)!.paiementPaymentRequestError,
              );
              if (success) {
                await myHistoryNotifier.getHistory();
                await myWalletNotifier.getMyWallet();
              }
            }
          },
          onRefuse: () async {
            final success = await paymentRequestsNotifier.refuseRequest(
              request,
            );
            if (context.mounted) {
              Navigator.of(context).pop();
              displayToast(
                context,
                success ? TypeMsg.msg : TypeMsg.error,
                success
                    ? AppLocalizations.of(
                        context,
                      )!.paiementPaymentRequestRefused
                    : AppLocalizations.of(context)!.paiementPaymentRequestError,
              );
            }
          },
        ),
      );
    }

    useEffect(() {
      paymentRequests.whenData((requests) {
        final pendingRequests = requests
            .where((r) => r.status == RequestStatus.proposed)
            .toList();
        if (pendingRequests.isNotEmpty && !hasShownRequestModal.value) {
          hasShownRequestModal.value = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showRequestModal(pendingRequests.first);
          });
        }
      });
      return null;
    }, [paymentRequests]);

    tos.maybeWhen(
      orElse: () {},
      error: (e, s) async {
        final value = await registerNotifier.register();
        value.maybeWhen(
          orElse: () {},
          data: (value) async {
            if (value) {
              tosNotifier.getTOS();
            }
          },
        );
      },
    );

    return PaymentTemplate(
      child: shouldDisplayTosDialog
          ? ScrollToHideNavbar(
              controller: ScrollController(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: TOSDialogBox(
                  descriptions: tos.maybeWhen(
                    orElse: () => '',
                    data: (tos) => tos.tosContent,
                  ),
                  title: AppLocalizations.of(context)!.paiementNewCGU,
                  onYes: () {
                    tos.maybeWhen(
                      orElse: () {},
                      data: (tos) async {
                        final value = await tosNotifier.signTOS(
                          tos.copyWith(
                            acceptedTosVersion: tos.latestTosVersion,
                          ),
                        );
                        if (value) {
                          await mySellersNotifier.getMyStores();
                          await myHistoryNotifier.getHistory();
                          await myWalletNotifier.getMyWallet();
                          shouldDisplayTosDialogNotifier.update(false);
                          hasAcceptedToSNotifier.update(true);
                        }
                      },
                    );
                  },
                  onNo: () {
                    shouldDisplayTosDialogNotifier.update(false);
                  },
                ),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Refresher(
                  controller: ScrollController(),
                  onRefresh: () async {
                    await mySellersNotifier.getMyStores();
                    await myHistoryNotifier.getHistory();
                    await myWalletNotifier.getMyWallet();
                    await tosNotifier.getTOS();
                    hasShownRequestModal.value = false;
                    await paymentRequestsNotifier.getRequests();
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      AsyncChild(
                        value: mySellers,
                        builder: (context, mySellers) {
                          if (mySellers.isEmpty && !isAdmin) {
                            return SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: AccountCard(
                                toggle: null,
                                resetHandledKeys: resetHandledKeys,
                              ),
                            );
                          }
                          return SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: FlipCard(
                              back: StoreCard(toggle: toggle),
                              front: AccountCard(
                                toggle: toggle,
                                resetHandledKeys: resetHandledKeys,
                              ),
                              controller: controller,
                            ),
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          return Stack(
                            children: [
                              Visibility(
                                visible: controller.value.abs() < 1,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: 1 - controller.value.abs(),
                                  child: LastTransactions(
                                    maxHeight: constraints.maxHeight - 260,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.value.abs() > 0,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: controller.value.abs(),
                                  child: StoreList(
                                    maxHeight: constraints.maxHeight - 260,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
