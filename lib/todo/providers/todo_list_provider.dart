import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/todo/class/todo.dart';
import 'package:titan/todo/repositories/todo_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class TodoListNotifier extends ListNotifier<Todo> {
  final TodoRepository todoRepository = TodoRepository();
  AsyncValue<List<Todo>> todoList = const AsyncValue.loading();
  TodoListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    todoRepository.setToken(token);
  }

  Future<AsyncValue<List<Todo>>> loadTodos() async {
    return await loadList(todoRepository.loadTodoList);
  }

  Future<bool> createTodo(Todo todo) async {
    return await add(todoRepository.createTodo, todo);
  }

  Future<bool> updateTodo(Todo todo) async {
    return await update(
      todoRepository.updateTodo,
      (todos, todo) => todos..[todos.indexWhere((g) => g.id == todo.id)] = todo,
      todo,
    );
  }

  Future<bool> deleteTodo(Todo todo) async {
    return await delete(
      todoRepository.deleteTodo,
      (todos, todo) => todos..removeWhere((i) => i.id == todo.id),
      todo.id,
      todo,
    );
  }
}

final todoListProvider =
    StateNotifierProvider<TodoListNotifier, AsyncValue<List<Todo>>>((ref) {
      final token = ref.watch(tokenProvider);
      TodoListNotifier notifier = TodoListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadTodos();
      });
      return notifier;
    });
