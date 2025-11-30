import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/ui/pages/transfer_structure_page/search_result.dart';
import 'package:titan/mypayment/ui/mypayment.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class TransferStructurePage extends HookConsumerWidget {
  const TransferStructurePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final queryController = useTextEditingController();
    return PaymentTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          children: [
            StyledSearchBar(
              label: "Prochain responsable",
              color: Color.fromARGB(255, 6, 75, 75),
              padding: const EdgeInsets.all(0),
              editingController: queryController,
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  await usersNotifier.filterUsers(value);
                } else {
                  usersNotifier.clear();
                }
              },
              suffixIcon: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 6, 75, 75),
                        Color.fromARGB(255, 0, 29, 29),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(
                          255,
                          0,
                          29,
                          29,
                        ).withValues(alpha: 0.2),
                        offset: const Offset(2, 3),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: HeroIcon(
                    HeroIcons.plus,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SearchResult(),
          ],
        ),
      ),
    );
  }
}
