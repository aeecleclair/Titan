enum AuthGrantType { authorizationCode, refreshToken }

class AuthRequest {
  late final String token;
  late final String clientId;
  late final String redirectUri;
  late final String codeVerifier;
  late final AuthGrantType grantType;

  AuthRequest({
    required this.token,
    required this.clientId,
    required this.redirectUri,
    required this.codeVerifier,
    required this.grantType,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['client_id'] = clientId;
    switch (grantType) {
      case AuthGrantType.authorizationCode:
        data['code_verifier'] = codeVerifier;
        data['redirect_uri'] = redirectUri;
        data['code'] = token;
        data['grant_type'] = 'authorization_code';
        break;
      case AuthGrantType.refreshToken:
        data['refresh_token'] = token;

        data['grant_type'] = 'refresh_token';
        break;
    }
    return data;
  }

  AuthRequest copyWith({
    String? token,
    String? clientId,
    String? redirectUri,
    String? codeVerifier,
    AuthGrantType? grantType,
  }) {
    return AuthRequest(
      token: token ?? this.token,
      clientId: clientId ?? this.clientId,
      redirectUri: redirectUri ?? this.redirectUri,
      codeVerifier: codeVerifier ?? this.codeVerifier,
      grantType: grantType ?? this.grantType,
    );
  }

  static AuthRequest empty() {
    return AuthRequest(
      token: '',
      clientId: '',
      redirectUri: '',
      codeVerifier: '',
      grantType: AuthGrantType.authorizationCode,
    );
  }

  @override
  String toString() {
    return 'AuthRequest(token: $token, clientId: $clientId, redirectUri: $redirectUri, codeVerifier: $codeVerifier, grantType: $grantType)';
  }
}
