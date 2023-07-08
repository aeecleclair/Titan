import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';

class EloCapsMainPage extends HookConsumerWidget {
  const EloCapsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElocapsTemplate(
        child: Column(
      children: [Text("Bonjour")],
    ));
  }
}
