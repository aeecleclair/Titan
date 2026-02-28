import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/todo/class/todo.dart';
import 'package:titan/todo/providers/todo_list_provider.dart';
import 'package:titan/todo/providers/todo_provider.dart';
import 'package:titan/todo/router.dart';
import 'package:titan/todo/ui/Todo.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/button.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';

class TodoMainPage extends HookConsumerWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final todoListNotifier = ref.watch(todoListProvider.notifier);
    final todoNotifier = ref.watch(todoProvider.notifier);

    return TodoTemplate(
      child: Refresher(
        onRefresh: () {
          return todoListNotifier.loadTodos();
        },
        child: AsyncChild(
          value: todoList,
          builder: (context, syncTodoList) {
            return Column(
              children: [
                Button(
                  text: "+",
                  onPressed: () {
                    todoNotifier.setTodo(Todo.empty());
                    QR.to(TodoRouter.root + TodoRouter.addEdit);
                  },
                ),
                ...syncTodoList.map(
                  (todo) => GestureDetector(
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          todo.description,
                          style: TextStyle(color: Colors.black),
                        ),
                        Spacer(),
                        Checkbox(value: false, onChanged: (_) {}),
                      ],
                    ),
                    onTap: () {
                      todoNotifier.setTodo(todo);
                      QR.to(TodoRouter.root + TodoRouter.addEdit);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
