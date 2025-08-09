// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get adminAccountTypes => 'Account types';

  @override
  String get adminAdd => 'Add';

  @override
  String get adminAddGroup => 'Add group';

  @override
  String get adminAddMember => 'Add member';

  @override
  String get adminAddedGroup => 'Group created';

  @override
  String get adminAddedLoaner => 'Lender added';

  @override
  String get adminAddedMember => 'Member added';

  @override
  String get adminAddingError => 'Error while adding';

  @override
  String get adminAddingMember => 'Adding a member';

  @override
  String get adminAddLoaningGroup => 'Add loaning group';

  @override
  String get adminAddSchool => 'Add school';

  @override
  String get adminAddStructure => 'Add structure';

  @override
  String get adminAddedSchool => 'School created';

  @override
  String get adminAddedStructure => 'Structure added';

  @override
  String get adminEditedStructure => 'Structure edited';

  @override
  String get adminAdministration => 'Administration';

  @override
  String get adminAssociationMembership => 'Membership';

  @override
  String get adminAssociationMembershipName => 'Membership name';

  @override
  String get adminAssociationsMemberships => 'Memberships';

  @override
  String get adminClearFilters => 'Clear filters';

  @override
  String get adminCreateAssociationMembership => 'Create membership';

  @override
  String get adminCreatedAssociationMembership => 'Membership created';

  @override
  String get adminCreationError => 'Error during creation';

  @override
  String get adminDateError => 'Start date must be before end date';

  @override
  String get adminDelete => 'Delete';

  @override
  String get adminDeleteAssociationMembership => 'Delete membership?';

  @override
  String get adminDeletedAssociationMembership => 'Membership deleted';

  @override
  String get adminDeleteGroup => 'Delete group?';

  @override
  String get adminDeletedGroup => 'Group deleted';

  @override
  String get adminDeleteSchool => 'Delete school?';

  @override
  String get adminDeletedSchool => 'School deleted';

  @override
  String get adminDeleting => 'Deleting';

  @override
  String get adminDeletingError => 'Error while deleting';

  @override
  String get adminDescription => 'Description';

  @override
  String get adminEclSchool => 'Centrale Lyon';

  @override
  String get adminEdit => 'Edit';

  @override
  String get adminEditStructure => 'Edit structure';

  @override
  String get adminEditMembership => 'Edit membership';

  @override
  String get adminEmptyDate => 'Empty date';

  @override
  String get adminEmptyFieldError => 'Name cannot be empty';

  @override
  String get adminEmailRegex => 'Email Regex';

  @override
  String get adminEmptyUser => 'Empty user';

  @override
  String get adminEndDate => 'End date';

  @override
  String get adminEndDateMaximal => 'Maximum end date';

  @override
  String get adminEndDateMinimal => 'Minimum end date';

  @override
  String get adminError => 'Error';

  @override
  String get adminFilters => 'Filters';

  @override
  String get adminGroup => 'Group';

  @override
  String get adminGroups => 'Groups';

  @override
  String get adminLoaningGroup => 'Loaning group';

  @override
  String get adminLooking => 'Searching';

  @override
  String get adminManager => 'Structure administrator';

  @override
  String get adminMaximum => 'Maximum';

  @override
  String get adminMembers => 'Members';

  @override
  String get adminMembershipAddingError =>
      'Error while adding (likely due to overlapping dates)';

  @override
  String get adminMemberships => 'Memberships';

  @override
  String get adminMembershipUpdatingError =>
      'Error while updating (likely due to overlapping dates)';

  @override
  String get adminMinimum => 'Minimum';

  @override
  String get adminModifyModuleVisibility => 'Module visibility';

  @override
  String get adminMyEclPay => 'MyECLPay';

  @override
  String get adminName => 'Name';

  @override
  String get adminNoManager => 'No manager selected';

  @override
  String get adminNoMember => 'No member';

  @override
  String get adminNoMoreLoaner => 'No lender available';

  @override
  String get adminNoSchool => 'No school';

  @override
  String get adminRemoveGroupMember => 'Remove member from group?';

  @override
  String get adminResearch => 'Search';

  @override
  String get adminSchools => 'Schools';

  @override
  String get adminStructures => 'Structures';

  @override
  String get adminStartDate => 'Start date';

  @override
  String get adminStartDateMaximal => 'Maximum start date';

  @override
  String get adminStartDateMinimal => 'Minimum start date';

  @override
  String get adminUpdatedAssociationMembership => 'Membership updated';

  @override
  String get adminUpdatedGroup => 'Group updated';

  @override
  String get adminUpdatedMembership => 'Membership updated';

  @override
  String get adminUpdatingError => 'Error while updating';

  @override
  String get adminUser => 'User';

  @override
  String get adminValidateFilters => 'Apply filters';

  @override
  String get adminVisibilities => 'Visibilities';

  @override
  String get adminGroupNotification => 'Notification de groupe';

  @override
  String adminNotifyGroup(String groupName) {
    return 'Notifier le groupe $groupName';
  }

  @override
  String get adminTitle => 'Titre';

  @override
  String get adminContent => 'Contenu';

  @override
  String get adminSend => 'Envoyer';

  @override
  String get adminNotificationSended => 'Notification envoyée';

  @override
  String get adminFailedToSendNotification =>
      'Échec de l\'envoi de la notification';

  @override
  String get adminGroupsManagement => 'Gestion des groupes';

  @override
  String get adminEditGroup => 'Modifier le groupe';

  @override
  String get adminManageMembers => 'Gérer les membres';

  @override
  String get adminDeleteGroupConfirmation =>
      'Êtes-vous sûr de vouloir supprimer ce groupe ?';

  @override
  String get adminFailedToDeleteGroup => 'Échec de la suppression du groupe';

  @override
  String get adminUsersAndGroups => 'Utilisateurs et groupes';

  @override
  String get adminUsersManagement => 'Gestion des utilisateurs';

  @override
  String get adminUsersManagementDescription =>
      'Gérez les utilisateurs de l\'application';

  @override
  String get adminManageUserGroups => 'Gérer les groupes d\'utilisateurs';

  @override
  String get adminSendNotificationToGroup =>
      'Envoyer une notification à un groupe';

  @override
  String get adminPaiementModule => 'Module de paiement';

  @override
  String get adminPaiement => 'Paiement';

  @override
  String get adminManagePaiementStructures =>
      'Gérer les structures du module de paiement';

  @override
  String get adminManageUsersAssociationMemberships =>
      'Gérer les adhésions des utilisateurs';

  @override
  String get adminAssociationMembershipsManagement => 'Gestion des adhésions';

  @override
  String get adminChooseGroupManager => 'Choisir une association';

  @override
  String get adminSelectManager => 'Sélectionner un gestionnaire';

  @override
  String get adminInviteUsers => 'Inviter des utilisateurs';

  @override
  String get adminImportList => 'Importer une liste';

  @override
  String get adminInvitedUsers => 'Utilisateurs invités';

  @override
  String get adminFailedToInviteUsers =>
      'Échec de l\'invitation des utilisateurs';

  @override
  String get adminDeleteUsers => 'Supprimer des utilisateurs';

  @override
  String get advertAdd => 'Add';

  @override
  String get advertAddedAdvert => 'Advert published';

  @override
  String get advertAddedAnnouncer => 'Announcer added';

  @override
  String get advertAddingError => 'Error while adding';

  @override
  String get advertAdmin => 'Admin';

  @override
  String get advertAdvert => 'Advert';

  @override
  String get advertChoosingAnnouncer => 'Please choose an announcer';

  @override
  String get advertChoosingPoster => 'Please choose an image';

  @override
  String get advertContent => 'Content';

  @override
  String get advertDeleteAdvert => 'Delete ad?';

  @override
  String get advertDeleteAnnouncer => 'Delete announcer?';

  @override
  String get advertDeleting => 'Deleting';

  @override
  String get advertEdit => 'Edit';

  @override
  String get advertEditedAdvert => 'Advert edited';

  @override
  String get advertEditingError => 'Error while editing';

  @override
  String get advertGroupAdvert => 'Group';

  @override
  String get advertIncorrectOrMissingFields => 'Incorrect or missing fields';

  @override
  String get advertInvalidNumber => 'Please enter a number';

  @override
  String get advertManagement => 'Management';

  @override
  String get advertModifyAnnouncingGroup => 'Edit announcement group';

  @override
  String get advertNoMoreAnnouncer => 'No more announcers available';

  @override
  String get advertNoValue => 'Please enter a value';

  @override
  String get advertPositiveNumber => 'Please enter a positive number';

  @override
  String get advertRemovedAnnouncer => 'Announcer removed';

  @override
  String get advertRemovingError => 'Error during removal';

  @override
  String get advertTags => 'Tags';

  @override
  String get advertTitle => 'Title';

  @override
  String get advertMonthJan => 'Jan';

  @override
  String get advertMonthFeb => 'Feb';

  @override
  String get advertMonthMar => 'Mar';

  @override
  String get advertMonthApr => 'Apr';

  @override
  String get advertMonthMay => 'May';

  @override
  String get advertMonthJun => 'Jun';

  @override
  String get advertMonthJul => 'Jul';

  @override
  String get advertMonthAug => 'Aug';

  @override
  String get advertMonthSep => 'Sep';

  @override
  String get advertMonthOct => 'Oct';

  @override
  String get advertMonthNov => 'Nov';

  @override
  String get advertMonthDec => 'Dec';

  @override
  String get amapAccounts => 'Accounts';

  @override
  String get amapAdd => 'Add';

  @override
  String get amapAddDelivery => 'Add delivery';

  @override
  String get amapAddedCommand => 'Order added';

  @override
  String get amapAddedOrder => 'Order added';

  @override
  String get amapAddedProduct => 'Product added';

  @override
  String get amapAddedUser => 'User added';

  @override
  String get amapAddProduct => 'Add product';

  @override
  String get amapAddUser => 'Add user';

  @override
  String get amapAddingACommand => 'Add an order';

  @override
  String get amapAddingCommand => 'Add the order';

  @override
  String get amapAddingError => 'Error while adding';

  @override
  String get amapAddingProduct => 'Add a product';

  @override
  String get amapAddOrder => 'Add an order';

  @override
  String get amapAdmin => 'Admin';

  @override
  String get amapAlreadyExistCommand => 'An order already exists for this date';

  @override
  String get amapAmap => 'Amap';

  @override
  String get amapAmount => 'Balance';

  @override
  String get amapArchive => 'Archive';

  @override
  String get amapArchiveDelivery => 'Archive';

  @override
  String get amapArchivingDelivery => 'Archiving delivery';

  @override
  String get amapCategory => 'Category';

  @override
  String get amapCloseDelivery => 'Lock';

  @override
  String get amapCommandDate => 'Order date';

  @override
  String get amapCommandProducts => 'Order products';

  @override
  String get amapConfirm => 'Confirm';

  @override
  String get amapContact => 'Association contacts';

  @override
  String get amapCreateCategory => 'Create category';

  @override
  String get amapDelete => 'Delete';

  @override
  String get amapDeleteDelivery => 'Delete delivery?';

  @override
  String get amapDeleteDeliveryDescription =>
      'Are you sure you want to delete this delivery?';

  @override
  String get amapDeletedDelivery => 'Delivery deleted';

  @override
  String get amapDeletedOrder => 'Order deleted';

  @override
  String get amapDeletedProduct => 'Product deleted';

  @override
  String get amapDeleteProduct => 'Delete product?';

  @override
  String get amapDeleteProductDescription =>
      'Are you sure you want to delete this product?';

  @override
  String get amapDeleting => 'Deleting';

  @override
  String get amapDeletingDelivery => 'Delete delivery?';

  @override
  String get amapDeletingError => 'Error while deleting';

  @override
  String get amapDeletingOrder => 'Delete order?';

  @override
  String get amapDeletingProduct => 'Delete product?';

  @override
  String get amapDeliver => 'Delivery completed?';

  @override
  String get amapDeliveries => 'Deliveries';

  @override
  String get amapDeliveringDelivery => 'Are all orders delivered?';

  @override
  String get amapDelivery => 'Delivery';

  @override
  String get amapDeliveryArchived => 'Delivery archived';

  @override
  String get amapDeliveryDate => 'Delivery date';

  @override
  String get amapDeliveryDelivered => 'Delivery completed';

  @override
  String get amapDeliveryHistory => 'Delivery history';

  @override
  String get amapDeliveryList => 'Delivery list';

  @override
  String get amapDeliveryLocked => 'Delivery locked';

  @override
  String get amapDeliveryOn => 'Delivery on';

  @override
  String get amapDeliveryOpened => 'Delivery opened';

  @override
  String get amapDeliveryNotArchived => 'Delivery not archived';

  @override
  String get amapDeliveryNotLocked => 'Delivery not locked';

  @override
  String get amapDeliveryNotDelivered => 'Delivery not completed';

  @override
  String get amapDeliveryNotOpened => 'Delivery not opened';

  @override
  String get amapEditDelivery => 'Edit delivery';

  @override
  String get amapEditedCommand => 'Order edited';

  @override
  String get amapEditingError => 'Error while editing';

  @override
  String get amapEditProduct => 'Edit product';

  @override
  String get amapEndingDelivery => 'End of delivery';

  @override
  String get amapError => 'Error';

  @override
  String get amapErrorLink => 'Error opening link';

  @override
  String get amapErrorLoadingUser => 'Error loading users';

  @override
  String get amapEvening => 'Evening';

  @override
  String get amapExpectingNumber => 'Please enter a number';

  @override
  String get amapFillField => 'Please fill out this field';

  @override
  String get amapHandlingAccount => 'Manage accounts';

  @override
  String get amapLoading => 'Loading...';

  @override
  String get amapLoadingError => 'Loading error';

  @override
  String get amapLock => 'Lock';

  @override
  String get amapLocked => 'Locked';

  @override
  String get amapLockedDelivery => 'Delivery locked';

  @override
  String get amapLockedOrder => 'Order locked';

  @override
  String get amapLooking => 'Search';

  @override
  String get amapLockingDelivery => 'Lock delivery?';

  @override
  String get amapMidDay => 'Midday';

  @override
  String get amapMyOrders => 'My orders';

  @override
  String get amapName => 'Name';

  @override
  String get amapNextStep => 'Next step';

  @override
  String get amapNoProduct => 'No product';

  @override
  String get amapNoCurrentOrder => 'No current order';

  @override
  String get amapNoMoney => 'Not enough money';

  @override
  String get amapNoOpennedDelivery => 'No open delivery';

  @override
  String get amapNoOrder => 'No order';

  @override
  String get amapNoSelectedDelivery => 'No delivery selected';

  @override
  String get amapNotEnoughMoney => 'Not enough money';

  @override
  String get amapNotPlannedDelivery => 'No scheduled delivery';

  @override
  String get amapOneOrder => 'order';

  @override
  String get amapOpenDelivery => 'Open';

  @override
  String get amapOpened => 'Opened';

  @override
  String get amapOpenningDelivery => 'Open delivery?';

  @override
  String get amapOrder => 'Order';

  @override
  String get amapOrders => 'Orders';

  @override
  String get amapPickChooseCategory =>
      'Please enter a value or choose an existing category';

  @override
  String get amapPickDeliveryMoment => 'Choose a delivery time';

  @override
  String get amapPresentation => 'Presentation';

  @override
  String get amapPresentation1 =>
      'The AMAP (association for the preservation of small-scale farming) is a service offered by the Planet&Co association of ECL. You can receive products (fruit and vegetable baskets, juices, jams...) directly on campus!\n\nOrders must be placed before Friday at 9 PM and are delivered on campus on Tuesday from 1:00 PM to 1:45 PM (or from 6:15 PM to 6:30 PM if you can\'t come at midday) in the M16 hall.\n\nYou can only order if your balance allows it. You can top up your balance via the Lydia collection or by cheque during office hours.\n\nLydia top-up link: ';

  @override
  String get amapPresentation2 =>
      '\n\nFeel free to contact us if you have any issues!';

  @override
  String get amapPrice => 'Price';

  @override
  String get amapProduct => 'product';

  @override
  String get amapProducts => 'Products';

  @override
  String get amapProductInDelivery => 'Product in an unfinished delivery';

  @override
  String get amapQuantity => 'Quantity';

  @override
  String get amapRequiredDate => 'Date is required';

  @override
  String get amapSeeMore => 'See more';

  @override
  String get amapThe => 'The';

  @override
  String get amapUnlock => 'Unlock';

  @override
  String get amapUnlockedDelivery => 'Delivery unlocked';

  @override
  String get amapUnlockingDelivery => 'Unlock delivery?';

  @override
  String get amapUpdate => 'Edit';

  @override
  String get amapUpdatedAmount => 'Balance updated';

  @override
  String get amapUpdatedOrder => 'Order updated';

  @override
  String get amapUpdatedProduct => 'Product updated';

  @override
  String get amapUpdatingError => 'Update failed';

  @override
  String get amapUsersNotFound => 'No users found';

  @override
  String get amapWaiting => 'Pending';

  @override
  String get bookingAdd => 'Add';

  @override
  String get bookingAddBookingPage => 'Request';

  @override
  String get bookingAddRoom => 'Add room';

  @override
  String get bookingAddBooking => 'Add booking';

  @override
  String get bookingAddedBooking => 'Request added';

  @override
  String get bookingAddedRoom => 'Room added';

  @override
  String get bookingAddedManager => 'Manager added';

  @override
  String get bookingAddingError => 'Error while adding';

  @override
  String get bookingAddManager => 'Add manager';

  @override
  String get bookingAdminPage => 'Admin';

  @override
  String get bookingAllDay => 'All day';

  @override
  String get bookingBookedFor => 'Booked for';

  @override
  String get bookingBooking => 'Booking';

  @override
  String get bookingBookingCreated => 'Booking created';

  @override
  String get bookingBookingDemand => 'Booking request';

  @override
  String get bookingBookingNote => 'Booking note';

  @override
  String get bookingBookingPage => 'Booking';

  @override
  String get bookingBookingReason => 'Booking reason';

  @override
  String get bookingBy => 'by';

  @override
  String get bookingConfirm => 'Confirm';

  @override
  String get bookingConfirmation => 'Confirmation';

  @override
  String get bookingConfirmBooking => 'Confirm the booking?';

  @override
  String get bookingConfirmed => 'Confirmed';

  @override
  String get bookingDates => 'Dates';

  @override
  String get bookingDecline => 'Decline';

  @override
  String get bookingDeclineBooking => 'Decline the booking?';

  @override
  String get bookingDeclined => 'Declined';

  @override
  String get bookingDelete => 'Delete';

  @override
  String get bookingDeleting => 'Deleting';

  @override
  String get bookingDeleteBooking => 'Deleting';

  @override
  String get bookingDeleteBookingConfirmation =>
      'Are you sure you want to delete this booking?';

  @override
  String get bookingDeletedBooking => 'Booking deleted';

  @override
  String get bookingDeletedRoom => 'Room deleted';

  @override
  String get bookingDeletedManager => 'Manager deleted';

  @override
  String get bookingDeleteRoomConfirmation =>
      'Are you sure you want to delete this room?\n\nThe room must have no current or upcoming bookings to be deleted';

  @override
  String get bookingDeleteManagerConfirmation =>
      'Are you sure you want to delete this manager?\n\nThe manager must not be associated with any room to be deleted';

  @override
  String get bookingDeletingBooking => 'Delete the booking?';

  @override
  String get bookingDeletingError => 'Error while deleting';

  @override
  String get bookingDeletingRoom => 'Delete the room?';

  @override
  String get bookingEdit => 'Edit';

  @override
  String get bookingEditBooking => 'Edit a booking';

  @override
  String get bookingEditionError => 'Error while editing';

  @override
  String get bookingEditedBooking => 'Booking edited';

  @override
  String get bookingEditedRoom => 'Room edited';

  @override
  String get bookingEditedManager => 'Manager edited';

  @override
  String get bookingEditManager => 'Edit or delete a manager';

  @override
  String get bookingEditRoom => 'Edit or delete a room';

  @override
  String get bookingEndDate => 'End date';

  @override
  String get bookingEndHour => 'End hour';

  @override
  String get bookingEntity => 'For whom?';

  @override
  String get bookingError => 'Error';

  @override
  String get bookingEventEvery => 'Every';

  @override
  String get bookingHistoryPage => 'History';

  @override
  String get bookingIncorrectOrMissingFields => 'Incorrect or missing fields';

  @override
  String get bookingInterval => 'Interval';

  @override
  String get bookingInvalidIntervalError => 'Invalid interval';

  @override
  String get bookingInvalidDates => 'Invalid dates';

  @override
  String get bookingInvalidRoom => 'Invalid room';

  @override
  String get bookingKeysRequested => 'Keys requested';

  @override
  String get bookingManagement => 'Management';

  @override
  String get bookingManager => 'Manager';

  @override
  String get bookingManagerName => 'Manager name';

  @override
  String get bookingMultipleDay => 'Multiple days';

  @override
  String get bookingMyBookings => 'My bookings';

  @override
  String get bookingNecessaryKey => 'Key needed';

  @override
  String get bookingNext => 'Next';

  @override
  String get bookingNo => 'No';

  @override
  String get bookingNoCurrentBooking => 'No current booking';

  @override
  String get bookingNoDateError => 'Please choose a date';

  @override
  String get bookingNoAppointmentInReccurence =>
      'No slot exists with these recurrence settings';

  @override
  String get bookingNoDaySelected => 'No day selected';

  @override
  String get bookingNoDescriptionError => 'Please enter a description';

  @override
  String get bookingNoKeys => 'No keys';

  @override
  String get bookingNoNoteError => 'Please enter a note';

  @override
  String get bookingNoPhoneRegistered => 'Number not provided';

  @override
  String get bookingNoReasonError => 'Please enter a reason';

  @override
  String get bookingNoRoomFoundError => 'No room registered';

  @override
  String get bookingNoRoomFound => 'No room found';

  @override
  String get bookingNote => 'Note';

  @override
  String get bookingOther => 'Other';

  @override
  String get bookingPending => 'Pending';

  @override
  String get bookingPrevious => 'Previous';

  @override
  String get bookingReason => 'Reason';

  @override
  String get bookingRecurrence => 'Recurrence';

  @override
  String get bookingRecurrenceDays => 'Recurrence days';

  @override
  String get bookingRecurrenceEndDate => 'Recurrence end date';

  @override
  String get bookingRecurrent => 'Recurrent';

  @override
  String get bookingRegisteredRooms => 'Registered rooms';

  @override
  String get bookingRoom => 'Room';

  @override
  String get bookingRoomName => 'Room name';

  @override
  String get bookingStartDate => 'Start date';

  @override
  String get bookingStartHour => 'Start hour';

  @override
  String get bookingWeeks => 'Weeks';

  @override
  String get bookingYes => 'Yes';

  @override
  String get bookingWeekDayMon => 'Monday';

  @override
  String get bookingWeekDayTue => 'Tuesday';

  @override
  String get bookingWeekDayWed => 'Wednesday';

  @override
  String get bookingWeekDayThu => 'Thursday';

  @override
  String get bookingWeekDayFri => 'Friday';

  @override
  String get bookingWeekDaySat => 'Saturday';

  @override
  String get bookingWeekDaySun => 'Sunday';

  @override
  String get cinemaAdd => 'Add';

  @override
  String get cinemaAddedSession => 'Session added';

  @override
  String get cinemaAddingError => 'Error while adding';

  @override
  String get cinemaAddSession => 'Add a session';

  @override
  String get cinemaCinema => 'Cinema';

  @override
  String get cinemaDeleteSession => 'Delete the session?';

  @override
  String get cinemaDeleting => 'Deleting';

  @override
  String get cinemaDuration => 'Duration';

  @override
  String get cinemaEdit => 'Edit';

  @override
  String get cinemaEditedSession => 'Session edited';

  @override
  String get cinemaEditingError => 'Error while editing';

  @override
  String get cinemaEditSession => 'Edit the session';

  @override
  String get cinemaEmptyUrl => 'Please enter a URL';

  @override
  String get cinemaImportFromTMDB => 'Import from TMDB';

  @override
  String get cinemaIncomingSession => 'Now showing';

  @override
  String get cinemaIncorrectOrMissingFields => 'Incorrect or missing fields';

  @override
  String get cinemaInvalidUrl => 'Invalid URL';

  @override
  String get cinemaGenre => 'Genre';

  @override
  String get cinemaName => 'Name';

  @override
  String get cinemaNoDateError => 'Please enter a date';

  @override
  String get cinemaNoDuration => 'Please enter a duration';

  @override
  String get cinemaNoOverview => 'No synopsis';

  @override
  String get cinemaNoPoster => 'No poster';

  @override
  String get cinemaNoSession => 'No session';

  @override
  String get cinemaOverview => 'Synopsis';

  @override
  String get cinemaPosterUrl => 'Poster URL';

  @override
  String get cinemaSessionDate => 'Session day';

  @override
  String get cinemaStartHour => 'Start hour';

  @override
  String get cinemaTagline => 'Tagline';

  @override
  String get cinemaThe => 'The';

  @override
  String get drawerAdmin => 'Administration';

  @override
  String get drawerAndroidAppLink =>
      'https://play.google.com/store/apps/details?id=fr.myecl.titan';

  @override
  String get drawerCopied => 'Copied!';

  @override
  String get drawerDownloadAppOnMobileDevice =>
      'This site is the web version of the MyECL app. We invite you to download the app. Use this site only if you have problems with the app.\n';

  @override
  String get drawerIosAppLink =>
      'https://apps.apple.com/fr/app/myecl/id6444443430';

  @override
  String get drawerLoginOut => 'Do you want to log out?';

  @override
  String get drawerLogOut => 'Log out';

  @override
  String get drawerOr => ' or ';

  @override
  String get drawerSettings => 'Settings';

  @override
  String get eventAdd => 'Add';

  @override
  String get eventAddEvent => 'Add an event';

  @override
  String get eventAddedEvent => 'Event added';

  @override
  String get eventAddingError => 'Error while adding';

  @override
  String get eventAllDay => 'All day';

  @override
  String get eventConfirm => 'Confirm';

  @override
  String get eventConfirmEvent => 'Confirm the event?';

  @override
  String get eventConfirmation => 'Confirmation';

  @override
  String get eventConfirmed => 'Confirmed';

  @override
  String get eventDates => 'Dates';

  @override
  String get eventDecline => 'Decline';

  @override
  String get eventDeclineEvent => 'Decline the event?';

  @override
  String get eventDeclined => 'Declined';

  @override
  String get eventDelete => 'Delete';

  @override
  String get eventDeletedEvent => 'Event deleted';

  @override
  String get eventDeleting => 'Deleting';

  @override
  String get eventDeletingError => 'Error while deleting';

  @override
  String get eventDeletingEvent => 'Delete the event?';

  @override
  String get eventDescription => 'Description';

  @override
  String get eventEdit => 'Edit';

  @override
  String get eventEditEvent => 'Edit an event';

  @override
  String get eventEditedEvent => 'Event edited';

  @override
  String get eventEditingError => 'Error while editing';

  @override
  String get eventEndDate => 'End date';

  @override
  String get eventEndHour => 'End hour';

  @override
  String get eventError => 'Error';

  @override
  String get eventEventList => 'Event list';

  @override
  String get eventEventType => 'Event type';

  @override
  String get eventEvery => 'Every';

  @override
  String get eventHistory => 'History';

  @override
  String get eventIncorrectOrMissingFields =>
      'Some fields are incorrect or missing';

  @override
  String get eventInterval => 'Interval';

  @override
  String get eventInvalidDates => 'End date must be after start date';

  @override
  String get eventInvalidIntervalError => 'Please enter a valid interval';

  @override
  String get eventLocation => 'Location';

  @override
  String get eventMyEvents => 'My events';

  @override
  String get eventName => 'Name';

  @override
  String get eventNext => 'Next';

  @override
  String get eventNo => 'No';

  @override
  String get eventNoCurrentEvent => 'No current event';

  @override
  String get eventNoDateError => 'Please enter a date';

  @override
  String get eventNoDaySelected => 'No day selected';

  @override
  String get eventNoDescriptionError => 'Please enter a description';

  @override
  String get eventNoEvent => 'No event';

  @override
  String get eventNoNameError => 'Please enter a name';

  @override
  String get eventNoOrganizerError => 'Please enter an organizer';

  @override
  String get eventNoPlaceError => 'Please enter a location';

  @override
  String get eventNoPhoneRegistered => 'Number not provided';

  @override
  String get eventNoRuleError => 'Please enter a recurrence rule';

  @override
  String get eventOrganizer => 'Organizer';

  @override
  String get eventOther => 'Other';

  @override
  String get eventPending => 'Pending';

  @override
  String get eventPrevious => 'Previous';

  @override
  String get eventRecurrence => 'Recurrence';

  @override
  String get eventRecurrenceDays => 'Recurrence days';

  @override
  String get eventRecurrenceEndDate => 'Recurrence end date';

  @override
  String get eventRecurrenceRule => 'Recurrence rule';

  @override
  String get eventRoom => 'Room';

  @override
  String get eventStartDate => 'Start date';

  @override
  String get eventStartHour => 'Start hour';

  @override
  String get eventTitle => 'Events';

  @override
  String get eventYes => 'Yes';

  @override
  String get eventEventEvery => 'Every';

  @override
  String get eventWeeks => 'weeks';

  @override
  String get eventDayMon => 'Monday';

  @override
  String get eventDayTue => 'Tuesday';

  @override
  String get eventDayWed => 'Wednesday';

  @override
  String get eventDayThu => 'Thursday';

  @override
  String get eventDayFri => 'Friday';

  @override
  String get eventDaySat => 'Saturday';

  @override
  String get eventDaySun => 'Sunday';

  @override
  String get homeCalendar => 'Calendar';

  @override
  String get homeEventOf => 'Events of';

  @override
  String get homeIncomingEvents => 'Upcoming events';

  @override
  String get homeLastInfos => 'Latest announcements';

  @override
  String get homeNoEvents => 'No events';

  @override
  String get homeTranslateDayShortMon => 'Mon';

  @override
  String get homeTranslateDayShortTue => 'Tue';

  @override
  String get homeTranslateDayShortWed => 'Wed';

  @override
  String get homeTranslateDayShortThu => 'Thu';

  @override
  String get homeTranslateDayShortFri => 'Fri';

  @override
  String get homeTranslateDayShortSat => 'Sat';

  @override
  String get homeTranslateDayShortSun => 'Sun';

  @override
  String get loanAdd => 'Add';

  @override
  String get loanAddLoan => 'Add a loan';

  @override
  String get loanAddObject => 'Add an object';

  @override
  String get loanAddedLoan => 'Loan added';

  @override
  String get loanAddedObject => 'Object added';

  @override
  String get loanAddedRoom => 'Room added';

  @override
  String get loanAddingError => 'Error while adding';

  @override
  String get loanAdmin => 'Administrator';

  @override
  String get loanAvailable => 'Available';

  @override
  String get loanAvailableMultiple => 'Available';

  @override
  String get loanBorrowed => 'Borrowed';

  @override
  String get loanBorrowedMultiple => 'Borrowed';

  @override
  String get loanAnd => 'and';

  @override
  String get loanAssociation => 'Association';

  @override
  String get loanAvailableItems => 'Available items';

  @override
  String get loanBeginDate => 'Loan start date';

  @override
  String get loanBorrower => 'Borrower';

  @override
  String get loanCaution => 'Deposit';

  @override
  String get loanCancel => 'Cancel';

  @override
  String get loanConfirm => 'Confirm';

  @override
  String get loanConfirmation => 'Confirmation';

  @override
  String get loanDates => 'Dates';

  @override
  String get loanDays => 'Days';

  @override
  String get loanDelay => 'Extension delay';

  @override
  String get loanDelete => 'Delete';

  @override
  String get loanDeletingLoan => 'Delete the loan?';

  @override
  String get loanDeletedItem => 'Object deleted';

  @override
  String get loanDeletedLoan => 'Loan deleted';

  @override
  String get loanDeleting => 'Deleting';

  @override
  String get loanDeletingError => 'Error while deleting';

  @override
  String get loanDeletingItem => 'Delete the object?';

  @override
  String get loanDuration => 'Duration';

  @override
  String get loanEdit => 'Edit';

  @override
  String get loanEditItem => 'Edit the object';

  @override
  String get loanEditLoan => 'Edit the loan';

  @override
  String get loanEditedRoom => 'Room edited';

  @override
  String get loanEndDate => 'Loan end date';

  @override
  String get loanEnded => 'Ended';

  @override
  String get loanEnterDate => 'Please enter a date';

  @override
  String get loanExtendedLoan => 'Extended loan';

  @override
  String get loanExtendingError => 'Error while extending';

  @override
  String get loanHistory => 'History';

  @override
  String get loanIncorrectOrMissingFields =>
      'Some fields are missing or incorrect';

  @override
  String get loanInvalidNumber => 'Please enter a number';

  @override
  String get loanInvalidDates => 'Dates are not valid';

  @override
  String get loanItem => 'Item';

  @override
  String get loanItems => 'Items';

  @override
  String get loanItemHandling => 'Item management';

  @override
  String get loanItemSelected => 'selected item';

  @override
  String get loanItemsSelected => 'selected items';

  @override
  String get loanLendingDuration => 'Possible loan duration';

  @override
  String get loanLoan => 'Loan';

  @override
  String get loanLoanHandling => 'Loan management';

  @override
  String get loanLooking => 'Searching';

  @override
  String get loanName => 'Name';

  @override
  String get loanNext => 'Next';

  @override
  String get loanNo => 'No';

  @override
  String get loanNoAssociationsFounded => 'No associations found';

  @override
  String get loanNoAvailableItems => 'No available items';

  @override
  String get loanNoBorrower => 'No borrower';

  @override
  String get loanNoItems => 'No items';

  @override
  String get loanNoItemSelected => 'No item selected';

  @override
  String get loanNoLoan => 'No loan';

  @override
  String get loanNoReturnedDate => 'No return date';

  @override
  String get loanQuantity => 'Quantity';

  @override
  String get loanNone => 'None';

  @override
  String get loanNote => 'Note';

  @override
  String get loanNoValue => 'Please enter a value';

  @override
  String get loanOnGoing => 'Ongoing';

  @override
  String get loanOnGoingLoan => 'Ongoing loan';

  @override
  String get loanOthers => 'others';

  @override
  String get loanPaidCaution => 'Deposit paid';

  @override
  String get loanPositiveNumber => 'Please enter a positive number';

  @override
  String get loanPrevious => 'Previous';

  @override
  String get loanReturned => 'Returned';

  @override
  String get loanReturnedLoan => 'Returned loan';

  @override
  String get loanReturningError => 'Error while returning';

  @override
  String get loanReturningLoan => 'Return';

  @override
  String get loanReturnLoan => 'Return the loan?';

  @override
  String get loanReturnLoanDescription => 'Do you want to return this loan?';

  @override
  String get loanToReturn => 'To return';

  @override
  String get loanUnavailable => 'Unavailable';

  @override
  String get loanUpdate => 'Edit';

  @override
  String get loanUpdatedItem => 'Item updated';

  @override
  String get loanUpdatedLoan => 'Loan updated';

  @override
  String get loanUpdatingError => 'Error while updating';

  @override
  String get loanYes => 'Yes';

  @override
  String get loginAccountActivated => 'Account activated';

  @override
  String get loginAccountNotActivated => 'Account not activated';

  @override
  String get loginActivationCode => 'Activation code';

  @override
  String get loginBirthday => 'Date of birth';

  @override
  String get loginCanBeEmpty => 'This field can be empty';

  @override
  String get loginConfirmPassword => 'Confirm password';

  @override
  String get loginCreate => 'Create';

  @override
  String get loginCreateAccount => 'Create an account';

  @override
  String get loginCreateAccountTitle => 'Create an\naccount';

  @override
  String get loginEmail => 'Email';

  @override
  String get loginEmailEmpty => 'Please enter an email address';

  @override
  String get loginEmailInvalid =>
      'Please enter a Centrale email address.\nIf you don\'t have one, please contact Éclair';

  @override
  String get loginEmptyFieldError => 'This field cannot be empty';

  @override
  String get loginEndActivation => 'Complete activation';

  @override
  String get loginEndResetPassword => 'Complete\npassword reset';

  @override
  String get loginErrorResetPassword => 'Error during reset';

  @override
  String get loginExpectingDate => 'A date is expected';

  @override
  String get loginFillAllFields => 'Please fill all fields';

  @override
  String get loginFirstname => 'First name';

  @override
  String get loginFloor => 'Floor';

  @override
  String get loginForgetPassword => 'Forgot\npassword';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginInvalidToken => 'Invalid activation code';

  @override
  String get loginLoginFailed => 'Login failed';

  @override
  String get loginMailSendingError => 'Error during account creation';

  @override
  String get loginMustBeIntError => 'This field must be an integer';

  @override
  String get loginName => 'Last name';

  @override
  String get loginNewPassword => 'New password';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginPasswordLengthError =>
      'Password must be at least 6 characters';

  @override
  String get loginPasswordUppercaseError =>
      'Password must contain at least one uppercase letter';

  @override
  String get loginPasswordLowercaseError =>
      'Password must contain at least one lowercase letter';

  @override
  String get loginPasswordNumberError =>
      'Password must contain at least one number';

  @override
  String get loginPasswordSpecialCaracterError =>
      'Password must contain at least one special character';

  @override
  String get loginPasswordMustMatch => 'Passwords must match';

  @override
  String get loginPasswordStrengthVeryWeak => 'Very weak';

  @override
  String get loginPasswordStrengthWeak => 'Weak';

  @override
  String get loginPasswordStrengthMedium => 'Medium';

  @override
  String get loginPasswordStrengthStrong => 'Strong';

  @override
  String get loginPasswordStrengthVeryStrong => 'Very strong';

  @override
  String get loginPhone => 'Phone';

  @override
  String get loginPromo => 'Incoming class (e.g., 2023)';

  @override
  String get loginSendedMail => 'Confirmation email sent';

  @override
  String get loginSendedResetMail => 'Reset email sent';

  @override
  String get loginSignIn => 'Sign in';

  @override
  String get loginRegister => 'Register';

  @override
  String get loginRecievedMail => 'I received the email';

  @override
  String get loginRecover => 'Reset';

  @override
  String get loginResetedPassword => 'Password reset';

  @override
  String get loginResetPasswordTitle => 'Reset\npassword';

  @override
  String get loginNickname => 'Nickname';

  @override
  String get loginWelcomeBack => 'Welcome back';

  @override
  String get loginAppName => 'MyECL';

  @override
  String get othersCheckInternetConnection =>
      'Please check your internet connection';

  @override
  String get othersRetry => 'Retry';

  @override
  String get othersTooOldVersion =>
      'Your app version is too old.\n\nPlease update the app.';

  @override
  String get othersUnableToConnectToServer => 'Unable to connect to the server';

  @override
  String get othersVersion => 'Version';

  @override
  String get othersNoModule =>
      'No modules available, please try again later 😢😢';

  @override
  String get othersAdmin => 'Admin';

  @override
  String get othersError => 'An error occurred';

  @override
  String get othersNoValue => 'Please enter a value';

  @override
  String get othersInvalidNumber => 'Please enter a number';

  @override
  String get othersNoDateError => 'Please enter a date';

  @override
  String get othersImageSizeTooBig => 'Image size must not exceed 4 MB';

  @override
  String get othersImageError => 'Error adding the image';

  @override
  String get phAddNewJournal => 'Add a new journal';

  @override
  String get phNameField => 'Name: ';

  @override
  String get phDateField => 'Date: ';

  @override
  String get phDelete => 'Are you sure you want to delete this journal?';

  @override
  String get phIrreversibleAction => 'This action is irreversible';

  @override
  String get phToHeavyFile => 'File too large';

  @override
  String get phAddPdfFile => 'Add a PDF file';

  @override
  String get phEditPdfFile => 'Edit PDF file';

  @override
  String get phPhName => 'PH name';

  @override
  String get phDate => 'Date';

  @override
  String get phAdded => 'Added';

  @override
  String get phEdited => 'Edited';

  @override
  String get phAddingFileError => 'Add error';

  @override
  String get phMissingInformatonsOrPdf => 'Missing information or PDF file';

  @override
  String get phAdd => 'Add';

  @override
  String get phEdit => 'Edit';

  @override
  String get phSeePreviousJournal => 'See previous journals';

  @override
  String get phNoJournalInDatabase => 'No PH yet in database';

  @override
  String get phSuccesDowloading => 'Successfully downloaded';

  @override
  String get phonebookActiveMandate => 'Active mandate:';

  @override
  String get phonebookAdd => 'Add';

  @override
  String get phonebookAddAssociation => 'Add an association';

  @override
  String get phonebookAddedAssociation => 'Association added';

  @override
  String get phonebookAddedMember => 'Member added';

  @override
  String get phonebookAddingError => 'Error adding';

  @override
  String get phonebookAddMember => 'Add a member';

  @override
  String get phonebookAddRole => 'Add a role';

  @override
  String get phonebookAdmin => 'Admin';

  @override
  String get phonebookAdminPage => 'Admin page';

  @override
  String get phonebookAll => 'All';

  @override
  String get phonebookApparentName => 'Public role name:';

  @override
  String get phonebookAssociation => 'Association:';

  @override
  String get phonebookAssociationDetail => 'Association details:';

  @override
  String get phonebookAssociationKind => 'Type of association:';

  @override
  String get phonebookAssociationPure => 'Association';

  @override
  String get phonebookAssociationPureSearch => '  Association';

  @override
  String get phonebookAssociations => 'Associations:';

  @override
  String get phonebookCancel => 'Cancel';

  @override
  String get phonebookChangeMandate => 'Switch to mandate ';

  @override
  String get phonebookChangeMandateConfirm =>
      'Are you sure you want to change the entire mandate?\nThis action is irreversible!';

  @override
  String get phonebookCopied => 'Copied to clipboard';

  @override
  String get phonebookDeactivateAssociation =>
      'Are you sure you want to deactivate this association?\nThis action is irreversible!';

  @override
  String get phonebookDeactivatedAssociation => 'Association deactivated';

  @override
  String get phonebookDeactivatedAssociationWarning =>
      'Warning, this association is deactivated, you cannot modify it';

  @override
  String get phonebookDeactivating => 'Deactivate the association?';

  @override
  String get phonebookDeactivatingError => 'Error during deactivation';

  @override
  String get phonebookDetail => 'Details:';

  @override
  String get phonebookDeleteAssociation =>
      'Delete the association?\nThis will erase all association history';

  @override
  String get phonebookDeletedAssociation => 'Association deleted';

  @override
  String get phonebookDeletedMember => 'Member deleted';

  @override
  String get phonebookDeleting => 'Deleting';

  @override
  String get phonebookDeletingError => 'Error deleting';

  @override
  String get phonebookDescription => 'Description';

  @override
  String get phonebookEdit => 'Edit';

  @override
  String get phonebookEditMembership => 'Edit role';

  @override
  String get phonebookEmail => 'Email:';

  @override
  String get phonebookEmailCopied => 'Email copied to clipboard';

  @override
  String get phonebookEmptyApparentName => 'Please enter a role name';

  @override
  String get phonebookEmptyFieldError => 'A field is not filled';

  @override
  String get phonebookEmptyKindError => 'Please choose an association type';

  @override
  String get phonebookEmptyMember => 'No member selected';

  @override
  String get phonebookErrorAssociationLoading => 'Error loading association';

  @override
  String get phonebookErrorAssociationNameEmpty =>
      'Please enter an association name';

  @override
  String get phonebookErrorAssociationPicture =>
      'Error editing association picture';

  @override
  String get phonebookErrorKindsLoading => 'Error loading association types';

  @override
  String get phonebookErrorLoadAssociationList =>
      'Error loading association list';

  @override
  String get phonebookErrorLoadAssociationMember =>
      'Error loading association members';

  @override
  String get phonebookErrorLoadAssociationPicture =>
      'Error loading association picture';

  @override
  String get phonebookErrorLoadProfilePicture => 'Error';

  @override
  String get phonebookErrorRoleTagsLoading => 'Error loading role tags';

  @override
  String get phonebookExistingMembership =>
      'This member is already in the current mandate';

  @override
  String get phonebookFirstname => 'First name:';

  @override
  String get phonebookGroups => 'Associated groups:';

  @override
  String get phonebookMandateChangingError => 'Error changing mandate';

  @override
  String get phonebookMember => 'Member';

  @override
  String get phonebookMemberReordered => 'Member reordered';

  @override
  String get phonebookMembers => 'Members';

  @override
  String get phonebookMembershipAssociationError =>
      'Please choose an association';

  @override
  String get phonebookMembershipRole => 'Role:';

  @override
  String get phonebookMembershipRoleError => 'Please choose a role';

  @override
  String get phonebookName => 'Last name:';

  @override
  String get phonebookNameCopied => 'Name and first name copied to clipboard';

  @override
  String get phonebookNamePure => 'Last name';

  @override
  String get phonebookNewMandate => 'New mandate';

  @override
  String get phonebookNewMandateConfirmed => 'Mandate changed';

  @override
  String get phonebookNickname => 'Nickname:';

  @override
  String get phonebookNicknameCopied => 'Nickname copied to clipboard';

  @override
  String get phonebookNoAssociationFound => 'No association found';

  @override
  String get phonebookNoMember => 'No member';

  @override
  String get phonebookNoMemberRole => 'No role found';

  @override
  String get phonebookPhone => 'Phone:';

  @override
  String get phonebookPhonebook => 'Phonebook';

  @override
  String get phonebookPhonebookSearch => 'Search';

  @override
  String get phonebookPhonebookSearchAssociation => 'Association';

  @override
  String get phonebookPhonebookSearchField => 'Search:';

  @override
  String get phonebookPhonebookSearchName => 'Last name/First name/Nickname';

  @override
  String get phonebookPhonebookSearchRole => 'Position';

  @override
  String get phonebookPresidentRoleTag => 'Prez\'';

  @override
  String get phonebookPromoNotGiven => 'Promotion not provided';

  @override
  String get phonebookPromotion => 'Promotion:';

  @override
  String get phonebookReorderingError => 'Error during reordering';

  @override
  String get phonebookResearch => 'Search';

  @override
  String get phonebookRolePure => 'Role';

  @override
  String get phonebookTooHeavyAssociationPicture =>
      'Image is too large (max 4MB)';

  @override
  String get phonebookUpdateGroups => 'Update groups';

  @override
  String get phonebookUpdatedAssociation => 'Association updated';

  @override
  String get phonebookUpdatedAssociationPicture =>
      'Association picture has been changed';

  @override
  String get phonebookUpdatedGroups => 'Groups updated';

  @override
  String get phonebookUpdatedMember => 'Member updated';

  @override
  String get phonebookUpdatingError => 'Error during update';

  @override
  String get phonebookValidation => 'Validate';

  @override
  String get purchasesPurchases => 'Purchases';

  @override
  String get purchasesResearch => 'Search';

  @override
  String get purchasesNoPurchasesFound => 'No purchases found';

  @override
  String get purchasesNoTickets => 'No tickets';

  @override
  String get purchasesTicketsError => 'Error loading tickets';

  @override
  String get purchasesPurchasesError => 'Error loading purchases';

  @override
  String get purchasesNoPurchases => 'No purchase';

  @override
  String get purchasesTimes => 'times';

  @override
  String get purchasesAlreadyUsed => 'Already used';

  @override
  String get purchasesNotPaid => 'Not validated';

  @override
  String get purchasesPleaseSelectProduct => 'Please select a product';

  @override
  String get purchasesProducts => 'Products';

  @override
  String get purchasesCancel => 'Cancel';

  @override
  String get purchasesValidate => 'Validate';

  @override
  String get purchasesLeftScan => 'Scans remaining';

  @override
  String get purchasesTag => 'Tag';

  @override
  String get purchasesHistory => 'History';

  @override
  String get purchasesPleaseSelectSeller => 'Please select a seller';

  @override
  String get purchasesNoTagGiven => 'Warning, no tag entered';

  @override
  String get purchasesTickets => 'Tickets';

  @override
  String get purchasesNoScannableProducts => 'No scannable products';

  @override
  String get purchasesLoading => 'Waiting for scan';

  @override
  String get purchasesScan => 'Scan';

  @override
  String get raffleRaffle => 'Raffle';

  @override
  String get rafflePrize => 'Prize';

  @override
  String get rafflePrizes => 'Prizes';

  @override
  String get raffleActualRaffles => 'Current raffles';

  @override
  String get rafflePastRaffles => 'Past raffles';

  @override
  String get raffleYourTickets => 'All your tickets';

  @override
  String get raffleCreateMenu => 'Creation menu';

  @override
  String get raffleNextRaffles => 'Upcoming raffles';

  @override
  String get raffleNoTicket => 'You have no ticket';

  @override
  String get raffleSeeRaffleDetail => 'View prizes/tickets';

  @override
  String get raffleActualPrize => 'Current prizes';

  @override
  String get raffleMajorPrize => 'Major prizes';

  @override
  String get raffleTakeTickets => 'Take your tickets';

  @override
  String get raffleNoTicketBuyable => 'You cannot buy tickets right now';

  @override
  String get raffleNoCurrentPrize => 'There are no prizes currently';

  @override
  String get raffleModifTombola =>
      'You can modify your raffles or create new ones, all decisions must then be approved by admins';

  @override
  String get raffleCreateYourRaffle => 'Your raffle creation menu';

  @override
  String get rafflePossiblePrice => 'Possible prize';

  @override
  String get raffleInformation => 'Information and statistics';

  @override
  String get raffleAccounts => 'Accounts';

  @override
  String get raffleAdd => 'Add';

  @override
  String get raffleUpdatedAmount => 'Amount updated';

  @override
  String get raffleUpdatingError => 'Error during update';

  @override
  String get raffleDeletedPrize => 'Prize deleted';

  @override
  String get raffleDeletingError => 'Error during deletion';

  @override
  String get raffleQuantity => 'Quantity';

  @override
  String get raffleClose => 'Close';

  @override
  String get raffleOpen => 'Open';

  @override
  String get raffleAddTypeTicketSimple => 'Add';

  @override
  String get raffleAddingError => 'Error during addition';

  @override
  String get raffleEditTypeTicketSimple => 'Edit';

  @override
  String get raffleFillField => 'Field cannot be empty';

  @override
  String get raffleWaiting => 'Loading';

  @override
  String get raffleEditingError => 'Error during editing';

  @override
  String get raffleAddedTicket => 'Ticket added';

  @override
  String get raffleEditedTicket => 'Ticket edited';

  @override
  String get raffleAlreadyExistTicket => 'Ticket already exists';

  @override
  String get raffleNumberExpected => 'An integer is expected';

  @override
  String get raffleDeletedTicket => 'Ticket deleted';

  @override
  String get raffleAddPrize => 'Add';

  @override
  String get raffleEditPrize => 'Edit';

  @override
  String get raffleOpenRaffle => 'Open raffle';

  @override
  String get raffleCloseRaffle => 'Close raffle';

  @override
  String get raffleOpenRaffleDescription =>
      'You are going to open the raffle, users will be able to buy tickets. You will no longer be able to modify the raffle. Are you sure you want to continue?';

  @override
  String get raffleCloseRaffleDescription =>
      'You are going to close the raffle, users will no longer be able to buy tickets. Are you sure you want to continue?';

  @override
  String get raffleNoCurrentRaffle => 'There is no ongoing raffle';

  @override
  String get raffleBoughtTicket => 'Ticket purchased';

  @override
  String get raffleDrawingError => 'Error during drawing';

  @override
  String get raffleInvalidPrice => 'Price must be greater than 0';

  @override
  String get raffleMustBePositive => 'Number must be strictly positive';

  @override
  String get raffleDraw => 'Draw';

  @override
  String get raffleDrawn => 'Drawn';

  @override
  String get raffleError => 'Error';

  @override
  String get raffleGathered => 'Collected';

  @override
  String get raffleTickets => 'Tickets';

  @override
  String get raffleTicket => 'ticket';

  @override
  String get raffleWinner => 'Winner';

  @override
  String get raffleNoPrize => 'No prize';

  @override
  String get raffleDeletePrize => 'Delete prize';

  @override
  String get raffleDeletePrizeDescription =>
      'You are going to delete the prize, are you sure you want to continue?';

  @override
  String get raffleDrawing => 'Drawing';

  @override
  String get raffleDrawingDescription => 'Draw the prize winner?';

  @override
  String get raffleDeleteTicket => 'Delete ticket';

  @override
  String get raffleDeleteTicketDescription =>
      'You are going to delete the ticket, are you sure you want to continue?';

  @override
  String get raffleWinningTickets => 'Winning tickets';

  @override
  String get raffleNoWinningTicketYet =>
      'Winning tickets will be displayed here';

  @override
  String get raffleName => 'Name';

  @override
  String get raffleDescription => 'Description';

  @override
  String get raffleBuyThisTicket => 'Buy this ticket';

  @override
  String get raffleLockedRaffle => 'Locked raffle';

  @override
  String get raffleUnavailableRaffle => 'Unavailable raffle';

  @override
  String get raffleNotEnoughMoney => 'You don\'t have enough money';

  @override
  String get raffleWinnable => 'winnable';

  @override
  String get raffleNoDescription => 'No description';

  @override
  String get raffleAmount => 'Balance';

  @override
  String get raffleLoading => 'Loading';

  @override
  String get raffleTicketNumber => 'Number of tickets';

  @override
  String get rafflePrice => 'Price';

  @override
  String get raffleEditRaffle => 'Edit raffle';

  @override
  String get raffleEdit => 'Edit';

  @override
  String get raffleAddPackTicket => 'Add ticket pack';

  @override
  String get recommendationRecommendation => 'Recommendation';

  @override
  String get recommendationTitle => 'Title';

  @override
  String get recommendationLogo => 'Logo';

  @override
  String get recommendationCode => 'Code';

  @override
  String get recommendationSummary => 'Short summary';

  @override
  String get recommendationDescription => 'Description';

  @override
  String get recommendationAdd => 'Add';

  @override
  String get recommendationEdit => 'Edit';

  @override
  String get recommendationDelete => 'Delete';

  @override
  String get recommendationAddImage => 'Please add an image';

  @override
  String get recommendationAddedRecommendation => 'Deal added';

  @override
  String get recommendationEditedRecommendation => 'Deal updated';

  @override
  String get recommendationDeleteRecommendationConfirmation =>
      'Are you sure you want to delete this deal?';

  @override
  String get recommendationDeleteRecommendation => 'Delete';

  @override
  String get recommendationDeletingRecommendationError =>
      'Error during deletion';

  @override
  String get recommendationDeletedRecommendation => 'Deal deleted';

  @override
  String get recommendationIncorrectOrMissingFields =>
      'Incorrect or missing fields';

  @override
  String get recommendationEditingError => 'Edit failed';

  @override
  String get recommendationAddingError => 'Add failed';

  @override
  String get recommendationCopiedCode => 'Discount code copied';

  @override
  String get seedLibraryAdd => 'Add';

  @override
  String get seedLibraryAddedPlant => 'Plant added';

  @override
  String get seedLibraryAddedSpecies => 'Species added';

  @override
  String get seedLibraryAddingError => 'Error during addition';

  @override
  String get seedLibraryAddPlant => 'Deposit a plant';

  @override
  String get seedLibraryAddSpecies => 'Add a species';

  @override
  String get seedLibraryAll => 'All';

  @override
  String get seedLibraryAncestor => 'Ancestor';

  @override
  String get seedLibraryAround => 'around';

  @override
  String get seedLibraryAutumn => 'Autumn';

  @override
  String get seedLibraryBorrowedPlant => 'Borrowed plant';

  @override
  String get seedLibraryBorrowingDate => 'Borrowing date:';

  @override
  String get seedLibraryBorrowPlant => 'Borrow plant';

  @override
  String get seedLibraryCard => 'Card';

  @override
  String get seedLibraryChoosingAncestor => 'Please choose an ancestor';

  @override
  String get seedLibraryChoosingSpecies => 'Please choose a species';

  @override
  String get seedLibraryChoosingSpeciesOrAncestor =>
      'Please choose a species or an ancestor';

  @override
  String get seedLibraryContact => 'Contact:';

  @override
  String get seedLibraryDays => 'days';

  @override
  String get seedLibraryDeadMsg => 'Do you want to declare the plant dead?';

  @override
  String get seedLibraryDeadPlant => 'Dead plant';

  @override
  String get seedLibraryDeathDate => 'Date of death';

  @override
  String get seedLibraryDeletedSpecies => 'Species deleted';

  @override
  String get seedLibraryDeleteSpecies => 'Delete species?';

  @override
  String get seedLibraryDeleting => 'Deleting';

  @override
  String get seedLibraryDeletingError => 'Error during deletion';

  @override
  String get seedLibraryDepositNotAvailable =>
      'Plant deposit is not possible without borrowing a plant first';

  @override
  String get seedLibraryDescription => 'Description';

  @override
  String get seedLibraryDifficulty => 'Difficulty:';

  @override
  String get seedLibraryEdit => 'Edit';

  @override
  String get seedLibraryEditedPlant => 'Plant updated';

  @override
  String get seedLibraryEditInformation => 'Edit information';

  @override
  String get seedLibraryEditingError => 'Error during editing';

  @override
  String get seedLibraryEditSpecies => 'Edit species';

  @override
  String get seedLibraryEmptyDifficultyError => 'Please choose a difficulty';

  @override
  String get seedLibraryEmptyFieldError => 'Please fill all fields';

  @override
  String get seedLibraryEmptyTypeError => 'Please choose a plant type';

  @override
  String get seedLibraryEndMonth => 'End month:';

  @override
  String get seedLibraryFacebookUrl => 'Facebook link';

  @override
  String get seedLibraryFilters => 'Filters';

  @override
  String get seedLibraryForum => 'Oskour mom I killed my plant - Help forum';

  @override
  String get seedLibraryForumUrl => 'Forum link';

  @override
  String get seedLibraryHelpSheets => 'Plant sheets';

  @override
  String get seedLibraryInformation => 'Information:';

  @override
  String get seedLibraryMaturationTime => 'Maturation time';

  @override
  String get seedLibraryMonthJan => 'January';

  @override
  String get seedLibraryMonthFeb => 'February';

  @override
  String get seedLibraryMonthMar => 'March';

  @override
  String get seedLibraryMonthApr => 'April';

  @override
  String get seedLibraryMonthMay => 'May';

  @override
  String get seedLibraryMonthJun => 'June';

  @override
  String get seedLibraryMonthJul => 'July';

  @override
  String get seedLibraryMonthAug => 'August';

  @override
  String get seedLibraryMonthSep => 'September';

  @override
  String get seedLibraryMonthOct => 'October';

  @override
  String get seedLibraryMonthNov => 'November';

  @override
  String get seedLibraryMonthDec => 'December';

  @override
  String get seedLibraryMyPlants => 'My plants';

  @override
  String get seedLibraryName => 'Name';

  @override
  String get seedLibraryNbSeedsRecommended => 'Number of seeds recommended';

  @override
  String get seedLibraryNbSeedsRecommendedError =>
      'Please enter a recommended seed number greater than 0';

  @override
  String get seedLibraryNoDateError => 'Please enter a date';

  @override
  String get seedLibraryNoFilteredPlants =>
      'No plants match your search. Try other filters.';

  @override
  String get seedLibraryNoMorePlant => 'No plants available';

  @override
  String get seedLibraryNoPersonalPlants =>
      'You don\'t have any plants yet in your seed library. You can add some in the stocks.';

  @override
  String get seedLibraryNoSpecies => 'No species found';

  @override
  String get seedLibraryNoStockPlants => 'No plants available in stock';

  @override
  String get seedLibraryNotes => 'Notes';

  @override
  String get seedLibraryOk => 'OK';

  @override
  String get seedLibraryPlantationPeriod => 'Planting period:';

  @override
  String get seedLibraryPlantationType => 'Plantation type:';

  @override
  String get seedLibraryPlantDetail => 'Plant details';

  @override
  String get seedLibraryPlantingDate => 'Planting date';

  @override
  String get seedLibraryPlantingNow => 'I\'m planting it now';

  @override
  String get seedLibraryPrefix => 'Prefix';

  @override
  String get seedLibraryPrefixError => 'Prefix already used';

  @override
  String get seedLibraryPrefixLengthError => 'The prefix must be 3 characters';

  @override
  String get seedLibraryPropagationMethod => 'Propagation method:';

  @override
  String get seedLibraryReference => 'Reference:';

  @override
  String get seedLibraryRemovedPlant => 'Plant removed';

  @override
  String get seedLibraryRemovingError => 'Error removing plant';

  @override
  String get seedLibraryResearch => 'Search';

  @override
  String get seedLibrarySaveChanges => 'Save changes';

  @override
  String get seedLibrarySeason => 'Season:';

  @override
  String get seedLibrarySeed => 'Seed';

  @override
  String get seedLibrarySeeds => 'seeds';

  @override
  String get seedLibrarySeedDeposit => 'Plant deposit';

  @override
  String get seedLibrarySeedLibrary => 'Seed library';

  @override
  String get seedLibrarySeedQuantitySimple => 'Seed quantity';

  @override
  String get seedLibrarySeedQuantity => 'Seed quantity:';

  @override
  String get seedLibraryShowDeadPlants => 'Show dead plants';

  @override
  String get seedLibrarySpecies => 'Species:';

  @override
  String get seedLibrarySpeciesHelp => 'Help on species';

  @override
  String get seedLibrarySpeciesPlural => 'Species';

  @override
  String get seedLibrarySpeciesSimple => 'Species';

  @override
  String get seedLibrarySpeciesType => 'Species type:';

  @override
  String get seedLibrarySpring => 'Spring';

  @override
  String get seedLibraryStartMonth => 'Start month:';

  @override
  String get seedLibraryStock => 'Available stock';

  @override
  String get seedLibrarySummer => 'Summer';

  @override
  String get seedLibraryStocks => 'Stocks';

  @override
  String get seedLibraryTimeUntilMaturation => 'Time until maturation:';

  @override
  String get seedLibraryType => 'Type:';

  @override
  String get seedLibraryUnableToOpen => 'Unable to open link';

  @override
  String get seedLibraryUpdate => 'Edit';

  @override
  String get seedLibraryUpdatedInformation => 'Information updated';

  @override
  String get seedLibraryUpdatedSpecies => 'Species updated';

  @override
  String get seedLibraryUpdatedPlant => 'Plant updated';

  @override
  String get seedLibraryUpdatingError => 'Error updating';

  @override
  String get seedLibraryWinter => 'Winter';

  @override
  String get seedLibraryWriteReference =>
      'Please write the following reference: ';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsAddProfilePicture => 'Add a photo';

  @override
  String get settingsAdmin => 'Administrator';

  @override
  String get settingsAskHelp => 'Ask for help';

  @override
  String get settingsAssociation => 'Association';

  @override
  String get settingsBirthday => 'Birthday';

  @override
  String get settingsBugs => 'Bugs';

  @override
  String get settingsChangePassword => 'Change password';

  @override
  String get settingsChangingPassword =>
      'Do you really want to change your password?';

  @override
  String get settingsConfirmPassword => 'Confirm password';

  @override
  String get settingsCopied => 'Copied!';

  @override
  String get settingsDarkMode => 'Dark mode';

  @override
  String get settingsDarkModeOff => 'Off';

  @override
  String get settingsDeleteLogs => 'Delete logs?';

  @override
  String get settingsDeleteNotificationLogs => 'Delete notification logs?';

  @override
  String get settingsDetelePersonalData => 'Delete my personal data';

  @override
  String get settingsDetelePersonalDataDesc =>
      'This action notifies the administrator that you want to delete your personal data.';

  @override
  String get settingsDeleting => 'Deleting';

  @override
  String get settingsEdit => 'Edit';

  @override
  String get settingsEditAccount => 'Edit account';

  @override
  String get settingsEmail => 'Email';

  @override
  String get settingsEmptyField => 'This field cannot be empty';

  @override
  String get settingsErrorProfilePicture => 'Error editing profile picture';

  @override
  String get settingsErrorSendingDemand => 'Error sending request';

  @override
  String get settingsEventsIcal => 'Ical link for events';

  @override
  String get settingsExpectingDate => 'Expected birth date';

  @override
  String get settingsFirstname => 'First name';

  @override
  String get settingsFloor => 'Floor';

  @override
  String get settingsHelp => 'Help';

  @override
  String get settingsIcalCopied => 'Ical link copied!';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageVar => 'English 🇬🇧';

  @override
  String get settingsLogs => 'Logs';

  @override
  String get settingsModules => 'Modules';

  @override
  String get settingsMyIcs => 'My Ical link';

  @override
  String get settingsName => 'Last name';

  @override
  String get settingsNewPassword => 'New password';

  @override
  String get settingsNickname => 'Nickname';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsOldPassword => 'Old password';

  @override
  String get settingsPasswordChanged => 'Password changed';

  @override
  String get settingsPasswordsNotMatch => 'Passwords do not match';

  @override
  String get settingsPersonalData => 'Personal data';

  @override
  String get settingsPersonalisation => 'Personalization';

  @override
  String get settingsPhone => 'Phone';

  @override
  String get settingsProfilePicture => 'Profile picture';

  @override
  String get settingsPromo => 'Promotion';

  @override
  String get settingsRepportBug => 'Report a bug';

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsSecurity => 'Security';

  @override
  String get settingsSendedDemand => 'Request sent';

  @override
  String get settingsSettings => 'Settings';

  @override
  String get settingsTooHeavyProfilePicture => 'Image is too large (max 4MB)';

  @override
  String get settingsUpdatedProfile => 'Profile updated';

  @override
  String get settingsUpdatedProfilePicture => 'Profile picture updated';

  @override
  String get settingsUpdateNotification => 'Update notifications';

  @override
  String get settingsUpdatingError => 'Error updating profile';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsPasswordStrength => 'Password strength';

  @override
  String get settingsPasswordStrengthVeryWeak => 'Very weak';

  @override
  String get settingsPasswordStrengthWeak => 'Weak';

  @override
  String get settingsPasswordStrengthMedium => 'Medium';

  @override
  String get settingsPasswordStrengthStrong => 'Strong';

  @override
  String get settingsPasswordStrengthVeryStrong => 'Very strong';

  @override
  String get settingsPhoneNumber => 'Phone number';

  @override
  String get settingsValidate => 'Confirm';

  @override
  String get settingsEditedAccount => 'Account edited';

  @override
  String get settingsFailedToEditAccount => 'Failed to edit account';

  @override
  String get settingsChooseLanguage => 'Choose a language';

  @override
  String settingsNotificationCounter(int active, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      active,
      locale: localeName,
      other: 'notifications',
      one: 'notification',
      zero: 'notification',
    );
    return '$active/$total active $_temp0';
  }

  @override
  String get settingsEvent => 'Event';

  @override
  String get settingsIcal => 'Ical link';

  @override
  String get settingsSynncWithCalendar => 'Sync with calendar';

  @override
  String get settingsIcalLinkCopied => 'Ical link copied';

  @override
  String get settingsProfile => 'Profile';

  @override
  String get voteAdd => 'Add';

  @override
  String get voteAddMember => 'Add a member';

  @override
  String get voteAddedPretendance => 'List added';

  @override
  String get voteAddedSection => 'Section added';

  @override
  String get voteAddingError => 'Error adding';

  @override
  String get voteAddPretendance => 'Add a list';

  @override
  String get voteAddSection => 'Add a section';

  @override
  String get voteAll => 'All';

  @override
  String get voteAlreadyAddedMember => 'Member already added';

  @override
  String get voteAlreadyVoted => 'Vote recorded';

  @override
  String get voteChooseList => 'Choose a list';

  @override
  String get voteClear => 'Reset';

  @override
  String get voteClearVotes => 'Reset votes';

  @override
  String get voteClosedVote => 'Votes closed';

  @override
  String get voteCloseVote => 'Close votes';

  @override
  String get voteConfirmVote => 'Confirm vote';

  @override
  String get voteCountVote => 'Count votes';

  @override
  String get voteDeletedAll => 'All deleted';

  @override
  String get voteDeletedPipo => 'Fake lists deleted';

  @override
  String get voteDeletedSection => 'Section deleted';

  @override
  String get voteDeleteAll => 'Delete all';

  @override
  String get voteDeleteAllDescription =>
      'Do you really want to delete everything?';

  @override
  String get voteDeletePipo => 'Delete fake lists';

  @override
  String get voteDeletePipoDescription =>
      'Do you really want to delete the fake lists?';

  @override
  String get voteDeletePretendance => 'Delete the list';

  @override
  String get voteDeletePretendanceDesc =>
      'Do you really want to delete this list?';

  @override
  String get voteDeleteSection => 'Delete the section';

  @override
  String get voteDeleteSectionDescription =>
      'Do you really want to delete this section?';

  @override
  String get voteDeletingError => 'Error deleting';

  @override
  String get voteDescription => 'Description';

  @override
  String get voteEdit => 'Edit';

  @override
  String get voteEditedPretendance => 'List edited';

  @override
  String get voteEditedSection => 'Section edited';

  @override
  String get voteEditingError => 'Error editing';

  @override
  String get voteErrorClosingVotes => 'Error closing votes';

  @override
  String get voteErrorCountingVotes => 'Error counting votes';

  @override
  String get voteErrorResetingVotes => 'Error resetting votes';

  @override
  String get voteErrorOpeningVotes => 'Error opening votes';

  @override
  String get voteIncorrectOrMissingFields => 'Incorrect or missing fields';

  @override
  String get voteMembers => 'Members';

  @override
  String get voteName => 'Name';

  @override
  String get voteNoPretendanceList => 'No list of candidates';

  @override
  String get voteNoSection => 'No section';

  @override
  String get voteCanNotVote => 'You cannot vote';

  @override
  String get voteNoSectionList => 'No section';

  @override
  String get voteNotOpenedVote => 'Vote not opened';

  @override
  String get voteOnGoingCount => 'Counting in progress';

  @override
  String get voteOpenVote => 'Open votes';

  @override
  String get votePipo => 'Fake';

  @override
  String get votePretendance => 'Lists';

  @override
  String get votePretendanceDeleted => 'Candidate list deleted';

  @override
  String get votePretendanceNotDeleted => 'Error deleting';

  @override
  String get voteProgram => 'Program';

  @override
  String get votePublish => 'Publish';

  @override
  String get votePublishVoteDescription =>
      'Do you really want to publish the votes?';

  @override
  String get voteResetedVotes => 'Votes reset';

  @override
  String get voteResetVote => 'Reset votes';

  @override
  String get voteResetVoteDescription => 'What do you want to do?';

  @override
  String get voteRole => 'Role';

  @override
  String get voteSectionDescription => 'Section description';

  @override
  String get voteSection => 'Section';

  @override
  String get voteSectionName => 'Section name';

  @override
  String get voteSeeMore => 'See more';

  @override
  String get voteSelected => 'Selected';

  @override
  String get voteShowVotes => 'Show votes';

  @override
  String get voteVote => 'Vote';

  @override
  String get voteVoteError => 'Error recording vote';

  @override
  String get voteVoteFor => 'Vote for ';

  @override
  String get voteVoteNotStarted => 'Vote not opened';

  @override
  String get voteVoters => 'Voting groups';

  @override
  String get voteVoteSuccess => 'Vote recorded';

  @override
  String get voteVotes => 'Votes';

  @override
  String get voteVotesClosed => 'Votes closed';

  @override
  String get voteVotesCounted => 'Votes counted';

  @override
  String get voteVotesOpened => 'Votes opened';

  @override
  String get voteWarning => 'Warning';

  @override
  String get voteWarningMessage =>
      'Selection will not be saved.\nDo you want to continue?';

  @override
  String get moduleAdvert => 'Advert';

  @override
  String get moduleAmap => 'AMAP';

  @override
  String get moduleBooking => 'Booking';

  @override
  String get moduleCalendar => 'Calendar';

  @override
  String get moduleCentralisation => 'Centralisation';

  @override
  String get moduleCinema => 'Cinema';

  @override
  String get moduleEvent => 'Event';

  @override
  String get moduleFlappyBird => 'Flappy Bird';

  @override
  String get moduleLoan => 'Loan';

  @override
  String get modulePhonebook => 'Phonebook';

  @override
  String get modulePurchases => 'Purchases';

  @override
  String get moduleRaffle => 'Raffle';

  @override
  String get moduleRecommendation => 'Recommendation';

  @override
  String get moduleSeedLibrary => 'Seed Library';

  @override
  String get moduleVote => 'Vote';

  @override
  String get modulePh => 'PH';

  @override
  String get moduleSettings => 'Settings';

  @override
  String get moduleFeed => 'Feed';

  @override
  String get moduleStyleGuide => 'StyleGuide';

  @override
  String get moduleAdmin => 'Administration';

  @override
  String get moduleOthers => 'Others';

  @override
  String get modulePayment => 'Payment';

  @override
  String get paiementTopUp => 'Top-up';

  @override
  String get paiementStoreManagement => 'Association management';

  @override
  String get paiementDeleteStore => 'Delete association';

  @override
  String get paiementDeleteStoreDescription =>
      'Are you sure you want to delete this association?';

  @override
  String get paiementDeleteStoreError => 'Unable to delete the association';

  @override
  String get paiementStoreDeleted => 'Association deleted';

  @override
  String get paiementAddThisDevice => 'Add this device';

  @override
  String get paiementThisDevice => '(this device)';

  @override
  String get paiementCancelled => 'Cancelled';

  @override
  String get paiementThe => 'The';

  @override
  String get paiementOf => 'of';

  @override
  String get paiementRefundedThe => 'Refunded on';

  @override
  String get paiementAt => 'at';

  @override
  String get paiementPleaseAcceptTOS => 'Please accept the Terms of Service.';

  @override
  String get paiementAskDeviceActivation => 'Device activation request';

  @override
  String get paiementDeviceActivationReceived =>
      'The activation request has been received, please check your email to finalize the process';

  @override
  String get paiementRevokeDevice => 'Revoke device?';

  @override
  String get paiementRevokeDeviceDescription =>
      'You will no longer be able to use this device for payments';

  @override
  String get paiementDeviceRevoked => 'Device revoked';

  @override
  String get paiementDeviceRevokingError => 'Error while revoking device';

  @override
  String get paiementPleaseAcceptPopup => 'Please allow popups';

  @override
  String get paiementProceedSuccessfully => 'Payment completed successfully';

  @override
  String get paiementCancelledTransaction => 'Payment cancelled';

  @override
  String get paiementPleaseEnterMinAmount =>
      'Please enter an amount greater than 1';

  @override
  String get paiementMaxAmount => 'The maximum wallet amount is';

  @override
  String get paiementPayWithHA => 'Pay with HelloAsso';

  @override
  String get paiementBalanceAfterTopUp => 'Balance after top-up:';

  @override
  String get paiementPersonalBalance => 'Personal balance';

  @override
  String get paiementDevices => 'Devices';

  @override
  String get paiementPay => 'Pay';

  @override
  String get paiementDeviceNotRegistered => 'Device not registered';

  @override
  String get paiementDeviceNotRegisteredDescription =>
      'Your device is not registered yet. \nTo register it, please go to the devices page.';

  @override
  String get paiementAccessPage => 'Access the page';

  @override
  String get paiementDeviceNotActivated => 'Device not activated';

  @override
  String get paiementDeviceNotActivatedDescription =>
      'Your device is not yet activated. \nTo activate it, please go to the devices page.';

  @override
  String get paiementReactivateRevokedDeviceDescription =>
      'Your device has been revoked. \nTo reactivate it, please go to the devices page.';

  @override
  String get paiementDeviceRecoveryError => 'Error while retrieving device';

  @override
  String get paiementStats => 'Stats';

  @override
  String get paimentTopUpAction => 'Top-up';

  @override
  String get paiementGetBalanceError => 'Error while retrieving balance: ';

  @override
  String get paiementLastTransactions => 'Latest transactions';

  @override
  String get paiementGetTransactionsError =>
      'Error while retrieving transactions: ';

  @override
  String get paiementStoreBalance => 'Association balance';

  @override
  String get paiementScan => 'Scan';

  @override
  String get paiementManagement => 'Management';

  @override
  String get paiementHistory => 'History';

  @override
  String get paiementHandOver => 'Handover';

  @override
  String get paiementStores => 'Associations';

  @override
  String get paiementAdmin => 'Administrator';

  @override
  String get paiementSuccededTransaction => 'Successful payment';

  @override
  String get paiementNewCGU => 'New Terms of Service';

  @override
  String get paiementDecline => 'Decline';

  @override
  String get paiementAccept => 'Accept';

  @override
  String get paiementAmount => 'Amount';

  @override
  String get paiementValidUntil => 'Valid until';

  @override
  String get paiementClose => 'Close';

  @override
  String get paiementPleaseEnterValidAmount => 'Please enter a valid amount';

  @override
  String get paiementPleaseAuthenticate => 'Please authenticate';

  @override
  String get paiementAthenticationRequired => 'Authentication required to pay';

  @override
  String get paiementNoThanks => 'No thanks';

  @override
  String get paiementAuthentificationFailed => 'Authentication failed';

  @override
  String get paiementPleaseAddDevice => 'Please add this device to pay';

  @override
  String get paiementPayment => 'Payment';

  @override
  String get paiementBalanceAfterTransaction => 'Balance after payment: ';

  @override
  String get paiementCancel => 'Cancel';

  @override
  String get paiementLimitedTo => 'Limited to';

  @override
  String get paiementScanCode => 'Scan a code';

  @override
  String get paiementNext => 'Next';

  @override
  String get paiementCancelTransaction => 'Cancel transaction';

  @override
  String get paiementTransactionCancelled => 'Transaction cancelled';

  @override
  String get paiementTransactionCancelledDescription =>
      'Are you sure you want to cancel the transaction of';

  @override
  String get paiementTransactionCancelledError =>
      'Error while cancelling the transaction';

  @override
  String get paiementNoMembership => 'No membership';

  @override
  String get paiementNoMembershipDescription =>
      'This product is not available to non-members. Confirm the payment?';

  @override
  String get paiementQRCodeAlreadyUsed => 'QR Code already used';

  @override
  String get paiementCameraPermissionRequired => 'Camera permission required';

  @override
  String get paiementCameraPerssionRequiredDescription =>
      'To scan a QR Code, you must allow camera access.';

  @override
  String get paiementSettings => 'Settings';

  @override
  String get paiementReceived => 'Received';

  @override
  String get paiementSpent => 'Spent';

  @override
  String get paiementNoTrasactionForThisMonth =>
      'No transactions for this month';

  @override
  String get paiementNoTransactinon => 'No transaction';

  @override
  String get paiementSellerRigths => 'Seller rights';

  @override
  String get paiementCanBank => 'Can collect payments';

  @override
  String get paiementCanSeeHistory => 'Can view history';

  @override
  String get paiementCanCancelTransaction => 'Can cancel transactions';

  @override
  String get paiementCanManageSellers => 'Can manage sellers';

  @override
  String get paiementAddedSeller => 'Seller added';

  @override
  String get paiementAddingSellerError => 'Error while adding seller';

  @override
  String get paiementBank => 'Collect';

  @override
  String get paiementSeeHistory => 'View history';

  @override
  String get paiementCancelTransactions => 'Cancel transactions';

  @override
  String get paiementManageSellers => 'Manage sellers';

  @override
  String get paiementStructureAdmin => 'Structure administrator';

  @override
  String get paiementRightsOf => 'Rights of';

  @override
  String get paiementRightsUpdated => 'Rights updated';

  @override
  String get paiementRightsUpdateError => 'Error while updating rights';

  @override
  String get paiementDeleteSellerDescription =>
      'Are you sure you want to delete this seller?';

  @override
  String get paiementDeletedSeller => 'Seller deleted';

  @override
  String get paiementDeletingSellerError => 'Error while deleting seller';

  @override
  String get paiementDeleteSeller => 'Delete seller';

  @override
  String get paiementAdd => 'Add';

  @override
  String get paiementAddSeller => 'Add seller';

  @override
  String get paiementSellerError => 'You are not a seller of this association';

  @override
  String get paiementSellersOf => 'Sellers of';

  @override
  String get paiementModify => 'Edit';

  @override
  String get paiementAStore => 'an association';

  @override
  String get paiementStoreName => 'Association name';

  @override
  String get paiementSuccessfullyAddedStore => 'Association successfully added';

  @override
  String get paiementSuccessfullyModifiedStore =>
      'Association successfully updated';

  @override
  String get paiementAddingStoreError => 'Error while adding the association';

  @override
  String get paiementModifyingStoreError =>
      'Error while updating the association';

  @override
  String get paiementRefund => 'Refund';

  @override
  String get paiementDoneTransaction => 'Transaction completed';

  @override
  String get paiementRefundAction => 'Refund';

  @override
  String get paiementTotalDuringPeriod => 'Total during the period';

  @override
  String get paiementMean => 'Average: ';

  @override
  String get paiementTransaction => 'Transaction';

  @override
  String get paiementTransferStructure => 'Structure transfer';

  @override
  String get paiementYouAreTransferingStructureTo =>
      'You are about to transfer the structure to ';

  @override
  String get paiementTransferStructureDescription =>
      'The new manager will have access to all structure management features. You will receive an email to confirm this transfer. The link will only be active for 20 minutes. This action is irreversible. Are you sure you want to continue?';

  @override
  String get paiementTransferStructureError =>
      'Error while transferring structure';

  @override
  String get paiementTransferStructureSuccess =>
      'Structure transfer requested successfully';

  @override
  String get paiementNextAccountable => 'Next responsible';
}
