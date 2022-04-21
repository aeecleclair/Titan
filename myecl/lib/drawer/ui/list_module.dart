import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/providers/modules_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/ui/module.dart';

class ListModule extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const ListModule({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(listModuleProvider);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: modules
            .map((m) => ModuleUI(m: m, controllerNotifier: controllerNotifier))
            .toList(),
      ),
    );
  }
}
