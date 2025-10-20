import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/centralassociation/ui/centralassociation.dart';
import 'package:titan/centralassociation/providers/centralassociation_asso_provider.dart';
import 'package:titan/centralassociation/ui/pages/asso_list.dart';

class CentralassociationMainPage extends HookConsumerWidget {
  const CentralassociationMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assos = ref.watch(assoProvider);

    return CentralassociationTemplate(
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
