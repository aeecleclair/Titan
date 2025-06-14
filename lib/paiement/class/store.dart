import 'package:titan/paiement/class/structure.dart';

class Store {
  final String id;
  final String name;
  final String walletId;
  final Structure structure;

  Store({
    required this.id,
    required this.name,
    required this.walletId,
    required this.structure,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      walletId: json['wallet_id'],
      structure: Structure.fromJson(json['structure']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'wallet_id': walletId,
      'structure': structure.toJson(),
    };
  }

  Store copyWith({
    String? id,
    String? name,
    String? walletId,
    Structure? structure,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      walletId: walletId ?? this.walletId,
      structure: structure ?? this.structure,
    );
  }

  @override
  String toString() {
    return 'Store(id: $id, name: $name, walletId: $walletId, structure: $structure)';
  }

  Store.empty()
    : this(id: '', name: '', walletId: '', structure: Structure.empty());
}
