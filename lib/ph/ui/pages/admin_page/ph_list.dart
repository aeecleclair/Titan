import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/ui/pages/admin_page/ph_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class PhList extends HookConsumerWidget {
  const PhList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phList = ref.watch(phListProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: AsyncChild(
          value: phList,
          builder: (context, phList) {
            return Row(children: phList.map((ph) => PhCard(ph: ph)).toList());
          }),
    );
  }
}
