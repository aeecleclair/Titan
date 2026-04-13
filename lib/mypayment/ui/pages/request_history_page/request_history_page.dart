import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/payment_request.dart';
import 'package:titan/mypayment/providers/request_history_provider.dart';
import 'package:titan/mypayment/ui/components/request_card.dart';
import 'package:titan/mypayment/ui/components/request_detail_modal.dart';
import 'package:titan/mypayment/ui/components/show_request_modal.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/mypayment/ui/pages/main_page/account_card/day_divider.dart';
import 'package:titan/mypayment/ui/mypayment.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestHistoryPage extends HookConsumerWidget {
  const RequestHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestHistory = ref.watch(requestHistoryProvider);
    final requestHistoryNotifier = ref.read(requestHistoryProvider.notifier);
    final localizeWithContext = AppLocalizations.of(context)!;

    useEffect(() {
      final timers = <Timer>[];
      requestHistory.whenData((requests) {
        final now = DateTime.now();
        for (final request in requests) {
          if (request.status != RequestStatus.proposed) continue;
          final expiresAt = request.creation.add(const Duration(minutes: 15));
          final remaining = expiresAt.difference(now);
          if (remaining.isNegative) continue;
          timers.add(
            Timer(remaining, () => requestHistoryNotifier.getRequestHistory()),
          );
        }
      });
      return () {
        for (final timer in timers) {
          timer.cancel();
        }
      };
    }, [requestHistory]);

    final scrollController = useMemoized(() => ScrollController(), []);

    return PaymentTemplate(
      child: Refresher(
        controller: scrollController,
        onRefresh: () async {
          await requestHistoryNotifier.getRequestHistory();
        },
        child: AsyncChild(
          value: requestHistory,
          builder: (context, requests) {
            if (requests.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  localizeWithContext.paiementNoRequests,
                  style: const TextStyle(
                    color: Color(0xff204550),
                    fontSize: 16,
                  ),
                ),
              );
            }
            final sortedRequests = List<PaymentRequest>.from(requests)
              ..sort((a, b) => b.creation.compareTo(a.creation));

            final Map<String, List<PaymentRequest>> groupedByDay = {};
            final Map<String, DateTime> stringDate = {};
            for (var request in sortedRequests) {
              final day = timeago.format(request.creation, locale: 'fr_short');
              if (groupedByDay[day] == null) {
                groupedByDay[day] = [];
                stringDate[day] = request.creation;
              }
              groupedByDay[day]!.add(request);
            }
            final sortedKeys = stringDate.keys.toList()
              ..sort((a, b) => stringDate[b]!.compareTo(stringDate[a]!));

            return Column(
              children: [
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localizeWithContext.paiementRequestHistory,
                    style: const TextStyle(
                      color: Color(0xff204550),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                for (var day in sortedKeys) ...[
                  DayDivider(date: day),
                  for (var request in groupedByDay[day]!)
                    RequestCard(
                      request: request,
                      onTap: request.status == RequestStatus.proposed
                          ? () async {
                              await showRequestModal(
                                context: context,
                                ref: ref,
                                request: request,
                              );
                              await requestHistoryNotifier.getRequestHistory();
                            }
                          : () => showCustomBottomModal(
                              context: context,
                              ref: ref,
                              modal: RequestDetailModal(request: request),
                            ),
                    ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
