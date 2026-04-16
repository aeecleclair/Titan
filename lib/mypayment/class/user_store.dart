import 'package:titan/mypayment/class/structure.dart';

class UserStore {
  final String id;
  final String name;
  final String walletId;
  final Structure structure;
  final String? associationId;
  final bool canBank;
  final bool canSeeHistory;
  final bool canCancel;
  final bool canManageSellers;

  UserStore({
    required this.id,
    required this.name,
    required this.walletId,
    required this.structure,
    this.associationId,
    required this.canBank,
    required this.canSeeHistory,
    required this.canCancel,
    required this.canManageSellers,
  });

  factory UserStore.fromJson(Map<String, dynamic> json) {
    return UserStore(
      id: json['id'],
      name: json['name'],
      walletId: json['wallet_id'],
      structure: Structure.fromJson(json['structure']),
      associationId: json['association_id'],
      canBank: json['can_bank'],
      canSeeHistory: json['can_see_history'],
      canCancel: json['can_cancel'],
      canManageSellers: json['can_manage_sellers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'wallet_id': walletId,
      'structure': structure.toJson(),
      'association_id': associationId,
      'can_bank': canBank,
      'can_see_history': canSeeHistory,
      'can_cancel': canCancel,
      'can_manage_sellers': canManageSellers,
    };
  }

  UserStore copyWith({
    String? id,
    String? name,
    String? walletId,
    Structure? structure,
    String? associationId,
    bool? canBank,
    bool? canSeeHistory,
    bool? canCancel,
    bool? canManageSellers,
  }) {
    return UserStore(
      id: id ?? this.id,
      name: name ?? this.name,
      walletId: walletId ?? this.walletId,
      structure: structure ?? this.structure,
      associationId: associationId ?? this.associationId,
      canBank: canBank ?? this.canBank,
      canSeeHistory: canSeeHistory ?? this.canSeeHistory,
      canCancel: canCancel ?? this.canCancel,
      canManageSellers: canManageSellers ?? this.canManageSellers,
    );
  }

  @override
  String toString() {
    return 'UserStore(id: $id, name: $name, walletId: $walletId, structure: $structure, associationId: $associationId, canBank: $canBank, canSeeHistory: $canSeeHistory, canCancel: $canCancel, canManageSellers: $canManageSellers)';
  }

  UserStore.empty()
    : this(
        id: '',
        name: '',
        walletId: '',
        structure: Structure.empty(),
        canBank: false,
        canSeeHistory: false,
        canCancel: false,
        canManageSellers: false,
      );
}
