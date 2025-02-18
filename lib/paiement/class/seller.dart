class Seller {
  final String userId;
  final String storeId;
  final bool canBank;
  final bool canSeeHistory;
  final bool canCancel;
  final bool canManageSellers;
  final bool storeAdmin;

  Seller({
    required this.userId,
    required this.storeId,
    required this.canBank,
    required this.canSeeHistory,
    required this.canCancel,
    required this.canManageSellers,
    required this.storeAdmin,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      userId: json['user_id'],
      storeId: json['store_id'],
      canBank: json['can_bank'],
      canSeeHistory: json['can_see_history'],
      canCancel: json['can_cancel'],
      canManageSellers: json['can_manage_sellers'],
      storeAdmin: json['store_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'store_id': storeId,
      'can_bank': canBank,
      'can_see_history': canSeeHistory,
      'can_cancel': canCancel,
      'can_manage_sellers': canManageSellers,
      'store_admin': storeAdmin,
    };
  }

  Seller copyWith({
    String? userId,
    String? storeId,
    bool? canBank,
    bool? canSeeHistory,
    bool? canCancel,
    bool? canManageSellers,
    bool? storeAdmin,
  }) {
    return Seller(
      userId: userId ?? this.userId,
      storeId: storeId ?? this.storeId,
      canBank: canBank ?? this.canBank,
      canSeeHistory: canSeeHistory ?? this.canSeeHistory,
      canCancel: canCancel ?? this.canCancel,
      canManageSellers: canManageSellers ?? this.canManageSellers,
      storeAdmin: storeAdmin ?? this.storeAdmin,
    );
  }

  @override
  String toString() {
    return 'Seller(userId: $userId, storeId: $storeId, canBank: $canBank, canSeeHistory: $canSeeHistory, canCancel: $canCancel, canManageSellers: $canManageSellers, storeAdmin: $storeAdmin)';
  }

  Seller.empty()
      : this(
          userId: '',
          storeId: '',
          canBank: false,
          canSeeHistory: false,
          canCancel: false,
          canManageSellers: false,
          storeAdmin: false,
        );
}
