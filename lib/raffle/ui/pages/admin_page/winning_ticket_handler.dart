import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/providers/winning_ticket_list_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/admin_page/winning_ticket_card.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';

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
          child: const Text("Tickets gagnants",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RaffleColorConstants.textDark)),
        ),
        const SizedBox(
          height: 10,
        ),
        HorizontalListView(
          child: Row(
            children: [
              const SizedBox(
                width: 15,
                height: 125,
              ),
              winningTicketList.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const SizedBox(
                        height: 150,
                        child:
                            Text("Les tickets gagnants seront affichés ici"));
                  }
                  return Row(
                      children: data
                          .map((e) => WinningTicketUI(
                                ticket: e,
                                onEdit: () {},
                                onDelete: () async {},
                              ))
                          .toList());
                },
                error: (Object e, StackTrace? s) => SizedBox(
                    height: 150, child: Text("Error: ${e.toString()}")),
                loading: () => const SizedBox(
                  height: 150,
                  child: CircularProgressIndicator(
                    color: RaffleColorConstants.gradient2,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
