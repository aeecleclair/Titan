import 'package:titan/tools/functions.dart';

enum WalletDeviceStatus { active, inactive, revoked }

class WalletDevice {
  final String id;
  final String name;
  final String walletId;
  final DateTime creation;
  final WalletDeviceStatus status;

  WalletDevice({
    required this.id,
    required this.name,
    required this.walletId,
    required this.creation,
    required this.status,
  });

  WalletDevice.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      walletId = json['wallet_id'],
      creation = processDateFromAPI(json['creation']),
      status = WalletDeviceStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'wallet_id': walletId,
    'creation': processDateToAPI(creation),
    'status': status.toString().split('.').last,
  };

  @override
  String toString() {
    return 'WalletDevice {id: $id, name: $name, walletId: $walletId, creation: $creation, status: $status}';
  }

  WalletDevice.empty()
    : id = '',
      name = '',
      walletId = '',
      creation = DateTime.now(),
      status = WalletDeviceStatus.active;

  WalletDevice copyWith({
    String? id,
    String? name,
    String? walletId,
    DateTime? creation,
    WalletDeviceStatus? status,
  }) {
    return WalletDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      walletId: walletId ?? this.walletId,
      creation: creation ?? this.creation,
      status: status ?? this.status,
    );
  }
}
