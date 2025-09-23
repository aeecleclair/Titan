import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/centralassos/ui/centralassos.dart';
import 'package:myecl/centralassos/providers/centralassos_asso_provider.dart';
import 'package:myecl/centralassos/ui/pages/asso_list.dart';

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
            children: [
              ...assos.map<Widget>((asso) => AssoList(asso: asso)),
            ],
          ),
        ),
      ),
    );
  }
}
