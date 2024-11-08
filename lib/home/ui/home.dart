import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/modules_provider.dart';
import 'package:myecl/home/router.dart';
import 'package:myecl/home/ui/module_button.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class HomeTemplate extends HookConsumerWidget {
  final Widget child;
  const HomeTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(
            title: "Accueil",
            root: HomeRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moduleList = ref.watch(listModuleProvider);
    final ScrollController scrollController = useScrollController();
    return HomeTemplate(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: max(3, MediaQuery.of(context).size.width ~/ 200),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: moduleList.length,
          itemBuilder: (BuildContext gridContext, int index) =>
              ModuleUI(module: moduleList[index], size: 30),
        ),
      ),
    );
  }
}
