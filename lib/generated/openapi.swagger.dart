// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'openapi.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'openapi.enums.swagger.dart' as enums;
export 'openapi.enums.swagger.dart';
export 'openapi.models.swagger.dart';

part 'openapi.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Openapi extends ChopperService {
  static Openapi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Openapi(client);
    }

    final newClient = ChopperClient(
      services: [_$Openapi()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl ?? Uri.parse('http://'),
    );
    return _$Openapi(newClient);
  }

  ///Get Devices
  Future<chopper.Response<List<FirebaseDevice>>> notificationDevicesGet() {
    generatedMapping.putIfAbsent(
      FirebaseDevice,
      () => FirebaseDevice.fromJsonFactory,
    );

    return _notificationDevicesGet();
  }

  ///Get Devices
  @Get(path: '/notification/devices')
  Future<chopper.Response<List<FirebaseDevice>>> _notificationDevicesGet();

  ///Register Firebase Device
  Future<chopper.Response> notificationDevicesPost({
    required BodyRegisterFirebaseDeviceNotificationDevicesPost? body,
  }) {
    return _notificationDevicesPost(body: body);
  }

  ///Register Firebase Device
  @Post(path: '/notification/devices', optionalBody: true)
  Future<chopper.Response> _notificationDevicesPost({
    @Body() required BodyRegisterFirebaseDeviceNotificationDevicesPost? body,
  });

  ///Unregister Firebase Device
  ///@param firebase_token
  Future<chopper.Response> notificationDevicesFirebaseTokenDelete({
    required String? firebaseToken,
  }) {
    return _notificationDevicesFirebaseTokenDelete(
      firebaseToken: firebaseToken,
    );
  }

  ///Unregister Firebase Device
  ///@param firebase_token
  @Delete(path: '/notification/devices/{firebase_token}')
  Future<chopper.Response> _notificationDevicesFirebaseTokenDelete({
    @Path('firebase_token') required String? firebaseToken,
  });

  ///Subscribe To Topic
  ///@param topic_str The topic to subscribe to. The Topic may be followed by an additional identifier (ex: cinema_4c029b5f-2bf7-4b70-85d4-340a4bd28653)
  Future<chopper.Response> notificationTopicsTopicStrSubscribePost({
    required String? topicStr,
  }) {
    return _notificationTopicsTopicStrSubscribePost(topicStr: topicStr);
  }

  ///Subscribe To Topic
  ///@param topic_str The topic to subscribe to. The Topic may be followed by an additional identifier (ex: cinema_4c029b5f-2bf7-4b70-85d4-340a4bd28653)
  @Post(path: '/notification/topics/{topic_str}/subscribe', optionalBody: true)
  Future<chopper.Response> _notificationTopicsTopicStrSubscribePost({
    @Path('topic_str') required String? topicStr,
  });

  ///Unsubscribe To Topic
  ///@param topic_str
  Future<chopper.Response> notificationTopicsTopicStrUnsubscribePost({
    required String? topicStr,
  }) {
    return _notificationTopicsTopicStrUnsubscribePost(topicStr: topicStr);
  }

  ///Unsubscribe To Topic
  ///@param topic_str
  @Post(
    path: '/notification/topics/{topic_str}/unsubscribe',
    optionalBody: true,
  )
  Future<chopper.Response> _notificationTopicsTopicStrUnsubscribePost({
    @Path('topic_str') required String? topicStr,
  });

  ///Get Topic
  Future<chopper.Response<List<String>>> notificationTopicsGet() {
    return _notificationTopicsGet();
  }

  ///Get Topic
  @Get(path: '/notification/topics')
  Future<chopper.Response<List<String>>> _notificationTopicsGet();

  ///Get Topic Identifier
  ///@param topic
  Future<chopper.Response<List<String>>> notificationTopicsTopicGet({
    required enums.Topic? topic,
  }) {
    return _notificationTopicsTopicGet(topic: topic?.value?.toString());
  }

  ///Get Topic Identifier
  ///@param topic
  @Get(path: '/notification/topics/{topic}')
  Future<chopper.Response<List<String>>> _notificationTopicsTopicGet({
    @Path('topic') required String? topic,
  });

  ///Send Notification
  Future<chopper.Response> notificationSendPost() {
    return _notificationSendPost();
  }

  ///Send Notification
  @Post(path: '/notification/send', optionalBody: true)
  Future<chopper.Response> _notificationSendPost();

  ///Send Future Notification
  Future<chopper.Response> notificationSendFuturePost() {
    return _notificationSendFuturePost();
  }

  ///Send Future Notification
  @Post(path: '/notification/send/future', optionalBody: true)
  Future<chopper.Response> _notificationSendFuturePost();

  ///Send Notification Topic
  Future<chopper.Response> notificationSendTopicPost() {
    return _notificationSendTopicPost();
  }

  ///Send Notification Topic
  @Post(path: '/notification/send/topic', optionalBody: true)
  Future<chopper.Response> _notificationSendTopicPost();

  ///Send Future Notification Topic
  Future<chopper.Response> notificationSendTopicFuturePost() {
    return _notificationSendTopicFuturePost();
  }

  ///Send Future Notification Topic
  @Post(path: '/notification/send/topic/future', optionalBody: true)
  Future<chopper.Response> _notificationSendTopicFuturePost();

  ///Google Api Callback
  Future<chopper.Response> googleApiOauth2callbackGet() {
    return _googleApiOauth2callbackGet();
  }

  ///Google Api Callback
  @Get(path: '/google-api/oauth2callback')
  Future<chopper.Response> _googleApiOauth2callbackGet();

  ///Get Structures
  Future<chopper.Response<List<Structure>>> myeclpayStructuresGet() {
    generatedMapping.putIfAbsent(Structure, () => Structure.fromJsonFactory);

    return _myeclpayStructuresGet();
  }

  ///Get Structures
  @Get(path: '/myeclpay/structures')
  Future<chopper.Response<List<Structure>>> _myeclpayStructuresGet();

  ///Create Structure
  Future<chopper.Response<Structure>> myeclpayStructuresPost({
    required StructureBase? body,
  }) {
    generatedMapping.putIfAbsent(Structure, () => Structure.fromJsonFactory);

    return _myeclpayStructuresPost(body: body);
  }

  ///Create Structure
  @Post(path: '/myeclpay/structures', optionalBody: true)
  Future<chopper.Response<Structure>> _myeclpayStructuresPost({
    @Body() required StructureBase? body,
  });

  ///Update Structure
  ///@param structure_id
  Future<chopper.Response> myeclpayStructuresStructureIdPatch({
    required String? structureId,
    required StructureUpdate? body,
  }) {
    return _myeclpayStructuresStructureIdPatch(
      structureId: structureId,
      body: body,
    );
  }

  ///Update Structure
  ///@param structure_id
  @Patch(path: '/myeclpay/structures/{structure_id}', optionalBody: true)
  Future<chopper.Response> _myeclpayStructuresStructureIdPatch({
    @Path('structure_id') required String? structureId,
    @Body() required StructureUpdate? body,
  });

  ///Delete Structure
  ///@param structure_id
  Future<chopper.Response> myeclpayStructuresStructureIdDelete({
    required String? structureId,
  }) {
    return _myeclpayStructuresStructureIdDelete(structureId: structureId);
  }

  ///Delete Structure
  ///@param structure_id
  @Delete(path: '/myeclpay/structures/{structure_id}')
  Future<chopper.Response> _myeclpayStructuresStructureIdDelete({
    @Path('structure_id') required String? structureId,
  });

  ///Init Transfer Structure Manager
  ///@param structure_id
  Future<chopper.Response>
  myeclpayStructuresStructureIdInitManagerTransferPost({
    required String? structureId,
    required StructureTranfert? body,
  }) {
    return _myeclpayStructuresStructureIdInitManagerTransferPost(
      structureId: structureId,
      body: body,
    );
  }

  ///Init Transfer Structure Manager
  ///@param structure_id
  @Post(
    path: '/myeclpay/structures/{structure_id}/init-manager-transfer',
    optionalBody: true,
  )
  Future<chopper.Response>
  _myeclpayStructuresStructureIdInitManagerTransferPost({
    @Path('structure_id') required String? structureId,
    @Body() required StructureTranfert? body,
  });

  ///Confirm Structure Manager Transfer
  ///@param token
  Future<chopper.Response> myeclpayStructuresConfirmManagerTransferGet({
    required String? token,
  }) {
    return _myeclpayStructuresConfirmManagerTransferGet(token: token);
  }

  ///Confirm Structure Manager Transfer
  ///@param token
  @Get(path: '/myeclpay/structures/confirm-manager-transfer')
  Future<chopper.Response> _myeclpayStructuresConfirmManagerTransferGet({
    @Query('token') required String? token,
  });

  ///Create Store
  ///@param structure_id
  Future<chopper.Response<Store>> myeclpayStructuresStructureIdStoresPost({
    required String? structureId,
    required StoreBase? body,
  }) {
    generatedMapping.putIfAbsent(Store, () => Store.fromJsonFactory);

    return _myeclpayStructuresStructureIdStoresPost(
      structureId: structureId,
      body: body,
    );
  }

  ///Create Store
  ///@param structure_id
  @Post(path: '/myeclpay/structures/{structure_id}/stores', optionalBody: true)
  Future<chopper.Response<Store>> _myeclpayStructuresStructureIdStoresPost({
    @Path('structure_id') required String? structureId,
    @Body() required StoreBase? body,
  });

  ///Get Store History
  ///@param store_id
  Future<chopper.Response<List<History>>> myeclpayStoresStoreIdHistoryGet({
    required String? storeId,
  }) {
    generatedMapping.putIfAbsent(History, () => History.fromJsonFactory);

    return _myeclpayStoresStoreIdHistoryGet(storeId: storeId);
  }

  ///Get Store History
  ///@param store_id
  @Get(path: '/myeclpay/stores/{store_id}/history')
  Future<chopper.Response<List<History>>> _myeclpayStoresStoreIdHistoryGet({
    @Path('store_id') required String? storeId,
  });

  ///Get User Stores
  Future<chopper.Response<List<UserStore>>> myeclpayUsersMeStoresGet() {
    generatedMapping.putIfAbsent(UserStore, () => UserStore.fromJsonFactory);

    return _myeclpayUsersMeStoresGet();
  }

  ///Get User Stores
  @Get(path: '/myeclpay/users/me/stores')
  Future<chopper.Response<List<UserStore>>> _myeclpayUsersMeStoresGet();

  ///Update Store
  ///@param store_id
  Future<chopper.Response> myeclpayStoresStoreIdPatch({
    required String? storeId,
    required StoreUpdate? body,
  }) {
    return _myeclpayStoresStoreIdPatch(storeId: storeId, body: body);
  }

  ///Update Store
  ///@param store_id
  @Patch(path: '/myeclpay/stores/{store_id}', optionalBody: true)
  Future<chopper.Response> _myeclpayStoresStoreIdPatch({
    @Path('store_id') required String? storeId,
    @Body() required StoreUpdate? body,
  });

  ///Delete Store
  ///@param store_id
  Future<chopper.Response> myeclpayStoresStoreIdDelete({
    required String? storeId,
  }) {
    return _myeclpayStoresStoreIdDelete(storeId: storeId);
  }

  ///Delete Store
  ///@param store_id
  @Delete(path: '/myeclpay/stores/{store_id}')
  Future<chopper.Response> _myeclpayStoresStoreIdDelete({
    @Path('store_id') required String? storeId,
  });

  ///Create Store Seller
  ///@param store_id
  Future<chopper.Response<Seller>> myeclpayStoresStoreIdSellersPost({
    required String? storeId,
    required SellerCreation? body,
  }) {
    generatedMapping.putIfAbsent(Seller, () => Seller.fromJsonFactory);

    return _myeclpayStoresStoreIdSellersPost(storeId: storeId, body: body);
  }

  ///Create Store Seller
  ///@param store_id
  @Post(path: '/myeclpay/stores/{store_id}/sellers', optionalBody: true)
  Future<chopper.Response<Seller>> _myeclpayStoresStoreIdSellersPost({
    @Path('store_id') required String? storeId,
    @Body() required SellerCreation? body,
  });

  ///Get Store Sellers
  ///@param store_id
  Future<chopper.Response<List<Seller>>> myeclpayStoresStoreIdSellersGet({
    required String? storeId,
  }) {
    generatedMapping.putIfAbsent(Seller, () => Seller.fromJsonFactory);

    return _myeclpayStoresStoreIdSellersGet(storeId: storeId);
  }

  ///Get Store Sellers
  ///@param store_id
  @Get(path: '/myeclpay/stores/{store_id}/sellers')
  Future<chopper.Response<List<Seller>>> _myeclpayStoresStoreIdSellersGet({
    @Path('store_id') required String? storeId,
  });

  ///Update Store Seller
  ///@param store_id
  ///@param seller_user_id
  Future<chopper.Response> myeclpayStoresStoreIdSellersSellerUserIdPatch({
    required String? storeId,
    required String? sellerUserId,
    required SellerUpdate? body,
  }) {
    return _myeclpayStoresStoreIdSellersSellerUserIdPatch(
      storeId: storeId,
      sellerUserId: sellerUserId,
      body: body,
    );
  }

  ///Update Store Seller
  ///@param store_id
  ///@param seller_user_id
  @Patch(
    path: '/myeclpay/stores/{store_id}/sellers/{seller_user_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _myeclpayStoresStoreIdSellersSellerUserIdPatch({
    @Path('store_id') required String? storeId,
    @Path('seller_user_id') required String? sellerUserId,
    @Body() required SellerUpdate? body,
  });

  ///Delete Store Seller
  ///@param store_id
  ///@param seller_user_id
  Future<chopper.Response> myeclpayStoresStoreIdSellersSellerUserIdDelete({
    required String? storeId,
    required String? sellerUserId,
  }) {
    return _myeclpayStoresStoreIdSellersSellerUserIdDelete(
      storeId: storeId,
      sellerUserId: sellerUserId,
    );
  }

  ///Delete Store Seller
  ///@param store_id
  ///@param seller_user_id
  @Delete(path: '/myeclpay/stores/{store_id}/sellers/{seller_user_id}')
  Future<chopper.Response> _myeclpayStoresStoreIdSellersSellerUserIdDelete({
    @Path('store_id') required String? storeId,
    @Path('seller_user_id') required String? sellerUserId,
  });

  ///Register User
  Future<chopper.Response> myeclpayUsersMeRegisterPost() {
    return _myeclpayUsersMeRegisterPost();
  }

  ///Register User
  @Post(path: '/myeclpay/users/me/register', optionalBody: true)
  Future<chopper.Response> _myeclpayUsersMeRegisterPost();

  ///Get Tos
  Future<chopper.Response> myeclpayTosGet() {
    return _myeclpayTosGet();
  }

  ///Get Tos
  @Get(path: '/myeclpay/tos')
  Future<chopper.Response> _myeclpayTosGet();

  ///Get User Tos
  Future<chopper.Response<TOSSignatureResponse>> myeclpayUsersMeTosGet() {
    generatedMapping.putIfAbsent(
      TOSSignatureResponse,
      () => TOSSignatureResponse.fromJsonFactory,
    );

    return _myeclpayUsersMeTosGet();
  }

  ///Get User Tos
  @Get(path: '/myeclpay/users/me/tos')
  Future<chopper.Response<TOSSignatureResponse>> _myeclpayUsersMeTosGet();

  ///Sign Tos
  Future<chopper.Response> myeclpayUsersMeTosPost({
    required TOSSignature? body,
  }) {
    return _myeclpayUsersMeTosPost(body: body);
  }

  ///Sign Tos
  @Post(path: '/myeclpay/users/me/tos', optionalBody: true)
  Future<chopper.Response> _myeclpayUsersMeTosPost({
    @Body() required TOSSignature? body,
  });

  ///Get User Devices
  Future<chopper.Response<List<WalletDevice>>>
  myeclpayUsersMeWalletDevicesGet() {
    generatedMapping.putIfAbsent(
      WalletDevice,
      () => WalletDevice.fromJsonFactory,
    );

    return _myeclpayUsersMeWalletDevicesGet();
  }

  ///Get User Devices
  @Get(path: '/myeclpay/users/me/wallet/devices')
  Future<chopper.Response<List<WalletDevice>>>
  _myeclpayUsersMeWalletDevicesGet();

  ///Create User Devices
  Future<chopper.Response<WalletDevice>> myeclpayUsersMeWalletDevicesPost({
    required WalletDeviceCreation? body,
  }) {
    generatedMapping.putIfAbsent(
      WalletDevice,
      () => WalletDevice.fromJsonFactory,
    );

    return _myeclpayUsersMeWalletDevicesPost(body: body);
  }

  ///Create User Devices
  @Post(path: '/myeclpay/users/me/wallet/devices', optionalBody: true)
  Future<chopper.Response<WalletDevice>> _myeclpayUsersMeWalletDevicesPost({
    @Body() required WalletDeviceCreation? body,
  });

  ///Get User Device
  ///@param wallet_device_id
  Future<chopper.Response<WalletDevice>>
  myeclpayUsersMeWalletDevicesWalletDeviceIdGet({
    required String? walletDeviceId,
  }) {
    generatedMapping.putIfAbsent(
      WalletDevice,
      () => WalletDevice.fromJsonFactory,
    );

    return _myeclpayUsersMeWalletDevicesWalletDeviceIdGet(
      walletDeviceId: walletDeviceId,
    );
  }

  ///Get User Device
  ///@param wallet_device_id
  @Get(path: '/myeclpay/users/me/wallet/devices/{wallet_device_id}')
  Future<chopper.Response<WalletDevice>>
  _myeclpayUsersMeWalletDevicesWalletDeviceIdGet({
    @Path('wallet_device_id') required String? walletDeviceId,
  });

  ///Get User Wallet
  Future<chopper.Response<Wallet>> myeclpayUsersMeWalletGet() {
    generatedMapping.putIfAbsent(Wallet, () => Wallet.fromJsonFactory);

    return _myeclpayUsersMeWalletGet();
  }

  ///Get User Wallet
  @Get(path: '/myeclpay/users/me/wallet')
  Future<chopper.Response<Wallet>> _myeclpayUsersMeWalletGet();

  ///Activate User Device
  ///@param token
  Future<chopper.Response> myeclpayDevicesActivateGet({
    required String? token,
  }) {
    return _myeclpayDevicesActivateGet(token: token);
  }

  ///Activate User Device
  ///@param token
  @Get(path: '/myeclpay/devices/activate')
  Future<chopper.Response> _myeclpayDevicesActivateGet({
    @Query('token') required String? token,
  });

  ///Revoke User Devices
  ///@param wallet_device_id
  Future<chopper.Response>
  myeclpayUsersMeWalletDevicesWalletDeviceIdRevokePost({
    required String? walletDeviceId,
  }) {
    return _myeclpayUsersMeWalletDevicesWalletDeviceIdRevokePost(
      walletDeviceId: walletDeviceId,
    );
  }

  ///Revoke User Devices
  ///@param wallet_device_id
  @Post(
    path: '/myeclpay/users/me/wallet/devices/{wallet_device_id}/revoke',
    optionalBody: true,
  )
  Future<chopper.Response>
  _myeclpayUsersMeWalletDevicesWalletDeviceIdRevokePost({
    @Path('wallet_device_id') required String? walletDeviceId,
  });

  ///Get User Wallet History
  Future<chopper.Response<List<History>>> myeclpayUsersMeWalletHistoryGet() {
    generatedMapping.putIfAbsent(History, () => History.fromJsonFactory);

    return _myeclpayUsersMeWalletHistoryGet();
  }

  ///Get User Wallet History
  @Get(path: '/myeclpay/users/me/wallet/history')
  Future<chopper.Response<List<History>>> _myeclpayUsersMeWalletHistoryGet();

  ///Add Transfer By Admin
  Future<chopper.Response> myeclpayTransferAdminPost({
    required AdminTransferInfo? body,
  }) {
    return _myeclpayTransferAdminPost(body: body);
  }

  ///Add Transfer By Admin
  @Post(path: '/myeclpay/transfer/admin', optionalBody: true)
  Future<chopper.Response> _myeclpayTransferAdminPost({
    @Body() required AdminTransferInfo? body,
  });

  ///Init Ha Transfer
  Future<chopper.Response<PaymentUrl>> myeclpayTransferInitPost({
    required TransferInfo? body,
  }) {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _myeclpayTransferInitPost(body: body);
  }

  ///Init Ha Transfer
  @Post(path: '/myeclpay/transfer/init', optionalBody: true)
  Future<chopper.Response<PaymentUrl>> _myeclpayTransferInitPost({
    @Body() required TransferInfo? body,
  });

  ///Redirect From Ha Transfer
  ///@param url
  ///@param checkoutIntentId
  ///@param code
  ///@param orderId
  ///@param error
  Future<chopper.Response<PaymentUrl>> myeclpayTransferRedirectGet({
    required String? url,
    String? checkoutIntentId,
    String? code,
    String? orderId,
    String? error,
  }) {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _myeclpayTransferRedirectGet(
      url: url,
      checkoutIntentId: checkoutIntentId,
      code: code,
      orderId: orderId,
      error: error,
    );
  }

  ///Redirect From Ha Transfer
  ///@param url
  ///@param checkoutIntentId
  ///@param code
  ///@param orderId
  ///@param error
  @Get(path: '/myeclpay/transfer/redirect')
  Future<chopper.Response<PaymentUrl>> _myeclpayTransferRedirectGet({
    @Query('url') required String? url,
    @Query('checkoutIntentId') String? checkoutIntentId,
    @Query('code') String? code,
    @Query('orderId') String? orderId,
    @Query('error') String? error,
  });

  ///Validate Can Scan Qrcode
  ///@param store_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  myeclpayStoresStoreIdScanCheckPost({
    required String? storeId,
    required ScanInfo? body,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _myeclpayStoresStoreIdScanCheckPost(storeId: storeId, body: body);
  }

  ///Validate Can Scan Qrcode
  ///@param store_id
  @Post(path: '/myeclpay/stores/{store_id}/scan/check', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _myeclpayStoresStoreIdScanCheckPost({
    @Path('store_id') required String? storeId,
    @Body() required ScanInfo? body,
  });

  ///Store Scan Qrcode
  ///@param store_id
  Future<chopper.Response> myeclpayStoresStoreIdScanPost({
    required String? storeId,
    required ScanInfo? body,
  }) {
    return _myeclpayStoresStoreIdScanPost(storeId: storeId, body: body);
  }

  ///Store Scan Qrcode
  ///@param store_id
  @Post(path: '/myeclpay/stores/{store_id}/scan', optionalBody: true)
  Future<chopper.Response> _myeclpayStoresStoreIdScanPost({
    @Path('store_id') required String? storeId,
    @Body() required ScanInfo? body,
  });

  ///Refund Transaction
  ///@param transaction_id
  Future<chopper.Response> myeclpayTransactionsTransactionIdRefundPost({
    required String? transactionId,
    required RefundInfo? body,
  }) {
    return _myeclpayTransactionsTransactionIdRefundPost(
      transactionId: transactionId,
      body: body,
    );
  }

  ///Refund Transaction
  ///@param transaction_id
  @Post(
    path: '/myeclpay/transactions/{transaction_id}/refund',
    optionalBody: true,
  )
  Future<chopper.Response> _myeclpayTransactionsTransactionIdRefundPost({
    @Path('transaction_id') required String? transactionId,
    @Body() required RefundInfo? body,
  });

  ///Cancel Transaction
  ///@param transaction_id
  Future<chopper.Response> myeclpayTransactionsTransactionIdCancelPost({
    required String? transactionId,
  }) {
    return _myeclpayTransactionsTransactionIdCancelPost(
      transactionId: transactionId,
    );
  }

  ///Cancel Transaction
  ///@param transaction_id
  @Post(
    path: '/myeclpay/transactions/{transaction_id}/cancel',
    optionalBody: true,
  )
  Future<chopper.Response> _myeclpayTransactionsTransactionIdCancelPost({
    @Path('transaction_id') required String? transactionId,
  });

  ///Get Data For Integrity Check
  Future<chopper.Response> myeclpayIntegrityCheckGet() {
    return _myeclpayIntegrityCheckGet();
  }

  ///Get Data For Integrity Check
  @Get(path: '/myeclpay/integrity-check')
  Future<chopper.Response> _myeclpayIntegrityCheckGet();

  ///Login For Access Token
  Future<chopper.Response<AccessToken>> authSimpleTokenPost({
    required Map<String, String> body,
  }) {
    generatedMapping.putIfAbsent(
      AccessToken,
      () => AccessToken.fromJsonFactory,
    );

    return _authSimpleTokenPost(body: body);
  }

  ///Login For Access Token
  @Post(
    path: '/auth/simple_token',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<AccessToken>> _authSimpleTokenPost({
    @Body() required Map<String, String> body,
  });

  ///Get Authorize Page
  ///@param client_id
  ///@param redirect_uri
  ///@param response_type
  ///@param scope
  ///@param state
  ///@param nonce
  ///@param code_challenge
  ///@param code_challenge_method
  Future<chopper.Response<String>> authAuthorizeGet({
    required String? clientId,
    String? redirectUri,
    required String? responseType,
    String? scope,
    String? state,
    String? nonce,
    String? codeChallenge,
    String? codeChallengeMethod,
  }) {
    return _authAuthorizeGet(
      clientId: clientId,
      redirectUri: redirectUri,
      responseType: responseType,
      scope: scope,
      state: state,
      nonce: nonce,
      codeChallenge: codeChallenge,
      codeChallengeMethod: codeChallengeMethod,
    );
  }

  ///Get Authorize Page
  ///@param client_id
  ///@param redirect_uri
  ///@param response_type
  ///@param scope
  ///@param state
  ///@param nonce
  ///@param code_challenge
  ///@param code_challenge_method
  @Get(path: '/auth/authorize')
  Future<chopper.Response<String>> _authAuthorizeGet({
    @Query('client_id') required String? clientId,
    @Query('redirect_uri') String? redirectUri,
    @Query('response_type') required String? responseType,
    @Query('scope') String? scope,
    @Query('state') String? state,
    @Query('nonce') String? nonce,
    @Query('code_challenge') String? codeChallenge,
    @Query('code_challenge_method') String? codeChallengeMethod,
  });

  ///Post Authorize Page
  Future<chopper.Response<String>> authAuthorizePost({
    required Map<String, String> body,
  }) {
    return _authAuthorizePost(body: body);
  }

  ///Post Authorize Page
  @Post(path: '/auth/authorize', headers: {contentTypeKey: formEncodedHeaders})
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<String>> _authAuthorizePost({
    @Body() required Map<String, String> body,
  });

  ///Authorize Validation
  Future<chopper.Response> authAuthorizationFlowAuthorizeValidationPost({
    required Map<String, String> body,
  }) {
    return _authAuthorizationFlowAuthorizeValidationPost(body: body);
  }

  ///Authorize Validation
  @Post(
    path: '/auth/authorization-flow/authorize-validation',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response> _authAuthorizationFlowAuthorizeValidationPost({
    @Body() required Map<String, String> body,
  });

  ///Token
  ///@param authorization
  Future<chopper.Response<TokenResponse>> authTokenPost({
    String? authorization,
    required Map<String, String> body,
  }) {
    generatedMapping.putIfAbsent(
      TokenResponse,
      () => TokenResponse.fromJsonFactory,
    );

    return _authTokenPost(authorization: authorization?.toString(), body: body);
  }

  ///Token
  ///@param authorization
  @Post(path: '/auth/token', headers: {contentTypeKey: formEncodedHeaders})
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<TokenResponse>> _authTokenPost({
    @Header('authorization') String? authorization,
    @Body() required Map<String, String> body,
  });

  ///Introspect
  ///@param authorization
  Future<chopper.Response<IntrospectTokenResponse>> authIntrospectPost({
    String? authorization,
    required Map<String, String> body,
  }) {
    generatedMapping.putIfAbsent(
      IntrospectTokenResponse,
      () => IntrospectTokenResponse.fromJsonFactory,
    );

    return _authIntrospectPost(
      authorization: authorization?.toString(),
      body: body,
    );
  }

  ///Introspect
  ///@param authorization
  @Post(path: '/auth/introspect', headers: {contentTypeKey: formEncodedHeaders})
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<IntrospectTokenResponse>> _authIntrospectPost({
    @Header('authorization') String? authorization,
    @Body() required Map<String, String> body,
  });

  ///Auth Get Userinfo
  Future<chopper.Response> authUserinfoGet() {
    return _authUserinfoGet();
  }

  ///Auth Get Userinfo
  @Get(path: '/auth/userinfo')
  Future<chopper.Response> _authUserinfoGet();

  ///Jwks Uri
  Future<chopper.Response> oidcAuthorizationFlowJwksUriGet() {
    return _oidcAuthorizationFlowJwksUriGet();
  }

  ///Jwks Uri
  @Get(path: '/oidc/authorization-flow/jwks_uri')
  Future<chopper.Response> _oidcAuthorizationFlowJwksUriGet();

  ///Oauth Configuration
  Future<chopper.Response> wellKnownOauthAuthorizationServerGet() {
    return _wellKnownOauthAuthorizationServerGet();
  }

  ///Oauth Configuration
  @Get(path: '/.well-known/oauth-authorization-server')
  Future<chopper.Response> _wellKnownOauthAuthorizationServerGet();

  ///Oidc Configuration
  Future<chopper.Response> wellKnownOpenidConfigurationGet() {
    return _wellKnownOpenidConfigurationGet();
  }

  ///Oidc Configuration
  @Get(path: '/.well-known/openid-configuration')
  Future<chopper.Response> _wellKnownOpenidConfigurationGet();

  ///Read Users
  ///@param accountTypes
  Future<chopper.Response<List<CoreUserSimple>>> usersGet({
    List<enums.AccountType>? accountTypes,
  }) {
    generatedMapping.putIfAbsent(
      CoreUserSimple,
      () => CoreUserSimple.fromJsonFactory,
    );

    return _usersGet(accountTypes: accountTypeListToJson(accountTypes));
  }

  ///Read Users
  ///@param accountTypes
  @Get(path: '/users')
  Future<chopper.Response<List<CoreUserSimple>>> _usersGet({
    @Query('accountTypes') List<Object?>? accountTypes,
  });

  ///Count Users
  Future<chopper.Response<int>> usersCountGet() {
    return _usersCountGet();
  }

  ///Count Users
  @Get(path: '/users/count')
  Future<chopper.Response<int>> _usersCountGet();

  ///Search Users
  ///@param query
  ///@param includedAccountTypes
  ///@param excludedAccountTypes
  ///@param includedGroups
  ///@param excludedGroups
  Future<chopper.Response<List<CoreUserSimple>>> usersSearchGet({
    required String? query,
    List<enums.AccountType>? includedAccountTypes,
    List<enums.AccountType>? excludedAccountTypes,
    List<String>? includedGroups,
    List<String>? excludedGroups,
  }) {
    generatedMapping.putIfAbsent(
      CoreUserSimple,
      () => CoreUserSimple.fromJsonFactory,
    );

    return _usersSearchGet(
      query: query,
      includedAccountTypes: accountTypeListToJson(includedAccountTypes),
      excludedAccountTypes: accountTypeListToJson(excludedAccountTypes),
      includedGroups: includedGroups,
      excludedGroups: excludedGroups,
    );
  }

  ///Search Users
  ///@param query
  ///@param includedAccountTypes
  ///@param excludedAccountTypes
  ///@param includedGroups
  ///@param excludedGroups
  @Get(path: '/users/search')
  Future<chopper.Response<List<CoreUserSimple>>> _usersSearchGet({
    @Query('query') required String? query,
    @Query('includedAccountTypes') List<Object?>? includedAccountTypes,
    @Query('excludedAccountTypes') List<Object?>? excludedAccountTypes,
    @Query('includedGroups') List<String>? includedGroups,
    @Query('excludedGroups') List<String>? excludedGroups,
  });

  ///Get Account Types
  Future<chopper.Response<List<AccountType>>> usersAccountTypesGet() {
    generatedMapping.putIfAbsent(
      AccountType,
      () => AccountType.fromJsonFactory,
    );

    return _usersAccountTypesGet();
  }

  ///Get Account Types
  @Get(path: '/users/account-types')
  Future<chopper.Response<List<AccountType>>> _usersAccountTypesGet();

  ///Read Current User
  Future<chopper.Response<CoreUser>> usersMeGet() {
    generatedMapping.putIfAbsent(CoreUser, () => CoreUser.fromJsonFactory);

    return _usersMeGet();
  }

  ///Read Current User
  @Get(path: '/users/me')
  Future<chopper.Response<CoreUser>> _usersMeGet();

  ///Update Current User
  Future<chopper.Response> usersMePatch({required CoreUserUpdate? body}) {
    return _usersMePatch(body: body);
  }

  ///Update Current User
  @Patch(path: '/users/me', optionalBody: true)
  Future<chopper.Response> _usersMePatch({
    @Body() required CoreUserUpdate? body,
  });

  ///Create User By User
  Future<chopper.Response<AppTypesStandardResponsesResult>> usersCreatePost({
    required CoreUserCreateRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersCreatePost(body: body);
  }

  ///Create User By User
  @Post(path: '/users/create', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>> _usersCreatePost({
    @Body() required CoreUserCreateRequest? body,
  });

  ///Batch Create Users
  Future<chopper.Response<BatchResult>> usersBatchCreationPost({
    required List<CoreBatchUserCreateRequest>? body,
  }) {
    generatedMapping.putIfAbsent(
      BatchResult,
      () => BatchResult.fromJsonFactory,
    );

    return _usersBatchCreationPost(body: body);
  }

  ///Batch Create Users
  @Post(path: '/users/batch-creation', optionalBody: true)
  Future<chopper.Response<BatchResult>> _usersBatchCreationPost({
    @Body() required List<CoreBatchUserCreateRequest>? body,
  });

  ///Activate User
  Future<chopper.Response<AppTypesStandardResponsesResult>> usersActivatePost({
    required CoreUserActivateRequest? body,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersActivatePost(body: body);
  }

  ///Activate User
  @Post(path: '/users/activate', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>> _usersActivatePost({
    @Body() required CoreUserActivateRequest? body,
  });

  ///Make Admin
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  usersMakeAdminPost() {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersMakeAdminPost();
  }

  ///Make Admin
  @Post(path: '/users/make-admin', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _usersMakeAdminPost();

  ///Recover User
  Future<chopper.Response<AppTypesStandardResponsesResult>> usersRecoverPost({
    required BodyRecoverUserUsersRecoverPost? body,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersRecoverPost(body: body);
  }

  ///Recover User
  @Post(path: '/users/recover', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>> _usersRecoverPost({
    @Body() required BodyRecoverUserUsersRecoverPost? body,
  });

  ///Reset Password
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  usersResetPasswordPost({required ResetPasswordRequest? body}) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersResetPasswordPost(body: body);
  }

  ///Reset Password
  @Post(path: '/users/reset-password', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _usersResetPasswordPost({@Body() required ResetPasswordRequest? body});

  ///Migrate Mail
  Future<chopper.Response> usersMigrateMailPost({
    required MailMigrationRequest? body,
  }) {
    return _usersMigrateMailPost(body: body);
  }

  ///Migrate Mail
  @Post(path: '/users/migrate-mail', optionalBody: true)
  Future<chopper.Response> _usersMigrateMailPost({
    @Body() required MailMigrationRequest? body,
  });

  ///Migrate Mail Confirm
  ///@param token
  Future<chopper.Response> usersMigrateMailConfirmGet({
    required String? token,
  }) {
    return _usersMigrateMailConfirmGet(token: token);
  }

  ///Migrate Mail Confirm
  ///@param token
  @Get(path: '/users/migrate-mail-confirm')
  Future<chopper.Response> _usersMigrateMailConfirmGet({
    @Query('token') required String? token,
  });

  ///Change Password
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  usersChangePasswordPost({required ChangePasswordRequest? body}) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersChangePasswordPost(body: body);
  }

  ///Change Password
  @Post(path: '/users/change-password', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _usersChangePasswordPost({@Body() required ChangePasswordRequest? body});

  ///Read User
  ///@param user_id
  Future<chopper.Response<CoreUser>> usersUserIdGet({required String? userId}) {
    generatedMapping.putIfAbsent(CoreUser, () => CoreUser.fromJsonFactory);

    return _usersUserIdGet(userId: userId);
  }

  ///Read User
  ///@param user_id
  @Get(path: '/users/{user_id}')
  Future<chopper.Response<CoreUser>> _usersUserIdGet({
    @Path('user_id') required String? userId,
  });

  ///Update User
  ///@param user_id
  Future<chopper.Response> usersUserIdPatch({
    required String? userId,
    required CoreUserUpdateAdmin? body,
  }) {
    return _usersUserIdPatch(userId: userId, body: body);
  }

  ///Update User
  ///@param user_id
  @Patch(path: '/users/{user_id}', optionalBody: true)
  Future<chopper.Response> _usersUserIdPatch({
    @Path('user_id') required String? userId,
    @Body() required CoreUserUpdateAdmin? body,
  });

  ///Delete User
  Future<chopper.Response> usersMeAskDeletionPost() {
    return _usersMeAskDeletionPost();
  }

  ///Delete User
  @Post(path: '/users/me/ask-deletion', optionalBody: true)
  Future<chopper.Response> _usersMeAskDeletionPost();

  ///Merge Users
  Future<chopper.Response> usersMergePost({
    required CoreUserFusionRequest? body,
  }) {
    return _usersMergePost(body: body);
  }

  ///Merge Users
  @Post(path: '/users/merge', optionalBody: true)
  Future<chopper.Response> _usersMergePost({
    @Body() required CoreUserFusionRequest? body,
  });

  ///Read Own Profile Picture
  Future<chopper.Response> usersMeProfilePictureGet() {
    return _usersMeProfilePictureGet();
  }

  ///Read Own Profile Picture
  @Get(path: '/users/me/profile-picture')
  Future<chopper.Response> _usersMeProfilePictureGet();

  ///Create Current User Profile Picture
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  usersMeProfilePicturePost({required MultipartFile image}) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersMeProfilePicturePost(image: image);
  }

  ///Create Current User Profile Picture
  @Post(path: '/users/me/profile-picture', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _usersMeProfilePicturePost({@PartFile('image') required MultipartFile image});

  ///Read User Profile Picture
  ///@param user_id
  Future<chopper.Response> usersUserIdProfilePictureGet({
    required String? userId,
  }) {
    return _usersUserIdProfilePictureGet(userId: userId);
  }

  ///Read User Profile Picture
  ///@param user_id
  @Get(path: '/users/{user_id}/profile-picture')
  Future<chopper.Response> _usersUserIdProfilePictureGet({
    @Path('user_id') required String? userId,
  });

  ///Read Schools
  Future<chopper.Response<List<CoreSchool>>> schoolsGet() {
    generatedMapping.putIfAbsent(CoreSchool, () => CoreSchool.fromJsonFactory);

    return _schoolsGet();
  }

  ///Read Schools
  @Get(path: '/schools/')
  Future<chopper.Response<List<CoreSchool>>> _schoolsGet();

  ///Create School
  Future<chopper.Response<CoreSchool>> schoolsPost({
    required CoreSchoolBase? body,
  }) {
    generatedMapping.putIfAbsent(CoreSchool, () => CoreSchool.fromJsonFactory);

    return _schoolsPost(body: body);
  }

  ///Create School
  @Post(path: '/schools/', optionalBody: true)
  Future<chopper.Response<CoreSchool>> _schoolsPost({
    @Body() required CoreSchoolBase? body,
  });

  ///Read School
  ///@param school_id
  Future<chopper.Response<CoreSchool>> schoolsSchoolIdGet({
    required String? schoolId,
  }) {
    generatedMapping.putIfAbsent(CoreSchool, () => CoreSchool.fromJsonFactory);

    return _schoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Read School
  ///@param school_id
  @Get(path: '/schools/{school_id}')
  Future<chopper.Response<CoreSchool>> _schoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
  });

  ///Update School
  ///@param school_id
  Future<chopper.Response> schoolsSchoolIdPatch({
    required String? schoolId,
    required CoreSchoolUpdate? body,
  }) {
    return _schoolsSchoolIdPatch(schoolId: schoolId, body: body);
  }

  ///Update School
  ///@param school_id
  @Patch(path: '/schools/{school_id}', optionalBody: true)
  Future<chopper.Response> _schoolsSchoolIdPatch({
    @Path('school_id') required String? schoolId,
    @Body() required CoreSchoolUpdate? body,
  });

  ///Delete School
  ///@param school_id
  Future<chopper.Response> schoolsSchoolIdDelete({required String? schoolId}) {
    return _schoolsSchoolIdDelete(schoolId: schoolId);
  }

  ///Delete School
  ///@param school_id
  @Delete(path: '/schools/{school_id}')
  Future<chopper.Response> _schoolsSchoolIdDelete({
    @Path('school_id') required String? schoolId,
  });

  ///Read Information
  Future<chopper.Response<CoreInformation>> informationGet() {
    generatedMapping.putIfAbsent(
      CoreInformation,
      () => CoreInformation.fromJsonFactory,
    );

    return _informationGet();
  }

  ///Read Information
  @Get(path: '/information')
  Future<chopper.Response<CoreInformation>> _informationGet();

  ///Read Privacy
  Future<chopper.Response> privacyGet() {
    return _privacyGet();
  }

  ///Read Privacy
  @Get(path: '/privacy')
  Future<chopper.Response> _privacyGet();

  ///Read Terms And Conditions
  Future<chopper.Response> termsAndConditionsGet() {
    return _termsAndConditionsGet();
  }

  ///Read Terms And Conditions
  @Get(path: '/terms-and-conditions')
  Future<chopper.Response> _termsAndConditionsGet();

  ///Read Support
  Future<chopper.Response> supportGet() {
    return _supportGet();
  }

  ///Read Support
  @Get(path: '/support')
  Future<chopper.Response> _supportGet();

  ///Read Security Txt
  Future<chopper.Response> securityTxtGet() {
    return _securityTxtGet();
  }

  ///Read Security Txt
  @Get(path: '/security.txt')
  Future<chopper.Response> _securityTxtGet();

  ///Read Wellknown Security Txt
  Future<chopper.Response> wellKnownSecurityTxtGet() {
    return _wellKnownSecurityTxtGet();
  }

  ///Read Wellknown Security Txt
  @Get(path: '/.well-known/security.txt')
  Future<chopper.Response> _wellKnownSecurityTxtGet();

  ///Read Robots Txt
  Future<chopper.Response> robotsTxtGet() {
    return _robotsTxtGet();
  }

  ///Read Robots Txt
  @Get(path: '/robots.txt')
  Future<chopper.Response> _robotsTxtGet();

  ///Get Style File
  ///@param file
  Future<chopper.Response> styleFileCssGet({required String? file}) {
    return _styleFileCssGet(file: file);
  }

  ///Get Style File
  ///@param file
  @Get(path: '/style/{file}.css')
  Future<chopper.Response> _styleFileCssGet({
    @Path('file') required String? file,
  });

  ///Get Favicon
  Future<chopper.Response> faviconIcoGet() {
    return _faviconIcoGet();
  }

  ///Get Favicon
  @Get(path: '/favicon.ico')
  Future<chopper.Response> _faviconIcoGet();

  ///Get Module Visibility
  Future<chopper.Response<List<ModuleVisibility>>> moduleVisibilityGet() {
    generatedMapping.putIfAbsent(
      ModuleVisibility,
      () => ModuleVisibility.fromJsonFactory,
    );

    return _moduleVisibilityGet();
  }

  ///Get Module Visibility
  @Get(path: '/module-visibility/')
  Future<chopper.Response<List<ModuleVisibility>>> _moduleVisibilityGet();

  ///Add Module Visibility
  Future<chopper.Response> moduleVisibilityPost({
    required ModuleVisibilityCreate? body,
  }) {
    return _moduleVisibilityPost(body: body);
  }

  ///Add Module Visibility
  @Post(path: '/module-visibility/', optionalBody: true)
  Future<chopper.Response> _moduleVisibilityPost({
    @Body() required ModuleVisibilityCreate? body,
  });

  ///Get User Modules Visibility
  Future<chopper.Response<List<String>>> moduleVisibilityMeGet() {
    return _moduleVisibilityMeGet();
  }

  ///Get User Modules Visibility
  @Get(path: '/module-visibility/me')
  Future<chopper.Response<List<String>>> _moduleVisibilityMeGet();

  ///Delete Module Group Visibility
  ///@param root
  ///@param group_id
  Future<chopper.Response> moduleVisibilityRootGroupsGroupIdDelete({
    required String? root,
    required String? groupId,
  }) {
    return _moduleVisibilityRootGroupsGroupIdDelete(
      root: root,
      groupId: groupId,
    );
  }

  ///Delete Module Group Visibility
  ///@param root
  ///@param group_id
  @Delete(path: '/module-visibility/{root}/groups/{group_id}')
  Future<chopper.Response> _moduleVisibilityRootGroupsGroupIdDelete({
    @Path('root') required String? root,
    @Path('group_id') required String? groupId,
  });

  ///Delete Module Account Type Visibility
  ///@param root
  ///@param account_type
  Future<chopper.Response> moduleVisibilityRootAccountTypesAccountTypeDelete({
    required String? root,
    required enums.AccountType? accountType,
  }) {
    return _moduleVisibilityRootAccountTypesAccountTypeDelete(
      root: root,
      accountType: accountType?.value?.toString(),
    );
  }

  ///Delete Module Account Type Visibility
  ///@param root
  ///@param account_type
  @Delete(path: '/module-visibility/{root}/account-types/{account_type}')
  Future<chopper.Response> _moduleVisibilityRootAccountTypesAccountTypeDelete({
    @Path('root') required String? root,
    @Path('account_type') required String? accountType,
  });

  ///Webhook
  Future<chopper.Response> paymentHelloassoWebhookPost() {
    return _paymentHelloassoWebhookPost();
  }

  ///Webhook
  @Post(path: '/payment/helloasso/webhook', optionalBody: true)
  Future<chopper.Response> _paymentHelloassoWebhookPost();

  ///Read Groups
  Future<chopper.Response<List<CoreGroupSimple>>> groupsGet() {
    generatedMapping.putIfAbsent(
      CoreGroupSimple,
      () => CoreGroupSimple.fromJsonFactory,
    );

    return _groupsGet();
  }

  ///Read Groups
  @Get(path: '/groups/')
  Future<chopper.Response<List<CoreGroupSimple>>> _groupsGet();

  ///Create Group
  Future<chopper.Response<CoreGroupSimple>> groupsPost({
    required CoreGroupCreate? body,
  }) {
    generatedMapping.putIfAbsent(
      CoreGroupSimple,
      () => CoreGroupSimple.fromJsonFactory,
    );

    return _groupsPost(body: body);
  }

  ///Create Group
  @Post(path: '/groups/', optionalBody: true)
  Future<chopper.Response<CoreGroupSimple>> _groupsPost({
    @Body() required CoreGroupCreate? body,
  });

  ///Read Group
  ///@param group_id
  Future<chopper.Response<CoreGroup>> groupsGroupIdGet({
    required String? groupId,
  }) {
    generatedMapping.putIfAbsent(CoreGroup, () => CoreGroup.fromJsonFactory);

    return _groupsGroupIdGet(groupId: groupId);
  }

  ///Read Group
  ///@param group_id
  @Get(path: '/groups/{group_id}')
  Future<chopper.Response<CoreGroup>> _groupsGroupIdGet({
    @Path('group_id') required String? groupId,
  });

  ///Update Group
  ///@param group_id
  Future<chopper.Response> groupsGroupIdPatch({
    required String? groupId,
    required CoreGroupUpdate? body,
  }) {
    return _groupsGroupIdPatch(groupId: groupId, body: body);
  }

  ///Update Group
  ///@param group_id
  @Patch(path: '/groups/{group_id}', optionalBody: true)
  Future<chopper.Response> _groupsGroupIdPatch({
    @Path('group_id') required String? groupId,
    @Body() required CoreGroupUpdate? body,
  });

  ///Delete Group
  ///@param group_id
  Future<chopper.Response> groupsGroupIdDelete({required String? groupId}) {
    return _groupsGroupIdDelete(groupId: groupId);
  }

  ///Delete Group
  ///@param group_id
  @Delete(path: '/groups/{group_id}')
  Future<chopper.Response> _groupsGroupIdDelete({
    @Path('group_id') required String? groupId,
  });

  ///Create Membership
  Future<chopper.Response<CoreGroup>> groupsMembershipPost({
    required CoreMembership? body,
  }) {
    generatedMapping.putIfAbsent(CoreGroup, () => CoreGroup.fromJsonFactory);

    return _groupsMembershipPost(body: body);
  }

  ///Create Membership
  @Post(path: '/groups/membership', optionalBody: true)
  Future<chopper.Response<CoreGroup>> _groupsMembershipPost({
    @Body() required CoreMembership? body,
  });

  ///Delete Membership
  Future<chopper.Response> groupsMembershipDelete({
    required CoreMembershipDelete? body,
  }) {
    return _groupsMembershipDelete(body: body);
  }

  ///Delete Membership
  @Delete(path: '/groups/membership')
  Future<chopper.Response> _groupsMembershipDelete({
    @Body() required CoreMembershipDelete? body,
  });

  ///Create Batch Membership
  Future<chopper.Response> groupsBatchMembershipPost({
    required CoreBatchMembership? body,
  }) {
    return _groupsBatchMembershipPost(body: body);
  }

  ///Create Batch Membership
  @Post(path: '/groups/batch-membership', optionalBody: true)
  Future<chopper.Response> _groupsBatchMembershipPost({
    @Body() required CoreBatchMembership? body,
  });

  ///Delete Batch Membership
  Future<chopper.Response> groupsBatchMembershipDelete({
    required CoreBatchDeleteMembership? body,
  }) {
    return _groupsBatchMembershipDelete(body: body);
  }

  ///Delete Batch Membership
  @Delete(path: '/groups/batch-membership')
  Future<chopper.Response> _groupsBatchMembershipDelete({
    @Body() required CoreBatchDeleteMembership? body,
  });

  ///Read Associations Memberships
  ///@param exclude_external
  Future<chopper.Response<List<MembershipSimple>>> membershipsGet({
    bool? excludeExternal,
    required BodyReadAssociationsMembershipsMembershipsGet? body,
  }) {
    generatedMapping.putIfAbsent(
      MembershipSimple,
      () => MembershipSimple.fromJsonFactory,
    );

    return _membershipsGet(excludeExternal: excludeExternal, body: body);
  }

  ///Read Associations Memberships
  ///@param exclude_external
  @Get(path: '/memberships/')
  Future<chopper.Response<List<MembershipSimple>>> _membershipsGet({
    @Query('exclude_external') bool? excludeExternal,
    @Body() required BodyReadAssociationsMembershipsMembershipsGet? body,
  });

  ///Create Association Membership
  Future<chopper.Response<MembershipSimple>> membershipsPost({
    required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
  }) {
    generatedMapping.putIfAbsent(
      MembershipSimple,
      () => MembershipSimple.fromJsonFactory,
    );

    return _membershipsPost(body: body);
  }

  ///Create Association Membership
  @Post(path: '/memberships/', optionalBody: true)
  Future<chopper.Response<MembershipSimple>> _membershipsPost({
    @Body() required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
  });

  ///Read Association Membership
  ///@param association_membership_id
  ///@param minimalStartDate
  ///@param maximalStartDate
  ///@param minimalEndDate
  ///@param maximalEndDate
  Future<chopper.Response<List<UserMembershipComplete>>>
  membershipsAssociationMembershipIdMembersGet({
    required String? associationMembershipId,
    String? minimalStartDate,
    String? maximalStartDate,
    String? minimalEndDate,
    String? maximalEndDate,
  }) {
    generatedMapping.putIfAbsent(
      UserMembershipComplete,
      () => UserMembershipComplete.fromJsonFactory,
    );

    return _membershipsAssociationMembershipIdMembersGet(
      associationMembershipId: associationMembershipId,
      minimalStartDate: minimalStartDate,
      maximalStartDate: maximalStartDate,
      minimalEndDate: minimalEndDate,
      maximalEndDate: maximalEndDate,
    );
  }

  ///Read Association Membership
  ///@param association_membership_id
  ///@param minimalStartDate
  ///@param maximalStartDate
  ///@param minimalEndDate
  ///@param maximalEndDate
  @Get(path: '/memberships/{association_membership_id}/members')
  Future<chopper.Response<List<UserMembershipComplete>>>
  _membershipsAssociationMembershipIdMembersGet({
    @Path('association_membership_id') required String? associationMembershipId,
    @Query('minimalStartDate') String? minimalStartDate,
    @Query('maximalStartDate') String? maximalStartDate,
    @Query('minimalEndDate') String? minimalEndDate,
    @Query('maximalEndDate') String? maximalEndDate,
  });

  ///Update Association Membership
  ///@param association_membership_id
  Future<chopper.Response> membershipsAssociationMembershipIdPatch({
    required String? associationMembershipId,
    required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
  }) {
    return _membershipsAssociationMembershipIdPatch(
      associationMembershipId: associationMembershipId,
      body: body,
    );
  }

  ///Update Association Membership
  ///@param association_membership_id
  @Patch(path: '/memberships/{association_membership_id}', optionalBody: true)
  Future<chopper.Response> _membershipsAssociationMembershipIdPatch({
    @Path('association_membership_id') required String? associationMembershipId,
    @Body() required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
  });

  ///Delete Association Membership
  ///@param association_membership_id
  Future<chopper.Response> membershipsAssociationMembershipIdDelete({
    required String? associationMembershipId,
  }) {
    return _membershipsAssociationMembershipIdDelete(
      associationMembershipId: associationMembershipId,
    );
  }

  ///Delete Association Membership
  ///@param association_membership_id
  @Delete(path: '/memberships/{association_membership_id}')
  Future<chopper.Response> _membershipsAssociationMembershipIdDelete({
    @Path('association_membership_id') required String? associationMembershipId,
  });

  ///Read User Memberships
  ///@param user_id
  Future<chopper.Response<List<UserMembershipComplete>>>
  membershipsUsersUserIdGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      UserMembershipComplete,
      () => UserMembershipComplete.fromJsonFactory,
    );

    return _membershipsUsersUserIdGet(userId: userId);
  }

  ///Read User Memberships
  ///@param user_id
  @Get(path: '/memberships/users/{user_id}')
  Future<chopper.Response<List<UserMembershipComplete>>>
  _membershipsUsersUserIdGet({@Path('user_id') required String? userId});

  ///Create User Membership
  ///@param user_id
  Future<chopper.Response<UserMembershipComplete>> membershipsUsersUserIdPost({
    required String? userId,
    required UserMembershipBase? body,
  }) {
    generatedMapping.putIfAbsent(
      UserMembershipComplete,
      () => UserMembershipComplete.fromJsonFactory,
    );

    return _membershipsUsersUserIdPost(userId: userId, body: body);
  }

  ///Create User Membership
  ///@param user_id
  @Post(path: '/memberships/users/{user_id}', optionalBody: true)
  Future<chopper.Response<UserMembershipComplete>> _membershipsUsersUserIdPost({
    @Path('user_id') required String? userId,
    @Body() required UserMembershipBase? body,
  });

  ///Read User Association Membership History
  ///@param user_id
  ///@param association_membership_id
  Future<chopper.Response<List<UserMembershipComplete>>>
  membershipsUsersUserIdAssociationMembershipIdGet({
    required String? userId,
    required String? associationMembershipId,
  }) {
    generatedMapping.putIfAbsent(
      UserMembershipComplete,
      () => UserMembershipComplete.fromJsonFactory,
    );

    return _membershipsUsersUserIdAssociationMembershipIdGet(
      userId: userId,
      associationMembershipId: associationMembershipId,
    );
  }

  ///Read User Association Membership History
  ///@param user_id
  ///@param association_membership_id
  @Get(path: '/memberships/users/{user_id}/{association_membership_id}')
  Future<chopper.Response<List<UserMembershipComplete>>>
  _membershipsUsersUserIdAssociationMembershipIdGet({
    @Path('user_id') required String? userId,
    @Path('association_membership_id') required String? associationMembershipId,
  });

  ///Add Batch Membership
  ///@param association_membership_id
  Future<chopper.Response<List<MembershipUserMappingEmail>>>
  membershipsAssociationMembershipIdAddBatchPost({
    required String? associationMembershipId,
    required List<MembershipUserMappingEmail>? body,
  }) {
    generatedMapping.putIfAbsent(
      MembershipUserMappingEmail,
      () => MembershipUserMappingEmail.fromJsonFactory,
    );

    return _membershipsAssociationMembershipIdAddBatchPost(
      associationMembershipId: associationMembershipId,
      body: body,
    );
  }

  ///Add Batch Membership
  ///@param association_membership_id
  @Post(
    path: '/memberships/{association_membership_id}/add-batch/',
    optionalBody: true,
  )
  Future<chopper.Response<List<MembershipUserMappingEmail>>>
  _membershipsAssociationMembershipIdAddBatchPost({
    @Path('association_membership_id') required String? associationMembershipId,
    @Body() required List<MembershipUserMappingEmail>? body,
  });

  ///Update User Membership
  ///@param membership_id
  Future<chopper.Response> membershipsUsersMembershipIdPatch({
    required String? membershipId,
    required UserMembershipEdit? body,
  }) {
    return _membershipsUsersMembershipIdPatch(
      membershipId: membershipId,
      body: body,
    );
  }

  ///Update User Membership
  ///@param membership_id
  @Patch(path: '/memberships/users/{membership_id}', optionalBody: true)
  Future<chopper.Response> _membershipsUsersMembershipIdPatch({
    @Path('membership_id') required String? membershipId,
    @Body() required UserMembershipEdit? body,
  });

  ///Delete User Membership
  ///@param membership_id
  Future<chopper.Response> membershipsUsersMembershipIdDelete({
    required String? membershipId,
  }) {
    return _membershipsUsersMembershipIdDelete(membershipId: membershipId);
  }

  ///Delete User Membership
  ///@param membership_id
  @Delete(path: '/memberships/users/{membership_id}')
  Future<chopper.Response> _membershipsUsersMembershipIdDelete({
    @Path('membership_id') required String? membershipId,
  });

  ///Get Raffle
  Future<chopper.Response<List<RaffleComplete>>> tombolaRafflesGet() {
    generatedMapping.putIfAbsent(
      RaffleComplete,
      () => RaffleComplete.fromJsonFactory,
    );

    return _tombolaRafflesGet();
  }

  ///Get Raffle
  @Get(path: '/tombola/raffles')
  Future<chopper.Response<List<RaffleComplete>>> _tombolaRafflesGet();

  ///Create Raffle
  Future<chopper.Response<RaffleComplete>> tombolaRafflesPost({
    required RaffleBase? body,
  }) {
    generatedMapping.putIfAbsent(
      RaffleComplete,
      () => RaffleComplete.fromJsonFactory,
    );

    return _tombolaRafflesPost(body: body);
  }

  ///Create Raffle
  @Post(path: '/tombola/raffles', optionalBody: true)
  Future<chopper.Response<RaffleComplete>> _tombolaRafflesPost({
    @Body() required RaffleBase? body,
  });

  ///Edit Raffle
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdPatch({
    required String? raffleId,
    required RaffleEdit? body,
  }) {
    return _tombolaRafflesRaffleIdPatch(raffleId: raffleId, body: body);
  }

  ///Edit Raffle
  ///@param raffle_id
  @Patch(path: '/tombola/raffles/{raffle_id}', optionalBody: true)
  Future<chopper.Response> _tombolaRafflesRaffleIdPatch({
    @Path('raffle_id') required String? raffleId,
    @Body() required RaffleEdit? body,
  });

  ///Delete Raffle
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdDelete({
    required String? raffleId,
  }) {
    return _tombolaRafflesRaffleIdDelete(raffleId: raffleId);
  }

  ///Delete Raffle
  ///@param raffle_id
  @Delete(path: '/tombola/raffles/{raffle_id}')
  Future<chopper.Response> _tombolaRafflesRaffleIdDelete({
    @Path('raffle_id') required String? raffleId,
  });

  ///Get Raffles By Group Id
  ///@param group_id
  Future<chopper.Response<List<RaffleComplete>>> tombolaGroupGroupIdRafflesGet({
    required String? groupId,
  }) {
    generatedMapping.putIfAbsent(
      RaffleComplete,
      () => RaffleComplete.fromJsonFactory,
    );

    return _tombolaGroupGroupIdRafflesGet(groupId: groupId);
  }

  ///Get Raffles By Group Id
  ///@param group_id
  @Get(path: '/tombola/group/{group_id}/raffles')
  Future<chopper.Response<List<RaffleComplete>>>
  _tombolaGroupGroupIdRafflesGet({@Path('group_id') required String? groupId});

  ///Get Raffle Stats
  ///@param raffle_id
  Future<chopper.Response<RaffleStats>> tombolaRafflesRaffleIdStatsGet({
    required String? raffleId,
  }) {
    generatedMapping.putIfAbsent(
      RaffleStats,
      () => RaffleStats.fromJsonFactory,
    );

    return _tombolaRafflesRaffleIdStatsGet(raffleId: raffleId);
  }

  ///Get Raffle Stats
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/stats')
  Future<chopper.Response<RaffleStats>> _tombolaRafflesRaffleIdStatsGet({
    @Path('raffle_id') required String? raffleId,
  });

  ///Create Current Raffle Logo
  ///@param raffle_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  tombolaRafflesRaffleIdLogoPost({
    required String? raffleId,
    required MultipartFile image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _tombolaRafflesRaffleIdLogoPost(raffleId: raffleId, image: image);
  }

  ///Create Current Raffle Logo
  ///@param raffle_id
  @Post(path: '/tombola/raffles/{raffle_id}/logo', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _tombolaRafflesRaffleIdLogoPost({
    @Path('raffle_id') required String? raffleId,
    @PartFile('image') required MultipartFile image,
  });

  ///Read Raffle Logo
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdLogoGet({
    required String? raffleId,
  }) {
    return _tombolaRafflesRaffleIdLogoGet(raffleId: raffleId);
  }

  ///Read Raffle Logo
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/logo')
  Future<chopper.Response> _tombolaRafflesRaffleIdLogoGet({
    @Path('raffle_id') required String? raffleId,
  });

  ///Get Pack Tickets
  Future<chopper.Response<List<PackTicketSimple>>> tombolaPackTicketsGet() {
    generatedMapping.putIfAbsent(
      PackTicketSimple,
      () => PackTicketSimple.fromJsonFactory,
    );

    return _tombolaPackTicketsGet();
  }

  ///Get Pack Tickets
  @Get(path: '/tombola/pack_tickets')
  Future<chopper.Response<List<PackTicketSimple>>> _tombolaPackTicketsGet();

  ///Create Packticket
  Future<chopper.Response<PackTicketSimple>> tombolaPackTicketsPost({
    required PackTicketBase? body,
  }) {
    generatedMapping.putIfAbsent(
      PackTicketSimple,
      () => PackTicketSimple.fromJsonFactory,
    );

    return _tombolaPackTicketsPost(body: body);
  }

  ///Create Packticket
  @Post(path: '/tombola/pack_tickets', optionalBody: true)
  Future<chopper.Response<PackTicketSimple>> _tombolaPackTicketsPost({
    @Body() required PackTicketBase? body,
  });

  ///Edit Packticket
  ///@param packticket_id
  Future<chopper.Response> tombolaPackTicketsPackticketIdPatch({
    required String? packticketId,
    required PackTicketEdit? body,
  }) {
    return _tombolaPackTicketsPackticketIdPatch(
      packticketId: packticketId,
      body: body,
    );
  }

  ///Edit Packticket
  ///@param packticket_id
  @Patch(path: '/tombola/pack_tickets/{packticket_id}', optionalBody: true)
  Future<chopper.Response> _tombolaPackTicketsPackticketIdPatch({
    @Path('packticket_id') required String? packticketId,
    @Body() required PackTicketEdit? body,
  });

  ///Delete Packticket
  ///@param packticket_id
  Future<chopper.Response> tombolaPackTicketsPackticketIdDelete({
    required String? packticketId,
  }) {
    return _tombolaPackTicketsPackticketIdDelete(packticketId: packticketId);
  }

  ///Delete Packticket
  ///@param packticket_id
  @Delete(path: '/tombola/pack_tickets/{packticket_id}')
  Future<chopper.Response> _tombolaPackTicketsPackticketIdDelete({
    @Path('packticket_id') required String? packticketId,
  });

  ///Get Pack Tickets By Raffle Id
  ///@param raffle_id
  Future<chopper.Response<List<PackTicketSimple>>>
  tombolaRafflesRaffleIdPackTicketsGet({required String? raffleId}) {
    generatedMapping.putIfAbsent(
      PackTicketSimple,
      () => PackTicketSimple.fromJsonFactory,
    );

    return _tombolaRafflesRaffleIdPackTicketsGet(raffleId: raffleId);
  }

  ///Get Pack Tickets By Raffle Id
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/pack_tickets')
  Future<chopper.Response<List<PackTicketSimple>>>
  _tombolaRafflesRaffleIdPackTicketsGet({
    @Path('raffle_id') required String? raffleId,
  });

  ///Get Tickets
  Future<chopper.Response<List<TicketSimple>>> tombolaTicketsGet() {
    generatedMapping.putIfAbsent(
      TicketSimple,
      () => TicketSimple.fromJsonFactory,
    );

    return _tombolaTicketsGet();
  }

  ///Get Tickets
  @Get(path: '/tombola/tickets')
  Future<chopper.Response<List<TicketSimple>>> _tombolaTicketsGet();

  ///Buy Ticket
  ///@param pack_id
  Future<chopper.Response<List<TicketComplete>>> tombolaTicketsBuyPackIdPost({
    required String? packId,
  }) {
    generatedMapping.putIfAbsent(
      TicketComplete,
      () => TicketComplete.fromJsonFactory,
    );

    return _tombolaTicketsBuyPackIdPost(packId: packId);
  }

  ///Buy Ticket
  ///@param pack_id
  @Post(path: '/tombola/tickets/buy/{pack_id}', optionalBody: true)
  Future<chopper.Response<List<TicketComplete>>> _tombolaTicketsBuyPackIdPost({
    @Path('pack_id') required String? packId,
  });

  ///Get Tickets By Userid
  ///@param user_id
  Future<chopper.Response<List<TicketComplete>>> tombolaUsersUserIdTicketsGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      TicketComplete,
      () => TicketComplete.fromJsonFactory,
    );

    return _tombolaUsersUserIdTicketsGet(userId: userId);
  }

  ///Get Tickets By Userid
  ///@param user_id
  @Get(path: '/tombola/users/{user_id}/tickets')
  Future<chopper.Response<List<TicketComplete>>> _tombolaUsersUserIdTicketsGet({
    @Path('user_id') required String? userId,
  });

  ///Get Tickets By Raffleid
  ///@param raffle_id
  Future<chopper.Response<List<TicketComplete>>>
  tombolaRafflesRaffleIdTicketsGet({required String? raffleId}) {
    generatedMapping.putIfAbsent(
      TicketComplete,
      () => TicketComplete.fromJsonFactory,
    );

    return _tombolaRafflesRaffleIdTicketsGet(raffleId: raffleId);
  }

  ///Get Tickets By Raffleid
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/tickets')
  Future<chopper.Response<List<TicketComplete>>>
  _tombolaRafflesRaffleIdTicketsGet({
    @Path('raffle_id') required String? raffleId,
  });

  ///Get Prizes
  Future<chopper.Response<List<PrizeSimple>>> tombolaPrizesGet() {
    generatedMapping.putIfAbsent(
      PrizeSimple,
      () => PrizeSimple.fromJsonFactory,
    );

    return _tombolaPrizesGet();
  }

  ///Get Prizes
  @Get(path: '/tombola/prizes')
  Future<chopper.Response<List<PrizeSimple>>> _tombolaPrizesGet();

  ///Create Prize
  Future<chopper.Response<PrizeSimple>> tombolaPrizesPost({
    required PrizeBase? body,
  }) {
    generatedMapping.putIfAbsent(
      PrizeSimple,
      () => PrizeSimple.fromJsonFactory,
    );

    return _tombolaPrizesPost(body: body);
  }

  ///Create Prize
  @Post(path: '/tombola/prizes', optionalBody: true)
  Future<chopper.Response<PrizeSimple>> _tombolaPrizesPost({
    @Body() required PrizeBase? body,
  });

  ///Edit Prize
  ///@param prize_id
  Future<chopper.Response> tombolaPrizesPrizeIdPatch({
    required String? prizeId,
    required PrizeEdit? body,
  }) {
    return _tombolaPrizesPrizeIdPatch(prizeId: prizeId, body: body);
  }

  ///Edit Prize
  ///@param prize_id
  @Patch(path: '/tombola/prizes/{prize_id}', optionalBody: true)
  Future<chopper.Response> _tombolaPrizesPrizeIdPatch({
    @Path('prize_id') required String? prizeId,
    @Body() required PrizeEdit? body,
  });

  ///Delete Prize
  ///@param prize_id
  Future<chopper.Response> tombolaPrizesPrizeIdDelete({
    required String? prizeId,
  }) {
    return _tombolaPrizesPrizeIdDelete(prizeId: prizeId);
  }

  ///Delete Prize
  ///@param prize_id
  @Delete(path: '/tombola/prizes/{prize_id}')
  Future<chopper.Response> _tombolaPrizesPrizeIdDelete({
    @Path('prize_id') required String? prizeId,
  });

  ///Get Prizes By Raffleid
  ///@param raffle_id
  Future<chopper.Response<List<PrizeSimple>>> tombolaRafflesRaffleIdPrizesGet({
    required String? raffleId,
  }) {
    generatedMapping.putIfAbsent(
      PrizeSimple,
      () => PrizeSimple.fromJsonFactory,
    );

    return _tombolaRafflesRaffleIdPrizesGet(raffleId: raffleId);
  }

  ///Get Prizes By Raffleid
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/prizes')
  Future<chopper.Response<List<PrizeSimple>>> _tombolaRafflesRaffleIdPrizesGet({
    @Path('raffle_id') required String? raffleId,
  });

  ///Create Prize Picture
  ///@param prize_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  tombolaPrizesPrizeIdPicturePost({
    required String? prizeId,
    required MultipartFile image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _tombolaPrizesPrizeIdPicturePost(prizeId: prizeId, image: image);
  }

  ///Create Prize Picture
  ///@param prize_id
  @Post(path: '/tombola/prizes/{prize_id}/picture', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _tombolaPrizesPrizeIdPicturePost({
    @Path('prize_id') required String? prizeId,
    @PartFile('image') required MultipartFile image,
  });

  ///Read Prize Logo
  ///@param prize_id
  Future<chopper.Response> tombolaPrizesPrizeIdPictureGet({
    required String? prizeId,
  }) {
    return _tombolaPrizesPrizeIdPictureGet(prizeId: prizeId);
  }

  ///Read Prize Logo
  ///@param prize_id
  @Get(path: '/tombola/prizes/{prize_id}/picture')
  Future<chopper.Response> _tombolaPrizesPrizeIdPictureGet({
    @Path('prize_id') required String? prizeId,
  });

  ///Get Users Cash
  Future<chopper.Response<List<CashComplete>>> tombolaUsersCashGet() {
    generatedMapping.putIfAbsent(
      CashComplete,
      () => CashComplete.fromJsonFactory,
    );

    return _tombolaUsersCashGet();
  }

  ///Get Users Cash
  @Get(path: '/tombola/users/cash')
  Future<chopper.Response<List<CashComplete>>> _tombolaUsersCashGet();

  ///Get Cash By Id
  ///@param user_id
  Future<chopper.Response<CashComplete>> tombolaUsersUserIdCashGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      CashComplete,
      () => CashComplete.fromJsonFactory,
    );

    return _tombolaUsersUserIdCashGet(userId: userId);
  }

  ///Get Cash By Id
  ///@param user_id
  @Get(path: '/tombola/users/{user_id}/cash')
  Future<chopper.Response<CashComplete>> _tombolaUsersUserIdCashGet({
    @Path('user_id') required String? userId,
  });

  ///Create Cash Of User
  ///@param user_id
  Future<chopper.Response<CashComplete>> tombolaUsersUserIdCashPost({
    required String? userId,
    required CashEdit? body,
  }) {
    generatedMapping.putIfAbsent(
      CashComplete,
      () => CashComplete.fromJsonFactory,
    );

    return _tombolaUsersUserIdCashPost(userId: userId, body: body);
  }

  ///Create Cash Of User
  ///@param user_id
  @Post(path: '/tombola/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response<CashComplete>> _tombolaUsersUserIdCashPost({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
  });

  ///Edit Cash By Id
  ///@param user_id
  Future<chopper.Response> tombolaUsersUserIdCashPatch({
    required String? userId,
    required CashEdit? body,
  }) {
    return _tombolaUsersUserIdCashPatch(userId: userId, body: body);
  }

  ///Edit Cash By Id
  ///@param user_id
  @Patch(path: '/tombola/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response> _tombolaUsersUserIdCashPatch({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
  });

  ///Draw Winner
  ///@param prize_id
  Future<chopper.Response<List<TicketComplete>>> tombolaPrizesPrizeIdDrawPost({
    required String? prizeId,
  }) {
    generatedMapping.putIfAbsent(
      TicketComplete,
      () => TicketComplete.fromJsonFactory,
    );

    return _tombolaPrizesPrizeIdDrawPost(prizeId: prizeId);
  }

  ///Draw Winner
  ///@param prize_id
  @Post(path: '/tombola/prizes/{prize_id}/draw', optionalBody: true)
  Future<chopper.Response<List<TicketComplete>>> _tombolaPrizesPrizeIdDrawPost({
    @Path('prize_id') required String? prizeId,
  });

  ///Open Raffle
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdOpenPatch({
    required String? raffleId,
  }) {
    return _tombolaRafflesRaffleIdOpenPatch(raffleId: raffleId);
  }

  ///Open Raffle
  ///@param raffle_id
  @Patch(path: '/tombola/raffles/{raffle_id}/open', optionalBody: true)
  Future<chopper.Response> _tombolaRafflesRaffleIdOpenPatch({
    @Path('raffle_id') required String? raffleId,
  });

  ///Lock Raffle
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdLockPatch({
    required String? raffleId,
  }) {
    return _tombolaRafflesRaffleIdLockPatch(raffleId: raffleId);
  }

  ///Lock Raffle
  ///@param raffle_id
  @Patch(path: '/tombola/raffles/{raffle_id}/lock', optionalBody: true)
  Future<chopper.Response> _tombolaRafflesRaffleIdLockPatch({
    @Path('raffle_id') required String? raffleId,
  });

  ///Get Flappybird Score
  Future<chopper.Response<List<FlappyBirdScoreInDB>>> flappybirdScoresGet() {
    generatedMapping.putIfAbsent(
      FlappyBirdScoreInDB,
      () => FlappyBirdScoreInDB.fromJsonFactory,
    );

    return _flappybirdScoresGet();
  }

  ///Get Flappybird Score
  @Get(path: '/flappybird/scores')
  Future<chopper.Response<List<FlappyBirdScoreInDB>>> _flappybirdScoresGet();

  ///Create Flappybird Score
  Future<chopper.Response<FlappyBirdScoreBase>> flappybirdScoresPost({
    required FlappyBirdScoreBase? body,
  }) {
    generatedMapping.putIfAbsent(
      FlappyBirdScoreBase,
      () => FlappyBirdScoreBase.fromJsonFactory,
    );

    return _flappybirdScoresPost(body: body);
  }

  ///Create Flappybird Score
  @Post(path: '/flappybird/scores', optionalBody: true)
  Future<chopper.Response<FlappyBirdScoreBase>> _flappybirdScoresPost({
    @Body() required FlappyBirdScoreBase? body,
  });

  ///Get Current User Flappybird Personal Best
  Future<chopper.Response<FlappyBirdScoreCompleteFeedBack>>
  flappybirdScoresMeGet() {
    generatedMapping.putIfAbsent(
      FlappyBirdScoreCompleteFeedBack,
      () => FlappyBirdScoreCompleteFeedBack.fromJsonFactory,
    );

    return _flappybirdScoresMeGet();
  }

  ///Get Current User Flappybird Personal Best
  @Get(path: '/flappybird/scores/me')
  Future<chopper.Response<FlappyBirdScoreCompleteFeedBack>>
  _flappybirdScoresMeGet();

  ///Remove Flappybird Score
  ///@param targeted_user_id
  Future<chopper.Response> flappybirdScoresTargetedUserIdDelete({
    required String? targetedUserId,
  }) {
    return _flappybirdScoresTargetedUserIdDelete(
      targetedUserId: targetedUserId,
    );
  }

  ///Remove Flappybird Score
  ///@param targeted_user_id
  @Delete(path: '/flappybird/scores/{targeted_user_id}')
  Future<chopper.Response> _flappybirdScoresTargetedUserIdDelete({
    @Path('targeted_user_id') required String? targetedUserId,
  });

  ///Get Paper Pdf
  ///@param paper_id
  Future<chopper.Response> phPaperIdPdfGet({required String? paperId}) {
    return _phPaperIdPdfGet(paperId: paperId);
  }

  ///Get Paper Pdf
  ///@param paper_id
  @Get(path: '/ph/{paper_id}/pdf')
  Future<chopper.Response> _phPaperIdPdfGet({
    @Path('paper_id') required String? paperId,
  });

  ///Create Paper Pdf And Cover
  ///@param paper_id
  Future<chopper.Response> phPaperIdPdfPost({
    required String? paperId,
    required MultipartFile pdf,
  }) {
    return _phPaperIdPdfPost(paperId: paperId, pdf: pdf);
  }

  ///Create Paper Pdf And Cover
  ///@param paper_id
  @Post(path: '/ph/{paper_id}/pdf', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _phPaperIdPdfPost({
    @Path('paper_id') required String? paperId,
    @PartFile('pdf') required MultipartFile pdf,
  });

  ///Get Papers
  Future<chopper.Response<List<PaperComplete>>> phGet() {
    generatedMapping.putIfAbsent(
      PaperComplete,
      () => PaperComplete.fromJsonFactory,
    );

    return _phGet();
  }

  ///Get Papers
  @Get(path: '/ph/')
  Future<chopper.Response<List<PaperComplete>>> _phGet();

  ///Create Paper
  Future<chopper.Response<PaperComplete>> phPost({required PaperBase? body}) {
    generatedMapping.putIfAbsent(
      PaperComplete,
      () => PaperComplete.fromJsonFactory,
    );

    return _phPost(body: body);
  }

  ///Create Paper
  @Post(path: '/ph/', optionalBody: true)
  Future<chopper.Response<PaperComplete>> _phPost({
    @Body() required PaperBase? body,
  });

  ///Get Papers Admin
  Future<chopper.Response<List<PaperComplete>>> phAdminGet() {
    generatedMapping.putIfAbsent(
      PaperComplete,
      () => PaperComplete.fromJsonFactory,
    );

    return _phAdminGet();
  }

  ///Get Papers Admin
  @Get(path: '/ph/admin')
  Future<chopper.Response<List<PaperComplete>>> _phAdminGet();

  ///Get Cover
  ///@param paper_id
  Future<chopper.Response> phPaperIdCoverGet({required String? paperId}) {
    return _phPaperIdCoverGet(paperId: paperId);
  }

  ///Get Cover
  ///@param paper_id
  @Get(path: '/ph/{paper_id}/cover')
  Future<chopper.Response> _phPaperIdCoverGet({
    @Path('paper_id') required String? paperId,
  });

  ///Update Paper
  ///@param paper_id
  Future<chopper.Response> phPaperIdPatch({
    required String? paperId,
    required PaperUpdate? body,
  }) {
    return _phPaperIdPatch(paperId: paperId, body: body);
  }

  ///Update Paper
  ///@param paper_id
  @Patch(path: '/ph/{paper_id}', optionalBody: true)
  Future<chopper.Response> _phPaperIdPatch({
    @Path('paper_id') required String? paperId,
    @Body() required PaperUpdate? body,
  });

  ///Delete Paper
  ///@param paper_id
  Future<chopper.Response> phPaperIdDelete({required String? paperId}) {
    return _phPaperIdDelete(paperId: paperId);
  }

  ///Delete Paper
  ///@param paper_id
  @Delete(path: '/ph/{paper_id}')
  Future<chopper.Response> _phPaperIdDelete({
    @Path('paper_id') required String? paperId,
  });

  ///Get Movie
  ///@param themoviedb_id
  Future<chopper.Response<TheMovieDB>> cinemaThemoviedbThemoviedbIdGet({
    required String? themoviedbId,
  }) {
    generatedMapping.putIfAbsent(TheMovieDB, () => TheMovieDB.fromJsonFactory);

    return _cinemaThemoviedbThemoviedbIdGet(themoviedbId: themoviedbId);
  }

  ///Get Movie
  ///@param themoviedb_id
  @Get(path: '/cinema/themoviedb/{themoviedb_id}')
  Future<chopper.Response<TheMovieDB>> _cinemaThemoviedbThemoviedbIdGet({
    @Path('themoviedb_id') required String? themoviedbId,
  });

  ///Get Sessions
  Future<chopper.Response<List<CineSessionComplete>>> cinemaSessionsGet() {
    generatedMapping.putIfAbsent(
      CineSessionComplete,
      () => CineSessionComplete.fromJsonFactory,
    );

    return _cinemaSessionsGet();
  }

  ///Get Sessions
  @Get(path: '/cinema/sessions')
  Future<chopper.Response<List<CineSessionComplete>>> _cinemaSessionsGet();

  ///Create Session
  Future<chopper.Response<CineSessionComplete>> cinemaSessionsPost({
    required CineSessionBase? body,
  }) {
    generatedMapping.putIfAbsent(
      CineSessionComplete,
      () => CineSessionComplete.fromJsonFactory,
    );

    return _cinemaSessionsPost(body: body);
  }

  ///Create Session
  @Post(path: '/cinema/sessions', optionalBody: true)
  Future<chopper.Response<CineSessionComplete>> _cinemaSessionsPost({
    @Body() required CineSessionBase? body,
  });

  ///Update Session
  ///@param session_id
  Future<chopper.Response> cinemaSessionsSessionIdPatch({
    required String? sessionId,
    required CineSessionUpdate? body,
  }) {
    return _cinemaSessionsSessionIdPatch(sessionId: sessionId, body: body);
  }

  ///Update Session
  ///@param session_id
  @Patch(path: '/cinema/sessions/{session_id}', optionalBody: true)
  Future<chopper.Response> _cinemaSessionsSessionIdPatch({
    @Path('session_id') required String? sessionId,
    @Body() required CineSessionUpdate? body,
  });

  ///Delete Session
  ///@param session_id
  Future<chopper.Response> cinemaSessionsSessionIdDelete({
    required String? sessionId,
  }) {
    return _cinemaSessionsSessionIdDelete(sessionId: sessionId);
  }

  ///Delete Session
  ///@param session_id
  @Delete(path: '/cinema/sessions/{session_id}')
  Future<chopper.Response> _cinemaSessionsSessionIdDelete({
    @Path('session_id') required String? sessionId,
  });

  ///Create Campaigns Logo
  ///@param session_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  cinemaSessionsSessionIdPosterPost({
    required String? sessionId,
    required MultipartFile image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _cinemaSessionsSessionIdPosterPost(
      sessionId: sessionId,
      image: image,
    );
  }

  ///Create Campaigns Logo
  ///@param session_id
  @Post(path: '/cinema/sessions/{session_id}/poster', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _cinemaSessionsSessionIdPosterPost({
    @Path('session_id') required String? sessionId,
    @PartFile('image') required MultipartFile image,
  });

  ///Read Session Poster
  ///@param session_id
  Future<chopper.Response> cinemaSessionsSessionIdPosterGet({
    required String? sessionId,
  }) {
    return _cinemaSessionsSessionIdPosterGet(sessionId: sessionId);
  }

  ///Read Session Poster
  ///@param session_id
  @Get(path: '/cinema/sessions/{session_id}/poster')
  Future<chopper.Response> _cinemaSessionsSessionIdPosterGet({
    @Path('session_id') required String? sessionId,
  });

  ///Get Events
  Future<chopper.Response<List<EventReturn>>> calendarEventsGet() {
    generatedMapping.putIfAbsent(
      EventReturn,
      () => EventReturn.fromJsonFactory,
    );

    return _calendarEventsGet();
  }

  ///Get Events
  @Get(path: '/calendar/events/')
  Future<chopper.Response<List<EventReturn>>> _calendarEventsGet();

  ///Add Event
  Future<chopper.Response<EventReturn>> calendarEventsPost({
    required EventBase? body,
  }) {
    generatedMapping.putIfAbsent(
      EventReturn,
      () => EventReturn.fromJsonFactory,
    );

    return _calendarEventsPost(body: body);
  }

  ///Add Event
  @Post(path: '/calendar/events/', optionalBody: true)
  Future<chopper.Response<EventReturn>> _calendarEventsPost({
    @Body() required EventBase? body,
  });

  ///Get Confirmed Events
  Future<chopper.Response<List<EventComplete>>> calendarEventsConfirmedGet() {
    generatedMapping.putIfAbsent(
      EventComplete,
      () => EventComplete.fromJsonFactory,
    );

    return _calendarEventsConfirmedGet();
  }

  ///Get Confirmed Events
  @Get(path: '/calendar/events/confirmed')
  Future<chopper.Response<List<EventComplete>>> _calendarEventsConfirmedGet();

  ///Get Applicant Bookings
  ///@param applicant_id
  Future<chopper.Response<List<EventReturn>>> calendarEventsUserApplicantIdGet({
    required String? applicantId,
  }) {
    generatedMapping.putIfAbsent(
      EventReturn,
      () => EventReturn.fromJsonFactory,
    );

    return _calendarEventsUserApplicantIdGet(applicantId: applicantId);
  }

  ///Get Applicant Bookings
  ///@param applicant_id
  @Get(path: '/calendar/events/user/{applicant_id}')
  Future<chopper.Response<List<EventReturn>>>
  _calendarEventsUserApplicantIdGet({
    @Path('applicant_id') required String? applicantId,
  });

  ///Get Event By Id
  ///@param event_id
  Future<chopper.Response<EventComplete>> calendarEventsEventIdGet({
    required String? eventId,
  }) {
    generatedMapping.putIfAbsent(
      EventComplete,
      () => EventComplete.fromJsonFactory,
    );

    return _calendarEventsEventIdGet(eventId: eventId);
  }

  ///Get Event By Id
  ///@param event_id
  @Get(path: '/calendar/events/{event_id}')
  Future<chopper.Response<EventComplete>> _calendarEventsEventIdGet({
    @Path('event_id') required String? eventId,
  });

  ///Edit Bookings Id
  ///@param event_id
  Future<chopper.Response> calendarEventsEventIdPatch({
    required String? eventId,
    required EventEdit? body,
  }) {
    return _calendarEventsEventIdPatch(eventId: eventId, body: body);
  }

  ///Edit Bookings Id
  ///@param event_id
  @Patch(path: '/calendar/events/{event_id}', optionalBody: true)
  Future<chopper.Response> _calendarEventsEventIdPatch({
    @Path('event_id') required String? eventId,
    @Body() required EventEdit? body,
  });

  ///Delete Bookings Id
  ///@param event_id
  Future<chopper.Response> calendarEventsEventIdDelete({
    required Object? eventId,
  }) {
    return _calendarEventsEventIdDelete(eventId: eventId);
  }

  ///Delete Bookings Id
  ///@param event_id
  @Delete(path: '/calendar/events/{event_id}')
  Future<chopper.Response> _calendarEventsEventIdDelete({
    @Path('event_id') required Object? eventId,
  });

  ///Get Event Applicant
  ///@param event_id
  Future<chopper.Response<EventApplicant>> calendarEventsEventIdApplicantGet({
    required String? eventId,
  }) {
    generatedMapping.putIfAbsent(
      EventApplicant,
      () => EventApplicant.fromJsonFactory,
    );

    return _calendarEventsEventIdApplicantGet(eventId: eventId);
  }

  ///Get Event Applicant
  ///@param event_id
  @Get(path: '/calendar/events/{event_id}/applicant')
  Future<chopper.Response<EventApplicant>> _calendarEventsEventIdApplicantGet({
    @Path('event_id') required String? eventId,
  });

  ///Confirm Booking
  ///@param event_id
  ///@param decision
  Future<chopper.Response> calendarEventsEventIdReplyDecisionPatch({
    required String? eventId,
    required enums.Decision? decision,
  }) {
    return _calendarEventsEventIdReplyDecisionPatch(
      eventId: eventId,
      decision: decision?.value?.toString(),
    );
  }

  ///Confirm Booking
  ///@param event_id
  ///@param decision
  @Patch(
    path: '/calendar/events/{event_id}/reply/{decision}',
    optionalBody: true,
  )
  Future<chopper.Response> _calendarEventsEventIdReplyDecisionPatch({
    @Path('event_id') required String? eventId,
    @Path('decision') required String? decision,
  });

  ///Recreate Ical File
  Future<chopper.Response> calendarIcalCreatePost() {
    return _calendarIcalCreatePost();
  }

  ///Recreate Ical File
  @Post(path: '/calendar/ical/create', optionalBody: true)
  Future<chopper.Response> _calendarIcalCreatePost();

  ///Get Icalendar File
  Future<chopper.Response> calendarIcalGet() {
    return _calendarIcalGet();
  }

  ///Get Icalendar File
  @Get(path: '/calendar/ical')
  Future<chopper.Response> _calendarIcalGet();

  ///Get All Associations
  Future<chopper.Response<List<AssociationComplete>>>
  phonebookAssociationsGet() {
    generatedMapping.putIfAbsent(
      AssociationComplete,
      () => AssociationComplete.fromJsonFactory,
    );

    return _phonebookAssociationsGet();
  }

  ///Get All Associations
  @Get(path: '/phonebook/associations/')
  Future<chopper.Response<List<AssociationComplete>>>
  _phonebookAssociationsGet();

  ///Create Association
  Future<chopper.Response<AssociationComplete>> phonebookAssociationsPost({
    required AssociationBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AssociationComplete,
      () => AssociationComplete.fromJsonFactory,
    );

    return _phonebookAssociationsPost(body: body);
  }

  ///Create Association
  @Post(path: '/phonebook/associations/', optionalBody: true)
  Future<chopper.Response<AssociationComplete>> _phonebookAssociationsPost({
    @Body() required AssociationBase? body,
  });

  ///Get All Role Tags
  Future<chopper.Response<RoleTagsReturn>> phonebookRoletagsGet() {
    generatedMapping.putIfAbsent(
      RoleTagsReturn,
      () => RoleTagsReturn.fromJsonFactory,
    );

    return _phonebookRoletagsGet();
  }

  ///Get All Role Tags
  @Get(path: '/phonebook/roletags')
  Future<chopper.Response<RoleTagsReturn>> _phonebookRoletagsGet();

  ///Get All Kinds
  Future<chopper.Response<KindsReturn>> phonebookAssociationsKindsGet() {
    generatedMapping.putIfAbsent(
      KindsReturn,
      () => KindsReturn.fromJsonFactory,
    );

    return _phonebookAssociationsKindsGet();
  }

  ///Get All Kinds
  @Get(path: '/phonebook/associations/kinds')
  Future<chopper.Response<KindsReturn>> _phonebookAssociationsKindsGet();

  ///Update Association
  ///@param association_id
  Future<chopper.Response> phonebookAssociationsAssociationIdPatch({
    required String? associationId,
    required AssociationEdit? body,
  }) {
    return _phonebookAssociationsAssociationIdPatch(
      associationId: associationId,
      body: body,
    );
  }

  ///Update Association
  ///@param association_id
  @Patch(path: '/phonebook/associations/{association_id}', optionalBody: true)
  Future<chopper.Response> _phonebookAssociationsAssociationIdPatch({
    @Path('association_id') required String? associationId,
    @Body() required AssociationEdit? body,
  });

  ///Delete Association
  ///@param association_id
  Future<chopper.Response> phonebookAssociationsAssociationIdDelete({
    required String? associationId,
  }) {
    return _phonebookAssociationsAssociationIdDelete(
      associationId: associationId,
    );
  }

  ///Delete Association
  ///@param association_id
  @Delete(path: '/phonebook/associations/{association_id}')
  Future<chopper.Response> _phonebookAssociationsAssociationIdDelete({
    @Path('association_id') required String? associationId,
  });

  ///Update Association Groups
  ///@param association_id
  Future<chopper.Response> phonebookAssociationsAssociationIdGroupsPatch({
    required String? associationId,
    required AssociationGroupsEdit? body,
  }) {
    return _phonebookAssociationsAssociationIdGroupsPatch(
      associationId: associationId,
      body: body,
    );
  }

  ///Update Association Groups
  ///@param association_id
  @Patch(
    path: '/phonebook/associations/{association_id}/groups',
    optionalBody: true,
  )
  Future<chopper.Response> _phonebookAssociationsAssociationIdGroupsPatch({
    @Path('association_id') required String? associationId,
    @Body() required AssociationGroupsEdit? body,
  });

  ///Deactivate Association
  ///@param association_id
  Future<chopper.Response> phonebookAssociationsAssociationIdDeactivatePatch({
    required String? associationId,
  }) {
    return _phonebookAssociationsAssociationIdDeactivatePatch(
      associationId: associationId,
    );
  }

  ///Deactivate Association
  ///@param association_id
  @Patch(
    path: '/phonebook/associations/{association_id}/deactivate',
    optionalBody: true,
  )
  Future<chopper.Response> _phonebookAssociationsAssociationIdDeactivatePatch({
    @Path('association_id') required String? associationId,
  });

  ///Get Association Members
  ///@param association_id
  Future<chopper.Response<List<MemberComplete>>>
  phonebookAssociationsAssociationIdMembersGet({
    required String? associationId,
  }) {
    generatedMapping.putIfAbsent(
      MemberComplete,
      () => MemberComplete.fromJsonFactory,
    );

    return _phonebookAssociationsAssociationIdMembersGet(
      associationId: associationId,
    );
  }

  ///Get Association Members
  ///@param association_id
  @Get(path: '/phonebook/associations/{association_id}/members/')
  Future<chopper.Response<List<MemberComplete>>>
  _phonebookAssociationsAssociationIdMembersGet({
    @Path('association_id') required String? associationId,
  });

  ///Get Association Members By Mandate Year
  ///@param association_id
  ///@param mandate_year
  Future<chopper.Response<List<MemberComplete>>>
  phonebookAssociationsAssociationIdMembersMandateYearGet({
    required String? associationId,
    required int? mandateYear,
  }) {
    generatedMapping.putIfAbsent(
      MemberComplete,
      () => MemberComplete.fromJsonFactory,
    );

    return _phonebookAssociationsAssociationIdMembersMandateYearGet(
      associationId: associationId,
      mandateYear: mandateYear,
    );
  }

  ///Get Association Members By Mandate Year
  ///@param association_id
  ///@param mandate_year
  @Get(path: '/phonebook/associations/{association_id}/members/{mandate_year}')
  Future<chopper.Response<List<MemberComplete>>>
  _phonebookAssociationsAssociationIdMembersMandateYearGet({
    @Path('association_id') required String? associationId,
    @Path('mandate_year') required int? mandateYear,
  });

  ///Get Member Details
  ///@param user_id
  Future<chopper.Response<MemberComplete>> phonebookMemberUserIdGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      MemberComplete,
      () => MemberComplete.fromJsonFactory,
    );

    return _phonebookMemberUserIdGet(userId: userId);
  }

  ///Get Member Details
  ///@param user_id
  @Get(path: '/phonebook/member/{user_id}')
  Future<chopper.Response<MemberComplete>> _phonebookMemberUserIdGet({
    @Path('user_id') required String? userId,
  });

  ///Create Membership
  Future<chopper.Response<MembershipComplete>>
  phonebookAssociationsMembershipsPost({
    required AppModulesPhonebookSchemasPhonebookMembershipBase? body,
  }) {
    generatedMapping.putIfAbsent(
      MembershipComplete,
      () => MembershipComplete.fromJsonFactory,
    );

    return _phonebookAssociationsMembershipsPost(body: body);
  }

  ///Create Membership
  @Post(path: '/phonebook/associations/memberships', optionalBody: true)
  Future<chopper.Response<MembershipComplete>>
  _phonebookAssociationsMembershipsPost({
    @Body() required AppModulesPhonebookSchemasPhonebookMembershipBase? body,
  });

  ///Update Membership
  ///@param membership_id
  Future<chopper.Response> phonebookAssociationsMembershipsMembershipIdPatch({
    required String? membershipId,
    required MembershipEdit? body,
  }) {
    return _phonebookAssociationsMembershipsMembershipIdPatch(
      membershipId: membershipId,
      body: body,
    );
  }

  ///Update Membership
  ///@param membership_id
  @Patch(
    path: '/phonebook/associations/memberships/{membership_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _phonebookAssociationsMembershipsMembershipIdPatch({
    @Path('membership_id') required String? membershipId,
    @Body() required MembershipEdit? body,
  });

  ///Delete Membership
  ///@param membership_id
  Future<chopper.Response> phonebookAssociationsMembershipsMembershipIdDelete({
    required String? membershipId,
  }) {
    return _phonebookAssociationsMembershipsMembershipIdDelete(
      membershipId: membershipId,
    );
  }

  ///Delete Membership
  ///@param membership_id
  @Delete(path: '/phonebook/associations/memberships/{membership_id}')
  Future<chopper.Response> _phonebookAssociationsMembershipsMembershipIdDelete({
    @Path('membership_id') required String? membershipId,
  });

  ///Create Association Logo
  ///@param association_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  phonebookAssociationsAssociationIdPicturePost({
    required String? associationId,
    required MultipartFile image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _phonebookAssociationsAssociationIdPicturePost(
      associationId: associationId,
      image: image,
    );
  }

  ///Create Association Logo
  ///@param association_id
  @Post(
    path: '/phonebook/associations/{association_id}/picture',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _phonebookAssociationsAssociationIdPicturePost({
    @Path('association_id') required String? associationId,
    @PartFile('image') required MultipartFile image,
  });

  ///Read Association Logo
  ///@param association_id
  Future<chopper.Response> phonebookAssociationsAssociationIdPictureGet({
    required String? associationId,
  }) {
    return _phonebookAssociationsAssociationIdPictureGet(
      associationId: associationId,
    );
  }

  ///Read Association Logo
  ///@param association_id
  @Get(path: '/phonebook/associations/{association_id}/picture')
  Future<chopper.Response> _phonebookAssociationsAssociationIdPictureGet({
    @Path('association_id') required String? associationId,
  });

  ///Get Products
  Future<chopper.Response<List<AppModulesAmapSchemasAmapProductComplete>>>
  amapProductsGet() {
    generatedMapping.putIfAbsent(
      AppModulesAmapSchemasAmapProductComplete,
      () => AppModulesAmapSchemasAmapProductComplete.fromJsonFactory,
    );

    return _amapProductsGet();
  }

  ///Get Products
  @Get(path: '/amap/products')
  Future<chopper.Response<List<AppModulesAmapSchemasAmapProductComplete>>>
  _amapProductsGet();

  ///Create Product
  Future<chopper.Response<AppModulesAmapSchemasAmapProductComplete>>
  amapProductsPost({required ProductSimple? body}) {
    generatedMapping.putIfAbsent(
      AppModulesAmapSchemasAmapProductComplete,
      () => AppModulesAmapSchemasAmapProductComplete.fromJsonFactory,
    );

    return _amapProductsPost(body: body);
  }

  ///Create Product
  @Post(path: '/amap/products', optionalBody: true)
  Future<chopper.Response<AppModulesAmapSchemasAmapProductComplete>>
  _amapProductsPost({@Body() required ProductSimple? body});

  ///Get Product By Id
  ///@param product_id
  Future<chopper.Response<AppModulesAmapSchemasAmapProductComplete>>
  amapProductsProductIdGet({required String? productId}) {
    generatedMapping.putIfAbsent(
      AppModulesAmapSchemasAmapProductComplete,
      () => AppModulesAmapSchemasAmapProductComplete.fromJsonFactory,
    );

    return _amapProductsProductIdGet(productId: productId);
  }

  ///Get Product By Id
  ///@param product_id
  @Get(path: '/amap/products/{product_id}')
  Future<chopper.Response<AppModulesAmapSchemasAmapProductComplete>>
  _amapProductsProductIdGet({@Path('product_id') required String? productId});

  ///Edit Product
  ///@param product_id
  Future<chopper.Response> amapProductsProductIdPatch({
    required String? productId,
    required AppModulesAmapSchemasAmapProductEdit? body,
  }) {
    return _amapProductsProductIdPatch(productId: productId, body: body);
  }

  ///Edit Product
  ///@param product_id
  @Patch(path: '/amap/products/{product_id}', optionalBody: true)
  Future<chopper.Response> _amapProductsProductIdPatch({
    @Path('product_id') required String? productId,
    @Body() required AppModulesAmapSchemasAmapProductEdit? body,
  });

  ///Delete Product
  ///@param product_id
  Future<chopper.Response> amapProductsProductIdDelete({
    required String? productId,
  }) {
    return _amapProductsProductIdDelete(productId: productId);
  }

  ///Delete Product
  ///@param product_id
  @Delete(path: '/amap/products/{product_id}')
  Future<chopper.Response> _amapProductsProductIdDelete({
    @Path('product_id') required String? productId,
  });

  ///Get Deliveries
  Future<chopper.Response<List<DeliveryReturn>>> amapDeliveriesGet() {
    generatedMapping.putIfAbsent(
      DeliveryReturn,
      () => DeliveryReturn.fromJsonFactory,
    );

    return _amapDeliveriesGet();
  }

  ///Get Deliveries
  @Get(path: '/amap/deliveries')
  Future<chopper.Response<List<DeliveryReturn>>> _amapDeliveriesGet();

  ///Create Delivery
  Future<chopper.Response<DeliveryReturn>> amapDeliveriesPost({
    required DeliveryBase? body,
  }) {
    generatedMapping.putIfAbsent(
      DeliveryReturn,
      () => DeliveryReturn.fromJsonFactory,
    );

    return _amapDeliveriesPost(body: body);
  }

  ///Create Delivery
  @Post(path: '/amap/deliveries', optionalBody: true)
  Future<chopper.Response<DeliveryReturn>> _amapDeliveriesPost({
    @Body() required DeliveryBase? body,
  });

  ///Delete Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdDelete({
    required String? deliveryId,
  }) {
    return _amapDeliveriesDeliveryIdDelete(deliveryId: deliveryId);
  }

  ///Delete Delivery
  ///@param delivery_id
  @Delete(path: '/amap/deliveries/{delivery_id}')
  Future<chopper.Response> _amapDeliveriesDeliveryIdDelete({
    @Path('delivery_id') required String? deliveryId,
  });

  ///Edit Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdPatch({
    required String? deliveryId,
    required DeliveryUpdate? body,
  }) {
    return _amapDeliveriesDeliveryIdPatch(deliveryId: deliveryId, body: body);
  }

  ///Edit Delivery
  ///@param delivery_id
  @Patch(path: '/amap/deliveries/{delivery_id}', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdPatch({
    @Path('delivery_id') required String? deliveryId,
    @Body() required DeliveryUpdate? body,
  });

  ///Add Product To Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdProductsPost({
    required String? deliveryId,
    required DeliveryProductsUpdate? body,
  }) {
    return _amapDeliveriesDeliveryIdProductsPost(
      deliveryId: deliveryId,
      body: body,
    );
  }

  ///Add Product To Delivery
  ///@param delivery_id
  @Post(path: '/amap/deliveries/{delivery_id}/products', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdProductsPost({
    @Path('delivery_id') required String? deliveryId,
    @Body() required DeliveryProductsUpdate? body,
  });

  ///Remove Product From Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdProductsDelete({
    required String? deliveryId,
    required DeliveryProductsUpdate? body,
  }) {
    return _amapDeliveriesDeliveryIdProductsDelete(
      deliveryId: deliveryId,
      body: body,
    );
  }

  ///Remove Product From Delivery
  ///@param delivery_id
  @Delete(path: '/amap/deliveries/{delivery_id}/products')
  Future<chopper.Response> _amapDeliveriesDeliveryIdProductsDelete({
    @Path('delivery_id') required String? deliveryId,
    @Body() required DeliveryProductsUpdate? body,
  });

  ///Get Orders From Delivery
  ///@param delivery_id
  Future<chopper.Response<List<OrderReturn>>>
  amapDeliveriesDeliveryIdOrdersGet({required String? deliveryId}) {
    generatedMapping.putIfAbsent(
      OrderReturn,
      () => OrderReturn.fromJsonFactory,
    );

    return _amapDeliveriesDeliveryIdOrdersGet(deliveryId: deliveryId);
  }

  ///Get Orders From Delivery
  ///@param delivery_id
  @Get(path: '/amap/deliveries/{delivery_id}/orders')
  Future<chopper.Response<List<OrderReturn>>>
  _amapDeliveriesDeliveryIdOrdersGet({
    @Path('delivery_id') required String? deliveryId,
  });

  ///Get Order By Id
  ///@param order_id
  Future<chopper.Response<OrderReturn>> amapOrdersOrderIdGet({
    required String? orderId,
  }) {
    generatedMapping.putIfAbsent(
      OrderReturn,
      () => OrderReturn.fromJsonFactory,
    );

    return _amapOrdersOrderIdGet(orderId: orderId);
  }

  ///Get Order By Id
  ///@param order_id
  @Get(path: '/amap/orders/{order_id}')
  Future<chopper.Response<OrderReturn>> _amapOrdersOrderIdGet({
    @Path('order_id') required String? orderId,
  });

  ///Edit Order From Delivery
  ///@param order_id
  Future<chopper.Response> amapOrdersOrderIdPatch({
    required String? orderId,
    required OrderEdit? body,
  }) {
    return _amapOrdersOrderIdPatch(orderId: orderId, body: body);
  }

  ///Edit Order From Delivery
  ///@param order_id
  @Patch(path: '/amap/orders/{order_id}', optionalBody: true)
  Future<chopper.Response> _amapOrdersOrderIdPatch({
    @Path('order_id') required String? orderId,
    @Body() required OrderEdit? body,
  });

  ///Remove Order
  ///@param order_id
  Future<chopper.Response> amapOrdersOrderIdDelete({required String? orderId}) {
    return _amapOrdersOrderIdDelete(orderId: orderId);
  }

  ///Remove Order
  ///@param order_id
  @Delete(path: '/amap/orders/{order_id}')
  Future<chopper.Response> _amapOrdersOrderIdDelete({
    @Path('order_id') required String? orderId,
  });

  ///Add Order To Delievery
  Future<chopper.Response<OrderReturn>> amapOrdersPost({
    required OrderBase? body,
  }) {
    generatedMapping.putIfAbsent(
      OrderReturn,
      () => OrderReturn.fromJsonFactory,
    );

    return _amapOrdersPost(body: body);
  }

  ///Add Order To Delievery
  @Post(path: '/amap/orders', optionalBody: true)
  Future<chopper.Response<OrderReturn>> _amapOrdersPost({
    @Body() required OrderBase? body,
  });

  ///Open Ordering Of Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdOpenorderingPost({
    required String? deliveryId,
  }) {
    return _amapDeliveriesDeliveryIdOpenorderingPost(deliveryId: deliveryId);
  }

  ///Open Ordering Of Delivery
  ///@param delivery_id
  @Post(path: '/amap/deliveries/{delivery_id}/openordering', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdOpenorderingPost({
    @Path('delivery_id') required String? deliveryId,
  });

  ///Lock Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdLockPost({
    required String? deliveryId,
  }) {
    return _amapDeliveriesDeliveryIdLockPost(deliveryId: deliveryId);
  }

  ///Lock Delivery
  ///@param delivery_id
  @Post(path: '/amap/deliveries/{delivery_id}/lock', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdLockPost({
    @Path('delivery_id') required String? deliveryId,
  });

  ///Mark Delivery As Delivered
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdDeliveredPost({
    required String? deliveryId,
  }) {
    return _amapDeliveriesDeliveryIdDeliveredPost(deliveryId: deliveryId);
  }

  ///Mark Delivery As Delivered
  ///@param delivery_id
  @Post(path: '/amap/deliveries/{delivery_id}/delivered', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdDeliveredPost({
    @Path('delivery_id') required String? deliveryId,
  });

  ///Archive Of Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdArchivePost({
    required String? deliveryId,
  }) {
    return _amapDeliveriesDeliveryIdArchivePost(deliveryId: deliveryId);
  }

  ///Archive Of Delivery
  ///@param delivery_id
  @Post(path: '/amap/deliveries/{delivery_id}/archive', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdArchivePost({
    @Path('delivery_id') required String? deliveryId,
  });

  ///Get Users Cash
  Future<chopper.Response<List<CashComplete>>> amapUsersCashGet() {
    generatedMapping.putIfAbsent(
      CashComplete,
      () => CashComplete.fromJsonFactory,
    );

    return _amapUsersCashGet();
  }

  ///Get Users Cash
  @Get(path: '/amap/users/cash')
  Future<chopper.Response<List<CashComplete>>> _amapUsersCashGet();

  ///Get Cash By Id
  ///@param user_id
  Future<chopper.Response<CashComplete>> amapUsersUserIdCashGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      CashComplete,
      () => CashComplete.fromJsonFactory,
    );

    return _amapUsersUserIdCashGet(userId: userId);
  }

  ///Get Cash By Id
  ///@param user_id
  @Get(path: '/amap/users/{user_id}/cash')
  Future<chopper.Response<CashComplete>> _amapUsersUserIdCashGet({
    @Path('user_id') required String? userId,
  });

  ///Create Cash Of User
  ///@param user_id
  Future<chopper.Response<CashComplete>> amapUsersUserIdCashPost({
    required String? userId,
    required CashEdit? body,
  }) {
    generatedMapping.putIfAbsent(
      CashComplete,
      () => CashComplete.fromJsonFactory,
    );

    return _amapUsersUserIdCashPost(userId: userId, body: body);
  }

  ///Create Cash Of User
  ///@param user_id
  @Post(path: '/amap/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response<CashComplete>> _amapUsersUserIdCashPost({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
  });

  ///Edit Cash By Id
  ///@param user_id
  Future<chopper.Response> amapUsersUserIdCashPatch({
    required String? userId,
    required CashEdit? body,
  }) {
    return _amapUsersUserIdCashPatch(userId: userId, body: body);
  }

  ///Edit Cash By Id
  ///@param user_id
  @Patch(path: '/amap/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response> _amapUsersUserIdCashPatch({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
  });

  ///Get Orders Of User
  ///@param user_id
  Future<chopper.Response<List<OrderReturn>>> amapUsersUserIdOrdersGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      OrderReturn,
      () => OrderReturn.fromJsonFactory,
    );

    return _amapUsersUserIdOrdersGet(userId: userId);
  }

  ///Get Orders Of User
  ///@param user_id
  @Get(path: '/amap/users/{user_id}/orders')
  Future<chopper.Response<List<OrderReturn>>> _amapUsersUserIdOrdersGet({
    @Path('user_id') required String? userId,
  });

  ///Get Information
  Future<chopper.Response<Information>> amapInformationGet() {
    generatedMapping.putIfAbsent(
      Information,
      () => Information.fromJsonFactory,
    );

    return _amapInformationGet();
  }

  ///Get Information
  @Get(path: '/amap/information')
  Future<chopper.Response<Information>> _amapInformationGet();

  ///Edit Information
  Future<chopper.Response> amapInformationPatch({
    required InformationEdit? body,
  }) {
    return _amapInformationPatch(body: body);
  }

  ///Edit Information
  @Patch(path: '/amap/information', optionalBody: true)
  Future<chopper.Response> _amapInformationPatch({
    @Body() required InformationEdit? body,
  });

  ///Get Participant By Id
  ///@param participant_id
  Future<chopper.Response<Participant>> raidParticipantsParticipantIdGet({
    required String? participantId,
  }) {
    generatedMapping.putIfAbsent(
      Participant,
      () => Participant.fromJsonFactory,
    );

    return _raidParticipantsParticipantIdGet(participantId: participantId);
  }

  ///Get Participant By Id
  ///@param participant_id
  @Get(path: '/raid/participants/{participant_id}')
  Future<chopper.Response<Participant>> _raidParticipantsParticipantIdGet({
    @Path('participant_id') required String? participantId,
  });

  ///Update Participant
  ///@param participant_id
  Future<chopper.Response> raidParticipantsParticipantIdPatch({
    required String? participantId,
    required ParticipantUpdate? body,
  }) {
    return _raidParticipantsParticipantIdPatch(
      participantId: participantId,
      body: body,
    );
  }

  ///Update Participant
  ///@param participant_id
  @Patch(path: '/raid/participants/{participant_id}', optionalBody: true)
  Future<chopper.Response> _raidParticipantsParticipantIdPatch({
    @Path('participant_id') required String? participantId,
    @Body() required ParticipantUpdate? body,
  });

  ///Create Participant
  Future<chopper.Response<Participant>> raidParticipantsPost({
    required ParticipantBase? body,
  }) {
    generatedMapping.putIfAbsent(
      Participant,
      () => Participant.fromJsonFactory,
    );

    return _raidParticipantsPost(body: body);
  }

  ///Create Participant
  @Post(path: '/raid/participants', optionalBody: true)
  Future<chopper.Response<Participant>> _raidParticipantsPost({
    @Body() required ParticipantBase? body,
  });

  ///Get All Teams
  Future<chopper.Response<List<TeamPreview>>> raidTeamsGet() {
    generatedMapping.putIfAbsent(
      TeamPreview,
      () => TeamPreview.fromJsonFactory,
    );

    return _raidTeamsGet();
  }

  ///Get All Teams
  @Get(path: '/raid/teams')
  Future<chopper.Response<List<TeamPreview>>> _raidTeamsGet();

  ///Create Team
  Future<chopper.Response<Team>> raidTeamsPost({required TeamBase? body}) {
    generatedMapping.putIfAbsent(Team, () => Team.fromJsonFactory);

    return _raidTeamsPost(body: body);
  }

  ///Create Team
  @Post(path: '/raid/teams', optionalBody: true)
  Future<chopper.Response<Team>> _raidTeamsPost({
    @Body() required TeamBase? body,
  });

  ///Delete All Teams
  Future<chopper.Response> raidTeamsDelete() {
    return _raidTeamsDelete();
  }

  ///Delete All Teams
  @Delete(path: '/raid/teams')
  Future<chopper.Response> _raidTeamsDelete();

  ///Generate Teams Pdf
  Future<chopper.Response> raidTeamsGeneratePdfPost() {
    return _raidTeamsGeneratePdfPost();
  }

  ///Generate Teams Pdf
  @Post(path: '/raid/teams/generate-pdf', optionalBody: true)
  Future<chopper.Response> _raidTeamsGeneratePdfPost();

  ///Get Team By Participant Id
  ///@param participant_id
  Future<chopper.Response<Team>> raidParticipantsParticipantIdTeamGet({
    required String? participantId,
  }) {
    generatedMapping.putIfAbsent(Team, () => Team.fromJsonFactory);

    return _raidParticipantsParticipantIdTeamGet(participantId: participantId);
  }

  ///Get Team By Participant Id
  ///@param participant_id
  @Get(path: '/raid/participants/{participant_id}/team')
  Future<chopper.Response<Team>> _raidParticipantsParticipantIdTeamGet({
    @Path('participant_id') required String? participantId,
  });

  ///Get Team By Id
  ///@param team_id
  Future<chopper.Response<Team>> raidTeamsTeamIdGet({required String? teamId}) {
    generatedMapping.putIfAbsent(Team, () => Team.fromJsonFactory);

    return _raidTeamsTeamIdGet(teamId: teamId);
  }

  ///Get Team By Id
  ///@param team_id
  @Get(path: '/raid/teams/{team_id}')
  Future<chopper.Response<Team>> _raidTeamsTeamIdGet({
    @Path('team_id') required String? teamId,
  });

  ///Update Team
  ///@param team_id
  Future<chopper.Response> raidTeamsTeamIdPatch({
    required String? teamId,
    required TeamUpdate? body,
  }) {
    return _raidTeamsTeamIdPatch(teamId: teamId, body: body);
  }

  ///Update Team
  ///@param team_id
  @Patch(path: '/raid/teams/{team_id}', optionalBody: true)
  Future<chopper.Response> _raidTeamsTeamIdPatch({
    @Path('team_id') required String? teamId,
    @Body() required TeamUpdate? body,
  });

  ///Delete Team
  ///@param team_id
  Future<chopper.Response> raidTeamsTeamIdDelete({required String? teamId}) {
    return _raidTeamsTeamIdDelete(teamId: teamId);
  }

  ///Delete Team
  ///@param team_id
  @Delete(path: '/raid/teams/{team_id}')
  Future<chopper.Response> _raidTeamsTeamIdDelete({
    @Path('team_id') required String? teamId,
  });

  ///Upload Document
  ///@param document_type
  Future<chopper.Response<DocumentCreation>> raidDocumentDocumentTypePost({
    required enums.DocumentType? documentType,
    required MultipartFile file,
  }) {
    generatedMapping.putIfAbsent(
      DocumentCreation,
      () => DocumentCreation.fromJsonFactory,
    );

    return _raidDocumentDocumentTypePost(
      documentType: documentType?.value?.toString(),
      file: file,
    );
  }

  ///Upload Document
  ///@param document_type
  @Post(path: '/raid/document/{document_type}', optionalBody: true)
  @Multipart()
  Future<chopper.Response<DocumentCreation>> _raidDocumentDocumentTypePost({
    @Path('document_type') required String? documentType,
    @PartFile('file') required MultipartFile file,
  });

  ///Read Document
  ///@param document_id
  Future<chopper.Response> raidDocumentDocumentIdGet({
    required String? documentId,
  }) {
    return _raidDocumentDocumentIdGet(documentId: documentId);
  }

  ///Read Document
  ///@param document_id
  @Get(path: '/raid/document/{document_id}')
  Future<chopper.Response> _raidDocumentDocumentIdGet({
    @Path('document_id') required String? documentId,
  });

  ///Validate Document
  ///@param document_id
  ///@param validation
  Future<chopper.Response> raidDocumentDocumentIdValidatePost({
    required String? documentId,
    required enums.DocumentValidation? validation,
  }) {
    return _raidDocumentDocumentIdValidatePost(
      documentId: documentId,
      validation: validation?.value?.toString(),
    );
  }

  ///Validate Document
  ///@param document_id
  ///@param validation
  @Post(path: '/raid/document/{document_id}/validate', optionalBody: true)
  Future<chopper.Response> _raidDocumentDocumentIdValidatePost({
    @Path('document_id') required String? documentId,
    @Query('validation') required String? validation,
  });

  ///Set Security File
  ///@param participant_id
  Future<chopper.Response<SecurityFile>> raidSecurityFilePost({
    required String? participantId,
    required SecurityFileBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SecurityFile,
      () => SecurityFile.fromJsonFactory,
    );

    return _raidSecurityFilePost(participantId: participantId, body: body);
  }

  ///Set Security File
  ///@param participant_id
  @Post(path: '/raid/security_file/', optionalBody: true)
  Future<chopper.Response<SecurityFile>> _raidSecurityFilePost({
    @Query('participant_id') required String? participantId,
    @Body() required SecurityFileBase? body,
  });

  ///Confirm Payment
  ///@param participant_id
  Future<chopper.Response> raidParticipantParticipantIdPaymentPost({
    required String? participantId,
  }) {
    return _raidParticipantParticipantIdPaymentPost(
      participantId: participantId,
    );
  }

  ///Confirm Payment
  ///@param participant_id
  @Post(path: '/raid/participant/{participant_id}/payment', optionalBody: true)
  Future<chopper.Response> _raidParticipantParticipantIdPaymentPost({
    @Path('participant_id') required String? participantId,
  });

  ///Confirm T Shirt Payment
  ///@param participant_id
  Future<chopper.Response> raidParticipantParticipantIdTShirtPaymentPost({
    required String? participantId,
  }) {
    return _raidParticipantParticipantIdTShirtPaymentPost(
      participantId: participantId,
    );
  }

  ///Confirm T Shirt Payment
  ///@param participant_id
  @Post(
    path: '/raid/participant/{participant_id}/t_shirt_payment',
    optionalBody: true,
  )
  Future<chopper.Response> _raidParticipantParticipantIdTShirtPaymentPost({
    @Path('participant_id') required String? participantId,
  });

  ///Validate Attestation On Honour
  ///@param participant_id
  Future<chopper.Response> raidParticipantParticipantIdHonourPost({
    required String? participantId,
  }) {
    return _raidParticipantParticipantIdHonourPost(
      participantId: participantId,
    );
  }

  ///Validate Attestation On Honour
  ///@param participant_id
  @Post(path: '/raid/participant/{participant_id}/honour', optionalBody: true)
  Future<chopper.Response> _raidParticipantParticipantIdHonourPost({
    @Path('participant_id') required String? participantId,
  });

  ///Create Invite Token
  ///@param team_id
  Future<chopper.Response<InviteToken>> raidTeamsTeamIdInvitePost({
    required String? teamId,
  }) {
    generatedMapping.putIfAbsent(
      InviteToken,
      () => InviteToken.fromJsonFactory,
    );

    return _raidTeamsTeamIdInvitePost(teamId: teamId);
  }

  ///Create Invite Token
  ///@param team_id
  @Post(path: '/raid/teams/{team_id}/invite', optionalBody: true)
  Future<chopper.Response<InviteToken>> _raidTeamsTeamIdInvitePost({
    @Path('team_id') required String? teamId,
  });

  ///Join Team
  ///@param token
  Future<chopper.Response> raidTeamsJoinTokenPost({required String? token}) {
    return _raidTeamsJoinTokenPost(token: token);
  }

  ///Join Team
  ///@param token
  @Post(path: '/raid/teams/join/{token}', optionalBody: true)
  Future<chopper.Response> _raidTeamsJoinTokenPost({
    @Path('token') required String? token,
  });

  ///Kick Team Member
  ///@param team_id
  ///@param participant_id
  Future<chopper.Response<Team>> raidTeamsTeamIdKickParticipantIdPost({
    required String? teamId,
    required String? participantId,
  }) {
    generatedMapping.putIfAbsent(Team, () => Team.fromJsonFactory);

    return _raidTeamsTeamIdKickParticipantIdPost(
      teamId: teamId,
      participantId: participantId,
    );
  }

  ///Kick Team Member
  ///@param team_id
  ///@param participant_id
  @Post(path: '/raid/teams/{team_id}/kick/{participant_id}', optionalBody: true)
  Future<chopper.Response<Team>> _raidTeamsTeamIdKickParticipantIdPost({
    @Path('team_id') required String? teamId,
    @Path('participant_id') required String? participantId,
  });

  ///Merge Teams
  ///@param team1_id
  ///@param team2_id
  Future<chopper.Response<Team>> raidTeamsMergePost({
    required String? team1Id,
    required String? team2Id,
  }) {
    generatedMapping.putIfAbsent(Team, () => Team.fromJsonFactory);

    return _raidTeamsMergePost(team1Id: team1Id, team2Id: team2Id);
  }

  ///Merge Teams
  ///@param team1_id
  ///@param team2_id
  @Post(path: '/raid/teams/merge', optionalBody: true)
  Future<chopper.Response<Team>> _raidTeamsMergePost({
    @Query('team1_id') required String? team1Id,
    @Query('team2_id') required String? team2Id,
  });

  ///Get Raid Information
  Future<chopper.Response<RaidInformation>> raidInformationGet() {
    generatedMapping.putIfAbsent(
      RaidInformation,
      () => RaidInformation.fromJsonFactory,
    );

    return _raidInformationGet();
  }

  ///Get Raid Information
  @Get(path: '/raid/information')
  Future<chopper.Response<RaidInformation>> _raidInformationGet();

  ///Update Raid Information
  Future<chopper.Response> raidInformationPatch({
    required RaidInformation? body,
  }) {
    return _raidInformationPatch(body: body);
  }

  ///Update Raid Information
  @Patch(path: '/raid/information', optionalBody: true)
  Future<chopper.Response> _raidInformationPatch({
    @Body() required RaidInformation? body,
  });

  ///Get Drive Folders
  Future<chopper.Response<RaidDriveFoldersCreation>> raidDriveGet() {
    generatedMapping.putIfAbsent(
      RaidDriveFoldersCreation,
      () => RaidDriveFoldersCreation.fromJsonFactory,
    );

    return _raidDriveGet();
  }

  ///Get Drive Folders
  @Get(path: '/raid/drive')
  Future<chopper.Response<RaidDriveFoldersCreation>> _raidDriveGet();

  ///Update Drive Folders
  Future<chopper.Response> raidDrivePatch({
    required RaidDriveFoldersCreation? body,
  }) {
    return _raidDrivePatch(body: body);
  }

  ///Update Drive Folders
  @Patch(path: '/raid/drive', optionalBody: true)
  Future<chopper.Response> _raidDrivePatch({
    @Body() required RaidDriveFoldersCreation? body,
  });

  ///Get Raid Price
  Future<chopper.Response<RaidPrice>> raidPriceGet() {
    generatedMapping.putIfAbsent(RaidPrice, () => RaidPrice.fromJsonFactory);

    return _raidPriceGet();
  }

  ///Get Raid Price
  @Get(path: '/raid/price')
  Future<chopper.Response<RaidPrice>> _raidPriceGet();

  ///Update Raid Price
  Future<chopper.Response> raidPricePatch({required RaidPrice? body}) {
    return _raidPricePatch(body: body);
  }

  ///Update Raid Price
  @Patch(path: '/raid/price', optionalBody: true)
  Future<chopper.Response> _raidPricePatch({@Body() required RaidPrice? body});

  ///Get Payment Url
  Future<chopper.Response<PaymentUrl>> raidPayGet() {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _raidPayGet();
  }

  ///Get Payment Url
  @Get(path: '/raid/pay')
  Future<chopper.Response<PaymentUrl>> _raidPayGet();

  ///Get Cdr Users
  Future<chopper.Response<List<CdrUserPreview>>> cdrUsersGet() {
    generatedMapping.putIfAbsent(
      CdrUserPreview,
      () => CdrUserPreview.fromJsonFactory,
    );

    return _cdrUsersGet();
  }

  ///Get Cdr Users
  @Get(path: '/cdr/users/')
  Future<chopper.Response<List<CdrUserPreview>>> _cdrUsersGet();

  ///Get Cdr Users Pending Validation
  Future<chopper.Response<List<CdrUserPreview>>> cdrUsersPendingGet() {
    generatedMapping.putIfAbsent(
      CdrUserPreview,
      () => CdrUserPreview.fromJsonFactory,
    );

    return _cdrUsersPendingGet();
  }

  ///Get Cdr Users Pending Validation
  @Get(path: '/cdr/users/pending/')
  Future<chopper.Response<List<CdrUserPreview>>> _cdrUsersPendingGet();

  ///Get Cdr User
  ///@param user_id
  Future<chopper.Response<CdrUser>> cdrUsersUserIdGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(CdrUser, () => CdrUser.fromJsonFactory);

    return _cdrUsersUserIdGet(userId: userId);
  }

  ///Get Cdr User
  ///@param user_id
  @Get(path: '/cdr/users/{user_id}/')
  Future<chopper.Response<CdrUser>> _cdrUsersUserIdGet({
    @Path('user_id') required String? userId,
  });

  ///Update Cdr User
  ///@param user_id
  Future<chopper.Response> cdrUsersUserIdPatch({
    required String? userId,
    required CdrUserUpdate? body,
  }) {
    return _cdrUsersUserIdPatch(userId: userId, body: body);
  }

  ///Update Cdr User
  ///@param user_id
  @Patch(path: '/cdr/users/{user_id}/', optionalBody: true)
  Future<chopper.Response> _cdrUsersUserIdPatch({
    @Path('user_id') required String? userId,
    @Body() required CdrUserUpdate? body,
  });

  ///Get Sellers
  Future<chopper.Response<List<SellerComplete>>> cdrSellersGet() {
    generatedMapping.putIfAbsent(
      SellerComplete,
      () => SellerComplete.fromJsonFactory,
    );

    return _cdrSellersGet();
  }

  ///Get Sellers
  @Get(path: '/cdr/sellers/')
  Future<chopper.Response<List<SellerComplete>>> _cdrSellersGet();

  ///Create Seller
  Future<chopper.Response<SellerComplete>> cdrSellersPost({
    required SellerBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SellerComplete,
      () => SellerComplete.fromJsonFactory,
    );

    return _cdrSellersPost(body: body);
  }

  ///Create Seller
  @Post(path: '/cdr/sellers/', optionalBody: true)
  Future<chopper.Response<SellerComplete>> _cdrSellersPost({
    @Body() required SellerBase? body,
  });

  ///Get Sellers By User Id
  Future<chopper.Response<List<SellerComplete>>> cdrUsersMeSellersGet() {
    generatedMapping.putIfAbsent(
      SellerComplete,
      () => SellerComplete.fromJsonFactory,
    );

    return _cdrUsersMeSellersGet();
  }

  ///Get Sellers By User Id
  @Get(path: '/cdr/users/me/sellers/')
  Future<chopper.Response<List<SellerComplete>>> _cdrUsersMeSellersGet();

  ///Get Online Sellers
  Future<chopper.Response<List<SellerComplete>>> cdrOnlineSellersGet() {
    generatedMapping.putIfAbsent(
      SellerComplete,
      () => SellerComplete.fromJsonFactory,
    );

    return _cdrOnlineSellersGet();
  }

  ///Get Online Sellers
  @Get(path: '/cdr/online/sellers/')
  Future<chopper.Response<List<SellerComplete>>> _cdrOnlineSellersGet();

  ///Send Seller Results
  ///@param seller_id
  Future<chopper.Response> cdrSellersSellerIdResultsGet({
    required String? sellerId,
  }) {
    return _cdrSellersSellerIdResultsGet(sellerId: sellerId);
  }

  ///Send Seller Results
  ///@param seller_id
  @Get(path: '/cdr/sellers/{seller_id}/results/')
  Future<chopper.Response> _cdrSellersSellerIdResultsGet({
    @Path('seller_id') required String? sellerId,
  });

  ///Get All Available Online Products
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  cdrOnlineProductsGet() {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductComplete,
      () => AppModulesCdrSchemasCdrProductComplete.fromJsonFactory,
    );

    return _cdrOnlineProductsGet();
  }

  ///Get All Available Online Products
  @Get(path: '/cdr/online/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrOnlineProductsGet();

  ///Get All Products
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  cdrProductsGet() {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductComplete,
      () => AppModulesCdrSchemasCdrProductComplete.fromJsonFactory,
    );

    return _cdrProductsGet();
  }

  ///Get All Products
  @Get(path: '/cdr/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrProductsGet();

  ///Update Seller
  ///@param seller_id
  Future<chopper.Response> cdrSellersSellerIdPatch({
    required String? sellerId,
    required SellerEdit? body,
  }) {
    return _cdrSellersSellerIdPatch(sellerId: sellerId, body: body);
  }

  ///Update Seller
  ///@param seller_id
  @Patch(path: '/cdr/sellers/{seller_id}/', optionalBody: true)
  Future<chopper.Response> _cdrSellersSellerIdPatch({
    @Path('seller_id') required String? sellerId,
    @Body() required SellerEdit? body,
  });

  ///Delete Seller
  ///@param seller_id
  Future<chopper.Response> cdrSellersSellerIdDelete({
    required String? sellerId,
  }) {
    return _cdrSellersSellerIdDelete(sellerId: sellerId);
  }

  ///Delete Seller
  ///@param seller_id
  @Delete(path: '/cdr/sellers/{seller_id}/')
  Future<chopper.Response> _cdrSellersSellerIdDelete({
    @Path('seller_id') required String? sellerId,
  });

  ///Get Products By Seller Id
  ///@param seller_id
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  cdrSellersSellerIdProductsGet({required String? sellerId}) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductComplete,
      () => AppModulesCdrSchemasCdrProductComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsGet(sellerId: sellerId);
  }

  ///Get Products By Seller Id
  ///@param seller_id
  @Get(path: '/cdr/sellers/{seller_id}/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrSellersSellerIdProductsGet({
    @Path('seller_id') required String? sellerId,
  });

  ///Create Product
  ///@param seller_id
  Future<chopper.Response<AppModulesCdrSchemasCdrProductComplete>>
  cdrSellersSellerIdProductsPost({
    required String? sellerId,
    required ProductBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductComplete,
      () => AppModulesCdrSchemasCdrProductComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsPost(sellerId: sellerId, body: body);
  }

  ///Create Product
  ///@param seller_id
  @Post(path: '/cdr/sellers/{seller_id}/products/', optionalBody: true)
  Future<chopper.Response<AppModulesCdrSchemasCdrProductComplete>>
  _cdrSellersSellerIdProductsPost({
    @Path('seller_id') required String? sellerId,
    @Body() required ProductBase? body,
  });

  ///Get Available Online Products
  ///@param seller_id
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  cdrOnlineSellersSellerIdProductsGet({required String? sellerId}) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductComplete,
      () => AppModulesCdrSchemasCdrProductComplete.fromJsonFactory,
    );

    return _cdrOnlineSellersSellerIdProductsGet(sellerId: sellerId);
  }

  ///Get Available Online Products
  ///@param seller_id
  @Get(path: '/cdr/online/sellers/{seller_id}/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrOnlineSellersSellerIdProductsGet({
    @Path('seller_id') required String? sellerId,
  });

  ///Update Product
  ///@param seller_id
  ///@param product_id
  Future<chopper.Response> cdrSellersSellerIdProductsProductIdPatch({
    required String? sellerId,
    required String? productId,
    required AppModulesCdrSchemasCdrProductEdit? body,
  }) {
    return _cdrSellersSellerIdProductsProductIdPatch(
      sellerId: sellerId,
      productId: productId,
      body: body,
    );
  }

  ///Update Product
  ///@param seller_id
  ///@param product_id
  @Patch(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/',
    optionalBody: true,
  )
  Future<chopper.Response> _cdrSellersSellerIdProductsProductIdPatch({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required AppModulesCdrSchemasCdrProductEdit? body,
  });

  ///Delete Product
  ///@param seller_id
  ///@param product_id
  Future<chopper.Response> cdrSellersSellerIdProductsProductIdDelete({
    required String? sellerId,
    required String? productId,
  }) {
    return _cdrSellersSellerIdProductsProductIdDelete(
      sellerId: sellerId,
      productId: productId,
    );
  }

  ///Delete Product
  ///@param seller_id
  ///@param product_id
  @Delete(path: '/cdr/sellers/{seller_id}/products/{product_id}/')
  Future<chopper.Response> _cdrSellersSellerIdProductsProductIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
  });

  ///Create Product Variant
  ///@param seller_id
  ///@param product_id
  Future<chopper.Response<ProductVariantComplete>>
  cdrSellersSellerIdProductsProductIdVariantsPost({
    required String? sellerId,
    required String? productId,
    required ProductVariantBase? body,
  }) {
    generatedMapping.putIfAbsent(
      ProductVariantComplete,
      () => ProductVariantComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsProductIdVariantsPost(
      sellerId: sellerId,
      productId: productId,
      body: body,
    );
  }

  ///Create Product Variant
  ///@param seller_id
  ///@param product_id
  @Post(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/variants/',
    optionalBody: true,
  )
  Future<chopper.Response<ProductVariantComplete>>
  _cdrSellersSellerIdProductsProductIdVariantsPost({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required ProductVariantBase? body,
  });

  ///Update Product Variant
  ///@param seller_id
  ///@param product_id
  ///@param variant_id
  Future<chopper.Response>
  cdrSellersSellerIdProductsProductIdVariantsVariantIdPatch({
    required String? sellerId,
    required String? productId,
    required String? variantId,
    required ProductVariantEdit? body,
  }) {
    return _cdrSellersSellerIdProductsProductIdVariantsVariantIdPatch(
      sellerId: sellerId,
      productId: productId,
      variantId: variantId,
      body: body,
    );
  }

  ///Update Product Variant
  ///@param seller_id
  ///@param product_id
  ///@param variant_id
  @Patch(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/variants/{variant_id}/',
    optionalBody: true,
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdVariantsVariantIdPatch({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('variant_id') required String? variantId,
    @Body() required ProductVariantEdit? body,
  });

  ///Delete Product Variant
  ///@param seller_id
  ///@param product_id
  ///@param variant_id
  Future<chopper.Response>
  cdrSellersSellerIdProductsProductIdVariantsVariantIdDelete({
    required String? sellerId,
    required String? productId,
    required String? variantId,
  }) {
    return _cdrSellersSellerIdProductsProductIdVariantsVariantIdDelete(
      sellerId: sellerId,
      productId: productId,
      variantId: variantId,
    );
  }

  ///Delete Product Variant
  ///@param seller_id
  ///@param product_id
  ///@param variant_id
  @Delete(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/variants/{variant_id}/',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdVariantsVariantIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('variant_id') required String? variantId,
  });

  ///Get Seller Documents
  ///@param seller_id
  Future<chopper.Response<List<DocumentComplete>>>
  cdrSellersSellerIdDocumentsGet({required String? sellerId}) {
    generatedMapping.putIfAbsent(
      DocumentComplete,
      () => DocumentComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdDocumentsGet(sellerId: sellerId);
  }

  ///Get Seller Documents
  ///@param seller_id
  @Get(path: '/cdr/sellers/{seller_id}/documents/')
  Future<chopper.Response<List<DocumentComplete>>>
  _cdrSellersSellerIdDocumentsGet({
    @Path('seller_id') required String? sellerId,
  });

  ///Create Document
  ///@param seller_id
  Future<chopper.Response<DocumentComplete>> cdrSellersSellerIdDocumentsPost({
    required String? sellerId,
    required DocumentBase? body,
  }) {
    generatedMapping.putIfAbsent(
      DocumentComplete,
      () => DocumentComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdDocumentsPost(sellerId: sellerId, body: body);
  }

  ///Create Document
  ///@param seller_id
  @Post(path: '/cdr/sellers/{seller_id}/documents/', optionalBody: true)
  Future<chopper.Response<DocumentComplete>> _cdrSellersSellerIdDocumentsPost({
    @Path('seller_id') required String? sellerId,
    @Body() required DocumentBase? body,
  });

  ///Get All Sellers Documents
  Future<chopper.Response<List<DocumentComplete>>> cdrDocumentsGet() {
    generatedMapping.putIfAbsent(
      DocumentComplete,
      () => DocumentComplete.fromJsonFactory,
    );

    return _cdrDocumentsGet();
  }

  ///Get All Sellers Documents
  @Get(path: '/cdr/documents/')
  Future<chopper.Response<List<DocumentComplete>>> _cdrDocumentsGet();

  ///Delete Document
  ///@param seller_id
  ///@param document_id
  Future<chopper.Response> cdrSellersSellerIdDocumentsDocumentIdDelete({
    required String? sellerId,
    required String? documentId,
  }) {
    return _cdrSellersSellerIdDocumentsDocumentIdDelete(
      sellerId: sellerId,
      documentId: documentId,
    );
  }

  ///Delete Document
  ///@param seller_id
  ///@param document_id
  @Delete(path: '/cdr/sellers/{seller_id}/documents/{document_id}/')
  Future<chopper.Response> _cdrSellersSellerIdDocumentsDocumentIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('document_id') required String? documentId,
  });

  ///Get Purchases By User Id
  ///@param user_id
  Future<chopper.Response<List<PurchaseReturn>>> cdrUsersUserIdPurchasesGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      PurchaseReturn,
      () => PurchaseReturn.fromJsonFactory,
    );

    return _cdrUsersUserIdPurchasesGet(userId: userId);
  }

  ///Get Purchases By User Id
  ///@param user_id
  @Get(path: '/cdr/users/{user_id}/purchases/')
  Future<chopper.Response<List<PurchaseReturn>>> _cdrUsersUserIdPurchasesGet({
    @Path('user_id') required String? userId,
  });

  ///Get My Purchases
  Future<chopper.Response<List<PurchaseReturn>>> cdrMePurchasesGet() {
    generatedMapping.putIfAbsent(
      PurchaseReturn,
      () => PurchaseReturn.fromJsonFactory,
    );

    return _cdrMePurchasesGet();
  }

  ///Get My Purchases
  @Get(path: '/cdr/me/purchases/')
  Future<chopper.Response<List<PurchaseReturn>>> _cdrMePurchasesGet();

  ///Get Purchases By User Id By Seller Id
  ///@param seller_id
  ///@param user_id
  Future<chopper.Response<List<PurchaseReturn>>>
  cdrSellersSellerIdUsersUserIdPurchasesGet({
    required String? sellerId,
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      PurchaseReturn,
      () => PurchaseReturn.fromJsonFactory,
    );

    return _cdrSellersSellerIdUsersUserIdPurchasesGet(
      sellerId: sellerId,
      userId: userId,
    );
  }

  ///Get Purchases By User Id By Seller Id
  ///@param seller_id
  ///@param user_id
  @Get(path: '/cdr/sellers/{seller_id}/users/{user_id}/purchases/')
  Future<chopper.Response<List<PurchaseReturn>>>
  _cdrSellersSellerIdUsersUserIdPurchasesGet({
    @Path('seller_id') required String? sellerId,
    @Path('user_id') required String? userId,
  });

  ///Create Purchase
  ///@param user_id
  ///@param product_variant_id
  Future<chopper.Response<PurchaseComplete>>
  cdrUsersUserIdPurchasesProductVariantIdPost({
    required String? userId,
    required String? productVariantId,
    required PurchaseBase? body,
  }) {
    generatedMapping.putIfAbsent(
      PurchaseComplete,
      () => PurchaseComplete.fromJsonFactory,
    );

    return _cdrUsersUserIdPurchasesProductVariantIdPost(
      userId: userId,
      productVariantId: productVariantId,
      body: body,
    );
  }

  ///Create Purchase
  ///@param user_id
  ///@param product_variant_id
  @Post(
    path: '/cdr/users/{user_id}/purchases/{product_variant_id}/',
    optionalBody: true,
  )
  Future<chopper.Response<PurchaseComplete>>
  _cdrUsersUserIdPurchasesProductVariantIdPost({
    @Path('user_id') required String? userId,
    @Path('product_variant_id') required String? productVariantId,
    @Body() required PurchaseBase? body,
  });

  ///Delete Purchase
  ///@param user_id
  ///@param product_variant_id
  Future<chopper.Response> cdrUsersUserIdPurchasesProductVariantIdDelete({
    required String? userId,
    required String? productVariantId,
  }) {
    return _cdrUsersUserIdPurchasesProductVariantIdDelete(
      userId: userId,
      productVariantId: productVariantId,
    );
  }

  ///Delete Purchase
  ///@param user_id
  ///@param product_variant_id
  @Delete(path: '/cdr/users/{user_id}/purchases/{product_variant_id}/')
  Future<chopper.Response> _cdrUsersUserIdPurchasesProductVariantIdDelete({
    @Path('user_id') required String? userId,
    @Path('product_variant_id') required String? productVariantId,
  });

  ///Mark Purchase As Validated
  ///@param user_id
  ///@param product_variant_id
  ///@param validated
  Future<chopper.Response>
  cdrUsersUserIdPurchasesProductVariantIdValidatedPatch({
    required String? userId,
    required String? productVariantId,
    required bool? validated,
  }) {
    return _cdrUsersUserIdPurchasesProductVariantIdValidatedPatch(
      userId: userId,
      productVariantId: productVariantId,
      validated: validated,
    );
  }

  ///Mark Purchase As Validated
  ///@param user_id
  ///@param product_variant_id
  ///@param validated
  @Patch(
    path: '/cdr/users/{user_id}/purchases/{product_variant_id}/validated/',
    optionalBody: true,
  )
  Future<chopper.Response>
  _cdrUsersUserIdPurchasesProductVariantIdValidatedPatch({
    @Path('user_id') required String? userId,
    @Path('product_variant_id') required String? productVariantId,
    @Query('validated') required bool? validated,
  });

  ///Get Signatures By User Id
  ///@param user_id
  Future<chopper.Response<List<SignatureComplete>>>
  cdrUsersUserIdSignaturesGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      SignatureComplete,
      () => SignatureComplete.fromJsonFactory,
    );

    return _cdrUsersUserIdSignaturesGet(userId: userId);
  }

  ///Get Signatures By User Id
  ///@param user_id
  @Get(path: '/cdr/users/{user_id}/signatures/')
  Future<chopper.Response<List<SignatureComplete>>>
  _cdrUsersUserIdSignaturesGet({@Path('user_id') required String? userId});

  ///Get Signatures By User Id By Seller Id
  ///@param seller_id
  ///@param user_id
  Future<chopper.Response<List<SignatureComplete>>>
  cdrSellersSellerIdUsersUserIdSignaturesGet({
    required String? sellerId,
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      SignatureComplete,
      () => SignatureComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdUsersUserIdSignaturesGet(
      sellerId: sellerId,
      userId: userId,
    );
  }

  ///Get Signatures By User Id By Seller Id
  ///@param seller_id
  ///@param user_id
  @Get(path: '/cdr/sellers/{seller_id}/users/{user_id}/signatures/')
  Future<chopper.Response<List<SignatureComplete>>>
  _cdrSellersSellerIdUsersUserIdSignaturesGet({
    @Path('seller_id') required String? sellerId,
    @Path('user_id') required String? userId,
  });

  ///Create Signature
  ///@param user_id
  ///@param document_id
  Future<chopper.Response<SignatureComplete>>
  cdrUsersUserIdSignaturesDocumentIdPost({
    required String? userId,
    required String? documentId,
    required SignatureBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SignatureComplete,
      () => SignatureComplete.fromJsonFactory,
    );

    return _cdrUsersUserIdSignaturesDocumentIdPost(
      userId: userId,
      documentId: documentId,
      body: body,
    );
  }

  ///Create Signature
  ///@param user_id
  ///@param document_id
  @Post(
    path: '/cdr/users/{user_id}/signatures/{document_id}/',
    optionalBody: true,
  )
  Future<chopper.Response<SignatureComplete>>
  _cdrUsersUserIdSignaturesDocumentIdPost({
    @Path('user_id') required String? userId,
    @Path('document_id') required String? documentId,
    @Body() required SignatureBase? body,
  });

  ///Delete Signature
  ///@param user_id
  ///@param document_id
  Future<chopper.Response> cdrUsersUserIdSignaturesDocumentIdDelete({
    required String? userId,
    required String? documentId,
  }) {
    return _cdrUsersUserIdSignaturesDocumentIdDelete(
      userId: userId,
      documentId: documentId,
    );
  }

  ///Delete Signature
  ///@param user_id
  ///@param document_id
  @Delete(path: '/cdr/users/{user_id}/signatures/{document_id}/')
  Future<chopper.Response> _cdrUsersUserIdSignaturesDocumentIdDelete({
    @Path('user_id') required String? userId,
    @Path('document_id') required String? documentId,
  });

  ///Get Curriculums
  Future<chopper.Response<List<CurriculumComplete>>> cdrCurriculumsGet() {
    generatedMapping.putIfAbsent(
      CurriculumComplete,
      () => CurriculumComplete.fromJsonFactory,
    );

    return _cdrCurriculumsGet();
  }

  ///Get Curriculums
  @Get(path: '/cdr/curriculums/')
  Future<chopper.Response<List<CurriculumComplete>>> _cdrCurriculumsGet();

  ///Create Curriculum
  Future<chopper.Response<CurriculumComplete>> cdrCurriculumsPost({
    required CurriculumBase? body,
  }) {
    generatedMapping.putIfAbsent(
      CurriculumComplete,
      () => CurriculumComplete.fromJsonFactory,
    );

    return _cdrCurriculumsPost(body: body);
  }

  ///Create Curriculum
  @Post(path: '/cdr/curriculums/', optionalBody: true)
  Future<chopper.Response<CurriculumComplete>> _cdrCurriculumsPost({
    @Body() required CurriculumBase? body,
  });

  ///Delete Curriculum
  ///@param curriculum_id
  Future<chopper.Response> cdrCurriculumsCurriculumIdDelete({
    required String? curriculumId,
  }) {
    return _cdrCurriculumsCurriculumIdDelete(curriculumId: curriculumId);
  }

  ///Delete Curriculum
  ///@param curriculum_id
  @Delete(path: '/cdr/curriculums/{curriculum_id}/')
  Future<chopper.Response> _cdrCurriculumsCurriculumIdDelete({
    @Path('curriculum_id') required String? curriculumId,
  });

  ///Create Curriculum Membership
  ///@param user_id
  ///@param curriculum_id
  Future<chopper.Response> cdrUsersUserIdCurriculumsCurriculumIdPost({
    required String? userId,
    required String? curriculumId,
  }) {
    return _cdrUsersUserIdCurriculumsCurriculumIdPost(
      userId: userId,
      curriculumId: curriculumId,
    );
  }

  ///Create Curriculum Membership
  ///@param user_id
  ///@param curriculum_id
  @Post(
    path: '/cdr/users/{user_id}/curriculums/{curriculum_id}/',
    optionalBody: true,
  )
  Future<chopper.Response> _cdrUsersUserIdCurriculumsCurriculumIdPost({
    @Path('user_id') required String? userId,
    @Path('curriculum_id') required String? curriculumId,
  });

  ///Update Curriculum Membership
  ///@param user_id
  ///@param curriculum_id
  Future<chopper.Response> cdrUsersUserIdCurriculumsCurriculumIdPatch({
    required String? userId,
    required String? curriculumId,
  }) {
    return _cdrUsersUserIdCurriculumsCurriculumIdPatch(
      userId: userId,
      curriculumId: curriculumId,
    );
  }

  ///Update Curriculum Membership
  ///@param user_id
  ///@param curriculum_id
  @Patch(
    path: '/cdr/users/{user_id}/curriculums/{curriculum_id}/',
    optionalBody: true,
  )
  Future<chopper.Response> _cdrUsersUserIdCurriculumsCurriculumIdPatch({
    @Path('user_id') required String? userId,
    @Path('curriculum_id') required String? curriculumId,
  });

  ///Delete Curriculum Membership
  ///@param user_id
  ///@param curriculum_id
  Future<chopper.Response> cdrUsersUserIdCurriculumsCurriculumIdDelete({
    required String? userId,
    required String? curriculumId,
  }) {
    return _cdrUsersUserIdCurriculumsCurriculumIdDelete(
      userId: userId,
      curriculumId: curriculumId,
    );
  }

  ///Delete Curriculum Membership
  ///@param user_id
  ///@param curriculum_id
  @Delete(path: '/cdr/users/{user_id}/curriculums/{curriculum_id}/')
  Future<chopper.Response> _cdrUsersUserIdCurriculumsCurriculumIdDelete({
    @Path('user_id') required String? userId,
    @Path('curriculum_id') required String? curriculumId,
  });

  ///Get Payments By User Id
  ///@param user_id
  Future<chopper.Response<List<PaymentComplete>>> cdrUsersUserIdPaymentsGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      PaymentComplete,
      () => PaymentComplete.fromJsonFactory,
    );

    return _cdrUsersUserIdPaymentsGet(userId: userId);
  }

  ///Get Payments By User Id
  ///@param user_id
  @Get(path: '/cdr/users/{user_id}/payments/')
  Future<chopper.Response<List<PaymentComplete>>> _cdrUsersUserIdPaymentsGet({
    @Path('user_id') required String? userId,
  });

  ///Create Payment
  ///@param user_id
  Future<chopper.Response<PaymentComplete>> cdrUsersUserIdPaymentsPost({
    required String? userId,
    required PaymentBase? body,
  }) {
    generatedMapping.putIfAbsent(
      PaymentComplete,
      () => PaymentComplete.fromJsonFactory,
    );

    return _cdrUsersUserIdPaymentsPost(userId: userId, body: body);
  }

  ///Create Payment
  ///@param user_id
  @Post(path: '/cdr/users/{user_id}/payments/', optionalBody: true)
  Future<chopper.Response<PaymentComplete>> _cdrUsersUserIdPaymentsPost({
    @Path('user_id') required String? userId,
    @Body() required PaymentBase? body,
  });

  ///Delete Payment
  ///@param user_id
  ///@param payment_id
  Future<chopper.Response> cdrUsersUserIdPaymentsPaymentIdDelete({
    required String? userId,
    required String? paymentId,
  }) {
    return _cdrUsersUserIdPaymentsPaymentIdDelete(
      userId: userId,
      paymentId: paymentId,
    );
  }

  ///Delete Payment
  ///@param user_id
  ///@param payment_id
  @Delete(path: '/cdr/users/{user_id}/payments/{payment_id}/')
  Future<chopper.Response> _cdrUsersUserIdPaymentsPaymentIdDelete({
    @Path('user_id') required String? userId,
    @Path('payment_id') required String? paymentId,
  });

  ///Get Payment Url
  Future<chopper.Response<PaymentUrl>> cdrPayPost() {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _cdrPayPost();
  }

  ///Get Payment Url
  @Post(path: '/cdr/pay/', optionalBody: true)
  Future<chopper.Response<PaymentUrl>> _cdrPayPost();

  ///Get Status
  Future<chopper.Response<Status>> cdrStatusGet() {
    generatedMapping.putIfAbsent(Status, () => Status.fromJsonFactory);

    return _cdrStatusGet();
  }

  ///Get Status
  @Get(path: '/cdr/status/')
  Future<chopper.Response<Status>> _cdrStatusGet();

  ///Update Status
  Future<chopper.Response> cdrStatusPatch({required Status? body}) {
    return _cdrStatusPatch(body: body);
  }

  ///Update Status
  @Patch(path: '/cdr/status/', optionalBody: true)
  Future<chopper.Response> _cdrStatusPatch({@Body() required Status? body});

  ///Get My Tickets
  Future<chopper.Response<List<Ticket>>> cdrUsersMeTicketsGet() {
    generatedMapping.putIfAbsent(Ticket, () => Ticket.fromJsonFactory);

    return _cdrUsersMeTicketsGet();
  }

  ///Get My Tickets
  @Get(path: '/cdr/users/me/tickets/')
  Future<chopper.Response<List<Ticket>>> _cdrUsersMeTicketsGet();

  ///Get Tickets Of User
  ///@param user_id
  Future<chopper.Response<List<Ticket>>> cdrUsersUserIdTicketsGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(Ticket, () => Ticket.fromJsonFactory);

    return _cdrUsersUserIdTicketsGet(userId: userId);
  }

  ///Get Tickets Of User
  ///@param user_id
  @Get(path: '/cdr/users/{user_id}/tickets/')
  Future<chopper.Response<List<Ticket>>> _cdrUsersUserIdTicketsGet({
    @Path('user_id') required String? userId,
  });

  ///Get Ticket Secret
  ///@param ticket_id
  Future<chopper.Response<TicketSecret>> cdrUsersMeTicketsTicketIdSecretGet({
    required String? ticketId,
  }) {
    generatedMapping.putIfAbsent(
      TicketSecret,
      () => TicketSecret.fromJsonFactory,
    );

    return _cdrUsersMeTicketsTicketIdSecretGet(ticketId: ticketId);
  }

  ///Get Ticket Secret
  ///@param ticket_id
  @Get(path: '/cdr/users/me/tickets/{ticket_id}/secret/')
  Future<chopper.Response<TicketSecret>> _cdrUsersMeTicketsTicketIdSecretGet({
    @Path('ticket_id') required String? ticketId,
  });

  ///Get Ticket By Secret
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  ///@param secret
  Future<chopper.Response<Ticket>>
  cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? secret,
  }) {
    generatedMapping.putIfAbsent(Ticket, () => Ticket.fromJsonFactory);

    return _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet(
      sellerId: sellerId,
      productId: productId,
      generatorId: generatorId,
      secret: secret,
    );
  }

  ///Get Ticket By Secret
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  ///@param secret
  @Get(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/tickets/{generator_id}/{secret}/',
  )
  Future<chopper.Response<Ticket>>
  _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('generator_id') required String? generatorId,
    @Path('secret') required String? secret,
  });

  ///Scan Ticket
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  ///@param secret
  Future<chopper.Response>
  cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? secret,
    required TicketScan? body,
  }) {
    return _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch(
      sellerId: sellerId,
      productId: productId,
      generatorId: generatorId,
      secret: secret,
      body: body,
    );
  }

  ///Scan Ticket
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  ///@param secret
  @Patch(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/tickets/{generator_id}/{secret}/',
    optionalBody: true,
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('generator_id') required String? generatorId,
    @Path('secret') required String? secret,
    @Body() required TicketScan? body,
  });

  ///Get Users By Tag
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  ///@param tag
  Future<chopper.Response<List<CoreUserSimple>>>
  cdrSellersSellerIdProductsProductIdTicketsGeneratorIdListsTagGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? tag,
  }) {
    generatedMapping.putIfAbsent(
      CoreUserSimple,
      () => CoreUserSimple.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdListsTagGet(
      sellerId: sellerId,
      productId: productId,
      generatorId: generatorId,
      tag: tag,
    );
  }

  ///Get Users By Tag
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  ///@param tag
  @Get(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/tickets/{generator_id}/lists/{tag}/',
  )
  Future<chopper.Response<List<CoreUserSimple>>>
  _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdListsTagGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('generator_id') required String? generatorId,
    @Path('tag') required String? tag,
  });

  ///Get Tags Of Ticket
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  Future<chopper.Response<List<String>>>
  cdrSellersSellerIdProductsProductIdTagsGeneratorIdGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
  }) {
    return _cdrSellersSellerIdProductsProductIdTagsGeneratorIdGet(
      sellerId: sellerId,
      productId: productId,
      generatorId: generatorId,
    );
  }

  ///Get Tags Of Ticket
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  @Get(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/tags/{generator_id}/',
  )
  Future<chopper.Response<List<String>>>
  _cdrSellersSellerIdProductsProductIdTagsGeneratorIdGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('generator_id') required String? generatorId,
  });

  ///Generate Ticket For Product
  ///@param seller_id
  ///@param product_id
  Future<chopper.Response<AppModulesCdrSchemasCdrProductComplete>>
  cdrSellersSellerIdProductsProductIdTicketsPost({
    required String? sellerId,
    required String? productId,
    required GenerateTicketBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductComplete,
      () => AppModulesCdrSchemasCdrProductComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsProductIdTicketsPost(
      sellerId: sellerId,
      productId: productId,
      body: body,
    );
  }

  ///Generate Ticket For Product
  ///@param seller_id
  ///@param product_id
  @Post(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/tickets/',
    optionalBody: true,
  )
  Future<chopper.Response<AppModulesCdrSchemasCdrProductComplete>>
  _cdrSellersSellerIdProductsProductIdTicketsPost({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required GenerateTicketBase? body,
  });

  ///Delete Ticket Generator For Product
  ///@param seller_id
  ///@param product_id
  ///@param ticket_generator_id
  Future<chopper.Response>
  cdrSellersSellerIdProductsProductIdTicketsTicketGeneratorIdDelete({
    required String? sellerId,
    required String? productId,
    required String? ticketGeneratorId,
  }) {
    return _cdrSellersSellerIdProductsProductIdTicketsTicketGeneratorIdDelete(
      sellerId: sellerId,
      productId: productId,
      ticketGeneratorId: ticketGeneratorId,
    );
  }

  ///Delete Ticket Generator For Product
  ///@param seller_id
  ///@param product_id
  ///@param ticket_generator_id
  @Delete(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/tickets/{ticket_generator_id}',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdTicketsTicketGeneratorIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('ticket_generator_id') required String? ticketGeneratorId,
  });

  ///Get Custom Data Fields
  ///@param seller_id
  ///@param product_id
  Future<chopper.Response<List<CustomDataFieldComplete>>>
  cdrSellersSellerIdProductsProductIdDataGet({
    required String? sellerId,
    required String? productId,
  }) {
    generatedMapping.putIfAbsent(
      CustomDataFieldComplete,
      () => CustomDataFieldComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsProductIdDataGet(
      sellerId: sellerId,
      productId: productId,
    );
  }

  ///Get Custom Data Fields
  ///@param seller_id
  ///@param product_id
  @Get(path: '/cdr/sellers/{seller_id}/products/{product_id}/data/')
  Future<chopper.Response<List<CustomDataFieldComplete>>>
  _cdrSellersSellerIdProductsProductIdDataGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
  });

  ///Create Custom Data Field
  ///@param seller_id
  ///@param product_id
  Future<chopper.Response<CustomDataFieldComplete>>
  cdrSellersSellerIdProductsProductIdDataPost({
    required String? sellerId,
    required String? productId,
    required CustomDataFieldBase? body,
  }) {
    generatedMapping.putIfAbsent(
      CustomDataFieldComplete,
      () => CustomDataFieldComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsProductIdDataPost(
      sellerId: sellerId,
      productId: productId,
      body: body,
    );
  }

  ///Create Custom Data Field
  ///@param seller_id
  ///@param product_id
  @Post(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/data/',
    optionalBody: true,
  )
  Future<chopper.Response<CustomDataFieldComplete>>
  _cdrSellersSellerIdProductsProductIdDataPost({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required CustomDataFieldBase? body,
  });

  ///Delete Customdata Field
  ///@param seller_id
  ///@param product_id
  ///@param field_id
  Future<chopper.Response>
  cdrSellersSellerIdProductsProductIdDataFieldIdDelete({
    required String? sellerId,
    required String? productId,
    required String? fieldId,
  }) {
    return _cdrSellersSellerIdProductsProductIdDataFieldIdDelete(
      sellerId: sellerId,
      productId: productId,
      fieldId: fieldId,
    );
  }

  ///Delete Customdata Field
  ///@param seller_id
  ///@param product_id
  ///@param field_id
  @Delete(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/data/{field_id}/',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdDataFieldIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('field_id') required String? fieldId,
  });

  ///Get Customdata
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  Future<chopper.Response<CustomDataComplete>>
  cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdGet({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
  }) {
    generatedMapping.putIfAbsent(
      CustomDataComplete,
      () => CustomDataComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdGet(
      sellerId: sellerId,
      productId: productId,
      userId: userId,
      fieldId: fieldId,
    );
  }

  ///Get Customdata
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  @Get(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/users/{user_id}/data/{field_id}/',
  )
  Future<chopper.Response<CustomDataComplete>>
  _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('user_id') required String? userId,
    @Path('field_id') required String? fieldId,
  });

  ///Create Custom Data
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  Future<chopper.Response<CustomDataComplete>>
  cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPost({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
    required CustomDataBase? body,
  }) {
    generatedMapping.putIfAbsent(
      CustomDataComplete,
      () => CustomDataComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPost(
      sellerId: sellerId,
      productId: productId,
      userId: userId,
      fieldId: fieldId,
      body: body,
    );
  }

  ///Create Custom Data
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  @Post(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/users/{user_id}/data/{field_id}/',
    optionalBody: true,
  )
  Future<chopper.Response<CustomDataComplete>>
  _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPost({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('user_id') required String? userId,
    @Path('field_id') required String? fieldId,
    @Body() required CustomDataBase? body,
  });

  ///Update Custom Data
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  Future<chopper.Response>
  cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPatch({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
    required CustomDataBase? body,
  }) {
    return _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPatch(
      sellerId: sellerId,
      productId: productId,
      userId: userId,
      fieldId: fieldId,
      body: body,
    );
  }

  ///Update Custom Data
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  @Patch(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/users/{user_id}/data/{field_id}/',
    optionalBody: true,
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdPatch({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('user_id') required String? userId,
    @Path('field_id') required String? fieldId,
    @Body() required CustomDataBase? body,
  });

  ///Delete Customdata
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  Future<chopper.Response>
  cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdDelete({
    required String? sellerId,
    required String? productId,
    required String? userId,
    required String? fieldId,
  }) {
    return _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdDelete(
      sellerId: sellerId,
      productId: productId,
      userId: userId,
      fieldId: fieldId,
    );
  }

  ///Delete Customdata
  ///@param seller_id
  ///@param product_id
  ///@param user_id
  ///@param field_id
  @Delete(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/users/{user_id}/data/{field_id}/',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('user_id') required String? userId,
    @Path('field_id') required String? fieldId,
  });

  ///Get All Species
  Future<chopper.Response<List<SpeciesComplete>>> seedLibrarySpeciesGet() {
    generatedMapping.putIfAbsent(
      SpeciesComplete,
      () => SpeciesComplete.fromJsonFactory,
    );

    return _seedLibrarySpeciesGet();
  }

  ///Get All Species
  @Get(path: '/seed_library/species/')
  Future<chopper.Response<List<SpeciesComplete>>> _seedLibrarySpeciesGet();

  ///Create Species
  Future<chopper.Response<SpeciesComplete>> seedLibrarySpeciesPost({
    required SpeciesBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SpeciesComplete,
      () => SpeciesComplete.fromJsonFactory,
    );

    return _seedLibrarySpeciesPost(body: body);
  }

  ///Create Species
  @Post(path: '/seed_library/species/', optionalBody: true)
  Future<chopper.Response<SpeciesComplete>> _seedLibrarySpeciesPost({
    @Body() required SpeciesBase? body,
  });

  ///Get All Species Types
  Future<chopper.Response<SpeciesTypesReturn>> seedLibrarySpeciesTypesGet() {
    generatedMapping.putIfAbsent(
      SpeciesTypesReturn,
      () => SpeciesTypesReturn.fromJsonFactory,
    );

    return _seedLibrarySpeciesTypesGet();
  }

  ///Get All Species Types
  @Get(path: '/seed_library/species/types')
  Future<chopper.Response<SpeciesTypesReturn>> _seedLibrarySpeciesTypesGet();

  ///Update Species
  ///@param species_id
  Future<chopper.Response> seedLibrarySpeciesSpeciesIdPatch({
    required String? speciesId,
    required SpeciesEdit? body,
  }) {
    return _seedLibrarySpeciesSpeciesIdPatch(speciesId: speciesId, body: body);
  }

  ///Update Species
  ///@param species_id
  @Patch(path: '/seed_library/species/{species_id}', optionalBody: true)
  Future<chopper.Response> _seedLibrarySpeciesSpeciesIdPatch({
    @Path('species_id') required String? speciesId,
    @Body() required SpeciesEdit? body,
  });

  ///Delete Species
  ///@param species_id
  Future<chopper.Response> seedLibrarySpeciesSpeciesIdDelete({
    required String? speciesId,
  }) {
    return _seedLibrarySpeciesSpeciesIdDelete(speciesId: speciesId);
  }

  ///Delete Species
  ///@param species_id
  @Delete(path: '/seed_library/species/{species_id}')
  Future<chopper.Response> _seedLibrarySpeciesSpeciesIdDelete({
    @Path('species_id') required String? speciesId,
  });

  ///Get Waiting Plants
  Future<chopper.Response<List<PlantSimple>>> seedLibraryPlantsWaitingGet() {
    generatedMapping.putIfAbsent(
      PlantSimple,
      () => PlantSimple.fromJsonFactory,
    );

    return _seedLibraryPlantsWaitingGet();
  }

  ///Get Waiting Plants
  @Get(path: '/seed_library/plants/waiting')
  Future<chopper.Response<List<PlantSimple>>> _seedLibraryPlantsWaitingGet();

  ///Get My Plants
  Future<chopper.Response<List<PlantSimple>>> seedLibraryPlantsUsersMeGet() {
    generatedMapping.putIfAbsent(
      PlantSimple,
      () => PlantSimple.fromJsonFactory,
    );

    return _seedLibraryPlantsUsersMeGet();
  }

  ///Get My Plants
  @Get(path: '/seed_library/plants/users/me')
  Future<chopper.Response<List<PlantSimple>>> _seedLibraryPlantsUsersMeGet();

  ///Get Plants By User Id
  ///@param user_id
  Future<chopper.Response<List<PlantSimple>>> seedLibraryPlantsUsersUserIdGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      PlantSimple,
      () => PlantSimple.fromJsonFactory,
    );

    return _seedLibraryPlantsUsersUserIdGet(userId: userId);
  }

  ///Get Plants By User Id
  ///@param user_id
  @Get(path: '/seed_library/plants/users/{user_id}')
  Future<chopper.Response<List<PlantSimple>>> _seedLibraryPlantsUsersUserIdGet({
    @Path('user_id') required String? userId,
  });

  ///Get Plant By Id
  ///@param plant_id
  Future<chopper.Response<PlantComplete>> seedLibraryPlantsPlantIdGet({
    required String? plantId,
  }) {
    generatedMapping.putIfAbsent(
      PlantComplete,
      () => PlantComplete.fromJsonFactory,
    );

    return _seedLibraryPlantsPlantIdGet(plantId: plantId);
  }

  ///Get Plant By Id
  ///@param plant_id
  @Get(path: '/seed_library/plants/{plant_id}')
  Future<chopper.Response<PlantComplete>> _seedLibraryPlantsPlantIdGet({
    @Path('plant_id') required String? plantId,
  });

  ///Update Plant
  ///@param plant_id
  Future<chopper.Response> seedLibraryPlantsPlantIdPatch({
    required String? plantId,
    required PlantEdit? body,
  }) {
    return _seedLibraryPlantsPlantIdPatch(plantId: plantId, body: body);
  }

  ///Update Plant
  ///@param plant_id
  @Patch(path: '/seed_library/plants/{plant_id}', optionalBody: true)
  Future<chopper.Response> _seedLibraryPlantsPlantIdPatch({
    @Path('plant_id') required String? plantId,
    @Body() required PlantEdit? body,
  });

  ///Delete Plant
  ///@param plant_id
  Future<chopper.Response> seedLibraryPlantsPlantIdDelete({
    required String? plantId,
  }) {
    return _seedLibraryPlantsPlantIdDelete(plantId: plantId);
  }

  ///Delete Plant
  ///@param plant_id
  @Delete(path: '/seed_library/plants/{plant_id}')
  Future<chopper.Response> _seedLibraryPlantsPlantIdDelete({
    @Path('plant_id') required String? plantId,
  });

  ///Create Plant
  Future<chopper.Response<PlantComplete>> seedLibraryPlantsPost({
    required PlantCreation? body,
  }) {
    generatedMapping.putIfAbsent(
      PlantComplete,
      () => PlantComplete.fromJsonFactory,
    );

    return _seedLibraryPlantsPost(body: body);
  }

  ///Create Plant
  @Post(path: '/seed_library/plants/', optionalBody: true)
  Future<chopper.Response<PlantComplete>> _seedLibraryPlantsPost({
    @Body() required PlantCreation? body,
  });

  ///Update Plant Admin
  ///@param plant_id
  Future<chopper.Response> seedLibraryPlantsPlantIdAdminPatch({
    required String? plantId,
    required PlantEdit? body,
  }) {
    return _seedLibraryPlantsPlantIdAdminPatch(plantId: plantId, body: body);
  }

  ///Update Plant Admin
  ///@param plant_id
  @Patch(path: '/seed_library/plants/{plant_id}/admin', optionalBody: true)
  Future<chopper.Response> _seedLibraryPlantsPlantIdAdminPatch({
    @Path('plant_id') required String? plantId,
    @Body() required PlantEdit? body,
  });

  ///Borrow Plant
  ///@param plant_id
  Future<chopper.Response> seedLibraryPlantsPlantIdBorrowPatch({
    required String? plantId,
  }) {
    return _seedLibraryPlantsPlantIdBorrowPatch(plantId: plantId);
  }

  ///Borrow Plant
  ///@param plant_id
  @Patch(path: '/seed_library/plants/{plant_id}/borrow', optionalBody: true)
  Future<chopper.Response> _seedLibraryPlantsPlantIdBorrowPatch({
    @Path('plant_id') required String? plantId,
  });

  ///Get Seed Library Information
  Future<chopper.Response<SeedLibraryInformation>> seedLibraryInformationGet() {
    generatedMapping.putIfAbsent(
      SeedLibraryInformation,
      () => SeedLibraryInformation.fromJsonFactory,
    );

    return _seedLibraryInformationGet();
  }

  ///Get Seed Library Information
  @Get(path: '/seed_library/information')
  Future<chopper.Response<SeedLibraryInformation>> _seedLibraryInformationGet();

  ///Update Seed Library Information
  Future<chopper.Response> seedLibraryInformationPatch({
    required SeedLibraryInformation? body,
  }) {
    return _seedLibraryInformationPatch(body: body);
  }

  ///Update Seed Library Information
  @Patch(path: '/seed_library/information', optionalBody: true)
  Future<chopper.Response> _seedLibraryInformationPatch({
    @Body() required SeedLibraryInformation? body,
  });

  ///Read Advertisers
  Future<chopper.Response<List<AdvertiserComplete>>> advertAdvertisersGet() {
    generatedMapping.putIfAbsent(
      AdvertiserComplete,
      () => AdvertiserComplete.fromJsonFactory,
    );

    return _advertAdvertisersGet();
  }

  ///Read Advertisers
  @Get(path: '/advert/advertisers')
  Future<chopper.Response<List<AdvertiserComplete>>> _advertAdvertisersGet();

  ///Create Advertiser
  Future<chopper.Response<AdvertiserComplete>> advertAdvertisersPost({
    required AdvertiserBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AdvertiserComplete,
      () => AdvertiserComplete.fromJsonFactory,
    );

    return _advertAdvertisersPost(body: body);
  }

  ///Create Advertiser
  @Post(path: '/advert/advertisers', optionalBody: true)
  Future<chopper.Response<AdvertiserComplete>> _advertAdvertisersPost({
    @Body() required AdvertiserBase? body,
  });

  ///Delete Advertiser
  ///@param advertiser_id
  Future<chopper.Response> advertAdvertisersAdvertiserIdDelete({
    required String? advertiserId,
  }) {
    return _advertAdvertisersAdvertiserIdDelete(advertiserId: advertiserId);
  }

  ///Delete Advertiser
  ///@param advertiser_id
  @Delete(path: '/advert/advertisers/{advertiser_id}')
  Future<chopper.Response> _advertAdvertisersAdvertiserIdDelete({
    @Path('advertiser_id') required String? advertiserId,
  });

  ///Update Advertiser
  ///@param advertiser_id
  Future<chopper.Response> advertAdvertisersAdvertiserIdPatch({
    required String? advertiserId,
    required AdvertiserUpdate? body,
  }) {
    return _advertAdvertisersAdvertiserIdPatch(
      advertiserId: advertiserId,
      body: body,
    );
  }

  ///Update Advertiser
  ///@param advertiser_id
  @Patch(path: '/advert/advertisers/{advertiser_id}', optionalBody: true)
  Future<chopper.Response> _advertAdvertisersAdvertiserIdPatch({
    @Path('advertiser_id') required String? advertiserId,
    @Body() required AdvertiserUpdate? body,
  });

  ///Get Current User Advertisers
  Future<chopper.Response<List<AdvertiserComplete>>> advertMeAdvertisersGet() {
    generatedMapping.putIfAbsent(
      AdvertiserComplete,
      () => AdvertiserComplete.fromJsonFactory,
    );

    return _advertMeAdvertisersGet();
  }

  ///Get Current User Advertisers
  @Get(path: '/advert/me/advertisers')
  Future<chopper.Response<List<AdvertiserComplete>>> _advertMeAdvertisersGet();

  ///Read Adverts
  ///@param advertisers
  Future<chopper.Response<List<AdvertReturnComplete>>> advertAdvertsGet({
    List<String>? advertisers,
  }) {
    generatedMapping.putIfAbsent(
      AdvertReturnComplete,
      () => AdvertReturnComplete.fromJsonFactory,
    );

    return _advertAdvertsGet(advertisers: advertisers);
  }

  ///Read Adverts
  ///@param advertisers
  @Get(path: '/advert/adverts')
  Future<chopper.Response<List<AdvertReturnComplete>>> _advertAdvertsGet({
    @Query('advertisers') List<String>? advertisers,
  });

  ///Create Advert
  Future<chopper.Response<AdvertReturnComplete>> advertAdvertsPost({
    required AdvertBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AdvertReturnComplete,
      () => AdvertReturnComplete.fromJsonFactory,
    );

    return _advertAdvertsPost(body: body);
  }

  ///Create Advert
  @Post(path: '/advert/adverts', optionalBody: true)
  Future<chopper.Response<AdvertReturnComplete>> _advertAdvertsPost({
    @Body() required AdvertBase? body,
  });

  ///Read Advert
  ///@param advert_id
  Future<chopper.Response<AdvertReturnComplete>> advertAdvertsAdvertIdGet({
    required String? advertId,
  }) {
    generatedMapping.putIfAbsent(
      AdvertReturnComplete,
      () => AdvertReturnComplete.fromJsonFactory,
    );

    return _advertAdvertsAdvertIdGet(advertId: advertId);
  }

  ///Read Advert
  ///@param advert_id
  @Get(path: '/advert/adverts/{advert_id}')
  Future<chopper.Response<AdvertReturnComplete>> _advertAdvertsAdvertIdGet({
    @Path('advert_id') required String? advertId,
  });

  ///Update Advert
  ///@param advert_id
  Future<chopper.Response> advertAdvertsAdvertIdPatch({
    required String? advertId,
    required AdvertUpdate? body,
  }) {
    return _advertAdvertsAdvertIdPatch(advertId: advertId, body: body);
  }

  ///Update Advert
  ///@param advert_id
  @Patch(path: '/advert/adverts/{advert_id}', optionalBody: true)
  Future<chopper.Response> _advertAdvertsAdvertIdPatch({
    @Path('advert_id') required String? advertId,
    @Body() required AdvertUpdate? body,
  });

  ///Delete Advert
  ///@param advert_id
  Future<chopper.Response> advertAdvertsAdvertIdDelete({
    required String? advertId,
  }) {
    return _advertAdvertsAdvertIdDelete(advertId: advertId);
  }

  ///Delete Advert
  ///@param advert_id
  @Delete(path: '/advert/adverts/{advert_id}')
  Future<chopper.Response> _advertAdvertsAdvertIdDelete({
    @Path('advert_id') required String? advertId,
  });

  ///Read Advert Image
  ///@param advert_id
  Future<chopper.Response> advertAdvertsAdvertIdPictureGet({
    required String? advertId,
  }) {
    return _advertAdvertsAdvertIdPictureGet(advertId: advertId);
  }

  ///Read Advert Image
  ///@param advert_id
  @Get(path: '/advert/adverts/{advert_id}/picture')
  Future<chopper.Response> _advertAdvertsAdvertIdPictureGet({
    @Path('advert_id') required String? advertId,
  });

  ///Create Advert Image
  ///@param advert_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  advertAdvertsAdvertIdPicturePost({
    required String? advertId,
    required MultipartFile image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _advertAdvertsAdvertIdPicturePost(advertId: advertId, image: image);
  }

  ///Create Advert Image
  ///@param advert_id
  @Post(path: '/advert/adverts/{advert_id}/picture', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _advertAdvertsAdvertIdPicturePost({
    @Path('advert_id') required String? advertId,
    @PartFile('image') required MultipartFile image,
  });

  ///Get Sections
  Future<chopper.Response<List<SectionComplete>>> campaignSectionsGet() {
    generatedMapping.putIfAbsent(
      SectionComplete,
      () => SectionComplete.fromJsonFactory,
    );

    return _campaignSectionsGet();
  }

  ///Get Sections
  @Get(path: '/campaign/sections')
  Future<chopper.Response<List<SectionComplete>>> _campaignSectionsGet();

  ///Add Section
  Future<chopper.Response<SectionComplete>> campaignSectionsPost({
    required SectionBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SectionComplete,
      () => SectionComplete.fromJsonFactory,
    );

    return _campaignSectionsPost(body: body);
  }

  ///Add Section
  @Post(path: '/campaign/sections', optionalBody: true)
  Future<chopper.Response<SectionComplete>> _campaignSectionsPost({
    @Body() required SectionBase? body,
  });

  ///Delete Section
  ///@param section_id
  Future<chopper.Response> campaignSectionsSectionIdDelete({
    required String? sectionId,
  }) {
    return _campaignSectionsSectionIdDelete(sectionId: sectionId);
  }

  ///Delete Section
  ///@param section_id
  @Delete(path: '/campaign/sections/{section_id}')
  Future<chopper.Response> _campaignSectionsSectionIdDelete({
    @Path('section_id') required String? sectionId,
  });

  ///Get Lists
  Future<chopper.Response<List<ListReturn>>> campaignListsGet() {
    generatedMapping.putIfAbsent(ListReturn, () => ListReturn.fromJsonFactory);

    return _campaignListsGet();
  }

  ///Get Lists
  @Get(path: '/campaign/lists')
  Future<chopper.Response<List<ListReturn>>> _campaignListsGet();

  ///Add List
  Future<chopper.Response<ListReturn>> campaignListsPost({
    required ListBase? body,
  }) {
    generatedMapping.putIfAbsent(ListReturn, () => ListReturn.fromJsonFactory);

    return _campaignListsPost(body: body);
  }

  ///Add List
  @Post(path: '/campaign/lists', optionalBody: true)
  Future<chopper.Response<ListReturn>> _campaignListsPost({
    @Body() required ListBase? body,
  });

  ///Delete List
  ///@param list_id
  Future<chopper.Response> campaignListsListIdDelete({
    required String? listId,
  }) {
    return _campaignListsListIdDelete(listId: listId);
  }

  ///Delete List
  ///@param list_id
  @Delete(path: '/campaign/lists/{list_id}')
  Future<chopper.Response> _campaignListsListIdDelete({
    @Path('list_id') required String? listId,
  });

  ///Update List
  ///@param list_id
  Future<chopper.Response> campaignListsListIdPatch({
    required String? listId,
    required ListEdit? body,
  }) {
    return _campaignListsListIdPatch(listId: listId, body: body);
  }

  ///Update List
  ///@param list_id
  @Patch(path: '/campaign/lists/{list_id}', optionalBody: true)
  Future<chopper.Response> _campaignListsListIdPatch({
    @Path('list_id') required String? listId,
    @Body() required ListEdit? body,
  });

  ///Delete Lists By Type
  ///@param list_type
  Future<chopper.Response> campaignListsDelete({Object? listType}) {
    return _campaignListsDelete(listType: listType);
  }

  ///Delete Lists By Type
  ///@param list_type
  @Delete(path: '/campaign/lists/')
  Future<chopper.Response> _campaignListsDelete({
    @Query('list_type') Object? listType,
  });

  ///Get Voters
  Future<chopper.Response<List<VoterGroup>>> campaignVotersGet() {
    generatedMapping.putIfAbsent(VoterGroup, () => VoterGroup.fromJsonFactory);

    return _campaignVotersGet();
  }

  ///Get Voters
  @Get(path: '/campaign/voters')
  Future<chopper.Response<List<VoterGroup>>> _campaignVotersGet();

  ///Add Voter
  Future<chopper.Response<VoterGroup>> campaignVotersPost({
    required VoterGroup? body,
  }) {
    generatedMapping.putIfAbsent(VoterGroup, () => VoterGroup.fromJsonFactory);

    return _campaignVotersPost(body: body);
  }

  ///Add Voter
  @Post(path: '/campaign/voters', optionalBody: true)
  Future<chopper.Response<VoterGroup>> _campaignVotersPost({
    @Body() required VoterGroup? body,
  });

  ///Delete Voters
  Future<chopper.Response> campaignVotersDelete() {
    return _campaignVotersDelete();
  }

  ///Delete Voters
  @Delete(path: '/campaign/voters')
  Future<chopper.Response> _campaignVotersDelete();

  ///Delete Voter By Group Id
  ///@param group_id
  Future<chopper.Response> campaignVotersGroupIdDelete({
    required String? groupId,
  }) {
    return _campaignVotersGroupIdDelete(groupId: groupId);
  }

  ///Delete Voter By Group Id
  ///@param group_id
  @Delete(path: '/campaign/voters/{group_id}')
  Future<chopper.Response> _campaignVotersGroupIdDelete({
    @Path('group_id') required String? groupId,
  });

  ///Open Vote
  Future<chopper.Response> campaignStatusOpenPost() {
    return _campaignStatusOpenPost();
  }

  ///Open Vote
  @Post(path: '/campaign/status/open', optionalBody: true)
  Future<chopper.Response> _campaignStatusOpenPost();

  ///Close Vote
  Future<chopper.Response> campaignStatusClosePost() {
    return _campaignStatusClosePost();
  }

  ///Close Vote
  @Post(path: '/campaign/status/close', optionalBody: true)
  Future<chopper.Response> _campaignStatusClosePost();

  ///Count Voting
  Future<chopper.Response> campaignStatusCountingPost() {
    return _campaignStatusCountingPost();
  }

  ///Count Voting
  @Post(path: '/campaign/status/counting', optionalBody: true)
  Future<chopper.Response> _campaignStatusCountingPost();

  ///Publish Vote
  Future<chopper.Response> campaignStatusPublishedPost() {
    return _campaignStatusPublishedPost();
  }

  ///Publish Vote
  @Post(path: '/campaign/status/published', optionalBody: true)
  Future<chopper.Response> _campaignStatusPublishedPost();

  ///Reset Vote
  Future<chopper.Response> campaignStatusResetPost() {
    return _campaignStatusResetPost();
  }

  ///Reset Vote
  @Post(path: '/campaign/status/reset', optionalBody: true)
  Future<chopper.Response> _campaignStatusResetPost();

  ///Get Sections Already Voted
  Future<chopper.Response<List<String>>> campaignVotesGet() {
    return _campaignVotesGet();
  }

  ///Get Sections Already Voted
  @Get(path: '/campaign/votes')
  Future<chopper.Response<List<String>>> _campaignVotesGet();

  ///Vote
  Future<chopper.Response> campaignVotesPost({required VoteBase? body}) {
    return _campaignVotesPost(body: body);
  }

  ///Vote
  @Post(path: '/campaign/votes', optionalBody: true)
  Future<chopper.Response> _campaignVotesPost({
    @Body() required VoteBase? body,
  });

  ///Get Results
  Future<chopper.Response<List<AppModulesCampaignSchemasCampaignResult>>>
  campaignResultsGet() {
    generatedMapping.putIfAbsent(
      AppModulesCampaignSchemasCampaignResult,
      () => AppModulesCampaignSchemasCampaignResult.fromJsonFactory,
    );

    return _campaignResultsGet();
  }

  ///Get Results
  @Get(path: '/campaign/results')
  Future<chopper.Response<List<AppModulesCampaignSchemasCampaignResult>>>
  _campaignResultsGet();

  ///Get Status Vote
  Future<chopper.Response<VoteStatus>> campaignStatusGet() {
    generatedMapping.putIfAbsent(VoteStatus, () => VoteStatus.fromJsonFactory);

    return _campaignStatusGet();
  }

  ///Get Status Vote
  @Get(path: '/campaign/status')
  Future<chopper.Response<VoteStatus>> _campaignStatusGet();

  ///Get Stats For Section
  ///@param section_id
  Future<chopper.Response<VoteStats>> campaignStatsSectionIdGet({
    required String? sectionId,
  }) {
    generatedMapping.putIfAbsent(VoteStats, () => VoteStats.fromJsonFactory);

    return _campaignStatsSectionIdGet(sectionId: sectionId);
  }

  ///Get Stats For Section
  ///@param section_id
  @Get(path: '/campaign/stats/{section_id}')
  Future<chopper.Response<VoteStats>> _campaignStatsSectionIdGet({
    @Path('section_id') required String? sectionId,
  });

  ///Create Campaigns Logo
  ///@param list_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  campaignListsListIdLogoPost({
    required String? listId,
    required MultipartFile image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _campaignListsListIdLogoPost(listId: listId, image: image);
  }

  ///Create Campaigns Logo
  ///@param list_id
  @Post(path: '/campaign/lists/{list_id}/logo', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _campaignListsListIdLogoPost({
    @Path('list_id') required String? listId,
    @PartFile('image') required MultipartFile image,
  });

  ///Read Campaigns Logo
  ///@param list_id
  Future<chopper.Response> campaignListsListIdLogoGet({
    required String? listId,
  }) {
    return _campaignListsListIdLogoGet(listId: listId);
  }

  ///Read Campaigns Logo
  ///@param list_id
  @Get(path: '/campaign/lists/{list_id}/logo')
  Future<chopper.Response> _campaignListsListIdLogoGet({
    @Path('list_id') required String? listId,
  });

  ///Get Recommendation
  Future<chopper.Response<List<Recommendation>>>
  recommendationRecommendationsGet() {
    generatedMapping.putIfAbsent(
      Recommendation,
      () => Recommendation.fromJsonFactory,
    );

    return _recommendationRecommendationsGet();
  }

  ///Get Recommendation
  @Get(path: '/recommendation/recommendations')
  Future<chopper.Response<List<Recommendation>>>
  _recommendationRecommendationsGet();

  ///Create Recommendation
  Future<chopper.Response<Recommendation>> recommendationRecommendationsPost({
    required RecommendationBase? body,
  }) {
    generatedMapping.putIfAbsent(
      Recommendation,
      () => Recommendation.fromJsonFactory,
    );

    return _recommendationRecommendationsPost(body: body);
  }

  ///Create Recommendation
  @Post(path: '/recommendation/recommendations', optionalBody: true)
  Future<chopper.Response<Recommendation>> _recommendationRecommendationsPost({
    @Body() required RecommendationBase? body,
  });

  ///Edit Recommendation
  ///@param recommendation_id
  Future<chopper.Response> recommendationRecommendationsRecommendationIdPatch({
    required String? recommendationId,
    required RecommendationEdit? body,
  }) {
    return _recommendationRecommendationsRecommendationIdPatch(
      recommendationId: recommendationId,
      body: body,
    );
  }

  ///Edit Recommendation
  ///@param recommendation_id
  @Patch(
    path: '/recommendation/recommendations/{recommendation_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _recommendationRecommendationsRecommendationIdPatch({
    @Path('recommendation_id') required String? recommendationId,
    @Body() required RecommendationEdit? body,
  });

  ///Delete Recommendation
  ///@param recommendation_id
  Future<chopper.Response> recommendationRecommendationsRecommendationIdDelete({
    required String? recommendationId,
  }) {
    return _recommendationRecommendationsRecommendationIdDelete(
      recommendationId: recommendationId,
    );
  }

  ///Delete Recommendation
  ///@param recommendation_id
  @Delete(path: '/recommendation/recommendations/{recommendation_id}')
  Future<chopper.Response>
  _recommendationRecommendationsRecommendationIdDelete({
    @Path('recommendation_id') required String? recommendationId,
  });

  ///Read Recommendation Image
  ///@param recommendation_id
  Future<chopper.Response>
  recommendationRecommendationsRecommendationIdPictureGet({
    required String? recommendationId,
  }) {
    return _recommendationRecommendationsRecommendationIdPictureGet(
      recommendationId: recommendationId,
    );
  }

  ///Read Recommendation Image
  ///@param recommendation_id
  @Get(path: '/recommendation/recommendations/{recommendation_id}/picture')
  Future<chopper.Response>
  _recommendationRecommendationsRecommendationIdPictureGet({
    @Path('recommendation_id') required String? recommendationId,
  });

  ///Create Recommendation Image
  ///@param recommendation_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  recommendationRecommendationsRecommendationIdPicturePost({
    required String? recommendationId,
    required MultipartFile image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _recommendationRecommendationsRecommendationIdPicturePost(
      recommendationId: recommendationId,
      image: image,
    );
  }

  ///Create Recommendation Image
  ///@param recommendation_id
  @Post(
    path: '/recommendation/recommendations/{recommendation_id}/picture',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _recommendationRecommendationsRecommendationIdPicturePost({
    @Path('recommendation_id') required String? recommendationId,
    @PartFile('image') required MultipartFile image,
  });

  ///Read Loaners
  Future<chopper.Response<List<Loaner>>> loansLoanersGet() {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansLoanersGet();
  }

  ///Read Loaners
  @Get(path: '/loans/loaners/')
  Future<chopper.Response<List<Loaner>>> _loansLoanersGet();

  ///Create Loaner
  Future<chopper.Response<Loaner>> loansLoanersPost({
    required LoanerBase? body,
  }) {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansLoanersPost(body: body);
  }

  ///Create Loaner
  @Post(path: '/loans/loaners/', optionalBody: true)
  Future<chopper.Response<Loaner>> _loansLoanersPost({
    @Body() required LoanerBase? body,
  });

  ///Delete Loaner
  ///@param loaner_id
  Future<chopper.Response> loansLoanersLoanerIdDelete({
    required String? loanerId,
  }) {
    return _loansLoanersLoanerIdDelete(loanerId: loanerId);
  }

  ///Delete Loaner
  ///@param loaner_id
  @Delete(path: '/loans/loaners/{loaner_id}')
  Future<chopper.Response> _loansLoanersLoanerIdDelete({
    @Path('loaner_id') required String? loanerId,
  });

  ///Update Loaner
  ///@param loaner_id
  Future<chopper.Response> loansLoanersLoanerIdPatch({
    required String? loanerId,
    required LoanerUpdate? body,
  }) {
    return _loansLoanersLoanerIdPatch(loanerId: loanerId, body: body);
  }

  ///Update Loaner
  ///@param loaner_id
  @Patch(path: '/loans/loaners/{loaner_id}', optionalBody: true)
  Future<chopper.Response> _loansLoanersLoanerIdPatch({
    @Path('loaner_id') required String? loanerId,
    @Body() required LoanerUpdate? body,
  });

  ///Get Loans By Loaner
  ///@param loaner_id
  ///@param returned
  Future<chopper.Response<List<Loan>>> loansLoanersLoanerIdLoansGet({
    required String? loanerId,
    bool? returned,
  }) {
    generatedMapping.putIfAbsent(Loan, () => Loan.fromJsonFactory);

    return _loansLoanersLoanerIdLoansGet(
      loanerId: loanerId,
      returned: returned,
    );
  }

  ///Get Loans By Loaner
  ///@param loaner_id
  ///@param returned
  @Get(path: '/loans/loaners/{loaner_id}/loans')
  Future<chopper.Response<List<Loan>>> _loansLoanersLoanerIdLoansGet({
    @Path('loaner_id') required String? loanerId,
    @Query('returned') bool? returned,
  });

  ///Get Items By Loaner
  ///@param loaner_id
  Future<chopper.Response<List<Item>>> loansLoanersLoanerIdItemsGet({
    required String? loanerId,
  }) {
    generatedMapping.putIfAbsent(Item, () => Item.fromJsonFactory);

    return _loansLoanersLoanerIdItemsGet(loanerId: loanerId);
  }

  ///Get Items By Loaner
  ///@param loaner_id
  @Get(path: '/loans/loaners/{loaner_id}/items')
  Future<chopper.Response<List<Item>>> _loansLoanersLoanerIdItemsGet({
    @Path('loaner_id') required String? loanerId,
  });

  ///Create Items For Loaner
  ///@param loaner_id
  Future<chopper.Response<Item>> loansLoanersLoanerIdItemsPost({
    required String? loanerId,
    required ItemBase? body,
  }) {
    generatedMapping.putIfAbsent(Item, () => Item.fromJsonFactory);

    return _loansLoanersLoanerIdItemsPost(loanerId: loanerId, body: body);
  }

  ///Create Items For Loaner
  ///@param loaner_id
  @Post(path: '/loans/loaners/{loaner_id}/items', optionalBody: true)
  Future<chopper.Response<Item>> _loansLoanersLoanerIdItemsPost({
    @Path('loaner_id') required String? loanerId,
    @Body() required ItemBase? body,
  });

  ///Update Items For Loaner
  ///@param loaner_id
  ///@param item_id
  Future<chopper.Response> loansLoanersLoanerIdItemsItemIdPatch({
    required String? loanerId,
    required String? itemId,
    required ItemUpdate? body,
  }) {
    return _loansLoanersLoanerIdItemsItemIdPatch(
      loanerId: loanerId,
      itemId: itemId,
      body: body,
    );
  }

  ///Update Items For Loaner
  ///@param loaner_id
  ///@param item_id
  @Patch(path: '/loans/loaners/{loaner_id}/items/{item_id}', optionalBody: true)
  Future<chopper.Response> _loansLoanersLoanerIdItemsItemIdPatch({
    @Path('loaner_id') required String? loanerId,
    @Path('item_id') required String? itemId,
    @Body() required ItemUpdate? body,
  });

  ///Delete Loaner Item
  ///@param loaner_id
  ///@param item_id
  Future<chopper.Response> loansLoanersLoanerIdItemsItemIdDelete({
    required String? loanerId,
    required String? itemId,
  }) {
    return _loansLoanersLoanerIdItemsItemIdDelete(
      loanerId: loanerId,
      itemId: itemId,
    );
  }

  ///Delete Loaner Item
  ///@param loaner_id
  ///@param item_id
  @Delete(path: '/loans/loaners/{loaner_id}/items/{item_id}')
  Future<chopper.Response> _loansLoanersLoanerIdItemsItemIdDelete({
    @Path('loaner_id') required String? loanerId,
    @Path('item_id') required String? itemId,
  });

  ///Get Current User Loans
  ///@param returned
  Future<chopper.Response<List<Loan>>> loansUsersMeGet({bool? returned}) {
    generatedMapping.putIfAbsent(Loan, () => Loan.fromJsonFactory);

    return _loansUsersMeGet(returned: returned);
  }

  ///Get Current User Loans
  ///@param returned
  @Get(path: '/loans/users/me')
  Future<chopper.Response<List<Loan>>> _loansUsersMeGet({
    @Query('returned') bool? returned,
  });

  ///Get Current User Loaners
  Future<chopper.Response<List<Loaner>>> loansUsersMeLoanersGet() {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansUsersMeLoanersGet();
  }

  ///Get Current User Loaners
  @Get(path: '/loans/users/me/loaners')
  Future<chopper.Response<List<Loaner>>> _loansUsersMeLoanersGet();

  ///Create Loan
  Future<chopper.Response<Loan>> loansPost({required LoanCreation? body}) {
    generatedMapping.putIfAbsent(Loan, () => Loan.fromJsonFactory);

    return _loansPost(body: body);
  }

  ///Create Loan
  @Post(path: '/loans/', optionalBody: true)
  Future<chopper.Response<Loan>> _loansPost({
    @Body() required LoanCreation? body,
  });

  ///Update Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdPatch({
    required String? loanId,
    required LoanUpdate? body,
  }) {
    return _loansLoanIdPatch(loanId: loanId, body: body);
  }

  ///Update Loan
  ///@param loan_id
  @Patch(path: '/loans/{loan_id}', optionalBody: true)
  Future<chopper.Response> _loansLoanIdPatch({
    @Path('loan_id') required String? loanId,
    @Body() required LoanUpdate? body,
  });

  ///Delete Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdDelete({required String? loanId}) {
    return _loansLoanIdDelete(loanId: loanId);
  }

  ///Delete Loan
  ///@param loan_id
  @Delete(path: '/loans/{loan_id}')
  Future<chopper.Response> _loansLoanIdDelete({
    @Path('loan_id') required String? loanId,
  });

  ///Return Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdReturnPost({required String? loanId}) {
    return _loansLoanIdReturnPost(loanId: loanId);
  }

  ///Return Loan
  ///@param loan_id
  @Post(path: '/loans/{loan_id}/return', optionalBody: true)
  Future<chopper.Response> _loansLoanIdReturnPost({
    @Path('loan_id') required String? loanId,
  });

  ///Extend Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdExtendPost({
    required String? loanId,
    required LoanExtend? body,
  }) {
    return _loansLoanIdExtendPost(loanId: loanId, body: body);
  }

  ///Extend Loan
  ///@param loan_id
  @Post(path: '/loans/{loan_id}/extend', optionalBody: true)
  Future<chopper.Response> _loansLoanIdExtendPost({
    @Path('loan_id') required String? loanId,
    @Body() required LoanExtend? body,
  });

  ///Get Managers
  Future<chopper.Response<List<Manager>>> bookingManagersGet() {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersGet();
  }

  ///Get Managers
  @Get(path: '/booking/managers')
  Future<chopper.Response<List<Manager>>> _bookingManagersGet();

  ///Create Manager
  Future<chopper.Response<Manager>> bookingManagersPost({
    required ManagerBase? body,
  }) {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersPost(body: body);
  }

  ///Create Manager
  @Post(path: '/booking/managers', optionalBody: true)
  Future<chopper.Response<Manager>> _bookingManagersPost({
    @Body() required ManagerBase? body,
  });

  ///Update Manager
  ///@param manager_id
  Future<chopper.Response> bookingManagersManagerIdPatch({
    required String? managerId,
    required ManagerUpdate? body,
  }) {
    return _bookingManagersManagerIdPatch(managerId: managerId, body: body);
  }

  ///Update Manager
  ///@param manager_id
  @Patch(path: '/booking/managers/{manager_id}', optionalBody: true)
  Future<chopper.Response> _bookingManagersManagerIdPatch({
    @Path('manager_id') required String? managerId,
    @Body() required ManagerUpdate? body,
  });

  ///Delete Manager
  ///@param manager_id
  Future<chopper.Response> bookingManagersManagerIdDelete({
    required String? managerId,
  }) {
    return _bookingManagersManagerIdDelete(managerId: managerId);
  }

  ///Delete Manager
  ///@param manager_id
  @Delete(path: '/booking/managers/{manager_id}')
  Future<chopper.Response> _bookingManagersManagerIdDelete({
    @Path('manager_id') required String? managerId,
  });

  ///Get Current User Managers
  Future<chopper.Response<List<Manager>>> bookingManagersUsersMeGet() {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersUsersMeGet();
  }

  ///Get Current User Managers
  @Get(path: '/booking/managers/users/me')
  Future<chopper.Response<List<Manager>>> _bookingManagersUsersMeGet();

  ///Get Bookings For Manager
  Future<chopper.Response<List<BookingReturnApplicant>>>
  bookingBookingsUsersMeManageGet() {
    generatedMapping.putIfAbsent(
      BookingReturnApplicant,
      () => BookingReturnApplicant.fromJsonFactory,
    );

    return _bookingBookingsUsersMeManageGet();
  }

  ///Get Bookings For Manager
  @Get(path: '/booking/bookings/users/me/manage')
  Future<chopper.Response<List<BookingReturnApplicant>>>
  _bookingBookingsUsersMeManageGet();

  ///Get Confirmed Bookings For Manager
  Future<chopper.Response<List<BookingReturnApplicant>>>
  bookingBookingsConfirmedUsersMeManageGet() {
    generatedMapping.putIfAbsent(
      BookingReturnApplicant,
      () => BookingReturnApplicant.fromJsonFactory,
    );

    return _bookingBookingsConfirmedUsersMeManageGet();
  }

  ///Get Confirmed Bookings For Manager
  @Get(path: '/booking/bookings/confirmed/users/me/manage')
  Future<chopper.Response<List<BookingReturnApplicant>>>
  _bookingBookingsConfirmedUsersMeManageGet();

  ///Get Confirmed Bookings
  Future<chopper.Response<List<BookingReturnSimpleApplicant>>>
  bookingBookingsConfirmedGet() {
    generatedMapping.putIfAbsent(
      BookingReturnSimpleApplicant,
      () => BookingReturnSimpleApplicant.fromJsonFactory,
    );

    return _bookingBookingsConfirmedGet();
  }

  ///Get Confirmed Bookings
  @Get(path: '/booking/bookings/confirmed')
  Future<chopper.Response<List<BookingReturnSimpleApplicant>>>
  _bookingBookingsConfirmedGet();

  ///Get Applicant Bookings
  Future<chopper.Response<List<BookingReturn>>> bookingBookingsUsersMeGet() {
    generatedMapping.putIfAbsent(
      BookingReturn,
      () => BookingReturn.fromJsonFactory,
    );

    return _bookingBookingsUsersMeGet();
  }

  ///Get Applicant Bookings
  @Get(path: '/booking/bookings/users/me')
  Future<chopper.Response<List<BookingReturn>>> _bookingBookingsUsersMeGet();

  ///Create Booking
  Future<chopper.Response<BookingReturn>> bookingBookingsPost({
    required BookingBase? body,
  }) {
    generatedMapping.putIfAbsent(
      BookingReturn,
      () => BookingReturn.fromJsonFactory,
    );

    return _bookingBookingsPost(body: body);
  }

  ///Create Booking
  @Post(path: '/booking/bookings', optionalBody: true)
  Future<chopper.Response<BookingReturn>> _bookingBookingsPost({
    @Body() required BookingBase? body,
  });

  ///Edit Booking
  ///@param booking_id
  Future<chopper.Response> bookingBookingsBookingIdPatch({
    required String? bookingId,
    required BookingEdit? body,
  }) {
    return _bookingBookingsBookingIdPatch(bookingId: bookingId, body: body);
  }

  ///Edit Booking
  ///@param booking_id
  @Patch(path: '/booking/bookings/{booking_id}', optionalBody: true)
  Future<chopper.Response> _bookingBookingsBookingIdPatch({
    @Path('booking_id') required String? bookingId,
    @Body() required BookingEdit? body,
  });

  ///Delete Booking
  ///@param booking_id
  Future<chopper.Response> bookingBookingsBookingIdDelete({
    required String? bookingId,
  }) {
    return _bookingBookingsBookingIdDelete(bookingId: bookingId);
  }

  ///Delete Booking
  ///@param booking_id
  @Delete(path: '/booking/bookings/{booking_id}')
  Future<chopper.Response> _bookingBookingsBookingIdDelete({
    @Path('booking_id') required String? bookingId,
  });

  ///Confirm Booking
  ///@param booking_id
  ///@param decision
  Future<chopper.Response> bookingBookingsBookingIdReplyDecisionPatch({
    required String? bookingId,
    required enums.Decision? decision,
  }) {
    return _bookingBookingsBookingIdReplyDecisionPatch(
      bookingId: bookingId,
      decision: decision?.value?.toString(),
    );
  }

  ///Confirm Booking
  ///@param booking_id
  ///@param decision
  @Patch(
    path: '/booking/bookings/{booking_id}/reply/{decision}',
    optionalBody: true,
  )
  Future<chopper.Response> _bookingBookingsBookingIdReplyDecisionPatch({
    @Path('booking_id') required String? bookingId,
    @Path('decision') required String? decision,
  });

  ///Get Rooms
  Future<chopper.Response<List<RoomComplete>>> bookingRoomsGet() {
    generatedMapping.putIfAbsent(
      RoomComplete,
      () => RoomComplete.fromJsonFactory,
    );

    return _bookingRoomsGet();
  }

  ///Get Rooms
  @Get(path: '/booking/rooms')
  Future<chopper.Response<List<RoomComplete>>> _bookingRoomsGet();

  ///Create Room
  Future<chopper.Response<RoomComplete>> bookingRoomsPost({
    required RoomBase? body,
  }) {
    generatedMapping.putIfAbsent(
      RoomComplete,
      () => RoomComplete.fromJsonFactory,
    );

    return _bookingRoomsPost(body: body);
  }

  ///Create Room
  @Post(path: '/booking/rooms', optionalBody: true)
  Future<chopper.Response<RoomComplete>> _bookingRoomsPost({
    @Body() required RoomBase? body,
  });

  ///Edit Room
  ///@param room_id
  Future<chopper.Response> bookingRoomsRoomIdPatch({
    required String? roomId,
    required RoomBase? body,
  }) {
    return _bookingRoomsRoomIdPatch(roomId: roomId, body: body);
  }

  ///Edit Room
  ///@param room_id
  @Patch(path: '/booking/rooms/{room_id}', optionalBody: true)
  Future<chopper.Response> _bookingRoomsRoomIdPatch({
    @Path('room_id') required String? roomId,
    @Body() required RoomBase? body,
  });

  ///Delete Room
  ///@param room_id
  Future<chopper.Response> bookingRoomsRoomIdDelete({required String? roomId}) {
    return _bookingRoomsRoomIdDelete(roomId: roomId);
  }

  ///Delete Room
  ///@param room_id
  @Delete(path: '/booking/rooms/{room_id}')
  Future<chopper.Response> _bookingRoomsRoomIdDelete({
    @Path('room_id') required String? roomId,
  });
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
