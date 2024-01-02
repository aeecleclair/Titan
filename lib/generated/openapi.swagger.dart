// ignore_for_file: type=lint

import 'openapi.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
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
    Iterable<dynamic>? interceptors,
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
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$Openapi(newClient);
  }

  ///Send Email Backgroundtasks
  ///@param email
  ///@param subject
  ///@param content
  Future<chopper.Response> sendEmailPost({
    required String? email,
    required String? subject,
    required String? content,
  }) {
    return _sendEmailPost(email: email, subject: subject, content: content);
  }

  ///Send Email Backgroundtasks
  ///@param email
  ///@param subject
  ///@param content
  @Post(
    path: '/send-email/',
    optionalBody: true,
  )
  Future<chopper.Response> _sendEmailPost({
    @Query('email') required String? email,
    @Query('subject') required String? subject,
    @Query('content') required String? content,
  });

  ///Read Advertisers
  Future<chopper.Response<List<AdvertiserComplete>>> advertAdvertisersGet() {
    generatedMapping.putIfAbsent(
        AdvertiserComplete, () => AdvertiserComplete.fromJsonFactory);

    return _advertAdvertisersGet();
  }

  ///Read Advertisers
  @Get(path: '/advert/advertisers')
  Future<chopper.Response<List<AdvertiserComplete>>> _advertAdvertisersGet();

  ///Create Advertiser
  Future<chopper.Response<AdvertiserComplete>> advertAdvertisersPost(
      {required AdvertiserBase? body}) {
    generatedMapping.putIfAbsent(
        AdvertiserComplete, () => AdvertiserComplete.fromJsonFactory);

    return _advertAdvertisersPost(body: body);
  }

  ///Create Advertiser
  @Post(
    path: '/advert/advertisers',
    optionalBody: true,
  )
  Future<chopper.Response<AdvertiserComplete>> _advertAdvertisersPost(
      {@Body() required AdvertiserBase? body});

  ///Delete Advertiser
  ///@param advertiser_id
  Future<chopper.Response> advertAdvertisersAdvertiserIdDelete(
      {required String? advertiserId}) {
    return _advertAdvertisersAdvertiserIdDelete(advertiserId: advertiserId);
  }

  ///Delete Advertiser
  ///@param advertiser_id
  @Delete(path: '/advert/advertisers/{advertiser_id}')
  Future<chopper.Response> _advertAdvertisersAdvertiserIdDelete(
      {@Path('advertiser_id') required String? advertiserId});

  ///Update Advertiser
  ///@param advertiser_id
  Future<chopper.Response> advertAdvertisersAdvertiserIdPatch({
    required String? advertiserId,
    required AdvertiserUpdate? body,
  }) {
    return _advertAdvertisersAdvertiserIdPatch(
        advertiserId: advertiserId, body: body);
  }

  ///Update Advertiser
  ///@param advertiser_id
  @Patch(
    path: '/advert/advertisers/{advertiser_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _advertAdvertisersAdvertiserIdPatch({
    @Path('advertiser_id') required String? advertiserId,
    @Body() required AdvertiserUpdate? body,
  });

  ///Get Current User Advertisers
  Future<chopper.Response<List<AdvertiserComplete>>> advertMeAdvertisersGet() {
    generatedMapping.putIfAbsent(
        AdvertiserComplete, () => AdvertiserComplete.fromJsonFactory);

    return _advertMeAdvertisersGet();
  }

  ///Get Current User Advertisers
  @Get(path: '/advert/me/advertisers')
  Future<chopper.Response<List<AdvertiserComplete>>> _advertMeAdvertisersGet();

  ///Read Adverts
  ///@param advertisers
  Future<chopper.Response<List<AdvertReturnComplete>>> advertAdvertsGet(
      {List<String>? advertisers}) {
    generatedMapping.putIfAbsent(
        AdvertReturnComplete, () => AdvertReturnComplete.fromJsonFactory);

    return _advertAdvertsGet(advertisers: advertisers);
  }

  ///Read Adverts
  ///@param advertisers
  @Get(path: '/advert/adverts')
  Future<chopper.Response<List<AdvertReturnComplete>>> _advertAdvertsGet(
      {@Query('advertisers') List<String>? advertisers});

  ///Create Advert
  Future<chopper.Response<AdvertReturnComplete>> advertAdvertsPost(
      {required AdvertBase? body}) {
    generatedMapping.putIfAbsent(
        AdvertReturnComplete, () => AdvertReturnComplete.fromJsonFactory);

    return _advertAdvertsPost(body: body);
  }

  ///Create Advert
  @Post(
    path: '/advert/adverts',
    optionalBody: true,
  )
  Future<chopper.Response<AdvertReturnComplete>> _advertAdvertsPost(
      {@Body() required AdvertBase? body});

  ///Read Advert
  ///@param advert_id
  Future<chopper.Response<AdvertReturnComplete>> advertAdvertsAdvertIdGet(
      {required String? advertId}) {
    generatedMapping.putIfAbsent(
        AdvertReturnComplete, () => AdvertReturnComplete.fromJsonFactory);

    return _advertAdvertsAdvertIdGet(advertId: advertId);
  }

  ///Read Advert
  ///@param advert_id
  @Get(path: '/advert/adverts/{advert_id}')
  Future<chopper.Response<AdvertReturnComplete>> _advertAdvertsAdvertIdGet(
      {@Path('advert_id') required String? advertId});

  ///Delete Advert
  ///@param advert_id
  Future<chopper.Response> advertAdvertsAdvertIdDelete(
      {required String? advertId}) {
    return _advertAdvertsAdvertIdDelete(advertId: advertId);
  }

  ///Delete Advert
  ///@param advert_id
  @Delete(path: '/advert/adverts/{advert_id}')
  Future<chopper.Response> _advertAdvertsAdvertIdDelete(
      {@Path('advert_id') required String? advertId});

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
  @Patch(
    path: '/advert/adverts/{advert_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _advertAdvertsAdvertIdPatch({
    @Path('advert_id') required String? advertId,
    @Body() required AdvertUpdate? body,
  });

  ///Read Advert Image
  ///@param advert_id
  Future<chopper.Response> advertAdvertsAdvertIdPictureGet(
      {required String? advertId}) {
    return _advertAdvertsAdvertIdPictureGet(advertId: advertId);
  }

  ///Read Advert Image
  ///@param advert_id
  @Get(path: '/advert/adverts/{advert_id}/picture')
  Future<chopper.Response> _advertAdvertsAdvertIdPictureGet(
      {@Path('advert_id') required String? advertId});

  ///Create Advert Image
  ///@param advert_id
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      advertAdvertsAdvertIdPicturePost({
    required String? advertId,
    required BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost body,
  }) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _advertAdvertsAdvertIdPicturePost(advertId: advertId, body: body);
  }

  ///Create Advert Image
  ///@param advert_id
  @Post(
    path: '/advert/adverts/{advert_id}/picture',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _advertAdvertsAdvertIdPicturePost({
    @Path('advert_id') required String? advertId,
    @Part() required BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost body,
  });

  ///Get Products
  Future<chopper.Response<List<ProductComplete>>> amapProductsGet() {
    generatedMapping.putIfAbsent(
        ProductComplete, () => ProductComplete.fromJsonFactory);

    return _amapProductsGet();
  }

  ///Get Products
  @Get(path: '/amap/products')
  Future<chopper.Response<List<ProductComplete>>> _amapProductsGet();

  ///Create Product
  Future<chopper.Response<ProductComplete>> amapProductsPost(
      {required ProductSimple? body}) {
    generatedMapping.putIfAbsent(
        ProductComplete, () => ProductComplete.fromJsonFactory);

    return _amapProductsPost(body: body);
  }

  ///Create Product
  @Post(
    path: '/amap/products',
    optionalBody: true,
  )
  Future<chopper.Response<ProductComplete>> _amapProductsPost(
      {@Body() required ProductSimple? body});

  ///Get Product By Id
  ///@param product_id
  Future<chopper.Response<ProductComplete>> amapProductsProductIdGet(
      {required String? productId}) {
    generatedMapping.putIfAbsent(
        ProductComplete, () => ProductComplete.fromJsonFactory);

    return _amapProductsProductIdGet(productId: productId);
  }

  ///Get Product By Id
  ///@param product_id
  @Get(path: '/amap/products/{product_id}')
  Future<chopper.Response<ProductComplete>> _amapProductsProductIdGet(
      {@Path('product_id') required String? productId});

  ///Delete Product
  ///@param product_id
  Future<chopper.Response> amapProductsProductIdDelete(
      {required String? productId}) {
    return _amapProductsProductIdDelete(productId: productId);
  }

  ///Delete Product
  ///@param product_id
  @Delete(path: '/amap/products/{product_id}')
  Future<chopper.Response> _amapProductsProductIdDelete(
      {@Path('product_id') required String? productId});

  ///Edit Product
  ///@param product_id
  Future<chopper.Response> amapProductsProductIdPatch({
    required String? productId,
    required ProductEdit? body,
  }) {
    return _amapProductsProductIdPatch(productId: productId, body: body);
  }

  ///Edit Product
  ///@param product_id
  @Patch(
    path: '/amap/products/{product_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _amapProductsProductIdPatch({
    @Path('product_id') required String? productId,
    @Body() required ProductEdit? body,
  });

  ///Get Deliveries
  Future<chopper.Response<List<DeliveryReturn>>> amapDeliveriesGet() {
    generatedMapping.putIfAbsent(
        DeliveryReturn, () => DeliveryReturn.fromJsonFactory);

    return _amapDeliveriesGet();
  }

  ///Get Deliveries
  @Get(path: '/amap/deliveries')
  Future<chopper.Response<List<DeliveryReturn>>> _amapDeliveriesGet();

  ///Create Delivery
  Future<chopper.Response<DeliveryReturn>> amapDeliveriesPost(
      {required DeliveryBase? body}) {
    generatedMapping.putIfAbsent(
        DeliveryReturn, () => DeliveryReturn.fromJsonFactory);

    return _amapDeliveriesPost(body: body);
  }

  ///Create Delivery
  @Post(
    path: '/amap/deliveries',
    optionalBody: true,
  )
  Future<chopper.Response<DeliveryReturn>> _amapDeliveriesPost(
      {@Body() required DeliveryBase? body});

  ///Delete Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdDelete(
      {required String? deliveryId}) {
    return _amapDeliveriesDeliveryIdDelete(deliveryId: deliveryId);
  }

  ///Delete Delivery
  ///@param delivery_id
  @Delete(path: '/amap/deliveries/{delivery_id}')
  Future<chopper.Response> _amapDeliveriesDeliveryIdDelete(
      {@Path('delivery_id') required String? deliveryId});

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
  @Patch(
    path: '/amap/deliveries/{delivery_id}',
    optionalBody: true,
  )
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
        deliveryId: deliveryId, body: body);
  }

  ///Add Product To Delivery
  ///@param delivery_id
  @Post(
    path: '/amap/deliveries/{delivery_id}/products',
    optionalBody: true,
  )
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
        deliveryId: deliveryId, body: body);
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
  Future<chopper.Response<List<OrderReturn>>> amapDeliveriesDeliveryIdOrdersGet(
      {required String? deliveryId}) {
    generatedMapping.putIfAbsent(
        OrderReturn, () => OrderReturn.fromJsonFactory);

    return _amapDeliveriesDeliveryIdOrdersGet(deliveryId: deliveryId);
  }

  ///Get Orders From Delivery
  ///@param delivery_id
  @Get(path: '/amap/deliveries/{delivery_id}/orders')
  Future<chopper.Response<List<OrderReturn>>>
      _amapDeliveriesDeliveryIdOrdersGet(
          {@Path('delivery_id') required String? deliveryId});

  ///Get Order By Id
  ///@param order_id
  Future<chopper.Response<OrderReturn>> amapOrdersOrderIdGet(
      {required String? orderId}) {
    generatedMapping.putIfAbsent(
        OrderReturn, () => OrderReturn.fromJsonFactory);

    return _amapOrdersOrderIdGet(orderId: orderId);
  }

  ///Get Order By Id
  ///@param order_id
  @Get(path: '/amap/orders/{order_id}')
  Future<chopper.Response<OrderReturn>> _amapOrdersOrderIdGet(
      {@Path('order_id') required String? orderId});

  ///Remove Order
  ///@param order_id
  Future<chopper.Response> amapOrdersOrderIdDelete({required String? orderId}) {
    return _amapOrdersOrderIdDelete(orderId: orderId);
  }

  ///Remove Order
  ///@param order_id
  @Delete(path: '/amap/orders/{order_id}')
  Future<chopper.Response> _amapOrdersOrderIdDelete(
      {@Path('order_id') required String? orderId});

  ///Edit Order From Delievery
  ///@param order_id
  Future<chopper.Response> amapOrdersOrderIdPatch({
    required String? orderId,
    required OrderEdit? body,
  }) {
    return _amapOrdersOrderIdPatch(orderId: orderId, body: body);
  }

  ///Edit Order From Delievery
  ///@param order_id
  @Patch(
    path: '/amap/orders/{order_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _amapOrdersOrderIdPatch({
    @Path('order_id') required String? orderId,
    @Body() required OrderEdit? body,
  });

  ///Add Order To Delievery
  Future<chopper.Response<OrderReturn>> amapOrdersPost(
      {required OrderBase? body}) {
    generatedMapping.putIfAbsent(
        OrderReturn, () => OrderReturn.fromJsonFactory);

    return _amapOrdersPost(body: body);
  }

  ///Add Order To Delievery
  @Post(
    path: '/amap/orders',
    optionalBody: true,
  )
  Future<chopper.Response<OrderReturn>> _amapOrdersPost(
      {@Body() required OrderBase? body});

  ///Open Ordering Of Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdOpenorderingPost(
      {required String? deliveryId}) {
    return _amapDeliveriesDeliveryIdOpenorderingPost(deliveryId: deliveryId);
  }

  ///Open Ordering Of Delivery
  ///@param delivery_id
  @Post(
    path: '/amap/deliveries/{delivery_id}/openordering',
    optionalBody: true,
  )
  Future<chopper.Response> _amapDeliveriesDeliveryIdOpenorderingPost(
      {@Path('delivery_id') required String? deliveryId});

  ///Lock Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdLockPost(
      {required String? deliveryId}) {
    return _amapDeliveriesDeliveryIdLockPost(deliveryId: deliveryId);
  }

  ///Lock Delivery
  ///@param delivery_id
  @Post(
    path: '/amap/deliveries/{delivery_id}/lock',
    optionalBody: true,
  )
  Future<chopper.Response> _amapDeliveriesDeliveryIdLockPost(
      {@Path('delivery_id') required String? deliveryId});

  ///Mark Delivery As Delivered
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdDeliveredPost(
      {required String? deliveryId}) {
    return _amapDeliveriesDeliveryIdDeliveredPost(deliveryId: deliveryId);
  }

  ///Mark Delivery As Delivered
  ///@param delivery_id
  @Post(
    path: '/amap/deliveries/{delivery_id}/delivered',
    optionalBody: true,
  )
  Future<chopper.Response> _amapDeliveriesDeliveryIdDeliveredPost(
      {@Path('delivery_id') required String? deliveryId});

  ///Archive Of Delivery
  ///@param delivery_id
  Future<chopper.Response> amapDeliveriesDeliveryIdArchivePost(
      {required String? deliveryId}) {
    return _amapDeliveriesDeliveryIdArchivePost(deliveryId: deliveryId);
  }

  ///Archive Of Delivery
  ///@param delivery_id
  @Post(
    path: '/amap/deliveries/{delivery_id}/archive',
    optionalBody: true,
  )
  Future<chopper.Response> _amapDeliveriesDeliveryIdArchivePost(
      {@Path('delivery_id') required String? deliveryId});

  ///Get Users Cash
  Future<chopper.Response<List<AppSchemasSchemasAmapCashComplete>>>
      amapUsersCashGet() {
    generatedMapping.putIfAbsent(AppSchemasSchemasAmapCashComplete,
        () => AppSchemasSchemasAmapCashComplete.fromJsonFactory);

    return _amapUsersCashGet();
  }

  ///Get Users Cash
  @Get(path: '/amap/users/cash')
  Future<chopper.Response<List<AppSchemasSchemasAmapCashComplete>>>
      _amapUsersCashGet();

  ///Get Cash By Id
  ///@param user_id
  Future<chopper.Response<AppSchemasSchemasAmapCashComplete>>
      amapUsersUserIdCashGet({required String? userId}) {
    generatedMapping.putIfAbsent(AppSchemasSchemasAmapCashComplete,
        () => AppSchemasSchemasAmapCashComplete.fromJsonFactory);

    return _amapUsersUserIdCashGet(userId: userId);
  }

  ///Get Cash By Id
  ///@param user_id
  @Get(path: '/amap/users/{user_id}/cash')
  Future<chopper.Response<AppSchemasSchemasAmapCashComplete>>
      _amapUsersUserIdCashGet({@Path('user_id') required String? userId});

  ///Create Cash Of User
  ///@param user_id
  Future<chopper.Response<AppSchemasSchemasAmapCashComplete>>
      amapUsersUserIdCashPost({
    required String? userId,
    required AppSchemasSchemasAmapCashEdit? body,
  }) {
    generatedMapping.putIfAbsent(AppSchemasSchemasAmapCashComplete,
        () => AppSchemasSchemasAmapCashComplete.fromJsonFactory);

    return _amapUsersUserIdCashPost(userId: userId, body: body);
  }

  ///Create Cash Of User
  ///@param user_id
  @Post(
    path: '/amap/users/{user_id}/cash',
    optionalBody: true,
  )
  Future<chopper.Response<AppSchemasSchemasAmapCashComplete>>
      _amapUsersUserIdCashPost({
    @Path('user_id') required String? userId,
    @Body() required AppSchemasSchemasAmapCashEdit? body,
  });

  ///Edit Cash By Id
  ///@param user_id
  Future<chopper.Response> amapUsersUserIdCashPatch({
    required String? userId,
    required AppSchemasSchemasAmapCashEdit? body,
  }) {
    return _amapUsersUserIdCashPatch(userId: userId, body: body);
  }

  ///Edit Cash By Id
  ///@param user_id
  @Patch(
    path: '/amap/users/{user_id}/cash',
    optionalBody: true,
  )
  Future<chopper.Response> _amapUsersUserIdCashPatch({
    @Path('user_id') required String? userId,
    @Body() required AppSchemasSchemasAmapCashEdit? body,
  });

  ///Get Orders Of User
  ///@param user_id
  Future<chopper.Response<List<OrderReturn>>> amapUsersUserIdOrdersGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        OrderReturn, () => OrderReturn.fromJsonFactory);

    return _amapUsersUserIdOrdersGet(userId: userId);
  }

  ///Get Orders Of User
  ///@param user_id
  @Get(path: '/amap/users/{user_id}/orders')
  Future<chopper.Response<List<OrderReturn>>> _amapUsersUserIdOrdersGet(
      {@Path('user_id') required String? userId});

  ///Get Information
  Future<chopper.Response<Information>> amapInformationGet() {
    generatedMapping.putIfAbsent(
        Information, () => Information.fromJsonFactory);

    return _amapInformationGet();
  }

  ///Get Information
  @Get(path: '/amap/information')
  Future<chopper.Response<Information>> _amapInformationGet();

  ///Edit Information
  Future<chopper.Response> amapInformationPatch(
      {required InformationEdit? body}) {
    return _amapInformationPatch(body: body);
  }

  ///Edit Information
  @Patch(
    path: '/amap/information',
    optionalBody: true,
  )
  Future<chopper.Response> _amapInformationPatch(
      {@Body() required InformationEdit? body});

  ///Get Associations
  Future<chopper.Response> associationsGet() {
    return _associationsGet();
  }

  ///Get Associations
  @Get(path: '/associations')
  Future<chopper.Response> _associationsGet();

  ///Edit Association
  Future<chopper.Response> associationsPut() {
    return _associationsPut();
  }

  ///Edit Association
  @Put(
    path: '/associations',
    optionalBody: true,
  )
  Future<chopper.Response> _associationsPut();

  ///Create Association
  Future<chopper.Response> associationsPost() {
    return _associationsPost();
  }

  ///Create Association
  @Post(
    path: '/associations',
    optionalBody: true,
  )
  Future<chopper.Response> _associationsPost();

  ///Get Association
  ///@param association_id
  Future<chopper.Response> associationsAssociationIdGet(
      {required Object? associationId}) {
    return _associationsAssociationIdGet(associationId: associationId);
  }

  ///Get Association
  ///@param association_id
  @Get(path: '/associations/{association_id}')
  Future<chopper.Response> _associationsAssociationIdGet(
      {@Path('association_id') required Object? associationId});

  ///Get Users Association
  ///@param association_id
  Future<chopper.Response> associationsAssociationIdUsersGet(
      {required Object? associationId}) {
    return _associationsAssociationIdUsersGet(associationId: associationId);
  }

  ///Get Users Association
  ///@param association_id
  @Get(path: '/associations/{association_id}/users')
  Future<chopper.Response> _associationsAssociationIdUsersGet(
      {@Path('association_id') required Object? associationId});

  ///Create User Association
  ///@param association_id
  ///@param user_id
  Future<chopper.Response> associationsAssociationIdUsersUserIdPost({
    required Object? associationId,
    required Object? userId,
  }) {
    return _associationsAssociationIdUsersUserIdPost(
        associationId: associationId, userId: userId);
  }

  ///Create User Association
  ///@param association_id
  ///@param user_id
  @Post(
    path: '/associations/{association_id}/users/{user_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _associationsAssociationIdUsersUserIdPost({
    @Path('association_id') required Object? associationId,
    @Path('user_id') required Object? userId,
  });

  ///Delete User Association
  ///@param association_id
  ///@param user_id
  Future<chopper.Response> associationsAssociationIdUsersUserIdDelete({
    required Object? associationId,
    required Object? userId,
  }) {
    return _associationsAssociationIdUsersUserIdDelete(
        associationId: associationId, userId: userId);
  }

  ///Delete User Association
  ///@param association_id
  ///@param user_id
  @Delete(path: '/associations/{association_id}/users/{user_id}')
  Future<chopper.Response> _associationsAssociationIdUsersUserIdDelete({
    @Path('association_id') required Object? associationId,
    @Path('user_id') required Object? userId,
  });

  ///Create Admin Association
  ///@param association_id
  ///@param user_id
  Future<chopper.Response> associationsAssociationIdAdminsUserIdPost({
    required Object? associationId,
    required Object? userId,
  }) {
    return _associationsAssociationIdAdminsUserIdPost(
        associationId: associationId, userId: userId);
  }

  ///Create Admin Association
  ///@param association_id
  ///@param user_id
  @Post(
    path: '/associations/{association_id}/admins/{user_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _associationsAssociationIdAdminsUserIdPost({
    @Path('association_id') required Object? associationId,
    @Path('user_id') required Object? userId,
  });

  ///Delete Admin Association
  ///@param association_id
  ///@param user_id
  Future<chopper.Response> associationsAssociationIdAdminsUserIdDelete({
    required Object? associationId,
    required Object? userId,
  }) {
    return _associationsAssociationIdAdminsUserIdDelete(
        associationId: associationId, userId: userId);
  }

  ///Delete Admin Association
  ///@param association_id
  ///@param user_id
  @Delete(path: '/associations/{association_id}/admins/{user_id}')
  Future<chopper.Response> _associationsAssociationIdAdminsUserIdDelete({
    @Path('association_id') required Object? associationId,
    @Path('user_id') required Object? userId,
  });

  ///Login For Access Token
  Future<chopper.Response<AccessToken>> authSimpleTokenPost(
      {required Map<String, String> body}) {
    generatedMapping.putIfAbsent(
        AccessToken, () => AccessToken.fromJsonFactory);

    return _authSimpleTokenPost(body: body);
  }

  ///Login For Access Token
  @Post(
    path: '/auth/simple_token',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<AccessToken>> _authSimpleTokenPost(
      {@Body() required Map<String, String> body});

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
        codeChallengeMethod: codeChallengeMethod);
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
  Future<chopper.Response<String>> authAuthorizePost(
      {required Map<String, String> body}) {
    return _authAuthorizePost(body: body);
  }

  ///Post Authorize Page
  @Post(
    path: '/auth/authorize',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<String>> _authAuthorizePost(
      {@Body() required Map<String, String> body});

  ///Authorize Validation
  Future<chopper.Response> authAuthorizationFlowAuthorizeValidationPost(
      {required Map<String, String> body}) {
    return _authAuthorizationFlowAuthorizeValidationPost(body: body);
  }

  ///Authorize Validation
  @Post(
    path: '/auth/authorization-flow/authorize-validation',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response> _authAuthorizationFlowAuthorizeValidationPost(
      {@Body() required Map<String, String> body});

  ///Token
  ///@param authorization
  Future<chopper.Response<TokenResponse>> authTokenPost({
    String? authorization,
    required Map<String, String> body,
  }) {
    generatedMapping.putIfAbsent(
        TokenResponse, () => TokenResponse.fromJsonFactory);

    return _authTokenPost(authorization: authorization?.toString(), body: body);
  }

  ///Token
  ///@param authorization
  @Post(
    path: '/auth/token',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<TokenResponse>> _authTokenPost({
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

  ///Oidc Configuration
  Future<chopper.Response> wellKnownOpenidConfigurationGet() {
    return _wellKnownOpenidConfigurationGet();
  }

  ///Oidc Configuration
  @Get(path: '/.well-known/openid-configuration')
  Future<chopper.Response> _wellKnownOpenidConfigurationGet();

  ///Get Managers
  Future<chopper.Response<List<Manager>>> bookingManagersGet() {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersGet();
  }

  ///Get Managers
  @Get(path: '/booking/managers')
  Future<chopper.Response<List<Manager>>> _bookingManagersGet();

  ///Create Manager
  Future<chopper.Response<Manager>> bookingManagersPost(
      {required ManagerBase? body}) {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersPost(body: body);
  }

  ///Create Manager
  @Post(
    path: '/booking/managers',
    optionalBody: true,
  )
  Future<chopper.Response<Manager>> _bookingManagersPost(
      {@Body() required ManagerBase? body});

  ///Delete Manager
  ///@param manager_id
  Future<chopper.Response> bookingManagersManagerIdDelete(
      {required String? managerId}) {
    return _bookingManagersManagerIdDelete(managerId: managerId);
  }

  ///Delete Manager
  ///@param manager_id
  @Delete(path: '/booking/managers/{manager_id}')
  Future<chopper.Response> _bookingManagersManagerIdDelete(
      {@Path('manager_id') required String? managerId});

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
  @Patch(
    path: '/booking/managers/{manager_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _bookingManagersManagerIdPatch({
    @Path('manager_id') required String? managerId,
    @Body() required ManagerUpdate? body,
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
        BookingReturnApplicant, () => BookingReturnApplicant.fromJsonFactory);

    return _bookingBookingsUsersMeManageGet();
  }

  ///Get Bookings For Manager
  @Get(path: '/booking/bookings/users/me/manage')
  Future<chopper.Response<List<BookingReturnApplicant>>>
      _bookingBookingsUsersMeManageGet();

  ///Get Confirmed Bookings For Manager
  Future<chopper.Response<List<BookingReturn>>> bookingBookingsConfirmedGet() {
    generatedMapping.putIfAbsent(
        BookingReturn, () => BookingReturn.fromJsonFactory);

    return _bookingBookingsConfirmedGet();
  }

  ///Get Confirmed Bookings For Manager
  @Get(path: '/booking/bookings/confirmed')
  Future<chopper.Response<List<BookingReturn>>> _bookingBookingsConfirmedGet();

  ///Get Applicant Bookings
  ///@param applicant_id
  Future<chopper.Response<List<BookingReturn>>>
      bookingBookingsUsersApplicantIdGet({required String? applicantId}) {
    generatedMapping.putIfAbsent(
        BookingReturn, () => BookingReturn.fromJsonFactory);

    return _bookingBookingsUsersApplicantIdGet(applicantId: applicantId);
  }

  ///Get Applicant Bookings
  ///@param applicant_id
  @Get(path: '/booking/bookings/users/{applicant_id}')
  Future<chopper.Response<List<BookingReturn>>>
      _bookingBookingsUsersApplicantIdGet(
          {@Path('applicant_id') required String? applicantId});

  ///Create Booking
  Future<chopper.Response<BookingReturn>> bookingBookingsPost(
      {required BookingBase? body}) {
    generatedMapping.putIfAbsent(
        BookingReturn, () => BookingReturn.fromJsonFactory);

    return _bookingBookingsPost(body: body);
  }

  ///Create Booking
  @Post(
    path: '/booking/bookings',
    optionalBody: true,
  )
  Future<chopper.Response<BookingReturn>> _bookingBookingsPost(
      {@Body() required BookingBase? body});

  ///Delete Booking
  ///@param booking_id
  Future<chopper.Response> bookingBookingsBookingIdDelete(
      {required String? bookingId}) {
    return _bookingBookingsBookingIdDelete(bookingId: bookingId);
  }

  ///Delete Booking
  ///@param booking_id
  @Delete(path: '/booking/bookings/{booking_id}')
  Future<chopper.Response> _bookingBookingsBookingIdDelete(
      {@Path('booking_id') required String? bookingId});

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
  @Patch(
    path: '/booking/bookings/{booking_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _bookingBookingsBookingIdPatch({
    @Path('booking_id') required String? bookingId,
    @Body() required BookingEdit? body,
  });

  ///Confirm Booking
  ///@param booking_id
  ///@param decision
  Future<chopper.Response> bookingBookingsBookingIdReplyDecisionPatch({
    required String? bookingId,
    required enums.AppUtilsTypesBookingTypeDecision? decision,
  }) {
    return _bookingBookingsBookingIdReplyDecisionPatch(
        bookingId: bookingId, decision: decision?.value?.toString());
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
        RoomComplete, () => RoomComplete.fromJsonFactory);

    return _bookingRoomsGet();
  }

  ///Get Rooms
  @Get(path: '/booking/rooms')
  Future<chopper.Response<List<RoomComplete>>> _bookingRoomsGet();

  ///Create Room
  Future<chopper.Response<RoomComplete>> bookingRoomsPost(
      {required RoomBase? body}) {
    generatedMapping.putIfAbsent(
        RoomComplete, () => RoomComplete.fromJsonFactory);

    return _bookingRoomsPost(body: body);
  }

  ///Create Room
  @Post(
    path: '/booking/rooms',
    optionalBody: true,
  )
  Future<chopper.Response<RoomComplete>> _bookingRoomsPost(
      {@Body() required RoomBase? body});

  ///Delete Room
  ///@param room_id
  Future<chopper.Response> bookingRoomsRoomIdDelete({required String? roomId}) {
    return _bookingRoomsRoomIdDelete(roomId: roomId);
  }

  ///Delete Room
  ///@param room_id
  @Delete(path: '/booking/rooms/{room_id}')
  Future<chopper.Response> _bookingRoomsRoomIdDelete(
      {@Path('room_id') required String? roomId});

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
  @Patch(
    path: '/booking/rooms/{room_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _bookingRoomsRoomIdPatch({
    @Path('room_id') required String? roomId,
    @Body() required RoomBase? body,
  });

  ///Get Events
  Future<chopper.Response<List<EventReturn>>> calendarEventsGet() {
    generatedMapping.putIfAbsent(
        EventReturn, () => EventReturn.fromJsonFactory);

    return _calendarEventsGet();
  }

  ///Get Events
  @Get(path: '/calendar/events/')
  Future<chopper.Response<List<EventReturn>>> _calendarEventsGet();

  ///Add Event
  Future<chopper.Response<EventComplete>> calendarEventsPost(
      {required EventBase? body}) {
    generatedMapping.putIfAbsent(
        EventComplete, () => EventComplete.fromJsonFactory);

    return _calendarEventsPost(body: body);
  }

  ///Add Event
  @Post(
    path: '/calendar/events/',
    optionalBody: true,
  )
  Future<chopper.Response<EventComplete>> _calendarEventsPost(
      {@Body() required EventBase? body});

  ///Get Confirmed Events
  Future<chopper.Response<List<EventComplete>>> calendarEventsConfirmedGet() {
    generatedMapping.putIfAbsent(
        EventComplete, () => EventComplete.fromJsonFactory);

    return _calendarEventsConfirmedGet();
  }

  ///Get Confirmed Events
  @Get(path: '/calendar/events/confirmed')
  Future<chopper.Response<List<EventComplete>>> _calendarEventsConfirmedGet();

  ///Get Applicant Bookings
  ///@param applicant_id
  Future<chopper.Response<List<EventReturn>>> calendarEventsUserApplicantIdGet(
      {required String? applicantId}) {
    generatedMapping.putIfAbsent(
        EventReturn, () => EventReturn.fromJsonFactory);

    return _calendarEventsUserApplicantIdGet(applicantId: applicantId);
  }

  ///Get Applicant Bookings
  ///@param applicant_id
  @Get(path: '/calendar/events/user/{applicant_id}')
  Future<chopper.Response<List<EventReturn>>> _calendarEventsUserApplicantIdGet(
      {@Path('applicant_id') required String? applicantId});

  ///Get Event By Id
  ///@param event_id
  Future<chopper.Response<EventComplete>> calendarEventsEventIdGet(
      {required String? eventId}) {
    generatedMapping.putIfAbsent(
        EventComplete, () => EventComplete.fromJsonFactory);

    return _calendarEventsEventIdGet(eventId: eventId);
  }

  ///Get Event By Id
  ///@param event_id
  @Get(path: '/calendar/events/{event_id}')
  Future<chopper.Response<EventComplete>> _calendarEventsEventIdGet(
      {@Path('event_id') required String? eventId});

  ///Delete Bookings Id
  ///@param event_id
  Future<chopper.Response> calendarEventsEventIdDelete(
      {required Object? eventId}) {
    return _calendarEventsEventIdDelete(eventId: eventId);
  }

  ///Delete Bookings Id
  ///@param event_id
  @Delete(path: '/calendar/events/{event_id}')
  Future<chopper.Response> _calendarEventsEventIdDelete(
      {@Path('event_id') required Object? eventId});

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
  @Patch(
    path: '/calendar/events/{event_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _calendarEventsEventIdPatch({
    @Path('event_id') required String? eventId,
    @Body() required EventEdit? body,
  });

  ///Get Event Applicant
  ///@param event_id
  Future<chopper.Response<EventApplicant>> calendarEventsEventIdApplicantGet(
      {required String? eventId}) {
    generatedMapping.putIfAbsent(
        EventApplicant, () => EventApplicant.fromJsonFactory);

    return _calendarEventsEventIdApplicantGet(eventId: eventId);
  }

  ///Get Event Applicant
  ///@param event_id
  @Get(path: 'calendar/events/{event_id}/applicant')
  Future<chopper.Response<EventApplicant>> _calendarEventsEventIdApplicantGet(
      {@Path('event_id') required String? eventId});

  ///Confirm Booking
  ///@param event_id
  ///@param decision
  Future<chopper.Response> calendarEventsEventIdReplyDecisionPatch({
    required String? eventId,
    required enums.AppUtilsTypesCalendarTypesDecision? decision,
  }) {
    return _calendarEventsEventIdReplyDecisionPatch(
        eventId: eventId, decision: decision?.value?.toString());
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
  @Post(
    path: '/calendar/ical/create',
    optionalBody: true,
  )
  Future<chopper.Response> _calendarIcalCreatePost();

  ///Get Icalendar File
  Future<chopper.Response> calendarIcalGet() {
    return _calendarIcalGet();
  }

  ///Get Icalendar File
  @Get(path: '/calendar/ical')
  Future<chopper.Response> _calendarIcalGet();

  ///Get Sections
  Future<chopper.Response<List<SectionComplete>>> campaignSectionsGet() {
    generatedMapping.putIfAbsent(
        SectionComplete, () => SectionComplete.fromJsonFactory);

    return _campaignSectionsGet();
  }

  ///Get Sections
  @Get(path: '/campaign/sections')
  Future<chopper.Response<List<SectionComplete>>> _campaignSectionsGet();

  ///Add Section
  Future<chopper.Response<SectionComplete>> campaignSectionsPost(
      {required SectionBase? body}) {
    generatedMapping.putIfAbsent(
        SectionComplete, () => SectionComplete.fromJsonFactory);

    return _campaignSectionsPost(body: body);
  }

  ///Add Section
  @Post(
    path: '/campaign/sections',
    optionalBody: true,
  )
  Future<chopper.Response<SectionComplete>> _campaignSectionsPost(
      {@Body() required SectionBase? body});

  ///Delete Section
  ///@param section_id
  Future<chopper.Response> campaignSectionsSectionIdDelete(
      {required String? sectionId}) {
    return _campaignSectionsSectionIdDelete(sectionId: sectionId);
  }

  ///Delete Section
  ///@param section_id
  @Delete(path: '/campaign/sections/{section_id}')
  Future<chopper.Response> _campaignSectionsSectionIdDelete(
      {@Path('section_id') required String? sectionId});

  ///Get Lists
  Future<chopper.Response<List<ListReturn>>> campaignListsGet() {
    generatedMapping.putIfAbsent(ListReturn, () => ListReturn.fromJsonFactory);

    return _campaignListsGet();
  }

  ///Get Lists
  @Get(path: '/campaign/lists')
  Future<chopper.Response<List<ListReturn>>> _campaignListsGet();

  ///Add List
  Future<chopper.Response<ListReturn>> campaignListsPost(
      {required ListBase? body}) {
    generatedMapping.putIfAbsent(ListReturn, () => ListReturn.fromJsonFactory);

    return _campaignListsPost(body: body);
  }

  ///Add List
  @Post(
    path: '/campaign/lists',
    optionalBody: true,
  )
  Future<chopper.Response<ListReturn>> _campaignListsPost(
      {@Body() required ListBase? body});

  ///Delete List
  ///@param list_id
  Future<chopper.Response> campaignListsListIdDelete(
      {required String? listId}) {
    return _campaignListsListIdDelete(listId: listId);
  }

  ///Delete List
  ///@param list_id
  @Delete(path: '/campaign/lists/{list_id}')
  Future<chopper.Response> _campaignListsListIdDelete(
      {@Path('list_id') required String? listId});

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
  @Patch(
    path: '/campaign/lists/{list_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _campaignListsListIdPatch({
    @Path('list_id') required String? listId,
    @Body() required ListEdit? body,
  });

  ///Delete Lists By Type
  ///@param list_type
  Future<chopper.Response> campaignListsDelete({enums.ListType? listType}) {
    return _campaignListsDelete(listType: listType?.value?.toString());
  }

  ///Delete Lists By Type
  ///@param list_type
  @Delete(path: '/campaign/lists/')
  Future<chopper.Response> _campaignListsDelete(
      {@Query('list_type') String? listType});

  ///Get Voters
  Future<chopper.Response<List<VoterGroup>>> campaignVotersGet() {
    generatedMapping.putIfAbsent(VoterGroup, () => VoterGroup.fromJsonFactory);

    return _campaignVotersGet();
  }

  ///Get Voters
  @Get(path: '/campaign/voters')
  Future<chopper.Response<List<VoterGroup>>> _campaignVotersGet();

  ///Add Voter
  Future<chopper.Response<VoterGroup>> campaignVotersPost(
      {required VoterGroup? body}) {
    generatedMapping.putIfAbsent(VoterGroup, () => VoterGroup.fromJsonFactory);

    return _campaignVotersPost(body: body);
  }

  ///Add Voter
  @Post(
    path: '/campaign/voters',
    optionalBody: true,
  )
  Future<chopper.Response<VoterGroup>> _campaignVotersPost(
      {@Body() required VoterGroup? body});

  ///Delete Voters
  Future<chopper.Response> campaignVotersDelete() {
    return _campaignVotersDelete();
  }

  ///Delete Voters
  @Delete(path: '/campaign/voters')
  Future<chopper.Response> _campaignVotersDelete();

  ///Delete Voter By Group Id
  ///@param group_id
  Future<chopper.Response> campaignVotersGroupIdDelete(
      {required String? groupId}) {
    return _campaignVotersGroupIdDelete(groupId: groupId);
  }

  ///Delete Voter By Group Id
  ///@param group_id
  @Delete(path: '/campaign/voters/{group_id}')
  Future<chopper.Response> _campaignVotersGroupIdDelete(
      {@Path('group_id') required String? groupId});

  ///Open Vote
  Future<chopper.Response> campaignStatusOpenPost() {
    return _campaignStatusOpenPost();
  }

  ///Open Vote
  @Post(
    path: '/campaign/status/open',
    optionalBody: true,
  )
  Future<chopper.Response> _campaignStatusOpenPost();

  ///Close Vote
  Future<chopper.Response> campaignStatusClosePost() {
    return _campaignStatusClosePost();
  }

  ///Close Vote
  @Post(
    path: '/campaign/status/close',
    optionalBody: true,
  )
  Future<chopper.Response> _campaignStatusClosePost();

  ///Count Voting
  Future<chopper.Response> campaignStatusCountingPost() {
    return _campaignStatusCountingPost();
  }

  ///Count Voting
  @Post(
    path: '/campaign/status/counting',
    optionalBody: true,
  )
  Future<chopper.Response> _campaignStatusCountingPost();

  ///Publish Vote
  Future<chopper.Response> campaignStatusPublishedPost() {
    return _campaignStatusPublishedPost();
  }

  ///Publish Vote
  @Post(
    path: '/campaign/status/published',
    optionalBody: true,
  )
  Future<chopper.Response> _campaignStatusPublishedPost();

  ///Reset Vote
  Future<chopper.Response> campaignStatusResetPost() {
    return _campaignStatusResetPost();
  }

  ///Reset Vote
  @Post(
    path: '/campaign/status/reset',
    optionalBody: true,
  )
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
  @Post(
    path: '/campaign/votes',
    optionalBody: true,
  )
  Future<chopper.Response> _campaignVotesPost(
      {@Body() required VoteBase? body});

  ///Get Results
  Future<chopper.Response<List<AppSchemasSchemasCampaignResult>>>
      campaignResultsGet() {
    generatedMapping.putIfAbsent(AppSchemasSchemasCampaignResult,
        () => AppSchemasSchemasCampaignResult.fromJsonFactory);

    return _campaignResultsGet();
  }

  ///Get Results
  @Get(path: '/campaign/results')
  Future<chopper.Response<List<AppSchemasSchemasCampaignResult>>>
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
  Future<chopper.Response<VoteStats>> campaignStatsSectionIdGet(
      {required String? sectionId}) {
    generatedMapping.putIfAbsent(VoteStats, () => VoteStats.fromJsonFactory);

    return _campaignStatsSectionIdGet(sectionId: sectionId);
  }

  ///Get Stats For Section
  ///@param section_id
  @Get(path: '/campaign/stats/{section_id}')
  Future<chopper.Response<VoteStats>> _campaignStatsSectionIdGet(
      {@Path('section_id') required String? sectionId});

  ///Read Campaigns Logo
  ///@param list_id
  Future<chopper.Response> campaignListsListIdLogoGet(
      {required String? listId}) {
    return _campaignListsListIdLogoGet(listId: listId);
  }

  ///Read Campaigns Logo
  ///@param list_id
  @Get(path: '/campaign/lists/{list_id}/logo')
  Future<chopper.Response> _campaignListsListIdLogoGet(
      {@Path('list_id') required String? listId});

  ///Create Campaigns Logo
  ///@param list_id
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      campaignListsListIdLogoPost({
    required String? listId,
    required BodyCreateCampaignsLogoCampaignListsListIdLogoPost body,
  }) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _campaignListsListIdLogoPost(listId: listId, body: body);
  }

  ///Create Campaigns Logo
  ///@param list_id
  @Post(
    path: '/campaign/lists/{list_id}/logo',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _campaignListsListIdLogoPost({
    @Path('list_id') required String? listId,
    @Part() required BodyCreateCampaignsLogoCampaignListsListIdLogoPost body,
  });

  ///Get Sessions
  Future<chopper.Response<List<CineSessionComplete>>> cinemaSessionsGet() {
    generatedMapping.putIfAbsent(
        CineSessionComplete, () => CineSessionComplete.fromJsonFactory);

    return _cinemaSessionsGet();
  }

  ///Get Sessions
  @Get(path: '/cinema/sessions')
  Future<chopper.Response<List<CineSessionComplete>>> _cinemaSessionsGet();

  ///Create Session
  Future<chopper.Response<CineSessionComplete>> cinemaSessionsPost(
      {required CineSessionBase? body}) {
    generatedMapping.putIfAbsent(
        CineSessionComplete, () => CineSessionComplete.fromJsonFactory);

    return _cinemaSessionsPost(body: body);
  }

  ///Create Session
  @Post(
    path: '/cinema/sessions',
    optionalBody: true,
  )
  Future<chopper.Response<CineSessionComplete>> _cinemaSessionsPost(
      {@Body() required CineSessionBase? body});

  ///Delete Session
  ///@param session_id
  Future<chopper.Response> cinemaSessionsSessionIdDelete(
      {required String? sessionId}) {
    return _cinemaSessionsSessionIdDelete(sessionId: sessionId);
  }

  ///Delete Session
  ///@param session_id
  @Delete(path: '/cinema/sessions/{session_id}')
  Future<chopper.Response> _cinemaSessionsSessionIdDelete(
      {@Path('session_id') required String? sessionId});

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
  @Patch(
    path: '/cinema/sessions/{session_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _cinemaSessionsSessionIdPatch({
    @Path('session_id') required String? sessionId,
    @Body() required CineSessionUpdate? body,
  });

  ///Read Session Poster
  ///@param session_id
  Future<chopper.Response> cinemaSessionsSessionIdPosterGet(
      {required String? sessionId}) {
    return _cinemaSessionsSessionIdPosterGet(sessionId: sessionId);
  }

  ///Read Session Poster
  ///@param session_id
  @Get(path: '/cinema/sessions/{session_id}/poster')
  Future<chopper.Response> _cinemaSessionsSessionIdPosterGet(
      {@Path('session_id') required String? sessionId});

  ///Create Campaigns Logo
  ///@param session_id
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      cinemaSessionsSessionIdPosterPost({
    required String? sessionId,
    required BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost body,
  }) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _cinemaSessionsSessionIdPosterPost(sessionId: sessionId, body: body);
  }

  ///Create Campaigns Logo
  ///@param session_id
  @Post(
    path: '/cinema/sessions/{session_id}/poster',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _cinemaSessionsSessionIdPosterPost({
    @Path('session_id') required String? sessionId,
    @Part()
    required BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost body,
  });

  ///Read Information
  Future<chopper.Response<CoreInformation>> informationGet() {
    generatedMapping.putIfAbsent(
        CoreInformation, () => CoreInformation.fromJsonFactory);

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
  Future<chopper.Response> _styleFileCssGet(
      {@Path('file') required String? file});

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
        ModuleVisibility, () => ModuleVisibility.fromJsonFactory);

    return _moduleVisibilityGet();
  }

  ///Get Module Visibility
  @Get(path: '/module-visibility/')
  Future<chopper.Response<List<ModuleVisibility>>> _moduleVisibilityGet();

  ///Add Module Visibility
  Future<chopper.Response<ModuleVisibilityCreate>> moduleVisibilityPost(
      {required ModuleVisibilityCreate? body}) {
    generatedMapping.putIfAbsent(
        ModuleVisibilityCreate, () => ModuleVisibilityCreate.fromJsonFactory);

    return _moduleVisibilityPost(body: body);
  }

  ///Add Module Visibility
  @Post(
    path: '/module-visibility/',
    optionalBody: true,
  )
  Future<chopper.Response<ModuleVisibilityCreate>> _moduleVisibilityPost(
      {@Body() required ModuleVisibilityCreate? body});

  ///Get User Modules Visibility
  Future<chopper.Response<List<String>>> moduleVisibilityMeGet() {
    return _moduleVisibilityMeGet();
  }

  ///Get User Modules Visibility
  @Get(path: '/module-visibility/me')
  Future<chopper.Response<List<String>>> _moduleVisibilityMeGet();

  ///Delete Session
  ///@param root
  ///@param group_id
  Future<chopper.Response> moduleVisibilityRootGroupIdDelete({
    required String? root,
    required String? groupId,
  }) {
    return _moduleVisibilityRootGroupIdDelete(root: root, groupId: groupId);
  }

  ///Delete Session
  ///@param root
  ///@param group_id
  @Delete(path: '/module-visibility/{root}/{group_id}')
  Future<chopper.Response> _moduleVisibilityRootGroupIdDelete({
    @Path('root') required String? root,
    @Path('group_id') required String? groupId,
  });

  ///Read Groups
  Future<chopper.Response<List<CoreGroupSimple>>> groupsGet() {
    generatedMapping.putIfAbsent(
        CoreGroupSimple, () => CoreGroupSimple.fromJsonFactory);

    return _groupsGet();
  }

  ///Read Groups
  @Get(path: '/groups/')
  Future<chopper.Response<List<CoreGroupSimple>>> _groupsGet();

  ///Create Group
  Future<chopper.Response<CoreGroupSimple>> groupsPost(
      {required CoreGroupCreate? body}) {
    generatedMapping.putIfAbsent(
        CoreGroupSimple, () => CoreGroupSimple.fromJsonFactory);

    return _groupsPost(body: body);
  }

  ///Create Group
  @Post(
    path: '/groups/',
    optionalBody: true,
  )
  Future<chopper.Response<CoreGroupSimple>> _groupsPost(
      {@Body() required CoreGroupCreate? body});

  ///Read Group
  ///@param group_id
  Future<chopper.Response<CoreGroup>> groupsGroupIdGet(
      {required String? groupId}) {
    generatedMapping.putIfAbsent(CoreGroup, () => CoreGroup.fromJsonFactory);

    return _groupsGroupIdGet(groupId: groupId);
  }

  ///Read Group
  ///@param group_id
  @Get(path: '/groups/{group_id}')
  Future<chopper.Response<CoreGroup>> _groupsGroupIdGet(
      {@Path('group_id') required String? groupId});

  ///Delete Group
  ///@param group_id
  Future<chopper.Response> groupsGroupIdDelete({required String? groupId}) {
    return _groupsGroupIdDelete(groupId: groupId);
  }

  ///Delete Group
  ///@param group_id
  @Delete(path: '/groups/{group_id}')
  Future<chopper.Response> _groupsGroupIdDelete(
      {@Path('group_id') required String? groupId});

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
  @Patch(
    path: '/groups/{group_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _groupsGroupIdPatch({
    @Path('group_id') required String? groupId,
    @Body() required CoreGroupUpdate? body,
  });

  ///Create Membership
  Future<chopper.Response<CoreGroup>> groupsMembershipPost(
      {required CoreMembership? body}) {
    generatedMapping.putIfAbsent(CoreGroup, () => CoreGroup.fromJsonFactory);

    return _groupsMembershipPost(body: body);
  }

  ///Create Membership
  @Post(
    path: '/groups/membership',
    optionalBody: true,
  )
  Future<chopper.Response<CoreGroup>> _groupsMembershipPost(
      {@Body() required CoreMembership? body});

  ///Delete Membership
  Future<chopper.Response> groupsMembershipDelete(
      {required CoreMembershipDelete? body}) {
    return _groupsMembershipDelete(body: body);
  }

  ///Delete Membership
  @Delete(path: '/groups/membership')
  Future<chopper.Response> _groupsMembershipDelete(
      {@Body() required CoreMembershipDelete? body});

  ///Create Batch Membership
  Future<chopper.Response> groupsBatchMembershipPost(
      {required CoreBatchMembership? body}) {
    return _groupsBatchMembershipPost(body: body);
  }

  ///Create Batch Membership
  @Post(
    path: '/groups/batch-membership',
    optionalBody: true,
  )
  Future<chopper.Response> _groupsBatchMembershipPost(
      {@Body() required CoreBatchMembership? body});

  ///Delete Batch Membership
  Future<chopper.Response> groupsBatchMembershipDelete(
      {required CoreBatchDeleteMembership? body}) {
    return _groupsBatchMembershipDelete(body: body);
  }

  ///Delete Batch Membership
  @Delete(path: '/groups/batch-membership')
  Future<chopper.Response> _groupsBatchMembershipDelete(
      {@Body() required CoreBatchDeleteMembership? body});

  ///Read Loaners
  Future<chopper.Response<List<Loaner>>> loansLoanersGet() {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansLoanersGet();
  }

  ///Read Loaners
  @Get(path: '/loans/loaners/')
  Future<chopper.Response<List<Loaner>>> _loansLoanersGet();

  ///Create Loaner
  Future<chopper.Response<Loaner>> loansLoanersPost(
      {required LoanerBase? body}) {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansLoanersPost(body: body);
  }

  ///Create Loaner
  @Post(
    path: '/loans/loaners/',
    optionalBody: true,
  )
  Future<chopper.Response<Loaner>> _loansLoanersPost(
      {@Body() required LoanerBase? body});

  ///Delete Loaner
  ///@param loaner_id
  Future<chopper.Response> loansLoanersLoanerIdDelete(
      {required String? loanerId}) {
    return _loansLoanersLoanerIdDelete(loanerId: loanerId);
  }

  ///Delete Loaner
  ///@param loaner_id
  @Delete(path: '/loans/loaners/{loaner_id}')
  Future<chopper.Response> _loansLoanersLoanerIdDelete(
      {@Path('loaner_id') required String? loanerId});

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
  @Patch(
    path: '/loans/loaners/{loaner_id}',
    optionalBody: true,
  )
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
        loanerId: loanerId, returned: returned);
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
  Future<chopper.Response<List<Item>>> loansLoanersLoanerIdItemsGet(
      {required String? loanerId}) {
    generatedMapping.putIfAbsent(Item, () => Item.fromJsonFactory);

    return _loansLoanersLoanerIdItemsGet(loanerId: loanerId);
  }

  ///Get Items By Loaner
  ///@param loaner_id
  @Get(path: '/loans/loaners/{loaner_id}/items')
  Future<chopper.Response<List<Item>>> _loansLoanersLoanerIdItemsGet(
      {@Path('loaner_id') required String? loanerId});

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
  @Post(
    path: '/loans/loaners/{loaner_id}/items',
    optionalBody: true,
  )
  Future<chopper.Response<Item>> _loansLoanersLoanerIdItemsPost({
    @Path('loaner_id') required String? loanerId,
    @Body() required ItemBase? body,
  });

  ///Delete Loaner Item
  ///@param loaner_id
  ///@param item_id
  Future<chopper.Response> loansLoanersLoanerIdItemsItemIdDelete({
    required String? loanerId,
    required String? itemId,
  }) {
    return _loansLoanersLoanerIdItemsItemIdDelete(
        loanerId: loanerId, itemId: itemId);
  }

  ///Delete Loaner Item
  ///@param loaner_id
  ///@param item_id
  @Delete(path: '/loans/loaners/{loaner_id}/items/{item_id}')
  Future<chopper.Response> _loansLoanersLoanerIdItemsItemIdDelete({
    @Path('loaner_id') required String? loanerId,
    @Path('item_id') required String? itemId,
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
        loanerId: loanerId, itemId: itemId, body: body);
  }

  ///Update Items For Loaner
  ///@param loaner_id
  ///@param item_id
  @Patch(
    path: '/loans/loaners/{loaner_id}/items/{item_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _loansLoanersLoanerIdItemsItemIdPatch({
    @Path('loaner_id') required String? loanerId,
    @Path('item_id') required String? itemId,
    @Body() required ItemUpdate? body,
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
  Future<chopper.Response<List<Loan>>> _loansUsersMeGet(
      {@Query('returned') bool? returned});

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
  @Post(
    path: '/loans/',
    optionalBody: true,
  )
  Future<chopper.Response<Loan>> _loansPost(
      {@Body() required LoanCreation? body});

  ///Delete Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdDelete({required String? loanId}) {
    return _loansLoanIdDelete(loanId: loanId);
  }

  ///Delete Loan
  ///@param loan_id
  @Delete(path: '/loans/{loan_id}')
  Future<chopper.Response> _loansLoanIdDelete(
      {@Path('loan_id') required String? loanId});

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
  @Patch(
    path: '/loans/{loan_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _loansLoanIdPatch({
    @Path('loan_id') required String? loanId,
    @Body() required LoanUpdate? body,
  });

  ///Return Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdReturnPost({required String? loanId}) {
    return _loansLoanIdReturnPost(loanId: loanId);
  }

  ///Return Loan
  ///@param loan_id
  @Post(
    path: '/loans/{loan_id}/return',
    optionalBody: true,
  )
  Future<chopper.Response> _loansLoanIdReturnPost(
      {@Path('loan_id') required String? loanId});

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
  @Post(
    path: '/loans/{loan_id}/extend',
    optionalBody: true,
  )
  Future<chopper.Response> _loansLoanIdExtendPost({
    @Path('loan_id') required String? loanId,
    @Body() required LoanExtend? body,
  });

  ///Get Devices
  Future<chopper.Response<List<FirebaseDevice>>> notificationDevicesGet() {
    generatedMapping.putIfAbsent(
        FirebaseDevice, () => FirebaseDevice.fromJsonFactory);

    return _notificationDevicesGet();
  }

  ///Get Devices
  @Get(path: '/notification/devices')
  Future<chopper.Response<List<FirebaseDevice>>> _notificationDevicesGet();

  ///Register Firebase Device
  Future<chopper.Response> notificationDevicesPost(
      {required BodyRegisterFirebaseDeviceNotificationDevicesPost? body}) {
    return _notificationDevicesPost(body: body);
  }

  ///Register Firebase Device
  @Post(
    path: '/notification/devices',
    optionalBody: true,
  )
  Future<chopper.Response> _notificationDevicesPost(
      {@Body()
      required BodyRegisterFirebaseDeviceNotificationDevicesPost? body});

  ///Unregister Firebase Device
  ///@param firebase_token
  Future<chopper.Response> notificationDevicesFirebaseTokenDelete(
      {required String? firebaseToken}) {
    return _notificationDevicesFirebaseTokenDelete(
        firebaseToken: firebaseToken);
  }

  ///Unregister Firebase Device
  ///@param firebase_token
  @Delete(path: '/notification/devices/{firebase_token}')
  Future<chopper.Response> _notificationDevicesFirebaseTokenDelete(
      {@Path('firebase_token') required String? firebaseToken});

  ///Get Messages
  ///@param firebase_token
  Future<chopper.Response<List<Message>>> notificationMessagesFirebaseTokenGet(
      {required String? firebaseToken}) {
    generatedMapping.putIfAbsent(Message, () => Message.fromJsonFactory);

    return _notificationMessagesFirebaseTokenGet(firebaseToken: firebaseToken);
  }

  ///Get Messages
  ///@param firebase_token
  @Get(path: '/notification/messages/{firebase_token}')
  Future<chopper.Response<List<Message>>> _notificationMessagesFirebaseTokenGet(
      {@Path('firebase_token') required String? firebaseToken});

  ///Subscribe To Topic
  ///@param topic_str The topic to subscribe to. The Topic may be followed by an additional identifier (ex: cinema_4c029b5f-2bf7-4b70-85d4-340a4bd28653)
  Future<chopper.Response> notificationTopicsTopicStrSubscribePost(
      {required String? topicStr}) {
    return _notificationTopicsTopicStrSubscribePost(topicStr: topicStr);
  }

  ///Subscribe To Topic
  ///@param topic_str The topic to subscribe to. The Topic may be followed by an additional identifier (ex: cinema_4c029b5f-2bf7-4b70-85d4-340a4bd28653)
  @Post(
    path: '/notification/topics/{topic_str}/subscribe',
    optionalBody: true,
  )
  Future<chopper.Response> _notificationTopicsTopicStrSubscribePost(
      {@Path('topic_str') required String? topicStr});

  ///Unsubscribe To Topic
  ///@param topic_str
  Future<chopper.Response> notificationTopicsTopicStrUnsubscribePost(
      {required String? topicStr}) {
    return _notificationTopicsTopicStrUnsubscribePost(topicStr: topicStr);
  }

  ///Unsubscribe To Topic
  ///@param topic_str
  @Post(
    path: '/notification/topics/{topic_str}/unsubscribe',
    optionalBody: true,
  )
  Future<chopper.Response> _notificationTopicsTopicStrUnsubscribePost(
      {@Path('topic_str') required String? topicStr});

  ///Get Topic
  Future<chopper.Response<List<String>>> notificationTopicsGet() {
    return _notificationTopicsGet();
  }

  ///Get Topic
  @Get(path: '/notification/topics')
  Future<chopper.Response<List<String>>> _notificationTopicsGet();

  ///Get Topic Identifier
  ///@param topic_str
  Future<chopper.Response<List<String>>> notificationTopicsTopicStrGet(
      {required String? topicStr}) {
    return _notificationTopicsTopicStrGet(topicStr: topicStr);
  }

  ///Get Topic Identifier
  ///@param topic_str
  @Get(path: '/notification/topics/{topic_str}')
  Future<chopper.Response<List<String>>> _notificationTopicsTopicStrGet(
      {@Path('topic_str') required String? topicStr});

  ///Send Notification
  Future<chopper.Response> notificationSendPost({required Message? body}) {
    return _notificationSendPost(body: body);
  }

  ///Send Notification
  @Post(
    path: '/notification/send',
    optionalBody: true,
  )
  Future<chopper.Response> _notificationSendPost(
      {@Body() required Message? body});

  ///Get Raffle
  Future<chopper.Response<List<RaffleComplete>>> tombolaRafflesGet() {
    generatedMapping.putIfAbsent(
        RaffleComplete, () => RaffleComplete.fromJsonFactory);

    return _tombolaRafflesGet();
  }

  ///Get Raffle
  @Get(path: '/tombola/raffles')
  Future<chopper.Response<List<RaffleComplete>>> _tombolaRafflesGet();

  ///Create Raffle
  Future<chopper.Response<RaffleSimple>> tombolaRafflesPost(
      {required RaffleBase? body}) {
    generatedMapping.putIfAbsent(
        RaffleSimple, () => RaffleSimple.fromJsonFactory);

    return _tombolaRafflesPost(body: body);
  }

  ///Create Raffle
  @Post(
    path: '/tombola/raffles',
    optionalBody: true,
  )
  Future<chopper.Response<RaffleSimple>> _tombolaRafflesPost(
      {@Body() required RaffleBase? body});

  ///Delete Raffle
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdDelete(
      {required String? raffleId}) {
    return _tombolaRafflesRaffleIdDelete(raffleId: raffleId);
  }

  ///Delete Raffle
  ///@param raffle_id
  @Delete(path: '/tombola/raffles/{raffle_id}')
  Future<chopper.Response> _tombolaRafflesRaffleIdDelete(
      {@Path('raffle_id') required String? raffleId});

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
  @Patch(
    path: '/tombola/raffles/{raffle_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _tombolaRafflesRaffleIdPatch({
    @Path('raffle_id') required String? raffleId,
    @Body() required RaffleEdit? body,
  });

  ///Get Raffles By Group Id
  ///@param group_id
  Future<chopper.Response<List<RaffleSimple>>> tombolaGroupGroupIdRafflesGet(
      {required String? groupId}) {
    generatedMapping.putIfAbsent(
        RaffleSimple, () => RaffleSimple.fromJsonFactory);

    return _tombolaGroupGroupIdRafflesGet(groupId: groupId);
  }

  ///Get Raffles By Group Id
  ///@param group_id
  @Get(path: '/tombola/group/{group_id}/raffles')
  Future<chopper.Response<List<RaffleSimple>>> _tombolaGroupGroupIdRafflesGet(
      {@Path('group_id') required String? groupId});

  ///Get Raffle Stats
  ///@param raffle_id
  Future<chopper.Response<RaffleStats>> tombolaRafflesRaffleIdStatsGet(
      {required String? raffleId}) {
    generatedMapping.putIfAbsent(
        RaffleStats, () => RaffleStats.fromJsonFactory);

    return _tombolaRafflesRaffleIdStatsGet(raffleId: raffleId);
  }

  ///Get Raffle Stats
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/stats')
  Future<chopper.Response<RaffleStats>> _tombolaRafflesRaffleIdStatsGet(
      {@Path('raffle_id') required String? raffleId});

  ///Read Raffle Logo
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdLogoGet(
      {required String? raffleId}) {
    return _tombolaRafflesRaffleIdLogoGet(raffleId: raffleId);
  }

  ///Read Raffle Logo
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/logo')
  Future<chopper.Response> _tombolaRafflesRaffleIdLogoGet(
      {@Path('raffle_id') required String? raffleId});

  ///Create Current Raffle Logo
  ///@param raffle_id
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      tombolaRafflesRaffleIdLogoPost({
    required String? raffleId,
    required BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost body,
  }) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _tombolaRafflesRaffleIdLogoPost(raffleId: raffleId, body: body);
  }

  ///Create Current Raffle Logo
  ///@param raffle_id
  @Post(
    path: '/tombola/raffles/{raffle_id}/logo',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _tombolaRafflesRaffleIdLogoPost({
    @Path('raffle_id') required String? raffleId,
    @Part()
    required BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost body,
  });

  ///Get Pack Tickets
  Future<chopper.Response<List<PackTicketSimple>>> tombolaPackTicketsGet() {
    generatedMapping.putIfAbsent(
        PackTicketSimple, () => PackTicketSimple.fromJsonFactory);

    return _tombolaPackTicketsGet();
  }

  ///Get Pack Tickets
  @Get(path: '/tombola/pack_tickets')
  Future<chopper.Response<List<PackTicketSimple>>> _tombolaPackTicketsGet();

  ///Create Packticket
  Future<chopper.Response<PackTicketSimple>> tombolaPackTicketsPost(
      {required PackTicketBase? body}) {
    generatedMapping.putIfAbsent(
        PackTicketSimple, () => PackTicketSimple.fromJsonFactory);

    return _tombolaPackTicketsPost(body: body);
  }

  ///Create Packticket
  @Post(
    path: '/tombola/pack_tickets',
    optionalBody: true,
  )
  Future<chopper.Response<PackTicketSimple>> _tombolaPackTicketsPost(
      {@Body() required PackTicketBase? body});

  ///Delete Packticket
  ///@param packticket_id
  Future<chopper.Response> tombolaPackTicketsPackticketIdDelete(
      {required String? packticketId}) {
    return _tombolaPackTicketsPackticketIdDelete(packticketId: packticketId);
  }

  ///Delete Packticket
  ///@param packticket_id
  @Delete(path: '/tombola/pack_tickets/{packticket_id}')
  Future<chopper.Response> _tombolaPackTicketsPackticketIdDelete(
      {@Path('packticket_id') required String? packticketId});

  ///Edit Packticket
  ///@param packticket_id
  Future<chopper.Response> tombolaPackTicketsPackticketIdPatch({
    required String? packticketId,
    required PackTicketEdit? body,
  }) {
    return _tombolaPackTicketsPackticketIdPatch(
        packticketId: packticketId, body: body);
  }

  ///Edit Packticket
  ///@param packticket_id
  @Patch(
    path: '/tombola/pack_tickets/{packticket_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _tombolaPackTicketsPackticketIdPatch({
    @Path('packticket_id') required String? packticketId,
    @Body() required PackTicketEdit? body,
  });

  ///Get Pack Tickets By Raffle Id
  ///@param raffle_id
  Future<chopper.Response<List<PackTicketSimple>>>
      tombolaRafflesRaffleIdPackTicketsGet({required String? raffleId}) {
    generatedMapping.putIfAbsent(
        PackTicketSimple, () => PackTicketSimple.fromJsonFactory);

    return _tombolaRafflesRaffleIdPackTicketsGet(raffleId: raffleId);
  }

  ///Get Pack Tickets By Raffle Id
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/pack_tickets')
  Future<chopper.Response<List<PackTicketSimple>>>
      _tombolaRafflesRaffleIdPackTicketsGet(
          {@Path('raffle_id') required String? raffleId});

  ///Get Tickets
  Future<chopper.Response<List<TicketSimple>>> tombolaTicketsGet() {
    generatedMapping.putIfAbsent(
        TicketSimple, () => TicketSimple.fromJsonFactory);

    return _tombolaTicketsGet();
  }

  ///Get Tickets
  @Get(path: '/tombola/tickets')
  Future<chopper.Response<List<TicketSimple>>> _tombolaTicketsGet();

  ///Buy Ticket
  ///@param pack_id
  Future<chopper.Response<List<TicketComplete>>> tombolaTicketsBuyPackIdPost(
      {required String? packId}) {
    generatedMapping.putIfAbsent(
        TicketComplete, () => TicketComplete.fromJsonFactory);

    return _tombolaTicketsBuyPackIdPost(packId: packId);
  }

  ///Buy Ticket
  ///@param pack_id
  @Post(
    path: '/tombola/tickets/buy/{pack_id}',
    optionalBody: true,
  )
  Future<chopper.Response<List<TicketComplete>>> _tombolaTicketsBuyPackIdPost(
      {@Path('pack_id') required String? packId});

  ///Get Tickets By Userid
  ///@param user_id
  Future<chopper.Response<List<TicketComplete>>> tombolaUsersUserIdTicketsGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        TicketComplete, () => TicketComplete.fromJsonFactory);

    return _tombolaUsersUserIdTicketsGet(userId: userId);
  }

  ///Get Tickets By Userid
  ///@param user_id
  @Get(path: '/tombola/users/{user_id}/tickets')
  Future<chopper.Response<List<TicketComplete>>> _tombolaUsersUserIdTicketsGet(
      {@Path('user_id') required String? userId});

  ///Get Tickets By Raffleid
  ///@param raffle_id
  Future<chopper.Response<List<TicketComplete>>>
      tombolaRafflesRaffleIdTicketsGet({required String? raffleId}) {
    generatedMapping.putIfAbsent(
        TicketComplete, () => TicketComplete.fromJsonFactory);

    return _tombolaRafflesRaffleIdTicketsGet(raffleId: raffleId);
  }

  ///Get Tickets By Raffleid
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/tickets')
  Future<chopper.Response<List<TicketComplete>>>
      _tombolaRafflesRaffleIdTicketsGet(
          {@Path('raffle_id') required String? raffleId});

  ///Get Prizes
  Future<chopper.Response<List<PrizeSimple>>> tombolaPrizesGet() {
    generatedMapping.putIfAbsent(
        PrizeSimple, () => PrizeSimple.fromJsonFactory);

    return _tombolaPrizesGet();
  }

  ///Get Prizes
  @Get(path: '/tombola/prizes')
  Future<chopper.Response<List<PrizeSimple>>> _tombolaPrizesGet();

  ///Create Prize
  Future<chopper.Response<PrizeSimple>> tombolaPrizesPost(
      {required PrizeBase? body}) {
    generatedMapping.putIfAbsent(
        PrizeSimple, () => PrizeSimple.fromJsonFactory);

    return _tombolaPrizesPost(body: body);
  }

  ///Create Prize
  @Post(
    path: '/tombola/prizes',
    optionalBody: true,
  )
  Future<chopper.Response<PrizeSimple>> _tombolaPrizesPost(
      {@Body() required PrizeBase? body});

  ///Delete Prize
  ///@param prize_id
  Future<chopper.Response> tombolaPrizesPrizeIdDelete(
      {required String? prizeId}) {
    return _tombolaPrizesPrizeIdDelete(prizeId: prizeId);
  }

  ///Delete Prize
  ///@param prize_id
  @Delete(path: '/tombola/prizes/{prize_id}')
  Future<chopper.Response> _tombolaPrizesPrizeIdDelete(
      {@Path('prize_id') required String? prizeId});

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
  @Patch(
    path: '/tombola/prizes/{prize_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _tombolaPrizesPrizeIdPatch({
    @Path('prize_id') required String? prizeId,
    @Body() required PrizeEdit? body,
  });

  ///Get Prizes By Raffleid
  ///@param raffle_id
  Future<chopper.Response<List<PrizeSimple>>> tombolaRafflesRaffleIdPrizesGet(
      {required String? raffleId}) {
    generatedMapping.putIfAbsent(
        PrizeSimple, () => PrizeSimple.fromJsonFactory);

    return _tombolaRafflesRaffleIdPrizesGet(raffleId: raffleId);
  }

  ///Get Prizes By Raffleid
  ///@param raffle_id
  @Get(path: '/tombola/raffles/{raffle_id}/prizes')
  Future<chopper.Response<List<PrizeSimple>>> _tombolaRafflesRaffleIdPrizesGet(
      {@Path('raffle_id') required String? raffleId});

  ///Read Prize Logo
  ///@param prize_id
  Future<chopper.Response> tombolaPrizesPrizeIdPictureGet(
      {required String? prizeId}) {
    return _tombolaPrizesPrizeIdPictureGet(prizeId: prizeId);
  }

  ///Read Prize Logo
  ///@param prize_id
  @Get(path: '/tombola/prizes/{prize_id}/picture')
  Future<chopper.Response> _tombolaPrizesPrizeIdPictureGet(
      {@Path('prize_id') required String? prizeId});

  ///Create Prize Picture
  ///@param prize_id
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      tombolaPrizesPrizeIdPicturePost({
    required String? prizeId,
    required BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost body,
  }) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _tombolaPrizesPrizeIdPicturePost(prizeId: prizeId, body: body);
  }

  ///Create Prize Picture
  ///@param prize_id
  @Post(
    path: '/tombola/prizes/{prize_id}/picture',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _tombolaPrizesPrizeIdPicturePost({
    @Path('prize_id') required String? prizeId,
    @Part() required BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost body,
  });

  ///Get Users Cash
  Future<chopper.Response<List<AppSchemasSchemasRaffleCashComplete>>>
      tombolaUsersCashGet() {
    generatedMapping.putIfAbsent(AppSchemasSchemasRaffleCashComplete,
        () => AppSchemasSchemasRaffleCashComplete.fromJsonFactory);

    return _tombolaUsersCashGet();
  }

  ///Get Users Cash
  @Get(path: '/tombola/users/cash')
  Future<chopper.Response<List<AppSchemasSchemasRaffleCashComplete>>>
      _tombolaUsersCashGet();

  ///Get Cash By Id
  ///@param user_id
  Future<chopper.Response<AppSchemasSchemasRaffleCashComplete>>
      tombolaUsersUserIdCashGet({required String? userId}) {
    generatedMapping.putIfAbsent(AppSchemasSchemasRaffleCashComplete,
        () => AppSchemasSchemasRaffleCashComplete.fromJsonFactory);

    return _tombolaUsersUserIdCashGet(userId: userId);
  }

  ///Get Cash By Id
  ///@param user_id
  @Get(path: '/tombola/users/{user_id}/cash')
  Future<chopper.Response<AppSchemasSchemasRaffleCashComplete>>
      _tombolaUsersUserIdCashGet({@Path('user_id') required String? userId});

  ///Create Cash Of User
  ///@param user_id
  Future<chopper.Response<AppSchemasSchemasRaffleCashComplete>>
      tombolaUsersUserIdCashPost({
    required String? userId,
    required AppSchemasSchemasRaffleCashEdit? body,
  }) {
    generatedMapping.putIfAbsent(AppSchemasSchemasRaffleCashComplete,
        () => AppSchemasSchemasRaffleCashComplete.fromJsonFactory);

    return _tombolaUsersUserIdCashPost(userId: userId, body: body);
  }

  ///Create Cash Of User
  ///@param user_id
  @Post(
    path: '/tombola/users/{user_id}/cash',
    optionalBody: true,
  )
  Future<chopper.Response<AppSchemasSchemasRaffleCashComplete>>
      _tombolaUsersUserIdCashPost({
    @Path('user_id') required String? userId,
    @Body() required AppSchemasSchemasRaffleCashEdit? body,
  });

  ///Edit Cash By Id
  ///@param user_id
  Future<chopper.Response> tombolaUsersUserIdCashPatch({
    required String? userId,
    required AppSchemasSchemasRaffleCashEdit? body,
  }) {
    return _tombolaUsersUserIdCashPatch(userId: userId, body: body);
  }

  ///Edit Cash By Id
  ///@param user_id
  @Patch(
    path: '/tombola/users/{user_id}/cash',
    optionalBody: true,
  )
  Future<chopper.Response> _tombolaUsersUserIdCashPatch({
    @Path('user_id') required String? userId,
    @Body() required AppSchemasSchemasRaffleCashEdit? body,
  });

  ///Draw Winner
  ///@param prize_id
  Future<chopper.Response<List<TicketComplete>>> tombolaPrizesPrizeIdDrawPost(
      {required String? prizeId}) {
    generatedMapping.putIfAbsent(
        TicketComplete, () => TicketComplete.fromJsonFactory);

    return _tombolaPrizesPrizeIdDrawPost(prizeId: prizeId);
  }

  ///Draw Winner
  ///@param prize_id
  @Post(
    path: '/tombola/prizes/{prize_id}/draw',
    optionalBody: true,
  )
  Future<chopper.Response<List<TicketComplete>>> _tombolaPrizesPrizeIdDrawPost(
      {@Path('prize_id') required String? prizeId});

  ///Open Raffle
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdOpenPatch(
      {required String? raffleId}) {
    return _tombolaRafflesRaffleIdOpenPatch(raffleId: raffleId);
  }

  ///Open Raffle
  ///@param raffle_id
  @Patch(
    path: '/tombola/raffles/{raffle_id}/open',
    optionalBody: true,
  )
  Future<chopper.Response> _tombolaRafflesRaffleIdOpenPatch(
      {@Path('raffle_id') required String? raffleId});

  ///Lock Raffle
  ///@param raffle_id
  Future<chopper.Response> tombolaRafflesRaffleIdLockPatch(
      {required String? raffleId}) {
    return _tombolaRafflesRaffleIdLockPatch(raffleId: raffleId);
  }

  ///Lock Raffle
  ///@param raffle_id
  @Patch(
    path: '/tombola/raffles/{raffle_id}/lock',
    optionalBody: true,
  )
  Future<chopper.Response> _tombolaRafflesRaffleIdLockPatch(
      {@Path('raffle_id') required String? raffleId});

  ///Read Users
  Future<chopper.Response<List<CoreUserSimple>>> usersGet() {
    generatedMapping.putIfAbsent(
        CoreUserSimple, () => CoreUserSimple.fromJsonFactory);

    return _usersGet();
  }

  ///Read Users
  @Get(path: '/users/')
  Future<chopper.Response<List<CoreUserSimple>>> _usersGet();

  ///Count Users
  Future<chopper.Response<int>> usersCountGet() {
    return _usersCountGet();
  }

  ///Count Users
  @Get(path: '/users/count')
  Future<chopper.Response<int>> _usersCountGet();

  ///Search Users
  ///@param query
  ///@param includedGroups
  ///@param excludedGroups
  Future<chopper.Response<List<CoreUserSimple>>> usersSearchGet({
    required String? query,
    List<String>? includedGroups,
    List<String>? excludedGroups,
  }) {
    generatedMapping.putIfAbsent(
        CoreUserSimple, () => CoreUserSimple.fromJsonFactory);

    return _usersSearchGet(
        query: query,
        includedGroups: includedGroups,
        excludedGroups: excludedGroups);
  }

  ///Search Users
  ///@param query
  ///@param includedGroups
  ///@param excludedGroups
  @Get(path: '/users/search')
  Future<chopper.Response<List<CoreUserSimple>>> _usersSearchGet({
    @Query('query') required String? query,
    @Query('includedGroups') List<String>? includedGroups,
    @Query('excludedGroups') List<String>? excludedGroups,
  });

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
  @Patch(
    path: '/users/me',
    optionalBody: true,
  )
  Future<chopper.Response> _usersMePatch(
      {@Body() required CoreUserUpdate? body});

  ///Create User By User
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      usersCreatePost({required CoreUserCreateRequest? body}) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _usersCreatePost(body: body);
  }

  ///Create User By User
  @Post(
    path: '/users/create',
    optionalBody: true,
  )
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _usersCreatePost({@Body() required CoreUserCreateRequest? body});

  ///Batch Create Users
  Future<chopper.Response<BatchResult>> usersBatchCreationPost(
      {required List<CoreBatchUserCreateRequest>? body}) {
    generatedMapping.putIfAbsent(
        BatchResult, () => BatchResult.fromJsonFactory);

    return _usersBatchCreationPost(body: body);
  }

  ///Batch Create Users
  @Post(
    path: '/users/batch-creation',
    optionalBody: true,
  )
  Future<chopper.Response<BatchResult>> _usersBatchCreationPost(
      {@Body() required List<CoreBatchUserCreateRequest>? body});

  ///Get User Activation Page
  ///@param activation_token
  Future<chopper.Response<String>> usersActivateGet(
      {required String? activationToken}) {
    return _usersActivateGet(activationToken: activationToken);
  }

  ///Get User Activation Page
  ///@param activation_token
  @Get(path: '/users/activate')
  Future<chopper.Response<String>> _usersActivateGet(
      {@Query('activation_token') required String? activationToken});

  ///Activate User
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      usersActivatePost({required CoreUserActivateRequest? body}) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _usersActivatePost(body: body);
  }

  ///Activate User
  @Post(
    path: '/users/activate',
    optionalBody: true,
  )
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _usersActivatePost({@Body() required CoreUserActivateRequest? body});

  ///Make Admin
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      usersMakeAdminPost() {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _usersMakeAdminPost();
  }

  ///Make Admin
  @Post(
    path: '/users/make-admin',
    optionalBody: true,
  )
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _usersMakeAdminPost();

  ///Recover User
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      usersRecoverPost({required BodyRecoverUserUsersRecoverPost? body}) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _usersRecoverPost(body: body);
  }

  ///Recover User
  @Post(
    path: '/users/recover',
    optionalBody: true,
  )
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _usersRecoverPost(
          {@Body() required BodyRecoverUserUsersRecoverPost? body});

  ///Reset Password
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      usersResetPasswordPost({required ResetPasswordRequest? body}) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _usersResetPasswordPost(body: body);
  }

  ///Reset Password
  @Post(
    path: '/users/reset-password',
    optionalBody: true,
  )
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _usersResetPasswordPost({@Body() required ResetPasswordRequest? body});

  ///Migrate Mail
  Future<chopper.Response> usersMigrateMailPost(
      {required MailMigrationRequest? body}) {
    return _usersMigrateMailPost(body: body);
  }

  ///Migrate Mail
  @Post(
    path: '/users/migrate-mail',
    optionalBody: true,
  )
  Future<chopper.Response> _usersMigrateMailPost(
      {@Body() required MailMigrationRequest? body});

  ///Migrate Mail Confirm
  ///@param token
  Future<chopper.Response> usersMigrateMailConfirmGet(
      {required String? token}) {
    return _usersMigrateMailConfirmGet(token: token);
  }

  ///Migrate Mail Confirm
  ///@param token
  @Get(path: '/users/migrate-mail-confirm')
  Future<chopper.Response> _usersMigrateMailConfirmGet(
      {@Query('token') required String? token});

  ///Change Password
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      usersChangePasswordPost({required ChangePasswordRequest? body}) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _usersChangePasswordPost(body: body);
  }

  ///Change Password
  @Post(
    path: '/users/change-password',
    optionalBody: true,
  )
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
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
  Future<chopper.Response<CoreUser>> _usersUserIdGet(
      {@Path('user_id') required String? userId});

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
  @Patch(
    path: '/users/{user_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _usersUserIdPatch({
    @Path('user_id') required String? userId,
    @Body() required CoreUserUpdateAdmin? body,
  });

  ///Delete User
  Future<chopper.Response> usersMeAskDeletionPost() {
    return _usersMeAskDeletionPost();
  }

  ///Delete User
  @Post(
    path: '/users/me/ask-deletion',
    optionalBody: true,
  )
  Future<chopper.Response> _usersMeAskDeletionPost();

  ///Read Own Profile Picture
  Future<chopper.Response> usersMeProfilePictureGet() {
    return _usersMeProfilePictureGet();
  }

  ///Read Own Profile Picture
  @Get(path: '/users/me/profile-picture')
  Future<chopper.Response> _usersMeProfilePictureGet();

  ///Create Current User Profile Picture
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      usersMeProfilePicturePost(
          {required BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost
              body}) {
    generatedMapping.putIfAbsent(AppUtilsTypesStandardResponsesResult,
        () => AppUtilsTypesStandardResponsesResult.fromJsonFactory);

    return _usersMeProfilePicturePost(body: body);
  }

  ///Create Current User Profile Picture
  @Post(
    path: '/users/me/profile-picture',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppUtilsTypesStandardResponsesResult>>
      _usersMeProfilePicturePost(
          {@Part()
          required BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost
              body});

  ///Read User Profile Picture
  ///@param user_id
  Future<chopper.Response> usersUserIdProfilePictureGet(
      {required String? userId}) {
    return _usersUserIdProfilePictureGet(userId: userId);
  }

  ///Read User Profile Picture
  ///@param user_id
  @Get(path: '/users/{user_id}/profile-picture')
  Future<chopper.Response> _usersUserIdProfilePictureGet(
      {@Path('user_id') required String? userId});

  ///Get Games Played On
  ///@param time
  Future<chopper.Response<List<Game>>> elocapsGamesGet(
      {required String? time}) {
    generatedMapping.putIfAbsent(Game, () => Game.fromJsonFactory);

    return _elocapsGamesGet(time: time);
  }

  ///Get Games Played On
  ///@param time
  @Get(path: '/elocaps/games')
  Future<chopper.Response<List<Game>>> _elocapsGamesGet(
      {@Query('time') required String? time});

  ///Register Game
  Future<chopper.Response<Game>> elocapsGamesPost(
      {required GameCreateRequest? body}) {
    generatedMapping.putIfAbsent(Game, () => Game.fromJsonFactory);

    return _elocapsGamesPost(body: body);
  }

  ///Register Game
  @Post(
    path: '/elocaps/games',
    optionalBody: true,
  )
  Future<chopper.Response<Game>> _elocapsGamesPost(
      {@Body() required GameCreateRequest? body});

  ///Get Latest Games
  Future<chopper.Response<List<Game>>> elocapsGamesLatestGet() {
    generatedMapping.putIfAbsent(Game, () => Game.fromJsonFactory);

    return _elocapsGamesLatestGet();
  }

  ///Get Latest Games
  @Get(path: '/elocaps/games/latest')
  Future<chopper.Response<List<Game>>> _elocapsGamesLatestGet();

  ///Get Waiting Games
  Future<chopper.Response<List<GameMode>>> elocapsGamesWaitingGet() {
    generatedMapping.putIfAbsent(GameMode, () => GameMode.fromJsonFactory);

    return _elocapsGamesWaitingGet();
  }

  ///Get Waiting Games
  @Get(path: '/elocaps/games/waiting')
  Future<chopper.Response<List<GameMode>>> _elocapsGamesWaitingGet();

  ///Get Game Detail
  ///@param game_id
  Future<chopper.Response<Game>> elocapsGamesGameIdGet(
      {required String? gameId}) {
    generatedMapping.putIfAbsent(Game, () => Game.fromJsonFactory);

    return _elocapsGamesGameIdGet(gameId: gameId);
  }

  ///Get Game Detail
  ///@param game_id
  @Get(path: '/elocaps/games/{game_id}')
  Future<chopper.Response<Game>> _elocapsGamesGameIdGet(
      {@Path('game_id') required String? gameId});

  ///Confirm Game
  ///@param game_id
  Future<chopper.Response<Game>> elocapsGamesGameIdValidatePost(
      {required String? gameId}) {
    generatedMapping.putIfAbsent(Game, () => Game.fromJsonFactory);

    return _elocapsGamesGameIdValidatePost(gameId: gameId);
  }

  ///Confirm Game
  ///@param game_id
  @Post(
    path: '/elocaps/games/{game_id}/validate',
    optionalBody: true,
  )
  Future<chopper.Response<Game>> _elocapsGamesGameIdValidatePost(
      {@Path('game_id') required String? gameId});

  ///Get Player Games
  ///@param user_id
  Future<chopper.Response<List<Game>>> elocapsPlayersUserIdGamesGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(Game, () => Game.fromJsonFactory);

    return _elocapsPlayersUserIdGamesGet(userId: userId);
  }

  ///Get Player Games
  ///@param user_id
  @Get(path: '/elocaps/players/{user_id}/games')
  Future<chopper.Response<List<Game>>> _elocapsPlayersUserIdGamesGet(
      {@Path('user_id') required String? userId});

  ///Get Player Info
  ///@param user_id
  Future<chopper.Response<DetailedPlayer>> elocapsPlayersUserIdGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        DetailedPlayer, () => DetailedPlayer.fromJsonFactory);

    return _elocapsPlayersUserIdGet(userId: userId);
  }

  ///Get Player Info
  ///@param user_id
  @Get(path: '/elocaps/players/{user_id}')
  Future<chopper.Response<DetailedPlayer>> _elocapsPlayersUserIdGet(
      {@Path('user_id') required String? userId});

  ///Get Leaderboard
  ///@param mode
  Future<chopper.Response<List<PlayerBase>>> elocapsLeaderboardGet(
      {required enums.CapsMode? mode}) {
    generatedMapping.putIfAbsent(PlayerBase, () => PlayerBase.fromJsonFactory);

    return _elocapsLeaderboardGet(mode: mode?.value?.toString());
  }

  ///Get Leaderboard
  ///@param mode
  @Get(path: '/elocaps/leaderboard')
  Future<chopper.Response<List<PlayerBase>>> _elocapsLeaderboardGet(
      {@Query('mode') required String? mode});
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
      chopper.Response response) async {
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
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
