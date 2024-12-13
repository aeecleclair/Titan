import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/ui/cmm.dart';
import 'package:myecl/CMM/ui/scrolling_tab.dart/cmm_card.dart';

class ScrollingTab extends ConsumerWidget {
  const ScrollingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            CMMCard(string: "assets/images/cmm.jpg"),
            CMMCard(string: "assets/images/cmm2.jpg")
          ],
        ),
      ),
    );
  }
}
