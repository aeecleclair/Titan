class Todo {
  late final String id;
  late final String userId;
  late final String description;
  late final bool done;

  Todo({
    required this.id,
    required this.userId,
    required this.description,
    this.done = false,
  });

  Todo copyWith({String? id, String? userId, String? description, bool? done}) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'description': description,
      'done': done,
    };
  }

  Todo.empty() : id = '', userId = '', description = '', done = false;

  @override
  String toString() {
    return 'Todo{id: $id, userId: $userId, description: $description, done: $done}';
  }
}
