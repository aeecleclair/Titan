import 'package:flutter/foundation.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'dart:developer' as developer;

/// A type definition for factory functions that create empty model instances
typedef EmptyFactory<T> = T Function();

/// A class that manages empty model instances across your Flutter application
class EmptyModels {
  EmptyModels._(); // Private constructor to prevent instantiation

  // A map to store factory functions for different model types
  static final Map<Type, dynamic> _factories = {};

  // A flag to track initialization
  static bool _isInitialized = false;

  /// Register a factory function for a specific model type
  static void register<T>(EmptyFactory<T> factory) {
    _factories[T] = factory;
  }

  /// Get an empty instance of a model type
  static T empty<T>() {
    // Auto-initialize if not done yet
    if (!_isInitialized) {
      initialize();
    }

    if (!_factories.containsKey(T)) {
      developer.log(
        'Warning: No empty factory registered for type $T',
        name: 'EmptyModels',
      );

      // Try to provide generic defaults for common types
      if (T == String) {
        return '' as T;
      } else if (T == int) {
        return 0 as T;
      } else if (T == double) {
        return 0.0 as T;
      } else if (T == bool) {
        return false as T;
      } else if (T == List) {
        return <dynamic>[] as T;
      } else if (T == Map) {
        return <String, dynamic>{} as T;
      }

      // For other types, we must throw since we can't create them generically
      throw FlutterError('No empty factory registered for type $T. '
          'Make sure to register it using EmptyModels.register<$T>().');
    }

    return _factories[T]() as T;
  }

  /// Initialize with all generated model factories
  static void initialize() {
    if (_isInitialized) return;

    try {
      // This will call the generated function that registers all models
      registerAllEmptyFactories();
      _isInitialized = true;
    } catch (e) {
      developer.log(
        'Error initializing EmptyModels: $e',
        name: 'EmptyModels',
        error: e,
      );
      // Still mark as initialized to prevent repeated attempts
      _isInitialized = true;
    }
  }

  /// Safe version that returns null instead of throwing for unregistered types
  static T? emptyOrNull<T>() {
    try {
      return empty<T>();
    } catch (_) {
      return null;
    }
  }
}

