class Raffle {
  Raffle({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.groupId,
    required this.id,
  });
  late final String name;
  late final DateTime startDate;
  late final DateTime endDate;
  late final String groupId;
  late final String id;

  Raffle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    groupId = json['group_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['group_id'] = groupId;
    data['id'] = id;
    return data;
  }
}
