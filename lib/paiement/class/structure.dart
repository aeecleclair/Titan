class Structure {
  final String name;
  final String membership;
  final String id;
  final String managerUserId;

  Structure({
    required this.name,
    required this.membership,
    required this.id,
    required this.managerUserId,
  });

  Structure.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        membership = json['membership'],
        id = json['id'],
        managerUserId = json['manager_user_id'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'membership': membership,
      'id': id,
      'manager_user_id': managerUserId,
    };
  }

  @override
  String toString() {
    return 'Structure{name: $name, membership: $membership, id: $id, managerUserId: $managerUserId}';
  }

  Structure copyWith({
    String? name,
    String? membership,
    String? id,
    String? managerUserId,
  }) {
    return Structure(
      name: name ?? this.name,
      membership: membership ?? this.membership,
      id: id ?? this.id,
      managerUserId: managerUserId ?? this.managerUserId,
    );
  }

  Structure.empty()
      : this(name: '', membership: '', id: '', managerUserId: '');
}