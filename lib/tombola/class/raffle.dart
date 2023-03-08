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
  late String? description;

  Raffle.fromJson(Map<String, dynamic> json){
    name = json['name'];
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    groupId = json['group_id'];
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['group_id'] = groupId;
    _data['id'] = id;
    _data['description'] = description;
    return _data;
  }

  Raffle.copyWith({
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? groupId,
    String? id,
  }) {
    this.name = name ?? this.name;
    this.startDate = startDate ?? this.startDate;
    this.endDate = endDate ?? this.endDate;
    this.groupId = groupId ?? this.groupId;
    this.id = id ?? this.id;
  }

  Raffle.empty() {
    name = '';
    startDate = DateTime.now();
    endDate = DateTime.now();
    groupId = '';
    id = '';
  }

  @override
  String toString() {
    return 'Raffle{name: $name, startDate: $startDate, endDate: $endDate, groupId: $groupId, id: $id}';
  }
  Raffle.copyWith({
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? groupId,
    String? id,
  }) {
    this.name = name ?? this.name;
    this.startDate = startDate ?? this.startDate;
    this.endDate = endDate ?? this.endDate;
    this.groupId = groupId ?? this.groupId;
    this.id = id ?? this.id;
  }

  Raffle.empty() {
    name = '';
    startDate = DateTime.now();
    endDate = DateTime.now();
    groupId = '';
    id = '';
  }

  @override
  String toString() {
    return 'Raffle{name: $name, startDate: $startDate, endDate: $endDate, groupId: $groupId, id: $id}';
  }
}
