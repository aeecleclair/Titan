import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/modules_provider.dart';
import 'package:myecl/home/ui/module_button.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moduleList = ref.watch(listModuleProvider);
    final ScrollController scrollController = useScrollController();

    return Container(
      color: Colors.white,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: moduleList.length,
        itemBuilder: (BuildContext gridContext, int index) =>
            ModuleUI(module: moduleList[index]),
      ),
    );
  }
}
