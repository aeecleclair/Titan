// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$Openapi extends Openapi {
  _$Openapi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Openapi;

  @override
  Future<Response<dynamic>> _sendEmailPost({
    required String? email,
    required String? subject,
    required String? content,
  }) {
    final Uri $url = Uri.parse('/send-email/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'email': email,
      'subject': subject,
      'content': content,
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
  Future<Response<AppUtilsTypesStandardResponsesResult>>
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
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<List<ProductComplete>>> _amapProductsGet() {
    final Uri $url = Uri.parse('/amap/products');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ProductComplete>, ProductComplete>($request);
  }

  @override
  Future<Response<ProductComplete>> _amapProductsPost(
      {required ProductSimple? body}) {
    final Uri $url = Uri.parse('/amap/products');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ProductComplete, ProductComplete>($request);
  }

  @override
  Future<Response<ProductComplete>> _amapProductsProductIdGet(
      {required String? productId}) {
    final Uri $url = Uri.parse('/amap/products/${productId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ProductComplete, ProductComplete>($request);
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
  Future<Response<dynamic>> _amapProductsProductIdPatch({
    required String? productId,
    required ProductEdit? body,
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
  Future<Response<List<AppSchemasSchemasAmapCashComplete>>>
      _amapUsersCashGet() {
    final Uri $url = Uri.parse('/amap/users/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppSchemasSchemasAmapCashComplete>,
        AppSchemasSchemasAmapCashComplete>($request);
  }

  @override
  Future<Response<AppSchemasSchemasAmapCashComplete>> _amapUsersUserIdCashGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AppSchemasSchemasAmapCashComplete,
        AppSchemasSchemasAmapCashComplete>($request);
  }

  @override
  Future<Response<AppSchemasSchemasAmapCashComplete>> _amapUsersUserIdCashPost({
    required String? userId,
    required AppSchemasSchemasAmapCashEdit? body,
  }) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppSchemasSchemasAmapCashComplete,
        AppSchemasSchemasAmapCashComplete>($request);
  }

  @override
  Future<Response<dynamic>> _amapUsersUserIdCashPatch({
    required String? userId,
    required AppSchemasSchemasAmapCashEdit? body,
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
  Future<Response<dynamic>> _associationsGet() {
    final Uri $url = Uri.parse('/associations');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsPut() {
    final Uri $url = Uri.parse('/associations');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsPost() {
    final Uri $url = Uri.parse('/associations');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdGet(
      {required Object? associationId}) {
    final Uri $url = Uri.parse('/associations/${associationId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdUsersGet(
      {required Object? associationId}) {
    final Uri $url = Uri.parse('/associations/${associationId}/users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdUsersUserIdPost({
    required Object? associationId,
    required Object? userId,
  }) {
    final Uri $url =
        Uri.parse('/associations/${associationId}/users/${userId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdUsersUserIdDelete({
    required Object? associationId,
    required Object? userId,
  }) {
    final Uri $url =
        Uri.parse('/associations/${associationId}/users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdAdminsUserIdPost({
    required Object? associationId,
    required Object? userId,
  }) {
    final Uri $url =
        Uri.parse('/associations/${associationId}/admins/${userId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdAdminsUserIdDelete({
    required Object? associationId,
    required Object? userId,
  }) {
    final Uri $url =
        Uri.parse('/associations/${associationId}/admins/${userId}');
    final Request $request = Request(
      'DELETE',
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
  Future<Response<List<BookingReturn>>> _bookingBookingsConfirmedGet() {
    final Uri $url = Uri.parse('/booking/bookings/confirmed');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<BookingReturn>, BookingReturn>($request);
  }

  @override
  Future<Response<List<BookingReturn>>> _bookingBookingsUsersApplicantIdGet(
      {required String? applicantId}) {
    final Uri $url = Uri.parse('/booking/bookings/users/${applicantId}');
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
  Future<Response<EventComplete>> _calendarEventsPost(
      {required EventBase? body}) {
    final Uri $url = Uri.parse('/calendar/events/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<EventComplete, EventComplete>($request);
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
  Future<Response<EventApplicant>> _calendarEventsEventIdApplicantGet(
      {required String? eventId}) {
    final Uri $url = Uri.parse('calendar/events/${eventId}/applicant');
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
  Future<Response<dynamic>> _campaignListsDelete({String? listType}) {
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
  Future<Response<List<AppSchemasSchemasCampaignResult>>>
      _campaignResultsGet() {
    final Uri $url = Uri.parse('/campaign/results');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppSchemasSchemasCampaignResult>,
        AppSchemasSchemasCampaignResult>($request);
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
  Future<Response<AppUtilsTypesStandardResponsesResult>>
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
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
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
  Future<Response<AppUtilsTypesStandardResponsesResult>>
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
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
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
  Future<Response<ModuleVisibilityCreate>> _moduleVisibilityPost(
      {required ModuleVisibilityCreate? body}) {
    final Uri $url = Uri.parse('/module-visibility/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<ModuleVisibilityCreate, ModuleVisibilityCreate>($request);
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
  Future<Response<dynamic>> _moduleVisibilityRootGroupIdDelete({
    required String? root,
    required String? groupId,
  }) {
    final Uri $url = Uri.parse('/module-visibility/${root}/${groupId}');
    final Request $request = Request(
      'DELETE',
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
  Future<Response<List<Message>>> _notificationMessagesFirebaseTokenGet(
      {required String? firebaseToken}) {
    final Uri $url = Uri.parse('/notification/messages/${firebaseToken}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Message>, Message>($request);
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
  Future<Response<List<String>>> _notificationTopicsTopicStrGet(
      {required String? topicStr}) {
    final Uri $url = Uri.parse('/notification/topics/${topicStr}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _notificationSendPost({required Message? body}) {
    final Uri $url = Uri.parse('/notification/send');
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
  Future<Response<RaffleSimple>> _tombolaRafflesPost(
      {required RaffleBase? body}) {
    final Uri $url = Uri.parse('/tombola/raffles');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RaffleSimple, RaffleSimple>($request);
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
  Future<Response<List<RaffleSimple>>> _tombolaGroupGroupIdRafflesGet(
      {required String? groupId}) {
    final Uri $url = Uri.parse('/tombola/group/${groupId}/raffles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RaffleSimple>, RaffleSimple>($request);
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
  Future<Response<AppUtilsTypesStandardResponsesResult>>
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
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
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
  Future<Response<AppUtilsTypesStandardResponsesResult>>
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
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<List<AppSchemasSchemasRaffleCashComplete>>>
      _tombolaUsersCashGet() {
    final Uri $url = Uri.parse('/tombola/users/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<AppSchemasSchemasRaffleCashComplete>,
        AppSchemasSchemasRaffleCashComplete>($request);
  }

  @override
  Future<Response<AppSchemasSchemasRaffleCashComplete>>
      _tombolaUsersUserIdCashGet({required String? userId}) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AppSchemasSchemasRaffleCashComplete,
        AppSchemasSchemasRaffleCashComplete>($request);
  }

  @override
  Future<Response<AppSchemasSchemasRaffleCashComplete>>
      _tombolaUsersUserIdCashPost({
    required String? userId,
    required AppSchemasSchemasRaffleCashEdit? body,
  }) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppSchemasSchemasRaffleCashComplete,
        AppSchemasSchemasRaffleCashComplete>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaUsersUserIdCashPatch({
    required String? userId,
    required AppSchemasSchemasRaffleCashEdit? body,
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
  Future<Response<List<CoreUserSimple>>> _usersGet() {
    final Uri $url = Uri.parse('/users/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    List<String>? includedGroups,
    List<String>? excludedGroups,
  }) {
    final Uri $url = Uri.parse('/users/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
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
  Future<Response<AppUtilsTypesStandardResponsesResult>> _usersCreatePost(
      {required CoreUserCreateRequest? body}) {
    final Uri $url = Uri.parse('/users/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
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
  Future<Response<String>> _usersActivateGet(
      {required String? activationToken}) {
    final Uri $url = Uri.parse('/users/activate');
    final Map<String, dynamic> $params = <String, dynamic>{
      'activation_token': activationToken
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
  Future<Response<AppUtilsTypesStandardResponsesResult>> _usersActivatePost(
      {required CoreUserActivateRequest? body}) {
    final Uri $url = Uri.parse('/users/activate');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<AppUtilsTypesStandardResponsesResult>> _usersMakeAdminPost() {
    final Uri $url = Uri.parse('/users/make-admin');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<AppUtilsTypesStandardResponsesResult>> _usersRecoverPost(
      {required BodyRecoverUserUsersRecoverPost? body}) {
    final Uri $url = Uri.parse('/users/recover');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
  }

  @override
  Future<Response<AppUtilsTypesStandardResponsesResult>>
      _usersResetPasswordPost({required ResetPasswordRequest? body}) {
    final Uri $url = Uri.parse('/users/reset-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
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
  Future<Response<AppUtilsTypesStandardResponsesResult>>
      _usersChangePasswordPost({required ChangePasswordRequest? body}) {
    final Uri $url = Uri.parse('/users/change-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
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
  Future<Response<AppUtilsTypesStandardResponsesResult>>
      _usersMeProfilePicturePost(
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
    return client.send<AppUtilsTypesStandardResponsesResult,
        AppUtilsTypesStandardResponsesResult>($request);
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
  Future<Response<List<Game>>> _elocapsGamesGet({required String? time}) {
    final Uri $url = Uri.parse('/elocaps/games');
    final Map<String, dynamic> $params = <String, dynamic>{'time': time};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Game>, Game>($request);
  }

  @override
  Future<Response<Game>> _elocapsGamesPost({required GameCreateRequest? body}) {
    final Uri $url = Uri.parse('/elocaps/games');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Game, Game>($request);
  }

  @override
  Future<Response<List<Game>>> _elocapsGamesLatestGet() {
    final Uri $url = Uri.parse('/elocaps/games/latest');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Game>, Game>($request);
  }

  @override
  Future<Response<List<GameMode>>> _elocapsGamesWaitingGet() {
    final Uri $url = Uri.parse('/elocaps/games/waiting');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<GameMode>, GameMode>($request);
  }

  @override
  Future<Response<Game>> _elocapsGamesGameIdGet({required String? gameId}) {
    final Uri $url = Uri.parse('/elocaps/games/${gameId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Game, Game>($request);
  }

  @override
  Future<Response<Game>> _elocapsGamesGameIdValidatePost(
      {required String? gameId}) {
    final Uri $url = Uri.parse('/elocaps/games/${gameId}/validate');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<Game, Game>($request);
  }

  @override
  Future<Response<List<Game>>> _elocapsPlayersUserIdGamesGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/elocaps/players/${userId}/games');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Game>, Game>($request);
  }

  @override
  Future<Response<DetailedPlayer>> _elocapsPlayersUserIdGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/elocaps/players/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DetailedPlayer, DetailedPlayer>($request);
  }

  @override
  Future<Response<List<PlayerBase>>> _elocapsLeaderboardGet(
      {required String? mode}) {
    final Uri $url = Uri.parse('/elocaps/leaderboard');
    final Map<String, dynamic> $params = <String, dynamic>{'mode': mode};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<PlayerBase>, PlayerBase>($request);
  }
}
