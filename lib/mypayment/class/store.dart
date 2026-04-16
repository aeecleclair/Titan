import 'package:titan/admin/class/assocation.dart';
import 'package:titan/mypayment/class/structure.dart';

class StoreSimple {
  final String id;
  final String name;
  final String walletId;

  StoreSimple({required this.id, required this.name, required this.walletId});

  factory StoreSimple.fromJson(Map<String, dynamic> json) {
    return StoreSimple(
      id: json['id'],
      name: json['name'],
      walletId: json['wallet_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'wallet_id': walletId};
  }

  @override
  String toString() {
    return 'StoreSimple(id: $id, name: $name, walletId: $walletId)';
  }
}

class Store extends StoreSimple {
  final Structure structure;
  final Association association;

  Store({
    required super.id,
    required super.name,
    required super.walletId,
    required this.structure,
    required this.association,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      walletId: json['wallet_id'],
      structure: Structure.fromJson(json['structure']),
      association: json['association'] != null
          ? Association.fromJson(json['association'])
          : Association.empty(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'wallet_id': walletId,
      'structure': structure.toJson(),
      'association_id': association.id.isNotEmpty ? association.id : null,
    };
  }

  Store copyWith({
    String? id,
    String? name,
    String? walletId,
    Structure? structure,
    Association? association,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      walletId: walletId ?? this.walletId,
      structure: structure ?? this.structure,
      association: association ?? this.association,
    );
  }

  @override
  String toString() {
    return 'Store(id: $id, name: $name, walletId: $walletId, structure: $structure, association: $association)';
  }

  Store.empty()
    : this(
        id: '',
        name: '',
        walletId: '',
        structure: Structure.empty(),
        association: Association.empty(),
      );
}
