import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/providers/my_cmm_list_providers.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class MyCMMList extends HookConsumerWidget {
  const MyCMMList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCMMList = ref.watch(myCMMListProvider);

    return AsyncChild(
      value: myCMMList,
      builder: (context, myCMMList) {
        myCMMList.sort((a, b) => b.date.compareTo(a.date));
        return Column(
          children: myCMMList.map((cmm) {
            return CMMCard(
              string: cmm.path,
              user: cmm.user,
              vote: cmm.vote,
              score: cmm.score,
            );
          }).toList(),
        );
      },
    );
  }
}
