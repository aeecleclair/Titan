import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/centralassos/ui/centralassos.dart';
import 'package:titan/centralassos/providers/centralassos_asso_provider.dart';
import 'package:titan/centralassos/ui/pages/asso_list.dart';

class CentralassosMainPage extends HookConsumerWidget {
  const CentralassosMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assos = ref.watch(assoProvider);

    return CentralassosTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AsyncChild(
          value: assos,
          builder: (context, assos) => Column(
            children: [...assos.map<Widget>((asso) => AssoList(asso: asso))],
          ),
        ),
      ),
    );
  }
}
