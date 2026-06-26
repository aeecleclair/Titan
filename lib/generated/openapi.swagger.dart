// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element_parameter

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
import 'openapi.enums.swagger.dart'
    show
        AccountType,
        ActivationFormField,
        AmapSlotType,
        AnswerBooleanAnswerType,
        AnswerNumberAnswerType,
        AnswerTextAnswerType,
        AnswerType,
        CdrStatus,
        CompetitionGroupType,
        Decision,
        DeliveryStatusType,
        Difficulty,
        DocumentSignatureType,
        DocumentType,
        DocumentValidation,
        ExcelExportParams,
        HistoryDirection,
        HistoryType,
        ListType,
        MeetingPlace,
        NewsStatus,
        PaiementMethodType,
        PaymentType,
        PlantState,
        ProductPublicType,
        ProductSchoolType,
        PropagationMethod,
        RaffleStatusType,
        RequestStatus,
        RequestType,
        Size,
        SpeciesType,
        SportCategory,
        StatusType,
        TokenResponseTokenType,
        TransactionStatus,
        TransactionType,
        TransferOrigin,
        TransferType,
        WalletDeviceStatus,
        WalletType;
import 'openapi.metadata.swagger.dart';
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
  @GET(path: '/recommendation/recommendations')
  Future<chopper.Response<List<Recommendation>>>
  _recommendationRecommendationsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get recommendations.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Recommendation',
      operationId: 'get_recommendation_recommendations',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Recommendation"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/recommendation/recommendations', optionalBody: true)
  Future<chopper.Response<Recommendation>> _recommendationRecommendationsPost({
    @Body() required RecommendationBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a recommendation.

**This endpoint is only usable by members of the group BDE**''',
      summary: 'Create Recommendation',
      operationId: 'post_recommendation_recommendations',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Recommendation"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/recommendation/recommendations/{recommendation_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _recommendationRecommendationsRecommendationIdPatch({
    @Path('recommendation_id') required String? recommendationId,
    @Body() required RecommendationEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a recommendation.

**This endpoint is only usable by members of the group BDE**''',
      summary: 'Edit Recommendation',
      operationId: 'patch_recommendation_recommendations_{recommendation_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Recommendation"],
      deprecated: false,
    ),
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
  @DELETE(path: '/recommendation/recommendations/{recommendation_id}')
  Future<chopper.Response>
  _recommendationRecommendationsRecommendationIdDelete({
    @Path('recommendation_id') required String? recommendationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a recommendation.

**This endpoint is only usable by members of the group BDE**''',
      summary: 'Delete Recommendation',
      operationId: 'delete_recommendation_recommendations_{recommendation_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Recommendation"],
      deprecated: false,
    ),
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
  @GET(path: '/recommendation/recommendations/{recommendation_id}/picture')
  Future<chopper.Response>
  _recommendationRecommendationsRecommendationIdPictureGet({
    @Path('recommendation_id') required String? recommendationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the image of a recommendation.

**The user must be authenticated to use this endpoint**''',
      summary: 'Read Recommendation Image',
      operationId:
          'get_recommendation_recommendations_{recommendation_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Recommendation"],
      deprecated: false,
    ),
  });

  ///Create Recommendation Image
  ///@param recommendation_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  recommendationRecommendationsRecommendationIdPicturePost({
    required String? recommendationId,
    required List<int> image,
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
  @POST(
    path: '/recommendation/recommendations/{recommendation_id}/picture',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _recommendationRecommendationsRecommendationIdPicturePost({
    @Path('recommendation_id') required String? recommendationId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add an image to a recommendation.

**This endpoint is only usable by members of the group BDE**''',
      summary: 'Create Recommendation Image',
      operationId:
          'post_recommendation_recommendations_{recommendation_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Recommendation"],
      deprecated: false,
    ),
  });

  ///Read Loaners
  Future<chopper.Response<List<Loaner>>> loansLoanersGet() {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansLoanersGet();
  }

  ///Read Loaners
  @GET(path: '/loans/loaners/')
  Future<chopper.Response<List<Loaner>>> _loansLoanersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get existing loaners.

**This endpoint is only usable by administrators**''',
      summary: 'Read Loaners',
      operationId: 'get_loans_loaners_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
  });

  ///Create Loaner
  Future<chopper.Response<Loaner>> loansLoanersPost({
    required LoanerBase? body,
  }) {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansLoanersPost(body: body);
  }

  ///Create Loaner
  @POST(path: '/loans/loaners/', optionalBody: true)
  Future<chopper.Response<Loaner>> _loansLoanersPost({
    @Body() required LoanerBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new loaner.

Each loaner is associated with a `manager_group`. Users belonging to this group are able to manage the loaner items and loans.

**This endpoint is only usable by administrators**''',
      summary: 'Create Loaner',
      operationId: 'post_loans_loaners_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @DELETE(path: '/loans/loaners/{loaner_id}')
  Future<chopper.Response> _loansLoanersLoanerIdDelete({
    @Path('loaner_id') required String? loanerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Delete a loaner. All items and loans associated with the loaner will also be deleted from the database.

**This endpoint is only usable by administrators**''',
      summary: 'Delete Loaner',
      operationId: 'delete_loans_loaners_{loaner_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @PATCH(path: '/loans/loaners/{loaner_id}', optionalBody: true)
  Future<chopper.Response> _loansLoanersLoanerIdPatch({
    @Path('loaner_id') required String? loanerId,
    @Body() required LoanerUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Update a loaner, the request should contain a JSON with the fields to change (not necessarily all fields) and their new value.

**This endpoint is only usable by administrators**''',
      summary: 'Update Loaner',
      operationId: 'patch_loans_loaners_{loaner_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @GET(path: '/loans/loaners/{loaner_id}/loans')
  Future<chopper.Response<List<Loan>>> _loansLoanersLoanerIdLoansGet({
    @Path('loaner_id') required String? loanerId,
    @Query('returned') bool? returned,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all loans from a given group.


The query string `returned` can be used to get only return or non returned loans. By default, all loans are returned.


**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Get Loans By Loaner',
      operationId: 'get_loans_loaners_{loaner_id}_loans',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @GET(path: '/loans/loaners/{loaner_id}/items')
  Future<chopper.Response<List<Item>>> _loansLoanersLoanerIdItemsGet({
    @Path('loaner_id') required String? loanerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all items of a loaner.

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Get Items By Loaner',
      operationId: 'get_loans_loaners_{loaner_id}_items',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @POST(path: '/loans/loaners/{loaner_id}/items', optionalBody: true)
  Future<chopper.Response<Item>> _loansLoanersLoanerIdItemsPost({
    @Path('loaner_id') required String? loanerId,
    @Body() required ItemBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Create a new item for a loaner. A given loaner can not have more than one item with the same `name`.

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Create Items For Loaner',
      operationId: 'post_loans_loaners_{loaner_id}_items',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @PATCH(path: '/loans/loaners/{loaner_id}/items/{item_id}', optionalBody: true)
  Future<chopper.Response> _loansLoanersLoanerIdItemsItemIdPatch({
    @Path('loaner_id') required String? loanerId,
    @Path('item_id') required String? itemId,
    @Body() required ItemUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a loaner\'s item.

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Update Items For Loaner',
      operationId: 'patch_loans_loaners_{loaner_id}_items_{item_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @DELETE(path: '/loans/loaners/{loaner_id}/items/{item_id}')
  Future<chopper.Response> _loansLoanersLoanerIdItemsItemIdDelete({
    @Path('loaner_id') required String? loanerId,
    @Path('item_id') required String? itemId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a loaner\'s item.
This will remove the item from all loans but won\'t delete any loan.

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Delete Loaner Item',
      operationId: 'delete_loans_loaners_{loaner_id}_items_{item_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
  });

  ///Get Current User Loans
  ///@param returned
  Future<chopper.Response<List<Loan>>> loansUsersMeGet({bool? returned}) {
    generatedMapping.putIfAbsent(Loan, () => Loan.fromJsonFactory);

    return _loansUsersMeGet(returned: returned);
  }

  ///Get Current User Loans
  ///@param returned
  @GET(path: '/loans/users/me')
  Future<chopper.Response<List<Loan>>> _loansUsersMeGet({
    @Query('returned') bool? returned,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all loans from the current user.

The query string `returned` can be used to get only returned or non returned loans. By default, all loans are returned.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Current User Loans',
      operationId: 'get_loans_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
  });

  ///Get Current User Loaners
  Future<chopper.Response<List<Loaner>>> loansUsersMeLoanersGet() {
    generatedMapping.putIfAbsent(Loaner, () => Loaner.fromJsonFactory);

    return _loansUsersMeLoanersGet();
  }

  ///Get Current User Loaners
  @GET(path: '/loans/users/me/loaners')
  Future<chopper.Response<List<Loaner>>> _loansUsersMeLoanersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all loaners the current user can manage.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Current User Loaners',
      operationId: 'get_loans_users_me_loaners',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
  });

  ///Create Loan
  Future<chopper.Response<Loan>> loansPost({required LoanCreation? body}) {
    generatedMapping.putIfAbsent(Loan, () => Loan.fromJsonFactory);

    return _loansPost(body: body);
  }

  ///Create Loan
  @POST(path: '/loans/', optionalBody: true)
  Future<chopper.Response<Loan>> _loansPost({
    @Body() required LoanCreation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new loan in database and add the requested items

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Create Loan',
      operationId: 'post_loans_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @PATCH(path: '/loans/{loan_id}', optionalBody: true)
  Future<chopper.Response> _loansLoanIdPatch({
    @Path('loan_id') required String? loanId,
    @Body() required LoanUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a loan and its items.

As the endpoint can update the loan items, it will send back
the new representation of the loan `Loan` including the new items relationships

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Update Loan',
      operationId: 'patch_loans_{loan_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
  });

  ///Delete Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdDelete({required String? loanId}) {
    return _loansLoanIdDelete(loanId: loanId);
  }

  ///Delete Loan
  ///@param loan_id
  @DELETE(path: '/loans/{loan_id}')
  Future<chopper.Response> _loansLoanIdDelete({
    @Path('loan_id') required String? loanId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a loan
This will remove the loan but won\'t delete any loaner items.

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Delete Loan',
      operationId: 'delete_loans_{loan_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
  });

  ///Return Loan
  ///@param loan_id
  Future<chopper.Response> loansLoanIdReturnPost({required String? loanId}) {
    return _loansLoanIdReturnPost(loanId: loanId);
  }

  ///Return Loan
  ///@param loan_id
  @POST(path: '/loans/{loan_id}/return', optionalBody: true)
  Future<chopper.Response> _loansLoanIdReturnPost({
    @Path('loan_id') required String? loanId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Mark a loan as returned. This will update items availability.

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Return Loan',
      operationId: 'post_loans_{loan_id}_return',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
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
  @POST(path: '/loans/{loan_id}/extend', optionalBody: true)
  Future<chopper.Response> _loansLoanIdExtendPost({
    @Path('loan_id') required String? loanId,
    @Body() required LoanExtend? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''A new `end` date or an extended `duration` can be provided. If the two are provided, only `end` will be used.

**The user must be a member of the loaner group_manager to use this endpoint**''',
      summary: 'Extend Loan',
      operationId: 'post_loans_{loan_id}_extend',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Loans"],
      deprecated: false,
    ),
  });

  ///Get Events
  Future<chopper.Response<List<EventCompleteTicketUrl>>> calendarEventsGet() {
    generatedMapping.putIfAbsent(
      EventCompleteTicketUrl,
      () => EventCompleteTicketUrl.fromJsonFactory,
    );

    return _calendarEventsGet();
  }

  ///Get Events
  @GET(path: '/calendar/events/')
  Future<chopper.Response<List<EventCompleteTicketUrl>>> _calendarEventsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all events from the database.',
      summary: 'Get Events',
      operationId: 'get_calendar_events_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Add Event
  Future<chopper.Response<EventCompleteTicketUrl>> calendarEventsPost({
    required EventBaseCreation? body,
  }) {
    generatedMapping.putIfAbsent(
      EventCompleteTicketUrl,
      () => EventCompleteTicketUrl.fromJsonFactory,
    );

    return _calendarEventsPost(body: body);
  }

  ///Add Event
  @POST(path: '/calendar/events/', optionalBody: true)
  Future<chopper.Response<EventCompleteTicketUrl>> _calendarEventsPost({
    @Body() required EventBaseCreation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Add an event to the calendar.',
      summary: 'Add Event',
      operationId: 'post_calendar_events_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Get Confirmed Events
  Future<chopper.Response<List<EventCompleteTicketUrl>>>
  calendarEventsConfirmedGet() {
    generatedMapping.putIfAbsent(
      EventCompleteTicketUrl,
      () => EventCompleteTicketUrl.fromJsonFactory,
    );

    return _calendarEventsConfirmedGet();
  }

  ///Get Confirmed Events
  @GET(path: '/calendar/events/confirmed')
  Future<chopper.Response<List<EventCompleteTicketUrl>>>
  _calendarEventsConfirmedGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all confirmed events.

**Usable by every member**''',
      summary: 'Get Confirmed Events',
      operationId: 'get_calendar_events_confirmed',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Get Association Events
  ///@param association_id
  Future<chopper.Response<List<EventCompleteTicketUrl>>>
  calendarEventsAssociationsAssociationIdGet({required String? associationId}) {
    generatedMapping.putIfAbsent(
      EventCompleteTicketUrl,
      () => EventCompleteTicketUrl.fromJsonFactory,
    );

    return _calendarEventsAssociationsAssociationIdGet(
      associationId: associationId,
    );
  }

  ///Get Association Events
  ///@param association_id
  @GET(path: '/calendar/events/associations/{association_id}')
  Future<chopper.Response<List<EventCompleteTicketUrl>>>
  _calendarEventsAssociationsAssociationIdGet({
    @Path('association_id') required String? associationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the booking of the association

**Usable by members of the association**''',
      summary: 'Get Association Events',
      operationId: 'get_calendar_events_associations_{association_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Get Event By Id
  ///@param event_id
  Future<chopper.Response<EventCompleteTicketUrl>> calendarEventsEventIdGet({
    required String? eventId,
  }) {
    generatedMapping.putIfAbsent(
      EventCompleteTicketUrl,
      () => EventCompleteTicketUrl.fromJsonFactory,
    );

    return _calendarEventsEventIdGet(eventId: eventId);
  }

  ///Get Event By Id
  ///@param event_id
  @GET(path: '/calendar/events/{event_id}')
  Future<chopper.Response<EventCompleteTicketUrl>> _calendarEventsEventIdGet({
    @Path('event_id') required String? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get an event\'s information by its id.

**Non approved events are only accessible for BDE or the event\'s association members**''',
      summary: 'Get Event By Id',
      operationId: 'get_calendar_events_{event_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Edit Envent
  ///@param event_id
  Future<chopper.Response> calendarEventsEventIdPatch({
    required String? eventId,
    required EventEdit? body,
  }) {
    return _calendarEventsEventIdPatch(eventId: eventId, body: body);
  }

  ///Edit Envent
  ///@param event_id
  @PATCH(path: '/calendar/events/{event_id}', optionalBody: true)
  Future<chopper.Response> _calendarEventsEventIdPatch({
    @Path('event_id') required String? eventId,
    @Body() required EventEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit an event.

**Only usable by admins or members of the event\'s association**''',
      summary: 'Edit Envent',
      operationId: 'patch_calendar_events_{event_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Delete Event
  ///@param event_id
  Future<chopper.Response> calendarEventsEventIdDelete({
    required Object? eventId,
  }) {
    return _calendarEventsEventIdDelete(eventId: eventId);
  }

  ///Delete Event
  ///@param event_id
  @DELETE(path: '/calendar/events/{event_id}')
  Future<chopper.Response> _calendarEventsEventIdDelete({
    @Path('event_id') required Object? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Remove an event.

**Only usable by admins or, if the event is pending, members of the event\'s association**''',
      summary: 'Delete Event',
      operationId: 'delete_calendar_events_{event_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Get Event Ticket Url
  ///@param event_id
  Future<chopper.Response<EventTicketUrl>> calendarEventsEventIdTicketUrlGet({
    required String? eventId,
  }) {
    generatedMapping.putIfAbsent(
      EventTicketUrl,
      () => EventTicketUrl.fromJsonFactory,
    );

    return _calendarEventsEventIdTicketUrlGet(eventId: eventId);
  }

  ///Get Event Ticket Url
  ///@param event_id
  @GET(path: '/calendar/events/{event_id}/ticket-url')
  Future<chopper.Response<EventTicketUrl>> _calendarEventsEventIdTicketUrlGet({
    @Path('event_id') required String? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Event Ticket Url',
      operationId: 'get_calendar_events_{event_id}_ticket-url',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Get Event Image
  ///@param event_id
  Future<chopper.Response> calendarEventsEventIdImageGet({
    required String? eventId,
  }) {
    return _calendarEventsEventIdImageGet(eventId: eventId);
  }

  ///Get Event Image
  ///@param event_id
  @GET(path: '/calendar/events/{event_id}/image')
  Future<chopper.Response> _calendarEventsEventIdImageGet({
    @Path('event_id') required String? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the image of an event

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Event Image',
      operationId: 'get_calendar_events_{event_id}_image',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Create Event Image
  ///@param event_id
  Future<chopper.Response> calendarEventsEventIdImagePost({
    required String? eventId,
    required List<int> image,
  }) {
    return _calendarEventsEventIdImagePost(eventId: eventId, image: image);
  }

  ///Create Event Image
  ///@param event_id
  @POST(path: '/calendar/events/{event_id}/image', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _calendarEventsEventIdImagePost({
    @Path('event_id') required String? eventId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add an image to an event

**The user must be authenticated to use this endpoint**''',
      summary: 'Create Event Image',
      operationId: 'post_calendar_events_{event_id}_image',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Confirm Event
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

  ///Confirm Event
  ///@param event_id
  ///@param decision
  @PATCH(
    path: '/calendar/events/{event_id}/reply/{decision}',
    optionalBody: true,
  )
  Future<chopper.Response> _calendarEventsEventIdReplyDecisionPatch({
    @Path('event_id') required String? eventId,
    @Path('decision') required String? decision,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Give a decision to an event.

**Only usable by admins**''',
      summary: 'Confirm Event',
      operationId: 'patch_calendar_events_{event_id}_reply_{decision}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Get Ical Url
  Future<chopper.Response<IcalSecret>> calendarIcalUrlGet() {
    generatedMapping.putIfAbsent(IcalSecret, () => IcalSecret.fromJsonFactory);

    return _calendarIcalUrlGet();
  }

  ///Get Ical Url
  @GET(path: '/calendar/ical-url')
  Future<chopper.Response<IcalSecret>> _calendarIcalUrlGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Generate a unique ical url for the user',
      summary: 'Get Ical Url',
      operationId: 'get_calendar_ical-url',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Recreate Ical File
  Future<chopper.Response> calendarIcalCreatePost() {
    return _calendarIcalCreatePost();
  }

  ///Recreate Ical File
  @POST(path: '/calendar/ical/create', optionalBody: true)
  Future<chopper.Response> _calendarIcalCreatePost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create manually the icalendar file

**Only usable by global admins**''',
      summary: 'Recreate Ical File',
      operationId: 'post_calendar_ical_create',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Calendar"],
      deprecated: false,
    ),
  });

  ///Get Icalendar File
  ///@param secret
  Future<chopper.Response> calendarIcalGet({required String? secret}) {
    return _calendarIcalGet(secret: secret);
  }

  ///Get Icalendar File
  ///@param secret
  @GET(path: '/calendar/ical')
  Future<chopper.Response> _calendarIcalGet({
    @Query('secret') required String? secret,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get the icalendar file corresponding to the event in the database.',
      summary: 'Get Icalendar File',
      operationId: 'get_calendar_ical',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Calendar"],
      deprecated: false,
    ),
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
  @GET(path: '/cinema/themoviedb/{themoviedb_id}')
  Future<chopper.Response<TheMovieDB>> _cinemaThemoviedbThemoviedbIdGet({
    @Path('themoviedb_id') required String? themoviedbId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Makes a HTTP request to The Movie Database (TMDB)
using an API key and returns a TheMovieDB object
* https://developer.themoviedb.org/reference/movie-details
* https://developer.themoviedb.org/docs/errors''',
      summary: 'Get Movie',
      operationId: 'get_cinema_themoviedb_{themoviedb_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cinema"],
      deprecated: false,
    ),
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
  @GET(path: '/cinema/sessions')
  Future<chopper.Response<List<CineSessionComplete>>> _cinemaSessionsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Sessions',
      operationId: 'get_cinema_sessions',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cinema"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/cinema/sessions', optionalBody: true)
  Future<chopper.Response<CineSessionComplete>> _cinemaSessionsPost({
    @Body() required CineSessionBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Session',
      operationId: 'post_cinema_sessions',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cinema"],
      deprecated: false,
    ),
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
  @PATCH(path: '/cinema/sessions/{session_id}', optionalBody: true)
  Future<chopper.Response> _cinemaSessionsSessionIdPatch({
    @Path('session_id') required String? sessionId,
    @Body() required CineSessionUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Session',
      operationId: 'patch_cinema_sessions_{session_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cinema"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cinema/sessions/{session_id}')
  Future<chopper.Response> _cinemaSessionsSessionIdDelete({
    @Path('session_id') required String? sessionId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Session',
      operationId: 'delete_cinema_sessions_{session_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cinema"],
      deprecated: false,
    ),
  });

  ///Create Campaigns Logo
  ///@param session_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  cinemaSessionsSessionIdPosterPost({
    required String? sessionId,
    required List<int> image,
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
  @POST(path: '/cinema/sessions/{session_id}/poster', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _cinemaSessionsSessionIdPosterPost({
    @Path('session_id') required String? sessionId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Campaigns Logo',
      operationId: 'post_cinema_sessions_{session_id}_poster',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cinema"],
      deprecated: false,
    ),
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
  @GET(path: '/cinema/sessions/{session_id}/poster')
  Future<chopper.Response> _cinemaSessionsSessionIdPosterGet({
    @Path('session_id') required String? sessionId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Read Session Poster',
      operationId: 'get_cinema_sessions_{session_id}_poster',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cinema"],
      deprecated: false,
    ),
  });

  ///Get Managers
  Future<chopper.Response<List<Manager>>> bookingManagersGet() {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersGet();
  }

  ///Get Managers
  @GET(path: '/booking/managers')
  Future<chopper.Response<List<Manager>>> _bookingManagersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get existing managers.

**This endpoint is only usable by administrators**''',
      summary: 'Get Managers',
      operationId: 'get_booking_managers',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

  ///Create Manager
  Future<chopper.Response<Manager>> bookingManagersPost({
    required ManagerBase? body,
  }) {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersPost(body: body);
  }

  ///Create Manager
  @POST(path: '/booking/managers', optionalBody: true)
  Future<chopper.Response<Manager>> _bookingManagersPost({
    @Body() required ManagerBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a manager.

**This endpoint is only usable by administrators**''',
      summary: 'Create Manager',
      operationId: 'post_booking_managers',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @PATCH(path: '/booking/managers/{manager_id}', optionalBody: true)
  Future<chopper.Response> _bookingManagersManagerIdPatch({
    @Path('manager_id') required String? managerId,
    @Body() required ManagerUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Update a manager, the request should contain a JSON with the fields to change (not necessarily all fields) and their new value.

**This endpoint is only usable by administrators**''',
      summary: 'Update Manager',
      operationId: 'patch_booking_managers_{manager_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @DELETE(path: '/booking/managers/{manager_id}')
  Future<chopper.Response> _bookingManagersManagerIdDelete({
    @Path('manager_id') required String? managerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Delete a manager only if the manager is not linked to any room

**This endpoint is only usable by administrators**''',
      summary: 'Delete Manager',
      operationId: 'delete_booking_managers_{manager_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

  ///Get Current User Managers
  Future<chopper.Response<List<Manager>>> bookingManagersUsersMeGet() {
    generatedMapping.putIfAbsent(Manager, () => Manager.fromJsonFactory);

    return _bookingManagersUsersMeGet();
  }

  ///Get Current User Managers
  @GET(path: '/booking/managers/users/me')
  Future<chopper.Response<List<Manager>>> _bookingManagersUsersMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all managers the current user is a member.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Current User Managers',
      operationId: 'get_booking_managers_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/booking/bookings/users/me/manage')
  Future<chopper.Response<List<BookingReturnApplicant>>>
  _bookingBookingsUsersMeManageGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all bookings a user can manage.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Bookings For Manager',
      operationId: 'get_booking_bookings_users_me_manage',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/booking/bookings/confirmed/users/me/manage')
  Future<chopper.Response<List<BookingReturnApplicant>>>
  _bookingBookingsConfirmedUsersMeManageGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all confirmed bookings a user can manage.
**The user must be authenticated to use this endpoint**''',
      summary: 'Get Confirmed Bookings For Manager',
      operationId: 'get_booking_bookings_confirmed_users_me_manage',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/booking/bookings/confirmed')
  Future<chopper.Response<List<BookingReturnSimpleApplicant>>>
  _bookingBookingsConfirmedGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all confirmed bookings.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Confirmed Bookings',
      operationId: 'get_booking_bookings_confirmed',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

  ///Get Applicant Bookings
  Future<chopper.Response<List<BookingReturn>>> bookingBookingsUsersMeGet() {
    generatedMapping.putIfAbsent(
      BookingReturn,
      () => BookingReturn.fromJsonFactory,
    );

    return _bookingBookingsUsersMeGet();
  }

  ///Get Applicant Bookings
  @GET(path: '/booking/bookings/users/me')
  Future<chopper.Response<List<BookingReturn>>> _bookingBookingsUsersMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the user bookings.

**Only usable by the user**''',
      summary: 'Get Applicant Bookings',
      operationId: 'get_booking_bookings_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/booking/bookings', optionalBody: true)
  Future<chopper.Response<BookingReturn>> _bookingBookingsPost({
    @Body() required BookingBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a booking.

**The user must be authenticated to use this endpoint**''',
      summary: 'Create Booking',
      operationId: 'post_booking_bookings',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @PATCH(path: '/booking/bookings/{booking_id}', optionalBody: true)
  Future<chopper.Response> _bookingBookingsBookingIdPatch({
    @Path('booking_id') required String? bookingId,
    @Body() required BookingEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a booking.

**Only usable by a user in the manager group of the booking or applicant before decision**''',
      summary: 'Edit Booking',
      operationId: 'patch_booking_bookings_{booking_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @DELETE(path: '/booking/bookings/{booking_id}')
  Future<chopper.Response> _bookingBookingsBookingIdDelete({
    @Path('booking_id') required String? bookingId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Remove a booking.

**Only usable by the applicant before decision**''',
      summary: 'Delete Booking',
      operationId: 'delete_booking_bookings_{booking_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/booking/bookings/{booking_id}/reply/{decision}',
    optionalBody: true,
  )
  Future<chopper.Response> _bookingBookingsBookingIdReplyDecisionPatch({
    @Path('booking_id') required String? bookingId,
    @Path('decision') required String? decision,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Give a decision to a booking.

**Only usable by a user in the manager group of the booking**''',
      summary: 'Confirm Booking',
      operationId: 'patch_booking_bookings_{booking_id}_reply_{decision}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @GET(path: '/booking/rooms')
  Future<chopper.Response<List<RoomComplete>>> _bookingRoomsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all rooms.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Rooms',
      operationId: 'get_booking_rooms',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/booking/rooms', optionalBody: true)
  Future<chopper.Response<RoomComplete>> _bookingRoomsPost({
    @Body() required RoomBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new room in database.

**This endpoint is only usable by admins**''',
      summary: 'Create Room',
      operationId: 'post_booking_rooms',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @PATCH(path: '/booking/rooms/{room_id}', optionalBody: true)
  Future<chopper.Response> _bookingRoomsRoomIdPatch({
    @Path('room_id') required String? roomId,
    @Body() required RoomBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a room.

**This endpoint is only usable by admins**''',
      summary: 'Edit Room',
      operationId: 'patch_booking_rooms_{room_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
  });

  ///Delete Room
  ///@param room_id
  Future<chopper.Response> bookingRoomsRoomIdDelete({required String? roomId}) {
    return _bookingRoomsRoomIdDelete(roomId: roomId);
  }

  ///Delete Room
  ///@param room_id
  @DELETE(path: '/booking/rooms/{room_id}')
  Future<chopper.Response> _bookingRoomsRoomIdDelete({
    @Path('room_id') required String? roomId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Delete a room only if there are not future or ongoing bookings of this room

**This endpoint is only usable by admins**''',
      summary: 'Delete Room',
      operationId: 'delete_booking_rooms_{room_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Booking"],
      deprecated: false,
    ),
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
  @GET(path: '/seed_library/species/')
  Future<chopper.Response<List<SpeciesComplete>>> _seedLibrarySpeciesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all species from database as a list of SpeciesComplete schemas',
      summary: 'Get All Species',
      operationId: 'get_seed_library_species_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/seed_library/species/', optionalBody: true)
  Future<chopper.Response<SpeciesComplete>> _seedLibrarySpeciesPost({
    @Body() required SpeciesBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new Species by giving an SpeciesBase scheme
**This endpoint is only usable by seed_library **''',
      summary: 'Create Species',
      operationId: 'post_seed_library_species_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @GET(path: '/seed_library/species/types')
  Future<chopper.Response<SpeciesTypesReturn>> _seedLibrarySpeciesTypesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all available types of species from SpeciesType enum.',
      summary: 'Get All Species Types',
      operationId: 'get_seed_library_species_types',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
  });

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
  @PATCH(path: '/seed_library/species/{species_id}', optionalBody: true)
  Future<chopper.Response> _seedLibrarySpeciesSpeciesIdPatch({
    @Path('species_id') required String? speciesId,
    @Body() required SpeciesEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a Species
**This endpoint is only usable by seed_library**''',
      summary: 'Update Species',
      operationId: 'patch_seed_library_species_{species_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @DELETE(path: '/seed_library/species/{species_id}')
  Future<chopper.Response> _seedLibrarySpeciesSpeciesIdDelete({
    @Path('species_id') required String? speciesId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a Species
**This endpoint is only usable by seed_library**''',
      summary: 'Delete Species',
      operationId: 'delete_seed_library_species_{species_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @GET(path: '/seed_library/plants/waiting')
  Future<chopper.Response<List<PlantSimple>>> _seedLibraryPlantsWaitingGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all plants where state=waiting from database as a list of PlantsComplete schemas',
      summary: 'Get Waiting Plants',
      operationId: 'get_seed_library_plants_waiting',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
  });

  ///Get My Plants
  Future<chopper.Response<List<PlantSimple>>> seedLibraryPlantsUsersMeGet() {
    generatedMapping.putIfAbsent(
      PlantSimple,
      () => PlantSimple.fromJsonFactory,
    );

    return _seedLibraryPlantsUsersMeGet();
  }

  ///Get My Plants
  @GET(path: '/seed_library/plants/users/me')
  Future<chopper.Response<List<PlantSimple>>> _seedLibraryPlantsUsersMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all plants where user ={user_id} from database as a list of PlantsComplete schemas',
      summary: 'Get My Plants',
      operationId: 'get_seed_library_plants_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/seed_library/plants/users/{user_id}')
  Future<chopper.Response<List<PlantSimple>>> _seedLibraryPlantsUsersUserIdGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all plants where borrower_id = {user_id} from database as a list of PlantsComplete schemas',
      summary: 'Get Plants By User Id',
      operationId: 'get_seed_library_plants_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @GET(path: '/seed_library/plants/{plant_id}')
  Future<chopper.Response<PlantComplete>> _seedLibraryPlantsPlantIdGet({
    @Path('plant_id') required String? plantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return the plants where plant ={plant_id} from database as a PlantsComplete schemas',
      summary: 'Get Plant By Id',
      operationId: 'get_seed_library_plants_{plant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @PATCH(path: '/seed_library/plants/{plant_id}', optionalBody: true)
  Future<chopper.Response> _seedLibraryPlantsPlantIdPatch({
    @Path('plant_id') required String? plantId,
    @Body() required PlantEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a Plant
**This endpoint is only usable by the owner of the plant**''',
      summary: 'Update Plant',
      operationId: 'patch_seed_library_plants_{plant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @DELETE(path: '/seed_library/plants/{plant_id}')
  Future<chopper.Response> _seedLibraryPlantsPlantIdDelete({
    @Path('plant_id') required String? plantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a Plant
**This endpoint is only usable by seed_library**''',
      summary: 'Delete Plant',
      operationId: 'delete_seed_library_plants_{plant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
  });

  ///Create Plant
  Future<chopper.Response<PlantSimple>> seedLibraryPlantsPost({
    required PlantCreation? body,
  }) {
    generatedMapping.putIfAbsent(
      PlantSimple,
      () => PlantSimple.fromJsonFactory,
    );

    return _seedLibraryPlantsPost(body: body);
  }

  ///Create Plant
  @POST(path: '/seed_library/plants/', optionalBody: true)
  Future<chopper.Response<PlantSimple>> _seedLibraryPlantsPost({
    @Body() required PlantCreation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new Plant by giving an PlantCreation scheme
**This endpoint is only usable if the plant has an ancestor_id or by seed_library **''',
      summary: 'Create Plant',
      operationId: 'post_seed_library_plants_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @PATCH(path: '/seed_library/plants/{plant_id}/admin', optionalBody: true)
  Future<chopper.Response> _seedLibraryPlantsPlantIdAdminPatch({
    @Path('plant_id') required String? plantId,
    @Body() required PlantEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a Plant
**This endpoint is only usable by seed_library**''',
      summary: 'Update Plant Admin',
      operationId: 'patch_seed_library_plants_{plant_id}_admin',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @PATCH(path: '/seed_library/plants/{plant_id}/borrow', optionalBody: true)
  Future<chopper.Response> _seedLibraryPlantsPlantIdBorrowPatch({
    @Path('plant_id') required String? plantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Plant borrowed by the user (modify borrowing date, borrower and state)',
      summary: 'Borrow Plant',
      operationId: 'patch_seed_library_plants_{plant_id}_borrow',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
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
  @GET(path: '/seed_library/information')
  Future<chopper.Response<SeedLibraryInformation>> _seedLibraryInformationGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Seed Library Information',
      operationId: 'get_seed_library_information',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
  });

  ///Update Seed Library Information
  Future<chopper.Response> seedLibraryInformationPatch({
    required SeedLibraryInformation? body,
  }) {
    return _seedLibraryInformationPatch(body: body);
  }

  ///Update Seed Library Information
  @PATCH(path: '/seed_library/information', optionalBody: true)
  Future<chopper.Response> _seedLibraryInformationPatch({
    @Body() required SeedLibraryInformation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Seed Library Information',
      operationId: 'patch_seed_library_information',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["seed_library"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/phonebook/associations/')
  Future<chopper.Response<List<AssociationComplete>>>
  _phonebookAssociationsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all associations from database as a list of AssociationComplete schemas',
      summary: 'Get All Associations',
      operationId: 'get_phonebook_associations_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

  ///Create Association
  Future<chopper.Response<AssociationComplete>> phonebookAssociationsPost({
    required AppModulesPhonebookSchemasPhonebookAssociationBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AssociationComplete,
      () => AssociationComplete.fromJsonFactory,
    );

    return _phonebookAssociationsPost(body: body);
  }

  ///Create Association
  @POST(path: '/phonebook/associations/', optionalBody: true)
  Future<chopper.Response<AssociationComplete>> _phonebookAssociationsPost({
    @Body() required AppModulesPhonebookSchemasPhonebookAssociationBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Create a new Association by giving an AssociationBase scheme',
      summary: 'Create Association',
      operationId: 'post_phonebook_associations_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @GET(path: '/phonebook/roletags')
  Future<chopper.Response<RoleTagsReturn>> _phonebookRoletagsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all available role tags from RoleTags enum.',
      summary: 'Get All Role Tags',
      operationId: 'get_phonebook_roletags',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

  ///Get All Groupements
  Future<chopper.Response<List<AssociationGroupement>>>
  phonebookGroupementsGet() {
    generatedMapping.putIfAbsent(
      AssociationGroupement,
      () => AssociationGroupement.fromJsonFactory,
    );

    return _phonebookGroupementsGet();
  }

  ///Get All Groupements
  @GET(path: '/phonebook/groupements/')
  Future<chopper.Response<List<AssociationGroupement>>>
  _phonebookGroupementsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all groupements from database as a list of AssociationGroupement schemas',
      summary: 'Get All Groupements',
      operationId: 'get_phonebook_groupements_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

  ///Create Groupement
  Future<chopper.Response<AssociationGroupement>> phonebookGroupementsPost({
    required AssociationGroupementBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AssociationGroupement,
      () => AssociationGroupement.fromJsonFactory,
    );

    return _phonebookGroupementsPost(body: body);
  }

  ///Create Groupement
  @POST(path: '/phonebook/groupements/', optionalBody: true)
  Future<chopper.Response<AssociationGroupement>> _phonebookGroupementsPost({
    @Body() required AssociationGroupementBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Groupement',
      operationId: 'post_phonebook_groupements_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

  ///Update Groupement
  ///@param groupement_id
  Future<chopper.Response> phonebookGroupementsGroupementIdPatch({
    required String? groupementId,
    required AssociationGroupementBase? body,
  }) {
    return _phonebookGroupementsGroupementIdPatch(
      groupementId: groupementId,
      body: body,
    );
  }

  ///Update Groupement
  ///@param groupement_id
  @PATCH(path: '/phonebook/groupements/{groupement_id}', optionalBody: true)
  Future<chopper.Response> _phonebookGroupementsGroupementIdPatch({
    @Path('groupement_id') required String? groupementId,
    @Body() required AssociationGroupementBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update a groupement',
      summary: 'Update Groupement',
      operationId: 'patch_phonebook_groupements_{groupement_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

  ///Delete Groupement
  ///@param groupement_id
  Future<chopper.Response> phonebookGroupementsGroupementIdDelete({
    required String? groupementId,
  }) {
    return _phonebookGroupementsGroupementIdDelete(groupementId: groupementId);
  }

  ///Delete Groupement
  ///@param groupement_id
  @DELETE(path: '/phonebook/groupements/{groupement_id}')
  Future<chopper.Response> _phonebookGroupementsGroupementIdDelete({
    @Path('groupement_id') required String? groupementId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a groupement',
      summary: 'Delete Groupement',
      operationId: 'delete_phonebook_groupements_{groupement_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

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
  @PATCH(path: '/phonebook/associations/{association_id}', optionalBody: true)
  Future<chopper.Response> _phonebookAssociationsAssociationIdPatch({
    @Path('association_id') required String? associationId,
    @Body() required AssociationEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update an Association',
      summary: 'Update Association',
      operationId: 'patch_phonebook_associations_{association_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @DELETE(path: '/phonebook/associations/{association_id}')
  Future<chopper.Response> _phonebookAssociationsAssociationIdDelete({
    @Path('association_id') required String? associationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete an Association

[!] Memberships linked to association_id will be deleted too''',
      summary: 'Delete Association',
      operationId: 'delete_phonebook_associations_{association_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/phonebook/associations/{association_id}/groups',
    optionalBody: true,
  )
  Future<chopper.Response> _phonebookAssociationsAssociationIdGroupsPatch({
    @Path('association_id') required String? associationId,
    @Body() required AssociationGroupsEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update the groups associated with an Association',
      summary: 'Update Association Groups',
      operationId: 'patch_phonebook_associations_{association_id}_groups',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/phonebook/associations/{association_id}/deactivate',
    optionalBody: true,
  )
  Future<chopper.Response> _phonebookAssociationsAssociationIdDeactivatePatch({
    @Path('association_id') required String? associationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Deactivate an Association',
      summary: 'Deactivate Association',
      operationId: 'patch_phonebook_associations_{association_id}_deactivate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @GET(path: '/phonebook/associations/{association_id}/members/')
  Future<chopper.Response<List<MemberComplete>>>
  _phonebookAssociationsAssociationIdMembersGet({
    @Path('association_id') required String? associationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return the list of MemberComplete of an Association.',
      summary: 'Get Association Members',
      operationId: 'get_phonebook_associations_{association_id}_members_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @GET(path: '/phonebook/associations/{association_id}/members/{mandate_year}')
  Future<chopper.Response<List<MemberComplete>>>
  _phonebookAssociationsAssociationIdMembersMandateYearGet({
    @Path('association_id') required String? associationId,
    @Path('mandate_year') required int? mandateYear,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return the list of MemberComplete of an Association with given mandate_year.',
      summary: 'Get Association Members By Mandate Year',
      operationId:
          'get_phonebook_associations_{association_id}_members_{mandate_year}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @GET(path: '/phonebook/member/{user_id}')
  Future<chopper.Response<MemberComplete>> _phonebookMemberUserIdGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return MemberComplete for given user_id.',
      summary: 'Get Member Details',
      operationId: 'get_phonebook_member_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @POST(path: '/phonebook/associations/memberships', optionalBody: true)
  Future<chopper.Response<MembershipComplete>>
  _phonebookAssociationsMembershipsPost({
    @Body() required AppModulesPhonebookSchemasPhonebookMembershipBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new Membership.
\'role_tags\' are used to indicate if the members has a main role in the association (president, secretary ...) and \'role_name\' is the display name for this membership''',
      summary: 'Create Membership',
      operationId: 'post_phonebook_associations_memberships',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/phonebook/associations/memberships/{membership_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _phonebookAssociationsMembershipsMembershipIdPatch({
    @Path('membership_id') required String? membershipId,
    @Body() required MembershipEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update a Membership.',
      summary: 'Update Membership',
      operationId: 'patch_phonebook_associations_memberships_{membership_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @DELETE(path: '/phonebook/associations/memberships/{membership_id}')
  Future<chopper.Response> _phonebookAssociationsMembershipsMembershipIdDelete({
    @Path('membership_id') required String? membershipId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a membership.',
      summary: 'Delete Membership',
      operationId: 'delete_phonebook_associations_memberships_{membership_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

  ///Create Association Logo
  ///@param association_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  phonebookAssociationsAssociationIdPicturePost({
    required String? associationId,
    required List<int> image,
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
  @POST(
    path: '/phonebook/associations/{association_id}/picture',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _phonebookAssociationsAssociationIdPicturePost({
    @Path('association_id') required String? associationId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Upload a logo for an Association.

**The user must be a member of the group phonebook_admin or the president of the association to use this endpoint**''',
      summary: 'Create Association Logo',
      operationId: 'post_phonebook_associations_{association_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
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
  @GET(path: '/phonebook/associations/{association_id}/picture')
  Future<chopper.Response> _phonebookAssociationsAssociationIdPictureGet({
    @Path('association_id') required String? associationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get the logo of an Association.',
      summary: 'Read Association Logo',
      operationId: 'get_phonebook_associations_{association_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Phonebook"],
      deprecated: false,
    ),
  });

  ///Read Adverts
  ///@param advertisers
  Future<chopper.Response<List<AdvertComplete>>> advertAdvertsGet({
    List<String>? advertisers,
  }) {
    generatedMapping.putIfAbsent(
      AdvertComplete,
      () => AdvertComplete.fromJsonFactory,
    );

    return _advertAdvertsGet(advertisers: advertisers);
  }

  ///Read Adverts
  ///@param advertisers
  @GET(path: '/advert/adverts')
  Future<chopper.Response<List<AdvertComplete>>> _advertAdvertsGet({
    @Query('advertisers') List<String>? advertisers,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get existing adverts. If advertisers optional parameter is used, search adverts by advertisers

**The user must be authenticated to use this endpoint**''',
      summary: 'Read Adverts',
      operationId: 'get_advert_adverts',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Advert"],
      deprecated: false,
    ),
  });

  ///Create Advert
  Future<chopper.Response<AdvertComplete>> advertAdvertsPost({
    required AdvertBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AdvertComplete,
      () => AdvertComplete.fromJsonFactory,
    );

    return _advertAdvertsPost(body: body);
  }

  ///Create Advert
  @POST(path: '/advert/adverts', optionalBody: true)
  Future<chopper.Response<AdvertComplete>> _advertAdvertsPost({
    @Body() required AdvertBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new advert

**The user must be a member of the advertiser group to use this endpoint**''',
      summary: 'Create Advert',
      operationId: 'post_advert_adverts',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Advert"],
      deprecated: false,
    ),
  });

  ///Read Advert
  ///@param advert_id
  Future<chopper.Response<AdvertComplete>> advertAdvertsAdvertIdGet({
    required String? advertId,
  }) {
    generatedMapping.putIfAbsent(
      AdvertComplete,
      () => AdvertComplete.fromJsonFactory,
    );

    return _advertAdvertsAdvertIdGet(advertId: advertId);
  }

  ///Read Advert
  ///@param advert_id
  @GET(path: '/advert/adverts/{advert_id}')
  Future<chopper.Response<AdvertComplete>> _advertAdvertsAdvertIdGet({
    @Path('advert_id') required String? advertId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get an advert

**The user must be authenticated to use this endpoint**''',
      summary: 'Read Advert',
      operationId: 'get_advert_adverts_{advert_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Advert"],
      deprecated: false,
    ),
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
  @PATCH(path: '/advert/adverts/{advert_id}', optionalBody: true)
  Future<chopper.Response> _advertAdvertsAdvertIdPatch({
    @Path('advert_id') required String? advertId,
    @Body() required AdvertUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit an advert

**The user must be a member of the advertiser group_manager to use this endpoint**''',
      summary: 'Update Advert',
      operationId: 'patch_advert_adverts_{advert_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Advert"],
      deprecated: false,
    ),
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
  @DELETE(path: '/advert/adverts/{advert_id}')
  Future<chopper.Response> _advertAdvertsAdvertIdDelete({
    @Path('advert_id') required String? advertId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete an advert

**The user must be admin or a member of the advertiser group_manager to use this endpoint**''',
      summary: 'Delete Advert',
      operationId: 'delete_advert_adverts_{advert_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Advert"],
      deprecated: false,
    ),
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
  @GET(path: '/advert/adverts/{advert_id}/picture')
  Future<chopper.Response> _advertAdvertsAdvertIdPictureGet({
    @Path('advert_id') required String? advertId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the image of an advert

**The user must be authenticated to use this endpoint**''',
      summary: 'Read Advert Image',
      operationId: 'get_advert_adverts_{advert_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Advert"],
      deprecated: false,
    ),
  });

  ///Create Advert Image
  ///@param advert_id
  Future<chopper.Response> advertAdvertsAdvertIdPicturePost({
    required String? advertId,
    required List<int> image,
  }) {
    return _advertAdvertsAdvertIdPicturePost(advertId: advertId, image: image);
  }

  ///Create Advert Image
  ///@param advert_id
  @POST(path: '/advert/adverts/{advert_id}/picture', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _advertAdvertsAdvertIdPicturePost({
    @Path('advert_id') required String? advertId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add an image to an advert

**The user must be authenticated to use this endpoint**''',
      summary: 'Create Advert Image',
      operationId: 'post_advert_adverts_{advert_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Advert"],
      deprecated: false,
    ),
  });

  ///Get Cdr Users
  Future<chopper.Response<List<CdrUserPreview>>> cdrUsersGet() {
    generatedMapping.putIfAbsent(
      CdrUserPreview,
      () => CdrUserPreview.fromJsonFactory,
    );

    return _cdrUsersGet();
  }

  ///Get Cdr Users
  @GET(path: '/cdr/users/')
  Future<chopper.Response<List<CdrUserPreview>>> _cdrUsersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all users.

**User must be part of a seller group to use this endpoint**''',
      summary: 'Get Cdr Users',
      operationId: 'get_cdr_users_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Cdr Users Pending Validation
  Future<chopper.Response<List<CdrUserPreview>>> cdrUsersPendingGet() {
    generatedMapping.putIfAbsent(
      CdrUserPreview,
      () => CdrUserPreview.fromJsonFactory,
    );

    return _cdrUsersPendingGet();
  }

  ///Get Cdr Users Pending Validation
  @GET(path: '/cdr/users/pending/')
  Future<chopper.Response<List<CdrUserPreview>>> _cdrUsersPendingGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all users that have non-validated purchases.

**User must be part of a seller group to use this endpoint**''',
      summary: 'Get Cdr Users Pending Validation',
      operationId: 'get_cdr_users_pending_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/cdr/users/{user_id}/')
  Future<chopper.Response<CdrUser>> _cdrUsersUserIdGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user.

**User must be part of a seller group or trying to get itself to use this endpoint**''',
      summary: 'Get Cdr User',
      operationId: 'get_cdr_users_{user_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @PATCH(path: '/cdr/users/{user_id}/', optionalBody: true)
  Future<chopper.Response> _cdrUsersUserIdPatch({
    @Path('user_id') required String? userId,
    @Body() required CdrUserUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a user email, nickname and/or floor.

An email will be send to the user, to confirm its new address.

**User must be part of a seller group to use this endpoint**''',
      summary: 'Update Cdr User',
      operationId: 'patch_cdr_users_{user_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/sellers/')
  Future<chopper.Response<List<SellerComplete>>> _cdrSellersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all sellers.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Get Sellers',
      operationId: 'get_cdr_sellers_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/cdr/sellers/', optionalBody: true)
  Future<chopper.Response<SellerComplete>> _cdrSellersPost({
    @Body() required SellerBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a seller.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Create Seller',
      operationId: 'post_cdr_sellers_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/users/me/sellers/')
  Future<chopper.Response<List<SellerComplete>>> _cdrUsersMeSellersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get sellers user is part of the group. If user is adminCDR, returns all sellers.

**User must be authenticated to use this endpoint**''',
      summary: 'Get Sellers By User Id',
      operationId: 'get_cdr_users_me_sellers_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Online Sellers
  Future<chopper.Response<List<SellerComplete>>> cdrOnlineSellersGet() {
    generatedMapping.putIfAbsent(
      SellerComplete,
      () => SellerComplete.fromJsonFactory,
    );

    return _cdrOnlineSellersGet();
  }

  ///Get Online Sellers
  @GET(path: '/cdr/online/sellers/')
  Future<chopper.Response<List<SellerComplete>>> _cdrOnlineSellersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all sellers that has online available products.

**User must be authenticated to use this endpoint**''',
      summary: 'Get Online Sellers',
      operationId: 'get_cdr_online_sellers_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Send Seller Results
  ///@param seller_id
  Future<chopper.Response> cdrSellersSellerIdResultsGet({
    required String? sellerId,
  }) {
    return _cdrSellersSellerIdResultsGet(sellerId: sellerId);
  }

  ///Send Seller Results
  ///@param seller_id
  @GET(path: '/cdr/sellers/{seller_id}/results/')
  Future<chopper.Response> _cdrSellersSellerIdResultsGet({
    @Path('seller_id') required String? sellerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a seller\'s results.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Send Seller Results',
      operationId: 'get_cdr_sellers_{seller_id}_results_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/online/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrOnlineProductsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a seller\'s online available products.

**User must be authenticated to use this endpoint**''',
      summary: 'Get All Available Online Products',
      operationId: 'get_cdr_online_products_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/cdr/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrProductsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a seller\'s online available products.

**User must be part of a seller group to use this endpoint**''',
      summary: 'Get All Products',
      operationId: 'get_cdr_products_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @PATCH(path: '/cdr/sellers/{seller_id}/', optionalBody: true)
  Future<chopper.Response> _cdrSellersSellerIdPatch({
    @Path('seller_id') required String? sellerId,
    @Body() required SellerEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a seller.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Update Seller',
      operationId: 'patch_cdr_sellers_{seller_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cdr/sellers/{seller_id}/')
  Future<chopper.Response> _cdrSellersSellerIdDelete({
    @Path('seller_id') required String? sellerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a seller.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Delete Seller',
      operationId: 'delete_cdr_sellers_{seller_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/sellers/{seller_id}/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrSellersSellerIdProductsGet({
    @Path('seller_id') required String? sellerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a seller\'s products.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Get Products By Seller Id',
      operationId: 'get_cdr_sellers_{seller_id}_products_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Create Product
  ///@param seller_id
  Future<chopper.Response<AppModulesCdrSchemasCdrProductComplete>>
  cdrSellersSellerIdProductsPost({
    required String? sellerId,
    required AppModulesCdrSchemasCdrProductBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductComplete,
      () => AppModulesCdrSchemasCdrProductComplete.fromJsonFactory,
    );

    return _cdrSellersSellerIdProductsPost(sellerId: sellerId, body: body);
  }

  ///Create Product
  ///@param seller_id
  @POST(path: '/cdr/sellers/{seller_id}/products/', optionalBody: true)
  Future<chopper.Response<AppModulesCdrSchemasCdrProductComplete>>
  _cdrSellersSellerIdProductsPost({
    @Path('seller_id') required String? sellerId,
    @Body() required AppModulesCdrSchemasCdrProductBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a product.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Create Product',
      operationId: 'post_cdr_sellers_{seller_id}_products_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/online/sellers/{seller_id}/products/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrOnlineSellersSellerIdProductsGet({
    @Path('seller_id') required String? sellerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a seller\'s online available products.

**User must be authenticated to use this endpoint**''',
      summary: 'Get Available Online Products',
      operationId: 'get_cdr_online_sellers_{seller_id}_products_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/',
    optionalBody: true,
  )
  Future<chopper.Response> _cdrSellersSellerIdProductsProductIdPatch({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required AppModulesCdrSchemasCdrProductEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a product.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Update Product',
      operationId: 'patch_cdr_sellers_{seller_id}_products_{product_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cdr/sellers/{seller_id}/products/{product_id}/')
  Future<chopper.Response> _cdrSellersSellerIdProductsProductIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a product.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Delete Product',
      operationId: 'delete_cdr_sellers_{seller_id}_products_{product_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Create Product Variant
  ///@param seller_id
  ///@param product_id
  Future<chopper.Response<AppModulesCdrSchemasCdrProductVariantComplete>>
  cdrSellersSellerIdProductsProductIdVariantsPost({
    required String? sellerId,
    required String? productId,
    required AppModulesCdrSchemasCdrProductVariantBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrProductVariantComplete,
      () => AppModulesCdrSchemasCdrProductVariantComplete.fromJsonFactory,
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
  @POST(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/variants/',
    optionalBody: true,
  )
  Future<chopper.Response<AppModulesCdrSchemasCdrProductVariantComplete>>
  _cdrSellersSellerIdProductsProductIdVariantsPost({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required AppModulesCdrSchemasCdrProductVariantBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a product variant.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Create Product Variant',
      operationId:
          'post_cdr_sellers_{seller_id}_products_{product_id}_variants_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
    required AppModulesCdrSchemasCdrProductVariantEdit? body,
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
  @PATCH(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/variants/{variant_id}/',
    optionalBody: true,
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdVariantsVariantIdPatch({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('variant_id') required String? variantId,
    @Body() required AppModulesCdrSchemasCdrProductVariantEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a product variant.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Update Product Variant',
      operationId:
          'patch_cdr_sellers_{seller_id}_products_{product_id}_variants_{variant_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/variants/{variant_id}/',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdVariantsVariantIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('variant_id') required String? variantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a product variant.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Delete Product Variant',
      operationId:
          'delete_cdr_sellers_{seller_id}_products_{product_id}_variants_{variant_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/sellers/{seller_id}/documents/')
  Future<chopper.Response<List<DocumentComplete>>>
  _cdrSellersSellerIdDocumentsGet({
    @Path('seller_id') required String? sellerId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a seller\'s documents.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Get Seller Documents',
      operationId: 'get_cdr_sellers_{seller_id}_documents_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @POST(path: '/cdr/sellers/{seller_id}/documents/', optionalBody: true)
  Future<chopper.Response<DocumentComplete>> _cdrSellersSellerIdDocumentsPost({
    @Path('seller_id') required String? sellerId,
    @Body() required DocumentBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a document.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Create Document',
      operationId: 'post_cdr_sellers_{seller_id}_documents_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/documents/')
  Future<chopper.Response<List<DocumentComplete>>> _cdrDocumentsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a seller\'s documents.

**User must be part of a seller\'s group to use this endpoint**''',
      summary: 'Get All Sellers Documents',
      operationId: 'get_cdr_documents_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @DELETE(path: '/cdr/sellers/{seller_id}/documents/{document_id}/')
  Future<chopper.Response> _cdrSellersSellerIdDocumentsDocumentIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('document_id') required String? documentId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a document.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Delete Document',
      operationId: 'delete_cdr_sellers_{seller_id}_documents_{document_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/users/{user_id}/purchases/')
  Future<chopper.Response<List<PurchaseReturn>>> _cdrUsersUserIdPurchasesGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user\'s purchases.

**User must get his own purchases or be CDR Admin to use this endpoint**''',
      summary: 'Get Purchases By User Id',
      operationId: 'get_cdr_users_{user_id}_purchases_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/me/purchases/')
  Future<chopper.Response<List<PurchaseReturn>>> _cdrMePurchasesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get My Purchases',
      operationId: 'get_cdr_me_purchases_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get All My Purchases
  Future<chopper.Response<List<PurchaseReturn>>> cdrMePurchasesAllGet() {
    generatedMapping.putIfAbsent(
      PurchaseReturn,
      () => PurchaseReturn.fromJsonFactory,
    );

    return _cdrMePurchasesAllGet();
  }

  ///Get All My Purchases
  @GET(path: '/cdr/me/purchases/all')
  Future<chopper.Response<List<PurchaseReturn>>> _cdrMePurchasesAllGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get All My Purchases',
      operationId: 'get_cdr_me_purchases_all',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/cdr/sellers/{seller_id}/users/{user_id}/purchases/')
  Future<chopper.Response<List<PurchaseReturn>>>
  _cdrSellersSellerIdUsersUserIdPurchasesGet({
    @Path('seller_id') required String? sellerId,
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user\'s purchases.

**User must get his own purchases or be part of the seller\'s group to use this endpoint**''',
      summary: 'Get Purchases By User Id By Seller Id',
      operationId: 'get_cdr_sellers_{seller_id}_users_{user_id}_purchases_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Create Purchase
  ///@param user_id
  ///@param product_variant_id
  Future<chopper.Response<AppModulesCdrSchemasCdrPurchaseComplete>>
  cdrUsersUserIdPurchasesProductVariantIdPost({
    required String? userId,
    required String? productVariantId,
    required AppModulesCdrSchemasCdrPurchaseBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrPurchaseComplete,
      () => AppModulesCdrSchemasCdrPurchaseComplete.fromJsonFactory,
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
  @POST(
    path: '/cdr/users/{user_id}/purchases/{product_variant_id}/',
    optionalBody: true,
  )
  Future<chopper.Response<AppModulesCdrSchemasCdrPurchaseComplete>>
  _cdrUsersUserIdPurchasesProductVariantIdPost({
    @Path('user_id') required String? userId,
    @Path('product_variant_id') required String? productVariantId,
    @Body() required AppModulesCdrSchemasCdrPurchaseBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a purchase.

**User must create a purchase for themself and for an online available product or be part of the seller\'s group to use this endpoint**''',
      summary: 'Create Purchase',
      operationId: 'post_cdr_users_{user_id}_purchases_{product_variant_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cdr/users/{user_id}/purchases/{product_variant_id}/')
  Future<chopper.Response> _cdrUsersUserIdPurchasesProductVariantIdDelete({
    @Path('user_id') required String? userId,
    @Path('product_variant_id') required String? productVariantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a purchase.

**User must create a purchase for themself and for an online available product or be part of the seller\'s group to use this endpoint**''',
      summary: 'Delete Purchase',
      operationId: 'delete_cdr_users_{user_id}_purchases_{product_variant_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Create Purchase Batch
  Future<chopper.Response> cdrBatchPurchasesPost({
    required BatchPurchase? body,
  }) {
    return _cdrBatchPurchasesPost(body: body);
  }

  ///Create Purchase Batch
  @POST(path: '/cdr/batch-purchases/', optionalBody: true)
  Future<chopper.Response> _cdrBatchPurchasesPost({
    @Body() required BatchPurchase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a purchase for a list of user.

**User must be part of the seller\'s group to use this endpoint**''',
      summary: 'Create Purchase Batch',
      operationId: 'post_cdr_batch-purchases_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/cdr/users/{user_id}/purchases/{product_variant_id}/validated/',
    optionalBody: true,
  )
  Future<chopper.Response>
  _cdrUsersUserIdPurchasesProductVariantIdValidatedPatch({
    @Path('user_id') required String? userId,
    @Path('product_variant_id') required String? productVariantId,
    @Query('validated') required bool? validated,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Validate a purchase.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Mark Purchase As Validated',
      operationId:
          'patch_cdr_users_{user_id}_purchases_{product_variant_id}_validated_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Validate Purchase Batch
  Future<chopper.Response> cdrBatchValidationPost({
    required BatchValidation? body,
  }) {
    return _cdrBatchValidationPost(body: body);
  }

  ///Validate Purchase Batch
  @POST(path: '/cdr/batch-validation/', optionalBody: true)
  Future<chopper.Response> _cdrBatchValidationPost({
    @Body() required BatchValidation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Validate Purchase Batch',
      operationId: 'post_cdr_batch-validation_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/users/{user_id}/signatures/')
  Future<chopper.Response<List<SignatureComplete>>>
  _cdrUsersUserIdSignaturesGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user\'s signatures.

**User must get his own signatures or be CDR Admin to use this endpoint**''',
      summary: 'Get Signatures By User Id',
      operationId: 'get_cdr_users_{user_id}_signatures_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/cdr/sellers/{seller_id}/users/{user_id}/signatures/')
  Future<chopper.Response<List<SignatureComplete>>>
  _cdrSellersSellerIdUsersUserIdSignaturesGet({
    @Path('seller_id') required String? sellerId,
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user\'s signatures for a single seller.

**User must get his own signatures or be part of the seller\'s group to use this endpoint**''',
      summary: 'Get Signatures By User Id By Seller Id',
      operationId: 'get_cdr_sellers_{seller_id}_users_{user_id}_signatures_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @POST(
    path: '/cdr/users/{user_id}/signatures/{document_id}/',
    optionalBody: true,
  )
  Future<chopper.Response<SignatureComplete>>
  _cdrUsersUserIdSignaturesDocumentIdPost({
    @Path('user_id') required String? userId,
    @Path('document_id') required String? documentId,
    @Body() required SignatureBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a signature.

**User must sign numerically or be part of the seller\'s group to use this endpoint**''',
      summary: 'Create Signature',
      operationId: 'post_cdr_users_{user_id}_signatures_{document_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cdr/users/{user_id}/signatures/{document_id}/')
  Future<chopper.Response> _cdrUsersUserIdSignaturesDocumentIdDelete({
    @Path('user_id') required String? userId,
    @Path('document_id') required String? documentId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a signature.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Delete Signature',
      operationId: 'delete_cdr_users_{user_id}_signatures_{document_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/curriculums/')
  Future<chopper.Response<List<CurriculumComplete>>> _cdrCurriculumsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all curriculums.

**User be authenticated to use this endpoint**''',
      summary: 'Get Curriculums',
      operationId: 'get_cdr_curriculums_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/cdr/curriculums/', optionalBody: true)
  Future<chopper.Response<CurriculumComplete>> _cdrCurriculumsPost({
    @Body() required CurriculumBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a curriculum.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Create Curriculum',
      operationId: 'post_cdr_curriculums_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cdr/curriculums/{curriculum_id}/')
  Future<chopper.Response> _cdrCurriculumsCurriculumIdDelete({
    @Path('curriculum_id') required String? curriculumId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a curriculum.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Delete Curriculum',
      operationId: 'delete_cdr_curriculums_{curriculum_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @POST(
    path: '/cdr/users/{user_id}/curriculums/{curriculum_id}/',
    optionalBody: true,
  )
  Future<chopper.Response> _cdrUsersUserIdCurriculumsCurriculumIdPost({
    @Path('user_id') required String? userId,
    @Path('curriculum_id') required String? curriculumId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add a curriculum to a user.

**User must add a curriculum to themself or be CDR Admin to use this endpoint**''',
      summary: 'Create Curriculum Membership',
      operationId: 'post_cdr_users_{user_id}_curriculums_{curriculum_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @PATCH(
    path: '/cdr/users/{user_id}/curriculums/{curriculum_id}/',
    optionalBody: true,
  )
  Future<chopper.Response> _cdrUsersUserIdCurriculumsCurriculumIdPatch({
    @Path('user_id') required String? userId,
    @Path('curriculum_id') required String? curriculumId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a curriculum membership.

**User must add a curriculum to themself or be CDR Admin to use this endpoint**''',
      summary: 'Update Curriculum Membership',
      operationId: 'patch_cdr_users_{user_id}_curriculums_{curriculum_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cdr/users/{user_id}/curriculums/{curriculum_id}/')
  Future<chopper.Response> _cdrUsersUserIdCurriculumsCurriculumIdDelete({
    @Path('user_id') required String? userId,
    @Path('curriculum_id') required String? curriculumId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Remove a curriculum from a user.

**User must add a curriculum to themself or be CDR Admin to use this endpoint**''',
      summary: 'Delete Curriculum Membership',
      operationId: 'delete_cdr_users_{user_id}_curriculums_{curriculum_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Payments By User Id
  ///@param user_id
  Future<chopper.Response<List<AppModulesCdrSchemasCdrPaymentComplete>>>
  cdrUsersUserIdPaymentsGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrPaymentComplete,
      () => AppModulesCdrSchemasCdrPaymentComplete.fromJsonFactory,
    );

    return _cdrUsersUserIdPaymentsGet(userId: userId);
  }

  ///Get Payments By User Id
  ///@param user_id
  @GET(path: '/cdr/users/{user_id}/payments/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrPaymentComplete>>>
  _cdrUsersUserIdPaymentsGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user\'s payments.

**User must get his own payments or be CDR Admin to use this endpoint**''',
      summary: 'Get Payments By User Id',
      operationId: 'get_cdr_users_{user_id}_payments_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Create Payment
  ///@param user_id
  Future<chopper.Response<AppModulesCdrSchemasCdrPaymentComplete>>
  cdrUsersUserIdPaymentsPost({
    required String? userId,
    required AppModulesCdrSchemasCdrPaymentBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrPaymentComplete,
      () => AppModulesCdrSchemasCdrPaymentComplete.fromJsonFactory,
    );

    return _cdrUsersUserIdPaymentsPost(userId: userId, body: body);
  }

  ///Create Payment
  ///@param user_id
  @POST(path: '/cdr/users/{user_id}/payments/', optionalBody: true)
  Future<chopper.Response<AppModulesCdrSchemasCdrPaymentComplete>>
  _cdrUsersUserIdPaymentsPost({
    @Path('user_id') required String? userId,
    @Body() required AppModulesCdrSchemasCdrPaymentBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a payment.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Create Payment',
      operationId: 'post_cdr_users_{user_id}_payments_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(path: '/cdr/users/{user_id}/payments/{payment_id}/')
  Future<chopper.Response> _cdrUsersUserIdPaymentsPaymentIdDelete({
    @Path('user_id') required String? userId,
    @Path('payment_id') required String? paymentId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Remove a payment.

**User must be CDR Admin to use this endpoint**''',
      summary: 'Delete Payment',
      operationId: 'delete_cdr_users_{user_id}_payments_{payment_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Payment Url
  Future<chopper.Response<PaymentUrl>> cdrPayPost() {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _cdrPayPost();
  }

  ///Get Payment Url
  @POST(path: '/cdr/pay/', optionalBody: true)
  Future<chopper.Response<PaymentUrl>> _cdrPayPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get payment url',
      summary: 'Get Payment Url',
      operationId: 'post_cdr_pay_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Cdr Year
  Future<chopper.Response<CdrYear>> cdrYearGet() {
    generatedMapping.putIfAbsent(CdrYear, () => CdrYear.fromJsonFactory);

    return _cdrYearGet();
  }

  ///Get Cdr Year
  @GET(path: '/cdr/year/')
  Future<chopper.Response<CdrYear>> _cdrYearGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Cdr Year',
      operationId: 'get_cdr_year_',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Update Cdr Year
  Future<chopper.Response> cdrYearPatch({required CdrYear? body}) {
    return _cdrYearPatch(body: body);
  }

  ///Update Cdr Year
  @PATCH(path: '/cdr/year/', optionalBody: true)
  Future<chopper.Response> _cdrYearPatch({
    @Body() required CdrYear? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Cdr Year',
      operationId: 'patch_cdr_year_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Status
  Future<chopper.Response<Status>> cdrStatusGet() {
    generatedMapping.putIfAbsent(Status, () => Status.fromJsonFactory);

    return _cdrStatusGet();
  }

  ///Get Status
  @GET(path: '/cdr/status/')
  Future<chopper.Response<Status>> _cdrStatusGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Status',
      operationId: 'get_cdr_status_',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Update Status
  Future<chopper.Response> cdrStatusPatch({required Status? body}) {
    return _cdrStatusPatch(body: body);
  }

  ///Update Status
  @PATCH(path: '/cdr/status/', optionalBody: true)
  Future<chopper.Response> _cdrStatusPatch({
    @Body() required Status? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Status',
      operationId: 'patch_cdr_status_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get My Tickets
  Future<chopper.Response<List<AppModulesCdrSchemasCdrTicket>>>
  cdrUsersMeTicketsGet() {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrTicket,
      () => AppModulesCdrSchemasCdrTicket.fromJsonFactory,
    );

    return _cdrUsersMeTicketsGet();
  }

  ///Get My Tickets
  @GET(path: '/cdr/users/me/tickets/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrTicket>>>
  _cdrUsersMeTicketsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get My Tickets',
      operationId: 'get_cdr_users_me_tickets_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Tickets Of User
  ///@param user_id
  Future<chopper.Response<List<AppModulesCdrSchemasCdrTicket>>>
  cdrUsersUserIdTicketsGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrTicket,
      () => AppModulesCdrSchemasCdrTicket.fromJsonFactory,
    );

    return _cdrUsersUserIdTicketsGet(userId: userId);
  }

  ///Get Tickets Of User
  ///@param user_id
  @GET(path: '/cdr/users/{user_id}/tickets/')
  Future<chopper.Response<List<AppModulesCdrSchemasCdrTicket>>>
  _cdrUsersUserIdTicketsGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Tickets Of User',
      operationId: 'get_cdr_users_{user_id}_tickets_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/users/me/tickets/{ticket_id}/secret/')
  Future<chopper.Response<TicketSecret>> _cdrUsersMeTicketsTicketIdSecretGet({
    @Path('ticket_id') required String? ticketId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Ticket Secret',
      operationId: 'get_cdr_users_me_tickets_{ticket_id}_secret_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Ticket By Secret
  ///@param seller_id
  ///@param product_id
  ///@param generator_id
  ///@param secret
  Future<chopper.Response<AppModulesCdrSchemasCdrTicket>>
  cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? secret,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesCdrSchemasCdrTicket,
      () => AppModulesCdrSchemasCdrTicket.fromJsonFactory,
    );

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
  @GET(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/tickets/{generator_id}/{secret}/',
  )
  Future<chopper.Response<AppModulesCdrSchemasCdrTicket>>
  _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('generator_id') required String? generatorId,
    @Path('secret') required String? secret,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Ticket By Secret',
      operationId:
          'get_cdr_sellers_{seller_id}_products_{product_id}_tickets_{generator_id}_{secret}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @PATCH(
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
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Scan Ticket',
      operationId:
          'patch_cdr_sellers_{seller_id}_products_{product_id}_tickets_{generator_id}_{secret}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/tickets/{generator_id}/lists/{tag}/',
  )
  Future<chopper.Response<List<CoreUserSimple>>>
  _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdListsTagGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('generator_id') required String? generatorId,
    @Path('tag') required String? tag,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Users By Tag',
      operationId:
          'get_cdr_sellers_{seller_id}_products_{product_id}_tickets_{generator_id}_lists_{tag}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/tags/{generator_id}/',
  )
  Future<chopper.Response<List<String>>>
  _cdrSellersSellerIdProductsProductIdTagsGeneratorIdGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('generator_id') required String? generatorId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Tags Of Ticket',
      operationId:
          'get_cdr_sellers_{seller_id}_products_{product_id}_tags_{generator_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @POST(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/tickets/',
    optionalBody: true,
  )
  Future<chopper.Response<AppModulesCdrSchemasCdrProductComplete>>
  _cdrSellersSellerIdProductsProductIdTicketsPost({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required GenerateTicketBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Generate Ticket For Product',
      operationId:
          'post_cdr_sellers_{seller_id}_products_{product_id}_tickets_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/tickets/{ticket_generator_id}',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdTicketsTicketGeneratorIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('ticket_generator_id') required String? ticketGeneratorId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Ticket Generator For Product',
      operationId:
          'delete_cdr_sellers_{seller_id}_products_{product_id}_tickets_{ticket_generator_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(path: '/cdr/sellers/{seller_id}/products/{product_id}/data/')
  Future<chopper.Response<List<CustomDataFieldComplete>>>
  _cdrSellersSellerIdProductsProductIdDataGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Custom Data Fields',
      operationId: 'get_cdr_sellers_{seller_id}_products_{product_id}_data_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @POST(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/data/',
    optionalBody: true,
  )
  Future<chopper.Response<CustomDataFieldComplete>>
  _cdrSellersSellerIdProductsProductIdDataPost({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Body() required CustomDataFieldBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Custom Data Field',
      operationId: 'post_cdr_sellers_{seller_id}_products_{product_id}_data_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Update Custom Data Field
  ///@param seller_id
  ///@param product_id
  ///@param field_id
  Future<chopper.Response> cdrSellersSellerIdProductsProductIdDataFieldIdPatch({
    required String? sellerId,
    required String? productId,
    required String? fieldId,
    required CustomDataFieldBase? body,
  }) {
    return _cdrSellersSellerIdProductsProductIdDataFieldIdPatch(
      sellerId: sellerId,
      productId: productId,
      fieldId: fieldId,
      body: body,
    );
  }

  ///Update Custom Data Field
  ///@param seller_id
  ///@param product_id
  ///@param field_id
  @PATCH(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/data/{field_id}/',
    optionalBody: true,
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdDataFieldIdPatch({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('field_id') required String? fieldId,
    @Body() required CustomDataFieldBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Custom Data Field',
      operationId:
          'patch_cdr_sellers_{seller_id}_products_{product_id}_data_{field_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(
    path: '/cdr/sellers/{seller_id}/products/{product_id}/data/{field_id}/',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdDataFieldIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('field_id') required String? fieldId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Customdata Field',
      operationId:
          'delete_cdr_sellers_{seller_id}_products_{product_id}_data_{field_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @GET(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/users/{user_id}/data/{field_id}/',
  )
  Future<chopper.Response<CustomDataComplete>>
  _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdGet({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('user_id') required String? userId,
    @Path('field_id') required String? fieldId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Customdata',
      operationId:
          'get_cdr_sellers_{seller_id}_products_{product_id}_users_{user_id}_data_{field_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @POST(
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
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Custom Data',
      operationId:
          'post_cdr_sellers_{seller_id}_products_{product_id}_users_{user_id}_data_{field_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @PATCH(
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
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Custom Data',
      operationId:
          'patch_cdr_sellers_{seller_id}_products_{product_id}_users_{user_id}_data_{field_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
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
  @DELETE(
    path:
        '/cdr/sellers/{seller_id}/products/{product_id}/users/{user_id}/data/{field_id}/',
  )
  Future<chopper.Response>
  _cdrSellersSellerIdProductsProductIdUsersUserIdDataFieldIdDelete({
    @Path('seller_id') required String? sellerId,
    @Path('product_id') required String? productId,
    @Path('user_id') required String? userId,
    @Path('field_id') required String? fieldId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Customdata',
      operationId:
          'delete_cdr_sellers_{seller_id}_products_{product_id}_users_{user_id}_data_{field_id}_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Cdr"],
      deprecated: false,
    ),
  });

  ///Get Paper Pdf
  ///@param paper_id
  Future<chopper.Response> phPaperIdPdfGet({required String? paperId}) {
    return _phPaperIdPdfGet(paperId: paperId);
  }

  ///Get Paper Pdf
  ///@param paper_id
  @GET(path: '/ph/{paper_id}/pdf')
  Future<chopper.Response> _phPaperIdPdfGet({
    @Path('paper_id') required String? paperId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Paper Pdf',
      operationId: 'get_ph_{paper_id}_pdf',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
  });

  ///Create Paper Pdf And Cover
  ///@param paper_id
  Future<chopper.Response> phPaperIdPdfPost({
    required String? paperId,
    required List<int> pdf,
  }) {
    return _phPaperIdPdfPost(paperId: paperId, pdf: pdf);
  }

  ///Create Paper Pdf And Cover
  ///@param paper_id
  @POST(path: '/ph/{paper_id}/pdf', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _phPaperIdPdfPost({
    @Path('paper_id') required String? paperId,
    @PartFile('pdf') required List<int> pdf,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Paper Pdf And Cover',
      operationId: 'post_ph_{paper_id}_pdf',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
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
  @GET(path: '/ph/')
  Future<chopper.Response<List<PaperComplete>>> _phGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all editions until now, sorted from the latest to the oldest',
      summary: 'Get Papers',
      operationId: 'get_ph_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
  });

  ///Create Paper
  Future<chopper.Response<PaperComplete>> phPost({required PaperBase? body}) {
    generatedMapping.putIfAbsent(
      PaperComplete,
      () => PaperComplete.fromJsonFactory,
    );

    return _phPost(body: body);
  }

  ///Create Paper
  @POST(path: '/ph/', optionalBody: true)
  Future<chopper.Response<PaperComplete>> _phPost({
    @Body() required PaperBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create a new paper.',
      summary: 'Create Paper',
      operationId: 'post_ph_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
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
  @GET(path: '/ph/admin')
  Future<chopper.Response<List<PaperComplete>>> _phAdminGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all editions, sorted from the latest to the oldest',
      summary: 'Get Papers Admin',
      operationId: 'get_ph_admin',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
  });

  ///Get Cover
  ///@param paper_id
  Future<chopper.Response> phPaperIdCoverGet({required String? paperId}) {
    return _phPaperIdCoverGet(paperId: paperId);
  }

  ///Get Cover
  ///@param paper_id
  @GET(path: '/ph/{paper_id}/cover')
  Future<chopper.Response> _phPaperIdCoverGet({
    @Path('paper_id') required String? paperId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Cover',
      operationId: 'get_ph_{paper_id}_cover',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
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
  @PATCH(path: '/ph/{paper_id}', optionalBody: true)
  Future<chopper.Response> _phPaperIdPatch({
    @Path('paper_id') required String? paperId,
    @Body() required PaperUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Paper',
      operationId: 'patch_ph_{paper_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
  });

  ///Delete Paper
  ///@param paper_id
  Future<chopper.Response> phPaperIdDelete({required String? paperId}) {
    return _phPaperIdDelete(paperId: paperId);
  }

  ///Delete Paper
  ///@param paper_id
  @DELETE(path: '/ph/{paper_id}')
  Future<chopper.Response> _phPaperIdDelete({
    @Path('paper_id') required String? paperId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Paper',
      operationId: 'delete_ph_{paper_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["ph"],
      deprecated: false,
    ),
  });

  ///Get Participant By Id
  ///@param participant_id
  Future<chopper.Response<RaidParticipant>> raidParticipantsParticipantIdGet({
    required String? participantId,
  }) {
    generatedMapping.putIfAbsent(
      RaidParticipant,
      () => RaidParticipant.fromJsonFactory,
    );

    return _raidParticipantsParticipantIdGet(participantId: participantId);
  }

  ///Get Participant By Id
  ///@param participant_id
  @GET(path: '/raid/participants/{participant_id}')
  Future<chopper.Response<RaidParticipant>> _raidParticipantsParticipantIdGet({
    @Path('participant_id') required String? participantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a participant by id',
      summary: 'Get Participant By Id',
      operationId: 'get_raid_participants_{participant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Update Participant
  ///@param participant_id
  Future<chopper.Response> raidParticipantsParticipantIdPatch({
    required String? participantId,
    required RaidParticipantUpdate? body,
  }) {
    return _raidParticipantsParticipantIdPatch(
      participantId: participantId,
      body: body,
    );
  }

  ///Update Participant
  ///@param participant_id
  @PATCH(path: '/raid/participants/{participant_id}', optionalBody: true)
  Future<chopper.Response> _raidParticipantsParticipantIdPatch({
    @Path('participant_id') required String? participantId,
    @Body() required RaidParticipantUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update a participant',
      summary: 'Update Participant',
      operationId: 'patch_raid_participants_{participant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Create Participant
  Future<chopper.Response<RaidParticipant>> raidParticipantsPost({
    required RaidParticipantBase? body,
  }) {
    generatedMapping.putIfAbsent(
      RaidParticipant,
      () => RaidParticipant.fromJsonFactory,
    );

    return _raidParticipantsPost(body: body);
  }

  ///Create Participant
  @POST(path: '/raid/participants', optionalBody: true)
  Future<chopper.Response<RaidParticipant>> _raidParticipantsPost({
    @Body() required RaidParticipantBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create a participant',
      summary: 'Create Participant',
      operationId: 'post_raid_participants',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Get All Teams
  Future<chopper.Response<List<RaidTeamPreview>>> raidTeamsGet() {
    generatedMapping.putIfAbsent(
      RaidTeamPreview,
      () => RaidTeamPreview.fromJsonFactory,
    );

    return _raidTeamsGet();
  }

  ///Get All Teams
  @GET(path: '/raid/teams')
  Future<chopper.Response<List<RaidTeamPreview>>> _raidTeamsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all teams',
      summary: 'Get All Teams',
      operationId: 'get_raid_teams',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Create Team
  Future<chopper.Response<RaidTeam>> raidTeamsPost({
    required RaidTeamBase? body,
  }) {
    generatedMapping.putIfAbsent(RaidTeam, () => RaidTeam.fromJsonFactory);

    return _raidTeamsPost(body: body);
  }

  ///Create Team
  @POST(path: '/raid/teams', optionalBody: true)
  Future<chopper.Response<RaidTeam>> _raidTeamsPost({
    @Body() required RaidTeamBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create a team',
      summary: 'Create Team',
      operationId: 'post_raid_teams',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Delete All Teams
  Future<chopper.Response> raidTeamsDelete() {
    return _raidTeamsDelete();
  }

  ///Delete All Teams
  @DELETE(path: '/raid/teams')
  Future<chopper.Response> _raidTeamsDelete({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete all teams',
      summary: 'Delete All Teams',
      operationId: 'delete_raid_teams',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Get Team By Participant Id
  ///@param participant_id
  Future<chopper.Response<RaidTeam>> raidParticipantsParticipantIdTeamGet({
    required String? participantId,
  }) {
    generatedMapping.putIfAbsent(RaidTeam, () => RaidTeam.fromJsonFactory);

    return _raidParticipantsParticipantIdTeamGet(participantId: participantId);
  }

  ///Get Team By Participant Id
  ///@param participant_id
  @GET(path: '/raid/participants/{participant_id}/team')
  Future<chopper.Response<RaidTeam>> _raidParticipantsParticipantIdTeamGet({
    @Path('participant_id') required String? participantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a team by participant id',
      summary: 'Get Team By Participant Id',
      operationId: 'get_raid_participants_{participant_id}_team',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Get Team By Id
  ///@param team_id
  Future<chopper.Response<RaidTeam>> raidTeamsTeamIdGet({
    required String? teamId,
  }) {
    generatedMapping.putIfAbsent(RaidTeam, () => RaidTeam.fromJsonFactory);

    return _raidTeamsTeamIdGet(teamId: teamId);
  }

  ///Get Team By Id
  ///@param team_id
  @GET(path: '/raid/teams/{team_id}')
  Future<chopper.Response<RaidTeam>> _raidTeamsTeamIdGet({
    @Path('team_id') required String? teamId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a team by id',
      summary: 'Get Team By Id',
      operationId: 'get_raid_teams_{team_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Update Team
  ///@param team_id
  Future<chopper.Response> raidTeamsTeamIdPatch({
    required String? teamId,
    required RaidTeamUpdate? body,
  }) {
    return _raidTeamsTeamIdPatch(teamId: teamId, body: body);
  }

  ///Update Team
  ///@param team_id
  @PATCH(path: '/raid/teams/{team_id}', optionalBody: true)
  Future<chopper.Response> _raidTeamsTeamIdPatch({
    @Path('team_id') required String? teamId,
    @Body() required RaidTeamUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update a team',
      summary: 'Update Team',
      operationId: 'patch_raid_teams_{team_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Delete Team
  ///@param team_id
  Future<chopper.Response> raidTeamsTeamIdDelete({required String? teamId}) {
    return _raidTeamsTeamIdDelete(teamId: teamId);
  }

  ///Delete Team
  ///@param team_id
  @DELETE(path: '/raid/teams/{team_id}')
  Future<chopper.Response> _raidTeamsTeamIdDelete({
    @Path('team_id') required String? teamId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a team',
      summary: 'Delete Team',
      operationId: 'delete_raid_teams_{team_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Upload Document
  ///@param document_type
  Future<chopper.Response<DocumentCreation>> raidDocumentDocumentTypePost({
    required enums.DocumentType? documentType,
    required List<int> file,
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
  @POST(path: '/raid/document/{document_type}', optionalBody: true)
  @Multipart()
  Future<chopper.Response<DocumentCreation>> _raidDocumentDocumentTypePost({
    @Path('document_type') required String? documentType,
    @PartFile('file') required List<int> file,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Upload a document',
      summary: 'Upload Document',
      operationId: 'post_raid_document_{document_type}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @GET(path: '/raid/document/{document_id}')
  Future<chopper.Response> _raidDocumentDocumentIdGet({
    @Path('document_id') required String? documentId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Read a document',
      summary: 'Read Document',
      operationId: 'get_raid_document_{document_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @POST(path: '/raid/document/{document_id}/validate', optionalBody: true)
  Future<chopper.Response> _raidDocumentDocumentIdValidatePost({
    @Path('document_id') required String? documentId,
    @Query('validation') required String? validation,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Validate a document',
      summary: 'Validate Document',
      operationId: 'post_raid_document_{document_id}_validate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @POST(path: '/raid/security_file/', optionalBody: true)
  Future<chopper.Response<SecurityFile>> _raidSecurityFilePost({
    @Query('participant_id') required String? participantId,
    @Body() required SecurityFileBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Confirm security file',
      summary: 'Set Security File',
      operationId: 'post_raid_security_file_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @POST(path: '/raid/participant/{participant_id}/payment', optionalBody: true)
  Future<chopper.Response> _raidParticipantParticipantIdPaymentPost({
    @Path('participant_id') required String? participantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Confirm payment manually',
      summary: 'Confirm Payment',
      operationId: 'post_raid_participant_{participant_id}_payment',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @POST(
    path: '/raid/participant/{participant_id}/t_shirt_payment',
    optionalBody: true,
  )
  Future<chopper.Response> _raidParticipantParticipantIdTShirtPaymentPost({
    @Path('participant_id') required String? participantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Confirm T shirt payment',
      summary: 'Confirm T Shirt Payment',
      operationId: 'post_raid_participant_{participant_id}_t_shirt_payment',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @POST(path: '/raid/participant/{participant_id}/honour', optionalBody: true)
  Future<chopper.Response> _raidParticipantParticipantIdHonourPost({
    @Path('participant_id') required String? participantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Validate attestation on honour',
      summary: 'Validate Attestation On Honour',
      operationId: 'post_raid_participant_{participant_id}_honour',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @POST(path: '/raid/teams/{team_id}/invite', optionalBody: true)
  Future<chopper.Response<InviteToken>> _raidTeamsTeamIdInvitePost({
    @Path('team_id') required String? teamId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create an invite token',
      summary: 'Create Invite Token',
      operationId: 'post_raid_teams_{team_id}_invite',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Join Team
  ///@param token
  Future<chopper.Response> raidTeamsJoinTokenPost({required String? token}) {
    return _raidTeamsJoinTokenPost(token: token);
  }

  ///Join Team
  ///@param token
  @POST(path: '/raid/teams/join/{token}', optionalBody: true)
  Future<chopper.Response> _raidTeamsJoinTokenPost({
    @Path('token') required String? token,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Join a team',
      summary: 'Join Team',
      operationId: 'post_raid_teams_join_{token}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Kick Team Member
  ///@param team_id
  ///@param participant_id
  Future<chopper.Response<RaidTeam>> raidTeamsTeamIdKickParticipantIdPost({
    required String? teamId,
    required String? participantId,
  }) {
    generatedMapping.putIfAbsent(RaidTeam, () => RaidTeam.fromJsonFactory);

    return _raidTeamsTeamIdKickParticipantIdPost(
      teamId: teamId,
      participantId: participantId,
    );
  }

  ///Kick Team Member
  ///@param team_id
  ///@param participant_id
  @POST(path: '/raid/teams/{team_id}/kick/{participant_id}', optionalBody: true)
  Future<chopper.Response<RaidTeam>> _raidTeamsTeamIdKickParticipantIdPost({
    @Path('team_id') required String? teamId,
    @Path('participant_id') required String? participantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Leave a team',
      summary: 'Kick Team Member',
      operationId: 'post_raid_teams_{team_id}_kick_{participant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Merge Teams
  ///@param team1_id
  ///@param team2_id
  Future<chopper.Response<RaidTeam>> raidTeamsMergePost({
    required String? team1Id,
    required String? team2Id,
  }) {
    generatedMapping.putIfAbsent(RaidTeam, () => RaidTeam.fromJsonFactory);

    return _raidTeamsMergePost(team1Id: team1Id, team2Id: team2Id);
  }

  ///Merge Teams
  ///@param team1_id
  ///@param team2_id
  @POST(path: '/raid/teams/merge', optionalBody: true)
  Future<chopper.Response<RaidTeam>> _raidTeamsMergePost({
    @Query('team1_id') required String? team1Id,
    @Query('team2_id') required String? team2Id,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Merge two teams',
      summary: 'Merge Teams',
      operationId: 'post_raid_teams_merge',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @GET(path: '/raid/information')
  Future<chopper.Response<RaidInformation>> _raidInformationGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get raid information',
      summary: 'Get Raid Information',
      operationId: 'get_raid_information',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Update Raid Information
  Future<chopper.Response> raidInformationPatch({
    required RaidInformation? body,
  }) {
    return _raidInformationPatch(body: body);
  }

  ///Update Raid Information
  @PATCH(path: '/raid/information', optionalBody: true)
  Future<chopper.Response> _raidInformationPatch({
    @Body() required RaidInformation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update raid information',
      summary: 'Update Raid Information',
      operationId: 'patch_raid_information',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @GET(path: '/raid/drive')
  Future<chopper.Response<RaidDriveFoldersCreation>> _raidDriveGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get drive folders',
      summary: 'Get Drive Folders',
      operationId: 'get_raid_drive',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Update Drive Folders
  Future<chopper.Response> raidDrivePatch({
    required RaidDriveFoldersCreation? body,
  }) {
    return _raidDrivePatch(body: body);
  }

  ///Update Drive Folders
  @PATCH(path: '/raid/drive', optionalBody: true)
  Future<chopper.Response> _raidDrivePatch({
    @Body() required RaidDriveFoldersCreation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update drive folders',
      summary: 'Update Drive Folders',
      operationId: 'patch_raid_drive',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Get Raid Price
  Future<chopper.Response<RaidPrice>> raidPriceGet() {
    generatedMapping.putIfAbsent(RaidPrice, () => RaidPrice.fromJsonFactory);

    return _raidPriceGet();
  }

  ///Get Raid Price
  @GET(path: '/raid/price')
  Future<chopper.Response<RaidPrice>> _raidPriceGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get raid price',
      summary: 'Get Raid Price',
      operationId: 'get_raid_price',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Update Raid Price
  Future<chopper.Response> raidPricePatch({required RaidPrice? body}) {
    return _raidPricePatch(body: body);
  }

  ///Update Raid Price
  @PATCH(path: '/raid/price', optionalBody: true)
  Future<chopper.Response> _raidPricePatch({
    @Body() required RaidPrice? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Update raid price',
      summary: 'Update Raid Price',
      operationId: 'patch_raid_price',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Get Payment Url
  Future<chopper.Response<PaymentUrl>> raidPayGet() {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _raidPayGet();
  }

  ///Get Payment Url
  @GET(path: '/raid/pay')
  Future<chopper.Response<PaymentUrl>> _raidPayGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get payment url',
      summary: 'Get Payment Url',
      operationId: 'get_raid_pay',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Download Security Files Zip
  Future<chopper.Response> raidSecurityFilesZipGet() {
    return _raidSecurityFilesZipGet();
  }

  ///Download Security Files Zip
  @GET(path: '/raid/security_files_zip')
  Future<chopper.Response> _raidSecurityFilesZipGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Generate and serve a ZIP file containing all security files.
Only accessible to raid admins.''',
      summary: 'Download Security Files Zip',
      operationId: 'get_raid_security_files_zip',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
  });

  ///Download Team Files Zip
  Future<chopper.Response> raidTeamFilesZipGet() {
    return _raidTeamFilesZipGet();
  }

  ///Download Team Files Zip
  @GET(path: '/raid/team_files_zip')
  Future<chopper.Response> _raidTeamFilesZipGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Generate and serve a ZIP file containing all team files.
Only accessible to raid admins.''',
      summary: 'Download Team Files Zip',
      operationId: 'get_raid_team_files_zip',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raid"],
      deprecated: false,
    ),
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
  @GET(path: '/campaign/sections')
  Future<chopper.Response<List<SectionComplete>>> _campaignSectionsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Return sections in the database as a list of `schemas_campaign.SectionBase`

**The user must be a member of a group authorized to vote or to manage the campaign to use this endpoint**''',
      summary: 'Get Sections',
      operationId: 'get_campaign_sections',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/campaign/sections', optionalBody: true)
  Future<chopper.Response<SectionComplete>> _campaignSectionsPost({
    @Body() required SectionBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add a section.

This endpoint can only be used in \'waiting\' status.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Add Section',
      operationId: 'post_campaign_sections',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
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
  @DELETE(path: '/campaign/sections/{section_id}')
  Future<chopper.Response> _campaignSectionsSectionIdDelete({
    @Path('section_id') required String? sectionId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a section.

This endpoint can only be used in \'waiting\' status.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Delete Section',
      operationId: 'delete_campaign_sections_{section_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Get Lists
  Future<chopper.Response<List<ListReturn>>> campaignListsGet() {
    generatedMapping.putIfAbsent(ListReturn, () => ListReturn.fromJsonFactory);

    return _campaignListsGet();
  }

  ///Get Lists
  @GET(path: '/campaign/lists')
  Future<chopper.Response<List<ListReturn>>> _campaignListsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return campaign lists registered for the vote.

**The user must be a member of a group authorized to vote or to manage the campaign to use this endpoint**''',
      summary: 'Get Lists',
      operationId: 'get_campaign_lists',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Add List
  Future<chopper.Response<ListReturn>> campaignListsPost({
    required ListBase? body,
  }) {
    generatedMapping.putIfAbsent(ListReturn, () => ListReturn.fromJsonFactory);

    return _campaignListsPost(body: body);
  }

  ///Add List
  @POST(path: '/campaign/lists', optionalBody: true)
  Future<chopper.Response<ListReturn>> _campaignListsPost({
    @Body() required ListBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add a campaign list to a section.

This endpoint can only be used in \'waiting\' status.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Add List',
      operationId: 'post_campaign_lists',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
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
  @DELETE(path: '/campaign/lists/{list_id}')
  Future<chopper.Response> _campaignListsListIdDelete({
    @Path('list_id') required String? listId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete the campaign list with the given id.

This endpoint can only be used in \'waiting\' status.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Delete List',
      operationId: 'delete_campaign_lists_{list_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
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
  @PATCH(path: '/campaign/lists/{list_id}', optionalBody: true)
  Future<chopper.Response> _campaignListsListIdPatch({
    @Path('list_id') required String? listId,
    @Body() required ListEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update the campaign list with the given id.

This endpoint can only be used in \'waiting\' status.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Update List',
      operationId: 'patch_campaign_lists_{list_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Delete Lists By Type
  ///@param list_type
  Future<chopper.Response> campaignListsDelete({Object? listType}) {
    return _campaignListsDelete(listType: listType);
  }

  ///Delete Lists By Type
  ///@param list_type
  @DELETE(path: '/campaign/lists/')
  Future<chopper.Response> _campaignListsDelete({
    @Query('list_type') Object? listType,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete the all lists by type.

This endpoint can only be used in \'waiting\' status.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Delete Lists By Type',
      operationId: 'delete_campaign_lists_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Get Voters
  Future<chopper.Response<CorePermission>> campaignVotersGet() {
    generatedMapping.putIfAbsent(
      CorePermission,
      () => CorePermission.fromJsonFactory,
    );

    return _campaignVotersGet();
  }

  ///Get Voters
  @GET(path: '/campaign/voters')
  Future<chopper.Response<CorePermission>> _campaignVotersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return the list of voters.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Get Voters',
      operationId: 'get_campaign_voters',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Delete Voters
  Future<chopper.Response> campaignVotersDelete() {
    return _campaignVotersDelete();
  }

  ///Delete Voters
  @DELETE(path: '/campaign/voters')
  Future<chopper.Response> _campaignVotersDelete({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete all voters.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Delete Voters',
      operationId: 'delete_campaign_voters',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Add Voter
  ///@param group_id
  Future<chopper.Response> campaignVotersGroupIdPost({
    required String? groupId,
  }) {
    return _campaignVotersGroupIdPost(groupId: groupId);
  }

  ///Add Voter
  ///@param group_id
  @POST(path: '/campaign/voters/{group_id}', optionalBody: true)
  Future<chopper.Response> _campaignVotersGroupIdPost({
    @Path('group_id') required String? groupId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add a voter.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Add Voter',
      operationId: 'post_campaign_voters_{group_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Delete Voter
  ///@param group_id
  Future<chopper.Response> campaignVotersGroupIdDelete({
    required String? groupId,
  }) {
    return _campaignVotersGroupIdDelete(groupId: groupId);
  }

  ///Delete Voter
  ///@param group_id
  @DELETE(path: '/campaign/voters/{group_id}')
  Future<chopper.Response> _campaignVotersGroupIdDelete({
    @Path('group_id') required String? groupId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a voter.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Delete Voter',
      operationId: 'delete_campaign_voters_{group_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Open Vote
  Future<chopper.Response> campaignStatusOpenPost() {
    return _campaignStatusOpenPost();
  }

  ///Open Vote
  @POST(path: '/campaign/status/open', optionalBody: true)
  Future<chopper.Response> _campaignStatusOpenPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''If the status is \'waiting\', change it to \'voting\' and create the blank lists.

> WARNING: this operation can not be reversed.
> When the status is \'open\', all users can vote and sections and lists can no longer be edited.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Open Vote',
      operationId: 'post_campaign_status_open',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Close Vote
  Future<chopper.Response> campaignStatusClosePost() {
    return _campaignStatusClosePost();
  }

  ///Close Vote
  @POST(path: '/campaign/status/close', optionalBody: true)
  Future<chopper.Response> _campaignStatusClosePost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''If the status is \'open\', change it to \'closed\'.

> WARNING: this operation can not be reversed.
> When the status is \'closed\', users are no longer able to vote.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Close Vote',
      operationId: 'post_campaign_status_close',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Count Voting
  Future<chopper.Response> campaignStatusCountingPost() {
    return _campaignStatusCountingPost();
  }

  ///Count Voting
  @POST(path: '/campaign/status/counting', optionalBody: true)
  Future<chopper.Response> _campaignStatusCountingPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''If the status is \'closed\', change it to \'counting\'.

> WARNING: this operation can not be reversed.
> When the status is \'counting\', administrators can see the results of the vote.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Count Voting',
      operationId: 'post_campaign_status_counting',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Publish Vote
  Future<chopper.Response> campaignStatusPublishedPost() {
    return _campaignStatusPublishedPost();
  }

  ///Publish Vote
  @POST(path: '/campaign/status/published', optionalBody: true)
  Future<chopper.Response> _campaignStatusPublishedPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''If the status is \'counting\', change it to \'published\'.

> WARNING: this operation can not be reversed.
> When the status is \'published\', everyone can see the results of the vote.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Publish Vote',
      operationId: 'post_campaign_status_published',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Reset Vote
  Future<chopper.Response> campaignStatusResetPost() {
    return _campaignStatusResetPost();
  }

  ///Reset Vote
  @POST(path: '/campaign/status/reset', optionalBody: true)
  Future<chopper.Response> _campaignStatusResetPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Reset the vote. Can only be used if the current status is counting ou published.

> WARNING: This will delete all votes then put the module to Waiting status. This will also delete blank lists.

**The user must be a member of a group authorized to manage the campaign to use this endpoint**''',
      summary: 'Reset Vote',
      operationId: 'post_campaign_status_reset',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Get Sections Already Voted
  Future<chopper.Response<List<String>>> campaignVotesGet() {
    return _campaignVotesGet();
  }

  ///Get Sections Already Voted
  @GET(path: '/campaign/votes')
  Future<chopper.Response<List<String>>> _campaignVotesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Return the list of id of sections an user has already voted for.

**The user must be a member of a group authorized to vote to use this endpoint**''',
      summary: 'Get Sections Already Voted',
      operationId: 'get_campaign_votes',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Vote
  Future<chopper.Response> campaignVotesPost({required VoteBase? body}) {
    return _campaignVotesPost(body: body);
  }

  ///Vote
  @POST(path: '/campaign/votes', optionalBody: true)
  Future<chopper.Response> _campaignVotesPost({
    @Body() required VoteBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add a vote for a given campaign list.

An user can only vote for one list per section.

**The user must be a member of a group authorized to vote to use this endpoint**''',
      summary: 'Vote',
      operationId: 'post_campaign_votes',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
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
  @GET(path: '/campaign/results')
  Future<chopper.Response<List<AppModulesCampaignSchemasCampaignResult>>>
  _campaignResultsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return the results of the vote.

**The user must be a member of a group authorized to vote or to manage the campaign to use this endpoint**''',
      summary: 'Get Results',
      operationId: 'get_campaign_results',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Get Status Vote
  Future<chopper.Response<VoteStatus>> campaignStatusGet() {
    generatedMapping.putIfAbsent(VoteStatus, () => VoteStatus.fromJsonFactory);

    return _campaignStatusGet();
  }

  ///Get Status Vote
  @GET(path: '/campaign/status')
  Future<chopper.Response<VoteStatus>> _campaignStatusGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the current status of the vote.

**The user must be a member of a group authorized to vote or to manage the campaign to use this endpoint**''',
      summary: 'Get Status Vote',
      operationId: 'get_campaign_status',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/campaign/stats/{section_id}')
  Future<chopper.Response<VoteStats>> _campaignStatsSectionIdGet({
    @Path('section_id') required String? sectionId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get stats about a given section.

**The user must be authorized to vote to use this endpoint**''',
      summary: 'Get Stats For Section',
      operationId: 'get_campaign_stats_{section_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
  });

  ///Create Campaigns Logo
  ///@param list_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  campaignListsListIdLogoPost({
    required String? listId,
    required List<int> image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _campaignListsListIdLogoPost(listId: listId, image: image);
  }

  ///Create Campaigns Logo
  ///@param list_id
  @POST(path: '/campaign/lists/{list_id}/logo', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _campaignListsListIdLogoPost({
    @Path('list_id') required String? listId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Upload a logo for a campaign list.

**The user must be authorized to manage the campaign to use this endpoint**''',
      summary: 'Create Campaigns Logo',
      operationId: 'post_campaign_lists_{list_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
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
  @GET(path: '/campaign/lists/{list_id}/logo')
  Future<chopper.Response> _campaignListsListIdLogoGet({
    @Path('list_id') required String? listId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the logo of a campaign list.
**The user must be a member of a group authorized to vote or to manage the campaign to use this endpoint**''',
      summary: 'Read Campaigns Logo',
      operationId: 'get_campaign_lists_{list_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Campaign"],
      deprecated: false,
    ),
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
  @GET(path: '/amap/products')
  Future<chopper.Response<List<AppModulesAmapSchemasAmapProductComplete>>>
  _amapProductsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all products

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Get Products',
      operationId: 'get_amap_products',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/amap/products', optionalBody: true)
  Future<chopper.Response<AppModulesAmapSchemasAmapProductComplete>>
  _amapProductsPost({
    @Body() required ProductSimple? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new product

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Create Product',
      operationId: 'post_amap_products',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/amap/products/{product_id}')
  Future<chopper.Response<AppModulesAmapSchemasAmapProductComplete>>
  _amapProductsProductIdGet({
    @Path('product_id') required String? productId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get a specific product',
      summary: 'Get Product By Id',
      operationId: 'get_amap_products_{product_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

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
  @PATCH(path: '/amap/products/{product_id}', optionalBody: true)
  Future<chopper.Response> _amapProductsProductIdPatch({
    @Path('product_id') required String? productId,
    @Body() required AppModulesAmapSchemasAmapProductEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a product

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Edit Product',
      operationId: 'patch_amap_products_{product_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @DELETE(path: '/amap/products/{product_id}')
  Future<chopper.Response> _amapProductsProductIdDelete({
    @Path('product_id') required String? productId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Delete a product. A product can not be deleted if it is already used in a delivery.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Delete Product',
      operationId: 'delete_amap_products_{product_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @GET(path: '/amap/deliveries')
  Future<chopper.Response<List<DeliveryReturn>>> _amapDeliveriesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all deliveries.',
      summary: 'Get Deliveries',
      operationId: 'get_amap_deliveries',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/amap/deliveries', optionalBody: true)
  Future<chopper.Response<DeliveryReturn>> _amapDeliveriesPost({
    @Body() required DeliveryBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new delivery.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Create Delivery',
      operationId: 'post_amap_deliveries',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @DELETE(path: '/amap/deliveries/{delivery_id}')
  Future<chopper.Response> _amapDeliveriesDeliveryIdDelete({
    @Path('delivery_id') required String? deliveryId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a delivery.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Delete Delivery',
      operationId: 'delete_amap_deliveries_{delivery_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @PATCH(path: '/amap/deliveries/{delivery_id}', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdPatch({
    @Path('delivery_id') required String? deliveryId,
    @Body() required DeliveryUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a delivery.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Edit Delivery',
      operationId: 'patch_amap_deliveries_{delivery_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @POST(path: '/amap/deliveries/{delivery_id}/products', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdProductsPost({
    @Path('delivery_id') required String? deliveryId,
    @Body() required DeliveryProductsUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Add `product_id` product to `delivery_id` delivery. This endpoint will only add a membership between the two objects.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Add Product To Delivery',
      operationId: 'post_amap_deliveries_{delivery_id}_products',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @DELETE(path: '/amap/deliveries/{delivery_id}/products')
  Future<chopper.Response> _amapDeliveriesDeliveryIdProductsDelete({
    @Path('delivery_id') required String? deliveryId,
    @Body() required DeliveryProductsUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Remove a given product from a delivery. This won\'t delete the product nor the delivery.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Remove Product From Delivery',
      operationId: 'delete_amap_deliveries_{delivery_id}_products',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @GET(path: '/amap/deliveries/{delivery_id}/orders')
  Future<chopper.Response<List<OrderReturn>>>
  _amapDeliveriesDeliveryIdOrdersGet({
    @Path('delivery_id') required String? deliveryId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get orders from a delivery.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Get Orders From Delivery',
      operationId: 'get_amap_deliveries_{delivery_id}_orders',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @GET(path: '/amap/orders/{order_id}')
  Future<chopper.Response<OrderReturn>> _amapOrdersOrderIdGet({
    @Path('order_id') required String? orderId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get content of an order.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Get Order By Id',
      operationId: 'get_amap_orders_{order_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @PATCH(path: '/amap/orders/{order_id}', optionalBody: true)
  Future<chopper.Response> _amapOrdersOrderIdPatch({
    @Path('order_id') required String? orderId,
    @Body() required OrderEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit an order.

**A member of the group AMAP can edit orders of other users**''',
      summary: 'Edit Order From Delivery',
      operationId: 'patch_amap_orders_{order_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

  ///Remove Order
  ///@param order_id
  Future<chopper.Response> amapOrdersOrderIdDelete({required String? orderId}) {
    return _amapOrdersOrderIdDelete(orderId: orderId);
  }

  ///Remove Order
  ///@param order_id
  @DELETE(path: '/amap/orders/{order_id}')
  Future<chopper.Response> _amapOrdersOrderIdDelete({
    @Path('order_id') required String? orderId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete an order.

**A member of the group AMAP can delete orders of other users**''',
      summary: 'Remove Order',
      operationId: 'delete_amap_orders_{order_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @POST(path: '/amap/orders', optionalBody: true)
  Future<chopper.Response<OrderReturn>> _amapOrdersPost({
    @Body() required OrderBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add an order to a delivery.

**A member of the group AMAP can create an order for every user**''',
      summary: 'Add Order To Delievery',
      operationId: 'post_amap_orders',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @POST(path: '/amap/deliveries/{delivery_id}/openordering', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdOpenorderingPost({
    @Path('delivery_id') required String? deliveryId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Open Ordering Of Delivery',
      operationId: 'post_amap_deliveries_{delivery_id}_openordering',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @POST(path: '/amap/deliveries/{delivery_id}/lock', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdLockPost({
    @Path('delivery_id') required String? deliveryId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Lock Delivery',
      operationId: 'post_amap_deliveries_{delivery_id}_lock',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @POST(path: '/amap/deliveries/{delivery_id}/delivered', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdDeliveredPost({
    @Path('delivery_id') required String? deliveryId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Mark Delivery As Delivered',
      operationId: 'post_amap_deliveries_{delivery_id}_delivered',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @POST(path: '/amap/deliveries/{delivery_id}/archive', optionalBody: true)
  Future<chopper.Response> _amapDeliveriesDeliveryIdArchivePost({
    @Path('delivery_id') required String? deliveryId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Archive Of Delivery',
      operationId: 'post_amap_deliveries_{delivery_id}_archive',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

  ///Get Users Cash
  Future<chopper.Response<List<AppModulesAmapSchemasAmapCashComplete>>>
  amapUsersCashGet() {
    generatedMapping.putIfAbsent(
      AppModulesAmapSchemasAmapCashComplete,
      () => AppModulesAmapSchemasAmapCashComplete.fromJsonFactory,
    );

    return _amapUsersCashGet();
  }

  ///Get Users Cash
  @GET(path: '/amap/users/cash')
  Future<chopper.Response<List<AppModulesAmapSchemasAmapCashComplete>>>
  _amapUsersCashGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get cash from all users.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Get Users Cash',
      operationId: 'get_amap_users_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

  ///Get Cash By Id
  ///@param user_id
  Future<chopper.Response<AppModulesAmapSchemasAmapCashComplete>>
  amapUsersUserIdCashGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      AppModulesAmapSchemasAmapCashComplete,
      () => AppModulesAmapSchemasAmapCashComplete.fromJsonFactory,
    );

    return _amapUsersUserIdCashGet(userId: userId);
  }

  ///Get Cash By Id
  ///@param user_id
  @GET(path: '/amap/users/{user_id}/cash')
  Future<chopper.Response<AppModulesAmapSchemasAmapCashComplete>>
  _amapUsersUserIdCashGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get cash from a specific user.

**The user must be a member of the group AMAP to use this endpoint or can only access the endpoint for its own user_id**''',
      summary: 'Get Cash By Id',
      operationId: 'get_amap_users_{user_id}_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

  ///Create Cash Of User
  ///@param user_id
  Future<chopper.Response<AppModulesAmapSchemasAmapCashComplete>>
  amapUsersUserIdCashPost({required String? userId, required CashEdit? body}) {
    generatedMapping.putIfAbsent(
      AppModulesAmapSchemasAmapCashComplete,
      () => AppModulesAmapSchemasAmapCashComplete.fromJsonFactory,
    );

    return _amapUsersUserIdCashPost(userId: userId, body: body);
  }

  ///Create Cash Of User
  ///@param user_id
  @POST(path: '/amap/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response<AppModulesAmapSchemasAmapCashComplete>>
  _amapUsersUserIdCashPost({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create cash for an user.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Create Cash Of User',
      operationId: 'post_amap_users_{user_id}_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @PATCH(path: '/amap/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response> _amapUsersUserIdCashPatch({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Edit cash for an user. This will add the balance to the current balance.
A negative value can be provided to remove money from the user.

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Edit Cash By Id',
      operationId: 'patch_amap_users_{user_id}_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @GET(path: '/amap/users/{user_id}/orders')
  Future<chopper.Response<List<OrderReturn>>> _amapUsersUserIdOrdersGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get orders from an user.

**The user must be a member of the group AMAP to use this endpoint or can only access the endpoint for its own user_id**''',
      summary: 'Get Orders Of User',
      operationId: 'get_amap_users_{user_id}_orders',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
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
  @GET(path: '/amap/information')
  Future<chopper.Response<Information>> _amapInformationGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all information',
      summary: 'Get Information',
      operationId: 'get_amap_information',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

  ///Edit Information
  Future<chopper.Response> amapInformationPatch({
    required InformationEdit? body,
  }) {
    return _amapInformationPatch(body: body);
  }

  ///Edit Information
  @PATCH(path: '/amap/information', optionalBody: true)
  Future<chopper.Response> _amapInformationPatch({
    @Body() required InformationEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update information

**The user must be a member of a group authorized to use manage AMAP to use this endpoint**''',
      summary: 'Edit Information',
      operationId: 'patch_amap_information',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["AMAP"],
      deprecated: false,
    ),
  });

  ///Get Sports
  Future<chopper.Response<List<Sport>>> competitionSportsGet() {
    generatedMapping.putIfAbsent(Sport, () => Sport.fromJsonFactory);

    return _competitionSportsGet();
  }

  ///Get Sports
  @GET(path: '/competition/sports')
  Future<chopper.Response<List<Sport>>> _competitionSportsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Sports',
      operationId: 'get_competition_sports',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Sport
  Future<chopper.Response<Sport>> competitionSportsPost({
    required SportBase? body,
  }) {
    generatedMapping.putIfAbsent(Sport, () => Sport.fromJsonFactory);

    return _competitionSportsPost(body: body);
  }

  ///Create Sport
  @POST(path: '/competition/sports', optionalBody: true)
  Future<chopper.Response<Sport>> _competitionSportsPost({
    @Body() required SportBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Sport',
      operationId: 'post_competition_sports',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Sport
  ///@param sport_id
  Future<chopper.Response> competitionSportsSportIdPatch({
    required String? sportId,
    required SportEdit? body,
  }) {
    return _competitionSportsSportIdPatch(sportId: sportId, body: body);
  }

  ///Edit Sport
  ///@param sport_id
  @PATCH(path: '/competition/sports/{sport_id}', optionalBody: true)
  Future<chopper.Response> _competitionSportsSportIdPatch({
    @Path('sport_id') required String? sportId,
    @Body() required SportEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit Sport',
      operationId: 'patch_competition_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Sport
  ///@param sport_id
  Future<chopper.Response> competitionSportsSportIdDelete({
    required String? sportId,
  }) {
    return _competitionSportsSportIdDelete(sportId: sportId);
  }

  ///Delete Sport
  ///@param sport_id
  @DELETE(path: '/competition/sports/{sport_id}')
  Future<chopper.Response> _competitionSportsSportIdDelete({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Sport',
      operationId: 'delete_competition_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Editions
  Future<chopper.Response<List<CompetitionEdition>>> competitionEditionsGet() {
    generatedMapping.putIfAbsent(
      CompetitionEdition,
      () => CompetitionEdition.fromJsonFactory,
    );

    return _competitionEditionsGet();
  }

  ///Get Editions
  @GET(path: '/competition/editions')
  Future<chopper.Response<List<CompetitionEdition>>> _competitionEditionsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Editions',
      operationId: 'get_competition_editions',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Edition
  Future<chopper.Response<CompetitionEdition>> competitionEditionsPost({
    required CompetitionEditionBase? body,
  }) {
    generatedMapping.putIfAbsent(
      CompetitionEdition,
      () => CompetitionEdition.fromJsonFactory,
    );

    return _competitionEditionsPost(body: body);
  }

  ///Create Edition
  @POST(path: '/competition/editions', optionalBody: true)
  Future<chopper.Response<CompetitionEdition>> _competitionEditionsPost({
    @Body() required CompetitionEditionBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Edition',
      operationId: 'post_competition_editions',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Active Edition
  Future<chopper.Response> competitionEditionsActiveGet() {
    return _competitionEditionsActiveGet();
  }

  ///Get Active Edition
  @GET(path: '/competition/editions/active')
  Future<chopper.Response> _competitionEditionsActiveGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the currently active competition edition.
Returns None if no edition is active.''',
      summary: 'Get Active Edition',
      operationId: 'get_competition_editions_active',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Activate Edition
  ///@param edition_id
  Future<chopper.Response> competitionEditionsEditionIdActivatePost({
    required String? editionId,
  }) {
    return _competitionEditionsEditionIdActivatePost(editionId: editionId);
  }

  ///Activate Edition
  ///@param edition_id
  @POST(path: '/competition/editions/{edition_id}/activate', optionalBody: true)
  Future<chopper.Response> _competitionEditionsEditionIdActivatePost({
    @Path('edition_id') required String? editionId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Activate a competition edition.
If another edition is already active, it will be deactivated.''',
      summary: 'Activate Edition',
      operationId: 'post_competition_editions_{edition_id}_activate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Enable Inscription
  ///@param edition_id
  Future<chopper.Response> competitionEditionsEditionIdInscriptionPost({
    required String? editionId,
    required bool? body,
  }) {
    return _competitionEditionsEditionIdInscriptionPost(
      editionId: editionId,
      body: body,
    );
  }

  ///Enable Inscription
  ///@param edition_id
  @POST(
    path: '/competition/editions/{edition_id}/inscription',
    optionalBody: true,
  )
  Future<chopper.Response> _competitionEditionsEditionIdInscriptionPost({
    @Path('edition_id') required String? editionId,
    @Body() required bool? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Enable inscription for a competition edition.
The edition must already be active.''',
      summary: 'Enable Inscription',
      operationId: 'post_competition_editions_{edition_id}_inscription',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Edition
  ///@param edition_id
  Future<chopper.Response> competitionEditionsEditionIdPatch({
    required String? editionId,
    required CompetitionEditionEdit? body,
  }) {
    return _competitionEditionsEditionIdPatch(editionId: editionId, body: body);
  }

  ///Edit Edition
  ///@param edition_id
  @PATCH(path: '/competition/editions/{edition_id}', optionalBody: true)
  Future<chopper.Response> _competitionEditionsEditionIdPatch({
    @Path('edition_id') required String? editionId,
    @Body() required CompetitionEditionEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit Edition',
      operationId: 'patch_competition_editions_{edition_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Competition Users
  Future<chopper.Response<List<CompetitionUser>>> competitionUsersGet() {
    generatedMapping.putIfAbsent(
      CompetitionUser,
      () => CompetitionUser.fromJsonFactory,
    );

    return _competitionUsersGet();
  }

  ///Get Competition Users
  @GET(path: '/competition/users')
  Future<chopper.Response<List<CompetitionUser>>> _competitionUsersGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all competition users for the current edition.',
      summary: 'Get Competition Users',
      operationId: 'get_competition_users',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Competition User
  Future<chopper.Response<CompetitionUserSimple>> competitionUsersPost({
    required CompetitionUserBase? body,
  }) {
    generatedMapping.putIfAbsent(
      CompetitionUserSimple,
      () => CompetitionUserSimple.fromJsonFactory,
    );

    return _competitionUsersPost(body: body);
  }

  ///Create Competition User
  @POST(path: '/competition/users', optionalBody: true)
  Future<chopper.Response<CompetitionUserSimple>> _competitionUsersPost({
    @Body() required CompetitionUserBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a competition user for the current edition.
The user must exist in the core users database.''',
      summary: 'Create Competition User',
      operationId: 'post_competition_users',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Competition Users By School
  ///@param school_id
  Future<chopper.Response<List<CompetitionUser>>>
  competitionUsersSchoolsSchoolIdGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      CompetitionUser,
      () => CompetitionUser.fromJsonFactory,
    );

    return _competitionUsersSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get Competition Users By School
  ///@param school_id
  @GET(path: '/competition/users/schools/{school_id}')
  Future<chopper.Response<List<CompetitionUser>>>
  _competitionUsersSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get all competition users for the current edition by school.',
      summary: 'Get Competition Users By School',
      operationId: 'get_competition_users_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Current User Competition
  Future<chopper.Response<CompetitionUser>> competitionUsersMeGet() {
    generatedMapping.putIfAbsent(
      CompetitionUser,
      () => CompetitionUser.fromJsonFactory,
    );

    return _competitionUsersMeGet();
  }

  ///Get Current User Competition
  @GET(path: '/competition/users/me')
  Future<chopper.Response<CompetitionUser>> _competitionUsersMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the competition user for the current edition.
This is the user making the request.''',
      summary: 'Get Current User Competition',
      operationId: 'get_competition_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Current User Competition
  Future<chopper.Response> competitionUsersMePatch({
    required CompetitionUserEdit? body,
  }) {
    return _competitionUsersMePatch(body: body);
  }

  ///Edit Current User Competition
  @PATCH(path: '/competition/users/me', optionalBody: true)
  Future<chopper.Response> _competitionUsersMePatch({
    @Body() required CompetitionUserEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Edit the current user\'s competition user for the current edition.
The user must exist in the core users database.''',
      summary: 'Edit Current User Competition',
      operationId: 'patch_competition_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Competition User
  ///@param user_id
  Future<chopper.Response<CompetitionUser>> competitionUsersUserIdGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      CompetitionUser,
      () => CompetitionUser.fromJsonFactory,
    );

    return _competitionUsersUserIdGet(userId: userId);
  }

  ///Get Competition User
  ///@param user_id
  @GET(path: '/competition/users/{user_id}')
  Future<chopper.Response<CompetitionUser>> _competitionUsersUserIdGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get a competition user by their user ID for the current edition.',
      summary: 'Get Competition User',
      operationId: 'get_competition_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Competition User
  ///@param user_id
  Future<chopper.Response> competitionUsersUserIdPatch({
    required String? userId,
    required CompetitionUserEdit? body,
  }) {
    return _competitionUsersUserIdPatch(userId: userId, body: body);
  }

  ///Edit Competition User
  ///@param user_id
  @PATCH(path: '/competition/users/{user_id}', optionalBody: true)
  Future<chopper.Response> _competitionUsersUserIdPatch({
    @Path('user_id') required String? userId,
    @Body() required CompetitionUserEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a competition user for the current edition.
The user must exist in the core users database.''',
      summary: 'Edit Competition User',
      operationId: 'patch_competition_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Competition User
  ///@param user_id
  Future<chopper.Response> competitionUsersUserIdDelete({
    required String? userId,
  }) {
    return _competitionUsersUserIdDelete(userId: userId);
  }

  ///Delete Competition User
  ///@param user_id
  @DELETE(path: '/competition/users/{user_id}')
  Future<chopper.Response> _competitionUsersUserIdDelete({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Competition User',
      operationId: 'delete_competition_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Validate Competition User
  ///@param user_id
  Future<chopper.Response> competitionUsersUserIdValidatePatch({
    required String? userId,
  }) {
    return _competitionUsersUserIdValidatePatch(userId: userId);
  }

  ///Validate Competition User
  ///@param user_id
  @PATCH(path: '/competition/users/{user_id}/validate', optionalBody: true)
  Future<chopper.Response> _competitionUsersUserIdValidatePatch({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Validate Competition User',
      operationId: 'patch_competition_users_{user_id}_validate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Invalidate Competition User
  ///@param user_id
  Future<chopper.Response> competitionUsersUserIdInvalidatePatch({
    required String? userId,
  }) {
    return _competitionUsersUserIdInvalidatePatch(userId: userId);
  }

  ///Invalidate Competition User
  ///@param user_id
  @PATCH(path: '/competition/users/{user_id}/invalidate', optionalBody: true)
  Future<chopper.Response> _competitionUsersUserIdInvalidatePatch({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Invalidate Competition User',
      operationId: 'patch_competition_users_{user_id}_invalidate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Group Members
  ///@param group
  Future<chopper.Response<List<UserGroupMembershipComplete>>>
  competitionGroupsGroupGet({required enums.CompetitionGroupType? group}) {
    generatedMapping.putIfAbsent(
      UserGroupMembershipComplete,
      () => UserGroupMembershipComplete.fromJsonFactory,
    );

    return _competitionGroupsGroupGet(group: group?.value?.toString());
  }

  ///Get Group Members
  ///@param group
  @GET(path: '/competition/groups/{group}')
  Future<chopper.Response<List<UserGroupMembershipComplete>>>
  _competitionGroupsGroupGet({
    @Path('group') required String? group,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get all users in a specific competition group for the current edition.',
      summary: 'Get Group Members',
      operationId: 'get_competition_groups_{group}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Current User Groups
  Future<chopper.Response<List<UserGroupMembership>>>
  competitionUsersMeGroupsGet() {
    generatedMapping.putIfAbsent(
      UserGroupMembership,
      () => UserGroupMembership.fromJsonFactory,
    );

    return _competitionUsersMeGroupsGet();
  }

  ///Get Current User Groups
  @GET(path: '/competition/users/me/groups')
  Future<chopper.Response<List<UserGroupMembership>>>
  _competitionUsersMeGroupsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get all groups the current user is a member of in the current edition.
This is the user making the request.''',
      summary: 'Get Current User Groups',
      operationId: 'get_competition_users_me_groups',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get User Groups
  ///@param user_id
  Future<chopper.Response<List<UserGroupMembership>>>
  competitionUsersUserIdGroupsGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      UserGroupMembership,
      () => UserGroupMembership.fromJsonFactory,
    );

    return _competitionUsersUserIdGroupsGet(userId: userId);
  }

  ///Get User Groups
  ///@param user_id
  @GET(path: '/competition/users/{user_id}/groups')
  Future<chopper.Response<List<UserGroupMembership>>>
  _competitionUsersUserIdGroupsGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get all groups a user is a member of in the current edition.',
      summary: 'Get User Groups',
      operationId: 'get_competition_users_{user_id}_groups',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Add User To Group
  ///@param group
  ///@param user_id
  Future<chopper.Response<UserGroupMembership>>
  competitionGroupsGroupUsersUserIdPost({
    required enums.CompetitionGroupType? group,
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(
      UserGroupMembership,
      () => UserGroupMembership.fromJsonFactory,
    );

    return _competitionGroupsGroupUsersUserIdPost(
      group: group?.value?.toString(),
      userId: userId,
    );
  }

  ///Add User To Group
  ///@param group
  ///@param user_id
  @POST(path: '/competition/groups/{group}/users/{user_id}', optionalBody: true)
  Future<chopper.Response<UserGroupMembership>>
  _competitionGroupsGroupUsersUserIdPost({
    @Path('group') required String? group,
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Add User To Group',
      operationId: 'post_competition_groups_{group}_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Remove User From Group
  ///@param group
  ///@param user_id
  Future<chopper.Response> competitionGroupsGroupUsersUserIdDelete({
    required enums.CompetitionGroupType? group,
    required String? userId,
  }) {
    return _competitionGroupsGroupUsersUserIdDelete(
      group: group?.value?.toString(),
      userId: userId,
    );
  }

  ///Remove User From Group
  ///@param group
  ///@param user_id
  @DELETE(path: '/competition/groups/{group}/users/{user_id}')
  Future<chopper.Response> _competitionGroupsGroupUsersUserIdDelete({
    @Path('group') required String? group,
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Remove User From Group',
      operationId: 'delete_competition_groups_{group}_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Schools
  Future<chopper.Response<List<SchoolExtension>>> competitionSchoolsGet() {
    generatedMapping.putIfAbsent(
      SchoolExtension,
      () => SchoolExtension.fromJsonFactory,
    );

    return _competitionSchoolsGet();
  }

  ///Get Schools
  @GET(path: '/competition/schools')
  Future<chopper.Response<List<SchoolExtension>>> _competitionSchoolsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Schools',
      operationId: 'get_competition_schools',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create School Extension
  Future<chopper.Response<SchoolExtensionBase>> competitionSchoolsPost({
    required SchoolExtensionBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SchoolExtensionBase,
      () => SchoolExtensionBase.fromJsonFactory,
    );

    return _competitionSchoolsPost(body: body);
  }

  ///Create School Extension
  @POST(path: '/competition/schools', optionalBody: true)
  Future<chopper.Response<SchoolExtensionBase>> _competitionSchoolsPost({
    @Body() required SchoolExtensionBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create School Extension',
      operationId: 'post_competition_schools',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get School
  ///@param school_id
  Future<chopper.Response<SchoolExtension>> competitionSchoolsSchoolIdGet({
    required String? schoolId,
  }) {
    generatedMapping.putIfAbsent(
      SchoolExtension,
      () => SchoolExtension.fromJsonFactory,
    );

    return _competitionSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get School
  ///@param school_id
  @GET(path: '/competition/schools/{school_id}')
  Future<chopper.Response<SchoolExtension>> _competitionSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get School',
      operationId: 'get_competition_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit School Extension
  ///@param school_id
  Future<chopper.Response> competitionSchoolsSchoolIdPatch({
    required String? schoolId,
    required SchoolExtensionEdit? body,
  }) {
    return _competitionSchoolsSchoolIdPatch(schoolId: schoolId, body: body);
  }

  ///Edit School Extension
  ///@param school_id
  @PATCH(path: '/competition/schools/{school_id}', optionalBody: true)
  Future<chopper.Response> _competitionSchoolsSchoolIdPatch({
    @Path('school_id') required String? schoolId,
    @Body() required SchoolExtensionEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit School Extension',
      operationId: 'patch_competition_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete School Extension
  ///@param school_id
  Future<chopper.Response> competitionSchoolsSchoolIdDelete({
    required String? schoolId,
  }) {
    return _competitionSchoolsSchoolIdDelete(schoolId: schoolId);
  }

  ///Delete School Extension
  ///@param school_id
  @DELETE(path: '/competition/schools/{school_id}')
  Future<chopper.Response> _competitionSchoolsSchoolIdDelete({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete School Extension',
      operationId: 'delete_competition_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get School General Quota
  ///@param school_id
  Future<chopper.Response<SchoolGeneralQuota>>
  competitionSchoolsSchoolIdGeneralQuotaGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      SchoolGeneralQuota,
      () => SchoolGeneralQuota.fromJsonFactory,
    );

    return _competitionSchoolsSchoolIdGeneralQuotaGet(schoolId: schoolId);
  }

  ///Get School General Quota
  ///@param school_id
  @GET(path: '/competition/schools/{school_id}/general-quota')
  Future<chopper.Response<SchoolGeneralQuota>>
  _competitionSchoolsSchoolIdGeneralQuotaGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get School General Quota',
      operationId: 'get_competition_schools_{school_id}_general-quota',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create School General Quota
  ///@param school_id
  Future<chopper.Response<SchoolGeneralQuota>>
  competitionSchoolsSchoolIdGeneralQuotaPost({
    required String? schoolId,
    required SchoolGeneralQuotaBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SchoolGeneralQuota,
      () => SchoolGeneralQuota.fromJsonFactory,
    );

    return _competitionSchoolsSchoolIdGeneralQuotaPost(
      schoolId: schoolId,
      body: body,
    );
  }

  ///Create School General Quota
  ///@param school_id
  @POST(
    path: '/competition/schools/{school_id}/general-quota',
    optionalBody: true,
  )
  Future<chopper.Response<SchoolGeneralQuota>>
  _competitionSchoolsSchoolIdGeneralQuotaPost({
    @Path('school_id') required String? schoolId,
    @Body() required SchoolGeneralQuotaBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create School General Quota',
      operationId: 'post_competition_schools_{school_id}_general-quota',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit School General Quota
  ///@param school_id
  Future<chopper.Response> competitionSchoolsSchoolIdGeneralQuotaPatch({
    required String? schoolId,
    required SchoolGeneralQuotaBase? body,
  }) {
    return _competitionSchoolsSchoolIdGeneralQuotaPatch(
      schoolId: schoolId,
      body: body,
    );
  }

  ///Edit School General Quota
  ///@param school_id
  @PATCH(
    path: '/competition/schools/{school_id}/general-quota',
    optionalBody: true,
  )
  Future<chopper.Response> _competitionSchoolsSchoolIdGeneralQuotaPatch({
    @Path('school_id') required String? schoolId,
    @Body() required SchoolGeneralQuotaBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit School General Quota',
      operationId: 'patch_competition_schools_{school_id}_general-quota',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Quotas For Sport
  ///@param sport_id
  Future<chopper.Response<List<SchoolSportQuota>>>
  competitionSportsSportIdQuotasGet({required String? sportId}) {
    generatedMapping.putIfAbsent(
      SchoolSportQuota,
      () => SchoolSportQuota.fromJsonFactory,
    );

    return _competitionSportsSportIdQuotasGet(sportId: sportId);
  }

  ///Get Quotas For Sport
  ///@param sport_id
  @GET(path: '/competition/sports/{sport_id}/quotas')
  Future<chopper.Response<List<SchoolSportQuota>>>
  _competitionSportsSportIdQuotasGet({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Quotas For Sport',
      operationId: 'get_competition_sports_{sport_id}_quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Quotas For School
  ///@param school_id
  Future<chopper.Response<List<SchoolSportQuota>>>
  competitionSchoolsSchoolIdSportsQuotasGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      SchoolSportQuota,
      () => SchoolSportQuota.fromJsonFactory,
    );

    return _competitionSchoolsSchoolIdSportsQuotasGet(schoolId: schoolId);
  }

  ///Get Quotas For School
  ///@param school_id
  @GET(path: '/competition/schools/{school_id}/sports-quotas')
  Future<chopper.Response<List<SchoolSportQuota>>>
  _competitionSchoolsSchoolIdSportsQuotasGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Quotas For School',
      operationId: 'get_competition_schools_{school_id}_sports-quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Sport Quota
  ///@param school_id
  ///@param sport_id
  Future<chopper.Response> competitionSchoolsSchoolIdSportsSportIdQuotasPost({
    required String? schoolId,
    required String? sportId,
    required SportQuotaInfo? body,
  }) {
    return _competitionSchoolsSchoolIdSportsSportIdQuotasPost(
      schoolId: schoolId,
      sportId: sportId,
      body: body,
    );
  }

  ///Create Sport Quota
  ///@param school_id
  ///@param sport_id
  @POST(
    path: '/competition/schools/{school_id}/sports/{sport_id}/quotas',
    optionalBody: true,
  )
  Future<chopper.Response> _competitionSchoolsSchoolIdSportsSportIdQuotasPost({
    @Path('school_id') required String? schoolId,
    @Path('sport_id') required String? sportId,
    @Body() required SportQuotaInfo? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Sport Quota',
      operationId:
          'post_competition_schools_{school_id}_sports_{sport_id}_quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Sport Quota
  ///@param school_id
  ///@param sport_id
  Future<chopper.Response> competitionSchoolsSchoolIdSportsSportIdQuotasPatch({
    required String? schoolId,
    required String? sportId,
    required SchoolSportQuotaEdit? body,
  }) {
    return _competitionSchoolsSchoolIdSportsSportIdQuotasPatch(
      schoolId: schoolId,
      sportId: sportId,
      body: body,
    );
  }

  ///Edit Sport Quota
  ///@param school_id
  ///@param sport_id
  @PATCH(
    path: '/competition/schools/{school_id}/sports/{sport_id}/quotas',
    optionalBody: true,
  )
  Future<chopper.Response> _competitionSchoolsSchoolIdSportsSportIdQuotasPatch({
    @Path('school_id') required String? schoolId,
    @Path('sport_id') required String? sportId,
    @Body() required SchoolSportQuotaEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit Sport Quota',
      operationId:
          'patch_competition_schools_{school_id}_sports_{sport_id}_quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Sport Quota
  ///@param school_id
  ///@param sport_id
  Future<chopper.Response> competitionSchoolsSchoolIdSportsSportIdQuotasDelete({
    required String? schoolId,
    required String? sportId,
  }) {
    return _competitionSchoolsSchoolIdSportsSportIdQuotasDelete(
      schoolId: schoolId,
      sportId: sportId,
    );
  }

  ///Delete Sport Quota
  ///@param school_id
  ///@param sport_id
  @DELETE(path: '/competition/schools/{school_id}/sports/{sport_id}/quotas')
  Future<chopper.Response>
  _competitionSchoolsSchoolIdSportsSportIdQuotasDelete({
    @Path('school_id') required String? schoolId,
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Sport Quota',
      operationId:
          'delete_competition_schools_{school_id}_sports_{sport_id}_quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Product Quotas For School
  ///@param school_id
  Future<chopper.Response<List<SchoolProductQuota>>>
  competitionSchoolsSchoolIdProductQuotasGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      SchoolProductQuota,
      () => SchoolProductQuota.fromJsonFactory,
    );

    return _competitionSchoolsSchoolIdProductQuotasGet(schoolId: schoolId);
  }

  ///Get Product Quotas For School
  ///@param school_id
  @GET(path: '/competition/schools/{school_id}/product-quotas')
  Future<chopper.Response<List<SchoolProductQuota>>>
  _competitionSchoolsSchoolIdProductQuotasGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Product Quotas For School',
      operationId: 'get_competition_schools_{school_id}_product-quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Product Quota
  ///@param school_id
  Future<chopper.Response<SchoolProductQuota>>
  competitionSchoolsSchoolIdProductQuotasPost({
    required String? schoolId,
    required SchoolProductQuotaBase? body,
  }) {
    generatedMapping.putIfAbsent(
      SchoolProductQuota,
      () => SchoolProductQuota.fromJsonFactory,
    );

    return _competitionSchoolsSchoolIdProductQuotasPost(
      schoolId: schoolId,
      body: body,
    );
  }

  ///Create Product Quota
  ///@param school_id
  @POST(
    path: '/competition/schools/{school_id}/product-quotas',
    optionalBody: true,
  )
  Future<chopper.Response<SchoolProductQuota>>
  _competitionSchoolsSchoolIdProductQuotasPost({
    @Path('school_id') required String? schoolId,
    @Body() required SchoolProductQuotaBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Product Quota',
      operationId: 'post_competition_schools_{school_id}_product-quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Product Quotas For Product
  ///@param product_id
  Future<chopper.Response<List<SchoolProductQuota>>>
  competitionProductsProductIdSchoolsQuotasGet({required String? productId}) {
    generatedMapping.putIfAbsent(
      SchoolProductQuota,
      () => SchoolProductQuota.fromJsonFactory,
    );

    return _competitionProductsProductIdSchoolsQuotasGet(productId: productId);
  }

  ///Get Product Quotas For Product
  ///@param product_id
  @GET(path: '/competition/products/{product_id}/schools-quotas')
  Future<chopper.Response<List<SchoolProductQuota>>>
  _competitionProductsProductIdSchoolsQuotasGet({
    @Path('product_id') required String? productId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Product Quotas For Product',
      operationId: 'get_competition_products_{product_id}_schools-quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Product Quota
  ///@param school_id
  ///@param product_id
  Future<chopper.Response>
  competitionSchoolsSchoolIdProductQuotasProductIdPatch({
    required String? schoolId,
    required String? productId,
    required SchoolProductQuotaEdit? body,
  }) {
    return _competitionSchoolsSchoolIdProductQuotasProductIdPatch(
      schoolId: schoolId,
      productId: productId,
      body: body,
    );
  }

  ///Edit Product Quota
  ///@param school_id
  ///@param product_id
  @PATCH(
    path: '/competition/schools/{school_id}/product-quotas/{product_id}',
    optionalBody: true,
  )
  Future<chopper.Response>
  _competitionSchoolsSchoolIdProductQuotasProductIdPatch({
    @Path('school_id') required String? schoolId,
    @Path('product_id') required String? productId,
    @Body() required SchoolProductQuotaEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit Product Quota',
      operationId:
          'patch_competition_schools_{school_id}_product-quotas_{product_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Product Quota
  ///@param school_id
  ///@param product_id
  Future<chopper.Response>
  competitionSchoolsSchoolIdProductQuotasProductIdDelete({
    required String? schoolId,
    required String? productId,
  }) {
    return _competitionSchoolsSchoolIdProductQuotasProductIdDelete(
      schoolId: schoolId,
      productId: productId,
    );
  }

  ///Delete Product Quota
  ///@param school_id
  ///@param product_id
  @DELETE(path: '/competition/schools/{school_id}/product-quotas/{product_id}')
  Future<chopper.Response>
  _competitionSchoolsSchoolIdProductQuotasProductIdDelete({
    @Path('school_id') required String? schoolId,
    @Path('product_id') required String? productId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Product Quota',
      operationId:
          'delete_competition_schools_{school_id}_product-quotas_{product_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Teams
  Future<chopper.Response<List<TeamComplete>>> competitionTeamsGet() {
    generatedMapping.putIfAbsent(
      TeamComplete,
      () => TeamComplete.fromJsonFactory,
    );

    return _competitionTeamsGet();
  }

  ///Get Teams
  @GET(path: '/competition/teams')
  Future<chopper.Response<List<TeamComplete>>> _competitionTeamsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Teams',
      operationId: 'get_competition_teams',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Team
  Future<chopper.Response<Team>> competitionTeamsPost({
    required TeamInfo? body,
  }) {
    generatedMapping.putIfAbsent(Team, () => Team.fromJsonFactory);

    return _competitionTeamsPost(body: body);
  }

  ///Create Team
  @POST(path: '/competition/teams', optionalBody: true)
  Future<chopper.Response<Team>> _competitionTeamsPost({
    @Body() required TeamInfo? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Team',
      operationId: 'post_competition_teams',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Current User Team As Captain
  Future<chopper.Response<TeamComplete>> competitionTeamsMeGet() {
    generatedMapping.putIfAbsent(
      TeamComplete,
      () => TeamComplete.fromJsonFactory,
    );

    return _competitionTeamsMeGet();
  }

  ///Get Current User Team As Captain
  @GET(path: '/competition/teams/me')
  Future<chopper.Response<TeamComplete>> _competitionTeamsMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Current User Team As Captain',
      operationId: 'get_competition_teams_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Teams For Sport
  ///@param sport_id
  Future<chopper.Response<List<TeamComplete>>>
  competitionTeamsSportsSportIdGet({required String? sportId}) {
    generatedMapping.putIfAbsent(
      TeamComplete,
      () => TeamComplete.fromJsonFactory,
    );

    return _competitionTeamsSportsSportIdGet(sportId: sportId);
  }

  ///Get Teams For Sport
  ///@param sport_id
  @GET(path: '/competition/teams/sports/{sport_id}')
  Future<chopper.Response<List<TeamComplete>>>
  _competitionTeamsSportsSportIdGet({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Teams For Sport',
      operationId: 'get_competition_teams_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Teams For School
  ///@param school_id
  Future<chopper.Response<List<TeamComplete>>>
  competitionTeamsSchoolsSchoolIdGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      TeamComplete,
      () => TeamComplete.fromJsonFactory,
    );

    return _competitionTeamsSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get Teams For School
  ///@param school_id
  @GET(path: '/competition/teams/schools/{school_id}')
  Future<chopper.Response<List<TeamComplete>>>
  _competitionTeamsSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Teams For School',
      operationId: 'get_competition_teams_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Sport Teams For School And Sport
  ///@param school_id
  ///@param sport_id
  Future<chopper.Response<List<TeamComplete>>>
  competitionTeamsSportsSportIdSchoolsSchoolIdGet({
    required String? schoolId,
    required String? sportId,
  }) {
    generatedMapping.putIfAbsent(
      TeamComplete,
      () => TeamComplete.fromJsonFactory,
    );

    return _competitionTeamsSportsSportIdSchoolsSchoolIdGet(
      schoolId: schoolId,
      sportId: sportId,
    );
  }

  ///Get Sport Teams For School And Sport
  ///@param school_id
  ///@param sport_id
  @GET(path: '/competition/teams/sports/{sport_id}/schools/{school_id}')
  Future<chopper.Response<List<TeamComplete>>>
  _competitionTeamsSportsSportIdSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Sport Teams For School And Sport',
      operationId:
          'get_competition_teams_sports_{sport_id}_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Team
  ///@param team_id
  Future<chopper.Response> competitionTeamsTeamIdPatch({
    required String? teamId,
    required TeamEdit? body,
  }) {
    return _competitionTeamsTeamIdPatch(teamId: teamId, body: body);
  }

  ///Edit Team
  ///@param team_id
  @PATCH(path: '/competition/teams/{team_id}', optionalBody: true)
  Future<chopper.Response> _competitionTeamsTeamIdPatch({
    @Path('team_id') required String? teamId,
    @Body() required TeamEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit Team',
      operationId: 'patch_competition_teams_{team_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Team
  ///@param team_id
  Future<chopper.Response> competitionTeamsTeamIdDelete({
    required String? teamId,
  }) {
    return _competitionTeamsTeamIdDelete(teamId: teamId);
  }

  ///Delete Team
  ///@param team_id
  @DELETE(path: '/competition/teams/{team_id}')
  Future<chopper.Response> _competitionTeamsTeamIdDelete({
    @Path('team_id') required String? teamId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Team',
      operationId: 'delete_competition_teams_{team_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Current User Participant
  Future<chopper.Response<ParticipantComplete>> competitionParticipantsMeGet() {
    generatedMapping.putIfAbsent(
      ParticipantComplete,
      () => ParticipantComplete.fromJsonFactory,
    );

    return _competitionParticipantsMeGet();
  }

  ///Get Current User Participant
  @GET(path: '/competition/participants/me')
  Future<chopper.Response<ParticipantComplete>> _competitionParticipantsMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Current User Participant',
      operationId: 'get_competition_participants_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Participants For Sport
  ///@param sport_id
  Future<chopper.Response<List<ParticipantComplete>>>
  competitionParticipantsSportsSportIdGet({required String? sportId}) {
    generatedMapping.putIfAbsent(
      ParticipantComplete,
      () => ParticipantComplete.fromJsonFactory,
    );

    return _competitionParticipantsSportsSportIdGet(sportId: sportId);
  }

  ///Get Participants For Sport
  ///@param sport_id
  @GET(path: '/competition/participants/sports/{sport_id}')
  Future<chopper.Response<List<ParticipantComplete>>>
  _competitionParticipantsSportsSportIdGet({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Participants For Sport',
      operationId: 'get_competition_participants_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Participants For School
  ///@param school_id
  Future<chopper.Response<List<ParticipantComplete>>>
  competitionParticipantsSchoolsSchoolIdGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      ParticipantComplete,
      () => ParticipantComplete.fromJsonFactory,
    );

    return _competitionParticipantsSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get Participants For School
  ///@param school_id
  @GET(path: '/competition/participants/schools/{school_id}')
  Future<chopper.Response<List<ParticipantComplete>>>
  _competitionParticipantsSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Participants For School',
      operationId: 'get_competition_participants_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Download Participant Certificate
  ///@param user_id
  Future<chopper.Response> competitionParticipantsUsersUserIdCertificateGet({
    required String? userId,
  }) {
    return _competitionParticipantsUsersUserIdCertificateGet(userId: userId);
  }

  ///Download Participant Certificate
  ///@param user_id
  @GET(path: '/competition/participants/users/{user_id}/certificate')
  Future<chopper.Response> _competitionParticipantsUsersUserIdCertificateGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Download Participant Certificate',
      operationId: 'get_competition_participants_users_{user_id}_certificate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Join Sport
  ///@param sport_id
  Future<chopper.Response<Participant>>
  competitionSportsSportIdParticipatePost({
    required String? sportId,
    required ParticipantInfo? body,
  }) {
    generatedMapping.putIfAbsent(
      Participant,
      () => Participant.fromJsonFactory,
    );

    return _competitionSportsSportIdParticipatePost(
      sportId: sportId,
      body: body,
    );
  }

  ///Join Sport
  ///@param sport_id
  @POST(path: '/competition/sports/{sport_id}/participate', optionalBody: true)
  Future<chopper.Response<Participant>>
  _competitionSportsSportIdParticipatePost({
    @Path('sport_id') required String? sportId,
    @Body() required ParticipantInfo? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Join Sport',
      operationId: 'post_competition_sports_{sport_id}_participate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Upload Participant Certificate
  ///@param sport_id
  Future<chopper.Response> competitionParticipantsSportsSportIdCertificatePost({
    required String? sportId,
    required List<int> certificate,
  }) {
    return _competitionParticipantsSportsSportIdCertificatePost(
      sportId: sportId,
      certificate: certificate,
    );
  }

  ///Upload Participant Certificate
  ///@param sport_id
  @POST(
    path: '/competition/participants/sports/{sport_id}/certificate',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response>
  _competitionParticipantsSportsSportIdCertificatePost({
    @Path('sport_id') required String? sportId,
    @PartFile('certificate') required List<int> certificate,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Upload Participant Certificate',
      operationId:
          'post_competition_participants_sports_{sport_id}_certificate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Participant Certificate File
  ///@param sport_id
  Future<chopper.Response>
  competitionParticipantsSportsSportIdCertificateDelete({
    required String? sportId,
  }) {
    return _competitionParticipantsSportsSportIdCertificateDelete(
      sportId: sportId,
    );
  }

  ///Delete Participant Certificate File
  ///@param sport_id
  @DELETE(path: '/competition/participants/sports/{sport_id}/certificate')
  Future<chopper.Response>
  _competitionParticipantsSportsSportIdCertificateDelete({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Participant Certificate File',
      operationId:
          'delete_competition_participants_sports_{sport_id}_certificate',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Mark Participant License As Valid
  ///@param sport_id
  ///@param user_id
  ///@param is_license_valid
  Future<chopper.Response>
  competitionParticipantsSportsSportIdUsersUserIdLicensePatch({
    required String? sportId,
    required String? userId,
    required bool? isLicenseValid,
  }) {
    return _competitionParticipantsSportsSportIdUsersUserIdLicensePatch(
      sportId: sportId,
      userId: userId,
      isLicenseValid: isLicenseValid,
    );
  }

  ///Mark Participant License As Valid
  ///@param sport_id
  ///@param user_id
  ///@param is_license_valid
  @PATCH(
    path: '/competition/participants/sports/{sport_id}/users/{user_id}/license',
    optionalBody: true,
  )
  Future<chopper.Response>
  _competitionParticipantsSportsSportIdUsersUserIdLicensePatch({
    @Path('sport_id') required String? sportId,
    @Path('user_id') required String? userId,
    @Query('is_license_valid') required bool? isLicenseValid,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Mark Participant License As Valid',
      operationId:
          'patch_competition_participants_sports_{sport_id}_users_{user_id}_license',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Withdraw From Sport
  ///@param sport_id
  Future<chopper.Response> competitionSportsSportIdWithdrawDelete({
    required String? sportId,
  }) {
    return _competitionSportsSportIdWithdrawDelete(sportId: sportId);
  }

  ///Withdraw From Sport
  ///@param sport_id
  @DELETE(path: '/competition/sports/{sport_id}/withdraw')
  Future<chopper.Response> _competitionSportsSportIdWithdrawDelete({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Withdraw From Sport',
      operationId: 'delete_competition_sports_{sport_id}_withdraw',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Participant
  ///@param user_id
  ///@param sport_id
  Future<chopper.Response> competitionParticipantsUserIdSportsSportIdDelete({
    required String? userId,
    required String? sportId,
  }) {
    return _competitionParticipantsUserIdSportsSportIdDelete(
      userId: userId,
      sportId: sportId,
    );
  }

  ///Delete Participant
  ///@param user_id
  ///@param sport_id
  @DELETE(path: '/competition/participants/{user_id}/sports/{sport_id}')
  Future<chopper.Response> _competitionParticipantsUserIdSportsSportIdDelete({
    @Path('user_id') required String? userId,
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Participant',
      operationId:
          'delete_competition_participants_{user_id}_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get All Locations
  Future<chopper.Response<List<Location>>> competitionLocationsGet() {
    generatedMapping.putIfAbsent(Location, () => Location.fromJsonFactory);

    return _competitionLocationsGet();
  }

  ///Get All Locations
  @GET(path: '/competition/locations')
  Future<chopper.Response<List<Location>>> _competitionLocationsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get All Locations',
      operationId: 'get_competition_locations',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Location
  Future<chopper.Response<Location>> competitionLocationsPost({
    required LocationBase? body,
  }) {
    generatedMapping.putIfAbsent(Location, () => Location.fromJsonFactory);

    return _competitionLocationsPost(body: body);
  }

  ///Create Location
  @POST(path: '/competition/locations', optionalBody: true)
  Future<chopper.Response<Location>> _competitionLocationsPost({
    @Body() required LocationBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Location',
      operationId: 'post_competition_locations',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Location By Id
  ///@param location_id
  Future<chopper.Response<LocationComplete>> competitionLocationsLocationIdGet({
    required String? locationId,
  }) {
    generatedMapping.putIfAbsent(
      LocationComplete,
      () => LocationComplete.fromJsonFactory,
    );

    return _competitionLocationsLocationIdGet(locationId: locationId);
  }

  ///Get Location By Id
  ///@param location_id
  @GET(path: '/competition/locations/{location_id}')
  Future<chopper.Response<LocationComplete>>
  _competitionLocationsLocationIdGet({
    @Path('location_id') required String? locationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Location By Id',
      operationId: 'get_competition_locations_{location_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Location
  ///@param location_id
  Future<chopper.Response> competitionLocationsLocationIdPatch({
    required String? locationId,
    required LocationEdit? body,
  }) {
    return _competitionLocationsLocationIdPatch(
      locationId: locationId,
      body: body,
    );
  }

  ///Edit Location
  ///@param location_id
  @PATCH(path: '/competition/locations/{location_id}', optionalBody: true)
  Future<chopper.Response> _competitionLocationsLocationIdPatch({
    @Path('location_id') required String? locationId,
    @Body() required LocationEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit Location',
      operationId: 'patch_competition_locations_{location_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Location
  ///@param location_id
  Future<chopper.Response> competitionLocationsLocationIdDelete({
    required String? locationId,
  }) {
    return _competitionLocationsLocationIdDelete(locationId: locationId);
  }

  ///Delete Location
  ///@param location_id
  @DELETE(path: '/competition/locations/{location_id}')
  Future<chopper.Response> _competitionLocationsLocationIdDelete({
    @Path('location_id') required String? locationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Location',
      operationId: 'delete_competition_locations_{location_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get All Matches For Edition
  Future<chopper.Response<List<MatchComplete>>> competitionMatchesGet() {
    generatedMapping.putIfAbsent(
      MatchComplete,
      () => MatchComplete.fromJsonFactory,
    );

    return _competitionMatchesGet();
  }

  ///Get All Matches For Edition
  @GET(path: '/competition/matches')
  Future<chopper.Response<List<MatchComplete>>> _competitionMatchesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get All Matches For Edition',
      operationId: 'get_competition_matches',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Matches For Sport And Edition
  ///@param sport_id
  Future<chopper.Response<List<MatchComplete>>>
  competitionMatchesSportsSportIdGet({required String? sportId}) {
    generatedMapping.putIfAbsent(
      MatchComplete,
      () => MatchComplete.fromJsonFactory,
    );

    return _competitionMatchesSportsSportIdGet(sportId: sportId);
  }

  ///Get Matches For Sport And Edition
  ///@param sport_id
  @GET(path: '/competition/matches/sports/{sport_id}')
  Future<chopper.Response<List<MatchComplete>>>
  _competitionMatchesSportsSportIdGet({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Matches For Sport And Edition',
      operationId: 'get_competition_matches_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Match
  ///@param sport_id
  Future<chopper.Response<Match>> competitionMatchesSportsSportIdPost({
    required String? sportId,
    required MatchBase? body,
  }) {
    generatedMapping.putIfAbsent(Match, () => Match.fromJsonFactory);

    return _competitionMatchesSportsSportIdPost(sportId: sportId, body: body);
  }

  ///Create Match
  ///@param sport_id
  @POST(path: '/competition/matches/sports/{sport_id}', optionalBody: true)
  Future<chopper.Response<Match>> _competitionMatchesSportsSportIdPost({
    @Path('sport_id') required String? sportId,
    @Body() required MatchBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Match',
      operationId: 'post_competition_matches_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Matches For School Sport And Edition
  ///@param school_id
  Future<chopper.Response<List<MatchComplete>>>
  competitionMatchesSchoolsSchoolIdGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      MatchComplete,
      () => MatchComplete.fromJsonFactory,
    );

    return _competitionMatchesSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get Matches For School Sport And Edition
  ///@param school_id
  @GET(path: '/competition/matches/schools/{school_id}')
  Future<chopper.Response<List<MatchComplete>>>
  _competitionMatchesSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Matches For School Sport And Edition',
      operationId: 'get_competition_matches_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Edit Match
  ///@param match_id
  Future<chopper.Response> competitionMatchesMatchIdPatch({
    required String? matchId,
    required MatchEdit? body,
  }) {
    return _competitionMatchesMatchIdPatch(matchId: matchId, body: body);
  }

  ///Edit Match
  ///@param match_id
  @PATCH(path: '/competition/matches/{match_id}', optionalBody: true)
  Future<chopper.Response> _competitionMatchesMatchIdPatch({
    @Path('match_id') required String? matchId,
    @Body() required MatchEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Edit Match',
      operationId: 'patch_competition_matches_{match_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Match
  ///@param match_id
  Future<chopper.Response> competitionMatchesMatchIdDelete({
    required String? matchId,
  }) {
    return _competitionMatchesMatchIdDelete(matchId: matchId);
  }

  ///Delete Match
  ///@param match_id
  @DELETE(path: '/competition/matches/{match_id}')
  Future<chopper.Response> _competitionMatchesMatchIdDelete({
    @Path('match_id') required String? matchId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete Match',
      operationId: 'delete_competition_matches_{match_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Global Podiums
  Future<chopper.Response<List<SchoolResult>>> competitionPodiumsGlobalGet() {
    generatedMapping.putIfAbsent(
      SchoolResult,
      () => SchoolResult.fromJsonFactory,
    );

    return _competitionPodiumsGlobalGet();
  }

  ///Get Global Podiums
  @GET(path: '/competition/podiums/global')
  Future<chopper.Response<List<SchoolResult>>> _competitionPodiumsGlobalGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get the global podiums for the current edition.',
      summary: 'Get Global Podiums',
      operationId: 'get_competition_podiums_global',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Sport Podiums
  ///@param sport_id
  Future<chopper.Response<List<TeamSportResultComplete>>>
  competitionPodiumsSportsSportIdGet({required String? sportId}) {
    generatedMapping.putIfAbsent(
      TeamSportResultComplete,
      () => TeamSportResultComplete.fromJsonFactory,
    );

    return _competitionPodiumsSportsSportIdGet(sportId: sportId);
  }

  ///Get Sport Podiums
  ///@param sport_id
  @GET(path: '/competition/podiums/sports/{sport_id}')
  Future<chopper.Response<List<TeamSportResultComplete>>>
  _competitionPodiumsSportsSportIdGet({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get the podiums for a specific sport in the current edition.',
      summary: 'Get Sport Podiums',
      operationId: 'get_competition_podiums_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Sport Podium
  ///@param sport_id
  Future<chopper.Response<List<TeamSportResult>>>
  competitionPodiumsSportsSportIdPost({
    required String? sportId,
    required SportPodiumRankings? body,
  }) {
    generatedMapping.putIfAbsent(
      TeamSportResult,
      () => TeamSportResult.fromJsonFactory,
    );

    return _competitionPodiumsSportsSportIdPost(sportId: sportId, body: body);
  }

  ///Create Sport Podium
  ///@param sport_id
  @POST(path: '/competition/podiums/sports/{sport_id}', optionalBody: true)
  Future<chopper.Response<List<TeamSportResult>>>
  _competitionPodiumsSportsSportIdPost({
    @Path('sport_id') required String? sportId,
    @Body() required SportPodiumRankings? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Create or update the podium for a specific sport in the current edition.',
      summary: 'Create Sport Podium',
      operationId: 'post_competition_podiums_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Sport Podium
  ///@param sport_id
  Future<chopper.Response> competitionPodiumsSportsSportIdDelete({
    required String? sportId,
  }) {
    return _competitionPodiumsSportsSportIdDelete(sportId: sportId);
  }

  ///Delete Sport Podium
  ///@param sport_id
  @DELETE(path: '/competition/podiums/sports/{sport_id}')
  Future<chopper.Response> _competitionPodiumsSportsSportIdDelete({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Delete the podium for a specific sport in the current edition.',
      summary: 'Delete Sport Podium',
      operationId: 'delete_competition_podiums_sports_{sport_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Pompom Podiums
  Future<chopper.Response<List<SchoolResult>>> competitionPodiumsPompomsGet() {
    generatedMapping.putIfAbsent(
      SchoolResult,
      () => SchoolResult.fromJsonFactory,
    );

    return _competitionPodiumsPompomsGet();
  }

  ///Get Pompom Podiums
  @GET(path: '/competition/podiums/pompoms')
  Future<chopper.Response<List<SchoolResult>>> _competitionPodiumsPompomsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get the pompoms podiums in the current edition.',
      summary: 'Get Pompom Podiums',
      operationId: 'get_competition_podiums_pompoms',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Pompom Podium
  Future<chopper.Response<List<SchoolResult>>> competitionPodiumsPompomsPost({
    required List<SchoolResult>? body,
  }) {
    generatedMapping.putIfAbsent(
      SchoolResult,
      () => SchoolResult.fromJsonFactory,
    );

    return _competitionPodiumsPompomsPost(body: body);
  }

  ///Create Pompom Podium
  @POST(path: '/competition/podiums/pompoms', optionalBody: true)
  Future<chopper.Response<List<SchoolResult>>> _competitionPodiumsPompomsPost({
    @Body() required List<SchoolResult>? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Create or update the pompoms podium in the current edition.',
      summary: 'Create Pompom Podium',
      operationId: 'post_competition_podiums_pompoms',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Pompom Podium
  Future<chopper.Response> competitionPodiumsPompomsDelete() {
    return _competitionPodiumsPompomsDelete();
  }

  ///Delete Pompom Podium
  @DELETE(path: '/competition/podiums/pompoms')
  Future<chopper.Response> _competitionPodiumsPompomsDelete({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete the pompoms podium in the current edition.',
      summary: 'Delete Pompom Podium',
      operationId: 'delete_competition_podiums_pompoms',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get School Podiums
  ///@param school_id
  Future<chopper.Response<List<TeamSportResultComplete>>>
  competitionPodiumsSchoolsSchoolIdGet({required String? schoolId}) {
    generatedMapping.putIfAbsent(
      TeamSportResultComplete,
      () => TeamSportResultComplete.fromJsonFactory,
    );

    return _competitionPodiumsSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get School Podiums
  ///@param school_id
  @GET(path: '/competition/podiums/schools/{school_id}')
  Future<chopper.Response<List<TeamSportResultComplete>>>
  _competitionPodiumsSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get the podiums for a specific school in the current edition.',
      summary: 'Get School Podiums',
      operationId: 'get_competition_podiums_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get All Products
  Future<
    chopper.Response<
      List<AppModulesSportCompetitionSchemasSportCompetitionProductComplete>
    >
  >
  competitionProductsGet() {
    generatedMapping.putIfAbsent(
      AppModulesSportCompetitionSchemasSportCompetitionProductComplete,
      () => AppModulesSportCompetitionSchemasSportCompetitionProductComplete
          .fromJsonFactory,
    );

    return _competitionProductsGet();
  }

  ///Get All Products
  @GET(path: '/competition/products')
  Future<
    chopper.Response<
      List<AppModulesSportCompetitionSchemasSportCompetitionProductComplete>
    >
  >
  _competitionProductsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all products.',
      summary: 'Get All Products',
      operationId: 'get_competition_products',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Product
  Future<
    chopper.Response<
      AppModulesSportCompetitionSchemasSportCompetitionProductComplete
    >
  >
  competitionProductsPost({
    required AppModulesSportCompetitionSchemasSportCompetitionProductBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesSportCompetitionSchemasSportCompetitionProductComplete,
      () => AppModulesSportCompetitionSchemasSportCompetitionProductComplete
          .fromJsonFactory,
    );

    return _competitionProductsPost(body: body);
  }

  ///Create Product
  @POST(path: '/competition/products', optionalBody: true)
  Future<
    chopper.Response<
      AppModulesSportCompetitionSchemasSportCompetitionProductComplete
    >
  >
  _competitionProductsPost({
    @Body()
    required AppModulesSportCompetitionSchemasSportCompetitionProductBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create a product.',
      summary: 'Create Product',
      operationId: 'post_competition_products',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Update Product
  ///@param product_id
  Future<chopper.Response> competitionProductsProductIdPatch({
    required String? productId,
    required AppModulesSportCompetitionSchemasSportCompetitionProductEdit? body,
  }) {
    return _competitionProductsProductIdPatch(productId: productId, body: body);
  }

  ///Update Product
  ///@param product_id
  @PATCH(path: '/competition/products/{product_id}', optionalBody: true)
  Future<chopper.Response> _competitionProductsProductIdPatch({
    @Path('product_id') required String? productId,
    @Body()
    required AppModulesSportCompetitionSchemasSportCompetitionProductEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a product.

**User must be a competition admin to use this endpoint**''',
      summary: 'Update Product',
      operationId: 'patch_competition_products_{product_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Product
  ///@param product_id
  Future<chopper.Response> competitionProductsProductIdDelete({
    required String? productId,
  }) {
    return _competitionProductsProductIdDelete(productId: productId);
  }

  ///Delete Product
  ///@param product_id
  @DELETE(path: '/competition/products/{product_id}')
  Future<chopper.Response> _competitionProductsProductIdDelete({
    @Path('product_id') required String? productId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a product.

**User must be a competition admin to use this endpoint**''',
      summary: 'Delete Product',
      operationId: 'delete_competition_products_{product_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Available Product Variants
  Future<
    chopper.Response<
      List<
        AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
      >
    >
  >
  competitionProductsAvailableGet() {
    generatedMapping.putIfAbsent(
      AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete,
      () =>
          AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
              .fromJsonFactory,
    );

    return _competitionProductsAvailableGet();
  }

  ///Get Available Product Variants
  @GET(path: '/competition/products/available')
  Future<
    chopper.Response<
      List<
        AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
      >
    >
  >
  _competitionProductsAvailableGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Get all available product variants of the current edition for this user.',
      summary: 'Get Available Product Variants',
      operationId: 'get_competition_products_available',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Product Variant
  ///@param product_id
  Future<chopper.Response<ProductVariant>>
  competitionProductsProductIdVariantsPost({
    required String? productId,
    required AppModulesSportCompetitionSchemasSportCompetitionProductVariantBase?
    body,
  }) {
    generatedMapping.putIfAbsent(
      ProductVariant,
      () => ProductVariant.fromJsonFactory,
    );

    return _competitionProductsProductIdVariantsPost(
      productId: productId,
      body: body,
    );
  }

  ///Create Product Variant
  ///@param product_id
  @POST(path: '/competition/products/{product_id}/variants', optionalBody: true)
  Future<chopper.Response<ProductVariant>>
  _competitionProductsProductIdVariantsPost({
    @Path('product_id') required String? productId,
    @Body()
    required AppModulesSportCompetitionSchemasSportCompetitionProductVariantBase?
    body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a product variant.

**User must be a competition admin to use this endpoint**''',
      summary: 'Create Product Variant',
      operationId: 'post_competition_products_{product_id}_variants',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Update Product Variant
  ///@param variant_id
  Future<chopper.Response> competitionProductsVariantsVariantIdPatch({
    required String? variantId,
    required AppModulesSportCompetitionSchemasSportCompetitionProductVariantEdit?
    body,
  }) {
    return _competitionProductsVariantsVariantIdPatch(
      variantId: variantId,
      body: body,
    );
  }

  ///Update Product Variant
  ///@param variant_id
  @PATCH(
    path: '/competition/products/variants/{variant_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _competitionProductsVariantsVariantIdPatch({
    @Path('variant_id') required String? variantId,
    @Body()
    required AppModulesSportCompetitionSchemasSportCompetitionProductVariantEdit?
    body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a product variant.

**User must be a competition admin to use this endpoint**''',
      summary: 'Update Product Variant',
      operationId: 'patch_competition_products_variants_{variant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Product Variant
  ///@param variant_id
  Future<chopper.Response> competitionProductsVariantsVariantIdDelete({
    required String? variantId,
  }) {
    return _competitionProductsVariantsVariantIdDelete(variantId: variantId);
  }

  ///Delete Product Variant
  ///@param variant_id
  @DELETE(path: '/competition/products/variants/{variant_id}')
  Future<chopper.Response> _competitionProductsVariantsVariantIdDelete({
    @Path('variant_id') required String? variantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a product variant.

**User must be a competition admin to use this endpoint**''',
      summary: 'Delete Product Variant',
      operationId: 'delete_competition_products_variants_{variant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Purchases By School Id
  ///@param school_id
  Future<chopper.Response<Object>> competitionPurchasesSchoolsSchoolIdGet({
    required String? schoolId,
  }) {
    return _competitionPurchasesSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get Purchases By School Id
  ///@param school_id
  @GET(path: '/competition/purchases/schools/{school_id}')
  Future<chopper.Response<Object>> _competitionPurchasesSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a school\'s purchases.

**User must be competition admin to use this endpoint**''',
      summary: 'Get Purchases By School Id',
      operationId: 'get_competition_purchases_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Purchases By User Id
  ///@param user_id
  Future<chopper.Response<List<Purchase>>> competitionPurchasesUsersUserIdGet({
    required String? userId,
  }) {
    generatedMapping.putIfAbsent(Purchase, () => Purchase.fromJsonFactory);

    return _competitionPurchasesUsersUserIdGet(userId: userId);
  }

  ///Get Purchases By User Id
  ///@param user_id
  @GET(path: '/competition/purchases/users/{user_id}')
  Future<chopper.Response<List<Purchase>>> _competitionPurchasesUsersUserIdGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user\'s purchases.

**User must be competition admin to use this endpoint**''',
      summary: 'Get Purchases By User Id',
      operationId: 'get_competition_purchases_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create User Purchase
  ///@param user_id
  Future<chopper.Response<Purchase>> competitionPurchasesUsersUserIdPost({
    required String? userId,
    required AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase?
    body,
  }) {
    generatedMapping.putIfAbsent(Purchase, () => Purchase.fromJsonFactory);

    return _competitionPurchasesUsersUserIdPost(userId: userId, body: body);
  }

  ///Create User Purchase
  ///@param user_id
  @POST(path: '/competition/purchases/users/{user_id}', optionalBody: true)
  Future<chopper.Response<Purchase>> _competitionPurchasesUsersUserIdPost({
    @Path('user_id') required String? userId,
    @Body()
    required AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase?
    body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a user\'s purchase.

**User must be competition admin to use this endpoint**''',
      summary: 'Create User Purchase',
      operationId: 'post_competition_purchases_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get My Purchases
  Future<chopper.Response<List<Purchase>>> competitionPurchasesMeGet() {
    generatedMapping.putIfAbsent(Purchase, () => Purchase.fromJsonFactory);

    return _competitionPurchasesMeGet();
  }

  ///Get My Purchases
  @GET(path: '/competition/purchases/me')
  Future<chopper.Response<List<Purchase>>> _competitionPurchasesMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get My Purchases',
      operationId: 'get_competition_purchases_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Purchase
  Future<chopper.Response<Purchase>> competitionPurchasesMePost({
    required AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase?
    body,
  }) {
    generatedMapping.putIfAbsent(Purchase, () => Purchase.fromJsonFactory);

    return _competitionPurchasesMePost(body: body);
  }

  ///Create Purchase
  @POST(path: '/competition/purchases/me', optionalBody: true)
  Future<chopper.Response<Purchase>> _competitionPurchasesMePost({
    @Body()
    required AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase?
    body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a purchase.

**User must create a purchase for themself**''',
      summary: 'Create Purchase',
      operationId: 'post_competition_purchases_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Update User Purchase
  ///@param user_id
  ///@param variant_id
  Future<chopper.Response>
  competitionPurchasesUsersUserIdVariantsVariantIdPatch({
    required String? userId,
    required String? variantId,
    required PurchaseEdit? body,
  }) {
    return _competitionPurchasesUsersUserIdVariantsVariantIdPatch(
      userId: userId,
      variantId: variantId,
      body: body,
    );
  }

  ///Update User Purchase
  ///@param user_id
  ///@param variant_id
  @PATCH(
    path: '/competition/purchases/users/{user_id}/variants/{variant_id}',
    optionalBody: true,
  )
  Future<chopper.Response>
  _competitionPurchasesUsersUserIdVariantsVariantIdPatch({
    @Path('user_id') required String? userId,
    @Path('variant_id') required String? variantId,
    @Body() required PurchaseEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a user\'s purchase.

**User must be competition admin to use this endpoint**''',
      summary: 'Update User Purchase',
      operationId:
          'patch_competition_purchases_users_{user_id}_variants_{variant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Purchase
  ///@param product_variant_id
  Future<chopper.Response> competitionPurchasesProductVariantIdDelete({
    required String? productVariantId,
  }) {
    return _competitionPurchasesProductVariantIdDelete(
      productVariantId: productVariantId,
    );
  }

  ///Delete Purchase
  ///@param product_variant_id
  @DELETE(path: '/competition/purchases/{product_variant_id}')
  Future<chopper.Response> _competitionPurchasesProductVariantIdDelete({
    @Path('product_variant_id') required String? productVariantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a purchase.

**User must delete their own purchase**''',
      summary: 'Delete Purchase',
      operationId: 'delete_competition_purchases_{product_variant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete User Purchase
  ///@param user_id
  ///@param product_variant_id
  Future<chopper.Response>
  competitionUsersUserIdPurchasesProductVariantIdDelete({
    required String? userId,
    required String? productVariantId,
  }) {
    return _competitionUsersUserIdPurchasesProductVariantIdDelete(
      userId: userId,
      productVariantId: productVariantId,
    );
  }

  ///Delete User Purchase
  ///@param user_id
  ///@param product_variant_id
  @DELETE(path: '/competition/users/{user_id}/purchases/{product_variant_id}')
  Future<chopper.Response>
  _competitionUsersUserIdPurchasesProductVariantIdDelete({
    @Path('user_id') required String? userId,
    @Path('product_variant_id') required String? productVariantId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a user\'s purchase.

**User must be competition admin to use this endpoint**''',
      summary: 'Delete User Purchase',
      operationId:
          'delete_competition_users_{user_id}_purchases_{product_variant_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Users Payments By School Id
  ///@param school_id
  Future<chopper.Response<Object>> competitionPaymentsSchoolsSchoolIdGet({
    required String? schoolId,
  }) {
    return _competitionPaymentsSchoolsSchoolIdGet(schoolId: schoolId);
  }

  ///Get Users Payments By School Id
  ///@param school_id
  @GET(path: '/competition/payments/schools/{school_id}')
  Future<chopper.Response<Object>> _competitionPaymentsSchoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a school\'s users payments.

**User must be competition admin to use this endpoint**''',
      summary: 'Get Users Payments By School Id',
      operationId: 'get_competition_payments_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Payments By User Id
  ///@param user_id
  Future<
    chopper.Response<
      List<AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete>
    >
  >
  competitionUsersUserIdPaymentsGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete,
      () => AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete
          .fromJsonFactory,
    );

    return _competitionUsersUserIdPaymentsGet(userId: userId);
  }

  ///Get Payments By User Id
  ///@param user_id
  @GET(path: '/competition/users/{user_id}/payments')
  Future<
    chopper.Response<
      List<AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete>
    >
  >
  _competitionUsersUserIdPaymentsGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get a user\'s payments.

**User must get his own payments or be competition admin to use this endpoint**''',
      summary: 'Get Payments By User Id',
      operationId: 'get_competition_users_{user_id}_payments',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Payment
  ///@param user_id
  Future<
    chopper.Response<
      AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete
    >
  >
  competitionUsersUserIdPaymentsPost({
    required String? userId,
    required AppModulesSportCompetitionSchemasSportCompetitionPaymentBase? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete,
      () => AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete
          .fromJsonFactory,
    );

    return _competitionUsersUserIdPaymentsPost(userId: userId, body: body);
  }

  ///Create Payment
  ///@param user_id
  @POST(path: '/competition/users/{user_id}/payments', optionalBody: true)
  Future<
    chopper.Response<
      AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete
    >
  >
  _competitionUsersUserIdPaymentsPost({
    @Path('user_id') required String? userId,
    @Body()
    required AppModulesSportCompetitionSchemasSportCompetitionPaymentBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a payment.

**User must be competition admin to use this endpoint**''',
      summary: 'Create Payment',
      operationId: 'post_competition_users_{user_id}_payments',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Payment
  ///@param user_id
  ///@param payment_id
  Future<chopper.Response> competitionUsersUserIdPaymentsPaymentIdDelete({
    required String? userId,
    required String? paymentId,
  }) {
    return _competitionUsersUserIdPaymentsPaymentIdDelete(
      userId: userId,
      paymentId: paymentId,
    );
  }

  ///Delete Payment
  ///@param user_id
  ///@param payment_id
  @DELETE(path: '/competition/users/{user_id}/payments/{payment_id}')
  Future<chopper.Response> _competitionUsersUserIdPaymentsPaymentIdDelete({
    @Path('user_id') required String? userId,
    @Path('payment_id') required String? paymentId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Remove a payment.

**User must be competition admin to use this endpoint**''',
      summary: 'Delete Payment',
      operationId: 'delete_competition_users_{user_id}_payments_{payment_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get Payment Url
  Future<chopper.Response<PaymentUrl>> competitionPayPost() {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _competitionPayPost();
  }

  ///Get Payment Url
  @POST(path: '/competition/pay', optionalBody: true)
  Future<chopper.Response<PaymentUrl>> _competitionPayPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get payment url',
      summary: 'Get Payment Url',
      operationId: 'post_competition_pay',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get All Volunteer Shifts
  Future<chopper.Response<List<VolunteerShiftComplete>>>
  competitionVolunteersShiftsGet() {
    generatedMapping.putIfAbsent(
      VolunteerShiftComplete,
      () => VolunteerShiftComplete.fromJsonFactory,
    );

    return _competitionVolunteersShiftsGet();
  }

  ///Get All Volunteer Shifts
  @GET(path: '/competition/volunteers/shifts')
  Future<chopper.Response<List<VolunteerShiftComplete>>>
  _competitionVolunteersShiftsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all volunteer shifts.',
      summary: 'Get All Volunteer Shifts',
      operationId: 'get_competition_volunteers_shifts',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Create Volunteer Shift
  Future<chopper.Response<VolunteerShift>> competitionVolunteersShiftsPost({
    required VolunteerShiftBase? body,
  }) {
    generatedMapping.putIfAbsent(
      VolunteerShift,
      () => VolunteerShift.fromJsonFactory,
    );

    return _competitionVolunteersShiftsPost(body: body);
  }

  ///Create Volunteer Shift
  @POST(path: '/competition/volunteers/shifts', optionalBody: true)
  Future<chopper.Response<VolunteerShift>> _competitionVolunteersShiftsPost({
    @Body() required VolunteerShiftBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create a volunteer shift.',
      summary: 'Create Volunteer Shift',
      operationId: 'post_competition_volunteers_shifts',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Update Volunteer Shift
  ///@param shift_id
  Future<chopper.Response> competitionVolunteersShiftsShiftIdPatch({
    required String? shiftId,
    required VolunteerShiftEdit? body,
  }) {
    return _competitionVolunteersShiftsShiftIdPatch(
      shiftId: shiftId,
      body: body,
    );
  }

  ///Update Volunteer Shift
  ///@param shift_id
  @PATCH(path: '/competition/volunteers/shifts/{shift_id}', optionalBody: true)
  Future<chopper.Response> _competitionVolunteersShiftsShiftIdPatch({
    @Path('shift_id') required String? shiftId,
    @Body() required VolunteerShiftEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a volunteer shift.

**User must be a competition admin to use this endpoint**''',
      summary: 'Update Volunteer Shift',
      operationId: 'patch_competition_volunteers_shifts_{shift_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Delete Volunteer Shift
  ///@param shift_id
  Future<chopper.Response> competitionVolunteersShiftsShiftIdDelete({
    required String? shiftId,
  }) {
    return _competitionVolunteersShiftsShiftIdDelete(shiftId: shiftId);
  }

  ///Delete Volunteer Shift
  ///@param shift_id
  @DELETE(path: '/competition/volunteers/shifts/{shift_id}')
  Future<chopper.Response> _competitionVolunteersShiftsShiftIdDelete({
    @Path('shift_id') required String? shiftId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a volunteer shift.

**User must be a competition admin to use this endpoint**''',
      summary: 'Delete Volunteer Shift',
      operationId: 'delete_competition_volunteers_shifts_{shift_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Get My Volunteer Registrations
  Future<chopper.Response<List<VolunteerRegistrationComplete>>>
  competitionVolunteersMeGet() {
    generatedMapping.putIfAbsent(
      VolunteerRegistrationComplete,
      () => VolunteerRegistrationComplete.fromJsonFactory,
    );

    return _competitionVolunteersMeGet();
  }

  ///Get My Volunteer Registrations
  @GET(path: '/competition/volunteers/me')
  Future<chopper.Response<List<VolunteerRegistrationComplete>>>
  _competitionVolunteersMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get my volunteer registrations.',
      summary: 'Get My Volunteer Registrations',
      operationId: 'get_competition_volunteers_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Register To Volunteer Shift
  ///@param shift_id
  Future<chopper.Response> competitionVolunteersShiftsShiftIdRegisterPost({
    required String? shiftId,
  }) {
    return _competitionVolunteersShiftsShiftIdRegisterPost(shiftId: shiftId);
  }

  ///Register To Volunteer Shift
  ///@param shift_id
  @POST(
    path: '/competition/volunteers/shifts/{shift_id}/register',
    optionalBody: true,
  )
  Future<chopper.Response> _competitionVolunteersShiftsShiftIdRegisterPost({
    @Path('shift_id') required String? shiftId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Register to a volunteer shift.',
      summary: 'Register To Volunteer Shift',
      operationId: 'post_competition_volunteers_shifts_{shift_id}_register',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Export Competition Users Data
  ///@param included_fields
  ///@param exclude_non_validated
  Future<chopper.Response> competitionDataExportUsersGet({
    List<enums.ExcelExportParams>? includedFields,
    bool? excludeNonValidated,
  }) {
    return _competitionDataExportUsersGet(
      includedFields: excelExportParamsListToJson(includedFields),
      excludeNonValidated: excludeNonValidated,
    );
  }

  ///Export Competition Users Data
  ///@param included_fields
  ///@param exclude_non_validated
  @GET(path: '/competition/data-export/users')
  Future<chopper.Response> _competitionDataExportUsersGet({
    @Query('included_fields') List<Object?>? includedFields,
    @Query('exclude_non_validated') bool? excludeNonValidated,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Export competition users data for the current edition as a CSV file.',
      summary: 'Export Competition Users Data',
      operationId: 'get_competition_data-export_users',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Export School Competition Users Data
  ///@param school_id
  ///@param included_fields
  ///@param exclude_non_validated
  Future<chopper.Response> competitionDataExportSchoolsSchoolIdUsersGet({
    required String? schoolId,
    List<enums.ExcelExportParams>? includedFields,
    bool? excludeNonValidated,
  }) {
    return _competitionDataExportSchoolsSchoolIdUsersGet(
      schoolId: schoolId,
      includedFields: excelExportParamsListToJson(includedFields),
      excludeNonValidated: excludeNonValidated,
    );
  }

  ///Export School Competition Users Data
  ///@param school_id
  ///@param included_fields
  ///@param exclude_non_validated
  @GET(path: '/competition/data-export/schools/{school_id}/users')
  Future<chopper.Response> _competitionDataExportSchoolsSchoolIdUsersGet({
    @Path('school_id') required String? schoolId,
    @Query('included_fields') List<Object?>? includedFields,
    @Query('exclude_non_validated') bool? excludeNonValidated,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Export competition users data for the current edition as a CSV file.',
      summary: 'Export School Competition Users Data',
      operationId: 'get_competition_data-export_schools_{school_id}_users',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Export Participants Captains Data
  Future<chopper.Response> competitionDataExportParticipantsCaptainsGet() {
    return _competitionDataExportParticipantsCaptainsGet();
  }

  ///Export Participants Captains Data
  @GET(path: '/competition/data-export/participants/captains')
  Future<chopper.Response> _competitionDataExportParticipantsCaptainsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Export participants captains data for the current edition as an Excel file.',
      summary: 'Export Participants Captains Data',
      operationId: 'get_competition_data-export_participants_captains',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Export School Quotas Data
  ///@param school_id
  Future<chopper.Response> competitionDataExportSchoolsSchoolIdQuotasGet({
    required String? schoolId,
  }) {
    return _competitionDataExportSchoolsSchoolIdQuotasGet(schoolId: schoolId);
  }

  ///Export School Quotas Data
  ///@param school_id
  @GET(path: '/competition/data-export/schools/{school_id}/quotas')
  Future<chopper.Response> _competitionDataExportSchoolsSchoolIdQuotasGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Export school quotas data for the current edition as an Excel file.',
      summary: 'Export School Quotas Data',
      operationId: 'get_competition_data-export_schools_{school_id}_quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Export Sport Quotas Data
  ///@param sport_id
  Future<chopper.Response> competitionDataExportSportsSportIdQuotasGet({
    required String? sportId,
  }) {
    return _competitionDataExportSportsSportIdQuotasGet(sportId: sportId);
  }

  ///Export Sport Quotas Data
  ///@param sport_id
  @GET(path: '/competition/data-export/sports/{sport_id}/quotas')
  Future<chopper.Response> _competitionDataExportSportsSportIdQuotasGet({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Export sport quotas data for the current edition as an Excel file.',
      summary: 'Export Sport Quotas Data',
      operationId: 'get_competition_data-export_sports_{sport_id}_quotas',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
  });

  ///Export Sport Participants Data
  ///@param sport_id
  Future<chopper.Response> competitionDataExportSportsSportIdParticipantsGet({
    required String? sportId,
  }) {
    return _competitionDataExportSportsSportIdParticipantsGet(sportId: sportId);
  }

  ///Export Sport Participants Data
  ///@param sport_id
  @GET(path: '/competition/data-export/sports/{sport_id}/participants')
  Future<chopper.Response> _competitionDataExportSportsSportIdParticipantsGet({
    @Path('sport_id') required String? sportId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Export sport quotas data for the current edition as an Excel file.',
      summary: 'Export Sport Participants Data',
      operationId: 'get_competition_data-export_sports_{sport_id}_participants',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Sport Competition"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/raffles')
  Future<chopper.Response<List<RaffleComplete>>> _tombolaRafflesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all raffles',
      summary: 'Get Raffle',
      operationId: 'get_tombola_raffles',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/tombola/raffles', optionalBody: true)
  Future<chopper.Response<RaffleComplete>> _tombolaRafflesPost({
    @Body() required RaffleBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new raffle

**The user must be a member of the group admin to use this endpoint**''',
      summary: 'Create Raffle',
      operationId: 'post_tombola_raffles',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @PATCH(path: '/tombola/raffles/{raffle_id}', optionalBody: true)
  Future<chopper.Response> _tombolaRafflesRaffleIdPatch({
    @Path('raffle_id') required String? raffleId,
    @Body() required RaffleEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a raffle

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Edit Raffle',
      operationId: 'patch_tombola_raffles_{raffle_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @DELETE(path: '/tombola/raffles/{raffle_id}')
  Future<chopper.Response> _tombolaRafflesRaffleIdDelete({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a raffle.

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Delete Raffle',
      operationId: 'delete_tombola_raffles_{raffle_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/group/{group_id}/raffles')
  Future<chopper.Response<List<RaffleComplete>>>
  _tombolaGroupGroupIdRafflesGet({
    @Path('group_id') required String? groupId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all raffles from a group',
      summary: 'Get Raffles By Group Id',
      operationId: 'get_tombola_group_{group_id}_raffles',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/tombola/raffles/{raffle_id}/stats')
  Future<chopper.Response<RaffleStats>> _tombolaRafflesRaffleIdStatsGet({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return the number of ticket sold and the total amount recollected for a raffle',
      summary: 'Get Raffle Stats',
      operationId: 'get_tombola_raffles_{raffle_id}_stats',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Create Current Raffle Logo
  ///@param raffle_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  tombolaRafflesRaffleIdLogoPost({
    required String? raffleId,
    required List<int> image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _tombolaRafflesRaffleIdLogoPost(raffleId: raffleId, image: image);
  }

  ///Create Current Raffle Logo
  ///@param raffle_id
  @POST(path: '/tombola/raffles/{raffle_id}/logo', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _tombolaRafflesRaffleIdLogoPost({
    @Path('raffle_id') required String? raffleId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Upload a logo for a specific raffle.

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Create Current Raffle Logo',
      operationId: 'post_tombola_raffles_{raffle_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/raffles/{raffle_id}/logo')
  Future<chopper.Response> _tombolaRafflesRaffleIdLogoGet({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get the logo of a specific raffle.',
      summary: 'Read Raffle Logo',
      operationId: 'get_tombola_raffles_{raffle_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/pack_tickets')
  Future<chopper.Response<List<PackTicketSimple>>> _tombolaPackTicketsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all tickets',
      summary: 'Get Pack Tickets',
      operationId: 'get_tombola_pack_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/tombola/pack_tickets', optionalBody: true)
  Future<chopper.Response<PackTicketSimple>> _tombolaPackTicketsPost({
    @Body() required PackTicketBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new packticket

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Create Packticket',
      operationId: 'post_tombola_pack_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @PATCH(path: '/tombola/pack_tickets/{packticket_id}', optionalBody: true)
  Future<chopper.Response> _tombolaPackTicketsPackticketIdPatch({
    @Path('packticket_id') required String? packticketId,
    @Body() required PackTicketEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a packticket

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Edit Packticket',
      operationId: 'patch_tombola_pack_tickets_{packticket_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @DELETE(path: '/tombola/pack_tickets/{packticket_id}')
  Future<chopper.Response> _tombolaPackTicketsPackticketIdDelete({
    @Path('packticket_id') required String? packticketId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a packticket.

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Delete Packticket',
      operationId: 'delete_tombola_pack_tickets_{packticket_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/raffles/{raffle_id}/pack_tickets')
  Future<chopper.Response<List<PackTicketSimple>>>
  _tombolaRafflesRaffleIdPackTicketsGet({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all pack_tickets associated to a raffle',
      summary: 'Get Pack Tickets By Raffle Id',
      operationId: 'get_tombola_raffles_{raffle_id}_pack_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/tickets')
  Future<chopper.Response<List<TicketSimple>>> _tombolaTicketsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all tickets

**The user must be a member of the group admin to use this endpoint**''',
      summary: 'Get Tickets',
      operationId: 'get_tombola_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Buy Ticket
  ///@param pack_id
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  tombolaTicketsBuyPackIdPost({required String? packId}) {
    generatedMapping.putIfAbsent(
      AppModulesRaffleSchemasRaffleTicketComplete,
      () => AppModulesRaffleSchemasRaffleTicketComplete.fromJsonFactory,
    );

    return _tombolaTicketsBuyPackIdPost(packId: packId);
  }

  ///Buy Ticket
  ///@param pack_id
  @POST(path: '/tombola/tickets/buy/{pack_id}', optionalBody: true)
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaTicketsBuyPackIdPost({
    @Path('pack_id') required String? packId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Buy a ticket',
      summary: 'Buy Ticket',
      operationId: 'post_tombola_tickets_buy_{pack_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Get Tickets By Userid
  ///@param user_id
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  tombolaUsersUserIdTicketsGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      AppModulesRaffleSchemasRaffleTicketComplete,
      () => AppModulesRaffleSchemasRaffleTicketComplete.fromJsonFactory,
    );

    return _tombolaUsersUserIdTicketsGet(userId: userId);
  }

  ///Get Tickets By Userid
  ///@param user_id
  @GET(path: '/tombola/users/{user_id}/tickets')
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaUsersUserIdTicketsGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get tickets of a specific user.

**Only admin users can get tickets of another user**''',
      summary: 'Get Tickets By Userid',
      operationId: 'get_tombola_users_{user_id}_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Get Tickets By Raffleid
  ///@param raffle_id
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  tombolaRafflesRaffleIdTicketsGet({required String? raffleId}) {
    generatedMapping.putIfAbsent(
      AppModulesRaffleSchemasRaffleTicketComplete,
      () => AppModulesRaffleSchemasRaffleTicketComplete.fromJsonFactory,
    );

    return _tombolaRafflesRaffleIdTicketsGet(raffleId: raffleId);
  }

  ///Get Tickets By Raffleid
  ///@param raffle_id
  @GET(path: '/tombola/raffles/{raffle_id}/tickets')
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaRafflesRaffleIdTicketsGet({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get tickets from a specific raffle.

**The user must be a member of the raffle\'s group to use this endpoint''',
      summary: 'Get Tickets By Raffleid',
      operationId: 'get_tombola_raffles_{raffle_id}_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/prizes')
  Future<chopper.Response<List<PrizeSimple>>> _tombolaPrizesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all prizes',
      summary: 'Get Prizes',
      operationId: 'get_tombola_prizes',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/tombola/prizes', optionalBody: true)
  Future<chopper.Response<PrizeSimple>> _tombolaPrizesPost({
    @Body() required PrizeBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new prize

**The user must be a member of the raffle\'s group to use this endpoint''',
      summary: 'Create Prize',
      operationId: 'post_tombola_prizes',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @PATCH(path: '/tombola/prizes/{prize_id}', optionalBody: true)
  Future<chopper.Response> _tombolaPrizesPrizeIdPatch({
    @Path('prize_id') required String? prizeId,
    @Body() required PrizeEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Edit a prize

**The user must be a member of the group raffle\'s to use this endpoint''',
      summary: 'Edit Prize',
      operationId: 'patch_tombola_prizes_{prize_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @DELETE(path: '/tombola/prizes/{prize_id}')
  Future<chopper.Response> _tombolaPrizesPrizeIdDelete({
    @Path('prize_id') required String? prizeId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a prize.

**The user must be a member of the group raffle\'s to use this endpoint''',
      summary: 'Delete Prize',
      operationId: 'delete_tombola_prizes_{prize_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/raffles/{raffle_id}/prizes')
  Future<chopper.Response<List<PrizeSimple>>> _tombolaRafflesRaffleIdPrizesGet({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get prizes from a specific raffle.',
      summary: 'Get Prizes By Raffleid',
      operationId: 'get_tombola_raffles_{raffle_id}_prizes',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Create Prize Picture
  ///@param prize_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  tombolaPrizesPrizeIdPicturePost({
    required String? prizeId,
    required List<int> image,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _tombolaPrizesPrizeIdPicturePost(prizeId: prizeId, image: image);
  }

  ///Create Prize Picture
  ///@param prize_id
  @POST(path: '/tombola/prizes/{prize_id}/picture', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _tombolaPrizesPrizeIdPicturePost({
    @Path('prize_id') required String? prizeId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Upload a logo for a specific prize.

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Create Prize Picture',
      operationId: 'post_tombola_prizes_{prize_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/tombola/prizes/{prize_id}/picture')
  Future<chopper.Response> _tombolaPrizesPrizeIdPictureGet({
    @Path('prize_id') required String? prizeId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get the logo of a specific prize.',
      summary: 'Read Prize Logo',
      operationId: 'get_tombola_prizes_{prize_id}_picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Get Users Cash
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleCashComplete>>>
  tombolaUsersCashGet() {
    generatedMapping.putIfAbsent(
      AppModulesRaffleSchemasRaffleCashComplete,
      () => AppModulesRaffleSchemasRaffleCashComplete.fromJsonFactory,
    );

    return _tombolaUsersCashGet();
  }

  ///Get Users Cash
  @GET(path: '/tombola/users/cash')
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleCashComplete>>>
  _tombolaUsersCashGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get cash from all users.

**The user must be a member of the group admin to use this endpoint''',
      summary: 'Get Users Cash',
      operationId: 'get_tombola_users_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Get Cash By Id
  ///@param user_id
  Future<chopper.Response<AppModulesRaffleSchemasRaffleCashComplete>>
  tombolaUsersUserIdCashGet({required String? userId}) {
    generatedMapping.putIfAbsent(
      AppModulesRaffleSchemasRaffleCashComplete,
      () => AppModulesRaffleSchemasRaffleCashComplete.fromJsonFactory,
    );

    return _tombolaUsersUserIdCashGet(userId: userId);
  }

  ///Get Cash By Id
  ///@param user_id
  @GET(path: '/tombola/users/{user_id}/cash')
  Future<chopper.Response<AppModulesRaffleSchemasRaffleCashComplete>>
  _tombolaUsersUserIdCashGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get cash from a specific user.

**The user must be a member of the group admin to use this endpoint or can only access the endpoint for its own user_id**''',
      summary: 'Get Cash By Id',
      operationId: 'get_tombola_users_{user_id}_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Create Cash Of User
  ///@param user_id
  Future<chopper.Response<AppModulesRaffleSchemasRaffleCashComplete>>
  tombolaUsersUserIdCashPost({
    required String? userId,
    required CashEdit? body,
  }) {
    generatedMapping.putIfAbsent(
      AppModulesRaffleSchemasRaffleCashComplete,
      () => AppModulesRaffleSchemasRaffleCashComplete.fromJsonFactory,
    );

    return _tombolaUsersUserIdCashPost(userId: userId, body: body);
  }

  ///Create Cash Of User
  ///@param user_id
  @POST(path: '/tombola/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response<AppModulesRaffleSchemasRaffleCashComplete>>
  _tombolaUsersUserIdCashPost({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create cash for a user.

**The user must be a member of the group admin to use this endpoint**''',
      summary: 'Create Cash Of User',
      operationId: 'post_tombola_users_{user_id}_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @PATCH(path: '/tombola/users/{user_id}/cash', optionalBody: true)
  Future<chopper.Response> _tombolaUsersUserIdCashPatch({
    @Path('user_id') required String? userId,
    @Body() required CashEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Edit cash for an user. This will add the balance to the current balance.
A negative value can be provided to remove money from the user.

**The user must be a member of the group admin to use this endpoint**''',
      summary: 'Edit Cash By Id',
      operationId: 'patch_tombola_users_{user_id}_cash',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
  });

  ///Draw Winner
  ///@param prize_id
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  tombolaPrizesPrizeIdDrawPost({required String? prizeId}) {
    generatedMapping.putIfAbsent(
      AppModulesRaffleSchemasRaffleTicketComplete,
      () => AppModulesRaffleSchemasRaffleTicketComplete.fromJsonFactory,
    );

    return _tombolaPrizesPrizeIdDrawPost(prizeId: prizeId);
  }

  ///Draw Winner
  ///@param prize_id
  @POST(path: '/tombola/prizes/{prize_id}/draw', optionalBody: true)
  Future<chopper.Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaPrizesPrizeIdDrawPost({
    @Path('prize_id') required String? prizeId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Draw Winner',
      operationId: 'post_tombola_prizes_{prize_id}_draw',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @PATCH(path: '/tombola/raffles/{raffle_id}/open', optionalBody: true)
  Future<chopper.Response> _tombolaRafflesRaffleIdOpenPatch({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Open a raffle

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Open Raffle',
      operationId: 'patch_tombola_raffles_{raffle_id}_open',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @PATCH(path: '/tombola/raffles/{raffle_id}/lock', optionalBody: true)
  Future<chopper.Response> _tombolaRafflesRaffleIdLockPatch({
    @Path('raffle_id') required String? raffleId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Lock a raffle

**The user must be a member of the raffle\'s group to use this endpoint**''',
      summary: 'Lock Raffle',
      operationId: 'patch_tombola_raffles_{raffle_id}_lock',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Raffle"],
      deprecated: false,
    ),
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
  @GET(path: '/flappybird/scores')
  Future<chopper.Response<List<FlappyBirdScoreInDB>>> _flappybirdScoresGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return the leaderboard',
      summary: 'Get Flappybird Score',
      operationId: 'get_flappybird_scores',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Flappy Bird"],
      deprecated: false,
    ),
  });

  ///Create Flappybird Score
  Future<chopper.Response<FlappyBirdScoreInDB>> flappybirdScoresPost({
    required FlappyBirdScoreBase? body,
  }) {
    generatedMapping.putIfAbsent(
      FlappyBirdScoreInDB,
      () => FlappyBirdScoreInDB.fromJsonFactory,
    );

    return _flappybirdScoresPost(body: body);
  }

  ///Create Flappybird Score
  @POST(path: '/flappybird/scores', optionalBody: true)
  Future<chopper.Response<FlappyBirdScoreInDB>> _flappybirdScoresPost({
    @Body() required FlappyBirdScoreBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create Flappybird Score',
      operationId: 'post_flappybird_scores',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Flappy Bird"],
      deprecated: false,
    ),
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
  @GET(path: '/flappybird/scores/me')
  Future<chopper.Response<FlappyBirdScoreCompleteFeedBack>>
  _flappybirdScoresMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Current User Flappybird Personal Best',
      operationId: 'get_flappybird_scores_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Flappy Bird"],
      deprecated: false,
    ),
  });

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
  @DELETE(path: '/flappybird/scores/{targeted_user_id}')
  Future<chopper.Response> _flappybirdScoresTargetedUserIdDelete({
    @Path('targeted_user_id') required String? targetedUserId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Remove Flappybird Score',
      operationId: 'delete_flappybird_scores_{targeted_user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Flappy Bird"],
      deprecated: false,
    ),
  });

  ///Get Open Events
  Future<chopper.Response<List<EventSimple>>> ticketsEventsGet() {
    generatedMapping.putIfAbsent(
      EventSimple,
      () => EventSimple.fromJsonFactory,
    );

    return _ticketsEventsGet();
  }

  ///Get Open Events
  @GET(path: '/tickets/events')
  Future<chopper.Response<List<EventSimple>>> _ticketsEventsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all open events.

To be considered open, an event should have its opening date in the past and its closing date in the future or not defined. Moreover, we only return enabled events.''',
      summary: 'Get Open Events',
      operationId: 'get_tickets_events',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Get Event
  ///@param event_id
  Future<chopper.Response<EventPublic>> ticketsEventsEventIdGet({
    required String? eventId,
  }) {
    generatedMapping.putIfAbsent(
      EventPublic,
      () => EventPublic.fromJsonFactory,
    );

    return _ticketsEventsEventIdGet(eventId: eventId);
  }

  ///Get Event
  ///@param event_id
  @GET(path: '/tickets/events/{event_id}')
  Future<chopper.Response<EventPublic>> _ticketsEventsEventIdGet({
    @Path('event_id') required String? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get an event public details

Only enabled sessions and categories are returned''',
      summary: 'Get Event',
      operationId: 'get_tickets_events_{event_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Create Checkout
  ///@param event_id
  Future<chopper.Response<CheckoutResponse>> ticketsEventsEventIdCheckoutPost({
    required String? eventId,
    required Checkout? body,
  }) {
    generatedMapping.putIfAbsent(
      CheckoutResponse,
      () => CheckoutResponse.fromJsonFactory,
    );

    return _ticketsEventsEventIdCheckoutPost(eventId: eventId, body: body);
  }

  ///Create Checkout
  ///@param event_id
  @POST(path: '/tickets/events/{event_id}/checkout', optionalBody: true)
  Future<chopper.Response<CheckoutResponse>> _ticketsEventsEventIdCheckoutPost({
    @Path('event_id') required String? eventId,
    @Body() required Checkout? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create a checkout for an open event',
      summary: 'Create Checkout',
      operationId: 'post_tickets_events_{event_id}_checkout',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Get User Tickets
  Future<chopper.Response<List<AppCoreTicketsSchemasTicketsTicketComplete>>>
  ticketsUserMeTicketsGet() {
    generatedMapping.putIfAbsent(
      AppCoreTicketsSchemasTicketsTicketComplete,
      () => AppCoreTicketsSchemasTicketsTicketComplete.fromJsonFactory,
    );

    return _ticketsUserMeTicketsGet();
  }

  ///Get User Tickets
  @GET(path: '/tickets/user/me/tickets')
  Future<chopper.Response<List<AppCoreTicketsSchemasTicketsTicketComplete>>>
  _ticketsUserMeTicketsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all tickets of the current user',
      summary: 'Get User Tickets',
      operationId: 'get_tickets_user_me_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Ticket Request Change Over
  Future<chopper.Response> ticketsUserMeTicketsChangeOverRequestPost({
    required TicketChangeOverInvitation? body,
  }) {
    return _ticketsUserMeTicketsChangeOverRequestPost(body: body);
  }

  ///Ticket Request Change Over
  @POST(
    path: '/tickets/user/me/tickets/change-over/request',
    optionalBody: true,
  )
  Future<chopper.Response> _ticketsUserMeTicketsChangeOverRequestPost({
    @Body() required TicketChangeOverInvitation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Give its ticket to another user. The other user will receive an email with a link to accept the transfer.

Using this endpoint will invalidate existing transfer invitations.''',
      summary: 'Ticket Request Change Over',
      operationId: 'post_tickets_user_me_tickets_change-over_request',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Ticket Accept Change Over
  ///@param token
  Future<chopper.Response> ticketsUserMeTicketsChangeOverAcceptGet({
    required String? token,
  }) {
    return _ticketsUserMeTicketsChangeOverAcceptGet(token: token);
  }

  ///Ticket Accept Change Over
  ///@param token
  @GET(path: '/tickets/user/me/tickets/change-over/accept')
  Future<chopper.Response> _ticketsUserMeTicketsChangeOverAcceptGet({
    @Query('token') required String? token,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Accept a ticket transfer invitation. The user will become the new owner of the ticket.',
      summary: 'Ticket Accept Change Over',
      operationId: 'get_tickets_user_me_tickets_change-over_accept',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Get Event Admin
  ///@param event_id
  Future<chopper.Response<EventAdmin>> ticketsAdminEventsEventIdGet({
    required String? eventId,
  }) {
    generatedMapping.putIfAbsent(EventAdmin, () => EventAdmin.fromJsonFactory);

    return _ticketsAdminEventsEventIdGet(eventId: eventId);
  }

  ///Get Event Admin
  ///@param event_id
  @GET(path: '/tickets/admin/events/{event_id}')
  Future<chopper.Response<EventAdmin>> _ticketsAdminEventsEventIdGet({
    @Path('event_id') required String? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get one event admin details

**The user should have the right to manage the event seller**''',
      summary: 'Get Event Admin',
      operationId: 'get_tickets_admin_events_{event_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Update Event
  ///@param event_id
  Future<chopper.Response> ticketsAdminEventsEventIdPatch({
    required String? eventId,
    required EventUpdate? body,
  }) {
    return _ticketsAdminEventsEventIdPatch(eventId: eventId, body: body);
  }

  ///Update Event
  ///@param event_id
  @PATCH(path: '/tickets/admin/events/{event_id}', optionalBody: true)
  Future<chopper.Response> _ticketsAdminEventsEventIdPatch({
    @Path('event_id') required String? eventId,
    @Body() required EventUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Edit one event for admin',
      summary: 'Update Event',
      operationId: 'patch_tickets_admin_events_{event_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Create Event
  Future<chopper.Response<EventAdmin>> ticketsAdminEventsPost({
    required EventCreate? body,
  }) {
    generatedMapping.putIfAbsent(EventAdmin, () => EventAdmin.fromJsonFactory);

    return _ticketsAdminEventsPost(body: body);
  }

  ///Create Event
  @POST(path: '/tickets/admin/events', optionalBody: true)
  Future<chopper.Response<EventAdmin>> _ticketsAdminEventsPost({
    @Body() required EventCreate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create an event

**The user should have the right to manage the event seller**''',
      summary: 'Create Event',
      operationId: 'post_tickets_admin_events',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Create Session
  ///@param event_id
  Future<chopper.Response<SessionComplete>>
  ticketsAdminEventsEventIdSessionsPost({
    required String? eventId,
    required SessionCreate? body,
  }) {
    generatedMapping.putIfAbsent(
      SessionComplete,
      () => SessionComplete.fromJsonFactory,
    );

    return _ticketsAdminEventsEventIdSessionsPost(eventId: eventId, body: body);
  }

  ///Create Session
  ///@param event_id
  @POST(path: '/tickets/admin/events/{event_id}/sessions', optionalBody: true)
  Future<chopper.Response<SessionComplete>>
  _ticketsAdminEventsEventIdSessionsPost({
    @Path('event_id') required String? eventId,
    @Body() required SessionCreate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a session for an event

**The user should have the right to manage the event seller**''',
      summary: 'Create Session',
      operationId: 'post_tickets_admin_events_{event_id}_sessions',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Update Session
  ///@param event_id
  ///@param session_id
  Future<chopper.Response> ticketsAdminEventsEventIdSessionsSessionIdPatch({
    required String? eventId,
    required String? sessionId,
    required SessionUpdate? body,
  }) {
    return _ticketsAdminEventsEventIdSessionsSessionIdPatch(
      eventId: eventId,
      sessionId: sessionId,
      body: body,
    );
  }

  ///Update Session
  ///@param event_id
  ///@param session_id
  @PATCH(
    path: '/tickets/admin/events/{event_id}/sessions/{session_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _ticketsAdminEventsEventIdSessionsSessionIdPatch({
    @Path('event_id') required String? eventId,
    @Path('session_id') required String? sessionId,
    @Body() required SessionUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Edit one event for admin',
      summary: 'Update Session',
      operationId:
          'patch_tickets_admin_events_{event_id}_sessions_{session_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Create Category
  ///@param event_id
  Future<chopper.Response<CategoryComplete>>
  ticketsAdminEventsEventIdCategoriesPost({
    required String? eventId,
    required CategoryCreate? body,
  }) {
    generatedMapping.putIfAbsent(
      CategoryComplete,
      () => CategoryComplete.fromJsonFactory,
    );

    return _ticketsAdminEventsEventIdCategoriesPost(
      eventId: eventId,
      body: body,
    );
  }

  ///Create Category
  ///@param event_id
  @POST(path: '/tickets/admin/events/{event_id}/categories', optionalBody: true)
  Future<chopper.Response<CategoryComplete>>
  _ticketsAdminEventsEventIdCategoriesPost({
    @Path('event_id') required String? eventId,
    @Body() required CategoryCreate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a category for an event

**The user should have the right to manage the event seller**''',
      summary: 'Create Category',
      operationId: 'post_tickets_admin_events_{event_id}_categories',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Update Category
  ///@param event_id
  ///@param category_id
  Future<chopper.Response> ticketsAdminEventsEventIdCategoriesCategoryIdPatch({
    required String? eventId,
    required String? categoryId,
    required CategoryUpdate? body,
  }) {
    return _ticketsAdminEventsEventIdCategoriesCategoryIdPatch(
      eventId: eventId,
      categoryId: categoryId,
      body: body,
    );
  }

  ///Update Category
  ///@param event_id
  ///@param category_id
  @PATCH(
    path: '/tickets/admin/events/{event_id}/categories/{category_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _ticketsAdminEventsEventIdCategoriesCategoryIdPatch({
    @Path('event_id') required String? eventId,
    @Path('category_id') required String? categoryId,
    @Body() required CategoryUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Edit one event for admin',
      summary: 'Update Category',
      operationId:
          'patch_tickets_admin_events_{event_id}_categories_{category_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Update Question
  ///@param event_id
  ///@param question_id
  Future<chopper.Response> ticketsAdminEventsEventIdQuestionsQuestionIdPatch({
    required String? eventId,
    required String? questionId,
    required QuestionUpdate? body,
  }) {
    return _ticketsAdminEventsEventIdQuestionsQuestionIdPatch(
      eventId: eventId,
      questionId: questionId,
      body: body,
    );
  }

  ///Update Question
  ///@param event_id
  ///@param question_id
  @PATCH(
    path: '/tickets/admin/events/{event_id}/questions/{question_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _ticketsAdminEventsEventIdQuestionsQuestionIdPatch({
    @Path('event_id') required String? eventId,
    @Path('question_id') required String? questionId,
    @Body() required QuestionUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Edit one event for admin',
      summary: 'Update Question',
      operationId:
          'patch_tickets_admin_events_{event_id}_questions_{question_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Get Event Tickets
  ///@param event_id
  Future<chopper.Response<List<AppCoreTicketsSchemasTicketsTicket>>>
  ticketsAdminEventsEventIdTicketsGet({required String? eventId}) {
    generatedMapping.putIfAbsent(
      AppCoreTicketsSchemasTicketsTicket,
      () => AppCoreTicketsSchemasTicketsTicket.fromJsonFactory,
    );

    return _ticketsAdminEventsEventIdTicketsGet(eventId: eventId);
  }

  ///Get Event Tickets
  ///@param event_id
  @GET(path: '/tickets/admin/events/{event_id}/tickets')
  Future<chopper.Response<List<AppCoreTicketsSchemasTicketsTicket>>>
  _ticketsAdminEventsEventIdTicketsGet({
    @Path('event_id') required String? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all tickets of an event

**The user should have the right to manage the event seller**''',
      summary: 'Get Event Tickets',
      operationId: 'get_tickets_admin_events_{event_id}_tickets',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Get Event Tickets Csv
  ///@param event_id
  Future<chopper.Response> ticketsAdminEventsEventIdTicketsCsvGet({
    required String? eventId,
  }) {
    return _ticketsAdminEventsEventIdTicketsCsvGet(eventId: eventId);
  }

  ///Get Event Tickets Csv
  ///@param event_id
  @GET(path: '/tickets/admin/events/{event_id}/tickets/csv')
  Future<chopper.Response> _ticketsAdminEventsEventIdTicketsCsvGet({
    @Path('event_id') required String? eventId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all tickets of an event as csv

**The user should have the right to manage the event seller**''',
      summary: 'Get Event Tickets Csv',
      operationId: 'get_tickets_admin_events_{event_id}_tickets_csv',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Check Ticket
  ///@param ticket_id
  Future<chopper.Response<AppCoreTicketsSchemasTicketsTicket>>
  ticketsAdminTicketsTicketIdCheckPost({required String? ticketId}) {
    generatedMapping.putIfAbsent(
      AppCoreTicketsSchemasTicketsTicket,
      () => AppCoreTicketsSchemasTicketsTicket.fromJsonFactory,
    );

    return _ticketsAdminTicketsTicketIdCheckPost(ticketId: ticketId);
  }

  ///Check Ticket
  ///@param ticket_id
  @POST(path: '/tickets/admin/tickets/{ticket_id}/check', optionalBody: true)
  Future<chopper.Response<AppCoreTicketsSchemasTicketsTicket>>
  _ticketsAdminTicketsTicketIdCheckPost({
    @Path('ticket_id') required String? ticketId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Check a ticket

**The user should have the right to manage the event seller**''',
      summary: 'Check Ticket',
      operationId: 'post_tickets_admin_tickets_{ticket_id}_check',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Scan Ticket
  ///@param ticket_id
  Future<chopper.Response> ticketsAdminTicketsTicketIdScanPost({
    required String? ticketId,
  }) {
    return _ticketsAdminTicketsTicketIdScanPost(ticketId: ticketId);
  }

  ///Scan Ticket
  ///@param ticket_id
  @POST(path: '/tickets/admin/tickets/{ticket_id}/scan', optionalBody: true)
  Future<chopper.Response> _ticketsAdminTicketsTicketIdScanPost({
    @Path('ticket_id') required String? ticketId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Mark a ticket as scanned

**The user should have the right to manage the event seller**''',
      summary: 'Scan Ticket',
      operationId: 'post_tickets_admin_tickets_{ticket_id}_scan',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Get Events By Store
  ///@param store_id
  Future<chopper.Response<List<EventSimple>>>
  ticketsAdminStoreStoreIdEventsGet({required String? storeId}) {
    generatedMapping.putIfAbsent(
      EventSimple,
      () => EventSimple.fromJsonFactory,
    );

    return _ticketsAdminStoreStoreIdEventsGet(storeId: storeId);
  }

  ///Get Events By Store
  ///@param store_id
  @GET(path: '/tickets/admin/store/{store_id}/events')
  Future<chopper.Response<List<EventSimple>>>
  _ticketsAdminStoreStoreIdEventsGet({
    @Path('store_id') required String? storeId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Events By Store',
      operationId: 'get_tickets_admin_store_{store_id}_events',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Get Events By Association
  ///@param association_id
  Future<chopper.Response<List<EventSimple>>>
  ticketsAdminAssociationAssociationIdEventsGet({
    required String? associationId,
  }) {
    generatedMapping.putIfAbsent(
      EventSimple,
      () => EventSimple.fromJsonFactory,
    );

    return _ticketsAdminAssociationAssociationIdEventsGet(
      associationId: associationId,
    );
  }

  ///Get Events By Association
  ///@param association_id
  @GET(path: '/tickets/admin/association/{association_id}/events')
  Future<chopper.Response<List<EventSimple>>>
  _ticketsAdminAssociationAssociationIdEventsGet({
    @Path('association_id') required String? associationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all events of an association

**The user should have the right to manage the event seller**''',
      summary: 'Get Events By Association',
      operationId: 'get_tickets_admin_association_{association_id}_events',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Tickets"],
      deprecated: false,
    ),
  });

  ///Read Associations
  Future<chopper.Response<List<Association>>> associationsGet() {
    generatedMapping.putIfAbsent(
      Association,
      () => Association.fromJsonFactory,
    );

    return _associationsGet();
  }

  ///Read Associations
  @GET(path: '/associations/')
  Future<chopper.Response<List<Association>>> _associationsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all associations

**User must be authenticated**''',
      summary: 'Read Associations',
      operationId: 'get_associations_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Associations"],
      deprecated: false,
    ),
  });

  ///Create Association
  Future<chopper.Response<Association>> associationsPost({
    required AppCoreAssociationsSchemasAssociationsAssociationBase? body,
  }) {
    generatedMapping.putIfAbsent(
      Association,
      () => Association.fromJsonFactory,
    );

    return _associationsPost(body: body);
  }

  ///Create Association
  @POST(path: '/associations/', optionalBody: true)
  Future<chopper.Response<Association>> _associationsPost({
    @Body()
    required AppCoreAssociationsSchemasAssociationsAssociationBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new association

**This endpoint is only usable by administrators**''',
      summary: 'Create Association',
      operationId: 'post_associations_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Associations"],
      deprecated: false,
    ),
  });

  ///Read Associations Me
  Future<chopper.Response<List<Association>>> associationsMeGet() {
    generatedMapping.putIfAbsent(
      Association,
      () => Association.fromJsonFactory,
    );

    return _associationsMeGet();
  }

  ///Read Associations Me
  @GET(path: '/associations/me')
  Future<chopper.Response<List<Association>>> _associationsMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Return all associations the current user has the right to manage

**User must be authenticated**''',
      summary: 'Read Associations Me',
      operationId: 'get_associations_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Associations"],
      deprecated: false,
    ),
  });

  ///Update Association
  ///@param association_id
  Future<chopper.Response> associationsAssociationIdPatch({
    required String? associationId,
    required AssociationUpdate? body,
  }) {
    return _associationsAssociationIdPatch(
      associationId: associationId,
      body: body,
    );
  }

  ///Update Association
  ///@param association_id
  @PATCH(path: '/associations/{association_id}', optionalBody: true)
  Future<chopper.Response> _associationsAssociationIdPatch({
    @Path('association_id') required String? associationId,
    @Body() required AssociationUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update the name or the description of a association.

**This endpoint is only usable by administrators**''',
      summary: 'Update Association',
      operationId: 'patch_associations_{association_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Associations"],
      deprecated: false,
    ),
  });

  ///Create Association Logo
  ///@param association_id
  Future<chopper.Response> associationsAssociationIdLogoPost({
    required String? associationId,
    required List<int> image,
  }) {
    return _associationsAssociationIdLogoPost(
      associationId: associationId,
      image: image,
    );
  }

  ///Create Association Logo
  ///@param association_id
  @POST(path: '/associations/{association_id}/logo', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _associationsAssociationIdLogoPost({
    @Path('association_id') required String? associationId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Upload a logo for an association

**This endpoint is only usable by administrators**''',
      summary: 'Create Association Logo',
      operationId: 'post_associations_{association_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Associations"],
      deprecated: false,
    ),
  });

  ///Read Association Logo
  ///@param association_id
  Future<chopper.Response> associationsAssociationIdLogoGet({
    required String? associationId,
  }) {
    return _associationsAssociationIdLogoGet(associationId: associationId);
  }

  ///Read Association Logo
  ///@param association_id
  @GET(path: '/associations/{association_id}/logo')
  Future<chopper.Response> _associationsAssociationIdLogoGet({
    @Path('association_id') required String? associationId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the logo of an association

**User must be authenticated**''',
      summary: 'Read Association Logo',
      operationId: 'get_associations_{association_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Associations"],
      deprecated: false,
    ),
  });

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
  @POST(
    path: '/auth/simple_token',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<AccessToken>> _authSimpleTokenPost({
    @Body() required Map<String, String> body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Ask for a JWT access token using oauth password flow.

*username* and *password* must be provided

Note: the request body needs to use **form-data** and not json.''',
      summary: 'Login For Access Token',
      operationId: 'post_auth_simple_token',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
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
  @GET(path: '/auth/authorize')
  Future<chopper.Response<String>> _authAuthorizeGet({
    @Query('client_id') required String? clientId,
    @Query('redirect_uri') String? redirectUri,
    @Query('response_type') required String? responseType,
    @Query('scope') String? scope,
    @Query('state') String? state,
    @Query('nonce') String? nonce,
    @Query('code_challenge') String? codeChallenge,
    @Query('code_challenge_method') String? codeChallengeMethod,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint is the one the user is redirected to when they begin the Oauth or Openid connect (*oidc*) *Authorization code* process.
The page allows the user to login and may let the user choose what type of data they want to authorize the client for.

This is the endpoint that should be set in the client OAuth or OIDC configuration page. It can be called by a GET or a POST request.

See `/auth/authorization-flow/authorize-validation` endpoint for information about the parameters.

> In order for the authorization code grant to be secure, the authorization page must appear in a web browser the user is familiar with,
> and must not be embedded in an iframe popup or an embedded browser in a mobile app.
> If it could be embedded in another website, the user would have no way of verifying it is the legitimate service and is not a phishing attempt.

**This endpoint is a UI endpoint which send and html page response. It will redirect to `/auth/authorization-flow/authorize-validation`**''',
      summary: 'Get Authorize Page',
      operationId: 'get_auth_authorize',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
  });

  ///Post Authorize Page
  Future<chopper.Response<String>> authAuthorizePost({
    required Map<String, String> body,
  }) {
    return _authAuthorizePost(body: body);
  }

  ///Post Authorize Page
  @POST(path: '/auth/authorize', headers: {contentTypeKey: formEncodedHeaders})
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<String>> _authAuthorizePost({
    @Body() required Map<String, String> body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint is the one the user is redirected to when they begin the OAuth or Openid connect (*oidc*) *Authorization code* process with or without PKCE.
The page allows the user to login and may let the user choose what type of data they want to authorize the client for.

This is the endpoint that should be set in the client OAuth or OIDC configuration page. It can be called by a GET or a POST request.

See `/auth/authorization-flow/authorize-validation` endpoint for information about the parameters.

> In order for the authorization code grant to be secure, the authorization page must appear in a web browser the user is familiar with,
> and must not be embedded in an iframe popup or an embedded browser in a mobile app.
> If it could be embedded in another website, the user would have no way of verifying it is the legitimate service and is not a phishing attempt.

**This endpoint is a UI endpoint which send and html page response. It will redirect to `/auth/authorization-flow/authorize-validation`**''',
      summary: 'Post Authorize Page',
      operationId: 'post_auth_authorize',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
  });

  ///Authorize Validation
  Future<chopper.Response> authAuthorizationFlowAuthorizeValidationPost({
    required Map<String, String> body,
  }) {
    return _authAuthorizationFlowAuthorizeValidationPost(body: body);
  }

  ///Authorize Validation
  @POST(
    path: '/auth/authorization-flow/authorize-validation',
    headers: {contentTypeKey: formEncodedHeaders},
  )
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response> _authAuthorizationFlowAuthorizeValidationPost({
    @Body() required Map<String, String> body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Part 1 of the authorization code grant.

Parameters must be `application/x-www-form-urlencoded` and includes:

* parameters for OAuth and Openid connect:
    * `response_type`: must be `code`
    * `client_id`: client identifier, needs to be registered in the server known_clients
    * `redirect_uri`: optional for OAuth (when registered in known_clients) but required for oidc. The url we need to redirect the user to after the authorization.
    * `scope`: optional for OAuth, must contain "openid" for oidc. List of scope the client want to get access to.
    * `state`: recommended. Opaque value used to maintain state between the request and the callback.

* additional parameters for Openid connect:
    * `nonce`: oidc only. A string value used to associate a client session with an ID Token, and to mitigate replay attacks.

* additional parameters for PKCE (see specs on https://datatracker.ietf.org/doc/html/rfc7636/):
    * `code_challenge`: PKCE only
    * `code_challenge_method`: PKCE only


* parameters that allows to authenticate the user and know which scopes he grants access to.
    * `email`
    * `password`

References:
 * https://www.rfc-editor.org/rfc/rfc6749.html#section-4.1.2
 * https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest''',
      summary: 'Authorize Validation',
      operationId: 'post_auth_authorization-flow_authorize-validation',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
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
  @POST(path: '/auth/token', headers: {contentTypeKey: formEncodedHeaders})
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<TokenResponse>> _authTokenPost({
    @Header('authorization') String? authorization,
    @Body() required Map<String, String> body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Part 2 of the authorization code grant.
The client exchange its authorization code for an access token. The endpoint supports OAuth and Openid connect, with or without PKCE.

Parameters must be `application/x-www-form-urlencoded` and include:

* parameters for OAuth and Openid connect:
    * `grant_type`: must be `authorization_code` or `refresh_token`
    * `code`: the authorization code received from the authorization endpoint
    * `redirect_uri`: optional for OAuth (when registered in known_clients) but required for oidc. The url we need to redirect the user to after the authorization. If provided, must be the same as previously registered in the `redirect_uri` field of the client.

* Client credentials
    The client must send either:
        the client id and secret in the authorization header or with client_id and client_secret parameters

* additional parameters for PKCE:
    * `code_verifier`: PKCE only, allows to verify the previous code_challenge

https://datatracker.ietf.org/doc/html/rfc6749#section-4.1.3
https://openid.net/specs/openid-connect-core-1_0.html#TokenRequestValidation''',
      summary: 'Token',
      operationId: 'post_auth_token',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
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
  @POST(path: '/auth/introspect', headers: {contentTypeKey: formEncodedHeaders})
  @FactoryConverter(request: FormUrlEncodedConverter.requestFactory)
  Future<chopper.Response<IntrospectTokenResponse>> _authIntrospectPost({
    @Header('authorization') String? authorization,
    @Body() required Map<String, String> body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Some clients requires an endpoint to check if an access token or a refresh token is valid.
This endpoint should not be publicly accessible, and is thus restricted to some AuthClient.

* parameters:
    * `token`: the token to introspect
    * `token_type_hint`: may be `access_token` or `refresh_token`, we currently do not use this hint as we are able to differentiate access and refresh tokens

* Client credentials
    The client must send either:
        the client id and secret in the authorization header or with client_id and client_secret parameters

Reference:
https://www.oauth.com/oauth2-servers/token-introspection-endpoint/
https://datatracker.ietf.org/doc/html/rfc7662''',
      summary: 'Introspect',
      operationId: 'post_auth_introspect',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
  });

  ///Auth Get Userinfo
  Future<chopper.Response> authUserinfoGet() {
    return _authUserinfoGet();
  }

  ///Auth Get Userinfo
  @GET(path: '/auth/userinfo')
  Future<chopper.Response> _authUserinfoGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Openid connect specify an endpoint the client can use to get information about the user.
The oidc client will provide the access_token it got previously in the request.

The information expected depends on the client and may include the user identifier, name, email, phone...
See the reference for possible claims. See the client documentation and implementation to know what it needs and can receive.
The sub (subject) Claim MUST always be returned in the UserInfo Response.

The client can ask for specific information using scopes and claims. See the reference for more information.
This procedure is not implemented in Hyperion as we can customize the response using auth_client class

Reference:
https://openid.net/specs/openid-connect-core-1_0.html#UserInfo''',
      summary: 'Auth Get Userinfo',
      operationId: 'get_auth_userinfo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Auth"],
      deprecated: false,
    ),
  });

  ///Jwks Uri
  Future<chopper.Response> oidcAuthorizationFlowJwksUriGet() {
    return _oidcAuthorizationFlowJwksUriGet();
  }

  ///Jwks Uri
  @GET(path: '/oidc/authorization-flow/jwks_uri')
  Future<chopper.Response> _oidcAuthorizationFlowJwksUriGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Jwks Uri',
      operationId: 'get_oidc_authorization-flow_jwks_uri',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
  });

  ///Oauth Configuration
  Future<chopper.Response> wellKnownOauthAuthorizationServerGet() {
    return _wellKnownOauthAuthorizationServerGet();
  }

  ///Oauth Configuration
  @GET(path: '/.well-known/oauth-authorization-server')
  Future<chopper.Response> _wellKnownOauthAuthorizationServerGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Oauth Configuration',
      operationId: 'get_.well-known_oauth-authorization-server',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
  });

  ///Oidc Configuration
  Future<chopper.Response> wellKnownOpenidConfigurationGet() {
    return _wellKnownOpenidConfigurationGet();
  }

  ///Oidc Configuration
  @GET(path: '/.well-known/openid-configuration')
  Future<chopper.Response> _wellKnownOpenidConfigurationGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Oidc Configuration',
      operationId: 'get_.well-known_openid-configuration',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
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
  @GET(path: '/information')
  Future<chopper.Response<CoreInformation>> _informationGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return information about Hyperion. This endpoint can be used to check if the API is up.',
      summary: 'Read Information',
      operationId: 'get_information',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Privacy
  Future<chopper.Response> privacyGet() {
    return _privacyGet();
  }

  ///Read Privacy
  @GET(path: '/privacy')
  Future<chopper.Response> _privacyGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return Hyperion privacy',
      summary: 'Read Privacy',
      operationId: 'get_privacy',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Terms And Conditions
  Future<chopper.Response> termsAndConditionsGet() {
    return _termsAndConditionsGet();
  }

  ///Read Terms And Conditions
  @GET(path: '/terms-and-conditions')
  Future<chopper.Response> _termsAndConditionsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return Hyperion terms and conditions pages',
      summary: 'Read Terms And Conditions',
      operationId: 'get_terms-and-conditions',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Mypayment Tos
  Future<chopper.Response> mypaymentTermsOfServiceGet() {
    return _mypaymentTermsOfServiceGet();
  }

  ///Read Mypayment Tos
  @GET(path: '/mypayment-terms-of-service')
  Future<chopper.Response> _mypaymentTermsOfServiceGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return MyPayment latest ToS',
      summary: 'Read Mypayment Tos',
      operationId: 'get_mypayment-terms-of-service',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Support
  Future<chopper.Response> supportGet() {
    return _supportGet();
  }

  ///Read Support
  @GET(path: '/support')
  Future<chopper.Response> _supportGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return Hyperion support',
      summary: 'Read Support',
      operationId: 'get_support',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Security Txt
  Future<chopper.Response> securityTxtGet() {
    return _securityTxtGet();
  }

  ///Read Security Txt
  @GET(path: '/security.txt')
  Future<chopper.Response> _securityTxtGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return Hyperion security.txt file',
      summary: 'Read Security Txt',
      operationId: 'get_security.txt',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Wellknown Security Txt
  Future<chopper.Response> wellKnownSecurityTxtGet() {
    return _wellKnownSecurityTxtGet();
  }

  ///Read Wellknown Security Txt
  @GET(path: '/.well-known/security.txt')
  Future<chopper.Response> _wellKnownSecurityTxtGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return Hyperion security.txt file',
      summary: 'Read Wellknown Security Txt',
      operationId: 'get_.well-known_security.txt',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Robots Txt
  Future<chopper.Response> robotsTxtGet() {
    return _robotsTxtGet();
  }

  ///Read Robots Txt
  @GET(path: '/robots.txt')
  Future<chopper.Response> _robotsTxtGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return Hyperion robots.txt file',
      summary: 'Read Robots Txt',
      operationId: 'get_robots.txt',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Read Account Deletion
  Future<chopper.Response> accountDeletionGet() {
    return _accountDeletionGet();
  }

  ///Read Account Deletion
  @GET(path: '/account-deletion')
  Future<chopper.Response> _accountDeletionGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return Hyperion account deletion information',
      summary: 'Read Account Deletion',
      operationId: 'get_account-deletion',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Get Variables
  Future<chopper.Response<CoreVariables>> variablesGet() {
    generatedMapping.putIfAbsent(
      CoreVariables,
      () => CoreVariables.fromJsonFactory,
    );

    return _variablesGet();
  }

  ///Get Variables
  @GET(path: '/variables')
  Future<chopper.Response<CoreVariables>> _variablesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return a style file from the assets folder',
      summary: 'Get Variables',
      operationId: 'get_variables',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Get Favicon
  Future<chopper.Response> faviconIcoGet() {
    return _faviconIcoGet();
  }

  ///Get Favicon
  @GET(path: '/favicon.ico')
  Future<chopper.Response> _faviconIcoGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Favicon',
      operationId: 'get_favicon.ico',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Core"],
      deprecated: false,
    ),
  });

  ///Register Firebase Device
  Future<chopper.Response> notificationDevicesPost({
    required BodyRegisterFirebaseDeviceNotificationDevicesPost? body,
  }) {
    return _notificationDevicesPost(body: body);
  }

  ///Register Firebase Device
  @POST(path: '/notification/devices', optionalBody: true)
  Future<chopper.Response> _notificationDevicesPost({
    @Body() required BodyRegisterFirebaseDeviceNotificationDevicesPost? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Register a firebase device for the user, if the device already exists, this will update the creation date.
This endpoint should be called once a month to ensure that the token is still valide.

**The user must be authenticated to use this endpoint**''',
      summary: 'Register Firebase Device',
      operationId: 'post_notification_devices',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Get Devices
  ///@param user_id
  Future<chopper.Response<List<FirebaseDevice>>> notificationDevicesGet({
    String? userId,
  }) {
    generatedMapping.putIfAbsent(
      FirebaseDevice,
      () => FirebaseDevice.fromJsonFactory,
    );

    return _notificationDevicesGet(userId: userId);
  }

  ///Get Devices
  ///@param user_id
  @GET(path: '/notification/devices')
  Future<chopper.Response<List<FirebaseDevice>>> _notificationDevicesGet({
    @Query('user_id') String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all devices a user have registered.
This endpoint is useful to get firebase tokens for debugging purposes.

**Only admins can use this endpoint**''',
      summary: 'Get Devices',
      operationId: 'get_notification_devices',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
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
  @DELETE(path: '/notification/devices/{firebase_token}')
  Future<chopper.Response> _notificationDevicesFirebaseTokenDelete({
    @Path('firebase_token') required String? firebaseToken,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Unregister a firebase device for the user

**The user must be authenticated to use this endpoint**''',
      summary: 'Unregister Firebase Device',
      operationId: 'delete_notification_devices_{firebase_token}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Subscribe To Topic
  ///@param topic_id
  Future<chopper.Response> notificationTopicsTopicIdSubscribePost({
    required String? topicId,
  }) {
    return _notificationTopicsTopicIdSubscribePost(topicId: topicId);
  }

  ///Subscribe To Topic
  ///@param topic_id
  @POST(path: '/notification/topics/{topic_id}/subscribe', optionalBody: true)
  Future<chopper.Response> _notificationTopicsTopicIdSubscribePost({
    @Path('topic_id') required String? topicId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Subscribe to a topic.

If the topic define restrictions, the user must be in the corresponding group or be a member.

**The user must be authenticated to use this endpoint**''',
      summary: 'Subscribe To Topic',
      operationId: 'post_notification_topics_{topic_id}_subscribe',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Unsubscribe To Topic
  ///@param topic_id
  Future<chopper.Response> notificationTopicsTopicIdUnsubscribePost({
    required String? topicId,
  }) {
    return _notificationTopicsTopicIdUnsubscribePost(topicId: topicId);
  }

  ///Unsubscribe To Topic
  ///@param topic_id
  @POST(path: '/notification/topics/{topic_id}/unsubscribe', optionalBody: true)
  Future<chopper.Response> _notificationTopicsTopicIdUnsubscribePost({
    @Path('topic_id') required String? topicId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Unsubscribe to a topic

**The user must be authenticated to use this endpoint**''',
      summary: 'Unsubscribe To Topic',
      operationId: 'post_notification_topics_{topic_id}_unsubscribe',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Get Topics
  Future<chopper.Response<List<TopicUser>>> notificationTopicsGet() {
    generatedMapping.putIfAbsent(TopicUser, () => TopicUser.fromJsonFactory);

    return _notificationTopicsGet();
  }

  ///Get Topics
  @GET(path: '/notification/topics')
  Future<chopper.Response<List<TopicUser>>> _notificationTopicsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return all available topics for a user

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Topics',
      operationId: 'get_notification_topics',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Send Notification
  Future<chopper.Response> notificationSendPost({
    required GroupNotificationRequest? body,
  }) {
    return _notificationSendPost(body: body);
  }

  ///Send Notification
  @POST(path: '/notification/send', optionalBody: true)
  Future<chopper.Response> _notificationSendPost({
    @Body() required GroupNotificationRequest? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Send a notification to a group.

**Only admins can use this endpoint**''',
      summary: 'Send Notification',
      operationId: 'post_notification_send',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Send Test Notification
  ///@param user_id
  Future<chopper.Response> notificationTestSendPost({String? userId}) {
    return _notificationTestSendPost(userId: userId);
  }

  ///Send Test Notification
  ///@param user_id
  @POST(path: '/notification/test/send', optionalBody: true)
  Future<chopper.Response> _notificationTestSendPost({
    @Query('user_id') String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Send ourself a test notification.

**Only admins can use this endpoint**''',
      summary: 'Send Test Notification',
      operationId: 'post_notification_test_send',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Send Test Future Notification
  ///@param user_id
  Future<chopper.Response> notificationTestSendFuturePost({String? userId}) {
    return _notificationTestSendFuturePost(userId: userId);
  }

  ///Send Test Future Notification
  ///@param user_id
  @POST(path: '/notification/test/send/future', optionalBody: true)
  Future<chopper.Response> _notificationTestSendFuturePost({
    @Query('user_id') String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Send ourself a test notification.

**Only admins can use this endpoint**''',
      summary: 'Send Test Future Notification',
      operationId: 'post_notification_test_send_future',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Send Test Notification Topic
  Future<chopper.Response> notificationTestSendTopicPost() {
    return _notificationTestSendTopicPost();
  }

  ///Send Test Notification Topic
  @POST(path: '/notification/test/send/topic', optionalBody: true)
  Future<chopper.Response> _notificationTestSendTopicPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Send ourself a test notification.

**Only admins can use this endpoint**''',
      summary: 'Send Test Notification Topic',
      operationId: 'post_notification_test_send_topic',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Send Test Future Notification Topic
  Future<chopper.Response> notificationTestSendTopicFuturePost() {
    return _notificationTestSendTopicFuturePost();
  }

  ///Send Test Future Notification Topic
  @POST(path: '/notification/test/send/topic/future', optionalBody: true)
  Future<chopper.Response> _notificationTestSendTopicFuturePost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Send ourself a test notification.

**Only admins can use this endpoint**''',
      summary: 'Send Test Future Notification Topic',
      operationId: 'post_notification_test_send_topic_future',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Notifications"],
      deprecated: false,
    ),
  });

  ///Read Groups
  Future<chopper.Response<List<CoreGroupSimple>>> groupsGet() {
    generatedMapping.putIfAbsent(
      CoreGroupSimple,
      () => CoreGroupSimple.fromJsonFactory,
    );

    return _groupsGet();
  }

  ///Read Groups
  @GET(path: '/groups/')
  Future<chopper.Response<List<CoreGroupSimple>>> _groupsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all groups from database as a list of dictionaries',
      summary: 'Read Groups',
      operationId: 'get_groups_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/groups/', optionalBody: true)
  Future<chopper.Response<CoreGroupSimple>> _groupsPost({
    @Body() required CoreGroupCreate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new group.

**This endpoint is only usable by administrators**''',
      summary: 'Create Group',
      operationId: 'post_groups_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
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
  @GET(path: '/groups/{group_id}')
  Future<chopper.Response<CoreGroup>> _groupsGroupIdGet({
    @Path('group_id') required String? groupId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Return group with id from database as a dictionary. This includes a list of users being members of the group.

**This endpoint is only usable by administrators**''',
      summary: 'Read Group',
      operationId: 'get_groups_{group_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
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
  @PATCH(path: '/groups/{group_id}', optionalBody: true)
  Future<chopper.Response> _groupsGroupIdPatch({
    @Path('group_id') required String? groupId,
    @Body() required CoreGroupUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update the name or the description of a group.

**This endpoint is only usable by administrators**''',
      summary: 'Update Group',
      operationId: 'patch_groups_{group_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Delete Group
  ///@param group_id
  Future<chopper.Response> groupsGroupIdDelete({required String? groupId}) {
    return _groupsGroupIdDelete(groupId: groupId);
  }

  ///Delete Group
  ///@param group_id
  @DELETE(path: '/groups/{group_id}')
  Future<chopper.Response> _groupsGroupIdDelete({
    @Path('group_id') required String? groupId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete group from database.
This will remove the group from all users but won\'t delete any user.

`GroupTypes` groups can not be deleted.

**This endpoint is only usable by administrators**''',
      summary: 'Delete Group',
      operationId: 'delete_groups_{group_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Create Membership
  Future<chopper.Response<CoreGroup>> groupsMembershipPost({
    required CoreMembership? body,
  }) {
    generatedMapping.putIfAbsent(CoreGroup, () => CoreGroup.fromJsonFactory);

    return _groupsMembershipPost(body: body);
  }

  ///Create Membership
  @POST(path: '/groups/membership', optionalBody: true)
  Future<chopper.Response<CoreGroup>> _groupsMembershipPost({
    @Body() required CoreMembership? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Create a new membership in database and return the group. This allows to "add a user to a group".

**This endpoint is only usable by administrators**''',
      summary: 'Create Membership',
      operationId: 'post_groups_membership',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Delete Membership
  Future<chopper.Response> groupsMembershipDelete({
    required CoreMembershipDelete? body,
  }) {
    return _groupsMembershipDelete(body: body);
  }

  ///Delete Membership
  @DELETE(path: '/groups/membership')
  Future<chopper.Response> _groupsMembershipDelete({
    @Body() required CoreMembershipDelete? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a membership using the user and group ids.

**This endpoint is only usable by administrators**''',
      summary: 'Delete Membership',
      operationId: 'delete_groups_membership',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Create Batch Membership
  Future<chopper.Response> groupsBatchMembershipPost({
    required CoreBatchMembership? body,
  }) {
    return _groupsBatchMembershipPost(body: body);
  }

  ///Create Batch Membership
  @POST(path: '/groups/batch-membership', optionalBody: true)
  Future<chopper.Response> _groupsBatchMembershipPost({
    @Body() required CoreBatchMembership? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add a list of user to a group, using a list of email.
If an user does not exist it will be ignored.

**This endpoint is only usable by administrators**''',
      summary: 'Create Batch Membership',
      operationId: 'post_groups_batch-membership',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Delete Batch Membership
  Future<chopper.Response> groupsBatchMembershipDelete({
    required CoreBatchDeleteMembership? body,
  }) {
    return _groupsBatchMembershipDelete(body: body);
  }

  ///Delete Batch Membership
  @DELETE(path: '/groups/batch-membership')
  Future<chopper.Response> _groupsBatchMembershipDelete({
    @Body() required CoreBatchDeleteMembership? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''This endpoint removes all users from a given group.

**This endpoint is only usable by administrators**''',
      summary: 'Delete Batch Membership',
      operationId: 'delete_groups_batch-membership',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Create Group Logo
  ///@param group_id
  Future<chopper.Response> groupsGroupIdLogoPost({
    required String? groupId,
    required List<int> image,
  }) {
    return _groupsGroupIdLogoPost(groupId: groupId, image: image);
  }

  ///Create Group Logo
  ///@param group_id
  @POST(path: '/groups/{group_id}/logo', optionalBody: true)
  @Multipart()
  Future<chopper.Response> _groupsGroupIdLogoPost({
    @Path('group_id') required String? groupId,
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Upload a logo for a group.

**This endpoint is only usable by administrators**''',
      summary: 'Create Group Logo',
      operationId: 'post_groups_{group_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Read User Profile Picture
  ///@param group_id
  Future<chopper.Response> groupsGroupIdLogoGet({required String? groupId}) {
    return _groupsGroupIdLogoGet(groupId: groupId);
  }

  ///Read User Profile Picture
  ///@param group_id
  @GET(path: '/groups/{group_id}/logo')
  Future<chopper.Response> _groupsGroupIdLogoGet({
    @Path('group_id') required String? groupId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the logo of a group.

**User must be authenticated**''',
      summary: 'Read User Profile Picture',
      operationId: 'get_groups_{group_id}_logo',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Groups"],
      deprecated: false,
    ),
  });

  ///Read Permissions List
  Future<chopper.Response<List<String>>> permissionsListGet() {
    return _permissionsListGet();
  }

  ///Read Permissions List
  @GET(path: '/permissions/list')
  Future<chopper.Response<List<String>>> _permissionsListGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all permissions from database',
      summary: 'Read Permissions List',
      operationId: 'get_permissions_list',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Permissions"],
      deprecated: false,
    ),
  });

  ///Read Permissions
  Future<chopper.Response<List<CorePermission>>> permissionsGet() {
    generatedMapping.putIfAbsent(
      CorePermission,
      () => CorePermission.fromJsonFactory,
    );

    return _permissionsGet();
  }

  ///Read Permissions
  @GET(path: '/permissions/')
  Future<chopper.Response<List<CorePermission>>> _permissionsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all permissions from database',
      summary: 'Read Permissions',
      operationId: 'get_permissions_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Permissions"],
      deprecated: false,
    ),
  });

  ///Create Permission
  Future<chopper.Response> permissionsPost({required Object? body}) {
    return _permissionsPost(body: body);
  }

  ///Create Permission
  @POST(path: '/permissions/', optionalBody: true)
  Future<chopper.Response> _permissionsPost({
    @Body() required Object? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Create a new permission in database',
      summary: 'Create Permission',
      operationId: 'post_permissions_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Permissions"],
      deprecated: false,
    ),
  });

  ///Delete Permission
  Future<chopper.Response> permissionsDelete({required Object? body}) {
    return _permissionsDelete(body: body);
  }

  ///Delete Permission
  @DELETE(path: '/permissions/')
  Future<chopper.Response> _permissionsDelete({
    @Body() required Object? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Delete a permission from database by name',
      summary: 'Delete Permission',
      operationId: 'delete_permissions_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Permissions"],
      deprecated: false,
    ),
  });

  ///Read Permission
  ///@param permission_name
  Future<chopper.Response<CorePermission>> permissionsPermissionNameGet({
    required String? permissionName,
  }) {
    generatedMapping.putIfAbsent(
      CorePermission,
      () => CorePermission.fromJsonFactory,
    );

    return _permissionsPermissionNameGet(permissionName: permissionName);
  }

  ///Read Permission
  ///@param permission_name
  @GET(path: '/permissions/{permission_name}')
  Future<chopper.Response<CorePermission>> _permissionsPermissionNameGet({
    @Path('permission_name') required String? permissionName,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return permission with name from database',
      summary: 'Read Permission',
      operationId: 'get_permissions_{permission_name}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Permissions"],
      deprecated: false,
    ),
  });

  ///Webhook
  Future<chopper.Response> checkoutHelloassoWebhookPost() {
    return _checkoutHelloassoWebhookPost();
  }

  ///Webhook
  @POST(path: '/checkout/helloasso/webhook', optionalBody: true)
  Future<chopper.Response> _checkoutHelloassoWebhookPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Webhook',
      operationId: 'post_checkout_helloasso_webhook',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Checkout"],
      deprecated: false,
    ),
  });

  ///Get Bank Account Holder
  Future<chopper.Response<Structure>> mypaymentBankAccountHolderGet() {
    generatedMapping.putIfAbsent(Structure, () => Structure.fromJsonFactory);

    return _mypaymentBankAccountHolderGet();
  }

  ///Get Bank Account Holder
  @GET(path: '/mypayment/bank-account-holder')
  Future<chopper.Response<Structure>> _mypaymentBankAccountHolderGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get the current bank account holder information.',
      summary: 'Get Bank Account Holder',
      operationId: 'get_mypayment_bank-account-holder',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Set Bank Account Holder
  Future<chopper.Response<Structure>> mypaymentBankAccountHolderPost({
    required MyPaymentBankAccountHolder? body,
  }) {
    generatedMapping.putIfAbsent(Structure, () => Structure.fromJsonFactory);

    return _mypaymentBankAccountHolderPost(body: body);
  }

  ///Set Bank Account Holder
  @POST(path: '/mypayment/bank-account-holder', optionalBody: true)
  Future<chopper.Response<Structure>> _mypaymentBankAccountHolderPost({
    @Body() required MyPaymentBankAccountHolder? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Set the bank account holder information.',
      summary: 'Set Bank Account Holder',
      operationId: 'post_mypayment_bank-account-holder',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get Structures
  Future<chopper.Response<List<Structure>>> mypaymentStructuresGet() {
    generatedMapping.putIfAbsent(Structure, () => Structure.fromJsonFactory);

    return _mypaymentStructuresGet();
  }

  ///Get Structures
  @GET(path: '/mypayment/structures')
  Future<chopper.Response<List<Structure>>> _mypaymentStructuresGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get all structures.',
      summary: 'Get Structures',
      operationId: 'get_mypayment_structures',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Create Structure
  Future<chopper.Response<Structure>> mypaymentStructuresPost({
    required StructureBase? body,
  }) {
    generatedMapping.putIfAbsent(Structure, () => Structure.fromJsonFactory);

    return _mypaymentStructuresPost(body: body);
  }

  ///Create Structure
  @POST(path: '/mypayment/structures', optionalBody: true)
  Future<chopper.Response<Structure>> _mypaymentStructuresPost({
    @Body() required StructureBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new structure.

A structure contains:
 - a name
 - an association membership id
 - a manager user id
 - a list of stores

**The user must be an admin to use this endpoint**''',
      summary: 'Create Structure',
      operationId: 'post_mypayment_structures',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Update Structure
  ///@param structure_id
  Future<chopper.Response> mypaymentStructuresStructureIdPatch({
    required String? structureId,
    required StructureUpdate? body,
  }) {
    return _mypaymentStructuresStructureIdPatch(
      structureId: structureId,
      body: body,
    );
  }

  ///Update Structure
  ///@param structure_id
  @PATCH(path: '/mypayment/structures/{structure_id}', optionalBody: true)
  Future<chopper.Response> _mypaymentStructuresStructureIdPatch({
    @Path('structure_id') required String? structureId,
    @Body() required StructureUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a structure.

**The user must be an admin to use this endpoint**''',
      summary: 'Update Structure',
      operationId: 'patch_mypayment_structures_{structure_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Delete Structure
  ///@param structure_id
  Future<chopper.Response> mypaymentStructuresStructureIdDelete({
    required String? structureId,
  }) {
    return _mypaymentStructuresStructureIdDelete(structureId: structureId);
  }

  ///Delete Structure
  ///@param structure_id
  @DELETE(path: '/mypayment/structures/{structure_id}')
  Future<chopper.Response> _mypaymentStructuresStructureIdDelete({
    @Path('structure_id') required String? structureId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Delete a structure. Only structures without stores can be deleted.

**The user must be an admin to use this endpoint**''',
      summary: 'Delete Structure',
      operationId: 'delete_mypayment_structures_{structure_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Init Transfer Structure Manager
  ///@param structure_id
  Future<chopper.Response>
  mypaymentStructuresStructureIdInitManagerTransferPost({
    required String? structureId,
    required StructureTranfert? body,
  }) {
    return _mypaymentStructuresStructureIdInitManagerTransferPost(
      structureId: structureId,
      body: body,
    );
  }

  ///Init Transfer Structure Manager
  ///@param structure_id
  @POST(
    path: '/mypayment/structures/{structure_id}/init-manager-transfer',
    optionalBody: true,
  )
  Future<chopper.Response>
  _mypaymentStructuresStructureIdInitManagerTransferPost({
    @Path('structure_id') required String? structureId,
    @Body() required StructureTranfert? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Initiate the transfer of a structure to a new manager. The current manager will receive an email with a link to confirm the transfer.
The link will only be valid for a limited time.

**The user must be the manager for this structure**''',
      summary: 'Init Transfer Structure Manager',
      operationId:
          'post_mypayment_structures_{structure_id}_init-manager-transfer',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Confirm Structure Manager Transfer
  ///@param token
  Future<chopper.Response> mypaymentStructuresConfirmManagerTransferGet({
    required String? token,
  }) {
    return _mypaymentStructuresConfirmManagerTransferGet(token: token);
  }

  ///Confirm Structure Manager Transfer
  ///@param token
  @GET(path: '/mypayment/structures/confirm-manager-transfer')
  Future<chopper.Response> _mypaymentStructuresConfirmManagerTransferGet({
    @Query('token') required String? token,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a manager for an association

The user must have initiated the update of the manager with `init_update_structure_manager`''',
      summary: 'Confirm Structure Manager Transfer',
      operationId: 'get_mypayment_structures_confirm-manager-transfer',
      consumes: [],
      produces: [],
      security: [],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Create Store
  ///@param structure_id
  Future<chopper.Response<UserStore>> mypaymentStructuresStructureIdStoresPost({
    required String? structureId,
    required StoreBase? body,
  }) {
    generatedMapping.putIfAbsent(UserStore, () => UserStore.fromJsonFactory);

    return _mypaymentStructuresStructureIdStoresPost(
      structureId: structureId,
      body: body,
    );
  }

  ///Create Store
  ///@param structure_id
  @POST(path: '/mypayment/structures/{structure_id}/stores', optionalBody: true)
  Future<chopper.Response<UserStore>>
  _mypaymentStructuresStructureIdStoresPost({
    @Path('structure_id') required String? structureId,
    @Body() required StoreBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Create a store. The structure manager will be added as a seller for the store.

Stores name should be unique, as an user need to be able to identify a store by its name.

**The user must be the manager for this structure**
**The user must be a member of the associated CoreAssociation**''',
      summary: 'Create Store',
      operationId: 'post_mypayment_structures_{structure_id}_stores',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get Store History
  ///@param store_id
  ///@param start_date
  ///@param end_date
  Future<chopper.Response<List<History>>> mypaymentStoresStoreIdHistoryGet({
    required String? storeId,
    String? startDate,
    String? endDate,
  }) {
    generatedMapping.putIfAbsent(History, () => History.fromJsonFactory);

    return _mypaymentStoresStoreIdHistoryGet(
      storeId: storeId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  ///Get Store History
  ///@param store_id
  ///@param start_date
  ///@param end_date
  @GET(path: '/mypayment/stores/{store_id}/history')
  Future<chopper.Response<List<History>>> _mypaymentStoresStoreIdHistoryGet({
    @Path('store_id') required String? storeId,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all transactions for the store.

**The user must be authorized to see the store history**''',
      summary: 'Get Store History',
      operationId: 'get_mypayment_stores_{store_id}_history',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Export Store History
  ///@param store_id
  ///@param start_date
  ///@param end_date
  Future<chopper.Response> mypaymentStoresStoreIdHistoryDataExportGet({
    required String? storeId,
    String? startDate,
    String? endDate,
  }) {
    return _mypaymentStoresStoreIdHistoryDataExportGet(
      storeId: storeId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  ///Export Store History
  ///@param store_id
  ///@param start_date
  ///@param end_date
  @GET(path: '/mypayment/stores/{store_id}/history/data-export')
  Future<chopper.Response> _mypaymentStoresStoreIdHistoryDataExportGet({
    @Path('store_id') required String? storeId,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Export store payment history as a CSV file.',
      summary: 'Export Store History',
      operationId: 'get_mypayment_stores_{store_id}_history_data-export',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get User Stores
  Future<chopper.Response<List<UserStore>>> mypaymentUsersMeStoresGet() {
    generatedMapping.putIfAbsent(UserStore, () => UserStore.fromJsonFactory);

    return _mypaymentUsersMeStoresGet();
  }

  ///Get User Stores
  @GET(path: '/mypayment/users/me/stores')
  Future<chopper.Response<List<UserStore>>> _mypaymentUsersMeStoresGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all stores for the current user.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get User Stores',
      operationId: 'get_mypayment_users_me_stores',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Update Store
  ///@param store_id
  Future<chopper.Response> mypaymentStoresStoreIdPatch({
    required String? storeId,
    required StoreUpdate? body,
  }) {
    return _mypaymentStoresStoreIdPatch(storeId: storeId, body: body);
  }

  ///Update Store
  ///@param store_id
  @PATCH(path: '/mypayment/stores/{store_id}', optionalBody: true)
  Future<chopper.Response> _mypaymentStoresStoreIdPatch({
    @Path('store_id') required String? storeId,
    @Body() required StoreUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a store

**The user must be the manager for this store\'s structure**''',
      summary: 'Update Store',
      operationId: 'patch_mypayment_stores_{store_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Delete Store
  ///@param store_id
  Future<chopper.Response> mypaymentStoresStoreIdDelete({
    required String? storeId,
  }) {
    return _mypaymentStoresStoreIdDelete(storeId: storeId);
  }

  ///Delete Store
  ///@param store_id
  @DELETE(path: '/mypayment/stores/{store_id}')
  Future<chopper.Response> _mypaymentStoresStoreIdDelete({
    @Path('store_id') required String? storeId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Delete a store. Only stores without transactions can be deleted.

**The user must be the manager for this store\'s structure**''',
      summary: 'Delete Store',
      operationId: 'delete_mypayment_stores_{store_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Create Store Seller
  ///@param store_id
  Future<chopper.Response<Seller>> mypaymentStoresStoreIdSellersPost({
    required String? storeId,
    required SellerCreation? body,
  }) {
    generatedMapping.putIfAbsent(Seller, () => Seller.fromJsonFactory);

    return _mypaymentStoresStoreIdSellersPost(storeId: storeId, body: body);
  }

  ///Create Store Seller
  ///@param store_id
  @POST(path: '/mypayment/stores/{store_id}/sellers', optionalBody: true)
  Future<chopper.Response<Seller>> _mypaymentStoresStoreIdSellersPost({
    @Path('store_id') required String? storeId,
    @Body() required SellerCreation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a store seller.

This seller will have authorized permissions among:
- can_bank
- can_see_history
- can_cancel
- can_manage_sellers

**The user must have the `can_manage_sellers` permission for this store**''',
      summary: 'Create Store Seller',
      operationId: 'post_mypayment_stores_{store_id}_sellers',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get Store Sellers
  ///@param store_id
  Future<chopper.Response<List<Seller>>> mypaymentStoresStoreIdSellersGet({
    required String? storeId,
  }) {
    generatedMapping.putIfAbsent(Seller, () => Seller.fromJsonFactory);

    return _mypaymentStoresStoreIdSellersGet(storeId: storeId);
  }

  ///Get Store Sellers
  ///@param store_id
  @GET(path: '/mypayment/stores/{store_id}/sellers')
  Future<chopper.Response<List<Seller>>> _mypaymentStoresStoreIdSellersGet({
    @Path('store_id') required String? storeId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all sellers for the given store.

**The user must have the `can_manage_sellers` permission for this store**''',
      summary: 'Get Store Sellers',
      operationId: 'get_mypayment_stores_{store_id}_sellers',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Update Store Seller
  ///@param store_id
  ///@param seller_user_id
  Future<chopper.Response> mypaymentStoresStoreIdSellersSellerUserIdPatch({
    required String? storeId,
    required String? sellerUserId,
    required SellerUpdate? body,
  }) {
    return _mypaymentStoresStoreIdSellersSellerUserIdPatch(
      storeId: storeId,
      sellerUserId: sellerUserId,
      body: body,
    );
  }

  ///Update Store Seller
  ///@param store_id
  ///@param seller_user_id
  @PATCH(
    path: '/mypayment/stores/{store_id}/sellers/{seller_user_id}',
    optionalBody: true,
  )
  Future<chopper.Response> _mypaymentStoresStoreIdSellersSellerUserIdPatch({
    @Path('store_id') required String? storeId,
    @Path('seller_user_id') required String? sellerUserId,
    @Body() required SellerUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a store seller permissions.
The structure manager cannot be updated as a seller.

**The user must have the `can_manage_sellers` permission for this store**''',
      summary: 'Update Store Seller',
      operationId: 'patch_mypayment_stores_{store_id}_sellers_{seller_user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Delete Store Seller
  ///@param store_id
  ///@param seller_user_id
  Future<chopper.Response> mypaymentStoresStoreIdSellersSellerUserIdDelete({
    required String? storeId,
    required String? sellerUserId,
  }) {
    return _mypaymentStoresStoreIdSellersSellerUserIdDelete(
      storeId: storeId,
      sellerUserId: sellerUserId,
    );
  }

  ///Delete Store Seller
  ///@param store_id
  ///@param seller_user_id
  @DELETE(path: '/mypayment/stores/{store_id}/sellers/{seller_user_id}')
  Future<chopper.Response> _mypaymentStoresStoreIdSellersSellerUserIdDelete({
    @Path('store_id') required String? storeId,
    @Path('seller_user_id') required String? sellerUserId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a store seller.
The structure manager cannot be deleted as a seller.

**The user must have the `can_manage_sellers` permission for this store**''',
      summary: 'Delete Store Seller',
      operationId:
          'delete_mypayment_stores_{store_id}_sellers_{seller_user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Register User
  Future<chopper.Response> mypaymentUsersMeRegisterPost() {
    return _mypaymentUsersMeRegisterPost();
  }

  ///Register User
  @POST(path: '/mypayment/users/me/register', optionalBody: true)
  Future<chopper.Response> _mypaymentUsersMeRegisterPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Sign MyPayment TOS for the given user.

The user will need to accept the latest TOS version to be able to use MyPayment.

**The user must be authenticated to use this endpoint**''',
      summary: 'Register User',
      operationId: 'post_mypayment_users_me_register',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get User Tos
  Future<chopper.Response<TOSSignatureResponse>> mypaymentUsersMeTosGet() {
    generatedMapping.putIfAbsent(
      TOSSignatureResponse,
      () => TOSSignatureResponse.fromJsonFactory,
    );

    return _mypaymentUsersMeTosGet();
  }

  ///Get User Tos
  @GET(path: '/mypayment/users/me/tos')
  Future<chopper.Response<TOSSignatureResponse>> _mypaymentUsersMeTosGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get the latest TOS version and the user signed TOS version.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get User Tos',
      operationId: 'get_mypayment_users_me_tos',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Sign Tos
  Future<chopper.Response> mypaymentUsersMeTosPost({
    required TOSSignature? body,
  }) {
    return _mypaymentUsersMeTosPost(body: body);
  }

  ///Sign Tos
  @POST(path: '/mypayment/users/me/tos', optionalBody: true)
  Future<chopper.Response> _mypaymentUsersMeTosPost({
    @Body() required TOSSignature? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Sign MyPayment TOS for the given user.

If the user is already registered in the MyPayment system, this will update the TOS version.

**The user must be authenticated to use this endpoint**''',
      summary: 'Sign Tos',
      operationId: 'post_mypayment_users_me_tos',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get User Devices
  Future<chopper.Response<List<WalletDevice>>>
  mypaymentUsersMeWalletDevicesGet() {
    generatedMapping.putIfAbsent(
      WalletDevice,
      () => WalletDevice.fromJsonFactory,
    );

    return _mypaymentUsersMeWalletDevicesGet();
  }

  ///Get User Devices
  @GET(path: '/mypayment/users/me/wallet/devices')
  Future<chopper.Response<List<WalletDevice>>>
  _mypaymentUsersMeWalletDevicesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get user devices.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get User Devices',
      operationId: 'get_mypayment_users_me_wallet_devices',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Create User Devices
  Future<chopper.Response<WalletDevice>> mypaymentUsersMeWalletDevicesPost({
    required WalletDeviceCreation? body,
  }) {
    generatedMapping.putIfAbsent(
      WalletDevice,
      () => WalletDevice.fromJsonFactory,
    );

    return _mypaymentUsersMeWalletDevicesPost(body: body);
  }

  ///Create User Devices
  @POST(path: '/mypayment/users/me/wallet/devices', optionalBody: true)
  Future<chopper.Response<WalletDevice>> _mypaymentUsersMeWalletDevicesPost({
    @Body() required WalletDeviceCreation? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new device for the user.
The user will need to activate it using a token sent by email.

**The user must be authenticated to use this endpoint**''',
      summary: 'Create User Devices',
      operationId: 'post_mypayment_users_me_wallet_devices',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get User Device
  ///@param wallet_device_id
  Future<chopper.Response<WalletDevice>>
  mypaymentUsersMeWalletDevicesWalletDeviceIdGet({
    required String? walletDeviceId,
  }) {
    generatedMapping.putIfAbsent(
      WalletDevice,
      () => WalletDevice.fromJsonFactory,
    );

    return _mypaymentUsersMeWalletDevicesWalletDeviceIdGet(
      walletDeviceId: walletDeviceId,
    );
  }

  ///Get User Device
  ///@param wallet_device_id
  @GET(path: '/mypayment/users/me/wallet/devices/{wallet_device_id}')
  Future<chopper.Response<WalletDevice>>
  _mypaymentUsersMeWalletDevicesWalletDeviceIdGet({
    @Path('wallet_device_id') required String? walletDeviceId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get user devices.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get User Device',
      operationId: 'get_mypayment_users_me_wallet_devices_{wallet_device_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get User Wallet
  Future<chopper.Response<Wallet>> mypaymentUsersMeWalletGet() {
    generatedMapping.putIfAbsent(Wallet, () => Wallet.fromJsonFactory);

    return _mypaymentUsersMeWalletGet();
  }

  ///Get User Wallet
  @GET(path: '/mypayment/users/me/wallet')
  Future<chopper.Response<Wallet>> _mypaymentUsersMeWalletGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get user wallet.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get User Wallet',
      operationId: 'get_mypayment_users_me_wallet',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Activate User Device
  ///@param token
  Future<chopper.Response> mypaymentDevicesActivateGet({
    required String? token,
  }) {
    return _mypaymentDevicesActivateGet(token: token);
  }

  ///Activate User Device
  ///@param token
  @GET(path: '/mypayment/devices/activate')
  Future<chopper.Response> _mypaymentDevicesActivateGet({
    @Query('token') required String? token,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Activate a wallet device',
      summary: 'Activate User Device',
      operationId: 'get_mypayment_devices_activate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Revoke User Devices
  ///@param wallet_device_id
  Future<chopper.Response>
  mypaymentUsersMeWalletDevicesWalletDeviceIdRevokePost({
    required String? walletDeviceId,
  }) {
    return _mypaymentUsersMeWalletDevicesWalletDeviceIdRevokePost(
      walletDeviceId: walletDeviceId,
    );
  }

  ///Revoke User Devices
  ///@param wallet_device_id
  @POST(
    path: '/mypayment/users/me/wallet/devices/{wallet_device_id}/revoke',
    optionalBody: true,
  )
  Future<chopper.Response>
  _mypaymentUsersMeWalletDevicesWalletDeviceIdRevokePost({
    @Path('wallet_device_id') required String? walletDeviceId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Revoke a device for the user.

**The user must be authenticated to use this endpoint**''',
      summary: 'Revoke User Devices',
      operationId:
          'post_mypayment_users_me_wallet_devices_{wallet_device_id}_revoke',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get User Wallet History
  ///@param start_date
  ///@param end_date
  Future<chopper.Response<List<History>>> mypaymentUsersMeWalletHistoryGet({
    String? startDate,
    String? endDate,
  }) {
    generatedMapping.putIfAbsent(History, () => History.fromJsonFactory);

    return _mypaymentUsersMeWalletHistoryGet(
      startDate: startDate,
      endDate: endDate,
    );
  }

  ///Get User Wallet History
  ///@param start_date
  ///@param end_date
  @GET(path: '/mypayment/users/me/wallet/history')
  Future<chopper.Response<List<History>>> _mypaymentUsersMeWalletHistoryGet({
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all transactions for the current user\'s wallet.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get User Wallet History',
      operationId: 'get_mypayment_users_me_wallet_history',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Init Ha Transfer
  Future<chopper.Response<PaymentUrl>> mypaymentTransferInitPost({
    required TransferInfo? body,
  }) {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _mypaymentTransferInitPost(body: body);
  }

  ///Init Ha Transfer
  @POST(path: '/mypayment/transfer/init', optionalBody: true)
  Future<chopper.Response<PaymentUrl>> _mypaymentTransferInitPost({
    @Body() required TransferInfo? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Initiate HelloAsso transfer, return a payment url to complete the transaction on HelloAsso website.',
      summary: 'Init Ha Transfer',
      operationId: 'post_mypayment_transfer_init',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Redirect From Ha Transfer
  ///@param url
  ///@param checkoutIntentId
  ///@param code
  ///@param orderId
  ///@param error
  Future<chopper.Response<PaymentUrl>> mypaymentTransferRedirectGet({
    required String? url,
    String? checkoutIntentId,
    String? code,
    String? orderId,
    String? error,
  }) {
    generatedMapping.putIfAbsent(PaymentUrl, () => PaymentUrl.fromJsonFactory);

    return _mypaymentTransferRedirectGet(
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
  @GET(path: '/mypayment/transfer/redirect')
  Future<chopper.Response<PaymentUrl>> _mypaymentTransferRedirectGet({
    @Query('url') required String? url,
    @Query('checkoutIntentId') String? checkoutIntentId,
    @Query('code') String? code,
    @Query('orderId') String? orderId,
    @Query('error') String? error,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''HelloAsso checkout should be configured to redirect the user to:
 - f"{settings.CLIENT_URL}mypayment/transfer/redirect?url={redirect_url}"
Redirect the user to the provided redirect `url`. The parameters `checkoutIntentId`, `code`, `orderId` and `error` passed by HelloAsso will be added to the redirect URL.
The redirect `url` must be trusted by Hyperion in the dotenv.''',
      summary: 'Redirect From Ha Transfer',
      operationId: 'get_mypayment_transfer_redirect',
      consumes: [],
      produces: [],
      security: [],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Validate Can Scan Qrcode
  ///@param store_id
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  mypaymentStoresStoreIdScanCheckPost({
    required String? storeId,
    required ScanInfo? body,
  }) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _mypaymentStoresStoreIdScanCheckPost(storeId: storeId, body: body);
  }

  ///Validate Can Scan Qrcode
  ///@param store_id
  @POST(path: '/mypayment/stores/{store_id}/scan/check', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _mypaymentStoresStoreIdScanCheckPost({
    @Path('store_id') required String? storeId,
    @Body() required ScanInfo? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Validate if a given QR Code can be scanned by the seller.

The QR Code should be valid, the seller should have the `can_bank` permission for this store,
and the debited wallet device should be active.

If the store structure has an association membership, the user should be a member of the association.

**The user must be authenticated to use this endpoint**''',
      summary: 'Validate Can Scan Qrcode',
      operationId: 'post_mypayment_stores_{store_id}_scan_check',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Store Scan Qrcode
  ///@param store_id
  Future<chopper.Response<History>> mypaymentStoresStoreIdScanPost({
    required String? storeId,
    required ScanInfo? body,
  }) {
    generatedMapping.putIfAbsent(History, () => History.fromJsonFactory);

    return _mypaymentStoresStoreIdScanPost(storeId: storeId, body: body);
  }

  ///Store Scan Qrcode
  ///@param store_id
  @POST(path: '/mypayment/stores/{store_id}/scan', optionalBody: true)
  Future<chopper.Response<History>> _mypaymentStoresStoreIdScanPost({
    @Path('store_id') required String? storeId,
    @Body() required ScanInfo? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Scan and bank a QR code for this store.

`signature` should be a base64 encoded string
 - signed using *ed25519*,
 - where data are a `QRCodeContentData` object:
    ```
    {
        id: UUID
        tot: int
        iat: datetime
        key: UUID
    }
    ```

The provided content is checked to ensure:
    - the QR Code is not already used
    - the QR Code is not expired
    - the QR Code is intended to be scanned for a store `scan_info.store`
    - the signature is valid and correspond to `wallet_device_id` public key
    - the debited\'s wallet device is active
    - the debited\'s Wallet balance greater than the QR Code total

**The user must be authenticated to use this endpoint**
**The user must have the `can_bank` permission for this store**''',
      summary: 'Store Scan Qrcode',
      operationId: 'post_mypayment_stores_{store_id}_scan',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Refund Transaction
  ///@param transaction_id
  Future<chopper.Response> mypaymentTransactionsTransactionIdRefundPost({
    required String? transactionId,
    required RefundInfo? body,
  }) {
    return _mypaymentTransactionsTransactionIdRefundPost(
      transactionId: transactionId,
      body: body,
    );
  }

  ///Refund Transaction
  ///@param transaction_id
  @POST(
    path: '/mypayment/transactions/{transaction_id}/refund',
    optionalBody: true,
  )
  Future<chopper.Response> _mypaymentTransactionsTransactionIdRefundPost({
    @Path('transaction_id') required String? transactionId,
    @Body() required RefundInfo? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Refund a transaction. Only transactions made in the last 30 days can be refunded.

Currently transactions between users are forbidden and can thus not be refunded.

To cancel a transaction made in the last 30 seconds, the endpoint `/mypayment/transactions/{transaction_id}/cancel` should be used.

**The user must either be the credited user or a seller with cancel permissions of the credited store of the transaction**''',
      summary: 'Refund Transaction',
      operationId: 'post_mypayment_transactions_{transaction_id}_refund',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Cancel Transaction
  ///@param transaction_id
  Future<chopper.Response> mypaymentTransactionsTransactionIdCancelPost({
    required String? transactionId,
  }) {
    return _mypaymentTransactionsTransactionIdCancelPost(
      transactionId: transactionId,
    );
  }

  ///Cancel Transaction
  ///@param transaction_id
  @POST(
    path: '/mypayment/transactions/{transaction_id}/cancel',
    optionalBody: true,
  )
  Future<chopper.Response> _mypaymentTransactionsTransactionIdCancelPost({
    @Path('transaction_id') required String? transactionId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Cancel a transaction.
A transaction can be canceled in the first 30 seconds after it has been created.

To refund an older transaction, use the `/mypayment/transactions/{transaction_id}/refund` endpoint.

**The user must either be the credited user or the seller of the transaction**''',
      summary: 'Cancel Transaction',
      operationId: 'post_mypayment_transactions_{transaction_id}_cancel',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get User Requests
  ///@param used
  Future<chopper.Response<List<Request$>>> mypaymentRequestsGet({bool? used}) {
    generatedMapping.putIfAbsent(Request$, () => Request$.fromJsonFactory);

    return _mypaymentRequestsGet(used: used);
  }

  ///Get User Requests
  ///@param used
  @GET(path: '/mypayment/requests')
  Future<chopper.Response<List<Request$>>> _mypaymentRequestsGet({
    @Query('used') bool? used,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all requests made by the user.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get User Requests',
      operationId: 'get_mypayment_requests',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Accept Request
  ///@param request_id
  Future<chopper.Response> mypaymentRequestsRequestIdAcceptPost({
    required String? requestId,
    required SignedContent? body,
  }) {
    return _mypaymentRequestsRequestIdAcceptPost(
      requestId: requestId,
      body: body,
    );
  }

  ///Accept Request
  ///@param request_id
  @POST(path: '/mypayment/requests/{request_id}/accept', optionalBody: true)
  Future<chopper.Response> _mypaymentRequestsRequestIdAcceptPost({
    @Path('request_id') required String? requestId,
    @Body() required SignedContent? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Confirm a request.

**The user must be authenticated to use this endpoint**''',
      summary: 'Accept Request',
      operationId: 'post_mypayment_requests_{request_id}_accept',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Refuse Request
  ///@param request_id
  Future<chopper.Response> mypaymentRequestsRequestIdRefusePost({
    required String? requestId,
  }) {
    return _mypaymentRequestsRequestIdRefusePost(requestId: requestId);
  }

  ///Refuse Request
  ///@param request_id
  @POST(path: '/mypayment/requests/{request_id}/refuse', optionalBody: true)
  Future<chopper.Response> _mypaymentRequestsRequestIdRefusePost({
    @Path('request_id') required String? requestId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Refuse a request.

**The user must be authenticated to use this endpoint**''',
      summary: 'Refuse Request',
      operationId: 'post_mypayment_requests_{request_id}_refuse',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get Invoices
  ///@param page
  ///@param page_size
  ///@param structures_ids
  ///@param start_date
  ///@param end_date
  Future<chopper.Response<List<Invoice>>> mypaymentInvoicesGet({
    int? page,
    int? pageSize,
    List? structuresIds,
    String? startDate,
    String? endDate,
  }) {
    generatedMapping.putIfAbsent(Invoice, () => Invoice.fromJsonFactory);

    return _mypaymentInvoicesGet(
      page: page,
      pageSize: pageSize,
      structuresIds: structuresIds,
      startDate: startDate,
      endDate: endDate,
    );
  }

  ///Get Invoices
  ///@param page
  ///@param page_size
  ///@param structures_ids
  ///@param start_date
  ///@param end_date
  @GET(path: '/mypayment/invoices')
  Future<chopper.Response<List<Invoice>>> _mypaymentInvoicesGet({
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('structures_ids') List? structuresIds,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all invoices.

**The user must be authenticated to use this endpoint**''',
      summary: 'Get Invoices',
      operationId: 'get_mypayment_invoices',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get Structure Invoices
  ///@param structure_id
  ///@param page
  ///@param page_size
  ///@param start_date
  ///@param end_date
  Future<chopper.Response<List<Invoice>>>
  mypaymentInvoicesStructuresStructureIdGet({
    required String? structureId,
    int? page,
    int? pageSize,
    String? startDate,
    String? endDate,
  }) {
    generatedMapping.putIfAbsent(Invoice, () => Invoice.fromJsonFactory);

    return _mypaymentInvoicesStructuresStructureIdGet(
      structureId: structureId,
      page: page,
      pageSize: pageSize,
      startDate: startDate,
      endDate: endDate,
    );
  }

  ///Get Structure Invoices
  ///@param structure_id
  ///@param page
  ///@param page_size
  ///@param start_date
  ///@param end_date
  @GET(path: '/mypayment/invoices/structures/{structure_id}')
  Future<chopper.Response<List<Invoice>>>
  _mypaymentInvoicesStructuresStructureIdGet({
    @Path('structure_id') required String? structureId,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get all invoices.

**The user must be the structure manager**''',
      summary: 'Get Structure Invoices',
      operationId: 'get_mypayment_invoices_structures_{structure_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Create Structure Invoice
  ///@param structure_id
  Future<chopper.Response<Invoice>> mypaymentInvoicesStructuresStructureIdPost({
    required String? structureId,
  }) {
    generatedMapping.putIfAbsent(Invoice, () => Invoice.fromJsonFactory);

    return _mypaymentInvoicesStructuresStructureIdPost(
      structureId: structureId,
    );
  }

  ///Create Structure Invoice
  ///@param structure_id
  @POST(
    path: '/mypayment/invoices/structures/{structure_id}',
    optionalBody: true,
  )
  Future<chopper.Response<Invoice>>
  _mypaymentInvoicesStructuresStructureIdPost({
    @Path('structure_id') required String? structureId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create an invoice for a structure.

**The user must be the bank account holder**''',
      summary: 'Create Structure Invoice',
      operationId: 'post_mypayment_invoices_structures_{structure_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Download Invoice
  ///@param invoice_id
  Future<chopper.Response> mypaymentInvoicesInvoiceIdGet({
    required String? invoiceId,
  }) {
    return _mypaymentInvoicesInvoiceIdGet(invoiceId: invoiceId);
  }

  ///Download Invoice
  ///@param invoice_id
  @GET(path: '/mypayment/invoices/{invoice_id}')
  Future<chopper.Response> _mypaymentInvoicesInvoiceIdGet({
    @Path('invoice_id') required String? invoiceId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Download Invoice',
      operationId: 'get_mypayment_invoices_{invoice_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Delete Structure Invoice
  ///@param invoice_id
  Future<chopper.Response> mypaymentInvoicesInvoiceIdDelete({
    required String? invoiceId,
  }) {
    return _mypaymentInvoicesInvoiceIdDelete(invoiceId: invoiceId);
  }

  ///Delete Structure Invoice
  ///@param invoice_id
  @DELETE(path: '/mypayment/invoices/{invoice_id}')
  Future<chopper.Response> _mypaymentInvoicesInvoiceIdDelete({
    @Path('invoice_id') required String? invoiceId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a structure invoice.

**The user must be the bank account holder**''',
      summary: 'Delete Structure Invoice',
      operationId: 'delete_mypayment_invoices_{invoice_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Update Invoice Paid Status
  ///@param invoice_id
  ///@param paid
  Future<chopper.Response> mypaymentInvoicesInvoiceIdPaidPatch({
    required String? invoiceId,
    required bool? paid,
  }) {
    return _mypaymentInvoicesInvoiceIdPaidPatch(
      invoiceId: invoiceId,
      paid: paid,
    );
  }

  ///Update Invoice Paid Status
  ///@param invoice_id
  ///@param paid
  @PATCH(path: '/mypayment/invoices/{invoice_id}/paid', optionalBody: true)
  Future<chopper.Response> _mypaymentInvoicesInvoiceIdPaidPatch({
    @Path('invoice_id') required String? invoiceId,
    @Query('paid') required bool? paid,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update the paid status of a structure invoice.

**The user must be the bank account holder**''',
      summary: 'Update Invoice Paid Status',
      operationId: 'patch_mypayment_invoices_{invoice_id}_paid',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Aknowledge Invoice As Received
  ///@param invoice_id
  Future<chopper.Response> mypaymentInvoicesInvoiceIdReceivedPatch({
    required String? invoiceId,
  }) {
    return _mypaymentInvoicesInvoiceIdReceivedPatch(invoiceId: invoiceId);
  }

  ///Aknowledge Invoice As Received
  ///@param invoice_id
  @PATCH(path: '/mypayment/invoices/{invoice_id}/received', optionalBody: true)
  Future<chopper.Response> _mypaymentInvoicesInvoiceIdReceivedPatch({
    @Path('invoice_id') required String? invoiceId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update the received status of a structure invoice.

**The user must be the structure manager**''',
      summary: 'Aknowledge Invoice As Received',
      operationId: 'patch_mypayment_invoices_{invoice_id}_received',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get Data For Integrity Check
  ///@param lastChecked
  ///@param isInitialisation
  ///@param x_data_verifier_token
  Future<chopper.Response<IntegrityCheckData>> mypaymentIntegrityCheckGet({
    String? lastChecked,
    bool? isInitialisation,
    String? xDataVerifierToken,
  }) {
    generatedMapping.putIfAbsent(
      IntegrityCheckData,
      () => IntegrityCheckData.fromJsonFactory,
    );

    return _mypaymentIntegrityCheckGet(
      lastChecked: lastChecked,
      isInitialisation: isInitialisation,
      xDataVerifierToken: xDataVerifierToken?.toString(),
    );
  }

  ///Get Data For Integrity Check
  ///@param lastChecked
  ///@param isInitialisation
  ///@param x_data_verifier_token
  @GET(path: '/mypayment/integrity-check')
  Future<chopper.Response<IntegrityCheckData>> _mypaymentIntegrityCheckGet({
    @Query('lastChecked') String? lastChecked,
    @Query('isInitialisation') bool? isInitialisation,
    @Header('x_data_verifier_token') String? xDataVerifierToken,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Send all the MyPayment data for integrity check.
Data includes:
- Wallets deducted of the last 30 seconds transactions
- Transactions with at least 30 seconds delay
- Transfers
- Refunds

**The header must contain the MYPAYMENT_DATA_VERIFIER_ACCESS_TOKEN defined in the settings in the `x-data-verifier-token` field**''',
      summary: 'Get Data For Integrity Check',
      operationId: 'get_mypayment_integrity-check',
      consumes: [],
      produces: [],
      security: [],
      tags: ["MyPayment"],
      deprecated: false,
    ),
  });

  ///Get Published News
  Future<chopper.Response<List<News>>> feedNewsGet() {
    generatedMapping.putIfAbsent(News, () => News.fromJsonFactory);

    return _feedNewsGet();
  }

  ///Get Published News
  @GET(path: '/feed/news')
  Future<chopper.Response<List<News>>> _feedNewsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return published news from the feed',
      summary: 'Get Published News',
      operationId: 'get_feed_news',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Feed"],
      deprecated: false,
    ),
  });

  ///Get News Image
  ///@param news_id
  Future<chopper.Response> feedNewsNewsIdImageGet({required String? newsId}) {
    return _feedNewsNewsIdImageGet(newsId: newsId);
  }

  ///Get News Image
  ///@param news_id
  @GET(path: '/feed/news/{news_id}/image')
  Future<chopper.Response> _feedNewsNewsIdImageGet({
    @Path('news_id') required String? newsId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return the image of a news',
      summary: 'Get News Image',
      operationId: 'get_feed_news_{news_id}_image',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Feed"],
      deprecated: false,
    ),
  });

  ///Get Admin News
  Future<chopper.Response<List<News>>> feedAdminNewsGet() {
    generatedMapping.putIfAbsent(News, () => News.fromJsonFactory);

    return _feedAdminNewsGet();
  }

  ///Get Admin News
  @GET(path: '/feed/admin/news')
  Future<chopper.Response<List<News>>> _feedAdminNewsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return news from the feed

**This endpoint is only usable by feed administrators**''',
      summary: 'Get Admin News',
      operationId: 'get_feed_admin_news',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Feed"],
      deprecated: false,
    ),
  });

  ///Approve News
  ///@param news_id
  Future<chopper.Response> feedAdminNewsNewsIdApprovePost({
    required String? newsId,
  }) {
    return _feedAdminNewsNewsIdApprovePost(newsId: newsId);
  }

  ///Approve News
  ///@param news_id
  @POST(path: '/feed/admin/news/{news_id}/approve', optionalBody: true)
  Future<chopper.Response> _feedAdminNewsNewsIdApprovePost({
    @Path('news_id') required String? newsId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Approve a news

**This endpoint is only usable by feed administrators**''',
      summary: 'Approve News',
      operationId: 'post_feed_admin_news_{news_id}_approve',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Feed"],
      deprecated: false,
    ),
  });

  ///Reject News
  ///@param news_id
  Future<chopper.Response> feedAdminNewsNewsIdRejectPost({
    required String? newsId,
  }) {
    return _feedAdminNewsNewsIdRejectPost(newsId: newsId);
  }

  ///Reject News
  ///@param news_id
  @POST(path: '/feed/admin/news/{news_id}/reject', optionalBody: true)
  Future<chopper.Response> _feedAdminNewsNewsIdRejectPost({
    @Path('news_id') required String? newsId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Reject a news

**This endpoint is only usable by feed administrators**''',
      summary: 'Reject News',
      operationId: 'post_feed_admin_news_{news_id}_reject',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Feed"],
      deprecated: false,
    ),
  });

  ///Read Associations Memberships
  Future<chopper.Response<List<MembershipSimple>>> membershipsGet() {
    generatedMapping.putIfAbsent(
      MembershipSimple,
      () => MembershipSimple.fromJsonFactory,
    );

    return _membershipsGet();
  }

  ///Read Associations Memberships
  @GET(path: '/memberships/')
  Future<chopper.Response<List<MembershipSimple>>> _membershipsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Return all memberships from database as a list of dictionaries',
      summary: 'Read Associations Memberships',
      operationId: 'get_memberships_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @POST(path: '/memberships/', optionalBody: true)
  Future<chopper.Response<MembershipSimple>> _membershipsPost({
    @Body() required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new membership.

**This endpoint is only usable by administrators**''',
      summary: 'Create Association Membership',
      operationId: 'post_memberships_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @GET(path: '/memberships/{association_membership_id}/members')
  Future<chopper.Response<List<UserMembershipComplete>>>
  _membershipsAssociationMembershipIdMembersGet({
    @Path('association_membership_id') required String? associationMembershipId,
    @Query('minimalStartDate') String? minimalStartDate,
    @Query('maximalStartDate') String? maximalStartDate,
    @Query('minimalEndDate') String? minimalEndDate,
    @Query('maximalEndDate') String? maximalEndDate,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return membership with the given ID.

**This endpoint is only usable by ECL members**''',
      summary: 'Read Association Membership',
      operationId: 'get_memberships_{association_membership_id}_members',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @PATCH(path: '/memberships/{association_membership_id}', optionalBody: true)
  Future<chopper.Response> _membershipsAssociationMembershipIdPatch({
    @Path('association_membership_id') required String? associationMembershipId,
    @Body() required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a membership.

**This endpoint is only usable by administrators**''',
      summary: 'Update Association Membership',
      operationId: 'patch_memberships_{association_membership_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @DELETE(path: '/memberships/{association_membership_id}')
  Future<chopper.Response> _membershipsAssociationMembershipIdDelete({
    @Path('association_membership_id') required String? associationMembershipId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a membership.

**This endpoint is only usable by administrators**''',
      summary: 'Delete Association Membership',
      operationId: 'delete_memberships_{association_membership_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @GET(path: '/memberships/users/{user_id}')
  Future<chopper.Response<List<UserMembershipComplete>>>
  _membershipsUsersUserIdGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all memberships for a user.',
      summary: 'Read User Memberships',
      operationId: 'get_memberships_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/memberships/users/{user_id}', optionalBody: true)
  Future<chopper.Response<UserMembershipComplete>> _membershipsUsersUserIdPost({
    @Path('user_id') required String? userId,
    @Body() required UserMembershipBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Create a new user membership.

**This endpoint is only usable by administrators and membership managers**''',
      summary: 'Create User Membership',
      operationId: 'post_memberships_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @GET(path: '/memberships/users/{user_id}/{association_membership_id}')
  Future<chopper.Response<List<UserMembershipComplete>>>
  _membershipsUsersUserIdAssociationMembershipIdGet({
    @Path('user_id') required String? userId,
    @Path('association_membership_id') required String? associationMembershipId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Return all user memberships for a specific association membership for a user.

**This endpoint is only usable by administrators and membership managers**''',
      summary: 'Read User Association Membership History',
      operationId:
          'get_memberships_users_{user_id}_{association_membership_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @POST(
    path: '/memberships/{association_membership_id}/add-batch/',
    optionalBody: true,
  )
  Future<chopper.Response<List<MembershipUserMappingEmail>>>
  _membershipsAssociationMembershipIdAddBatchPost({
    @Path('association_membership_id') required String? associationMembershipId,
    @Body() required List<MembershipUserMappingEmail>? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Add a batch of user to a membership.

Return the list of unknown users whose email is not in the database.

**User must be an administrator or a membership manager to use this endpoint.**''',
      summary: 'Add Batch Membership',
      operationId: 'post_memberships_{association_membership_id}_add-batch_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @PATCH(path: '/memberships/users/{membership_id}', optionalBody: true)
  Future<chopper.Response> _membershipsUsersMembershipIdPatch({
    @Path('membership_id') required String? membershipId,
    @Body() required UserMembershipEdit? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update a user membership.

**This endpoint is only usable by administrators and membership managers**''',
      summary: 'Update User Membership',
      operationId: 'patch_memberships_users_{membership_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
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
  @DELETE(path: '/memberships/users/{membership_id}')
  Future<chopper.Response> _membershipsUsersMembershipIdDelete({
    @Path('membership_id') required String? membershipId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete a user membership.

**This endpoint is only usable by administrators and membership managers**''',
      summary: 'Delete User Membership',
      operationId: 'delete_memberships_users_{membership_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
  });

  ///Synchronize Membership With Group
  ///@param membership_id
  ///@param group_id
  Future<chopper.Response> membershipsMembershipIdGroupGroupIdSynchronizePost({
    required String? membershipId,
    required String? groupId,
  }) {
    return _membershipsMembershipIdGroupGroupIdSynchronizePost(
      membershipId: membershipId,
      groupId: groupId,
    );
  }

  ///Synchronize Membership With Group
  ///@param membership_id
  ///@param group_id
  @POST(
    path: '/memberships/{membership_id}/group/{group_id}/synchronize',
    optionalBody: true,
  )
  Future<chopper.Response> _membershipsMembershipIdGroupGroupIdSynchronizePost({
    @Path('membership_id') required String? membershipId,
    @Path('group_id') required String? groupId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Synchronize a membership with a group.

**This endpoint is only usable by administrators**''',
      summary: 'Synchronize Membership With Group',
      operationId:
          'post_memberships_{membership_id}_group_{group_id}_synchronize',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Memberships"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/users')
  Future<chopper.Response<List<CoreUserSimple>>> _usersGet({
    @Query('accountTypes') List<Object?>? accountTypes,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Return all users from database as a list of `CoreUserSimple`

**This endpoint is only usable by administrators**''',
      summary: 'Read Users',
      operationId: 'get_users',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Count Users
  Future<chopper.Response<int>> usersCountGet() {
    return _usersCountGet();
  }

  ///Count Users
  @GET(path: '/users/count')
  Future<chopper.Response<int>> _usersCountGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return the number of users in the database

**This endpoint is only usable by administrators**''',
      summary: 'Count Users',
      operationId: 'get_users_count',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

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
  @GET(path: '/users/search')
  Future<chopper.Response<List<CoreUserSimple>>> _usersSearchGet({
    @Query('query') required String? query,
    @Query('includedAccountTypes') List<Object?>? includedAccountTypes,
    @Query('excludedAccountTypes') List<Object?>? excludedAccountTypes,
    @Query('includedGroups') List<String>? includedGroups,
    @Query('excludedGroups') List<String>? excludedGroups,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Search for a user using Jaro_Winkler distance algorithm.
The `query` will be compared against users name, firstname and nickname.
Assume that `query` is the beginning of a name, so we can capitalize words to improve results.

**The user must be authenticated to use this endpoint**''',
      summary: 'Search Users',
      operationId: 'get_users_search',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Get Account Types
  Future<chopper.Response<List<enums.AccountType>>> usersAccountTypesGet() {
    return _usersAccountTypesGet();
  }

  ///Get Account Types
  @GET(path: '/users/account-types/')
  Future<chopper.Response<List<enums.AccountType>>> _usersAccountTypesGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all account types hardcoded in the system',
      summary: 'Get Account Types',
      operationId: 'get_users_account-types_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Read Current User
  Future<chopper.Response<CoreUser>> usersMeGet() {
    generatedMapping.putIfAbsent(CoreUser, () => CoreUser.fromJsonFactory);

    return _usersMeGet();
  }

  ///Read Current User
  @GET(path: '/users/me')
  Future<chopper.Response<CoreUser>> _usersMeGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return `CoreUser` representation of current user

**The user must be authenticated to use this endpoint**''',
      summary: 'Read Current User',
      operationId: 'get_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Update Current User
  Future<chopper.Response> usersMePatch({required CoreUserUpdate? body}) {
    return _usersMePatch(body: body);
  }

  ///Update Current User
  @PATCH(path: '/users/me', optionalBody: true)
  Future<chopper.Response> _usersMePatch({
    @Body() required CoreUserUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Update the current user, the request should contain a JSON with the fields to change (not necessarily all fields) and their new value

**The user must be authenticated to use this endpoint**''',
      summary: 'Update Current User',
      operationId: 'patch_users_me',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
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
  @POST(path: '/users/create', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>> _usersCreatePost({
    @Body() required CoreUserCreateRequest? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Start the user account creation process. The user will be sent an email with a link to activate his account.
> The received token needs to be sent to the `/users/activate` endpoint to activate the account.

If the **password** is not provided, it will be required during the activation process. Don\'t submit a password if you are creating an account for someone else.

When creating **student** or **staff** account a valid ECL email is required.
Only admin users can create other **account types**, contact ÉCLAIR for more information.''',
      summary: 'Create User By User',
      operationId: 'post_users_create',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Users"],
      deprecated: false,
    ),
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
  @POST(path: '/users/batch-creation', optionalBody: true)
  Future<chopper.Response<BatchResult>> _usersBatchCreationPost({
    @Body() required List<CoreBatchUserCreateRequest>? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Batch user account creation process. All users will be sent an email with a link to activate their account.
> The received token needs to be send to `/users/activate` endpoint to activate the account.

Even for creating **student** or **staff** account a valid ECL email is not required but should preferably be used.

The endpoint return a dictionary of unsuccessful user creation: `{email: error message}`.

NOTE: the activation link will only be valid for a limited time. You should probably use `/users/batch-invitation` endpoint instead, which will send an invitation email to the user.

**This endpoint is only usable by administrators**''',
      summary: 'Batch Create Users',
      operationId: 'post_users_batch-creation',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Batch Invite Users
  Future<chopper.Response<BatchResult>> usersBatchInvitationPost({
    required List<CoreBatchUserCreateRequest>? body,
  }) {
    generatedMapping.putIfAbsent(
      BatchResult,
      () => BatchResult.fromJsonFactory,
    );

    return _usersBatchInvitationPost(body: body);
  }

  ///Batch Invite Users
  @POST(path: '/users/batch-invitation', optionalBody: true)
  Future<chopper.Response<BatchResult>> _usersBatchInvitationPost({
    @Body() required List<CoreBatchUserCreateRequest>? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Batch user account invitation process. All users will be sent an email encouraging them to create an account.
These emails will be whitelisted in Hyperion. If self registration is disabled only whitelisted emails will be able to create an account.

The endpoint return a dictionary of unsuccessful user creation: `{email: error message}`.

**This endpoint is only usable by administrators**''',
      summary: 'Batch Invite Users',
      operationId: 'post_users_batch-invitation',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
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
  @POST(path: '/users/activate', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>> _usersActivatePost({
    @Body() required CoreUserActivateRequest? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Activate the previously created account.

**token**: the activation token sent by email to the user

**password**: user password, required if it was not provided previously''',
      summary: 'Activate User',
      operationId: 'post_users_activate',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Init S3 For Users
  Future<chopper.Response> usersS3InitPost() {
    return _usersS3InitPost();
  }

  ///Init S3 For Users
  @POST(path: '/users/s3-init', optionalBody: true)
  Future<chopper.Response> _usersS3InitPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint is used to initialize the S3 bucket for users.
It will create a file for each existing user in the S3 bucket.
It should be used only once, when the S3 bucket is created.''',
      summary: 'Init S3 For Users',
      operationId: 'post_users_s3-init',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

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
  @POST(path: '/users/recover', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>> _usersRecoverPost({
    @Body() required BodyRecoverUserUsersRecoverPost? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Allow a user to start a password reset process.

If the provided **email** corresponds to an existing account, a password reset token will be sent.
Using this token, the password can be changed with `/users/reset-password` endpoint''',
      summary: 'Recover User',
      operationId: 'post_users_recover',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Users"],
      deprecated: false,
    ),
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
  @POST(path: '/users/reset-password', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _usersResetPasswordPost({
    @Body() required ResetPasswordRequest? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Reset the user password, using a **reset_token** provided by `/users/recover` endpoint.',
      summary: 'Reset Password',
      operationId: 'post_users_reset-password',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Migrate Mail
  Future<chopper.Response> usersMigrateMailPost({
    required MailMigrationRequest? body,
  }) {
    return _usersMigrateMailPost(body: body);
  }

  ///Migrate Mail
  @POST(path: '/users/migrate-mail', optionalBody: true)
  Future<chopper.Response> _usersMigrateMailPost({
    @Body() required MailMigrationRequest? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'This endpoint will send a confirmation code to the user\'s new email address. He will need to use this code to confirm the change with `/users/confirm-mail-migration` endpoint.',
      summary: 'Migrate Mail',
      operationId: 'post_users_migrate-mail',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
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
  @GET(path: '/users/migrate-mail-confirm')
  Future<chopper.Response> _usersMigrateMailConfirmGet({
    @Query('token') required String? token,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''This endpoint will updates the user new email address.
The user will need to use the confirmation code sent by the `/users/migrate-mail` endpoint.''',
      summary: 'Migrate Mail Confirm',
      operationId: 'get_users_migrate-mail-confirm',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Users"],
      deprecated: false,
    ),
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
  @POST(path: '/users/change-password', optionalBody: true)
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _usersChangePasswordPost({
    @Body() required ChangePasswordRequest? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Change a user password.

This endpoint will check the **old_password**, see also the `/users/reset-password` endpoint if the user forgot their password.''',
      summary: 'Change Password',
      operationId: 'post_users_change-password',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Read User
  ///@param user_id
  Future<chopper.Response<CoreUser>> usersUserIdGet({required String? userId}) {
    generatedMapping.putIfAbsent(CoreUser, () => CoreUser.fromJsonFactory);

    return _usersUserIdGet(userId: userId);
  }

  ///Read User
  ///@param user_id
  @GET(path: '/users/{user_id}')
  Future<chopper.Response<CoreUser>> _usersUserIdGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return `CoreUser` representation of user with id `user_id`

**The user must be authenticated to use this endpoint**''',
      summary: 'Read User',
      operationId: 'get_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
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
  @PATCH(path: '/users/{user_id}', optionalBody: true)
  Future<chopper.Response> _usersUserIdPatch({
    @Path('user_id') required String? userId,
    @Body() required CoreUserUpdateAdmin? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Update an user, the request should contain a JSON with the fields to change (not necessarily all fields) and their new value

**This endpoint is only usable by administrators**''',
      summary: 'Update User',
      operationId: 'patch_users_{user_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Delete User
  Future<chopper.Response> usersMeAskDeletionPost() {
    return _usersMeAskDeletionPost();
  }

  ///Delete User
  @POST(path: '/users/me/ask-deletion', optionalBody: true)
  Future<chopper.Response> _usersMeAskDeletionPost({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint will ask administrators to process to the user deletion.
This manual verification is needed to prevent data from being deleting for other users''',
      summary: 'Delete User',
      operationId: 'post_users_me_ask-deletion',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Merge Users
  Future<chopper.Response> usersMergePost({
    required CoreUserFusionRequest? body,
  }) {
    return _usersMergePost(body: body);
  }

  ///Merge Users
  @POST(path: '/users/merge', optionalBody: true)
  Future<chopper.Response> _usersMergePost({
    @Body() required CoreUserFusionRequest? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          'Fusion two users into one. The first user will be deleted and its data will be transferred to the second user.',
      summary: 'Merge Users',
      operationId: 'post_users_merge',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Update User As Super Admin
  ///@param user_id
  Future<chopper.Response> usersUserIdSuperAdminPatch({
    required String? userId,
  }) {
    return _usersUserIdSuperAdminPatch(userId: userId);
  }

  ///Update User As Super Admin
  ///@param user_id
  @PATCH(path: '/users/{user_id}/super-admin', optionalBody: true)
  Future<chopper.Response> _usersUserIdSuperAdminPatch({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Update an user, the request should contain a JSON with the fields to change (not necessarily all fields) and their new value

**This endpoint is only usable by administrators**''',
      summary: 'Update User As Super Admin',
      operationId: 'patch_users_{user_id}_super-admin',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Read Own Profile Picture
  Future<chopper.Response> usersMeProfilePictureGet() {
    return _usersMeProfilePictureGet();
  }

  ///Read Own Profile Picture
  @GET(path: '/users/me/profile-picture')
  Future<chopper.Response> _usersMeProfilePictureGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Get the profile picture of the authenticated user.',
      summary: 'Read Own Profile Picture',
      operationId: 'get_users_me_profile-picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Create Current User Profile Picture
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  usersMeProfilePicturePost({required List<int> image}) {
    generatedMapping.putIfAbsent(
      AppTypesStandardResponsesResult,
      () => AppTypesStandardResponsesResult.fromJsonFactory,
    );

    return _usersMeProfilePicturePost(image: image);
  }

  ///Create Current User Profile Picture
  @POST(path: '/users/me/profile-picture', optionalBody: true)
  @Multipart()
  Future<chopper.Response<AppTypesStandardResponsesResult>>
  _usersMeProfilePicturePost({
    @PartFile('image') required List<int> image,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Upload a profile picture for the current user.

**The user must be authenticated to use this endpoint**''',
      summary: 'Create Current User Profile Picture',
      operationId: 'post_users_me_profile-picture',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Read User Profile Picture
  ///@param user_id
  Future<chopper.Response> usersUserIdProfilePictureGet({
    required String? userId,
  }) {
    return _usersUserIdProfilePictureGet(userId: userId);
  }

  ///Read User Profile Picture
  ///@param user_id
  @GET(path: '/users/{user_id}/profile-picture')
  Future<chopper.Response> _usersUserIdProfilePictureGet({
    @Path('user_id') required String? userId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Get the profile picture of an user.

Unauthenticated users can use this endpoint (needed for some OIDC services)''',
      summary: 'Read User Profile Picture',
      operationId: 'get_users_{user_id}_profile-picture',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Users"],
      deprecated: false,
    ),
  });

  ///Read Schools
  Future<chopper.Response<List<CoreSchool>>> schoolsGet() {
    generatedMapping.putIfAbsent(CoreSchool, () => CoreSchool.fromJsonFactory);

    return _schoolsGet();
  }

  ///Read Schools
  @GET(path: '/schools/')
  Future<chopper.Response<List<CoreSchool>>> _schoolsGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Return all schools from database as a list of dictionaries',
      summary: 'Read Schools',
      operationId: 'get_schools_',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Schools"],
      deprecated: false,
    ),
  });

  ///Create School
  Future<chopper.Response<CoreSchool>> schoolsPost({
    required CoreSchoolBase? body,
  }) {
    generatedMapping.putIfAbsent(CoreSchool, () => CoreSchool.fromJsonFactory);

    return _schoolsPost(body: body);
  }

  ///Create School
  @POST(path: '/schools/', optionalBody: true)
  Future<chopper.Response<CoreSchool>> _schoolsPost({
    @Body() required CoreSchoolBase? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Create a new school and add users to it based on the email regex.

**This endpoint is only usable by administrators**''',
      summary: 'Create School',
      operationId: 'post_schools_',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Schools"],
      deprecated: false,
    ),
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
  @GET(path: '/schools/{school_id}')
  Future<chopper.Response<CoreSchool>> _schoolsSchoolIdGet({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Return school with id from database as a dictionary.

**This endpoint is only usable by administrators**''',
      summary: 'Read School',
      operationId: 'get_schools_{school_id}',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Schools"],
      deprecated: false,
    ),
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
  @PATCH(path: '/schools/{school_id}', optionalBody: true)
  Future<chopper.Response> _schoolsSchoolIdPatch({
    @Path('school_id') required String? schoolId,
    @Body() required CoreSchoolUpdate? body,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Update the name or the description of a school.

**This endpoint is only usable by administrators**''',
      summary: 'Update School',
      operationId: 'patch_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Schools"],
      deprecated: false,
    ),
  });

  ///Delete School
  ///@param school_id
  Future<chopper.Response> schoolsSchoolIdDelete({required String? schoolId}) {
    return _schoolsSchoolIdDelete(schoolId: schoolId);
  }

  ///Delete School
  ///@param school_id
  @DELETE(path: '/schools/{school_id}')
  Future<chopper.Response> _schoolsSchoolIdDelete({
    @Path('school_id') required String? schoolId,
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Delete school from database.
This will remove the school from all users but won\'t delete any user.

`SchoolTypes` schools can not be deleted.

**This endpoint is only usable by administrators**''',
      summary: 'Delete School',
      operationId: 'delete_schools_{school_id}',
      consumes: [],
      produces: [],
      security: ["AuthorizationCodeAuthentication"],
      tags: ["Schools"],
      deprecated: false,
    ),
  });

  ///Google Api Callback
  Future<chopper.Response> googleApiOauth2callbackGet() {
    return _googleApiOauth2callbackGet();
  }

  ///Google Api Callback
  @GET(path: '/google-api/oauth2callback')
  Future<chopper.Response> _googleApiOauth2callbackGet({
    @chopper.Tag()
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Google Api Callback',
      operationId: 'get_google-api_oauth2callback',
      consumes: [],
      produces: [],
      security: [],
      tags: ["GoogleAPI"],
      deprecated: false,
    ),
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
