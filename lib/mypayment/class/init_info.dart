class InitInfo {
  final int amount;
  final String redirectUrl;

  InitInfo({required this.amount, required this.redirectUrl});

  factory InitInfo.fromJson(Map<String, dynamic> json) {
    return InitInfo(amount: json['amount'], redirectUrl: json['redirect_url']);
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'redirect_url': redirectUrl};
  }

  @override
  String toString() {
    return 'InitInfo{amount: $amount, redirectUrl: $redirectUrl}';
  }

  InitInfo copyWith({int? amount, String? redirectUrl}) {
    return InitInfo(
      amount: amount ?? this.amount,
      redirectUrl: redirectUrl ?? this.redirectUrl,
    );
  }

  InitInfo.empty() : amount = 0, redirectUrl = '';
}
