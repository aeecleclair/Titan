import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';

class SharerGroupDetailPage extends HookConsumerWidget {
  const SharerGroupDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroup = ref.watch(sharerGroupProvider);
    return TricountTemplate(child: Refresher(
      onRefresh:() async {},
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200
            ),
            PageView(
              children: [
              ]
            )
          ],
        ),
      ),
    ));
  }
}
