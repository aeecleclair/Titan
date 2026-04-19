import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';
import 'package:titan/mypayment/providers/can_pay_provider.dart';
import 'package:titan/mypayment/providers/my_wallet_provider.dart';
import 'package:titan/mypayment/tools/can_pay.dart' show CanPayError;
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tickets/class/answer.dart';
import 'package:titan/tickets/class/answer_type.dart';
import 'package:titan/tickets/class/category.dart';
import 'package:titan/tickets/class/checkout.dart';
import 'package:titan/tickets/class/request_type.dart';
import 'package:titan/tickets/class/question.dart';
import 'package:titan/tickets/class/session.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/providers/checkout_provider.dart';
import 'package:titan/tickets/providers/ticket_event_provider.dart';
import 'package:titan/tickets/router.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

class BookTicketPage extends HookConsumerWidget {
  const BookTicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathForwarding = ref.watch(pathForwardingProvider);
    final ticketEventId = pathForwarding.queryParameters?['ticketEventId'];
    final l10n = AppLocalizations.of(context)!;
    if (ticketEventId == null || ticketEventId.isEmpty) {
      return TicketTemplate(
        child: Center(
          child: Text(
            l10n.ticketsNotFound,
            style: TextStyle(color: ColorConstants.tertiary),
          ),
        ),
      );
    }

    final ticketEventAsync = ref.watch(
      publicTicketEventByIdProvider(ticketEventId),
    );

    return TicketTemplate(
      child: AsyncChild<TicketEvent>(
        value: ticketEventAsync,
        builder: (context, ticketEvent) =>
            _TicketEventContent(ticketEvent: ticketEvent),
      ),
    );
  }
}

class _TicketEventContent extends HookConsumerWidget {
  const _TicketEventContent({required this.ticketEvent});

  final TicketEvent ticketEvent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeFormat = DateFormat.Hm('fr');

    final selectedCategory = useState<Category?>(null);
    final selectedSession = useState<Session?>(null);
    final selectedPaymentProvider = useState<String?>('helloasso');
    final answersMap = useState<Map<String, dynamic>>({});
    final checkoutState = ref.watch(checkoutProvider);
    final walletAsync = ref.watch(myWalletProvider);
    final canPayAsync = ref.watch(canPayProvider);
    final l10n = AppLocalizations.of(context)!;

    // Hide navbar when page loads
    useEffect(() {
      // Use a microtask to avoid modifying provider during build
      Future.microtask(() {
        ref.read(navbarVisibilityProvider.notifier).hide();
      });
      return () {
        // Show navbar again when leaving the page
        ref.read(navbarVisibilityProvider.notifier).show();
      };
    }, []);

    // Helper to get payment method from provider value
    RequestType getPaymentMethod(String? provider) {
      return provider == 'helloasso'
          ? RequestType.transferRequest
          : RequestType.transactionRequest;
    }

    // Helper to get redirect URL
    String getRedirectUrl() {
      return kIsWeb
          ? "${getTitanURL()}/tickets"
          : "${getTitanURLScheme()}://tickets";
    }

    // Helper to build answers list from answersMap
    List<Answer> buildAnswersList() {
      return ticketEvent.questions
          .where((q) => answersMap.value.containsKey(q.id))
          .map(
            (q) => Answer(
              questionId: q.id,
              answerType: q.answerType,
              answer: answersMap.value[q.id],
            ),
          )
          .toList();
    }

    // Check if all required questions are answered
    bool areAllRequiredQuestionsAnswered() {
      final requiredQuestions = ticketEvent.questions.where((q) => q.required);
      for (final question in requiredQuestions) {
        final answer = answersMap.value[question.id];
        if (answer == null || (answer is String && answer.trim().isEmpty)) {
          return false;
        }
      }
      return true;
    }

    // Update checkout when category or session changes
    final checkout = useState<Checkout>(
      Checkout(
        categoryId: selectedCategory.value?.id ?? '',
        sessionId: selectedSession.value?.id ?? '',
        answers: [],
        myPaymentRequestMethod: getPaymentMethod(selectedPaymentProvider.value),
        myPaymentTransferRedirectUrl: getRedirectUrl(),
      ),
    );

    // Sync checkout with selection changes
    useEffect(
      () {
        checkout.value = Checkout(
          categoryId: selectedCategory.value?.id ?? '',
          sessionId: selectedSession.value?.id ?? '',
          answers: buildAnswersList(),
          myPaymentRequestMethod: getPaymentMethod(
            selectedPaymentProvider.value,
          ),
          myPaymentTransferRedirectUrl: getRedirectUrl(),
        );
        return null;
      },
      [
        selectedCategory.value,
        selectedSession.value,
        selectedPaymentProvider.value,
        answersMap.value,
      ],
    );

