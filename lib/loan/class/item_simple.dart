class ItemSimple {
  ItemSimple({
    required this.id,
    required this.name,
    required this.loanerId,
  });

  late final String id;
  late final String name;
  late final String loanerId;

  ItemSimple.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    loanerId = json['loaner_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['loaner_id'] = loanerId;
    return data;
  }

  ItemSimple copyWith({
    id,
    name,
    loanerId,
  }) {
    return ItemSimple(
      id: id ?? this.id,
      name: name ?? this.name,
      loanerId: loanerId ?? this.loanerId,
    );
  }

  ItemSimple.empty() {
    id = '';
    name = '';
    loanerId = '';
  }

  @override
  String toString() {
    return 'ItemSimple(id: $id, name: $name, loanerId: $loanerId)';
  }
}