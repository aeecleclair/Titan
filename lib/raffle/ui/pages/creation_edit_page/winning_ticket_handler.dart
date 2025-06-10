import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/providers/winning_ticket_list_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/creation_edit_page/winning_ticket_card.dart';

class WinningTicketHandler extends HookConsumerWidget {
  const WinningTicketHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winningTicketList = ref.watch(winningTicketListProvider);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Tickets gagnants",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RaffleColorConstants.textDark,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              const SizedBox(width: 15, height: 125),
              winningTicketList.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const SizedBox(
                      height: 150,
                      child: Text("Il n'y a pas de ticket gagnant"),
                    );
                  }
                  return Row(
                    children: data
                        .map(
                          (e) => WinningTicketUI(
                            ticket: e,
                            onEdit: () {},
                            onDelete: () async {},
                          ),
                        )
                        .toList(),
                  );
                },
                error: (Object e, StackTrace? s) => SizedBox(
                  height: 150,
                  child: Text("Error: ${e.toString()}"),
                ),
                loading: () => const SizedBox(
                  height: 150,
                  child: CircularProgressIndicator(
                    color: RaffleColorConstants.gradient2,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}
