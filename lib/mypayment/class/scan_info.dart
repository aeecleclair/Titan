import 'package:titan/mypayment/class/signed_content.dart';

class ScanInfo extends SignedContent {
  final bool bypassMembership;

  ScanInfo({
    required super.id,
    required super.tot,
    required super.iat,
    required super.key,
    required super.store,
    required super.signature,
    this.bypassMembership = false,
  });

  ScanInfo.fromSignedContent(
    SignedContent content, {
    this.bypassMembership = false,
  }) : super(
         id: content.id,
         tot: content.tot,
         iat: content.iat,
         key: content.key,
         store: content.store,
         signature: content.signature,
       );

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'bypass_membership': bypassMembership,
  };

  @override
  String toString() {
    return 'ScanInfo {id: $id, tot: $tot, iat: $iat, key: $key, store: $store, signature: $signature, bypassMembership: $bypassMembership}';
  }
}
