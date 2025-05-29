class AssociationKinds {
  AssociationKinds({required this.kinds});

  late final List<String> kinds;

  AssociationKinds.fromJson(Map<String, dynamic> json) {
    kinds = json['kinds'].map<String>((dynamic tag) => tag.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'kinds': kinds};
    return data;
  }

  AssociationKinds empty() {
    return AssociationKinds(kinds: []);
  }

  @override
  String toString() {
    return 'AssociationKinds(kinds: $kinds)';
  }
}
