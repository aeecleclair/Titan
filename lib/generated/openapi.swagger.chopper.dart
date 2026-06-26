// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
  Future<Response<List<Recommendation>>> _recommendationRecommendationsGet({
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
  }) {
    final Uri $url = Uri.parse('/recommendation/recommendations');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Recommendation>, Recommendation>($request);
  }

  @override
  Future<Response<Recommendation>> _recommendationRecommendationsPost({
    required RecommendationBase? body,
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
  }) {
    final Uri $url = Uri.parse('/recommendation/recommendations');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Recommendation, Recommendation>($request);
  }

  @override
  Future<Response<dynamic>>
  _recommendationRecommendationsRecommendationIdPatch({
    required String? recommendationId,
    required RecommendationEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/recommendation/recommendations/${recommendationId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _recommendationRecommendationsRecommendationIdDelete({
    required String? recommendationId,
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
  }) {
    final Uri $url = Uri.parse(
      '/recommendation/recommendations/${recommendationId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _recommendationRecommendationsRecommendationIdPictureGet({
    required String? recommendationId,
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
  }) {
    final Uri $url = Uri.parse(
      '/recommendation/recommendations/${recommendationId}/picture',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
  _recommendationRecommendationsRecommendationIdPicturePost({
    required String? recommendationId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse(
      '/recommendation/recommendations/${recommendationId}/picture',
    );
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<List<Loaner>>> _loansLoanersGet({
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Loaner>, Loaner>($request);
  }

  @override
  Future<Response<Loaner>> _loansLoanersPost({
    required LoanerBase? body,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Loaner, Loaner>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdDelete({
    required String? loanerId,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdPatch({
    required String? loanerId,
    required LoanerUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Loan>>> _loansLoanersLoanerIdLoansGet({
    required String? loanerId,
    bool? returned,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/loans');
    final Map<String, dynamic> $params = <String, dynamic>{
      'returned': returned,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<Loan>, Loan>($request);
  }

  @override
  Future<Response<List<Item>>> _loansLoanersLoanerIdItemsGet({
    required String? loanerId,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Item>, Item>($request);
  }

  @override
  Future<Response<Item>> _loansLoanersLoanerIdItemsPost({
    required String? loanerId,
    required ItemBase? body,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Item, Item>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdItemsItemIdPatch({
    required String? loanerId,
    required String? itemId,
    required ItemUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items/${itemId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanersLoanerIdItemsItemIdDelete({
    required String? loanerId,
    required String? itemId,
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
  }) {
    final Uri $url = Uri.parse('/loans/loaners/${loanerId}/items/${itemId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Loan>>> _loansUsersMeGet({
    bool? returned,
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
  }) {
    final Uri $url = Uri.parse('/loans/users/me');
    final Map<String, dynamic> $params = <String, dynamic>{
      'returned': returned,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<Loan>, Loan>($request);
  }

  @override
  Future<Response<List<Loaner>>> _loansUsersMeLoanersGet({
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
  }) {
    final Uri $url = Uri.parse('/loans/users/me/loaners');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Loaner>, Loaner>($request);
  }

  @override
  Future<Response<Loan>> _loansPost({
    required LoanCreation? body,
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
  }) {
    final Uri $url = Uri.parse('/loans/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Loan, Loan>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdPatch({
    required String? loanId,
    required LoanUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/loans/${loanId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdDelete({
    required String? loanId,
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
  }) {
    final Uri $url = Uri.parse('/loans/${loanId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdReturnPost({
    required String? loanId,
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
  }) {
    final Uri $url = Uri.parse('/loans/${loanId}/return');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _loansLoanIdExtendPost({
    required String? loanId,
    required LoanExtend? body,
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
  }) {
    final Uri $url = Uri.parse('/loans/${loanId}/extend');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<EventCompleteTicketUrl>>> _calendarEventsGet({
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<EventCompleteTicketUrl>, EventCompleteTicketUrl>(
      $request,
    );
  }

  @override
  Future<Response<EventCompleteTicketUrl>> _calendarEventsPost({
    required EventBaseCreation? body,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<EventCompleteTicketUrl, EventCompleteTicketUrl>(
      $request,
    );
  }

  @override
  Future<Response<List<EventCompleteTicketUrl>>> _calendarEventsConfirmedGet({
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/confirmed');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<EventCompleteTicketUrl>, EventCompleteTicketUrl>(
      $request,
    );
  }

  @override
  Future<Response<List<EventCompleteTicketUrl>>>
  _calendarEventsAssociationsAssociationIdGet({
    required String? associationId,
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
  }) {
    final Uri $url = Uri.parse(
      '/calendar/events/associations/${associationId}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<EventCompleteTicketUrl>, EventCompleteTicketUrl>(
      $request,
    );
  }

  @override
  Future<Response<EventCompleteTicketUrl>> _calendarEventsEventIdGet({
    required String? eventId,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<EventCompleteTicketUrl, EventCompleteTicketUrl>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdPatch({
    required String? eventId,
    required EventEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdDelete({
    required Object? eventId,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EventTicketUrl>> _calendarEventsEventIdTicketUrlGet({
    required String? eventId,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}/ticket-url');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<EventTicketUrl, EventTicketUrl>($request);
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdImageGet({
    required String? eventId,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}/image');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdImagePost({
    required String? eventId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}/image');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _calendarEventsEventIdReplyDecisionPatch({
    required String? eventId,
    required String? decision,
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
  }) {
    final Uri $url = Uri.parse('/calendar/events/${eventId}/reply/${decision}');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<IcalSecret>> _calendarIcalUrlGet({
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
  }) {
    final Uri $url = Uri.parse('/calendar/ical-url');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<IcalSecret, IcalSecret>($request);
  }

  @override
  Future<Response<dynamic>> _calendarIcalCreatePost({
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
  }) {
    final Uri $url = Uri.parse('/calendar/ical/create');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _calendarIcalGet({
    required String? secret,
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
  }) {
    final Uri $url = Uri.parse('/calendar/ical');
    final Map<String, dynamic> $params = <String, dynamic>{'secret': secret};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TheMovieDB>> _cinemaThemoviedbThemoviedbIdGet({
    required String? themoviedbId,
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
  }) {
    final Uri $url = Uri.parse('/cinema/themoviedb/${themoviedbId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<TheMovieDB, TheMovieDB>($request);
  }

  @override
  Future<Response<List<CineSessionComplete>>> _cinemaSessionsGet({
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
  }) {
    final Uri $url = Uri.parse('/cinema/sessions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CineSessionComplete>, CineSessionComplete>(
      $request,
    );
  }

  @override
  Future<Response<CineSessionComplete>> _cinemaSessionsPost({
    required CineSessionBase? body,
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
  }) {
    final Uri $url = Uri.parse('/cinema/sessions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CineSessionComplete, CineSessionComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cinemaSessionsSessionIdPatch({
    required String? sessionId,
    required CineSessionUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cinemaSessionsSessionIdDelete({
    required String? sessionId,
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
  }) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
  _cinemaSessionsSessionIdPosterPost({
    required String? sessionId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}/poster');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _cinemaSessionsSessionIdPosterGet({
    required String? sessionId,
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
  }) {
    final Uri $url = Uri.parse('/cinema/sessions/${sessionId}/poster');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Manager>>> _bookingManagersGet({
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
  }) {
    final Uri $url = Uri.parse('/booking/managers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Manager>, Manager>($request);
  }

  @override
  Future<Response<Manager>> _bookingManagersPost({
    required ManagerBase? body,
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
  }) {
    final Uri $url = Uri.parse('/booking/managers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Manager, Manager>($request);
  }

  @override
  Future<Response<dynamic>> _bookingManagersManagerIdPatch({
    required String? managerId,
    required ManagerUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/booking/managers/${managerId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingManagersManagerIdDelete({
    required String? managerId,
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
  }) {
    final Uri $url = Uri.parse('/booking/managers/${managerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Manager>>> _bookingManagersUsersMeGet({
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
  }) {
    final Uri $url = Uri.parse('/booking/managers/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Manager>, Manager>($request);
  }

  @override
  Future<Response<List<BookingReturnApplicant>>>
  _bookingBookingsUsersMeManageGet({
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
  }) {
    final Uri $url = Uri.parse('/booking/bookings/users/me/manage');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<BookingReturnApplicant>, BookingReturnApplicant>(
      $request,
    );
  }

  @override
  Future<Response<List<BookingReturnApplicant>>>
  _bookingBookingsConfirmedUsersMeManageGet({
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
  }) {
    final Uri $url = Uri.parse('/booking/bookings/confirmed/users/me/manage');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<BookingReturnApplicant>, BookingReturnApplicant>(
      $request,
    );
  }

  @override
  Future<Response<List<BookingReturnSimpleApplicant>>>
  _bookingBookingsConfirmedGet({
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
  }) {
    final Uri $url = Uri.parse('/booking/bookings/confirmed');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client
        .send<List<BookingReturnSimpleApplicant>, BookingReturnSimpleApplicant>(
          $request,
        );
  }

  @override
  Future<Response<List<BookingReturn>>> _bookingBookingsUsersMeGet({
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
  }) {
    final Uri $url = Uri.parse('/booking/bookings/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<BookingReturn>, BookingReturn>($request);
  }

  @override
  Future<Response<BookingReturn>> _bookingBookingsPost({
    required BookingBase? body,
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
  }) {
    final Uri $url = Uri.parse('/booking/bookings');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<BookingReturn, BookingReturn>($request);
  }

  @override
  Future<Response<dynamic>> _bookingBookingsBookingIdPatch({
    required String? bookingId,
    required BookingEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/booking/bookings/${bookingId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingBookingsBookingIdDelete({
    required String? bookingId,
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
  }) {
    final Uri $url = Uri.parse('/booking/bookings/${bookingId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingBookingsBookingIdReplyDecisionPatch({
    required String? bookingId,
    required String? decision,
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
  }) {
    final Uri $url = Uri.parse(
      '/booking/bookings/${bookingId}/reply/${decision}',
    );
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RoomComplete>>> _bookingRoomsGet({
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
  }) {
    final Uri $url = Uri.parse('/booking/rooms');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<RoomComplete>, RoomComplete>($request);
  }

  @override
  Future<Response<RoomComplete>> _bookingRoomsPost({
    required RoomBase? body,
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
  }) {
    final Uri $url = Uri.parse('/booking/rooms');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<RoomComplete, RoomComplete>($request);
  }

  @override
  Future<Response<dynamic>> _bookingRoomsRoomIdPatch({
    required String? roomId,
    required RoomBase? body,
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
  }) {
    final Uri $url = Uri.parse('/booking/rooms/${roomId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _bookingRoomsRoomIdDelete({
    required String? roomId,
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
  }) {
    final Uri $url = Uri.parse('/booking/rooms/${roomId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SpeciesComplete>>> _seedLibrarySpeciesGet({
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
  }) {
    final Uri $url = Uri.parse('/seed_library/species/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SpeciesComplete>, SpeciesComplete>($request);
  }

  @override
  Future<Response<SpeciesComplete>> _seedLibrarySpeciesPost({
    required SpeciesBase? body,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/species/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SpeciesComplete, SpeciesComplete>($request);
  }

  @override
  Future<Response<SpeciesTypesReturn>> _seedLibrarySpeciesTypesGet({
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
  }) {
    final Uri $url = Uri.parse('/seed_library/species/types');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<SpeciesTypesReturn, SpeciesTypesReturn>($request);
  }

  @override
  Future<Response<dynamic>> _seedLibrarySpeciesSpeciesIdPatch({
    required String? speciesId,
    required SpeciesEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/species/${speciesId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _seedLibrarySpeciesSpeciesIdDelete({
    required String? speciesId,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/species/${speciesId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PlantSimple>>> _seedLibraryPlantsWaitingGet({
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/waiting');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PlantSimple>, PlantSimple>($request);
  }

  @override
  Future<Response<List<PlantSimple>>> _seedLibraryPlantsUsersMeGet({
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PlantSimple>, PlantSimple>($request);
  }

  @override
  Future<Response<List<PlantSimple>>> _seedLibraryPlantsUsersUserIdGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PlantSimple>, PlantSimple>($request);
  }

  @override
  Future<Response<PlantComplete>> _seedLibraryPlantsPlantIdGet({
    required String? plantId,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/${plantId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<PlantComplete, PlantComplete>($request);
  }

  @override
  Future<Response<dynamic>> _seedLibraryPlantsPlantIdPatch({
    required String? plantId,
    required PlantEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/${plantId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _seedLibraryPlantsPlantIdDelete({
    required String? plantId,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/${plantId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PlantSimple>> _seedLibraryPlantsPost({
    required PlantCreation? body,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<PlantSimple, PlantSimple>($request);
  }

  @override
  Future<Response<dynamic>> _seedLibraryPlantsPlantIdAdminPatch({
    required String? plantId,
    required PlantEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/${plantId}/admin');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _seedLibraryPlantsPlantIdBorrowPatch({
    required String? plantId,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/plants/${plantId}/borrow');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SeedLibraryInformation>> _seedLibraryInformationGet({
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
  }) {
    final Uri $url = Uri.parse('/seed_library/information');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<SeedLibraryInformation, SeedLibraryInformation>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _seedLibraryInformationPatch({
    required SeedLibraryInformation? body,
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
  }) {
    final Uri $url = Uri.parse('/seed_library/information');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AssociationComplete>>> _phonebookAssociationsGet({
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
  }) {
    final Uri $url = Uri.parse('/phonebook/associations/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<AssociationComplete>, AssociationComplete>(
      $request,
    );
  }

  @override
  Future<Response<AssociationComplete>> _phonebookAssociationsPost({
    required AppModulesPhonebookSchemasPhonebookAssociationBase? body,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/associations/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<AssociationComplete, AssociationComplete>($request);
  }

  @override
  Future<Response<RoleTagsReturn>> _phonebookRoletagsGet({
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
  }) {
    final Uri $url = Uri.parse('/phonebook/roletags');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RoleTagsReturn, RoleTagsReturn>($request);
  }

  @override
  Future<Response<List<AssociationGroupement>>> _phonebookGroupementsGet({
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
  }) {
    final Uri $url = Uri.parse('/phonebook/groupements/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<AssociationGroupement>, AssociationGroupement>(
      $request,
    );
  }

  @override
  Future<Response<AssociationGroupement>> _phonebookGroupementsPost({
    required AssociationGroupementBase? body,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/groupements/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<AssociationGroupement, AssociationGroupement>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookGroupementsGroupementIdPatch({
    required String? groupementId,
    required AssociationGroupementBase? body,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/groupements/${groupementId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookGroupementsGroupementIdDelete({
    required String? groupementId,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/groupements/${groupementId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdPatch({
    required String? associationId,
    required AssociationEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/associations/${associationId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdDelete({
    required String? associationId,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/associations/${associationId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdGroupsPatch({
    required String? associationId,
    required AssociationGroupsEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/${associationId}/groups',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdDeactivatePatch({
    required String? associationId,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/${associationId}/deactivate',
    );
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<MemberComplete>>>
  _phonebookAssociationsAssociationIdMembersGet({
    required String? associationId,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/${associationId}/members/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<MemberComplete>, MemberComplete>($request);
  }

  @override
  Future<Response<List<MemberComplete>>>
  _phonebookAssociationsAssociationIdMembersMandateYearGet({
    required String? associationId,
    required int? mandateYear,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/${associationId}/members/${mandateYear}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<MemberComplete>, MemberComplete>($request);
  }

  @override
  Future<Response<MemberComplete>> _phonebookMemberUserIdGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/member/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<MemberComplete, MemberComplete>($request);
  }

  @override
  Future<Response<MembershipComplete>> _phonebookAssociationsMembershipsPost({
    required AppModulesPhonebookSchemasPhonebookMembershipBase? body,
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
  }) {
    final Uri $url = Uri.parse('/phonebook/associations/memberships');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<MembershipComplete, MembershipComplete>($request);
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsMembershipsMembershipIdPatch({
    required String? membershipId,
    required MembershipEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/memberships/${membershipId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _phonebookAssociationsMembershipsMembershipIdDelete({
    required String? membershipId,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/memberships/${membershipId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
  _phonebookAssociationsAssociationIdPicturePost({
    required String? associationId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/${associationId}/picture',
    );
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _phonebookAssociationsAssociationIdPictureGet({
    required String? associationId,
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
  }) {
    final Uri $url = Uri.parse(
      '/phonebook/associations/${associationId}/picture',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AdvertComplete>>> _advertAdvertsGet({
    List<String>? advertisers,
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
  }) {
    final Uri $url = Uri.parse('/advert/adverts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'advertisers': advertisers,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<AdvertComplete>, AdvertComplete>($request);
  }

  @override
  Future<Response<AdvertComplete>> _advertAdvertsPost({
    required AdvertBase? body,
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
  }) {
    final Uri $url = Uri.parse('/advert/adverts');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<AdvertComplete, AdvertComplete>($request);
  }

  @override
  Future<Response<AdvertComplete>> _advertAdvertsAdvertIdGet({
    required String? advertId,
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
  }) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<AdvertComplete, AdvertComplete>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertsAdvertIdPatch({
    required String? advertId,
    required AdvertUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertsAdvertIdDelete({
    required String? advertId,
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
  }) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertsAdvertIdPictureGet({
    required String? advertId,
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
  }) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}/picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _advertAdvertsAdvertIdPicturePost({
    required String? advertId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/advert/adverts/${advertId}/picture');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CdrUserPreview>>> _cdrUsersGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CdrUserPreview>, CdrUserPreview>($request);
  }

  @override
  Future<Response<List<CdrUserPreview>>> _cdrUsersPendingGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/pending/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CdrUserPreview>, CdrUserPreview>($request);
  }

  @override
  Future<Response<CdrUser>> _cdrUsersUserIdGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CdrUser, CdrUser>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdPatch({
    required String? userId,
    required CdrUserUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SellerComplete>>> _cdrSellersGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SellerComplete>, SellerComplete>($request);
  }

  @override
  Future<Response<SellerComplete>> _cdrSellersPost({
    required SellerBase? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SellerComplete, SellerComplete>($request);
  }

  @override
  Future<Response<List<SellerComplete>>> _cdrUsersMeSellersGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/me/sellers/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SellerComplete>, SellerComplete>($request);
  }

  @override
  Future<Response<List<SellerComplete>>> _cdrOnlineSellersGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/online/sellers/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SellerComplete>, SellerComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdResultsGet({
    required String? sellerId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/results/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrOnlineProductsGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/online/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCdrSchemasCdrProductComplete>,
      AppModulesCdrSchemasCdrProductComplete
    >($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrProductsGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCdrSchemasCdrProductComplete>,
      AppModulesCdrSchemasCdrProductComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdPatch({
    required String? sellerId,
    required SellerEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdDelete({
    required String? sellerId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrSellersSellerIdProductsGet({
    required String? sellerId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCdrSchemasCdrProductComplete>,
      AppModulesCdrSchemasCdrProductComplete
    >($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrProductComplete>>
  _cdrSellersSellerIdProductsPost({
    required String? sellerId,
    required AppModulesCdrSchemasCdrProductBase? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/products/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesCdrSchemasCdrProductComplete,
      AppModulesCdrSchemasCdrProductComplete
    >($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrProductComplete>>>
  _cdrOnlineSellersSellerIdProductsGet({
    required String? sellerId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/online/sellers/${sellerId}/products/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCdrSchemasCdrProductComplete>,
      AppModulesCdrSchemasCdrProductComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdProductsProductIdPatch({
    required String? sellerId,
    required String? productId,
    required AppModulesCdrSchemasCdrProductEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdProductsProductIdDelete({
    required String? sellerId,
    required String? productId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrProductVariantComplete>>
  _cdrSellersSellerIdProductsProductIdVariantsPost({
    required String? sellerId,
    required String? productId,
    required AppModulesCdrSchemasCdrProductVariantBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/variants/',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesCdrSchemasCdrProductVariantComplete,
      AppModulesCdrSchemasCdrProductVariantComplete
    >($request);
  }

  @override
  Future<Response<dynamic>>
  _cdrSellersSellerIdProductsProductIdVariantsVariantIdPatch({
    required String? sellerId,
    required String? productId,
    required String? variantId,
    required AppModulesCdrSchemasCdrProductVariantEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/variants/${variantId}/',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _cdrSellersSellerIdProductsProductIdVariantsVariantIdDelete({
    required String? sellerId,
    required String? productId,
    required String? variantId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/variants/${variantId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<DocumentComplete>>> _cdrSellersSellerIdDocumentsGet({
    required String? sellerId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/documents/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<DocumentComplete>, DocumentComplete>($request);
  }

  @override
  Future<Response<DocumentComplete>> _cdrSellersSellerIdDocumentsPost({
    required String? sellerId,
    required DocumentBase? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/sellers/${sellerId}/documents/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<DocumentComplete, DocumentComplete>($request);
  }

  @override
  Future<Response<List<DocumentComplete>>> _cdrDocumentsGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/documents/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<DocumentComplete>, DocumentComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrSellersSellerIdDocumentsDocumentIdDelete({
    required String? sellerId,
    required String? documentId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/documents/${documentId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PurchaseReturn>>> _cdrUsersUserIdPurchasesGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/purchases/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PurchaseReturn>, PurchaseReturn>($request);
  }

  @override
  Future<Response<List<PurchaseReturn>>> _cdrMePurchasesGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/me/purchases/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PurchaseReturn>, PurchaseReturn>($request);
  }

  @override
  Future<Response<List<PurchaseReturn>>> _cdrMePurchasesAllGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/me/purchases/all');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PurchaseReturn>, PurchaseReturn>($request);
  }

  @override
  Future<Response<List<PurchaseReturn>>>
  _cdrSellersSellerIdUsersUserIdPurchasesGet({
    required String? sellerId,
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/users/${userId}/purchases/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PurchaseReturn>, PurchaseReturn>($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrPurchaseComplete>>
  _cdrUsersUserIdPurchasesProductVariantIdPost({
    required String? userId,
    required String? productVariantId,
    required AppModulesCdrSchemasCdrPurchaseBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/purchases/${productVariantId}/',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesCdrSchemasCdrPurchaseComplete,
      AppModulesCdrSchemasCdrPurchaseComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdPurchasesProductVariantIdDelete({
    required String? userId,
    required String? productVariantId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/purchases/${productVariantId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrBatchPurchasesPost({
    required BatchPurchase? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/batch-purchases/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _cdrUsersUserIdPurchasesProductVariantIdValidatedPatch({
    required String? userId,
    required String? productVariantId,
    required bool? validated,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/purchases/${productVariantId}/validated/',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'validated': validated,
    };
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrBatchValidationPost({
    required BatchValidation? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/batch-validation/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SignatureComplete>>> _cdrUsersUserIdSignaturesGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/signatures/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SignatureComplete>, SignatureComplete>($request);
  }

  @override
  Future<Response<List<SignatureComplete>>>
  _cdrSellersSellerIdUsersUserIdSignaturesGet({
    required String? sellerId,
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/users/${userId}/signatures/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SignatureComplete>, SignatureComplete>($request);
  }

  @override
  Future<Response<SignatureComplete>> _cdrUsersUserIdSignaturesDocumentIdPost({
    required String? userId,
    required String? documentId,
    required SignatureBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/signatures/${documentId}/',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SignatureComplete, SignatureComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdSignaturesDocumentIdDelete({
    required String? userId,
    required String? documentId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/signatures/${documentId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CurriculumComplete>>> _cdrCurriculumsGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/curriculums/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CurriculumComplete>, CurriculumComplete>($request);
  }

  @override
  Future<Response<CurriculumComplete>> _cdrCurriculumsPost({
    required CurriculumBase? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/curriculums/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CurriculumComplete, CurriculumComplete>($request);
  }

  @override
  Future<Response<dynamic>> _cdrCurriculumsCurriculumIdDelete({
    required String? curriculumId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/curriculums/${curriculumId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdCurriculumsCurriculumIdPost({
    required String? userId,
    required String? curriculumId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/curriculums/${curriculumId}/',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdCurriculumsCurriculumIdPatch({
    required String? userId,
    required String? curriculumId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/curriculums/${curriculumId}/',
    );
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdCurriculumsCurriculumIdDelete({
    required String? userId,
    required String? curriculumId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/users/${userId}/curriculums/${curriculumId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrPaymentComplete>>>
  _cdrUsersUserIdPaymentsGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/payments/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCdrSchemasCdrPaymentComplete>,
      AppModulesCdrSchemasCdrPaymentComplete
    >($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrPaymentComplete>>
  _cdrUsersUserIdPaymentsPost({
    required String? userId,
    required AppModulesCdrSchemasCdrPaymentBase? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/payments/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesCdrSchemasCdrPaymentComplete,
      AppModulesCdrSchemasCdrPaymentComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _cdrUsersUserIdPaymentsPaymentIdDelete({
    required String? userId,
    required String? paymentId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/payments/${paymentId}/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaymentUrl>> _cdrPayPost({
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
  }) {
    final Uri $url = Uri.parse('/cdr/pay/');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<CdrYear>> _cdrYearGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/year/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CdrYear, CdrYear>($request);
  }

  @override
  Future<Response<dynamic>> _cdrYearPatch({
    required CdrYear? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/year/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Status>> _cdrStatusGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/status/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<Status, Status>($request);
  }

  @override
  Future<Response<dynamic>> _cdrStatusPatch({
    required Status? body,
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
  }) {
    final Uri $url = Uri.parse('/cdr/status/');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrTicket>>> _cdrUsersMeTicketsGet({
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/me/tickets/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCdrSchemasCdrTicket>,
      AppModulesCdrSchemasCdrTicket
    >($request);
  }

  @override
  Future<Response<List<AppModulesCdrSchemasCdrTicket>>>
  _cdrUsersUserIdTicketsGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/${userId}/tickets/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCdrSchemasCdrTicket>,
      AppModulesCdrSchemasCdrTicket
    >($request);
  }

  @override
  Future<Response<TicketSecret>> _cdrUsersMeTicketsTicketIdSecretGet({
    required String? ticketId,
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
  }) {
    final Uri $url = Uri.parse('/cdr/users/me/tickets/${ticketId}/secret/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<TicketSecret, TicketSecret>($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrTicket>>
  _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? secret,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/tickets/${generatorId}/${secret}/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client
        .send<AppModulesCdrSchemasCdrTicket, AppModulesCdrSchemasCdrTicket>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>>
  _cdrSellersSellerIdProductsProductIdTicketsGeneratorIdSecretPatch({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
    required String? secret,
    required TicketScan? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/tickets/${generatorId}/${secret}/',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/tickets/${generatorId}/lists/${tag}/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CoreUserSimple>, CoreUserSimple>($request);
  }

  @override
  Future<Response<List<String>>>
  _cdrSellersSellerIdProductsProductIdTagsGeneratorIdGet({
    required String? sellerId,
    required String? productId,
    required String? generatorId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/tags/${generatorId}/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<AppModulesCdrSchemasCdrProductComplete>>
  _cdrSellersSellerIdProductsProductIdTicketsPost({
    required String? sellerId,
    required String? productId,
    required GenerateTicketBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/tickets/',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesCdrSchemasCdrProductComplete,
      AppModulesCdrSchemasCdrProductComplete
    >($request);
  }

  @override
  Future<Response<dynamic>>
  _cdrSellersSellerIdProductsProductIdTicketsTicketGeneratorIdDelete({
    required String? sellerId,
    required String? productId,
    required String? ticketGeneratorId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/tickets/${ticketGeneratorId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CustomDataFieldComplete>>>
  _cdrSellersSellerIdProductsProductIdDataGet({
    required String? sellerId,
    required String? productId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/data/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CustomDataFieldComplete>, CustomDataFieldComplete>(
      $request,
    );
  }

  @override
  Future<Response<CustomDataFieldComplete>>
  _cdrSellersSellerIdProductsProductIdDataPost({
    required String? sellerId,
    required String? productId,
    required CustomDataFieldBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/data/',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CustomDataFieldComplete, CustomDataFieldComplete>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>>
  _cdrSellersSellerIdProductsProductIdDataFieldIdPatch({
    required String? sellerId,
    required String? productId,
    required String? fieldId,
    required CustomDataFieldBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/data/${fieldId}/',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _cdrSellersSellerIdProductsProductIdDataFieldIdDelete({
    required String? sellerId,
    required String? productId,
    required String? fieldId,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/data/${fieldId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
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
  }) {
    final Uri $url = Uri.parse(
      '/cdr/sellers/${sellerId}/products/${productId}/users/${userId}/data/${fieldId}/',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdPdfGet({
    required String? paperId,
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
  }) {
    final Uri $url = Uri.parse('/ph/${paperId}/pdf');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdPdfPost({
    required String? paperId,
    required List<int> pdf,
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
  }) {
    final Uri $url = Uri.parse('/ph/${paperId}/pdf');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('pdf', pdf),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PaperComplete>>> _phGet({
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
  }) {
    final Uri $url = Uri.parse('/ph/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PaperComplete>, PaperComplete>($request);
  }

  @override
  Future<Response<PaperComplete>> _phPost({
    required PaperBase? body,
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
  }) {
    final Uri $url = Uri.parse('/ph/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<PaperComplete, PaperComplete>($request);
  }

  @override
  Future<Response<List<PaperComplete>>> _phAdminGet({
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
  }) {
    final Uri $url = Uri.parse('/ph/admin');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PaperComplete>, PaperComplete>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdCoverGet({
    required String? paperId,
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
  }) {
    final Uri $url = Uri.parse('/ph/${paperId}/cover');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdPatch({
    required String? paperId,
    required PaperUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/ph/${paperId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _phPaperIdDelete({
    required String? paperId,
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
  }) {
    final Uri $url = Uri.parse('/ph/${paperId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidParticipant>> _raidParticipantsParticipantIdGet({
    required String? participantId,
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
  }) {
    final Uri $url = Uri.parse('/raid/participants/${participantId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaidParticipant, RaidParticipant>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantsParticipantIdPatch({
    required String? participantId,
    required RaidParticipantUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/participants/${participantId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidParticipant>> _raidParticipantsPost({
    required RaidParticipantBase? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/participants');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<RaidParticipant, RaidParticipant>($request);
  }

  @override
  Future<Response<List<RaidTeamPreview>>> _raidTeamsGet({
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
  }) {
    final Uri $url = Uri.parse('/raid/teams');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<RaidTeamPreview>, RaidTeamPreview>($request);
  }

  @override
  Future<Response<RaidTeam>> _raidTeamsPost({
    required RaidTeamBase? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/teams');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<RaidTeam, RaidTeam>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsDelete({
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
  }) {
    final Uri $url = Uri.parse('/raid/teams');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidTeam>> _raidParticipantsParticipantIdTeamGet({
    required String? participantId,
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
  }) {
    final Uri $url = Uri.parse('/raid/participants/${participantId}/team');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaidTeam, RaidTeam>($request);
  }

  @override
  Future<Response<RaidTeam>> _raidTeamsTeamIdGet({
    required String? teamId,
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
  }) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaidTeam, RaidTeam>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsTeamIdPatch({
    required String? teamId,
    required RaidTeamUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsTeamIdDelete({
    required String? teamId,
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
  }) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DocumentCreation>> _raidDocumentDocumentTypePost({
    required String? documentType,
    required List<int> file,
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
  }) {
    final Uri $url = Uri.parse('/raid/document/${documentType}');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('file', file),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client.send<DocumentCreation, DocumentCreation>($request);
  }

  @override
  Future<Response<dynamic>> _raidDocumentDocumentIdGet({
    required String? documentId,
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
  }) {
    final Uri $url = Uri.parse('/raid/document/${documentId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidDocumentDocumentIdValidatePost({
    required String? documentId,
    required String? validation,
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
  }) {
    final Uri $url = Uri.parse('/raid/document/${documentId}/validate');
    final Map<String, dynamic> $params = <String, dynamic>{
      'validation': validation,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SecurityFile>> _raidSecurityFilePost({
    required String? participantId,
    required SecurityFileBase? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/security_file/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'participant_id': participantId,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<SecurityFile, SecurityFile>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantParticipantIdPaymentPost({
    required String? participantId,
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
  }) {
    final Uri $url = Uri.parse('/raid/participant/${participantId}/payment');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantParticipantIdTShirtPaymentPost({
    required String? participantId,
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
  }) {
    final Uri $url = Uri.parse(
      '/raid/participant/${participantId}/t_shirt_payment',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidParticipantParticipantIdHonourPost({
    required String? participantId,
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
  }) {
    final Uri $url = Uri.parse('/raid/participant/${participantId}/honour');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<InviteToken>> _raidTeamsTeamIdInvitePost({
    required String? teamId,
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
  }) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}/invite');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<InviteToken, InviteToken>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamsJoinTokenPost({
    required String? token,
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
  }) {
    final Uri $url = Uri.parse('/raid/teams/join/${token}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidTeam>> _raidTeamsTeamIdKickParticipantIdPost({
    required String? teamId,
    required String? participantId,
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
  }) {
    final Uri $url = Uri.parse('/raid/teams/${teamId}/kick/${participantId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaidTeam, RaidTeam>($request);
  }

  @override
  Future<Response<RaidTeam>> _raidTeamsMergePost({
    required String? team1Id,
    required String? team2Id,
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
      tag: swaggerMetaData,
    );
    return client.send<RaidTeam, RaidTeam>($request);
  }

  @override
  Future<Response<RaidInformation>> _raidInformationGet({
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
  }) {
    final Uri $url = Uri.parse('/raid/information');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaidInformation, RaidInformation>($request);
  }

  @override
  Future<Response<dynamic>> _raidInformationPatch({
    required RaidInformation? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/information');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidDriveFoldersCreation>> _raidDriveGet({
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
  }) {
    final Uri $url = Uri.parse('/raid/drive');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaidDriveFoldersCreation, RaidDriveFoldersCreation>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _raidDrivePatch({
    required RaidDriveFoldersCreation? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/drive');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RaidPrice>> _raidPriceGet({
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
  }) {
    final Uri $url = Uri.parse('/raid/price');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaidPrice, RaidPrice>($request);
  }

  @override
  Future<Response<dynamic>> _raidPricePatch({
    required RaidPrice? body,
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
  }) {
    final Uri $url = Uri.parse('/raid/price');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaymentUrl>> _raidPayGet({
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
  }) {
    final Uri $url = Uri.parse('/raid/pay');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<dynamic>> _raidSecurityFilesZipGet({
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
  }) {
    final Uri $url = Uri.parse('/raid/security_files_zip');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _raidTeamFilesZipGet({
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
  }) {
    final Uri $url = Uri.parse('/raid/team_files_zip');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SectionComplete>>> _campaignSectionsGet({
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
  }) {
    final Uri $url = Uri.parse('/campaign/sections');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SectionComplete>, SectionComplete>($request);
  }

  @override
  Future<Response<SectionComplete>> _campaignSectionsPost({
    required SectionBase? body,
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
  }) {
    final Uri $url = Uri.parse('/campaign/sections');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SectionComplete, SectionComplete>($request);
  }

  @override
  Future<Response<dynamic>> _campaignSectionsSectionIdDelete({
    required String? sectionId,
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
  }) {
    final Uri $url = Uri.parse('/campaign/sections/${sectionId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ListReturn>>> _campaignListsGet({
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
  }) {
    final Uri $url = Uri.parse('/campaign/lists');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ListReturn>, ListReturn>($request);
  }

  @override
  Future<Response<ListReturn>> _campaignListsPost({
    required ListBase? body,
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
  }) {
    final Uri $url = Uri.parse('/campaign/lists');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<ListReturn, ListReturn>($request);
  }

  @override
  Future<Response<dynamic>> _campaignListsListIdDelete({
    required String? listId,
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
  }) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignListsListIdPatch({
    required String? listId,
    required ListEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignListsDelete({
    Object? listType,
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
  }) {
    final Uri $url = Uri.parse('/campaign/lists/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'list_type': listType,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CorePermission>> _campaignVotersGet({
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
  }) {
    final Uri $url = Uri.parse('/campaign/voters');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CorePermission, CorePermission>($request);
  }

  @override
  Future<Response<dynamic>> _campaignVotersDelete({
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
  }) {
    final Uri $url = Uri.parse('/campaign/voters');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignVotersGroupIdPost({
    required String? groupId,
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
  }) {
    final Uri $url = Uri.parse('/campaign/voters/${groupId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignVotersGroupIdDelete({
    required String? groupId,
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
  }) {
    final Uri $url = Uri.parse('/campaign/voters/${groupId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusOpenPost({
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
  }) {
    final Uri $url = Uri.parse('/campaign/status/open');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusClosePost({
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
  }) {
    final Uri $url = Uri.parse('/campaign/status/close');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusCountingPost({
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
  }) {
    final Uri $url = Uri.parse('/campaign/status/counting');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusPublishedPost({
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
  }) {
    final Uri $url = Uri.parse('/campaign/status/published');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _campaignStatusResetPost({
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
  }) {
    final Uri $url = Uri.parse('/campaign/status/reset');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _campaignVotesGet({
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
  }) {
    final Uri $url = Uri.parse('/campaign/votes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _campaignVotesPost({
    required VoteBase? body,
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
  }) {
    final Uri $url = Uri.parse('/campaign/votes');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesCampaignSchemasCampaignResult>>>
  _campaignResultsGet({
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
  }) {
    final Uri $url = Uri.parse('/campaign/results');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesCampaignSchemasCampaignResult>,
      AppModulesCampaignSchemasCampaignResult
    >($request);
  }

  @override
  Future<Response<VoteStatus>> _campaignStatusGet({
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
  }) {
    final Uri $url = Uri.parse('/campaign/status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<VoteStatus, VoteStatus>($request);
  }

  @override
  Future<Response<VoteStats>> _campaignStatsSectionIdGet({
    required String? sectionId,
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
  }) {
    final Uri $url = Uri.parse('/campaign/stats/${sectionId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<VoteStats, VoteStats>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
  _campaignListsListIdLogoPost({
    required String? listId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}/logo');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _campaignListsListIdLogoGet({
    required String? listId,
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
  }) {
    final Uri $url = Uri.parse('/campaign/lists/${listId}/logo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesAmapSchemasAmapProductComplete>>>
  _amapProductsGet({
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
  }) {
    final Uri $url = Uri.parse('/amap/products');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesAmapSchemasAmapProductComplete>,
      AppModulesAmapSchemasAmapProductComplete
    >($request);
  }

  @override
  Future<Response<AppModulesAmapSchemasAmapProductComplete>> _amapProductsPost({
    required ProductSimple? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/products');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesAmapSchemasAmapProductComplete,
      AppModulesAmapSchemasAmapProductComplete
    >($request);
  }

  @override
  Future<Response<AppModulesAmapSchemasAmapProductComplete>>
  _amapProductsProductIdGet({
    required String? productId,
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
  }) {
    final Uri $url = Uri.parse('/amap/products/${productId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesAmapSchemasAmapProductComplete,
      AppModulesAmapSchemasAmapProductComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _amapProductsProductIdPatch({
    required String? productId,
    required AppModulesAmapSchemasAmapProductEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/products/${productId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapProductsProductIdDelete({
    required String? productId,
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
  }) {
    final Uri $url = Uri.parse('/amap/products/${productId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<DeliveryReturn>>> _amapDeliveriesGet({
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<DeliveryReturn>, DeliveryReturn>($request);
  }

  @override
  Future<Response<DeliveryReturn>> _amapDeliveriesPost({
    required DeliveryBase? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<DeliveryReturn, DeliveryReturn>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdDelete({
    required String? deliveryId,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdPatch({
    required String? deliveryId,
    required DeliveryUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdProductsPost({
    required String? deliveryId,
    required DeliveryProductsUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/products');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdProductsDelete({
    required String? deliveryId,
    required DeliveryProductsUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/products');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<OrderReturn>>> _amapDeliveriesDeliveryIdOrdersGet({
    required String? deliveryId,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/orders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<OrderReturn>, OrderReturn>($request);
  }

  @override
  Future<Response<OrderReturn>> _amapOrdersOrderIdGet({
    required String? orderId,
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
  }) {
    final Uri $url = Uri.parse('/amap/orders/${orderId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<OrderReturn, OrderReturn>($request);
  }

  @override
  Future<Response<dynamic>> _amapOrdersOrderIdPatch({
    required String? orderId,
    required OrderEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/orders/${orderId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapOrdersOrderIdDelete({
    required String? orderId,
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
  }) {
    final Uri $url = Uri.parse('/amap/orders/${orderId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<OrderReturn>> _amapOrdersPost({
    required OrderBase? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/orders');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<OrderReturn, OrderReturn>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdOpenorderingPost({
    required String? deliveryId,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/openordering');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdLockPost({
    required String? deliveryId,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/lock');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdDeliveredPost({
    required String? deliveryId,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/delivered');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _amapDeliveriesDeliveryIdArchivePost({
    required String? deliveryId,
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
  }) {
    final Uri $url = Uri.parse('/amap/deliveries/${deliveryId}/archive');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesAmapSchemasAmapCashComplete>>>
  _amapUsersCashGet({
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
  }) {
    final Uri $url = Uri.parse('/amap/users/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesAmapSchemasAmapCashComplete>,
      AppModulesAmapSchemasAmapCashComplete
    >($request);
  }

  @override
  Future<Response<AppModulesAmapSchemasAmapCashComplete>>
  _amapUsersUserIdCashGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesAmapSchemasAmapCashComplete,
      AppModulesAmapSchemasAmapCashComplete
    >($request);
  }

  @override
  Future<Response<AppModulesAmapSchemasAmapCashComplete>>
  _amapUsersUserIdCashPost({
    required String? userId,
    required CashEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesAmapSchemasAmapCashComplete,
      AppModulesAmapSchemasAmapCashComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _amapUsersUserIdCashPatch({
    required String? userId,
    required CashEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<OrderReturn>>> _amapUsersUserIdOrdersGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/amap/users/${userId}/orders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<OrderReturn>, OrderReturn>($request);
  }

  @override
  Future<Response<Information>> _amapInformationGet({
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
  }) {
    final Uri $url = Uri.parse('/amap/information');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<Information, Information>($request);
  }

  @override
  Future<Response<dynamic>> _amapInformationPatch({
    required InformationEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/amap/information');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Sport>>> _competitionSportsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/sports');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Sport>, Sport>($request);
  }

  @override
  Future<Response<Sport>> _competitionSportsPost({
    required SportBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/sports');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Sport, Sport>($request);
  }

  @override
  Future<Response<dynamic>> _competitionSportsSportIdPatch({
    required String? sportId,
    required SportEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/sports/${sportId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionSportsSportIdDelete({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/sports/${sportId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CompetitionEdition>>> _competitionEditionsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/editions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CompetitionEdition>, CompetitionEdition>($request);
  }

  @override
  Future<Response<CompetitionEdition>> _competitionEditionsPost({
    required CompetitionEditionBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/editions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CompetitionEdition, CompetitionEdition>($request);
  }

  @override
  Future<Response<dynamic>> _competitionEditionsActiveGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/editions/active');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionEditionsEditionIdActivatePost({
    required String? editionId,
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
  }) {
    final Uri $url = Uri.parse('/competition/editions/${editionId}/activate');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionEditionsEditionIdInscriptionPost({
    required String? editionId,
    required bool? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/editions/${editionId}/inscription',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionEditionsEditionIdPatch({
    required String? editionId,
    required CompetitionEditionEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/editions/${editionId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CompetitionUser>>> _competitionUsersGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CompetitionUser>, CompetitionUser>($request);
  }

  @override
  Future<Response<CompetitionUserSimple>> _competitionUsersPost({
    required CompetitionUserBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/users');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CompetitionUserSimple, CompetitionUserSimple>($request);
  }

  @override
  Future<Response<List<CompetitionUser>>> _competitionUsersSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CompetitionUser>, CompetitionUser>($request);
  }

  @override
  Future<Response<CompetitionUser>> _competitionUsersMeGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CompetitionUser, CompetitionUser>($request);
  }

  @override
  Future<Response<dynamic>> _competitionUsersMePatch({
    required CompetitionUserEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/me');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CompetitionUser>> _competitionUsersUserIdGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CompetitionUser, CompetitionUser>($request);
  }

  @override
  Future<Response<dynamic>> _competitionUsersUserIdPatch({
    required String? userId,
    required CompetitionUserEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionUsersUserIdDelete({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionUsersUserIdValidatePatch({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}/validate');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionUsersUserIdInvalidatePatch({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}/invalidate');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserGroupMembershipComplete>>>
  _competitionGroupsGroupGet({
    required String? group,
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
  }) {
    final Uri $url = Uri.parse('/competition/groups/${group}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client
        .send<List<UserGroupMembershipComplete>, UserGroupMembershipComplete>(
          $request,
        );
  }

  @override
  Future<Response<List<UserGroupMembership>>> _competitionUsersMeGroupsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/users/me/groups');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<UserGroupMembership>, UserGroupMembership>(
      $request,
    );
  }

  @override
  Future<Response<List<UserGroupMembership>>> _competitionUsersUserIdGroupsGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}/groups');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<UserGroupMembership>, UserGroupMembership>(
      $request,
    );
  }

  @override
  Future<Response<UserGroupMembership>> _competitionGroupsGroupUsersUserIdPost({
    required String? group,
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/groups/${group}/users/${userId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<UserGroupMembership, UserGroupMembership>($request);
  }

  @override
  Future<Response<dynamic>> _competitionGroupsGroupUsersUserIdDelete({
    required String? group,
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/groups/${group}/users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SchoolExtension>>> _competitionSchoolsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/schools');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolExtension>, SchoolExtension>($request);
  }

  @override
  Future<Response<SchoolExtensionBase>> _competitionSchoolsPost({
    required SchoolExtensionBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/schools');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SchoolExtensionBase, SchoolExtensionBase>($request);
  }

  @override
  Future<Response<SchoolExtension>> _competitionSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<SchoolExtension, SchoolExtension>($request);
  }

  @override
  Future<Response<dynamic>> _competitionSchoolsSchoolIdPatch({
    required String? schoolId,
    required SchoolExtensionEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/schools/${schoolId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionSchoolsSchoolIdDelete({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/schools/${schoolId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SchoolGeneralQuota>>
  _competitionSchoolsSchoolIdGeneralQuotaGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/general-quota',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<SchoolGeneralQuota, SchoolGeneralQuota>($request);
  }

  @override
  Future<Response<SchoolGeneralQuota>>
  _competitionSchoolsSchoolIdGeneralQuotaPost({
    required String? schoolId,
    required SchoolGeneralQuotaBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/general-quota',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SchoolGeneralQuota, SchoolGeneralQuota>($request);
  }

  @override
  Future<Response<dynamic>> _competitionSchoolsSchoolIdGeneralQuotaPatch({
    required String? schoolId,
    required SchoolGeneralQuotaBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/general-quota',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SchoolSportQuota>>> _competitionSportsSportIdQuotasGet({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/sports/${sportId}/quotas');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolSportQuota>, SchoolSportQuota>($request);
  }

  @override
  Future<Response<List<SchoolSportQuota>>>
  _competitionSchoolsSchoolIdSportsQuotasGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/sports-quotas',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolSportQuota>, SchoolSportQuota>($request);
  }

  @override
  Future<Response<dynamic>> _competitionSchoolsSchoolIdSportsSportIdQuotasPost({
    required String? schoolId,
    required String? sportId,
    required SportQuotaInfo? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/sports/${sportId}/quotas',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionSchoolsSchoolIdSportsSportIdQuotasPatch({
    required String? schoolId,
    required String? sportId,
    required SchoolSportQuotaEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/sports/${sportId}/quotas',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionSchoolsSchoolIdSportsSportIdQuotasDelete({
    required String? schoolId,
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/sports/${sportId}/quotas',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SchoolProductQuota>>>
  _competitionSchoolsSchoolIdProductQuotasGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/product-quotas',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolProductQuota>, SchoolProductQuota>($request);
  }

  @override
  Future<Response<SchoolProductQuota>>
  _competitionSchoolsSchoolIdProductQuotasPost({
    required String? schoolId,
    required SchoolProductQuotaBase? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/product-quotas',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SchoolProductQuota, SchoolProductQuota>($request);
  }

  @override
  Future<Response<List<SchoolProductQuota>>>
  _competitionProductsProductIdSchoolsQuotasGet({
    required String? productId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/products/${productId}/schools-quotas',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolProductQuota>, SchoolProductQuota>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionSchoolsSchoolIdProductQuotasProductIdPatch({
    required String? schoolId,
    required String? productId,
    required SchoolProductQuotaEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/product-quotas/${productId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionSchoolsSchoolIdProductQuotasProductIdDelete({
    required String? schoolId,
    required String? productId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/schools/${schoolId}/product-quotas/${productId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TeamComplete>>> _competitionTeamsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/teams');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TeamComplete>, TeamComplete>($request);
  }

  @override
  Future<Response<Team>> _competitionTeamsPost({
    required TeamInfo? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/teams');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<TeamComplete>> _competitionTeamsMeGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/teams/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<TeamComplete, TeamComplete>($request);
  }

  @override
  Future<Response<List<TeamComplete>>> _competitionTeamsSportsSportIdGet({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/teams/sports/${sportId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TeamComplete>, TeamComplete>($request);
  }

  @override
  Future<Response<List<TeamComplete>>> _competitionTeamsSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/teams/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TeamComplete>, TeamComplete>($request);
  }

  @override
  Future<Response<List<TeamComplete>>>
  _competitionTeamsSportsSportIdSchoolsSchoolIdGet({
    required String? schoolId,
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/teams/sports/${sportId}/schools/${schoolId}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TeamComplete>, TeamComplete>($request);
  }

  @override
  Future<Response<dynamic>> _competitionTeamsTeamIdPatch({
    required String? teamId,
    required TeamEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/teams/${teamId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionTeamsTeamIdDelete({
    required String? teamId,
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
  }) {
    final Uri $url = Uri.parse('/competition/teams/${teamId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ParticipantComplete>> _competitionParticipantsMeGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/participants/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<ParticipantComplete, ParticipantComplete>($request);
  }

  @override
  Future<Response<List<ParticipantComplete>>>
  _competitionParticipantsSportsSportIdGet({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/participants/sports/${sportId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ParticipantComplete>, ParticipantComplete>(
      $request,
    );
  }

  @override
  Future<Response<List<ParticipantComplete>>>
  _competitionParticipantsSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/participants/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ParticipantComplete>, ParticipantComplete>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _competitionParticipantsUsersUserIdCertificateGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/participants/users/${userId}/certificate',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Participant>> _competitionSportsSportIdParticipatePost({
    required String? sportId,
    required ParticipantInfo? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/sports/${sportId}/participate');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Participant, Participant>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionParticipantsSportsSportIdCertificatePost({
    required String? sportId,
    required List<int> certificate,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/participants/sports/${sportId}/certificate',
    );
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('certificate', certificate),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionParticipantsSportsSportIdCertificateDelete({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/participants/sports/${sportId}/certificate',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionParticipantsSportsSportIdUsersUserIdLicensePatch({
    required String? sportId,
    required String? userId,
    required bool? isLicenseValid,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/participants/sports/${sportId}/users/${userId}/license',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'is_license_valid': isLicenseValid,
    };
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionSportsSportIdWithdrawDelete({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/sports/${sportId}/withdraw');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionParticipantsUserIdSportsSportIdDelete({
    required String? userId,
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/participants/${userId}/sports/${sportId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Location>>> _competitionLocationsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/locations');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Location>, Location>($request);
  }

  @override
  Future<Response<Location>> _competitionLocationsPost({
    required LocationBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/locations');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Location, Location>($request);
  }

  @override
  Future<Response<LocationComplete>> _competitionLocationsLocationIdGet({
    required String? locationId,
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
  }) {
    final Uri $url = Uri.parse('/competition/locations/${locationId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<LocationComplete, LocationComplete>($request);
  }

  @override
  Future<Response<dynamic>> _competitionLocationsLocationIdPatch({
    required String? locationId,
    required LocationEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/locations/${locationId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionLocationsLocationIdDelete({
    required String? locationId,
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
  }) {
    final Uri $url = Uri.parse('/competition/locations/${locationId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<MatchComplete>>> _competitionMatchesGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/matches');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<MatchComplete>, MatchComplete>($request);
  }

  @override
  Future<Response<List<MatchComplete>>> _competitionMatchesSportsSportIdGet({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/matches/sports/${sportId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<MatchComplete>, MatchComplete>($request);
  }

  @override
  Future<Response<Match>> _competitionMatchesSportsSportIdPost({
    required String? sportId,
    required MatchBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/matches/sports/${sportId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Match, Match>($request);
  }

  @override
  Future<Response<List<MatchComplete>>> _competitionMatchesSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/matches/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<MatchComplete>, MatchComplete>($request);
  }

  @override
  Future<Response<dynamic>> _competitionMatchesMatchIdPatch({
    required String? matchId,
    required MatchEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/matches/${matchId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionMatchesMatchIdDelete({
    required String? matchId,
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
  }) {
    final Uri $url = Uri.parse('/competition/matches/${matchId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SchoolResult>>> _competitionPodiumsGlobalGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/global');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolResult>, SchoolResult>($request);
  }

  @override
  Future<Response<List<TeamSportResultComplete>>>
  _competitionPodiumsSportsSportIdGet({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/sports/${sportId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TeamSportResultComplete>, TeamSportResultComplete>(
      $request,
    );
  }

  @override
  Future<Response<List<TeamSportResult>>> _competitionPodiumsSportsSportIdPost({
    required String? sportId,
    required SportPodiumRankings? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/sports/${sportId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<TeamSportResult>, TeamSportResult>($request);
  }

  @override
  Future<Response<dynamic>> _competitionPodiumsSportsSportIdDelete({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/sports/${sportId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<SchoolResult>>> _competitionPodiumsPompomsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/pompoms');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolResult>, SchoolResult>($request);
  }

  @override
  Future<Response<List<SchoolResult>>> _competitionPodiumsPompomsPost({
    required List<SchoolResult>? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/pompoms');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<SchoolResult>, SchoolResult>($request);
  }

  @override
  Future<Response<dynamic>> _competitionPodiumsPompomsDelete({
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/pompoms');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TeamSportResultComplete>>>
  _competitionPodiumsSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/podiums/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TeamSportResultComplete>, TeamSportResultComplete>(
      $request,
    );
  }

  @override
  Future<
    Response<
      List<AppModulesSportCompetitionSchemasSportCompetitionProductComplete>
    >
  >
  _competitionProductsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/products');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesSportCompetitionSchemasSportCompetitionProductComplete>,
      AppModulesSportCompetitionSchemasSportCompetitionProductComplete
    >($request);
  }

  @override
  Future<
    Response<AppModulesSportCompetitionSchemasSportCompetitionProductComplete>
  >
  _competitionProductsPost({
    required AppModulesSportCompetitionSchemasSportCompetitionProductBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/products');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesSportCompetitionSchemasSportCompetitionProductComplete,
      AppModulesSportCompetitionSchemasSportCompetitionProductComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _competitionProductsProductIdPatch({
    required String? productId,
    required AppModulesSportCompetitionSchemasSportCompetitionProductEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/products/${productId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionProductsProductIdDelete({
    required String? productId,
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
  }) {
    final Uri $url = Uri.parse('/competition/products/${productId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<
    Response<
      List<
        AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
      >
    >
  >
  _competitionProductsAvailableGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/products/available');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<
        AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
      >,
      AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
    >($request);
  }

  @override
  Future<Response<ProductVariant>> _competitionProductsProductIdVariantsPost({
    required String? productId,
    required AppModulesSportCompetitionSchemasSportCompetitionProductVariantBase?
    body,
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
  }) {
    final Uri $url = Uri.parse('/competition/products/${productId}/variants');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<ProductVariant, ProductVariant>($request);
  }

  @override
  Future<Response<dynamic>> _competitionProductsVariantsVariantIdPatch({
    required String? variantId,
    required AppModulesSportCompetitionSchemasSportCompetitionProductVariantEdit?
    body,
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
  }) {
    final Uri $url = Uri.parse('/competition/products/variants/${variantId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionProductsVariantsVariantIdDelete({
    required String? variantId,
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
  }) {
    final Uri $url = Uri.parse('/competition/products/variants/${variantId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Object>> _competitionPurchasesSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/purchases/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<List<Purchase>>> _competitionPurchasesUsersUserIdGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/purchases/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Purchase>, Purchase>($request);
  }

  @override
  Future<Response<Purchase>> _competitionPurchasesUsersUserIdPost({
    required String? userId,
    required AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase?
    body,
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
  }) {
    final Uri $url = Uri.parse('/competition/purchases/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Purchase, Purchase>($request);
  }

  @override
  Future<Response<List<Purchase>>> _competitionPurchasesMeGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/purchases/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Purchase>, Purchase>($request);
  }

  @override
  Future<Response<Purchase>> _competitionPurchasesMePost({
    required AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase?
    body,
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
  }) {
    final Uri $url = Uri.parse('/competition/purchases/me');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Purchase, Purchase>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionPurchasesUsersUserIdVariantsVariantIdPatch({
    required String? userId,
    required String? variantId,
    required PurchaseEdit? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/purchases/users/${userId}/variants/${variantId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionPurchasesProductVariantIdDelete({
    required String? productVariantId,
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
  }) {
    final Uri $url = Uri.parse('/competition/purchases/${productVariantId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _competitionUsersUserIdPurchasesProductVariantIdDelete({
    required String? userId,
    required String? productVariantId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/users/${userId}/purchases/${productVariantId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Object>> _competitionPaymentsSchoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/competition/payments/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<
    Response<
      List<AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete>
    >
  >
  _competitionUsersUserIdPaymentsGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}/payments');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete>,
      AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete
    >($request);
  }

  @override
  Future<
    Response<AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete>
  >
  _competitionUsersUserIdPaymentsPost({
    required String? userId,
    required AppModulesSportCompetitionSchemasSportCompetitionPaymentBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/users/${userId}/payments');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete,
      AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _competitionUsersUserIdPaymentsPaymentIdDelete({
    required String? userId,
    required String? paymentId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/users/${userId}/payments/${paymentId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PaymentUrl>> _competitionPayPost({
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
  }) {
    final Uri $url = Uri.parse('/competition/pay');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<List<VolunteerShiftComplete>>>
  _competitionVolunteersShiftsGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/volunteers/shifts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<VolunteerShiftComplete>, VolunteerShiftComplete>(
      $request,
    );
  }

  @override
  Future<Response<VolunteerShift>> _competitionVolunteersShiftsPost({
    required VolunteerShiftBase? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/volunteers/shifts');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<VolunteerShift, VolunteerShift>($request);
  }

  @override
  Future<Response<dynamic>> _competitionVolunteersShiftsShiftIdPatch({
    required String? shiftId,
    required VolunteerShiftEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/competition/volunteers/shifts/${shiftId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionVolunteersShiftsShiftIdDelete({
    required String? shiftId,
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
  }) {
    final Uri $url = Uri.parse('/competition/volunteers/shifts/${shiftId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<VolunteerRegistrationComplete>>>
  _competitionVolunteersMeGet({
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
  }) {
    final Uri $url = Uri.parse('/competition/volunteers/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<VolunteerRegistrationComplete>,
      VolunteerRegistrationComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _competitionVolunteersShiftsShiftIdRegisterPost({
    required String? shiftId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/volunteers/shifts/${shiftId}/register',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionDataExportUsersGet({
    List<Object?>? includedFields,
    bool? excludeNonValidated,
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
  }) {
    final Uri $url = Uri.parse('/competition/data-export/users');
    final Map<String, dynamic> $params = <String, dynamic>{
      'included_fields': includedFields,
      'exclude_non_validated': excludeNonValidated,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionDataExportSchoolsSchoolIdUsersGet({
    required String? schoolId,
    List<Object?>? includedFields,
    bool? excludeNonValidated,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/data-export/schools/${schoolId}/users',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'included_fields': includedFields,
      'exclude_non_validated': excludeNonValidated,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionDataExportParticipantsCaptainsGet({
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/data-export/participants/captains',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionDataExportSchoolsSchoolIdQuotasGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/data-export/schools/${schoolId}/quotas',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionDataExportSportsSportIdQuotasGet({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/data-export/sports/${sportId}/quotas',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _competitionDataExportSportsSportIdParticipantsGet({
    required String? sportId,
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
  }) {
    final Uri $url = Uri.parse(
      '/competition/data-export/sports/${sportId}/participants',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RaffleComplete>>> _tombolaRafflesGet({
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<RaffleComplete>, RaffleComplete>($request);
  }

  @override
  Future<Response<RaffleComplete>> _tombolaRafflesPost({
    required RaffleBase? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<RaffleComplete, RaffleComplete>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdPatch({
    required String? raffleId,
    required RaffleEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdDelete({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RaffleComplete>>> _tombolaGroupGroupIdRafflesGet({
    required String? groupId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/group/${groupId}/raffles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<RaffleComplete>, RaffleComplete>($request);
  }

  @override
  Future<Response<RaffleStats>> _tombolaRafflesRaffleIdStatsGet({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/stats');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<RaffleStats, RaffleStats>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
  _tombolaRafflesRaffleIdLogoPost({
    required String? raffleId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/logo');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdLogoGet({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/logo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PackTicketSimple>>> _tombolaPackTicketsGet({
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
  }) {
    final Uri $url = Uri.parse('/tombola/pack_tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PackTicketSimple>, PackTicketSimple>($request);
  }

  @override
  Future<Response<PackTicketSimple>> _tombolaPackTicketsPost({
    required PackTicketBase? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/pack_tickets');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<PackTicketSimple, PackTicketSimple>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPackTicketsPackticketIdPatch({
    required String? packticketId,
    required PackTicketEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/pack_tickets/${packticketId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPackTicketsPackticketIdDelete({
    required String? packticketId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/pack_tickets/${packticketId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PackTicketSimple>>>
  _tombolaRafflesRaffleIdPackTicketsGet({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/pack_tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PackTicketSimple>, PackTicketSimple>($request);
  }

  @override
  Future<Response<List<TicketSimple>>> _tombolaTicketsGet({
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
  }) {
    final Uri $url = Uri.parse('/tombola/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TicketSimple>, TicketSimple>($request);
  }

  @override
  Future<Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaTicketsBuyPackIdPost({
    required String? packId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/tickets/buy/${packId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesRaffleSchemasRaffleTicketComplete>,
      AppModulesRaffleSchemasRaffleTicketComplete
    >($request);
  }

  @override
  Future<Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaUsersUserIdTicketsGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesRaffleSchemasRaffleTicketComplete>,
      AppModulesRaffleSchemasRaffleTicketComplete
    >($request);
  }

  @override
  Future<Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaRafflesRaffleIdTicketsGet({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesRaffleSchemasRaffleTicketComplete>,
      AppModulesRaffleSchemasRaffleTicketComplete
    >($request);
  }

  @override
  Future<Response<List<PrizeSimple>>> _tombolaPrizesGet({
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
  }) {
    final Uri $url = Uri.parse('/tombola/prizes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PrizeSimple>, PrizeSimple>($request);
  }

  @override
  Future<Response<PrizeSimple>> _tombolaPrizesPost({
    required PrizeBase? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/prizes');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<PrizeSimple, PrizeSimple>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPrizesPrizeIdPatch({
    required String? prizeId,
    required PrizeEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaPrizesPrizeIdDelete({
    required String? prizeId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PrizeSimple>>> _tombolaRafflesRaffleIdPrizesGet({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/prizes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PrizeSimple>, PrizeSimple>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
  _tombolaPrizesPrizeIdPicturePost({
    required String? prizeId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}/picture');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _tombolaPrizesPrizeIdPictureGet({
    required String? prizeId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}/picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesRaffleSchemasRaffleCashComplete>>>
  _tombolaUsersCashGet({
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
  }) {
    final Uri $url = Uri.parse('/tombola/users/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesRaffleSchemasRaffleCashComplete>,
      AppModulesRaffleSchemasRaffleCashComplete
    >($request);
  }

  @override
  Future<Response<AppModulesRaffleSchemasRaffleCashComplete>>
  _tombolaUsersUserIdCashGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesRaffleSchemasRaffleCashComplete,
      AppModulesRaffleSchemasRaffleCashComplete
    >($request);
  }

  @override
  Future<Response<AppModulesRaffleSchemasRaffleCashComplete>>
  _tombolaUsersUserIdCashPost({
    required String? userId,
    required CashEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AppModulesRaffleSchemasRaffleCashComplete,
      AppModulesRaffleSchemasRaffleCashComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _tombolaUsersUserIdCashPatch({
    required String? userId,
    required CashEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/tombola/users/${userId}/cash');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppModulesRaffleSchemasRaffleTicketComplete>>>
  _tombolaPrizesPrizeIdDrawPost({
    required String? prizeId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/prizes/${prizeId}/draw');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppModulesRaffleSchemasRaffleTicketComplete>,
      AppModulesRaffleSchemasRaffleTicketComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdOpenPatch({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/open');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _tombolaRafflesRaffleIdLockPatch({
    required String? raffleId,
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
  }) {
    final Uri $url = Uri.parse('/tombola/raffles/${raffleId}/lock');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<FlappyBirdScoreInDB>>> _flappybirdScoresGet({
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
  }) {
    final Uri $url = Uri.parse('/flappybird/scores');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<FlappyBirdScoreInDB>, FlappyBirdScoreInDB>(
      $request,
    );
  }

  @override
  Future<Response<FlappyBirdScoreInDB>> _flappybirdScoresPost({
    required FlappyBirdScoreBase? body,
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
  }) {
    final Uri $url = Uri.parse('/flappybird/scores');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<FlappyBirdScoreInDB, FlappyBirdScoreInDB>($request);
  }

  @override
  Future<Response<FlappyBirdScoreCompleteFeedBack>> _flappybirdScoresMeGet({
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
  }) {
    final Uri $url = Uri.parse('/flappybird/scores/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client
        .send<FlappyBirdScoreCompleteFeedBack, FlappyBirdScoreCompleteFeedBack>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _flappybirdScoresTargetedUserIdDelete({
    required String? targetedUserId,
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
  }) {
    final Uri $url = Uri.parse('/flappybird/scores/${targetedUserId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<EventSimple>>> _ticketsEventsGet({
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
  }) {
    final Uri $url = Uri.parse('/tickets/events');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<EventSimple>, EventSimple>($request);
  }

  @override
  Future<Response<EventPublic>> _ticketsEventsEventIdGet({
    required String? eventId,
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
  }) {
    final Uri $url = Uri.parse('/tickets/events/${eventId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<EventPublic, EventPublic>($request);
  }

  @override
  Future<Response<CheckoutResponse>> _ticketsEventsEventIdCheckoutPost({
    required String? eventId,
    required Checkout? body,
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
  }) {
    final Uri $url = Uri.parse('/tickets/events/${eventId}/checkout');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CheckoutResponse, CheckoutResponse>($request);
  }

  @override
  Future<Response<List<AppCoreTicketsSchemasTicketsTicketComplete>>>
  _ticketsUserMeTicketsGet({
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
  }) {
    final Uri $url = Uri.parse('/tickets/user/me/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppCoreTicketsSchemasTicketsTicketComplete>,
      AppCoreTicketsSchemasTicketsTicketComplete
    >($request);
  }

  @override
  Future<Response<dynamic>> _ticketsUserMeTicketsChangeOverRequestPost({
    required TicketChangeOverInvitation? body,
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
  }) {
    final Uri $url = Uri.parse('/tickets/user/me/tickets/change-over/request');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _ticketsUserMeTicketsChangeOverAcceptGet({
    required String? token,
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
  }) {
    final Uri $url = Uri.parse('/tickets/user/me/tickets/change-over/accept');
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EventAdmin>> _ticketsAdminEventsEventIdGet({
    required String? eventId,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/events/${eventId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<EventAdmin, EventAdmin>($request);
  }

  @override
  Future<Response<dynamic>> _ticketsAdminEventsEventIdPatch({
    required String? eventId,
    required EventUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/events/${eventId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EventAdmin>> _ticketsAdminEventsPost({
    required EventCreate? body,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/events');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<EventAdmin, EventAdmin>($request);
  }

  @override
  Future<Response<SessionComplete>> _ticketsAdminEventsEventIdSessionsPost({
    required String? eventId,
    required SessionCreate? body,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/events/${eventId}/sessions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<SessionComplete, SessionComplete>($request);
  }

  @override
  Future<Response<dynamic>> _ticketsAdminEventsEventIdSessionsSessionIdPatch({
    required String? eventId,
    required String? sessionId,
    required SessionUpdate? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/tickets/admin/events/${eventId}/sessions/${sessionId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CategoryComplete>> _ticketsAdminEventsEventIdCategoriesPost({
    required String? eventId,
    required CategoryCreate? body,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/events/${eventId}/categories');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CategoryComplete, CategoryComplete>($request);
  }

  @override
  Future<Response<dynamic>>
  _ticketsAdminEventsEventIdCategoriesCategoryIdPatch({
    required String? eventId,
    required String? categoryId,
    required CategoryUpdate? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/tickets/admin/events/${eventId}/categories/${categoryId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _ticketsAdminEventsEventIdQuestionsQuestionIdPatch({
    required String? eventId,
    required String? questionId,
    required QuestionUpdate? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/tickets/admin/events/${eventId}/questions/${questionId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<AppCoreTicketsSchemasTicketsTicket>>>
  _ticketsAdminEventsEventIdTicketsGet({
    required String? eventId,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/events/${eventId}/tickets');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      List<AppCoreTicketsSchemasTicketsTicket>,
      AppCoreTicketsSchemasTicketsTicket
    >($request);
  }

  @override
  Future<Response<dynamic>> _ticketsAdminEventsEventIdTicketsCsvGet({
    required String? eventId,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/events/${eventId}/tickets/csv');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppCoreTicketsSchemasTicketsTicket>>
  _ticketsAdminTicketsTicketIdCheckPost({
    required String? ticketId,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/tickets/${ticketId}/check');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<
      AppCoreTicketsSchemasTicketsTicket,
      AppCoreTicketsSchemasTicketsTicket
    >($request);
  }

  @override
  Future<Response<dynamic>> _ticketsAdminTicketsTicketIdScanPost({
    required String? ticketId,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/tickets/${ticketId}/scan');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<EventSimple>>> _ticketsAdminStoreStoreIdEventsGet({
    required String? storeId,
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
  }) {
    final Uri $url = Uri.parse('/tickets/admin/store/${storeId}/events');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<EventSimple>, EventSimple>($request);
  }

  @override
  Future<Response<List<EventSimple>>>
  _ticketsAdminAssociationAssociationIdEventsGet({
    required String? associationId,
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
  }) {
    final Uri $url = Uri.parse(
      '/tickets/admin/association/${associationId}/events',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<EventSimple>, EventSimple>($request);
  }

  @override
  Future<Response<List<Association>>> _associationsGet({
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
  }) {
    final Uri $url = Uri.parse('/associations/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Association>, Association>($request);
  }

  @override
  Future<Response<Association>> _associationsPost({
    required AppCoreAssociationsSchemasAssociationsAssociationBase? body,
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
  }) {
    final Uri $url = Uri.parse('/associations/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Association, Association>($request);
  }

  @override
  Future<Response<List<Association>>> _associationsMeGet({
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
  }) {
    final Uri $url = Uri.parse('/associations/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Association>, Association>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdPatch({
    required String? associationId,
    required AssociationUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/associations/${associationId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdLogoPost({
    required String? associationId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/associations/${associationId}/logo');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _associationsAssociationIdLogoGet({
    required String? associationId,
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
  }) {
    final Uri $url = Uri.parse('/associations/${associationId}/logo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AccessToken>> _authSimpleTokenPost({
    required Map<String, String> body,
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
  }) {
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
      tag: swaggerMetaData,
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _authAuthorizePost({
    required Map<String, String> body,
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
  }) {
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
      tag: swaggerMetaData,
    );
    return client.send<String, String>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<dynamic>> _authAuthorizationFlowAuthorizeValidationPost({
    required Map<String, String> body,
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
  }) {
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
      tag: swaggerMetaData,
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
      tag: swaggerMetaData,
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
      tag: swaggerMetaData,
    );
    return client.send<IntrospectTokenResponse, IntrospectTokenResponse>(
      $request,
      requestConverter: FormUrlEncodedConverter.requestFactory,
    );
  }

  @override
  Future<Response<dynamic>> _authUserinfoGet({
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
  }) {
    final Uri $url = Uri.parse('/auth/userinfo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _oidcAuthorizationFlowJwksUriGet({
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
  }) {
    final Uri $url = Uri.parse('/oidc/authorization-flow/jwks_uri');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _wellKnownOauthAuthorizationServerGet({
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
  }) {
    final Uri $url = Uri.parse('/.well-known/oauth-authorization-server');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _wellKnownOpenidConfigurationGet({
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
  }) {
    final Uri $url = Uri.parse('/.well-known/openid-configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CoreInformation>> _informationGet({
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
  }) {
    final Uri $url = Uri.parse('/information');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CoreInformation, CoreInformation>($request);
  }

  @override
  Future<Response<dynamic>> _privacyGet({
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
  }) {
    final Uri $url = Uri.parse('/privacy');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _termsAndConditionsGet({
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
  }) {
    final Uri $url = Uri.parse('/terms-and-conditions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentTermsOfServiceGet({
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
  }) {
    final Uri $url = Uri.parse('/mypayment-terms-of-service');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _supportGet({
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
  }) {
    final Uri $url = Uri.parse('/support');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _securityTxtGet({
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
  }) {
    final Uri $url = Uri.parse('/security.txt');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _wellKnownSecurityTxtGet({
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
  }) {
    final Uri $url = Uri.parse('/.well-known/security.txt');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _robotsTxtGet({
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
  }) {
    final Uri $url = Uri.parse('/robots.txt');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _accountDeletionGet({
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
  }) {
    final Uri $url = Uri.parse('/account-deletion');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CoreVariables>> _variablesGet({
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
  }) {
    final Uri $url = Uri.parse('/variables');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CoreVariables, CoreVariables>($request);
  }

  @override
  Future<Response<dynamic>> _faviconIcoGet({
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
  }) {
    final Uri $url = Uri.parse('/favicon.ico');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationDevicesPost({
    required BodyRegisterFirebaseDeviceNotificationDevicesPost? body,
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
  }) {
    final Uri $url = Uri.parse('/notification/devices');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<FirebaseDevice>>> _notificationDevicesGet({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/notification/devices');
    final Map<String, dynamic> $params = <String, dynamic>{'user_id': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<FirebaseDevice>, FirebaseDevice>($request);
  }

  @override
  Future<Response<dynamic>> _notificationDevicesFirebaseTokenDelete({
    required String? firebaseToken,
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
  }) {
    final Uri $url = Uri.parse('/notification/devices/${firebaseToken}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTopicsTopicIdSubscribePost({
    required String? topicId,
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
  }) {
    final Uri $url = Uri.parse('/notification/topics/${topicId}/subscribe');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTopicsTopicIdUnsubscribePost({
    required String? topicId,
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
  }) {
    final Uri $url = Uri.parse('/notification/topics/${topicId}/unsubscribe');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TopicUser>>> _notificationTopicsGet({
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
  }) {
    final Uri $url = Uri.parse('/notification/topics');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<TopicUser>, TopicUser>($request);
  }

  @override
  Future<Response<dynamic>> _notificationSendPost({
    required GroupNotificationRequest? body,
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
  }) {
    final Uri $url = Uri.parse('/notification/send');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTestSendPost({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/notification/test/send');
    final Map<String, dynamic> $params = <String, dynamic>{'user_id': userId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTestSendFuturePost({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/notification/test/send/future');
    final Map<String, dynamic> $params = <String, dynamic>{'user_id': userId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTestSendTopicPost({
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
  }) {
    final Uri $url = Uri.parse('/notification/test/send/topic');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _notificationTestSendTopicFuturePost({
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
  }) {
    final Uri $url = Uri.parse('/notification/test/send/topic/future');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CoreGroupSimple>>> _groupsGet({
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
  }) {
    final Uri $url = Uri.parse('/groups/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CoreGroupSimple>, CoreGroupSimple>($request);
  }

  @override
  Future<Response<CoreGroupSimple>> _groupsPost({
    required CoreGroupCreate? body,
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
  }) {
    final Uri $url = Uri.parse('/groups/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CoreGroupSimple, CoreGroupSimple>($request);
  }

  @override
  Future<Response<CoreGroup>> _groupsGroupIdGet({
    required String? groupId,
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
  }) {
    final Uri $url = Uri.parse('/groups/${groupId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CoreGroup, CoreGroup>($request);
  }

  @override
  Future<Response<dynamic>> _groupsGroupIdPatch({
    required String? groupId,
    required CoreGroupUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/groups/${groupId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsGroupIdDelete({
    required String? groupId,
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
  }) {
    final Uri $url = Uri.parse('/groups/${groupId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CoreGroup>> _groupsMembershipPost({
    required CoreMembership? body,
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
  }) {
    final Uri $url = Uri.parse('/groups/membership');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CoreGroup, CoreGroup>($request);
  }

  @override
  Future<Response<dynamic>> _groupsMembershipDelete({
    required CoreMembershipDelete? body,
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
  }) {
    final Uri $url = Uri.parse('/groups/membership');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsBatchMembershipPost({
    required CoreBatchMembership? body,
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
  }) {
    final Uri $url = Uri.parse('/groups/batch-membership');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsBatchMembershipDelete({
    required CoreBatchDeleteMembership? body,
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
  }) {
    final Uri $url = Uri.parse('/groups/batch-membership');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsGroupIdLogoPost({
    required String? groupId,
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/groups/${groupId}/logo');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _groupsGroupIdLogoGet({
    required String? groupId,
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
  }) {
    final Uri $url = Uri.parse('/groups/${groupId}/logo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _permissionsListGet({
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
  }) {
    final Uri $url = Uri.parse('/permissions/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<List<CorePermission>>> _permissionsGet({
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
  }) {
    final Uri $url = Uri.parse('/permissions/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CorePermission>, CorePermission>($request);
  }

  @override
  Future<Response<dynamic>> _permissionsPost({
    required Object? body,
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
  }) {
    final Uri $url = Uri.parse('/permissions/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _permissionsDelete({
    required Object? body,
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
  }) {
    final Uri $url = Uri.parse('/permissions/');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CorePermission>> _permissionsPermissionNameGet({
    required String? permissionName,
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
  }) {
    final Uri $url = Uri.parse('/permissions/${permissionName}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CorePermission, CorePermission>($request);
  }

  @override
  Future<Response<dynamic>> _checkoutHelloassoWebhookPost({
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
  }) {
    final Uri $url = Uri.parse('/checkout/helloasso/webhook');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Structure>> _mypaymentBankAccountHolderGet({
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
  }) {
    final Uri $url = Uri.parse('/mypayment/bank-account-holder');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<Structure, Structure>($request);
  }

  @override
  Future<Response<Structure>> _mypaymentBankAccountHolderPost({
    required MyPaymentBankAccountHolder? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/bank-account-holder');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Structure, Structure>($request);
  }

  @override
  Future<Response<List<Structure>>> _mypaymentStructuresGet({
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
  }) {
    final Uri $url = Uri.parse('/mypayment/structures');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Structure>, Structure>($request);
  }

  @override
  Future<Response<Structure>> _mypaymentStructuresPost({
    required StructureBase? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/structures');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Structure, Structure>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStructuresStructureIdPatch({
    required String? structureId,
    required StructureUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/structures/${structureId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStructuresStructureIdDelete({
    required String? structureId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/structures/${structureId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _mypaymentStructuresStructureIdInitManagerTransferPost({
    required String? structureId,
    required StructureTranfert? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/structures/${structureId}/init-manager-transfer',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStructuresConfirmManagerTransferGet({
    required String? token,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/structures/confirm-manager-transfer',
    );
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserStore>> _mypaymentStructuresStructureIdStoresPost({
    required String? structureId,
    required StoreBase? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/structures/${structureId}/stores');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<UserStore, UserStore>($request);
  }

  @override
  Future<Response<List<History>>> _mypaymentStoresStoreIdHistoryGet({
    required String? storeId,
    String? startDate,
    String? endDate,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/stores/${storeId}/history');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start_date': startDate,
      'end_date': endDate,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<History>, History>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStoresStoreIdHistoryDataExportGet({
    required String? storeId,
    String? startDate,
    String? endDate,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/stores/${storeId}/history/data-export',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'start_date': startDate,
      'end_date': endDate,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserStore>>> _mypaymentUsersMeStoresGet({
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/stores');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<UserStore>, UserStore>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStoresStoreIdPatch({
    required String? storeId,
    required StoreUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/stores/${storeId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStoresStoreIdDelete({
    required String? storeId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/stores/${storeId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Seller>> _mypaymentStoresStoreIdSellersPost({
    required String? storeId,
    required SellerCreation? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/stores/${storeId}/sellers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Seller, Seller>($request);
  }

  @override
  Future<Response<List<Seller>>> _mypaymentStoresStoreIdSellersGet({
    required String? storeId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/stores/${storeId}/sellers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<Seller>, Seller>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStoresStoreIdSellersSellerUserIdPatch({
    required String? storeId,
    required String? sellerUserId,
    required SellerUpdate? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/stores/${storeId}/sellers/${sellerUserId}',
    );
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentStoresStoreIdSellersSellerUserIdDelete({
    required String? storeId,
    required String? sellerUserId,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/stores/${storeId}/sellers/${sellerUserId}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentUsersMeRegisterPost({
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/register');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TOSSignatureResponse>> _mypaymentUsersMeTosGet({
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/tos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<TOSSignatureResponse, TOSSignatureResponse>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentUsersMeTosPost({
    required TOSSignature? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/tos');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<WalletDevice>>> _mypaymentUsersMeWalletDevicesGet({
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/wallet/devices');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<WalletDevice>, WalletDevice>($request);
  }

  @override
  Future<Response<WalletDevice>> _mypaymentUsersMeWalletDevicesPost({
    required WalletDeviceCreation? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/wallet/devices');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<WalletDevice, WalletDevice>($request);
  }

  @override
  Future<Response<WalletDevice>>
  _mypaymentUsersMeWalletDevicesWalletDeviceIdGet({
    required String? walletDeviceId,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/users/me/wallet/devices/${walletDeviceId}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<WalletDevice, WalletDevice>($request);
  }

  @override
  Future<Response<Wallet>> _mypaymentUsersMeWalletGet({
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/wallet');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<Wallet, Wallet>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentDevicesActivateGet({
    required String? token,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/devices/activate');
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _mypaymentUsersMeWalletDevicesWalletDeviceIdRevokePost({
    required String? walletDeviceId,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/users/me/wallet/devices/${walletDeviceId}/revoke',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<History>>> _mypaymentUsersMeWalletHistoryGet({
    String? startDate,
    String? endDate,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/users/me/wallet/history');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start_date': startDate,
      'end_date': endDate,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<History>, History>($request);
  }

  @override
  Future<Response<PaymentUrl>> _mypaymentTransferInitPost({
    required TransferInfo? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/transfer/init');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<PaymentUrl>> _mypaymentTransferRedirectGet({
    required String? url,
    String? checkoutIntentId,
    String? code,
    String? orderId,
    String? error,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/transfer/redirect');
    final Map<String, dynamic> $params = <String, dynamic>{
      'url': url,
      'checkoutIntentId': checkoutIntentId,
      'code': code,
      'orderId': orderId,
      'error': error,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<PaymentUrl, PaymentUrl>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>>
  _mypaymentStoresStoreIdScanCheckPost({
    required String? storeId,
    required ScanInfo? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/stores/${storeId}/scan/check');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<History>> _mypaymentStoresStoreIdScanPost({
    required String? storeId,
    required ScanInfo? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/stores/${storeId}/scan');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<History, History>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentTransactionsTransactionIdRefundPost({
    required String? transactionId,
    required RefundInfo? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/transactions/${transactionId}/refund',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentTransactionsTransactionIdCancelPost({
    required String? transactionId,
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
  }) {
    final Uri $url = Uri.parse(
      '/mypayment/transactions/${transactionId}/cancel',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Request$>>> _mypaymentRequestsGet({
    bool? used,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/requests');
    final Map<String, dynamic> $params = <String, dynamic>{'used': used};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<Request$>, Request$>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentRequestsRequestIdAcceptPost({
    required String? requestId,
    required SignedContent? body,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/requests/${requestId}/accept');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentRequestsRequestIdRefusePost({
    required String? requestId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/requests/${requestId}/refuse');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Invoice>>> _mypaymentInvoicesGet({
    int? page,
    int? pageSize,
    List<dynamic>? structuresIds,
    String? startDate,
    String? endDate,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/invoices');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
      'structures_ids': structuresIds,
      'start_date': startDate,
      'end_date': endDate,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<Invoice>, Invoice>($request);
  }

  @override
  Future<Response<List<Invoice>>> _mypaymentInvoicesStructuresStructureIdGet({
    required String? structureId,
    int? page,
    int? pageSize,
    String? startDate,
    String? endDate,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/invoices/structures/${structureId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
      'start_date': startDate,
      'end_date': endDate,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<Invoice>, Invoice>($request);
  }

  @override
  Future<Response<Invoice>> _mypaymentInvoicesStructuresStructureIdPost({
    required String? structureId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/invoices/structures/${structureId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<Invoice, Invoice>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentInvoicesInvoiceIdGet({
    required String? invoiceId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/invoices/${invoiceId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentInvoicesInvoiceIdDelete({
    required String? invoiceId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/invoices/${invoiceId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentInvoicesInvoiceIdPaidPatch({
    required String? invoiceId,
    required bool? paid,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/invoices/${invoiceId}/paid');
    final Map<String, dynamic> $params = <String, dynamic>{'paid': paid};
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mypaymentInvoicesInvoiceIdReceivedPatch({
    required String? invoiceId,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/invoices/${invoiceId}/received');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<IntegrityCheckData>> _mypaymentIntegrityCheckGet({
    String? lastChecked,
    bool? isInitialisation,
    String? xDataVerifierToken,
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
  }) {
    final Uri $url = Uri.parse('/mypayment/integrity-check');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lastChecked': lastChecked,
      'isInitialisation': isInitialisation,
    };
    final Map<String, String> $headers = {
      if (xDataVerifierToken != null)
        'x_data_verifier_token': xDataVerifierToken,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<IntegrityCheckData, IntegrityCheckData>($request);
  }

  @override
  Future<Response<List<News>>> _feedNewsGet({
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
  }) {
    final Uri $url = Uri.parse('/feed/news');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<News>, News>($request);
  }

  @override
  Future<Response<dynamic>> _feedNewsNewsIdImageGet({
    required String? newsId,
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
  }) {
    final Uri $url = Uri.parse('/feed/news/${newsId}/image');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<News>>> _feedAdminNewsGet({
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
  }) {
    final Uri $url = Uri.parse('/feed/admin/news');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<News>, News>($request);
  }

  @override
  Future<Response<dynamic>> _feedAdminNewsNewsIdApprovePost({
    required String? newsId,
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
  }) {
    final Uri $url = Uri.parse('/feed/admin/news/${newsId}/approve');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _feedAdminNewsNewsIdRejectPost({
    required String? newsId,
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
  }) {
    final Uri $url = Uri.parse('/feed/admin/news/${newsId}/reject');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<MembershipSimple>>> _membershipsGet({
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
  }) {
    final Uri $url = Uri.parse('/memberships/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<MembershipSimple>, MembershipSimple>($request);
  }

  @override
  Future<Response<MembershipSimple>> _membershipsPost({
    required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
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
  }) {
    final Uri $url = Uri.parse('/memberships/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
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
  }) {
    final Uri $url = Uri.parse(
      '/memberships/${associationMembershipId}/members',
    );
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
      tag: swaggerMetaData,
    );
    return client.send<List<UserMembershipComplete>, UserMembershipComplete>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _membershipsAssociationMembershipIdPatch({
    required String? associationMembershipId,
    required AppCoreMembershipsSchemasMembershipsMembershipBase? body,
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
  }) {
    final Uri $url = Uri.parse('/memberships/${associationMembershipId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _membershipsAssociationMembershipIdDelete({
    required String? associationMembershipId,
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
  }) {
    final Uri $url = Uri.parse('/memberships/${associationMembershipId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserMembershipComplete>>> _membershipsUsersUserIdGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/memberships/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<UserMembershipComplete>, UserMembershipComplete>(
      $request,
    );
  }

  @override
  Future<Response<UserMembershipComplete>> _membershipsUsersUserIdPost({
    required String? userId,
    required UserMembershipBase? body,
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
  }) {
    final Uri $url = Uri.parse('/memberships/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<UserMembershipComplete, UserMembershipComplete>(
      $request,
    );
  }

  @override
  Future<Response<List<UserMembershipComplete>>>
  _membershipsUsersUserIdAssociationMembershipIdGet({
    required String? userId,
    required String? associationMembershipId,
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
  }) {
    final Uri $url = Uri.parse(
      '/memberships/users/${userId}/${associationMembershipId}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<UserMembershipComplete>, UserMembershipComplete>(
      $request,
    );
  }

  @override
  Future<Response<List<MembershipUserMappingEmail>>>
  _membershipsAssociationMembershipIdAddBatchPost({
    required String? associationMembershipId,
    required List<MembershipUserMappingEmail>? body,
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
  }) {
    final Uri $url = Uri.parse(
      '/memberships/${associationMembershipId}/add-batch/',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<List<MembershipUserMappingEmail>, MembershipUserMappingEmail>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _membershipsUsersMembershipIdPatch({
    required String? membershipId,
    required UserMembershipEdit? body,
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
  }) {
    final Uri $url = Uri.parse('/memberships/users/${membershipId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _membershipsUsersMembershipIdDelete({
    required String? membershipId,
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
  }) {
    final Uri $url = Uri.parse('/memberships/users/${membershipId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>>
  _membershipsMembershipIdGroupGroupIdSynchronizePost({
    required String? membershipId,
    required String? groupId,
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
  }) {
    final Uri $url = Uri.parse(
      '/memberships/${membershipId}/group/${groupId}/synchronize',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CoreUserSimple>>> _usersGet({
    List<Object?>? accountTypes,
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
  }) {
    final Uri $url = Uri.parse('/users');
    final Map<String, dynamic> $params = <String, dynamic>{
      'accountTypes': accountTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<CoreUserSimple>, CoreUserSimple>($request);
  }

  @override
  Future<Response<int>> _usersCountGet({
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
  }) {
    final Uri $url = Uri.parse('/users/count');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
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
      tag: swaggerMetaData,
    );
    return client.send<List<CoreUserSimple>, CoreUserSimple>($request);
  }

  @override
  Future<Response<List<AccountType>>> _usersAccountTypesGet({
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
  }) {
    final Uri $url = Uri.parse('/users/account-types/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<AccountType>, AccountType>($request);
  }

  @override
  Future<Response<CoreUser>> _usersMeGet({
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
  }) {
    final Uri $url = Uri.parse('/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CoreUser, CoreUser>($request);
  }

  @override
  Future<Response<dynamic>> _usersMePatch({
    required CoreUserUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/users/me');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersCreatePost({
    required CoreUserCreateRequest? body,
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
  }) {
    final Uri $url = Uri.parse('/users/create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<BatchResult>> _usersBatchCreationPost({
    required List<CoreBatchUserCreateRequest>? body,
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
  }) {
    final Uri $url = Uri.parse('/users/batch-creation');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<BatchResult, BatchResult>($request);
  }

  @override
  Future<Response<BatchResult>> _usersBatchInvitationPost({
    required List<CoreBatchUserCreateRequest>? body,
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
  }) {
    final Uri $url = Uri.parse('/users/batch-invitation');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<BatchResult, BatchResult>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersActivatePost({
    required CoreUserActivateRequest? body,
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
  }) {
    final Uri $url = Uri.parse('/users/activate');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _usersS3InitPost({
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
  }) {
    final Uri $url = Uri.parse('/users/s3-init');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersRecoverPost({
    required BodyRecoverUserUsersRecoverPost? body,
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
  }) {
    final Uri $url = Uri.parse('/users/recover');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersResetPasswordPost({
    required ResetPasswordRequest? body,
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
  }) {
    final Uri $url = Uri.parse('/users/reset-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _usersMigrateMailPost({
    required MailMigrationRequest? body,
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
  }) {
    final Uri $url = Uri.parse('/users/migrate-mail');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMigrateMailConfirmGet({
    required String? token,
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
  }) {
    final Uri $url = Uri.parse('/users/migrate-mail-confirm');
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersChangePasswordPost({
    required ChangePasswordRequest? body,
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
  }) {
    final Uri $url = Uri.parse('/users/change-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<CoreUser>> _usersUserIdGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CoreUser, CoreUser>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdPatch({
    required String? userId,
    required CoreUserUpdateAdmin? body,
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
  }) {
    final Uri $url = Uri.parse('/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMeAskDeletionPost({
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
  }) {
    final Uri $url = Uri.parse('/users/me/ask-deletion');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMergePost({
    required CoreUserFusionRequest? body,
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
  }) {
    final Uri $url = Uri.parse('/users/merge');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdSuperAdminPatch({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/users/${userId}/super-admin');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersMeProfilePictureGet({
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
  }) {
    final Uri $url = Uri.parse('/users/me/profile-picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AppTypesStandardResponsesResult>> _usersMeProfilePicturePost({
    required List<int> image,
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
  }) {
    final Uri $url = Uri.parse('/users/me/profile-picture');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>>('image', image),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
      tag: swaggerMetaData,
    );
    return client
        .send<AppTypesStandardResponsesResult, AppTypesStandardResponsesResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _usersUserIdProfilePictureGet({
    required String? userId,
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
  }) {
    final Uri $url = Uri.parse('/users/${userId}/profile-picture');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<CoreSchool>>> _schoolsGet({
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
  }) {
    final Uri $url = Uri.parse('/schools/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CoreSchool>, CoreSchool>($request);
  }

  @override
  Future<Response<CoreSchool>> _schoolsPost({
    required CoreSchoolBase? body,
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
  }) {
    final Uri $url = Uri.parse('/schools/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<CoreSchool, CoreSchool>($request);
  }

  @override
  Future<Response<CoreSchool>> _schoolsSchoolIdGet({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/schools/${schoolId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CoreSchool, CoreSchool>($request);
  }

  @override
  Future<Response<dynamic>> _schoolsSchoolIdPatch({
    required String? schoolId,
    required CoreSchoolUpdate? body,
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
  }) {
    final Uri $url = Uri.parse('/schools/${schoolId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _schoolsSchoolIdDelete({
    required String? schoolId,
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
  }) {
    final Uri $url = Uri.parse('/schools/${schoolId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _googleApiOauth2callbackGet({
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
  }) {
    final Uri $url = Uri.parse('/google-api/oauth2callback');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
