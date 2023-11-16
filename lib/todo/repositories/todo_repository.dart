import 'package:myecl/todo/class/todo.dart';
import 'package:myecl/tools/repository/repository.dart';

class TodoRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'todos/';

  Future<List<Todo>> getTodoList() async {
    return (await getList()).map((e) => Todo.fromJson(e)).toList();
  }

  Future<Todo> createTodo(Todo todo) async {
    return Todo.fromJson(await create(todo.toJson()));
  }

  Future<bool> checkTodo(Todo todo) async {
    return await create({}, suffix: "${todo.id}/check");
  }
}
