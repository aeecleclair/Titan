import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/providers/winning_ticket_list_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/admin_page/winning_ticket_card.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';

class WinningTicketHandler extends HookConsumerWidget {
  const WinningTicketHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winningTicketList = ref.watch(winningTicketListProvider);
    return Column(
      children: [
        const AlignLeftText(RaffleTextConstants.winningTickets,
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: RaffleColorConstants.textDark),
        const SizedBox(height: 10),
        SizedBox(
            height: 150,
            child: AsyncChild(
                value: winningTicketList,
                builder: (context, data) {
                  if (data.isEmpty) {
                    return const Text(RaffleTextConstants.noWinningTicketYet);
                  }
                  return HorizontalListView.builder(
                      items: data,
                      itemBuilder: (context, item, i) =>
                          WinningTicketUI(ticket: item));
                },
                loaderColor: RaffleColorConstants.gradient2)),
      ],
    );
  }
}