void registerAllEmptyFactories() {
  EmptyModels.register<CoreUser>(
    () => CoreUser(
      name: '',
      firstname: '',
      id: '',
      accountType: AccountType.$external,
      schoolId: '',
      email: '',
    ),
  );

  EmptyModels.register<CoreUserSimple>(
    () => CoreUserSimple(
      name: '',
      firstname: '',
      id: '',
      accountType: AccountType.$external,
      schoolId: '',
    ),
  );

  EmptyModels.register<CoreGroup>(
    () => CoreGroup(
      id: '',
      name: '',
    ),
  );

  EmptyModels.register<CoreGroupSimple>(
    () => CoreGroupSimple(
      id: '',
      name: '',
    ),
  );

  EmptyModels.register<CoreSchool>(
    () => CoreSchool(
      id: '',
      name: '',
      emailRegex: '',
    ),
  );

  EmptyModels.register<AdvertiserComplete>(
    () => AdvertiserComplete(name: '', groupManagerId: '', id: 'id'),
  );

  EmptyModels.register<AdvertReturnComplete>(
    () => AdvertReturnComplete(
      title: '',
      content: '',
      id: '',
      advertiserId: '',
      advertiser: EmptyModels.empty<AdvertiserComplete>(),
    ),
  );

  EmptyModels.register<DeliveryReturn>(
    () => DeliveryReturn(
      id: '',
      deliveryDate: DateTime.now(),
      status: DeliveryStatusType.creation,
    ),
  );

  EmptyModels.register<OrderReturn>(
    () => OrderReturn(
      user: EmptyModels.empty<CoreUserSimple>(),
      deliveryId: '',
      productsdetail: [],
      collectionSlot: AmapSlotType.midi,
      orderId: '',
      amount: 0.0,
      orderingDate: DateTime.now(),
      deliveryDate: DateTime.now(),
    ),
  );

  EmptyModels.register<AppModulesAmapSchemasAmapProductComplete>(
    () => AppModulesAmapSchemasAmapProductComplete(
      id: '',
      name: '',
      price: 0.0,
      category: '',
    ),
  );

  EmptyModels.register<ProductQuantity>(
    () => ProductQuantity(
      product: EmptyModels.empty<AppModulesAmapSchemasAmapProductComplete>(),
      quantity: 0,
    ),
  );

  EmptyModels.register<TokenResponse>(
    () => TokenResponse(
      accessToken: '',
      refreshToken: '',
    ),
  );

  EmptyModels.register<Applicant>(
    () => Applicant(
      name: '',
      firstname: '',
      id: '',
      accountType: AccountType.$external,
      schoolId: '',
      email: '',
    ),
  );

  EmptyModels.register<RoomComplete>(
    () => RoomComplete(
      id: '',
      name: '',
      managerId: '',
    ),
  );

  EmptyModels.register<BookingReturnSimpleApplicant>(
    () => BookingReturnSimpleApplicant(
      reason: '',
      start: DateTime.now(),
      end: DateTime.now(),
      creation: DateTime.now(),
      roomId: '',
      key: false,
      id: '',
      decision: Decision.approved,
      applicantId: '',
      room: EmptyModels.empty<RoomComplete>(),
      applicant: EmptyModels.empty<CoreUserSimple>(),
    ),
  );

  EmptyModels.register<BookingReturn>(
    () => BookingReturn(
      reason: '',
      start: DateTime.now(),
      end: DateTime.now(),
      creation: DateTime.now(),
      roomId: '',
      key: false,
      id: '',
      decision: Decision.approved,
      applicantId: '',
      room: EmptyModels.empty<RoomComplete>(),
    ),
  );

  EmptyModels.register<BookingReturnApplicant>(
    () => BookingReturnApplicant(
      reason: '',
      start: DateTime.now(),
      end: DateTime.now(),
      creation: DateTime.now(),
      roomId: '',
      key: true,
      id: '',
      decision: Decision.approved,
      applicantId: '',
      room: EmptyModels.empty<RoomComplete>(),
      applicant: EmptyModels.empty<Applicant>(),
    ),
  );

  EmptyModels.register<Manager>(
    () => Manager(
      groupId: '',
      name: '',
      id: '',
    ),
  );

  EmptyModels.register<CineSessionComplete>(
    () => CineSessionComplete(
      start: DateTime.now(),
      duration: 0,
      name: '',
      overview: '',
      id: '',
    ),
  );

  EmptyModels.register<EventApplicant>(
    () => EventApplicant(
      name: '',
      firstname: '',
      id: '',
      accountType: AccountType.$external,
      schoolId: '',
      email: '',
    ),
  );

  EmptyModels.register<EventComplete>(
    () => EventComplete(
      name: '',
      organizer: '',
      start: DateTime.now(),
      end: DateTime.now(),
      allDay: false,
      location: '',
      type: CalendarEventType.autre,
      description: '',
      id: '',
      decision: Decision.approved,
      applicantId: '',
    ),
  );

  EmptyModels.register<EventReturn>(
    () => EventReturn(
      name: '',
      organizer: '',
      start: DateTime.now(),
      end: DateTime.now(),
      allDay: false,
      location: '',
      type: CalendarEventType.autre,
      description: '',
      id: '',
      decision: Decision.approved,
      applicantId: '',
      applicant: EmptyModels.empty<EventApplicant>(),
    ),
  );

  EmptyModels.register<Loaner>(
    () => Loaner(
      name: '',
      groupManagerId: '',
      id: '',
    ),
  );

  EmptyModels.register<Item>(
    () => Item(
      name: '',
      suggestedCaution: 0,
      totalQuantity: 0,
      suggestedLendingDuration: 0,
      id: '',
      loanedQuantity: 0,
      loanerId: '',
    ),
  );

  EmptyModels.register<Loan>(
    () => Loan(
      loaner: EmptyModels.empty<Loaner>(),
      start: DateTime.now(),
      end: DateTime.now(),
      id: '',
      borrower: EmptyModels.empty<CoreUserSimple>(),
      borrowerId: '',
      loanerId: '',
      returned: false,
      returnedDate: DateTime.now(),
      itemsQty: [],
    ),
  );

  EmptyModels.register<PaperComplete>(
    () => PaperComplete(
      name: '',
      releaseDate: DateTime.now(),
      id: '',
    ),
  );

  EmptyModels.register<AssociationComplete>(
    () => AssociationComplete(
      id: '',
      name: '',
      kind: Kinds.assoInd,
      mandateYear: 0,
    ),
  );

  EmptyModels.register<MemberComplete>(
    () => MemberComplete(
      name: '',
      firstname: '',
      id: '',
      accountType: AccountType.$external,
      schoolId: '',
      email: '',
      memberships: [],
    ),
  );

  EmptyModels.register<MembershipComplete>(
    () => MembershipComplete(
      id: '',
      userId: '',
      associationId: '',
      mandateYear: 0,
      roleName: '',
      memberOrder: 0,
    ),
  );

  EmptyModels.register<GenerateTicketComplete>(
    () => GenerateTicketComplete(
      name: '',
      maxUse: 0,
      expiration: DateTime.now(),
      id: '',
    ),
  );

  EmptyModels.register<SellerComplete>(
    () => SellerComplete(
      id: '',
      name: '',
      groupId: '',
      order: 0,
    ),
  );

  EmptyModels.register<PackTicketSimple>(
    () => PackTicketSimple(
      id: '',
      price: 0.0,
      packSize: 0,
      raffleId: '',
    ),
  );

  EmptyModels.register<PrizeSimple>(
    () => PrizeSimple(
      id: '',
      name: '',
      description: '',
      raffleId: '',
      quantity: 0,
    ),
  );

  EmptyModels.register<RaffleComplete>(
    () => RaffleComplete(
      id: '',
      name: '',
      description: '',
      groupId: '',
    ),
  );

  EmptyModels.register<RaffleStats>(
    () => RaffleStats(
      ticketsSold: 0,
      amountRaised: 0.0,
    ),
  );

  EmptyModels.register<Recommendation>(
    () => Recommendation(
      id: '',
      title: '',
      summary: '',
      description: '',
      creation: DateTime.now(),
    ),
  );

  EmptyModels.register<SectionComplete>(
    () => SectionComplete(
      id: '',
      name: '',
      description: '',
    ),
  );

  EmptyModels.register<ListReturn>(
    () => ListReturn(
      id: '',
      name: '',
      description: '',
      type: ListType.pipo,
      section: EmptyModels.empty<SectionComplete>(),
      members: [],
    ),
  );

  EmptyModels.register<ListMemberComplete>(
    () => ListMemberComplete(
      user: EmptyModels.empty<CoreUserSimple>(),
      userId: '',
      role: '',
    ),
  );

  EmptyModels.register<AppModulesCampaignSchemasCampaignResult>(
    () => AppModulesCampaignSchemasCampaignResult(
      listId: '',
      count: 0,
    ),
  );
}
