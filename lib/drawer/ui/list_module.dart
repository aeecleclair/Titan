import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/modules_provider.dart';
import 'package:myecl/drawer/ui/module.dart';
import 'package:myecl/home/router.dart';

class ListModule extends HookConsumerWidget {
  const ListModule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = [HomeRouter.module] + ref.watch(listModuleProvider);
    final scrollController = useScrollController();
    return Scrollbar(
      controller: scrollController,
      interactive: true,
      radius: const Radius.circular(8),
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: modules.map((module) => ModuleUI(module: module)).toList(),
        ),
      ),
    );
  }
}
