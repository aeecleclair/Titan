import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/todo/class/todo.dart';

class TodoNotifier extends Notifier<Todo> {
  @override
  Todo build() {
    return Todo.empty();
  }

  void setTodo(Todo todo) {
    state = todo;
  }
}

final todoProvider = NotifierProvider<TodoNotifier, Todo>(() {
  return TodoNotifier();
});
