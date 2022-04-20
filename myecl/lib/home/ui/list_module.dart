import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/providers/modules_provider.dart';
import 'package:myecl/home/ui/module.dart';

class ListModule extends ConsumerWidget {
  const ListModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(listModuleProvider);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: modules.map((m) => ModuleUI(m: m)).toList(),
      ),
    );
  }
}
