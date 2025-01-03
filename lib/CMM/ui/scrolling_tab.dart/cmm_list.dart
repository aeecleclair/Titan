import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/CMM/providers/sorting_bar_provider.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';
import 'package:myecl/CMM/ui/components/sorting_bar.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class CMMList extends HookConsumerWidget {
  const CMMList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmmList = ref.watch(cmmListProvider);
    final selected = ref.watch(selectedSortingTypeProvider);

    return Column(
      children: [
        const SortingBar(),
        AsyncChild(
          value: cmmList,
          builder: (context, cmmList) {
            cmmList.sort((a, b) => b.date.compareTo(a.date));
            return Column(
              children: cmmList.map((cmm) {
                return CMMCard(
                  string: cmm.path,
                  user: cmm.user,
                  vote: cmm.vote,
                  score: cmm.score,
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
