import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/todo/class/todo.dart';
import 'package:myecl/todo/repositories/todo_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TodoNotifier extends ListNotifier<Todo> {
  final repository = TodoRepository();
  TodoNotifier(String token) : super(const AsyncLoading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Todo>>> loadTodoList() async {
    return await loadList(() async => repository.getTodoList());
  }

  Future<bool> addTodo(Todo todo) async {
    return await add(repository.createTodo, todo);
  }

  Future<bool> checkTodo(Todo todo) async {
    return await update(
        repository.checkTodo,
        (todos, todo) =>
            todos..[todos.indexWhere((i) => i.id == todo.id)] = todo,
        todo);
  }
}

final todoListProvider =
    StateNotifierProvider<TodoNotifier, AsyncValue<List<Todo>>>((ref) {
  final token = ref.watch(tokenProvider);
  TodoNotifier notifier = TodoNotifier(token);
  notifier.loadTodoList();
  return notifier;
});
