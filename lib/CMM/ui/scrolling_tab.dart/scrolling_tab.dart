import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/ui/scrolling_tab.dart/cmm_list.dart';

class ScrollingTab extends ConsumerWidget {
  const ScrollingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: CMMList(),
    );
  }
}
