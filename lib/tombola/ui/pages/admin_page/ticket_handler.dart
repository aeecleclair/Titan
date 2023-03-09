import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/admin_page/ticket_ui.dart';

class TicketHandler extends HookConsumerWidget {
  const TicketHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final tickets = ref.watch(typeTicketsListProvider);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text("Tickets",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: TombolaColorConstants.textDark)),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
                height: 110,
              ),
              GestureDetector(
                  onTap: () {
                    pageNotifier.setTombolaPage(TombolaPage.addEditTypeTicket);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(12.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color:
                              TombolaColorConstants.textDark.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: HeroIcon(
                        HeroIcons.plus,
                        color: TombolaColorConstants.textDark,
                        size: 50,
                      ),
                    ),
                  )),
              tickets.when(
                data: (data) {
                  return Row(
                      children: data
                          .map((e) => TicketUI(
                                typeTicket: e,
                              ))
                          .toList());
                },
                error: (Object e, StackTrace? s) =>
                    Text("Error: ${e.toString()}"),
                loading: () => const CircularProgressIndicator(
                  color: TombolaColorConstants.gradient2,
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
