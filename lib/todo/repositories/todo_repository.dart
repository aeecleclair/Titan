import 'package:titan/todo/class/todo.dart';
import 'package:titan/tools/repository/repository.dart';

class TodoRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "todo/todos/";

  Future<List<Todo>> loadTodoList() async {
    return List<Todo>.from(
      (await getList()).map((json) => Todo.fromJson(json)),
    );
  }

  Future<Todo> createTodo(Todo todo) async {
    return Todo.fromJson(await create(todo.toJson()));
  }

  Future<bool> updateTodo(Todo todo) async {
    return await update(todo.toJson(), todo.id);
  }

  Future<bool> deleteTodo(String todoId) async {
    return await delete(todoId);
  }
}
