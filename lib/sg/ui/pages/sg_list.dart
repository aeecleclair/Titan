import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/Sg/providers/Sg_list_provider.dart';
import 'package:myecl/sg/ui/pages/sg_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class SgList extends HookConsumerWidget {
  const SgList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sgList = ref.watch(sgListProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AsyncChild(
        value: sgList,
        builder: (context, sgList) {
          return Column(
            children: sgList
                .map(
                  (sg) => SgCard(
                    sg: sg,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
