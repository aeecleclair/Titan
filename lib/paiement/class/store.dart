enum AvailableAssociationMembership { AEECL, USEECL }

class Store {
  final String id;
  final String name;
  final String walletId;
  final AvailableAssociationMembership membership;

  Store({
    required this.id,
    required this.name,
    required this.walletId,
    required this.membership,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      walletId: json['wallet_id'],
      membership: json['membership'] == 'aeecl'
          ? AvailableAssociationMembership.AEECL
          : AvailableAssociationMembership.USEECL,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'wallet_id': walletId,
      'membership': membership.name,
    };
  }

  Store copyWith({
    String? id,
    String? name,
    String? walletId,
    AvailableAssociationMembership? membership,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      walletId: walletId ?? this.walletId,
      membership: membership ?? this.membership,
    );
  }

  @override
  String toString() {
    return 'Store(id: $id, name: $name, walletId: $walletId, membership: $membership)';
  }

  Store.empty()
      : this(
          id: '',
          name: '',
          walletId: '',
          membership: AvailableAssociationMembership.AEECL,
        );
}
