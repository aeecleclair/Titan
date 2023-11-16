import 'package:flutter/material.dart';
import 'package:myecl/todo/tools/constants.dart';
import 'package:myecl/todo/ui/pages/todo.dart';

class AddEditTodoPage extends StatelessWidget {
  const AddEditTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoTemplate(
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                  ],
                ))));
  }
}