    // Helper functions for payment
    Future<void> tryLaunchUrl(String url) async {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception(l10n.paiementCantLaunchURL);
      }
    }

    void helloAssoCallback(String paymentUrl) async {
      html.WindowBase? popupWin =
          html.window.open(
                paymentUrl,
                "HelloAsso",
                "width=800, height=900, scrollbars=yes",
              )
              as html.WindowBase?;

      if (popupWin == null) {
        displayToast(context, TypeMsg.error, l10n.paiementPleaseAcceptPopup);
        return;
      }

      final completer = Completer();
      final win = popupWin; // capture non-null value
      void checkWindowClosed() {
        if (win.closed == true) {
          completer.complete();
        } else {
          Future.delayed(const Duration(milliseconds: 100), checkWindowClosed);
        }
      }

      checkWindowClosed();
      completer.future.then((_) {
        // Clear checkout and redirect to /tickets when popup is closed
        ref.read(checkoutProvider.notifier).reset();
        QR.to('/tickets');
      });

      void handlePaymentResult(String data) async {
        final receivedUri = Uri.parse(data);
        final code = receivedUri.queryParameters["code"];
        if (code == "succeeded") {
          displayToast(context, TypeMsg.msg, l10n.ticketsReservationSuccess);
        } else {
          displayToast(context, TypeMsg.error, l10n.paiementRefusedTransaction);
        }
        popupWin.close();
      }

      html.window.onMessage.listen((event) {
        if (event.data.toString().contains('code=')) {
          handlePaymentResult(event.data);
        }
      });
    }

    // Handle success/error states
    useEffect(() {
      if (checkoutState.isSuccess && checkoutState.checkout != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final checkout = checkoutState.checkout!;
          if (checkout.paymentUrl != null && checkout.paymentUrl!.isNotEmpty) {
            ref.read(checkoutProvider.notifier).reset();
            QR.to(TicketsRouter.root);
            if (kIsWeb) {
              helloAssoCallback(checkout.paymentUrl!);
            } else {
              try {
                await tryLaunchUrl(checkout.paymentUrl!);
              } catch (e) {
                if (context.mounted) {
                  displayToast(context, TypeMsg.error, e.toString());
                }
              }
            }
          } else {
            // Événement gratuit - rediriger vers la page des tickets avec message de succès
            ref.read(checkoutProvider.notifier).reset();
            if (context.mounted) {
              displayToast(
                context,
                TypeMsg.msg,
                l10n.ticketsReservationSuccess,
              );
            }
            QR.to(TicketsRouter.root);
          }
        });
      } else if (checkoutState.error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${l10n.othersError}: ${checkoutState.error}'),
              backgroundColor: Colors.red,
            ),
          );
          // Reset after showing error
          ref.read(checkoutProvider.notifier).reset();
        });
      }
      return null;
    }, [checkoutState.isSuccess, checkoutState.error]);

    final validCategories = ticketEvent.categories
        .where((c) => c.name.trim().isNotEmpty)
        .toList();
    final validSessions = ticketEvent.sessions
        .where((s) => s.name.trim().isNotEmpty)
        .toList();

    // Auto-select category or session if there's only one
    useEffect(() {
      if (validCategories.length == 1 && selectedCategory.value == null) {
        selectedCategory.value = validCategories.first;
      }
      if (validSessions.length == 1 && selectedSession.value == null) {
        selectedSession.value = validSessions.first;
      }
      return null;
    }, [validCategories, validSessions]);

    final scrollController = useScrollController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScrollToHideNavbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.ticketsBookTicket,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorConstants.title,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                color: ColorConstants.background2.withValues(alpha: 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: ColorConstants.mainBorder.withValues(alpha: 0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          HeroIcon(
                            HeroIcons.ticket,
                            size: 20,
                            color: ColorConstants.main,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            ticketEvent.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: ColorConstants.onTertiary),
                          ),
                        ],
                      ),
                      if (validCategories.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          l10n.ticketsCategoryLabel,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: ColorConstants.secondary),
                        ),
                        const SizedBox(height: 8),
                        ...validCategories.map((category) {
                          final isSelected =
                              selectedCategory.value?.id == category.id;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () => selectedCategory.value = category,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ColorConstants.main.withValues(
                                          alpha: 0.1,
                                        )
                                      : ColorConstants.background2.withValues(
                                          alpha: 0.05,
                                        ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? ColorConstants.main
                                        : ColorConstants.mainBorder.withValues(
                                            alpha: 0.3,
                                          ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      size: 20,
                                      color: isSelected
                                          ? ColorConstants.main
                                          : ColorConstants.tertiary,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        category.name.trim(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ColorConstants.onTertiary,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      '${category.price}€',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: ColorConstants.main,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                      if (validSessions.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          l10n.ticketsSessionLabel,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: ColorConstants.secondary),
                        ),
                        const SizedBox(height: 8),
                        ...validSessions.map((session) {
                          final isSelected =
                              selectedSession.value?.id == session.id;
                          final sessionTime = timeFormat.format(
                            session.startDatetime,
                          );
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () => selectedSession.value = session,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ColorConstants.main.withValues(
                                          alpha: 0.1,
                                        )
                                      : ColorConstants.background2.withValues(
                                          alpha: 0.05,
                                        ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? ColorConstants.main
                                        : ColorConstants.mainBorder.withValues(
                                            alpha: 0.3,
                                          ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      size: 20,
                                      color: isSelected
                                          ? ColorConstants.main
                                          : ColorConstants.tertiary,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        '${session.name.trim()} - $sessionTime',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ColorConstants.onTertiary,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    if (session.quota != null &&
                                        session.quota! > 0)
                                      Text(
                                        '${session.quota} ${l10n.ticketsPlaces}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: ColorConstants.tertiary,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                      // Questions section
                      if (ticketEvent.questions
                          .where((q) => !q.disabled)
                          .isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          l10n.ticketsQuestions,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: ColorConstants.secondary),
                        ),
                        const SizedBox(height: 8),
                        ...ticketEvent.questions.where((q) => !q.disabled).map((
                          question,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _QuestionAnswerField(
                              question: question,
                              value: answersMap.value[question.id],
                              onChanged: (value) {
                                answersMap.value = {
                                  ...answersMap.value,
                                  question.id: value,
                                };
                              },
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Payment section - only show if price > 0
              if (selectedCategory.value != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.ticketsTotal,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorConstants.onTertiary,
                      ),
                    ),
                    Text(
                      '${selectedCategory.value!.price}€',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: ColorConstants.main,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Only show payment method if price > 0
                if (selectedCategory.value!.price > 0) ...[
                  Text(
                    l10n.ticketsPaymentMethod,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorConstants.secondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () =>
                              selectedPaymentProvider.value = 'helloasso',
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color:
                                  selectedPaymentProvider.value == 'helloasso'
                                  ? ColorConstants.main.withValues(alpha: 0.1)
                                  : ColorConstants.background2.withValues(
                                      alpha: 0.05,
                                    ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    selectedPaymentProvider.value == 'helloasso'
                                    ? ColorConstants.main
                                    : ColorConstants.mainBorder.withValues(
                                        alpha: 0.3,
                                      ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 28,
                                  child: SvgPicture.asset(
                                    'assets/images/helloasso.svg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'HelloAsso',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color:
                                            selectedPaymentProvider.value ==
                                                'helloasso'
                                            ? ColorConstants.main
                                            : ColorConstants.tertiary,
                                        fontWeight:
                                            selectedPaymentProvider.value ==
                                                'helloasso'
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Builder(
                        builder: (context) {
                          final canPayResult = canPayAsync.maybeWhen(
                            data: (result) => result,
                            orElse: () => null,
                          );
                          final canPayOk = canPayResult?.success ?? false;
                          final balanceInCents =
                              walletAsync.valueOrNull?.balance ?? 0;
                          final categoryPriceCents =
                              ((selectedCategory.value?.price ?? 0) * 100)
                                  .round();
                          final hasInsufficientBalance =
                              canPayOk && balanceInCents < categoryPriceCents;
                          final isDisabled =
                              !canPayOk || hasInsufficientBalance;
                          final isSelected =
                              selectedPaymentProvider.value == 'myempay';

                          // Auto-switch to helloasso if myempay is selected but can't pay
                          if (isDisabled && isSelected) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              selectedPaymentProvider.value = 'helloasso';
                            });
                          }

                          String? disabledReason;
                          if (!canPayOk && canPayResult != null) {
                            switch (canPayResult.error!) {
                              case CanPayError.tosNotAccepted:
                                disabledReason = l10n.paiementPleaseAcceptTOS;
                              case CanPayError.noDevice:
                                disabledReason =
                                    l10n.paiementDeviceNotRegistered;
                              case CanPayError.deviceInactive:
                                disabledReason =
                                    l10n.paiementDeviceNotActivated;
                              case CanPayError.deviceRevoked:
                                disabledReason = l10n.paiementDeviceRevoked;
                              case CanPayError.insufficientBalance:
                                disabledReason = l10n.paiementInsufficientFunds;
                            }
                          } else if (hasInsufficientBalance) {
                            disabledReason = l10n.paiementInsufficientFunds;
                          }

                          return Expanded(
                            child: InkWell(
                              onTap: isDisabled
                                  ? null
                                  : () => selectedPaymentProvider.value =
                                        'myempay',
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ColorConstants.main.withValues(
                                          alpha: 0.1,
                                        )
                                      : isDisabled
                                      ? ColorConstants.background2.withValues(
                                          alpha: 0.02,
                                        )
                                      : ColorConstants.background2.withValues(
                                          alpha: 0.05,
                                        ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? ColorConstants.main
                                        : isDisabled
                                        ? ColorConstants.mainBorder.withValues(
                                            alpha: 0.1,
                                          )
                                        : ColorConstants.mainBorder.withValues(
                                            alpha: 0.3,
                                          ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 28,
                                      child: Image.asset(
                                        'assets/images/logo_prod.png',
                                        fit: BoxFit.contain,
                                        color: isDisabled
                                            ? ColorConstants.tertiary
                                                  .withValues(alpha: 0.5)
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'myempay',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: isSelected
                                                ? ColorConstants.main
                                                : isDisabled
                                                ? ColorConstants.tertiary
                                                      .withValues(alpha: 0.5)
                                                : ColorConstants.tertiary,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                    ),
                                    if (disabledReason != null)
                                      Text(
                                        disabledReason,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: ColorConstants.error,
                                              fontSize: 10,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      checkoutState.isCreating ||
                          selectedCategory.value == null ||
                          (validSessions.isNotEmpty &&
                              selectedSession.value == null) ||
                          !areAllRequiredQuestionsAnswered()
                      ? null
                      : () async {
                          // Show navbar before navigating to payment
                          ref.read(navbarVisibilityProvider.notifier).show();
                          final notifier = ref.read(checkoutProvider.notifier);
                          await notifier.createCheckout(
                            checkout.value,
                            ticketEvent,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.main,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: ColorConstants.main.withValues(
                      alpha: 0.3,
                    ),
                  ),
                  child: checkoutState.isCreating
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          l10n.ticketsReserve,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              // Bottom safe area padding
              SafeArea(top: false, child: const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for displaying a question and its answer input field
class _QuestionAnswerField extends StatelessWidget {
  final Question question;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;

  const _QuestionAnswerField({
    required this.question,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRequired = question.required;
    final hasError =
        isRequired &&
        (value == null || (value is String && value.trim().isEmpty));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${question.question}${isRequired ? ' *' : ''}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: hasError ? ColorConstants.error : ColorConstants.onTertiary,
            fontWeight: isRequired ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        _buildAnswerInput(context, l10n, isRequired),
      ],
    );
  }

  Widget _buildAnswerInput(
    BuildContext context,
    AppLocalizations l10n,
    bool isRequired,
  ) {
    switch (question.answerType) {
      case AnswerType.boolean:
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onChanged(true),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: value == true
                        ? ColorConstants.main.withValues(alpha: 0.1)
                        : ColorConstants.background2.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: value == true
                          ? ColorConstants.main
                          : ColorConstants.mainBorder.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        value == true
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        size: 20,
                        color: value == true
                            ? ColorConstants.main
                            : ColorConstants.tertiary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.ticketsAnswerTypeBoolean.split('/').first.trim(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: value == true
                              ? ColorConstants.main
                              : ColorConstants.onTertiary,
                          fontWeight: value == true
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () => onChanged(false),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: value == false
                        ? ColorConstants.main.withValues(alpha: 0.1)
                        : ColorConstants.background2.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: value == false
                          ? ColorConstants.main
                          : ColorConstants.mainBorder.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        value == false
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        size: 20,
                        color: value == false
                            ? ColorConstants.main
                            : ColorConstants.tertiary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.ticketsAnswerTypeBoolean.split('/').last.trim(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: value == false
                              ? ColorConstants.main
                              : ColorConstants.onTertiary,
                          fontWeight: value == false
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );

      case AnswerType.number:
        return TextFormField(
          initialValue: value?.toString() ?? '',
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (val) {
            if (isRequired && (val == null || val.trim().isEmpty)) {
              return l10n.ticketsQuestionRequiredLabel;
            }
            if (val != null && val.isNotEmpty && num.tryParse(val) == null) {
              return l10n.toolInvalidNumber;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: l10n.ticketsAnswerTypeNumber,
            filled: true,
            fillColor: ColorConstants.background2.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ColorConstants.mainBorder.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ColorConstants.mainBorder.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: ColorConstants.main),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: ColorConstants.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: (val) => onChanged(val.isEmpty ? null : num.tryParse(val)),
        );

      case AnswerType.text:
        return TextFormField(
          initialValue: value?.toString() ?? '',
          maxLines: 2,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (val) {
            if (isRequired && (val == null || val.trim().isEmpty)) {
              return l10n.ticketsQuestionRequiredLabel;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: l10n.ticketsAnswerTypeText,
            filled: true,
            fillColor: ColorConstants.background2.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ColorConstants.mainBorder.withValues(alpha: 0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ColorConstants.mainBorder.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: ColorConstants.main),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: ColorConstants.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: onChanged,
        );
    }
  }
}
