import 'package:titan/tools/functions.dart';

class Checkout {
  Checkout({required this.categoryId, required this.sessionId});
  late final String categoryId;
  late final String sessionId;
  late final int price;
  late final DateTime expiration;

  Checkout.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    expiration = processDateFromAPI(json['expiration']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['session_id'] = sessionId;
    return data;
  }

  Checkout copyWith({String? categoryId, String? sessionId}) {
    return Checkout(
      categoryId: categoryId ?? this.categoryId,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  Checkout.empty() {
    categoryId = '';
    sessionId = '';
  }

  @override
  String toString() {
    return 'Checkout{categoryId : $categoryId, sessionId: $sessionId}';
  }
}
