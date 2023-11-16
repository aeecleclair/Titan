import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/todo/providers/todo_list_provider.dart';
import 'package:myecl/todo/ui/pages/todo.dart';

class TodoMainPage extends HookConsumerWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return TodoTemplate(child: Container());
  }
}
