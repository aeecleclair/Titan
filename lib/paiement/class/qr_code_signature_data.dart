import 'package:myecl/tools/functions.dart';

class QrCodeSignatureData {
  final String qrCodeId;
  final int tot;
  final DateTime iat;
  final String key;
  final bool store;

  QrCodeSignatureData({
    required this.qrCodeId,
    required this.tot,
    required this.iat,
    required this.key,
    required this.store,
  });

  QrCodeSignatureData.fromJson(Map<String, dynamic> json)
      : qrCodeId = json['qr_code_id'],
        tot = json['tot'],
        iat = processDateFromAPI(json['iat']),
        key = json['key'],
        store = json['store'];

  Map<String, dynamic> toJson() => {
        'qr_code_id': qrCodeId,
        'tot': tot,
        'iat': processDateToAPI(iat),
        'key': key,
        'store': store,
      };

  @override
  String toString() {
    return 'QrCodeSignatureData {qrCodeId: $qrCodeId, tot: $tot, iat: $iat, key: $key, store: $store}';
  }

  QrCodeSignatureData.empty()
      : qrCodeId = '',
        tot = 0,
        iat = DateTime.now(),
        key = '',
        store = false;

  QrCodeSignatureData copyWith({
    String? qrCodeId,
    int? tot,
    DateTime? iat,
    String? key,
    bool? store,
  }) {
    return QrCodeSignatureData(
      qrCodeId: qrCodeId ?? this.qrCodeId,
      tot: tot ?? this.tot,
      iat: iat ?? this.iat,
      key: key ?? this.key,
      store: store ?? this.store,
    );
  }
}
