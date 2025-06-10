import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/providers/ph_list_provider.dart';
import 'package:titan/ph/providers/selected_year_list_provider.dart';
import 'package:titan/ph/ui/components/year_bar.dart';
import 'package:titan/ph/ui/pages/past_ph_selection_page/ph_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class PhList extends HookConsumerWidget {
  const PhList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phList = ref.watch(phListProvider);
    final selectedYear = ref.watch(selectedYearListProvider);

    return AsyncChild(
      value: phList,
      builder: (context, phList) {
        final list = phList
            .where(
              (ph) =>
                  selectedYear.contains(ph.date.year) &&
                  ph.date.isBefore(DateTime.now()),
            )
            .toList();
        list.sort((a, b) => b.date.compareTo(a.date));
        return Column(
          children: [
            const YearBar(),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                childAspectRatio: 0.72,
                crossAxisCount: kIsWeb ? 5 : 2,
                children: list.map((ph) {
                  return PhCard(ph: ph);
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
