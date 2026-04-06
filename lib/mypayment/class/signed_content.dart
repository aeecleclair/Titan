import 'package:titan/mypayment/class/secured_content_data.dart';

class SignedContent extends SecuredContentData {
  final String signature;

  SignedContent({
    required super.id,
    required super.tot,
    required super.iat,
    required super.key,
    required super.store,
    required this.signature,
  });

  SignedContent.fromJson(super.json)
    : signature = json['signature'],
      super.fromJson();

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'signature': signature};

  @override
  String toString() {
    return 'SignedContent {id: $id, tot: $tot, iat: $iat, key: $key, store: $store, signature: $signature}';
  }

  SignedContent.empty()
    : signature = '',
      super.empty();

  @override
  SignedContent copyWith({
    String? id,
    int? tot,
    DateTime? iat,
    String? key,
    bool? store,
    String? signature,
  }) {
    return SignedContent(
      id: id ?? this.id,
      tot: tot ?? this.tot,
      iat: iat ?? this.iat,
      key: key ?? this.key,
      store: store ?? this.store,
      signature: signature ?? this.signature,
    );
  }
}
