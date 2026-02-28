import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/todo/class/todo.dart';
import 'package:titan/todo/providers/todo_list_provider.dart';
import 'package:titan/todo/providers/todo_provider.dart';
import 'package:titan/todo/ui/Todo.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class TodoAddEditPage extends HookConsumerWidget {
  const TodoAddEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider);
    final todoListNotifier = ref.watch(todoListProvider.notifier);
    final textController = TextEditingController(text: todo.description);
    return TodoTemplate(
      child: Column(
        children: [
          Text("Description"),
          TextEntry(label: "Description", controller: textController),
          WaitingButton(
            onTap: () async {
              if (todo.id != "") {
                await todoListNotifier.updateTodo(
                  todo.copyWith(description: textController.text),
                );
              } else {
                await todoListNotifier.createTodo(
                  Todo(id: "", userId: "", description: textController.text),
                );
              }
              QR.back();
            },
            builder: (child) => AddEditButtonLayout(
              colors: const [
                ColorConstants.gradient1,
                ColorConstants.gradient2,
              ],
              child: child,
            ),
            child: Text(todo.id != "" ? "Edit" : "Add"),
          ),
        ],
      ),
    );
  }
}
