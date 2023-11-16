import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/todo/class/todo.dart';
import 'package:myecl/todo/providers/todo_list_provider.dart';
import 'package:myecl/tools/functions.dart';

class TodoCard extends HookConsumerWidget {
  final Todo todo;
  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        trailing: Checkbox(
          value: todo.done,
          onChanged: (value) {},
        ),
        title: Text(todo.name),
        subtitle: Text(todo.deadline != null ? processDate(todo.deadline!) : ""),
      ),
    );
  }
}
