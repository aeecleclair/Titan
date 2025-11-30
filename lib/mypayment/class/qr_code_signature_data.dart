import 'package:titan/tools/functions.dart';

class QrCodeSignatureData {
  final String id;
  final int tot;
  final DateTime iat;
  final String key;
  final bool store;

  QrCodeSignatureData({
    required this.id,
    required this.tot,
    required this.iat,
    required this.key,
    required this.store,
  });

  QrCodeSignatureData.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      tot = json['tot'],
      iat = processDateFromAPI(json['iat']),
      key = json['key'],
      store = json['store'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'tot': tot,
    'iat': processDateToAPI(iat),
    'key': key,
    'store': store,
  };

  @override
  String toString() {
    return 'QrCodeSignatureData {id: $id, tot: $tot, iat: $iat, key: $key, store: $store}';
  }

  QrCodeSignatureData.empty()
    : id = '',
      tot = 0,
      iat = DateTime.now(),
      key = '',
      store = false;

  QrCodeSignatureData copyWith({
    String? id,
    int? tot,
    DateTime? iat,
    String? key,
    bool? store,
  }) {
    return QrCodeSignatureData(
      id: id ?? this.id,
      tot: tot ?? this.tot,
      iat: iat ?? this.iat,
      key: key ?? this.key,
      store: store ?? this.store,
    );
  }
}
