import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:myecl/auth/class/auth_request.dart';
import 'package:myecl/auth/class/auth_token.dart';
import 'package:myecl/auth/providers/connection_status_provider.dart';
import 'package:myecl/auth/repository/openid_repository.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

final authTokenProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<AuthToken>>((ref) {
      final authNotifier = AuthNotifier(
        appAuth: FlutterAppAuth(),
        secureStorage: FlutterSecureStorage(),
        cacheManager: CacheManager(),
        openIdRepository: OpenIdRepository(),
      );
      final isOnline = ref.watch(connectionStatusProvider);
      if (isOnline) {
        authNotifier.refreshAccessToken();
      }
      return authNotifier;
    });

class IsCachingNotifier extends StateNotifier<bool> {
  IsCachingNotifier(super.b);

  void set(bool b) {
    state = b;
  }
}

final isCachingProvider = StateNotifierProvider<IsCachingNotifier, bool>((ref) {
  final IsCachingNotifier isCachingProvider = IsCachingNotifier(false);

  final isConnected = ref.watch(connectionStatusProvider);
  ref
      .read(authTokenProvider.notifier)
      .cacheManager
      .readCache(AuthNotifier.userIdName)
      .then((value) {
        isCachingProvider.set(!isConnected && value != "");
      });
  return isCachingProvider;
});

final refreshTokenProvider = FutureProvider<bool>((ref) {
  final authNotifier = ref.read(authTokenProvider.notifier);
  return authNotifier.refreshAccessToken();
});

final isLoggedInProvider = Provider<bool>((ref) {
  final authToken = ref.watch(authTokenProvider);
  final isCaching = ref.watch(isCachingProvider);
  if (isCaching) {
    return true;
  }
  return authToken.maybeWhen(
    data: (authToken) => authToken.accessToken == ""
        ? false
        : !JwtDecoder.isExpired(authToken.accessToken),
    orElse: () => false,
  );
});

final loadingProvider = FutureProvider<bool>((ref) {
  final isCaching = ref.watch(isCachingProvider);
  return isCaching ||
      ref
          .watch(authTokenProvider)
          .when(
            data: (authToken) =>
                authToken.accessToken != "" && ref.watch(isLoggedInProvider),
            error: (e, s) => false,
            loading: () => true,
          );
});

final userIdProvider = FutureProvider<String>((ref) {
  final cacheManager = ref.read(authTokenProvider.notifier).cacheManager;
  return ref
      .watch(authTokenProvider)
      .when(
        data: (authToken) {
          final id = authToken.accessToken == ""
              ? ""
              : JwtDecoder.decode(authToken.accessToken)["sub"];
          cacheManager.writeCache(AuthNotifier.userIdName, id);
          return id;
        },
        error: (e, s) => "",
        loading: () => cacheManager.readCache(AuthNotifier.userIdName),
      );
});

final tokenProvider = Provider((ref) {
  return ref
      .watch(authTokenProvider)
      .maybeWhen(data: (authToken) => authToken.accessToken, orElse: () => "");
});

/// The AuthNotifier class is responsible for managing the authentication state
/// of the application. It handles signing in, signing out, refreshing tokens,
/// and storing authentication tokens securely.
///
/// It uses the Flutter AppAuth package for OAuth 2.0 authorization code flow
/// with PKCE for mobile applications, and a web-based flow for web applications.
class AuthNotifier extends StateNotifier<AsyncValue<AuthToken>> {
  final FlutterAppAuth appAuth;
  final FlutterSecureStorage secureStorage;
  final CacheManager cacheManager;
  final OpenIdRepository openIdRepository;

  AuthNotifier({
    required this.appAuth,
    required this.secureStorage,
    required this.cacheManager,
    required this.openIdRepository,
  }) : super(const AsyncLoading());

  static const Base64Codec base64 = Base64Codec.urlSafe();
  static const String userIdName = "id";

  // --- OIDC Configuration ---
  static const String tokenName = "my_ecl_auth_token";
  static const String clientId = "Titan";
  static final String redirectURLScheme =
      "${getTitanPackageName()}://authorized";
  static final String redirectURL = "${getTitanURL()}/static.html";
  static final String discoveryUrl =
      "${Repository.host}.well-known/openid-configuration";
  static List<String> scopes = ["API"];

  /// Signs in the user using the appropriate flow based on the platform.
  Future<void> signIn() async {
    state = const AsyncLoading();
    try {
      if (kIsWeb) {
        await _signInWeb();
      } else {
        await _signInMobile();
      }
    } catch (e, s) {
      state = AsyncError("Error $e", s);
    } finally {
      // Ensure the state is updated to reflect the loading status
      if (state is AsyncLoading) {
        // If the sign-in process fails, reset the state to an empty token
        // to avoid leaving the app in a loading state.
        // This is important for mobile apps where the user might not be able
        // to retry the sign-in easily.
        state = AsyncData(AuthToken.empty());
      }
    }
  }

  /// Signs in the user using the mobile app flow.
  /// This method uses the Flutter AppAuth package to perform the OAuth 2.0
  /// authorization code flow with PKCE.
  Future<void> _signInMobile() async {
    AuthorizationTokenResponse response = await appAuth
        .authorizeAndExchangeCode(
          AuthorizationTokenRequest(
            clientId,
            redirectURLScheme,
            discoveryUrl: discoveryUrl,
            scopes: scopes,
            allowInsecureConnections: kDebugMode,
          ),
        );
    _saveAndStoreToken(AuthToken.fromTokenResponse(response));
  }

