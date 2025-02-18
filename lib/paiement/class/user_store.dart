import 'package:myecl/paiement/class/store.dart';

class UserStore extends Store {
  final bool canBank;
  final bool canSeeHistory;
  final bool canCancel;
  final bool canManageSellers;
  final bool storeAdmin;

  UserStore({
    required super.id,
    required super.name,
    required super.walletId,
    required super.membership,
    required this.canBank,
    required this.canSeeHistory,
    required this.canCancel,
    required this.canManageSellers,
    required this.storeAdmin,
  });

  factory UserStore.fromJson(Map<String, dynamic> json) {
    return UserStore(
      id: json['id'],
      name: json['name'],
      walletId: json['wallet_id'],
      membership: json['membership'] == 'aeecl'
          ? AvailableAssociationMembership.AEECL
          : AvailableAssociationMembership.USEECL,
      canBank: json['can_bank'],
      canSeeHistory: json['can_see_history'],
      canCancel: json['can_cancel'],
      canManageSellers: json['can_manage_sellers'],
      storeAdmin: json['store_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'wallet_id': walletId,
      'membership': membership == AvailableAssociationMembership.AEECL
          ? 'aeecl'
          : 'useecl',
      'can_bank': canBank,
      'can_see_history': canSeeHistory,
      'can_cancel': canCancel,
      'can_manage_sellers': canManageSellers,
      'store_admin': storeAdmin,
    };
  }

  UserStore copyWith({
    String? id,
    String? name,
    String? walletId,
    AvailableAssociationMembership? membership,
    bool? canBank,
    bool? canSeeHistory,
    bool? canCancel,
    bool? canManageSellers,
    bool? storeAdmin,
  }) {
    return UserStore(
      id: id ?? this.id,
      name: name ?? this.name,
      walletId: walletId ?? this.walletId,
      membership: membership ?? this.membership,
      canBank: canBank ?? this.canBank,
      canSeeHistory: canSeeHistory ?? this.canSeeHistory,
      canCancel: canCancel ?? this.canCancel,
      canManageSellers: canManageSellers ?? this.canManageSellers,
      storeAdmin: storeAdmin ?? this.storeAdmin,
    );
  }

  @override
  String toString() {
    return 'UserStore(id: $id, name: $name, walletId: $walletId, membership: $membership, canBank: $canBank, canSeeHistory: $canSeeHistory, canCancel: $canCancel, canManageSellers: $canManageSellers, storeAdmin: $storeAdmin)';
  }

  UserStore.empty()
      : this(
          id: '',
          name: '',
          walletId: '',
          membership: AvailableAssociationMembership.AEECL,
          canBank: false,
          canSeeHistory: false,
          canCancel: false,
          canManageSellers: false,
          storeAdmin: false,
        );
}
