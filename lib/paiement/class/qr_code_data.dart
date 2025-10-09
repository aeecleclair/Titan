import 'package:titan/tools/functions.dart';

class QrCodeData {
  final String id;
  final int tot;
  final DateTime iat;
  final String key;
  final bool store;
  final String signature;

  QrCodeData({
    required this.id,
    required this.tot,
    required this.iat,
    required this.key,
    required this.store,
    required this.signature,
  });

  QrCodeData.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      tot = json['tot'],
      iat = processDateFromAPI(json['iat']),
      key = json['key'],
      store = json['store'],
      signature = json['signature'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'tot': tot,
    'iat': processDateToAPI(iat),
    'key': key,
    'store': store,
    'signature': signature,
  };

  @override
  String toString() {
    return 'QrCodeData {id: $id, tot: $tot, iat: $iat, key: $key, store: $store, signature: $signature}';
  }

  QrCodeData.empty()
    : id = '',
      tot = 0,
      iat = DateTime.now(),
      key = '',
      store = false,
      signature = '';

  QrCodeData copyWith({
    String? id,
    int? tot,
    DateTime? iat,
    String? key,
    bool? store,
    String? signature,
  }) {
    return QrCodeData(
      id: id ?? this.id,
      tot: tot ?? this.tot,
      iat: iat ?? this.iat,
      key: key ?? this.key,
      store: store ?? this.store,
      signature: signature ?? this.signature,
    );
  }
}
