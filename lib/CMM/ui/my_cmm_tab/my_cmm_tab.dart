import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';
import 'package:myecl/CMM/ui/my_cmm_tab/my_cmm_tab%20copy.dart';

class MyCMMTab extends HookWidget {
  const MyCMMTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CMMCard(string: "assets/images/cmm.jpg"),
        CMMCard(string: "assets/images/cmm2.jpg"),
        CMMImagePicker(),
      ],
    );
  }
}
