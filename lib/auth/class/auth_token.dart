/// A type-safe class to hold authentication tokens, preferable to a raw Map.
class AuthToken {
  late final String accessToken;
  late final String refreshToken;

  AuthToken({required this.accessToken, required this.refreshToken});

  AuthToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] as String;
    refreshToken = json['refresh_token'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }

  static AuthToken empty() {
    return AuthToken(accessToken: '', refreshToken: '');
  }

  AuthToken copyWith({String? accessToken, String? refreshToken}) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  String toString() {
    return 'AuthToken(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
