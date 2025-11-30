class TOS {
  final int acceptedTosVersion;
  final int latestTosVersion;
  final String tosContent;
  final int maxWalletBalance;

  TOS({
    required this.acceptedTosVersion,
    required this.latestTosVersion,
    required this.tosContent,
    required this.maxWalletBalance,
  });

  TOS.fromJson(Map<String, dynamic> json)
    : acceptedTosVersion = json['accepted_tos_version'],
      latestTosVersion = json['latest_tos_version'],
      tosContent = json['tos_content'],
      maxWalletBalance = json['max_wallet_balance'];

  Map<String, dynamic> toJson() {
    return {
      'accepted_tos_version': acceptedTosVersion,
      'latest_tos_version': latestTosVersion,
      'tos_content': tosContent,
      'max_wallet_balance': maxWalletBalance,
    };
  }

  @override
  String toString() {
    return 'TOS{acceptedTosVersion: $acceptedTosVersion, latestTosVersion: $latestTosVersion, tosContent: $tosContent, maxWalletBalance: $maxWalletBalance}';
  }

  TOS copyWith({
    int? acceptedTosVersion,
    int? latestTosVersion,
    String? tosContent,
    int? maxWalletBalance,
  }) {
    return TOS(
      acceptedTosVersion: acceptedTosVersion ?? this.acceptedTosVersion,
      latestTosVersion: latestTosVersion ?? this.latestTosVersion,
      tosContent: tosContent ?? this.tosContent,
      maxWalletBalance: maxWalletBalance ?? this.maxWalletBalance,
    );
  }

  TOS.empty()
    : this(
        acceptedTosVersion: 0,
        latestTosVersion: 0,
        tosContent: '',
        maxWalletBalance: 0,
      );
}
