import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/todo/router.dart';
import 'package:titan/todo/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class TodoTemplate extends HookConsumerWidget {
  final Widget child;
  const TodoTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(title: TodoTextConstants.todo, root: TodoRouter.root),
          Expanded(child: child),
        ],
      ),
    );
  }
}
