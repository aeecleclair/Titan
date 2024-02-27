import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/todo/class/todo.dart';
import 'package:myecl/todo/providers/todo_list_provider.dart';
import 'package:myecl/todo/tools/constants.dart';
import 'package:myecl/todo/ui/pages/add_edit_todo_page/date_entry.dart';
import 'package:myecl/todo/ui/pages/add_edit_todo_page/text_entry.dart';
import 'package:myecl/todo/ui/pages/todo.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditTodoPage extends HookConsumerWidget {
  const AddEditTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListNotifier = ref.read(todoListProvider.notifier);
    final formKey = GlobalKey<FormState>();
    final name = useTextEditingController();
    final deadline = useTextEditingController();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
                      ),
                      const SizedBox(height: 30),
                      DateEntry(
                        controller: deadline,
                        title: "Deadline",
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            final newTodo = Todo(
                                id: "",
                                name: name.text,
                                deadline: deadline.text.isNotEmpty
                                    ? DateTime.parse(processDateBack(deadline.text))
                                    : null,
                                done: false,
                                creation: DateTime.now());
                            tokenExpireWrapper(ref, () async {
                              final value =
                                  await todoListNotifier.addTodo(newTodo);
                              if (value) {
                                QR.back();
                                displayToastWithContext(
                                    TypeMsg.msg, TodoTextConstants.addedTodo);
                              } else {
                                displayToastWithContext(
                                    TypeMsg.error, TodoTextConstants.error);
                              }
                            });
                          }
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
                          child: const Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
