class Action {
  late final String module;
  late final String table;

  Action({
    required this.module,
    required this.table,
  });

  Action.fromJson(Map<String, dynamic> json) {
    module = json['module'];
    table = json['table'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['module'] = module;
    data['table'] = table;
    return data;
  }

  @override
  String toString() {
    return 'Action{module: $module, table: $table}';
  }

  Action.empty() {
    module = '';
    table = '';
  }
}