import 'package:titan/mypayment/class/store.dart';
import 'package:titan/user/class/user.dart';

enum WalletType { user, store }

class Wallet {
  final String id;
  final int balance;
  final WalletType type;
  final Store? store;
  final User? user;

  Wallet({
    required this.id,
    required this.balance,
    required this.type,
    this.store,
    this.user,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      balance: json['balance'],
      type: json['type'] == 'user' ? WalletType.user : WalletType.store,
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'balance': balance,
      'type': type == WalletType.user ? 'user' : 'store',
      'store': store?.toJson(),
      'user': user?.toJson(),
    };
  }

  Wallet copyWith({
    String? id,
    int? balance,
    WalletType? type,
    Store? store,
    User? user,
  }) {
    return Wallet(
      id: id ?? this.id,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      store: store ?? this.store,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'Wallet{id: $id, balance: $balance, type: $type, store: $store, user: $user}';
  }

  Wallet.empty() : this(id: '', balance: 0, type: WalletType.user);
}
