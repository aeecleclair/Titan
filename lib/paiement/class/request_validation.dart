import 'package:titan/tools/functions.dart';

class RequestValidationData {
  final String requestId;
  final String key;
  final DateTime iat;
  final int tot;

  RequestValidationData({
    required this.requestId,
    required this.key,
    required this.iat,
    required this.tot,
  });

  Map<String, dynamic> toJson() => {
    'request_id': requestId,
    'key': key,
    'iat': processDateToAPI(iat),
    'tot': tot,
  };

  @override
  String toString() {
    return 'RequestValidationData {requestId: $requestId, key: $key, iat: $iat, tot: $tot}';
  }
}

class RequestValidation extends RequestValidationData {
  final String signature;

  RequestValidation({
    required super.requestId,
    required super.key,
    required super.iat,
    required super.tot,
    required this.signature,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'signature': signature,
  };

  @override
  String toString() {
    return 'RequestValidation {requestId: $requestId, key: $key, iat: $iat, tot: $tot, signature: $signature}';
  }
}
