import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/todo/tools/constants.dart';
import 'package:myecl/todo/ui/pages/add_edit_todo_page/text_entry.dart';
import 'package:myecl/todo/ui/pages/todo.dart';

class AddEditTodoPage extends HookConsumerWidget {
  const AddEditTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final name = useTextEditingController();
    return TodoTemplate(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.only(right: 30, top: 30, left: 30),
                child: Form(
                  key: formKey,
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
                      TextEntry(
                        controller: name,
                        isInt: false,
                        keyboardType: TextInputType.text,
                        label: "Name",
                        suffix: "",
                      )
                    ],
                  ),
                ))));
  }
}
