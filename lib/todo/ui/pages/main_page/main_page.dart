import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/todo/providers/todo_list_provider.dart';
import 'package:myecl/todo/tools/constants.dart';
import 'package:myecl/todo/ui/pages/main_page/todo_card.dart';
import 'package:myecl/todo/ui/pages/todo.dart';
import 'package:myecl/todo/ui/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

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
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              QR.to(TodoRouter.root + TodoRouter.addEdit);
            },
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 70,
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
                child: const HeroIcon(HeroIcons.plus, size: 30)),
          ),
          ...todos.when(
              data: (todos) {
                if (todos.isEmpty) {
                  return const [
                    SizedBox(height: 20),
                    Text(TodoTextConstants.noTodo)
                  ];
                }
                return todos.map((todo) => TodoCard(todo: todo));
              },
              loading: () => [const CircularProgressIndicator()],
              error: (error, stack) => [Text(error.toString())])
        ],
      ),
    ));
  }
}
