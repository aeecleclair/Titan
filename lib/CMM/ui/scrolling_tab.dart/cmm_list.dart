import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/user/class/list_users.dart';

class CMMList extends HookConsumerWidget {
  const CMMList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmmList = ref.watch(cmmListProvider);

    return AsyncChild(
      value: cmmList,
      builder: (context, cmmList) {
        cmmList.sort((a, b) => b.date.compareTo(a.date));
        return Column(
          children: cmmList.map((cmm) {
            return CMMCard(
              string: cmm.path,
              user: cmm.user,
            );
          }).toList(),
        );
      },
    );
  }
}
