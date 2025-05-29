class Voter {
  final String groupId;

  Voter({required this.groupId});

  Voter copyWith({String? groupId}) {
    return Voter(groupId: groupId ?? this.groupId);
  }

  Map<String, dynamic> toJson() {
    return {'group_id': groupId};
  }

  factory Voter.fromJson(Map<String, dynamic> map) {
    return Voter(groupId: map['group_id']);
  }

  factory Voter.empty() {
    return Voter(groupId: '');
  }

  @override
  String toString() => 'Voter(groupId: $groupId)';
}
