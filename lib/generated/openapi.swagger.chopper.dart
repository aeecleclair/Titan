// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Openapi extends Openapi {
  _$Openapi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Openapi;

  @override
  Future<Response<List<FirebaseDevice>>> _notificationDevicesGet() {
    final Uri $url = Uri.parse('/notification/devices');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<FirebaseDevice>, FirebaseDevice>($request);
  }

  @override
  Future<Response<dynamic>> _notificationDevicesPost(
      {required BodyRegisterFirebaseDeviceNotificationDevicesPost? body}) {
    final Uri $url = Uri.parse('/notification/devices');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationDevicesFirebaseTokenDelete(
      {required String? firebaseToken}) {
    final Uri $url = Uri.parse('/notification/devices/${firebaseToken}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTopicsTopicStrSubscribePost(
      {required String? topicStr}) {
    final Uri $url = Uri.parse('/notification/topics/${topicStr}/subscribe');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTopicsTopicStrUnsubscribePost(
      {required String? topicStr}) {
    final Uri $url = Uri.parse('/notification/topics/${topicStr}/unsubscribe');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _notificationTopicsGet() {
    final Uri $url = Uri.parse('/notification/topics');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<List<String>>> _notificationTopicsTopicGet(
      {required String? topic}) {
    final Uri $url = Uri.parse('/notification/topics/${topic}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _notificationSendPost() {
    final Uri $url = Uri.parse('/notification/send');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationSendFuturePost() {
    final Uri $url = Uri.parse('/notification/send/future');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationSendTopicPost() {
    final Uri $url = Uri.parse('/notification/send/topic');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationSendTopicFuturePost() {
    final Uri $url = Uri.parse('/notification/send/topic/future');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _googleApiOauth2callbackGet() {
    final Uri $url = Uri.parse('/google-api/oauth2callback');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Structure>>> _myeclpayStructuresGet() {
    final Uri $url = Uri.parse('/myeclpay/structures');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Structure>, Structure>($request);
  }

  @override
  Future<Response<Structure>> _myeclpayStructuresPost(
      {required StructureBase? body}) {
    final Uri $url = Uri.parse('/myeclpay/structures');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Structure, Structure>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayStructuresStructureIdPatch({
    required String? structureId,
    required StructureUpdate? body,
  }) {
    final Uri $url = Uri.parse('/myeclpay/structures/${structureId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayStructuresStructureIdDelete(
      {required String? structureId}) {
    final Uri $url = Uri.parse('/myeclpay/structures/${structureId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _myeclpayStructuresStructureIdInitManagerTransferPost({
    required String? structureId,
    required StructureTranfert? body,
  }) {
    final Uri $url =
        Uri.parse('/myeclpay/structures/${structureId}/init-manager-transfer');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayStructuresConfirmManagerTransferGet(
      {required String? token}) {
    final Uri $url = Uri.parse('/myeclpay/structures/confirm-manager-transfer');
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Store>> _myeclpayStructuresStructureIdStoresPost({
    required String? structureId,
    required StoreBase? body,
  }) {
    final Uri $url = Uri.parse('/myeclpay/structures/${structureId}/stores');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Store, Store>($request);
  }

  @override
  Future<Response<List<History>>> _myeclpayStoresStoreIdHistoryGet(
      {required String? storeId}) {
    final Uri $url = Uri.parse('/myeclpay/stores/${storeId}/history');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<History>, History>($request);
  }

  @override
  Future<Response<List<UserStore>>> _myeclpayUsersMeStoresGet() {
    final Uri $url = Uri.parse('/myeclpay/users/me/stores');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserStore>, UserStore>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayStoresStoreIdPatch({
    required String? storeId,
    required StoreUpdate? body,
  }) {
    final Uri $url = Uri.parse('/myeclpay/stores/${storeId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayStoresStoreIdDelete(
      {required String? storeId}) {
    final Uri $url = Uri.parse('/myeclpay/stores/${storeId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Seller>> _myeclpayStoresStoreIdSellersPost({
    required String? storeId,
    required SellerCreation? body,
  }) {
    final Uri $url = Uri.parse('/myeclpay/stores/${storeId}/sellers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Seller, Seller>($request);
  }

  @override
  Future<Response<List<Seller>>> _myeclpayStoresStoreIdSellersGet(
      {required String? storeId}) {
    final Uri $url = Uri.parse('/myeclpay/stores/${storeId}/sellers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Seller>, Seller>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayStoresStoreIdSellersSellerUserIdPatch({
    required String? storeId,
    required String? sellerUserId,
    required SellerUpdate? body,
  }) {
    final Uri $url =
        Uri.parse('/myeclpay/stores/${storeId}/sellers/${sellerUserId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayStoresStoreIdSellersSellerUserIdDelete({
    required String? storeId,
    required String? sellerUserId,
  }) {
    final Uri $url =
        Uri.parse('/myeclpay/stores/${storeId}/sellers/${sellerUserId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayTosGet() {
    final Uri $url = Uri.parse('/myeclpay/tos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TOSSignatureResponse>> _myeclpayUsersMeTosGet() {
    final Uri $url = Uri.parse('/myeclpay/users/me/tos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TOSSignatureResponse, TOSSignatureResponse>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayUsersMeTosPost(
      {required TOSSignature? body}) {
    final Uri $url = Uri.parse('/myeclpay/users/me/tos');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayUsersMeRegisterPost() {
    final Uri $url = Uri.parse('/myeclpay/users/me/register');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<WalletDevice>>> _myeclpayUsersMeWalletDevicesGet() {
    final Uri $url = Uri.parse('/myeclpay/users/me/wallet/devices');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<WalletDevice>, WalletDevice>($request);
  }

  @override
  Future<Response<WalletDevice>> _myeclpayUsersMeWalletDevicesPost(
      {required WalletDeviceCreation? body}) {
    final Uri $url = Uri.parse('/myeclpay/users/me/wallet/devices');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WalletDevice, WalletDevice>($request);
  }

  @override
  Future<Response<WalletDevice>> _myeclpayUsersMeWalletDevicesWalletDeviceIdGet(
      {required String? walletDeviceId}) {
    final Uri $url =
        Uri.parse('/myeclpay/users/me/wallet/devices/${walletDeviceId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WalletDevice, WalletDevice>($request);
  }

  @override
  Future<Response<Wallet>> _myeclpayUsersMeWalletGet() {
    final Uri $url = Uri.parse('/myeclpay/users/me/wallet');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Wallet, Wallet>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayDevicesActivateGet(
      {required String? token}) {
    final Uri $url = Uri.parse('/myeclpay/devices/activate');
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _myeclpayUsersMeWalletDevicesWalletDeviceIdRevokePost(
          {required String? walletDeviceId}) {
    final Uri $url =
        Uri.parse('/myeclpay/users/me/wallet/devices/${walletDeviceId}/revoke');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<History>>> _myeclpayUsersMeWalletHistoryGet() {
    final Uri $url = Uri.parse('/myeclpay/users/me/wallet/history');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<History>, History>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayTransferAdminPost(
      {required AdminTransferInfo? body}) {
    final Uri $url = Uri.parse('/myeclpay/transfer/admin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaymentUrl>> _myeclpayTransferInitPost(
      {required TransferInfo? body}) {
    final Uri $url = Uri.parse('/myeclpay/transfer/init');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<Transaction>> _myeclpayStoresStoreIdScanPost({
    required String? storeId,
    required ScanInfo? body,
  }) {
    final Uri $url = Uri.parse('/myeclpay/stores/${storeId}/scan');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Transaction, Transaction>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayTransactionsTransactionIdRefundPost({
    required String? transactionId,
    required RefundInfo? body,
  }) {
    final Uri $url =
        Uri.parse('/myeclpay/transactions/${transactionId}/refund');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayTransactionsTransactionIdCancelPost(
      {required String? transactionId}) {
    final Uri $url =
        Uri.parse('/myeclpay/transactions/${transactionId}/cancel');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _myeclpayIntegrityCheckGet() {
    final Uri $url = Uri.parse('/myeclpay/integrity-check');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AccessToken>> _authSimpleTokenPost(
      {required Map<String, String> body}) {
    final Uri $url = Uri.parse('/auth/simple_token');
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<AccessToken, AccessToken>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<String>> _authAuthorizeGet({
    required String? clientId,
    String? redirectUri,
    required String? responseType,
    String? scope,
    String? state,
    String? nonce,
    String? codeChallenge,
    String? codeChallengeMethod,
  }) {
    final Uri $url = Uri.parse('/auth/authorize');
    final Map<String, dynamic> $params = <String, dynamic>{
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': responseType,
      'scope': scope,
      'state': state,
      'nonce': nonce,
      'code_challenge': codeChallenge,
      'code_challenge_method': codeChallengeMethod,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _authAuthorizePost(
      {required Map<String, String> body}) {
    final Uri $url = Uri.parse('/auth/authorize');
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<String, String>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<dynamic>> _authAuthorizationFlowAuthorizeValidationPost(
      {required Map<String, String> body}) {
    final Uri $url = Uri.parse('/auth/authorization-flow/authorize-validation');
    final Map<String, String> $headers = {
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<dynamic, dynamic>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<TokenResponse>> _authTokenPost({
    String? authorization,
    required Map<String, String> body,
  }) {
    final Uri $url = Uri.parse('/auth/token');
    final Map<String, String> $headers = {
      if (authorization != null) 'authorization': authorization,
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<TokenResponse, TokenResponse>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<IntrospectTokenResponse>> _authIntrospectPost({
    String? authorization,
    required Map<String, String> body,
  }) {
    final Uri $url = Uri.parse('/auth/introspect');
    final Map<String, String> $headers = {
      if (authorization != null) 'authorization': authorization,
      'content-type': 'application/x-www-form-urlencoded',
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<IntrospectTokenResponse, IntrospectTokenResponse>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<dynamic>> _authUserinfoGet() {
    final Uri $url = Uri.parse('/auth/userinfo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _oidcAuthorizationFlowJwksUriGet() {
    final Uri $url = Uri.parse('/oidc/authorization-flow/jwks_uri');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _wellKnownOauthAuthorizationServerGet() {
    final Uri $url = Uri.parse('/.well-known/oauth-authorization-server');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _wellKnownOpenidConfigurationGet() {
    final Uri $url = Uri.parse('/.well-known/openid-configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CoreUserSimple>>> _usersGet(
      {List<Object?>? accountTypes}) {
    final Uri $url = Uri.parse('/users');
    final Map<String, dynamic> $params = <String, dynamic>{
      'accountTypes': accountTypes
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<CoreUserSimple>, CoreUserSimple>($request);
  }

  @override
  Future<Response<int>> _usersCountGet() {
    final Uri $url = Uri.parse('/users/count');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<int, int>($request);
  }

  @override
  Future<Response<List<CoreUserSimple>>> _usersSearchGet({
    required String? query,
    List<Object?>? includedAccountTypes,
    List<Object?>? excludedAccountTypes,
    List<String>? includedGroups,
    List<String>? excludedGroups,
  }) {
    final Uri $url = Uri.parse('/users/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'includedAccountTypes': includedAccountTypes,
      'excludedAccountTypes': excludedAccountTypes,
      'includedGroups': includedGroups,
      'excludedGroups': excludedGroups,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<CoreUserSimple>, CoreUserSimple>($request);
  }

  @override
  Future<Response<List<InvalidType>>> _usersAccountTypesGet() {
    final Uri $url = Uri.parse('/users/account-types');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<InvalidType>, List<InvalidType>>($request);
  }

  @override
  Future<Response<CoreUser>> _usersMeGet() {
    final Uri $url = Uri.parse('/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CoreUser, CoreUser>($request);
  }

  @override
  Future<Response<dynamic>> _usersMePatch({required CoreUserUpdate? body}) {
    final Uri $url = Uri.parse('/users/me');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersCreatePost(
      {required CoreUserCreateRequest? body}) {
    final Uri $url = Uri.parse('/users/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<BatchResult>> _usersBatchCreationPost(
      {required List<CoreBatchUserCreateRequest>? body}) {
    final Uri $url = Uri.parse('/users/batch-creation');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BatchResult, BatchResult>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersActivatePost(
      {required CoreUserActivateRequest? body}) {
    final Uri $url = Uri.parse('/users/activate');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersMakeAdminPost() {
    final Uri $url = Uri.parse('/users/make-admin');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersRecoverPost(
      {required BodyRecoverUserUsersRecoverPost? body}) {
    final Uri $url = Uri.parse('/users/recover');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersResetPasswordPost(
      {required ResetPasswordRequest? body}) {
    final Uri $url = Uri.parse('/users/reset-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<dynamic>> _usersMigrateMailPost(
      {required MailMigrationRequest? body}) {
    final Uri $url = Uri.parse('/users/migrate-mail');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMigrateMailConfirmGet(
      {required String? token}) {
    final Uri $url = Uri.parse('/users/migrate-mail-confirm');
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersChangePasswordPost(
      {required ChangePasswordRequest? body}) {
    final Uri $url = Uri.parse('/users/change-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<CoreUser>> _usersUserIdGet({required String? userId}) {
    final Uri $url = Uri.parse('/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CoreUser, CoreUser>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdPatch({
    required String? userId,
    required CoreUserUpdateAdmin? body,
  }) {
    final Uri $url = Uri.parse('/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMeAskDeletionPost() {
    final Uri $url = Uri.parse('/users/me/ask-deletion');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMergePost(
      {required CoreUserFusionRequest? body}) {
    final Uri $url = Uri.parse('/users/merge');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMeProfilePictureGet() {
    final Uri $url = Uri.parse('/users/me/profile-picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersMeProfilePicturePost(
      {required BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost
          body}) {
    final Uri $url = Uri.parse('/users/me/profile-picture');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdProfilePictureGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/users/${userId}/profile-picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CoreSchool>>> _schoolsGet() {
    final Uri $url = Uri.parse('/schools/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CoreSchool>, CoreSchool>($request);
  }

  @override
  Future<Response<CoreSchool>> _schoolsPost({required CoreSchoolBase? body}) {
    final Uri $url = Uri.parse('/schools/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CoreSchool, CoreSchool>($request);
  }

  @override
  Future<Response<CoreSchool>> _schoolsSchoolIdGet(
      {required String? schoolId}) {
    final Uri $url = Uri.parse('/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CoreSchool, CoreSchool>($request);
  }

  @override
  Future<Response<dynamic>> _schoolsSchoolIdPatch({
    required String? schoolId,
    required CoreSchoolUpdate? body,
  }) {
    final Uri $url = Uri.parse('/schools/${schoolId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _schoolsSchoolIdDelete(
      {required String? schoolId}) {
    final Uri $url = Uri.parse('/schools/${schoolId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CoreInformation>> _informationGet() {
    final Uri $url = Uri.parse('/information');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CoreInformation, CoreInformation>($request);
  }

  @override
  Future<Response<dynamic>> _privacyGet() {
    final Uri $url = Uri.parse('/privacy');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _termsAndConditionsGet() {
    final Uri $url = Uri.parse('/terms-and-conditions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _supportGet() {
    final Uri $url = Uri.parse('/support');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _securityTxtGet() {
    final Uri $url = Uri.parse('/security.txt');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _wellKnownSecurityTxtGet() {
    final Uri $url = Uri.parse('/.well-known/security.txt');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _robotsTxtGet() {
    final Uri $url = Uri.parse('/robots.txt');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _styleFileCssGet({required String? file}) {
    final Uri $url = Uri.parse('/style/${file}.css');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _faviconIcoGet() {
    final Uri $url = Uri.parse('/favicon.ico');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ModuleVisibility>>> _moduleVisibilityGet() {
    final Uri $url = Uri.parse('/module-visibility/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ModuleVisibility>, ModuleVisibility>($request);
  }

  @override
  Future<Response<dynamic>> _moduleVisibilityPost(
      {required ModuleVisibilityCreate? body}) {
    final Uri $url = Uri.parse('/module-visibility/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _moduleVisibilityMeGet() {
    final Uri $url = Uri.parse('/module-visibility/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _moduleVisibilityRootGroupsGroupIdDelete({
    required String? root,
    required String? groupId,
  }) {
    final Uri $url = Uri.parse('/module-visibility/${root}/groups/${groupId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _moduleVisibilityRootAccountTypesAccountTypeDelete({
    required String? root,
    required String? accountType,
  }) {
    final Uri $url =
        Uri.parse('/module-visibility/${root}/account-types/${accountType}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _paymentHelloassoWebhookPost() {
    final Uri $url = Uri.parse('/payment/helloasso/webhook');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CoreGroupSimple>>> _groupsGet() {
    final Uri $url = Uri.parse('/groups/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CoreGroupSimple>, CoreGroupSimple>($request);
  }

  @override
  Future<Response<CoreGroupSimple>> _groupsPost(
      {required CoreGroupCreate? body}) {
    final Uri $url = Uri.parse('/groups/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CoreGroupSimple, CoreGroupSimple>($request);
  }

  @override
  Future<Response<CoreGroup>> _groupsGroupIdGet({required String? groupId}) {
    final Uri $url = Uri.parse('/groups/${groupId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CoreGroup, CoreGroup>($request);
  }

  @override
  Future<Response<dynamic>> _groupsGroupIdPatch({
    required String? groupId,
    required CoreGroupUpdate? body,
  }) {
    final Uri $url = Uri.parse('/groups/${groupId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsGroupIdDelete({required String? groupId}) {
    final Uri $url = Uri.parse('/groups/${groupId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CoreGroup>> _groupsMembershipPost(
      {required CoreMembership? body}) {
    final Uri $url = Uri.parse('/groups/membership');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CoreGroup, CoreGroup>($request);
  }

  @override
  Future<Response<dynamic>> _groupsMembershipDelete(
      {required CoreMembershipDelete? body}) {
    final Uri $url = Uri.parse('/groups/membership');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsBatchMembershipPost(
      {required CoreBatchMembership? body}) {
    final Uri $url = Uri.parse('/groups/batch-membership');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsBatchMembershipDelete(
      {required CoreBatchDeleteMembership? body}) {
    final Uri $url = Uri.parse('/groups/batch-membership');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<MembershipSimple>>> _membershipsGet() {
    final Uri $url = Uri.parse('/memberships/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<MembershipSimple>, MembershipSimple>($request);
  }

  @override
  Future<Response<MembershipSimple>> _membershipsPost(
      {required AppCoreMembershipsSchemasMembershipsMembershipBase? body}) {
    final Uri $url = Uri.parse('/memberships/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MembershipSimple, MembershipSimple>($request);
  }

  @override
  Future<Response<List<UserMembershipComplete>>>
      _membershipsAssociationMembershipIdMembersGet({
    required String? associationMembershipId,
    String? minimalStartDate,
    String? maximalStartDate,
    String? minimalEndDate,
    String? maximalEndDate,
  }) {
    final Uri $url =
        Uri.parse('/memberships/${associationMembershipId}/members');
    final Map<String, dynamic> $params = <String, dynamic>{
      'minimalStartDate': minimalStartDate,
      'maximalStartDate': maximalStartDate,
      'minimalEndDate': minimalEndDate,
      'maximalEndDate': maximalEndDate,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<UserMembershipComplete>, UserMembershipComplete>($request);
  }

  @override
  Future<Response<dynamic>> _membershipsAssociationMembershipIdPatch({
    required String? associationMembershipId,
    required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
  }) {
    final Uri $url = Uri.parse('/memberships/${associationMembershipId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _membershipsAssociationMembershipIdDelete(
      {required String? associationMembershipId}) {
    final Uri $url = Uri.parse('/memberships/${associationMembershipId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserMembershipComplete>>> _membershipsUsersUserIdGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/memberships/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<UserMembershipComplete>, UserMembershipComplete>($request);
  }

  @override
  Future<Response<UserMembershipComplete>> _membershipsUsersUserIdPost({
    required String? userId,
    required UserMembershipBase? body,
  }) {
    final Uri $url = Uri.parse('/memberships/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<UserMembershipComplete, UserMembershipComplete>($request);
  }

  @override
  Future<Response<List<UserMembershipComplete>>>
      _membershipsUsersUserIdAssociationMembershipIdGet({
    required String? userId,
    required String? associationMembershipId,
  }) {
    final Uri $url =
        Uri.parse('/memberships/users/${userId}/${associationMembershipId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<UserMembershipComplete>, UserMembershipComplete>($request);
  }

  @override
  Future<Response<List<MembershipUserMappingEmail>>>
      _membershipsAssociationMembershipIdAddBatchPost({
    required String? associationMembershipId,
    required List<MembershipUserMappingEmail>? body,
  }) {
    final Uri $url =
        Uri.parse('/memberships/${associationMembershipId}/add-batch/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<MembershipUserMappingEmail>,
        MembershipUserMappingEmail>($request);
  }

  @override
  Future<Response<dynamic>> _membershipsUsersMembershipIdPatch({
    required String? membershipId,
    required UserMembershipEdit? body,
  }) {
    final Uri $url = Uri.parse('/memberships/users/${membershipId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _membershipsUsersMembershipIdDelete(
      {required String? membershipId}) {
    final Uri $url = Uri.parse('/memberships/users/${membershipId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RaffleComplete>>> _tombolaRafflesGet() {
    final Uri $url = Uri.parse('/tombola/raffles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RaffleComplete>, RaffleComplete>($request);
  }

  @override
  Future<Response<RaffleComplete>> _tombolaRafflesPost(
      {required RaffleBase? body}) {
    final Uri $url = Uri.parse('/tombola/raffles');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RaffleComplete, RaffleComplete>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdPatch({
    required String? raffleId,
    required RaffleEdit? body,
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdDelete(
      {required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RaffleComplete>>> _tombolaGroupGroupIdRafflesGet(
      {required String? groupId}) {
    final Uri $url = Uri.parse('/tombola/group/${groupId}/raffles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RaffleComplete>, RaffleComplete>($request);
  }

  @override
  Future<Response<RaffleStats>> _tombolaRafflesRaffleIdStatsGet(
      {required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/stats');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RaffleStats, RaffleStats>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
      _tombolaRafflesRaffleIdLogoPost({
    required String? raffleId,
    required BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost body,
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/logo');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdLogoGet(
      {required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/logo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PackTicketSimple>>> _tombolaPackTicketsGet() {
    final Uri $url = Uri.parse('/tombola/pack_tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PackTicketSimple>, PackTicketSimple>($request);
  }

  @override
  Future<Response<PackTicketSimple>> _tombolaPackTicketsPost(
      {required PackTicketBase? body}) {
    final Uri $url = Uri.parse('/tombola/pack_tickets');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PackTicketSimple, PackTicketSimple>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPackTicketsPackticketIdPatch({
    required String? packticketId,
    required PackTicketEdit? body,
  }) {
    final Uri $url = Uri.parse('/tombola/pack_tickets/${packticketId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPackTicketsPackticketIdDelete(
      {required String? packticketId}) {
    final Uri $url = Uri.parse('/tombola/pack_tickets/${packticketId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PackTicketSimple>>>
      _tombolaRafflesRaffleIdPackTicketsGet({required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/pack_tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PackTicketSimple>, PackTicketSimple>($request);
  }

  @override
  Future<Response<List<TicketSimple>>> _tombolaTicketsGet() {
    final Uri $url = Uri.parse('/tombola/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TicketSimple>, TicketSimple>($request);
  }

  @override
  Future<Response<List<TicketComplete>>> _tombolaTicketsBuyPackIdPost(
      {required String? packId}) {
    final Uri $url = Uri.parse('/tombola/tickets/buy/${packId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<List<TicketComplete>, TicketComplete>($request);
  }

  @override
  Future<Response<List<TicketComplete>>> _tombolaUsersUserIdTicketsGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TicketComplete>, TicketComplete>($request);
  }

  @override
  Future<Response<List<TicketComplete>>> _tombolaRafflesRaffleIdTicketsGet(
      {required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TicketComplete>, TicketComplete>($request);
  }

  @override
  Future<Response<List<PrizeSimple>>> _tombolaPrizesGet() {
    final Uri $url = Uri.parse('/tombola/prizes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PrizeSimple>, PrizeSimple>($request);
  }

  @override
  Future<Response<PrizeSimple>> _tombolaPrizesPost({required PrizeBase? body}) {
    final Uri $url = Uri.parse('/tombola/prizes');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PrizeSimple, PrizeSimple>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPrizesPrizeIdPatch({
    required String? prizeId,
    required PrizeEdit? body,
  }) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPrizesPrizeIdDelete(
      {required String? prizeId}) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PrizeSimple>>> _tombolaRafflesRaffleIdPrizesGet(
      {required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/prizes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PrizeSimple>, PrizeSimple>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
      _tombolaPrizesPrizeIdPicturePost({
    required String? prizeId,
    required BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost body,
  }) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}/picture');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPrizesPrizeIdPictureGet(
      {required String? prizeId}) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}/picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CashComplete>>> _tombolaUsersCashGet() {
    final Uri $url = Uri.parse('/tombola/users/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CashComplete>, CashComplete>($request);
  }

  @override
  Future<Response<CashComplete>> _tombolaUsersUserIdCashGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CashComplete, CashComplete>($request);
  }

  @override
  Future<Response<CashComplete>> _tombolaUsersUserIdCashPost({
    required String? userId,
    required CashEdit? body,
  }) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CashComplete, CashComplete>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaUsersUserIdCashPatch({
    required String? userId,
    required CashEdit? body,
  }) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TicketComplete>>> _tombolaPrizesPrizeIdDrawPost(
      {required String? prizeId}) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}/draw');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<List<TicketComplete>, TicketComplete>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdOpenPatch(
      {required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/open');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdLockPatch(
      {required String? raffleId}) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/lock');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<FlappyBirdScoreInDB>>> _flappybirdScoresGet() {
    final Uri $url = Uri.parse('/flappybird/scores');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<FlappyBirdScoreInDB>, FlappyBirdScoreInDB>($request);
  }

  @override
  Future<Response<FlappyBirdScoreBase>> _flappybirdScoresPost(
      {required FlappyBirdScoreBase? body}) {
    final Uri $url = Uri.parse('/flappybird/scores');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<FlappyBirdScoreBase, FlappyBirdScoreBase>($request);
  }

  @override
  Future<Response<FlappyBirdScoreCompleteFeedBack>> _flappybirdScoresMeGet() {
    final Uri $url = Uri.parse('/flappybird/scores/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<FlappyBirdScoreCompleteFeedBack,
        FlappyBirdScoreCompleteFeedBack>($request);
  }

  @override
  Future<Response<dynamic>> _flappybirdScoresTargetedUserIdDelete(
      {required String? targetedUserId}) {
    final Uri $url = Uri.parse('/flappybird/scores/${targetedUserId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdPdfGet({required String? paperId}) {
    final Uri $url = Uri.parse('/ph/${paperId}/pdf');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdPdfPost({
    required String? paperId,
    required BodyCreatePaperPdfAndCoverPhPaperIdPdfPost body,
  }) {
    final Uri $url = Uri.parse('/ph/${paperId}/pdf');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyCreatePaperPdfAndCoverPhPaperIdPdfPost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PaperComplete>>> _phGet() {
    final Uri $url = Uri.parse('/ph/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PaperComplete>, PaperComplete>($request);
  }

  @override
  Future<Response<PaperComplete>> _phPost({required PaperBase? body}) {
    final Uri $url = Uri.parse('/ph/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PaperComplete, PaperComplete>($request);
  }

  @override
  Future<Response<List<PaperComplete>>> _phAdminGet() {
    final Uri $url = Uri.parse('/ph/admin');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PaperComplete>, PaperComplete>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdCoverGet({required String? paperId}) {
    final Uri $url = Uri.parse('/ph/${paperId}/cover');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdPatch({
    required String? paperId,
    required PaperUpdate? body,
  }) {
    final Uri $url = Uri.parse('/ph/${paperId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdDelete({required String? paperId}) {
    final Uri $url = Uri.parse('/ph/${paperId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TheMovieDB>> _cinemaThemoviedbThemoviedbIdGet(
      {required String? themoviedbId}) {
    final Uri $url = Uri.parse('/cinema/themoviedb/${themoviedbId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TheMovieDB, TheMovieDB>($request);
  }

  @override
  Future<Response<List<CineSessionComplete>>> _cinemaSessionsGet() {
    final Uri $url = Uri.parse('/cinema/sessions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<CineSessionComplete>, CineSessionComplete>($request);
  }

  @override
  Future<Response<CineSessionComplete>> _cinemaSessionsPost(
      {required CineSessionBase? body}) {
    final Uri $url = Uri.parse('/cinema/sessions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CineSessionComplete, CineSessionComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cinemaSessionsSessionIdPatch({
    required String? sessionId,
    required CineSessionUpdate? body,
  }) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cinemaSessionsSessionIdDelete(
      {required String? sessionId}) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
      _cinemaSessionsSessionIdPosterPost({
    required String? sessionId,
    required BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost body,
  }) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}/poster');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<dynamic>> _cinemaSessionsSessionIdPosterGet(
      {required String? sessionId}) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}/poster');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<EventReturn>>> _calendarEventsGet() {
    final Uri $url = Uri.parse('/calendar/events/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<EventReturn>, EventReturn>($request);
  }

  @override
  Future<Response<EventReturn>> _calendarEventsPost(
      {required EventBase? body}) {
    final Uri $url = Uri.parse('/calendar/events/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<EventReturn, EventReturn>($request);
  }

  @override
  Future<Response<List<EventComplete>>> _calendarEventsConfirmedGet() {
    final Uri $url = Uri.parse('/calendar/events/confirmed');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<EventComplete>, EventComplete>($request);
  }

  @override
  Future<Response<List<EventReturn>>> _calendarEventsUserApplicantIdGet(
      {required String? applicantId}) {
    final Uri $url = Uri.parse('/calendar/events/user/${applicantId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<EventReturn>, EventReturn>($request);
  }

  @override
  Future<Response<EventComplete>> _calendarEventsEventIdGet(
      {required String? eventId}) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<EventComplete, EventComplete>($request);
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdPatch({
    required String? eventId,
    required EventEdit? body,
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdDelete(
      {required Object? eventId}) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EventApplicant>> _calendarEventsEventIdApplicantGet(
      {required String? eventId}) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}/applicant');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<EventApplicant, EventApplicant>($request);
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdReplyDecisionPatch({
    required String? eventId,
    required String? decision,
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}/reply/${decision}');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _calendarIcalCreatePost() {
    final Uri $url = Uri.parse('/calendar/ical/create');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _calendarIcalGet() {
    final Uri $url = Uri.parse('/calendar/ical');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AssociationComplete>>> _phonebookAssociationsGet() {
    final Uri $url = Uri.parse('/phonebook/associations/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<AssociationComplete>, AssociationComplete>($request);
  }

  @override
  Future<Response<AssociationComplete>> _phonebookAssociationsPost(
      {required AssociationBase? body}) {
    final Uri $url = Uri.parse('/phonebook/associations/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AssociationComplete, AssociationComplete>($request);
  }

  @override
  Future<Response<RoleTagsReturn>> _phonebookRoletagsGet() {
    final Uri $url = Uri.parse('/phonebook/roletags');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RoleTagsReturn, RoleTagsReturn>($request);
  }

  @override
  Future<Response<KindsReturn>> _phonebookAssociationsKindsGet() {
    final Uri $url = Uri.parse('/phonebook/associations/kinds');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<KindsReturn, KindsReturn>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdPatch({
    required String? associationId,
    required AssociationEdit? body,
  }) {
    final Uri $url = Uri.parse('/phonebook/associations/${associationId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdDelete(
      {required String? associationId}) {
    final Uri $url = Uri.parse('/phonebook/associations/${associationId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdGroupsPatch({
    required String? associationId,
    required AssociationGroupsEdit? body,
  }) {
    final Uri $url =
        Uri.parse('/phonebook/associations/${associationId}/groups');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdDeactivatePatch(
      {required String? associationId}) {
    final Uri $url =
        Uri.parse('/phonebook/associations/${associationId}/deactivate');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<MemberComplete>>>
      _phonebookAssociationsAssociationIdMembersGet(
          {required String? associationId}) {
    final Uri $url =
        Uri.parse('/phonebook/associations/${associationId}/members/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<MemberComplete>, MemberComplete>($request);
  }

  @override
  Future<Response<List<MemberComplete>>>
      _phonebookAssociationsAssociationIdMembersMandateYearGet({
    required String? associationId,
    required int? mandateYear,
  }) {
    final Uri $url = Uri.parse(
        '/phonebook/associations/${associationId}/members/${mandateYear}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<MemberComplete>, MemberComplete>($request);
  }

  @override
  Future<Response<MemberComplete>> _phonebookMemberUserIdGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/phonebook/member/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MemberComplete, MemberComplete>($request);
  }

  @override
  Future<Response<MembershipComplete>> _phonebookAssociationsMembershipsPost(
      {required AppModulesPhonebookSchemasPhonebookMembershipBase? body}) {
    final Uri $url = Uri.parse('/phonebook/associations/memberships');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MembershipComplete, MembershipComplete>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsMembershipsMembershipIdPatch({
    required String? membershipId,
    required MembershipEdit? body,
  }) {
    final Uri $url =
        Uri.parse('/phonebook/associations/memberships/${membershipId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsMembershipsMembershipIdDelete(
      {required String? membershipId}) {
    final Uri $url =
        Uri.parse('/phonebook/associations/memberships/${membershipId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
      _phonebookAssociationsAssociationIdPicturePost({
    required String? associationId,
    required BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost
        body,
  }) {
    final Uri $url =
        Uri.parse('/phonebook/associations/${associationId}/picture');
    final List<PartValue> $parts = <PartValue>[
      PartValue<
          BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdPictureGet(
      {required String? associationId}) {
    final Uri $url =
        Uri.parse('/phonebook/associations/${associationId}/picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesAmapSchemasAmapProductComplete>>>
      _amapProductsGet() {
    final Uri $url = Uri.parse('/amap/products');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppModulesAmapSchemasAmapProductComplete>,
        AppModulesAmapSchemasAmapProductComplete>($request);
  }

  @override
  Future<Response<AppModulesAmapSchemasAmapProductComplete>> _amapProductsPost(
      {required ProductSimple? body}) {
    final Uri $url = Uri.parse('/amap/products');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppModulesAmapSchemasAmapProductComplete,
        AppModulesAmapSchemasAmapProductComplete>($request);
  }

  @override
  Future<Response<AppModulesAmapSchemasAmapProductComplete>>
      _amapProductsProductIdGet({required String? productId}) {
    final Uri $url = Uri.parse('/amap/products/${productId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AppModulesAmapSchemasAmapProductComplete,
        AppModulesAmapSchemasAmapProductComplete>($request);
  }

  @override
  Future<Response<dynamic>> _amapProductsProductIdPatch({
    required String? productId,
    required AppModulesAmapSchemasAmapProductEdit? body,
  }) {
    final Uri $url = Uri.parse('/amap/products/${productId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapProductsProductIdDelete(
      {required String? productId}) {
    final Uri $url = Uri.parse('/amap/products/${productId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<DeliveryReturn>>> _amapDeliveriesGet() {
    final Uri $url = Uri.parse('/amap/deliveries');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<DeliveryReturn>, DeliveryReturn>($request);
  }

  @override
  Future<Response<DeliveryReturn>> _amapDeliveriesPost(
      {required DeliveryBase? body}) {
    final Uri $url = Uri.parse('/amap/deliveries');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<DeliveryReturn, DeliveryReturn>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdDelete(
      {required String? deliveryId}) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdPatch({
    required String? deliveryId,
    required DeliveryUpdate? body,
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdProductsPost({
    required String? deliveryId,
    required DeliveryProductsUpdate? body,
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/products');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdProductsDelete({
    required String? deliveryId,
    required DeliveryProductsUpdate? body,
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/products');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<OrderReturn>>> _amapDeliveriesDeliveryIdOrdersGet(
      {required String? deliveryId}) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/orders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<OrderReturn>, OrderReturn>($request);
  }

  @override
  Future<Response<OrderReturn>> _amapOrdersOrderIdGet(
      {required String? orderId}) {
    final Uri $url = Uri.parse('/amap/orders/${orderId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<OrderReturn, OrderReturn>($request);
  }

  @override
  Future<Response<dynamic>> _amapOrdersOrderIdPatch({
    required String? orderId,
    required OrderEdit? body,
  }) {
    final Uri $url = Uri.parse('/amap/orders/${orderId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapOrdersOrderIdDelete(
      {required String? orderId}) {
    final Uri $url = Uri.parse('/amap/orders/${orderId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<OrderReturn>> _amapOrdersPost({required OrderBase? body}) {
    final Uri $url = Uri.parse('/amap/orders');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<OrderReturn, OrderReturn>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdOpenorderingPost(
      {required String? deliveryId}) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/openordering');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdLockPost(
      {required String? deliveryId}) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/lock');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdDeliveredPost(
      {required String? deliveryId}) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/delivered');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdArchivePost(
      {required String? deliveryId}) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/archive');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CashComplete>>> _amapUsersCashGet() {
    final Uri $url = Uri.parse('/amap/users/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CashComplete>, CashComplete>($request);
  }

  @override
  Future<Response<CashComplete>> _amapUsersUserIdCashGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CashComplete, CashComplete>($request);
  }

  @override
  Future<Response<CashComplete>> _amapUsersUserIdCashPost({
    required String? userId,
    required CashEdit? body,
  }) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CashComplete, CashComplete>($request);
  }

  @override
  Future<Response<dynamic>> _amapUsersUserIdCashPatch({
    required String? userId,
    required CashEdit? body,
  }) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<OrderReturn>>> _amapUsersUserIdOrdersGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/amap/users/${userId}/orders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<OrderReturn>, OrderReturn>($request);
  }

  @override
  Future<Response<Information>> _amapInformationGet() {
    final Uri $url = Uri.parse('/amap/information');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Information, Information>($request);
  }

  @override
  Future<Response<dynamic>> _amapInformationPatch(
      {required InformationEdit? body}) {
    final Uri $url = Uri.parse('/amap/information');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Participant>> _raidParticipantsParticipantIdGet(
      {required String? participantId}) {
    final Uri $url = Uri.parse('/raid/participants/${participantId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Participant, Participant>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantsParticipantIdPatch({
    required String? participantId,
    required ParticipantUpdate? body,
  }) {
    final Uri $url = Uri.parse('/raid/participants/${participantId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Participant>> _raidParticipantsPost(
      {required ParticipantBase? body}) {
    final Uri $url = Uri.parse('/raid/participants');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Participant, Participant>($request);
  }

  @override
  Future<Response<List<TeamPreview>>> _raidTeamsGet() {
    final Uri $url = Uri.parse('/raid/teams');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<TeamPreview>, TeamPreview>($request);
  }

  @override
  Future<Response<Team>> _raidTeamsPost({required TeamBase? body}) {
    final Uri $url = Uri.parse('/raid/teams');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsDelete() {
    final Uri $url = Uri.parse('/raid/teams');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsGeneratePdfPost() {
    final Uri $url = Uri.parse('/raid/teams/generate-pdf');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Team>> _raidParticipantsParticipantIdTeamGet(
      {required String? participantId}) {
    final Uri $url = Uri.parse('/raid/participants/${participantId}/team');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<Team>> _raidTeamsTeamIdGet({required String? teamId}) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsTeamIdPatch({
    required String? teamId,
    required TeamUpdate? body,
  }) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsTeamIdDelete({required String? teamId}) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DocumentCreation>> _raidDocumentDocumentTypePost({
    required String? documentType,
    required BodyUploadDocumentRaidDocumentDocumentTypePost body,
  }) {
    final Uri $url = Uri.parse('/raid/document/${documentType}');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyUploadDocumentRaidDocumentDocumentTypePost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<DocumentCreation, DocumentCreation>($request);
  }

  @override
  Future<Response<dynamic>> _raidDocumentDocumentIdGet(
      {required String? documentId}) {
    final Uri $url = Uri.parse('/raid/document/${documentId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidDocumentDocumentIdValidatePost({
    required String? documentId,
    required String? validation,
  }) {
    final Uri $url = Uri.parse('/raid/document/${documentId}/validate');
    final Map<String, dynamic> $params = <String, dynamic>{
      'validation': validation
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SecurityFile>> _raidSecurityFilePost({
    required String? participantId,
    required SecurityFileBase? body,
  }) {
    final Uri $url = Uri.parse('/raid/security_file/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'participant_id': participantId
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SecurityFile, SecurityFile>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantParticipantIdPaymentPost(
      {required String? participantId}) {
    final Uri $url = Uri.parse('/raid/participant/${participantId}/payment');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantParticipantIdTShirtPaymentPost(
      {required String? participantId}) {
    final Uri $url =
        Uri.parse('/raid/participant/${participantId}/t_shirt_payment');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantParticipantIdHonourPost(
      {required String? participantId}) {
    final Uri $url = Uri.parse('/raid/participant/${participantId}/honour');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<InviteToken>> _raidTeamsTeamIdInvitePost(
      {required String? teamId}) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}/invite');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<InviteToken, InviteToken>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsJoinTokenPost({required String? token}) {
    final Uri $url = Uri.parse('/raid/teams/join/${token}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Team>> _raidTeamsTeamIdKickParticipantIdPost({
    required String? teamId,
    required String? participantId,
  }) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}/kick/${participantId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<Team>> _raidTeamsMergePost({
    required String? team1Id,
    required String? team2Id,
  }) {
    final Uri $url = Uri.parse('/raid/teams/merge');
    final Map<String, dynamic> $params = <String, dynamic>{
      'team1_id': team1Id,
      'team2_id': team2Id,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<RaidInformation>> _raidInformationGet() {
    final Uri $url = Uri.parse('/raid/information');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RaidInformation, RaidInformation>($request);
  }

  @override
  Future<Response<dynamic>> _raidInformationPatch(
      {required RaidInformation? body}) {
    final Uri $url = Uri.parse('/raid/information');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidDriveFoldersCreation>> _raidDriveGet() {
    final Uri $url = Uri.parse('/raid/drive');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<RaidDriveFoldersCreation, RaidDriveFoldersCreation>($request);
  }

  @override
  Future<Response<dynamic>> _raidDrivePatch(
      {required RaidDriveFoldersCreation? body}) {
    final Uri $url = Uri.parse('/raid/drive');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidPrice>> _raidPriceGet() {
    final Uri $url = Uri.parse('/raid/price');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<RaidPrice, RaidPrice>($request);
  }

  @override
  Future<Response<dynamic>> _raidPricePatch({required RaidPrice? body}) {
    final Uri $url = Uri.parse('/raid/price');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaymentUrl>> _raidPayGet() {
    final Uri $url = Uri.parse('/raid/pay');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<List<CdrUserPreview>>> _cdrUsersGet() {
    final Uri $url = Uri.parse('/cdr/users/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CdrUserPreview>, CdrUserPreview>($request);
  }

  @override
  Future<Response<List<CdrUserPreview>>> _cdrUsersPendingGet() {
    final Uri $url = Uri.parse('/cdr/users/pending/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CdrUserPreview>, CdrUserPreview>($request);
  }

  @override
  Future<Response<CdrUser>> _cdrUsersUserIdGet({required String? userId}) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CdrUser, CdrUser>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdPatch({
    required String? userId,
    required CdrUserUpdate? body,
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SellerComplete>>> _cdrSellersGet() {
    final Uri $url = Uri.parse('/cdr/sellers/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SellerComplete>, SellerComplete>($request);
  }

  @override
  Future<Response<SellerComplete>> _cdrSellersPost(
      {required SellerBase? body}) {
    final Uri $url = Uri.parse('/cdr/sellers/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SellerComplete, SellerComplete>($request);
  }

  @override
  Future<Response<List<SellerComplete>>> _cdrUsersMeSellersGet() {
    final Uri $url = Uri.parse('/cdr/users/me/sellers/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SellerComplete>, SellerComplete>($request);
  }

  @override
  Future<Response<List<SellerComplete>>> _cdrOnlineSellersGet() {
    final Uri $url = Uri.parse('/cdr/online/sellers/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SellerComplete>, SellerComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdResultsGet(
      {required String? sellerId}) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/results/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
      _cdrOnlineProductsGet() {
    final Uri $url = Uri.parse('/cdr/online/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppModulesCdrSchemasCdrProductComplete>,
        AppModulesCdrSchemasCdrProductComplete>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
      _cdrProductsGet() {
    final Uri $url = Uri.parse('/cdr/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppModulesCdrSchemasCdrProductComplete>,
        AppModulesCdrSchemasCdrProductComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdPatch({
    required String? sellerId,
    required SellerEdit? body,
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdDelete(
      {required String? sellerId}) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
      _cdrSellersSellerIdProductsGet({required String? sellerId}) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppModulesCdrSchemasCdrProductComplete>,
        AppModulesCdrSchemasCdrProductComplete>($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrProductComplete>>
      _cdrSellersSellerIdProductsPost({
    required String? sellerId,
    required ProductBase? body,
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/products/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppModulesCdrSchemasCdrProductComplete,
        AppModulesCdrSchemasCdrProductComplete>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
      _cdrOnlineSellersSellerIdProductsGet({required String? sellerId}) {
    final Uri $url = Uri.parse('/cdr/online/sellers/${sellerId}/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppModulesCdrSchemasCdrProductComplete>,
        AppModulesCdrSchemasCdrProductComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdProductsProductIdPatch({
    required String? sellerId,
    required String? productId,
    required AppModulesCdrSchemasCdrProductEdit? body,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/products/${productId}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdProductsProductIdDelete({
    required String? sellerId,
    required String? productId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/products/${productId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ProductVariantComplete>>
      _cdrSellersSellerIdProductsProductIdVariantsPost({
    required String? sellerId,
    required String? productId,
    required ProductVariantBase? body,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/products/${productId}/variants/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ProductVariantComplete, ProductVariantComplete>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrSellersSellerIdProductsProductIdVariantsVariantIdPatch({
    required String? sellerId,
    required String? productId,
    required String? variantId,
    required ProductVariantEdit? body,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/variants/${variantId}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrSellersSellerIdProductsProductIdVariantsVariantIdDelete({
    required String? sellerId,
    required String? productId,
    required String? variantId,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/variants/${variantId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<DocumentComplete>>> _cdrSellersSellerIdDocumentsGet(
      {required String? sellerId}) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/documents/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<DocumentComplete>, DocumentComplete>($request);
  }

  @override
  Future<Response<DocumentComplete>> _cdrSellersSellerIdDocumentsPost({
    required String? sellerId,
    required DocumentBase? body,
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/documents/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<DocumentComplete, DocumentComplete>($request);
  }

  @override
  Future<Response<List<DocumentComplete>>> _cdrDocumentsGet() {
    final Uri $url = Uri.parse('/cdr/documents/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<DocumentComplete>, DocumentComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdDocumentsDocumentIdDelete({
    required String? sellerId,
    required String? documentId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/documents/${documentId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PurchaseReturn>>> _cdrUsersUserIdPurchasesGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/purchases/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PurchaseReturn>, PurchaseReturn>($request);
  }

  @override
  Future<Response<List<PurchaseReturn>>> _cdrMePurchasesGet() {
    final Uri $url = Uri.parse('/cdr/me/purchases/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PurchaseReturn>, PurchaseReturn>($request);
  }

  @override
  Future<Response<List<PurchaseReturn>>>
      _cdrSellersSellerIdUsersUserIdPurchasesGet({
    required String? sellerId,
    required String? userId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/users/${userId}/purchases/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PurchaseReturn>, PurchaseReturn>($request);
  }

  @override
  Future<Response<PurchaseComplete>>
      _cdrUsersUserIdPurchasesProductVariantIdPost({
    required String? userId,
    required String? productVariantId,
    required PurchaseBase? body,
  }) {
    final Uri $url =
        Uri.parse('/cdr/users/${userId}/purchases/${productVariantId}/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PurchaseComplete, PurchaseComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdPurchasesProductVariantIdDelete({
    required String? userId,
    required String? productVariantId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/users/${userId}/purchases/${productVariantId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrUsersUserIdPurchasesProductVariantIdValidatedPatch({
    required String? userId,
    required String? productVariantId,
    required bool? validated,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/users/${userId}/purchases/${productVariantId}/validated/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'validated': validated
    };
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SignatureComplete>>> _cdrUsersUserIdSignaturesGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/signatures/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SignatureComplete>, SignatureComplete>($request);
  }

  @override
  Future<Response<List<SignatureComplete>>>
      _cdrSellersSellerIdUsersUserIdSignaturesGet({
    required String? sellerId,
    required String? userId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/users/${userId}/signatures/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SignatureComplete>, SignatureComplete>($request);
  }

  @override
  Future<Response<SignatureComplete>> _cdrUsersUserIdSignaturesDocumentIdPost({
    required String? userId,
    required String? documentId,
    required SignatureBase? body,
  }) {
    final Uri $url =
        Uri.parse('/cdr/users/${userId}/signatures/${documentId}/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SignatureComplete, SignatureComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdSignaturesDocumentIdDelete({
    required String? userId,
    required String? documentId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/users/${userId}/signatures/${documentId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CurriculumComplete>>> _cdrCurriculumsGet() {
    final Uri $url = Uri.parse('/cdr/curriculums/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CurriculumComplete>, CurriculumComplete>($request);
  }

  @override
  Future<Response<CurriculumComplete>> _cdrCurriculumsPost(
      {required CurriculumBase? body}) {
    final Uri $url = Uri.parse('/cdr/curriculums/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CurriculumComplete, CurriculumComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrCurriculumsCurriculumIdDelete(
      {required String? curriculumId}) {
    final Uri $url = Uri.parse('/cdr/curriculums/${curriculumId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdCurriculumsCurriculumIdPost({
    required String? userId,
    required String? curriculumId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/users/${userId}/curriculums/${curriculumId}/');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdCurriculumsCurriculumIdPatch({
    required String? userId,
    required String? curriculumId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/users/${userId}/curriculums/${curriculumId}/');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdCurriculumsCurriculumIdDelete({
    required String? userId,
    required String? curriculumId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/users/${userId}/curriculums/${curriculumId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PaymentComplete>>> _cdrUsersUserIdPaymentsGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/payments/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PaymentComplete>, PaymentComplete>($request);
  }

  @override
  Future<Response<PaymentComplete>> _cdrUsersUserIdPaymentsPost({
    required String? userId,
    required PaymentBase? body,
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/payments/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PaymentComplete, PaymentComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdPaymentsPaymentIdDelete({
    required String? userId,
    required String? paymentId,
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/payments/${paymentId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaymentUrl>> _cdrPayPost() {
    final Uri $url = Uri.parse('/cdr/pay/');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<Status>> _cdrStatusGet() {
    final Uri $url = Uri.parse('/cdr/status/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<dynamic>> _cdrStatusPatch({required Status? body}) {
    final Uri $url = Uri.parse('/cdr/status/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Ticket>>> _cdrUsersMeTicketsGet() {
    final Uri $url = Uri.parse('/cdr/users/me/tickets/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Ticket>, Ticket>($request);
  }

  @override
  Future<Response<List<Ticket>>> _cdrUsersUserIdTicketsGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/tickets/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Ticket>, Ticket>($request);
  }

  @override
  Future<Response<TicketSecret>> _cdrUsersMeTicketsTicketIdSecretGet(
      {required String? ticketId}) {
    final Uri $url = Uri.parse('/cdr/users/me/tickets/${ticketId}/secret/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TicketSecret, TicketSecret>($request);
  }

  @override
  Future<Response<Ticket>>
      _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? secret,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/tickets/${generatorId}/${secret}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Ticket, Ticket>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? secret,
    required TicketScan? body,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/tickets/${generatorId}/${secret}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CoreUserSimple>>>
      _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdListsTagGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? tag,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/tickets/${generatorId}/lists/${tag}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CoreUserSimple>, CoreUserSimple>($request);
  }

  @override
  Future<Response<List<String>>>
      _cdrSellersSellerIdProductsProductIdTagsGeneratorIdGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/tags/${generatorId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrProductComplete>>
      _cdrSellersSellerIdProductsProductIdTicketsPost({
    required String? sellerId,
    required String? productId,
    required GenerateTicketBase? body,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/products/${productId}/tickets/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppModulesCdrSchemasCdrProductComplete,
        AppModulesCdrSchemasCdrProductComplete>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrSellersSellerIdProductsProductIdTicketsTicketGeneratorIdDelete({
    required String? sellerId,
    required String? productId,
    required String? ticketGeneratorId,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/tickets/${ticketGeneratorId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CustomDataFieldComplete>>>
      _cdrSellersSellerIdProductsProductIdDataGet({
    required String? sellerId,
    required String? productId,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/products/${productId}/data/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<CustomDataFieldComplete>, CustomDataFieldComplete>($request);
  }

  @override
  Future<Response<CustomDataFieldComplete>>
      _cdrSellersSellerIdProductsProductIdDataPost({
    required String? sellerId,
    required String? productId,
    required CustomDataFieldBase? body,
  }) {
    final Uri $url =
        Uri.parse('/cdr/sellers/${sellerId}/products/${productId}/data/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<CustomDataFieldComplete, CustomDataFieldComplete>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrSellersSellerIdProductsProductIdDataFieldIdDelete({
    required String? sellerId,
    required String? productId,
    required String? fieldId,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/data/${fieldId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CustomDataComplete>>
      _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdGet({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CustomDataComplete, CustomDataComplete>($request);
  }

  @override
  Future<Response<CustomDataComplete>>
      _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPost({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
    required CustomDataBase? body,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CustomDataComplete, CustomDataComplete>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPatch({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
    required CustomDataBase? body,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdDelete({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
  }) {
    final Uri $url = Uri.parse(
        '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AdvertiserComplete>>> _advertAdvertisersGet() {
    final Uri $url = Uri.parse('/advert/advertisers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AdvertiserComplete>, AdvertiserComplete>($request);
  }

  @override
  Future<Response<AdvertiserComplete>> _advertAdvertisersPost(
      {required AdvertiserBase? body}) {
    final Uri $url = Uri.parse('/advert/advertisers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AdvertiserComplete, AdvertiserComplete>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertisersAdvertiserIdDelete(
      {required String? advertiserId}) {
    final Uri $url = Uri.parse('/advert/advertisers/${advertiserId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertisersAdvertiserIdPatch({
    required String? advertiserId,
    required AdvertiserUpdate? body,
  }) {
    final Uri $url = Uri.parse('/advert/advertisers/${advertiserId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AdvertiserComplete>>> _advertMeAdvertisersGet() {
    final Uri $url = Uri.parse('/advert/me/advertisers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AdvertiserComplete>, AdvertiserComplete>($request);
  }

  @override
  Future<Response<List<AdvertReturnComplete>>> _advertAdvertsGet(
      {List<String>? advertisers}) {
    final Uri $url = Uri.parse('/advert/adverts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'advertisers': advertisers
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AdvertReturnComplete>, AdvertReturnComplete>($request);
  }

  @override
  Future<Response<AdvertReturnComplete>> _advertAdvertsPost(
      {required AdvertBase? body}) {
    final Uri $url = Uri.parse('/advert/adverts');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AdvertReturnComplete, AdvertReturnComplete>($request);
  }

  @override
  Future<Response<AdvertReturnComplete>> _advertAdvertsAdvertIdGet(
      {required String? advertId}) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AdvertReturnComplete, AdvertReturnComplete>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertsAdvertIdPatch({
    required String? advertId,
    required AdvertUpdate? body,
  }) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertsAdvertIdDelete(
      {required String? advertId}) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertsAdvertIdPictureGet(
      {required String? advertId}) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}/picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
      _advertAdvertsAdvertIdPicturePost({
    required String? advertId,
    required BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost body,
  }) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}/picture');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<List<SectionComplete>>> _campaignSectionsGet() {
    final Uri $url = Uri.parse('/campaign/sections');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SectionComplete>, SectionComplete>($request);
  }

  @override
  Future<Response<SectionComplete>> _campaignSectionsPost(
      {required SectionBase? body}) {
    final Uri $url = Uri.parse('/campaign/sections');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SectionComplete, SectionComplete>($request);
  }

  @override
  Future<Response<dynamic>> _campaignSectionsSectionIdDelete(
      {required String? sectionId}) {
    final Uri $url = Uri.parse('/campaign/sections/${sectionId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ListReturn>>> _campaignListsGet() {
    final Uri $url = Uri.parse('/campaign/lists');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ListReturn>, ListReturn>($request);
  }

  @override
  Future<Response<ListReturn>> _campaignListsPost({required ListBase? body}) {
    final Uri $url = Uri.parse('/campaign/lists');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ListReturn, ListReturn>($request);
  }

  @override
  Future<Response<dynamic>> _campaignListsListIdDelete(
      {required String? listId}) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignListsListIdPatch({
    required String? listId,
    required ListEdit? body,
  }) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignListsDelete({Object? listType}) {
    final Uri $url = Uri.parse('/campaign/lists/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'list_type': listType
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<VoterGroup>>> _campaignVotersGet() {
    final Uri $url = Uri.parse('/campaign/voters');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<VoterGroup>, VoterGroup>($request);
  }

  @override
  Future<Response<VoterGroup>> _campaignVotersPost(
      {required VoterGroup? body}) {
    final Uri $url = Uri.parse('/campaign/voters');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<VoterGroup, VoterGroup>($request);
  }

  @override
  Future<Response<dynamic>> _campaignVotersDelete() {
    final Uri $url = Uri.parse('/campaign/voters');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignVotersGroupIdDelete(
      {required String? groupId}) {
    final Uri $url = Uri.parse('/campaign/voters/${groupId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusOpenPost() {
    final Uri $url = Uri.parse('/campaign/status/open');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusClosePost() {
    final Uri $url = Uri.parse('/campaign/status/close');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusCountingPost() {
    final Uri $url = Uri.parse('/campaign/status/counting');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusPublishedPost() {
    final Uri $url = Uri.parse('/campaign/status/published');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusResetPost() {
    final Uri $url = Uri.parse('/campaign/status/reset');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _campaignVotesGet() {
    final Uri $url = Uri.parse('/campaign/votes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _campaignVotesPost({required VoteBase? body}) {
    final Uri $url = Uri.parse('/campaign/votes');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCampaignSchemasCampaignResult>>>
      _campaignResultsGet() {
    final Uri $url = Uri.parse('/campaign/results');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppModulesCampaignSchemasCampaignResult>,
        AppModulesCampaignSchemasCampaignResult>($request);
  }

  @override
  Future<Response<VoteStatus>> _campaignStatusGet() {
    final Uri $url = Uri.parse('/campaign/status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<VoteStatus, VoteStatus>($request);
  }

  @override
  Future<Response<VoteStats>> _campaignStatsSectionIdGet(
      {required String? sectionId}) {
    final Uri $url = Uri.parse('/campaign/stats/${sectionId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<VoteStats, VoteStats>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
      _campaignListsListIdLogoPost({
    required String? listId,
    required BodyCreateCampaignsLogoCampaignListsListIdLogoPost body,
  }) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}/logo');
    final List<PartValue> $parts = <PartValue>[
      PartValue<BodyCreateCampaignsLogoCampaignListsListIdLogoPost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<dynamic>> _campaignListsListIdLogoGet(
      {required String? listId}) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}/logo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Recommendation>>> _recommendationRecommendationsGet() {
    final Uri $url = Uri.parse('/recommendation/recommendations');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Recommendation>, Recommendation>($request);
  }

  @override
  Future<Response<Recommendation>> _recommendationRecommendationsPost(
      {required RecommendationBase? body}) {
    final Uri $url = Uri.parse('/recommendation/recommendations');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Recommendation, Recommendation>($request);
  }

  @override
  Future<Response<dynamic>>
      _recommendationRecommendationsRecommendationIdPatch({
    required String? recommendationId,
    required RecommendationEdit? body,
  }) {
    final Uri $url =
        Uri.parse('/recommendation/recommendations/${recommendationId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _recommendationRecommendationsRecommendationIdDelete(
          {required String? recommendationId}) {
    final Uri $url =
        Uri.parse('/recommendation/recommendations/${recommendationId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
      _recommendationRecommendationsRecommendationIdPictureGet(
          {required String? recommendationId}) {
    final Uri $url = Uri.parse(
        '/recommendation/recommendations/${recommendationId}/picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
      _recommendationRecommendationsRecommendationIdPicturePost({
    required String? recommendationId,
    required BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost
        body,
  }) {
    final Uri $url = Uri.parse(
        '/recommendation/recommendations/${recommendationId}/picture');
    final List<PartValue> $parts = <PartValue>[
      PartValue<
          BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost>(
        'body',
        body,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<AppTypesStandardResponsesResult,
        AppTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<List<Loaner>>> _loansLoanersGet() {
    final Uri $url = Uri.parse('/loans/loaners/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Loaner>, Loaner>($request);
  }

  @override
  Future<Response<Loaner>> _loansLoanersPost({required LoanerBase? body}) {
    final Uri $url = Uri.parse('/loans/loaners/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Loaner, Loaner>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdDelete(
      {required String? loanerId}) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdPatch({
    required String? loanerId,
    required LoanerUpdate? body,
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Loan>>> _loansLoanersLoanerIdLoansGet({
    required String? loanerId,
    bool? returned,
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/loans');
    final Map<String, dynamic> $params = <String, dynamic>{
      'returned': returned
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Loan>, Loan>($request);
  }

  @override
  Future<Response<List<Item>>> _loansLoanersLoanerIdItemsGet(
      {required String? loanerId}) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Item>, Item>($request);
  }

  @override
  Future<Response<Item>> _loansLoanersLoanerIdItemsPost({
    required String? loanerId,
    required ItemBase? body,
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Item, Item>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdItemsItemIdPatch({
    required String? loanerId,
    required String? itemId,
    required ItemUpdate? body,
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items/${itemId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdItemsItemIdDelete({
    required String? loanerId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items/${itemId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Loan>>> _loansUsersMeGet({bool? returned}) {
    final Uri $url = Uri.parse('/loans/users/me');
    final Map<String, dynamic> $params = <String, dynamic>{
      'returned': returned
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Loan>, Loan>($request);
  }

  @override
  Future<Response<List<Loaner>>> _loansUsersMeLoanersGet() {
    final Uri $url = Uri.parse('/loans/users/me/loaners');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Loaner>, Loaner>($request);
  }

  @override
  Future<Response<Loan>> _loansPost({required LoanCreation? body}) {
    final Uri $url = Uri.parse('/loans/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Loan, Loan>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdPatch({
    required String? loanId,
    required LoanUpdate? body,
  }) {
    final Uri $url = Uri.parse('/loans/${loanId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdDelete({required String? loanId}) {
    final Uri $url = Uri.parse('/loans/${loanId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdReturnPost({required String? loanId}) {
    final Uri $url = Uri.parse('/loans/${loanId}/return');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdExtendPost({
    required String? loanId,
    required LoanExtend? body,
  }) {
    final Uri $url = Uri.parse('/loans/${loanId}/extend');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Manager>>> _bookingManagersGet() {
    final Uri $url = Uri.parse('/booking/managers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Manager>, Manager>($request);
  }

  @override
  Future<Response<Manager>> _bookingManagersPost({required ManagerBase? body}) {
    final Uri $url = Uri.parse('/booking/managers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Manager, Manager>($request);
  }

  @override
  Future<Response<dynamic>> _bookingManagersManagerIdPatch({
    required String? managerId,
    required ManagerUpdate? body,
  }) {
    final Uri $url = Uri.parse('/booking/managers/${managerId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingManagersManagerIdDelete(
      {required String? managerId}) {
    final Uri $url = Uri.parse('/booking/managers/${managerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Manager>>> _bookingManagersUsersMeGet() {
    final Uri $url = Uri.parse('/booking/managers/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Manager>, Manager>($request);
  }

  @override
  Future<Response<List<BookingReturnApplicant>>>
      _bookingBookingsUsersMeManageGet() {
    final Uri $url = Uri.parse('/booking/bookings/users/me/manage');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<BookingReturnApplicant>, BookingReturnApplicant>($request);
  }

  @override
  Future<Response<List<BookingReturnApplicant>>>
      _bookingBookingsConfirmedUsersMeManageGet() {
    final Uri $url = Uri.parse('/booking/bookings/confirmed/users/me/manage');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<BookingReturnApplicant>, BookingReturnApplicant>($request);
  }

  @override
  Future<Response<List<BookingReturnSimpleApplicant>>>
      _bookingBookingsConfirmedGet() {
    final Uri $url = Uri.parse('/booking/bookings/confirmed');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<BookingReturnSimpleApplicant>,
        BookingReturnSimpleApplicant>($request);
  }

  @override
  Future<Response<List<BookingReturn>>> _bookingBookingsUsersMeGet() {
    final Uri $url = Uri.parse('/booking/bookings/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<BookingReturn>, BookingReturn>($request);
  }

  @override
  Future<Response<BookingReturn>> _bookingBookingsPost(
      {required BookingBase? body}) {
    final Uri $url = Uri.parse('/booking/bookings');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<BookingReturn, BookingReturn>($request);
  }

  @override
  Future<Response<dynamic>> _bookingBookingsBookingIdPatch({
    required String? bookingId,
    required BookingEdit? body,
  }) {
    final Uri $url = Uri.parse('/booking/bookings/${bookingId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingBookingsBookingIdDelete(
      {required String? bookingId}) {
    final Uri $url = Uri.parse('/booking/bookings/${bookingId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingBookingsBookingIdReplyDecisionPatch({
    required String? bookingId,
    required String? decision,
  }) {
    final Uri $url =
        Uri.parse('/booking/bookings/${bookingId}/reply/${decision}');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RoomComplete>>> _bookingRoomsGet() {
    final Uri $url = Uri.parse('/booking/rooms');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RoomComplete>, RoomComplete>($request);
  }

  @override
  Future<Response<RoomComplete>> _bookingRoomsPost({required RoomBase? body}) {
    final Uri $url = Uri.parse('/booking/rooms');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RoomComplete, RoomComplete>($request);
  }

  @override
  Future<Response<dynamic>> _bookingRoomsRoomIdPatch({
    required String? roomId,
    required RoomBase? body,
  }) {
    final Uri $url = Uri.parse('/booking/rooms/${roomId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingRoomsRoomIdDelete(
      {required String? roomId}) {
    final Uri $url = Uri.parse('/booking/rooms/${roomId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
