import 'package:myecl/tools/functions.dart';

class QrCodeData {
  final String qrCodeId;
  final int total;
  final DateTime creation;
  final String walletDeviceId;
  final bool store;
  final String signature;

  QrCodeData({
    required this.qrCodeId,
    required this.total,
    required this.creation,
    required this.walletDeviceId,
    required this.store,
    required this.signature,
  });

  QrCodeData.fromJson(Map<String, dynamic> json)
      : qrCodeId = json['qr_code_id'],
        total = json['total'],
        creation = processDateFromAPI(json['creation']),
        walletDeviceId = json['wallet_device_id'],
        store = json['store'],
        signature = json['signature'];

  Map<String, dynamic> toJson() => {
        'qr_code_id': qrCodeId,
        'total': total,
        'creation': processDateToAPI(creation),
        'wallet_device_id': walletDeviceId,
        'store': store,
        'signature': signature,
      };

  @override
  String toString() {
    return 'QrCodeData {qrCodeId: $qrCodeId, total: $total, creation: $creation, walletDeviceId: $walletDeviceId, store: $store, signature: $signature}';
  }

  QrCodeData.empty()
      : qrCodeId = '',
        total = 0,
        creation = DateTime.now(),
        walletDeviceId = '',
        store = false,
        signature = '';

  QrCodeData copyWith({
    String? qrCodeId,
    int? total,
    DateTime? creation,
    String? walletDeviceId,
    bool? store,
    String? signature,
  }) {
    return QrCodeData(
      qrCodeId: qrCodeId ?? this.qrCodeId,
      total: total ?? this.total,
      creation: creation ?? this.creation,
      walletDeviceId: walletDeviceId ?? this.walletDeviceId,
      store: store ?? this.store,
      signature: signature ?? this.signature,
    );
  }
}