  /// Signs in the user using the web flow.
  /// This method opens a popup window for the user to authenticate and
  /// then retrieves the authorization code from the redirect URI.
  /// It uses the code to request an access token from the OpenID provider.
  Future<void> _signInWeb() async {
    final codeVerifier = _generateRandomString(128);
    final authUrl = _generateAuthUrl(codeVerifier);

    html.WindowBase? popupWin = html.window.open(
      authUrl,
      "Hyperion",
      "width=800, height=900, scrollbars=yes",
    );

    final completer = Completer();
    void checkWindowClosed() {
      if (popupWin != null && popupWin!.closed == true) {
        completer.complete();
      } else {
        Future.delayed(const Duration(milliseconds: 100), checkWindowClosed);
      }
    }

    checkWindowClosed();
    completer.future.then((_) {
      state.maybeWhen(
        loading: () {
          state = AsyncData(AuthToken.empty());
        },
        orElse: () {},
      );
    });

    Future<void> login(String data) async {
      final receivedUri = Uri.parse(data);
      final token = receivedUri.queryParameters["code"];
      if (popupWin != null) {
        popupWin!.close();
        popupWin = null;
      }
      try {
        if (token != null && token.isNotEmpty) {
          final authToken = await openIdRepository.getToken(
            AuthRequest(
              token: token,
              clientId: clientId,
              redirectUri: redirectURL,
              codeVerifier: codeVerifier,
              grantType: AuthGrantType.authorizationCode,
            ),
          );
          _saveAndStoreToken(authToken);
        } else {
          throw Exception('Wrong credentials');
        }
      } on TimeoutException catch (_) {
        throw Exception('No response from server');
      } catch (e) {
        rethrow;
      }
    }

    html.window.onMessage.listen((event) {
      if (event.data.toString().contains('code=')) {
        login(event.data);
      }
    });
  }

  /// Refreshes the access token based on the current platform.
  /// For web applications, it uses the OpenID repository to refresh the token.
  /// For mobile applications, it uses the Flutter AppAuth package to refresh the token.
  /// If the token is successfully refreshed, it stores the new token.
  /// If an error occurs, it updates the state with the error.
  Future<bool> refreshAccessToken() async {
    state = const AsyncLoading();
    final refreshToken = await secureStorage.read(key: tokenName);
    if (refreshToken != null) {
      try {
        if (kIsWeb) {
          await _refreshAccessTokenWeb(refreshToken);
        } else {
          await _refreshAccessTokenMobile(refreshToken);
        }
        return true;
      } catch (e, s) {
        state = AsyncError(e, s);
      }
    } else {
      state = const AsyncError("No token found", StackTrace.empty);
    }

    return false;
  }

  // Refreshes access token for web applications.
  Future<void> _refreshAccessTokenWeb(String refreshToken) async {
    final authToken = await openIdRepository.getToken(
      AuthRequest(
        token: refreshToken,
        clientId: clientId,
        redirectUri: redirectURL,
        codeVerifier: "",
        grantType: AuthGrantType.refreshToken,
      ),
    );
    _saveAndStoreToken(authToken);
  }

  // Refreshes access token for mobile applications.
  Future<void> _refreshAccessTokenMobile(String? refreshToken) async {
    final response = await appAuth.token(
      TokenRequest(
        clientId,
        redirectURLScheme,
        discoveryUrl: discoveryUrl,
        scopes: scopes,
        refreshToken: refreshToken,
        allowInsecureConnections: kDebugMode,
      ),
    );
    _saveAndStoreToken(AuthToken.fromTokenResponse(response));
  }

  /// Deletes the authentication token from secure storage and cache.
  void signOut() {
    try {
      secureStorage.delete(key: tokenName);
      cacheManager.deleteCache(tokenName);
      cacheManager.deleteCache(userIdName);
      state = AsyncData(AuthToken.empty());
    } catch (e) {
      state = AsyncError(e, StackTrace.empty);
    }
  }

  /// Saves the authentication token in the state and stores it securely.
  void _saveAndStoreToken(AuthToken authToken) {
    state = AsyncData(authToken);
    secureStorage.write(key: tokenName, value: authToken.refreshToken);
  }

  // --- Helper Methods ---

  /// Generates a random string of the specified length.
  /// This is used to create a code verifier for the OAuth 2.0 PKCE flow.
  static String _generateRandomString(int len) {
    final r = Random.secure();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  /// Hashes the given data using SHA-256 and encodes it in Base64.
  /// This is used to create a code challenge for the OAuth 2.0 PKCE flow.
  static String _hash(String data) {
    return base64.encode(sha256.convert(utf8.encode(data)).bytes);
  }

  /// Generates the authorization URL for the OAuth 2.0 PKCE flow.
  String _generateAuthUrl(String codeVerifier) {
    return "${Repository.host}auth/authorize?client_id=$clientId&response_type=code&scope=${scopes.join(" ")}&redirect_uri=$redirectURL&code_challenge=${_hash(codeVerifier)}&code_challenge_method=S256";
  }
}
