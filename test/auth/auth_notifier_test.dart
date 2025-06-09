import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myecl/auth/class/auth_request.dart';
import 'package:myecl/auth/class/auth_token.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/auth/repository/openid_repository.dart';

class MockAppAuth extends Mock implements FlutterAppAuth {}

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

class MockCacheManager extends Mock implements CacheManager {}

class MockOpenIdRepository extends Mock implements OpenIdRepository {}

class MockTokenResponse extends Mock implements AuthorizationTokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  MockTokenResponse({required this.accessToken, required this.refreshToken})
    : super();
}

void main() {
  late AuthNotifier authNotifier;
  late MockSecureStorage mockStorage;
  late MockCacheManager mockCache;
  late MockAppAuth mockAppAuth;
  late MockOpenIdRepository mockOpenIdRepository;

  setUpAll(() {
    dotenv.load();
    registerFallbackValue(
      AuthRequest(
        token: '',
        clientId: '',
        redirectUri: '',
        codeVerifier: '',
        grantType: AuthGrantType.authorizationCode,
      ),
    );
    registerFallbackValue(
      TokenRequest("", "", discoveryUrl: "", scopes: [], refreshToken: ""),
    );
    registerFallbackValue(
      AuthorizationTokenRequest("", "", discoveryUrl: "", scopes: []),
    );
  });

  setUp(() {
    mockStorage = MockSecureStorage();
    mockCache = MockCacheManager();
    mockAppAuth = MockAppAuth();
    mockOpenIdRepository = MockOpenIdRepository();

    authNotifier = AuthNotifier(
      appAuth: mockAppAuth,
      secureStorage: mockStorage,
      cacheManager: mockCache,
      openIdRepository: mockOpenIdRepository,
    );
  });

  test(
    'signOut should clear storage and cache and emit empty AuthToken',
    () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});
      when(() => mockCache.deleteCache(any())).thenAnswer((_) async {});

      when(
        () => mockOpenIdRepository.getToken(any()),
      ).thenAnswer((_) async => AuthToken.empty());

      authNotifier.signOut();

      expect(authNotifier.state, AsyncData(AuthToken.empty()));
      verify(() => mockStorage.delete(key: AuthNotifier.tokenName)).called(1);
      verify(() => mockCache.deleteCache(AuthNotifier.tokenName)).called(1);
      verify(() => mockCache.deleteCache(AuthNotifier.userIdName)).called(1);
    },
  );

  test('refreshAccessToken success mobile', () async {
    final fakeToken = AuthToken(accessToken: "abc", refreshToken: "refresh");
    when(
      () => mockStorage.read(key: any(named: 'key')),
    ).thenAnswer((_) async => "refresh");
    when(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockOpenIdRepository.getToken(any()),
    ).thenAnswer((_) async => fakeToken);

    when(() => mockAppAuth.token(any())).thenAnswer(
      (_) async =>
          MockTokenResponse(accessToken: "abc", refreshToken: "refresh"),
    );

    final result = await authNotifier.refreshAccessToken();

    expect(result, isTrue);
    expect(authNotifier.state, isA<AsyncData<AuthToken>>());
    final data = (authNotifier.state as AsyncData<AuthToken>).value;
    expect(data.accessToken, "abc");
    expect(data.refreshToken, "refresh");
    verify(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: "refresh",
      ),
    ).called(1);
  });

  test('refreshAccessToken failure mobile', () async {
    when(
      () => mockStorage.read(key: any(named: 'key')),
    ).thenAnswer((_) async => "invalid_refresh_token");

    when(() => mockAppAuth.token(any())).thenThrow(Exception("Token error"));

    final result = await authNotifier.refreshAccessToken();

    expect(result, isFalse);
    expect(authNotifier.state, isA<AsyncError<AuthToken>>());
    verifyNever(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    );
  });

  test('signIn success mobile', () async {
    when(() => mockAppAuth.authorizeAndExchangeCode(any())).thenAnswer(
      (_) async =>
          MockTokenResponse(accessToken: "abc", refreshToken: "refresh"),
    );

    when(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});

    await authNotifier.signIn();

    expect(authNotifier.state, isA<AsyncData<AuthToken>>());
    final data = (authNotifier.state as AsyncData<AuthToken>).value;
    expect(data.accessToken, "abc");
    expect(data.refreshToken, "refresh");
  });

  test('signIn failure mobile', () async {
    when(
      () => mockAppAuth.authorizeAndExchangeCode(any()),
    ).thenThrow(Exception("Authorization error"));

    await authNotifier.signIn();

    expect(authNotifier.state, isA<AsyncError<AuthToken>>());
    verifyNever(
      () => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    );
  });
}
