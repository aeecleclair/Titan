import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/todo/providers/todo_list_provider.dart';
import 'package:myecl/todo/tools/constants.dart';
import 'package:myecl/todo/ui/pages/main_page/todo_card.dart';
import 'package:myecl/todo/ui/pages/todo.dart';

class TodoMainPage extends HookConsumerWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return TodoTemplate(
        child: Padding(
      padding: const EdgeInsets.only(right: 30, top: 30, left: 30),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              TodoTextConstants.todoList,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...todos.when(
              data: (todos) => todos
                  .map((todo) => TodoCard(todo: todo)),
              loading: () => [const CircularProgressIndicator()],
              error: (error, stack) => [Text(error.toString())])
        ],
      ),
    ));
  }
}
