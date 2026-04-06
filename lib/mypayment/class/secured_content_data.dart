import 'package:titan/tools/functions.dart';

class SecuredContentData {
  final String id;
  final int tot;
  final DateTime iat;
  final String key;
  final bool store;

  SecuredContentData({
    required this.id,
    required this.tot,
    required this.iat,
    required this.key,
    required this.store,
  });

  SecuredContentData.fromJson(Map<String, dynamic> json)
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
    return 'SecuredContentData {id: $id, tot: $tot, iat: $iat, key: $key, store: $store}';
  }

  SecuredContentData.empty()
    : id = '',
      tot = 0,
      iat = DateTime.now(),
      key = '',
      store = false;

  SecuredContentData copyWith({
    String? id,
    int? tot,
    DateTime? iat,
    String? key,
    bool? store,
  }) {
    return SecuredContentData(
      id: id ?? this.id,
      tot: tot ?? this.tot,
      iat: iat ?? this.iat,
      key: key ?? this.key,
      store: store ?? this.store,
    );
  }
}
