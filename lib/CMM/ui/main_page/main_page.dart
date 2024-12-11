import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/ui/cmm.dart';
import 'package:myecl/CMM/ui/main_page/cmm_card.dart';

class CMMMainPage extends ConsumerWidget {
  const CMMMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CMMTemplate(
      child: SingleChildScrollView(
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
