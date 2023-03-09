class Raffle {
  Raffle({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.groupId,
    required this.id,
    this.description,
  });
  late final String name;
  late final DateTime startDate;
  late final DateTime endDate;
  late final String groupId;
  late final String id;
  late final String? description;

  Raffle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    groupId = json['group_id'];
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['group_id'] = groupId;
    data['id'] = id;
    data['description'] = description;
    return data;
  }

  Raffle copyWith({
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? groupId,
    String? id,
    String? description,
  }) =>
      Raffle(
          name: name ?? this.name,
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          groupId: groupId ?? this.groupId,
          id: id ?? this.id,
          description: description);

  Raffle.empty() {
    name = '';
    startDate = DateTime.now();
    endDate = DateTime.now();
    groupId = '';
    id = '';
    description = '';
  }

  @override
  String toString() {
    return 'Raffle{name: $name, startDate: $startDate, endDate: $endDate, groupId: $groupId, id: $id, description: $description}';
  }
}
