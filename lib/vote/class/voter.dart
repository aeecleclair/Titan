class Voter {
  final String id;
  final String groupId;

  Voter({
    required this.id,
    required this.groupId,
  });

  Voter copyWith({
    String? id,
    String? groupId,
  }) {
    return Voter(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
    };
  }

  factory Voter.fromJson(Map<String, dynamic> map) {
    return Voter(
      id: map['id'],
      groupId: map['group_id'],
    );
  }

  factory Voter.empty() {
    return Voter(
      id: '',
      groupId: '',
    );
  }

  @override
  String toString() => 'Voter(id: $id, groupId: $groupId)';
}