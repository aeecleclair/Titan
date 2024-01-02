// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      accessToken: json['access_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? '',
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
    };

AdvertBase _$AdvertBaseFromJson(Map<String, dynamic> json) => AdvertBase(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      advertiserId: json['advertiser_id'] as String? ?? '',
      tags: json['tags'] as String? ?? '',
    );

Map<String, dynamic> _$AdvertBaseToJson(AdvertBase instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'advertiser_id': instance.advertiserId,
      'tags': instance.tags,
    };

AdvertReturnComplete _$AdvertReturnCompleteFromJson(
        Map<String, dynamic> json) =>
    AdvertReturnComplete(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      advertiserId: json['advertiser_id'] as String? ?? '',
      tags: json['tags'] as String? ?? '',
      id: json['id'] as String? ?? '',
      advertiser: AdvertiserComplete.fromJson(
          json['advertiser'] as Map<String, dynamic>),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$AdvertReturnCompleteToJson(
        AdvertReturnComplete instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'advertiser_id': instance.advertiserId,
      'tags': instance.tags,
      'id': instance.id,
      'advertiser': instance.advertiser.toJson(),
      'date': instance.date?.toIso8601String(),
    };

AdvertUpdate _$AdvertUpdateFromJson(Map<String, dynamic> json) => AdvertUpdate(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      tags: json['tags'] as String? ?? '',
    );

Map<String, dynamic> _$AdvertUpdateToJson(AdvertUpdate instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'tags': instance.tags,
    };

AdvertiserBase _$AdvertiserBaseFromJson(Map<String, dynamic> json) =>
    AdvertiserBase(
      name: json['name'] as String? ?? '',
      groupManagerId: json['group_manager_id'] as String? ?? '',
    );

Map<String, dynamic> _$AdvertiserBaseToJson(AdvertiserBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_manager_id': instance.groupManagerId,
    };

AdvertiserComplete _$AdvertiserCompleteFromJson(Map<String, dynamic> json) =>
    AdvertiserComplete(
      name: json['name'] as String? ?? '',
      groupManagerId: json['group_manager_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$AdvertiserCompleteToJson(AdvertiserComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_manager_id': instance.groupManagerId,
      'id': instance.id,
    };

AdvertiserUpdate _$AdvertiserUpdateFromJson(Map<String, dynamic> json) =>
    AdvertiserUpdate(
      name: json['name'] as String? ?? '',
      groupManagerId: json['group_manager_id'] as String? ?? '',
    );

Map<String, dynamic> _$AdvertiserUpdateToJson(AdvertiserUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_manager_id': instance.groupManagerId,
    };

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      promo: json['promo'] as int? ?? 0,
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'email': instance.email,
      'promo': instance.promo,
      'phone': instance.phone,
    };

BatchResult _$BatchResultFromJson(Map<String, dynamic> json) => BatchResult(
      failed: json['failed'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BatchResultToJson(BatchResult instance) =>
    <String, dynamic>{
      'failed': instance.failed,
    };

BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost
    _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostFromJson(
            Map<String, dynamic> json) =>
        BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost(
          clientId: json['client_id'] as String? ?? '',
          redirectUri: json['redirect_uri'] as String? ?? '',
          responseType: json['response_type'] as String? ?? '',
          scope: json['scope'] as String? ?? '',
          state: json['state'] as String? ?? '',
          nonce: json['nonce'] as String? ?? '',
          codeChallenge: json['code_challenge'] as String? ?? '',
          codeChallengeMethod: json['code_challenge_method'] as String? ?? '',
          email: json['email'] as String? ?? '',
          password: json['password'] as String? ?? '',
        );

Map<String, dynamic>
    _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostToJson(
            BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost
                instance) =>
        <String, dynamic>{
          'client_id': instance.clientId,
          'redirect_uri': instance.redirectUri,
          'response_type': instance.responseType,
          'scope': instance.scope,
          'state': instance.state,
          'nonce': instance.nonce,
          'code_challenge': instance.codeChallenge,
          'code_challenge_method': instance.codeChallengeMethod,
          'email': instance.email,
          'password': instance.password,
        };

BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost
    _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostFromJson(
            Map<String, dynamic> json) =>
        BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost(
          image: json['image'] as String? ?? '',
        );

Map<String, dynamic>
    _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostToJson(
            BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost instance) =>
        <String, dynamic>{
          'image': instance.image,
        };

BodyCreateCampaignsLogoCampaignListsListIdLogoPost
    _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostFromJson(
            Map<String, dynamic> json) =>
        BodyCreateCampaignsLogoCampaignListsListIdLogoPost(
          image: json['image'] as String? ?? '',
        );

Map<String, dynamic> _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostToJson(
        BodyCreateCampaignsLogoCampaignListsListIdLogoPost instance) =>
    <String, dynamic>{
      'image': instance.image,
    };

BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost
    _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostFromJson(
            Map<String, dynamic> json) =>
        BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost(
          image: json['image'] as String? ?? '',
        );

Map<String,
    dynamic> _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostToJson(
        BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost instance) =>
    <String, dynamic>{
      'image': instance.image,
    };

BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost
    _$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostFromJson(
            Map<String, dynamic> json) =>
        BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost(
          image: json['image'] as String? ?? '',
        );

Map<String,
    dynamic> _$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostToJson(
        BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost instance) =>
    <String, dynamic>{
      'image': instance.image,
    };

BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost
    _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostFromJson(
            Map<String, dynamic> json) =>
        BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost(
          image: json['image'] as String? ?? '',
        );

Map<String, dynamic>
    _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostToJson(
            BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost
                instance) =>
        <String, dynamic>{
          'image': instance.image,
        };

BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost
    _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostFromJson(
            Map<String, dynamic> json) =>
        BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost(
          image: json['image'] as String? ?? '',
        );

Map<String, dynamic>
    _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostToJson(
            BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost instance) =>
        <String, dynamic>{
          'image': instance.image,
        };

BodyLoginForAccessTokenAuthSimpleTokenPost
    _$BodyLoginForAccessTokenAuthSimpleTokenPostFromJson(
            Map<String, dynamic> json) =>
        BodyLoginForAccessTokenAuthSimpleTokenPost(
          grantType: json['grant_type'] as String? ?? '',
          username: json['username'] as String? ?? '',
          password: json['password'] as String? ?? '',
          scope: json['scope'] as String? ?? '',
          clientId: json['client_id'] as String? ?? '',
          clientSecret: json['client_secret'] as String? ?? '',
        );

Map<String, dynamic> _$BodyLoginForAccessTokenAuthSimpleTokenPostToJson(
        BodyLoginForAccessTokenAuthSimpleTokenPost instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'username': instance.username,
      'password': instance.password,
      'scope': instance.scope,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
    };

BodyPostAuthorizePageAuthAuthorizePost
    _$BodyPostAuthorizePageAuthAuthorizePostFromJson(
            Map<String, dynamic> json) =>
        BodyPostAuthorizePageAuthAuthorizePost(
          responseType: json['response_type'] as String? ?? '',
          clientId: json['client_id'] as String? ?? '',
          redirectUri: json['redirect_uri'] as String? ?? '',
          scope: json['scope'] as String? ?? '',
          state: json['state'] as String? ?? '',
          nonce: json['nonce'] as String? ?? '',
          codeChallenge: json['code_challenge'] as String? ?? '',
          codeChallengeMethod: json['code_challenge_method'] as String? ?? '',
        );

Map<String, dynamic> _$BodyPostAuthorizePageAuthAuthorizePostToJson(
        BodyPostAuthorizePageAuthAuthorizePost instance) =>
    <String, dynamic>{
      'response_type': instance.responseType,
      'client_id': instance.clientId,
      'redirect_uri': instance.redirectUri,
      'scope': instance.scope,
      'state': instance.state,
      'nonce': instance.nonce,
      'code_challenge': instance.codeChallenge,
      'code_challenge_method': instance.codeChallengeMethod,
    };

BodyRecoverUserUsersRecoverPost _$BodyRecoverUserUsersRecoverPostFromJson(
        Map<String, dynamic> json) =>
    BodyRecoverUserUsersRecoverPost(
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$BodyRecoverUserUsersRecoverPostToJson(
        BodyRecoverUserUsersRecoverPost instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

BodyRegisterFirebaseDeviceNotificationDevicesPost
    _$BodyRegisterFirebaseDeviceNotificationDevicesPostFromJson(
            Map<String, dynamic> json) =>
        BodyRegisterFirebaseDeviceNotificationDevicesPost(
          firebaseToken: json['firebase_token'] as String? ?? '',
        );

Map<String, dynamic> _$BodyRegisterFirebaseDeviceNotificationDevicesPostToJson(
        BodyRegisterFirebaseDeviceNotificationDevicesPost instance) =>
    <String, dynamic>{
      'firebase_token': instance.firebaseToken,
    };

BodyTokenAuthTokenPost _$BodyTokenAuthTokenPostFromJson(
        Map<String, dynamic> json) =>
    BodyTokenAuthTokenPost(
      refreshToken: json['refresh_token'] as String? ?? '',
      grantType: json['grant_type'] as String? ?? '',
      code: json['code'] as String? ?? '',
      redirectUri: json['redirect_uri'] as String? ?? '',
      clientId: json['client_id'] as String? ?? '',
      clientSecret: json['client_secret'] as String? ?? '',
      codeVerifier: json['code_verifier'] as String? ?? '',
    );

Map<String, dynamic> _$BodyTokenAuthTokenPostToJson(
        BodyTokenAuthTokenPost instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
      'grant_type': instance.grantType,
      'code': instance.code,
      'redirect_uri': instance.redirectUri,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'code_verifier': instance.codeVerifier,
    };

BookingBase _$BookingBaseFromJson(Map<String, dynamic> json) => BookingBase(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      note: json['note'] as String? ?? '',
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
      entity: json['entity'] as String? ?? '',
    );

Map<String, dynamic> _$BookingBaseToJson(BookingBase instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrence_rule': instance.recurrenceRule,
      'entity': instance.entity,
    };

BookingEdit _$BookingEditFromJson(Map<String, dynamic> json) => BookingEdit(
      reason: json['reason'] as String? ?? '',
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      note: json['note'] as String? ?? '',
      room: json['room'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
      entity: json['entity'] as String? ?? '',
    );

Map<String, dynamic> _$BookingEditToJson(BookingEdit instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'note': instance.note,
      'room': instance.room,
      'key': instance.key,
      'recurrence_rule': instance.recurrenceRule,
      'entity': instance.entity,
    };

BookingReturn _$BookingReturnFromJson(Map<String, dynamic> json) =>
    BookingReturn(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      note: json['note'] as String? ?? '',
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
      entity: json['entity'] as String? ?? '',
      id: json['id'] as String? ?? '',
      decision: appUtilsTypesBookingTypeDecisionFromJson(json['decision']),
      applicantId: json['applicant_id'] as String? ?? '',
      room: RoomComplete.fromJson(json['room'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingReturnToJson(BookingReturn instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrence_rule': instance.recurrenceRule,
      'entity': instance.entity,
      'id': instance.id,
      'decision': appUtilsTypesBookingTypeDecisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
      'room': instance.room.toJson(),
    };

BookingReturnApplicant _$BookingReturnApplicantFromJson(
        Map<String, dynamic> json) =>
    BookingReturnApplicant(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      note: json['note'] as String? ?? '',
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
      entity: json['entity'] as String? ?? '',
      id: json['id'] as String? ?? '',
      decision: appUtilsTypesBookingTypeDecisionFromJson(json['decision']),
      applicantId: json['applicant_id'] as String? ?? '',
      room: RoomComplete.fromJson(json['room'] as Map<String, dynamic>),
      applicant: Applicant.fromJson(json['applicant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingReturnApplicantToJson(
        BookingReturnApplicant instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrence_rule': instance.recurrenceRule,
      'entity': instance.entity,
      'id': instance.id,
      'decision': appUtilsTypesBookingTypeDecisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
      'room': instance.room.toJson(),
      'applicant': instance.applicant.toJson(),
    };

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      email: json['email'] as String? ?? '',
      oldPassword: json['old_password'] as String? ?? '',
      newPassword: json['new_password'] as String? ?? '',
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'old_password': instance.oldPassword,
      'new_password': instance.newPassword,
    };

CineSessionBase _$CineSessionBaseFromJson(Map<String, dynamic> json) =>
    CineSessionBase(
      start: DateTime.parse(json['start'] as String),
      duration: json['duration'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
    );

Map<String, dynamic> _$CineSessionBaseToJson(CineSessionBase instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'duration': instance.duration,
      'name': instance.name,
      'overview': instance.overview,
      'genre': instance.genre,
      'tagline': instance.tagline,
    };

CineSessionComplete _$CineSessionCompleteFromJson(Map<String, dynamic> json) =>
    CineSessionComplete(
      start: DateTime.parse(json['start'] as String),
      duration: json['duration'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CineSessionCompleteToJson(
        CineSessionComplete instance) =>
    <String, dynamic>{
      'start': instance.start.toIso8601String(),
      'duration': instance.duration,
      'name': instance.name,
      'overview': instance.overview,
      'genre': instance.genre,
      'tagline': instance.tagline,
      'id': instance.id,
    };

CineSessionUpdate _$CineSessionUpdateFromJson(Map<String, dynamic> json) =>
    CineSessionUpdate(
      name: json['name'] as String? ?? '',
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      duration: json['duration'] as int? ?? 0,
      overview: json['overview'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
    );

Map<String, dynamic> _$CineSessionUpdateToJson(CineSessionUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'start': instance.start?.toIso8601String(),
      'duration': instance.duration,
      'overview': instance.overview,
      'genre': instance.genre,
      'tagline': instance.tagline,
    };

CoreBatchDeleteMembership _$CoreBatchDeleteMembershipFromJson(
        Map<String, dynamic> json) =>
    CoreBatchDeleteMembership(
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$CoreBatchDeleteMembershipToJson(
        CoreBatchDeleteMembership instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
    };

CoreBatchMembership _$CoreBatchMembershipFromJson(Map<String, dynamic> json) =>
    CoreBatchMembership(
      userEmails: (json['user_emails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      groupId: json['group_id'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$CoreBatchMembershipToJson(
        CoreBatchMembership instance) =>
    <String, dynamic>{
      'user_emails': instance.userEmails,
      'group_id': instance.groupId,
      'description': instance.description,
    };

CoreBatchUserCreateRequest _$CoreBatchUserCreateRequestFromJson(
        Map<String, dynamic> json) =>
    CoreBatchUserCreateRequest(
      email: json['email'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
    );

Map<String, dynamic> _$CoreBatchUserCreateRequestToJson(
        CoreBatchUserCreateRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'account_type': accountTypeToJson(instance.accountType),
    };

CoreGroup _$CoreGroupFromJson(Map<String, dynamic> json) => CoreGroup(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      id: json['id'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => CoreUserSimple.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CoreGroupToJson(CoreGroup instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'id': instance.id,
      'members': instance.members?.map((e) => e.toJson()).toList(),
    };

CoreGroupCreate _$CoreGroupCreateFromJson(Map<String, dynamic> json) =>
    CoreGroupCreate(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$CoreGroupCreateToJson(CoreGroupCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

CoreGroupSimple _$CoreGroupSimpleFromJson(Map<String, dynamic> json) =>
    CoreGroupSimple(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CoreGroupSimpleToJson(CoreGroupSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'id': instance.id,
    };

CoreGroupUpdate _$CoreGroupUpdateFromJson(Map<String, dynamic> json) =>
    CoreGroupUpdate(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$CoreGroupUpdateToJson(CoreGroupUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

CoreInformation _$CoreInformationFromJson(Map<String, dynamic> json) =>
    CoreInformation(
      ready: json['ready'] as bool? ?? false,
      version: json['version'] as String? ?? '',
      minimalTitanVersionCode: json['minimal_titan_version_code'] as int? ?? 0,
      minimalTitanVersion: json['minimal_titan_version'] as String? ?? '',
    );

Map<String, dynamic> _$CoreInformationToJson(CoreInformation instance) =>
    <String, dynamic>{
      'ready': instance.ready,
      'version': instance.version,
      'minimal_titan_version_code': instance.minimalTitanVersionCode,
      'minimal_titan_version': instance.minimalTitanVersion,
    };

CoreMembership _$CoreMembershipFromJson(Map<String, dynamic> json) =>
    CoreMembership(
      userId: json['user_id'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$CoreMembershipToJson(CoreMembership instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'group_id': instance.groupId,
      'description': instance.description,
    };

CoreMembershipDelete _$CoreMembershipDeleteFromJson(
        Map<String, dynamic> json) =>
    CoreMembershipDelete(
      userId: json['user_id'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$CoreMembershipDeleteToJson(
        CoreMembershipDelete instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'group_id': instance.groupId,
    };

CoreUser _$CoreUserFromJson(Map<String, dynamic> json) => CoreUser(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      promo: json['promo'] as int? ?? 0,
      floor: floorsTypeFromJson(json['floor']),
      phone: json['phone'] as String? ?? '',
      createdOn: json['created_on'] == null
          ? null
          : DateTime.parse(json['created_on'] as String),
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => CoreGroupSimple.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CoreUserToJson(CoreUser instance) => <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'email': instance.email,
      'birthday': _dateToJson(instance.birthday),
      'promo': instance.promo,
      'floor': floorsTypeToJson(instance.floor),
      'phone': instance.phone,
      'created_on': instance.createdOn?.toIso8601String(),
      'groups': instance.groups?.map((e) => e.toJson()).toList(),
    };

CoreUserActivateRequest _$CoreUserActivateRequestFromJson(
        Map<String, dynamic> json) =>
    CoreUserActivateRequest(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      activationToken: json['activation_token'] as String? ?? '',
      password: json['password'] as String? ?? '',
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String? ?? '',
      floor: floorsTypeFromJson(json['floor']),
      promo: json['promo'] as int? ?? 0,
    );

Map<String, dynamic> _$CoreUserActivateRequestToJson(
        CoreUserActivateRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'activation_token': instance.activationToken,
      'password': instance.password,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'floor': floorsTypeToJson(instance.floor),
      'promo': instance.promo,
    };

CoreUserCreateRequest _$CoreUserCreateRequestFromJson(
        Map<String, dynamic> json) =>
    CoreUserCreateRequest(
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$CoreUserCreateRequestToJson(
        CoreUserCreateRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

CoreUserSimple _$CoreUserSimpleFromJson(Map<String, dynamic> json) =>
    CoreUserSimple(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CoreUserSimpleToJson(CoreUserSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
    };

CoreUserUpdate _$CoreUserUpdateFromJson(Map<String, dynamic> json) =>
    CoreUserUpdate(
      nickname: json['nickname'] as String? ?? '',
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String? ?? '',
      floor: floorsTypeNullableFromJson(json['floor']),
    );

Map<String, dynamic> _$CoreUserUpdateToJson(CoreUserUpdate instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'floor': floorsTypeNullableToJson(instance.floor),
    };

CoreUserUpdateAdmin _$CoreUserUpdateAdminFromJson(Map<String, dynamic> json) =>
    CoreUserUpdateAdmin(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      promo: json['promo'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String? ?? '',
      floor: floorsTypeNullableFromJson(json['floor']),
    );

Map<String, dynamic> _$CoreUserUpdateAdminToJson(
        CoreUserUpdateAdmin instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'promo': instance.promo,
      'nickname': instance.nickname,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'floor': floorsTypeNullableToJson(instance.floor),
    };

DeliveryBase _$DeliveryBaseFromJson(Map<String, dynamic> json) => DeliveryBase(
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
      productsIds: (json['products_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$DeliveryBaseToJson(DeliveryBase instance) =>
    <String, dynamic>{
      'delivery_date': _dateToJson(instance.deliveryDate),
      'products_ids': instance.productsIds,
    };

DeliveryProductsUpdate _$DeliveryProductsUpdateFromJson(
        Map<String, dynamic> json) =>
    DeliveryProductsUpdate(
      productsIds: (json['products_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$DeliveryProductsUpdateToJson(
        DeliveryProductsUpdate instance) =>
    <String, dynamic>{
      'products_ids': instance.productsIds,
    };

DeliveryReturn _$DeliveryReturnFromJson(Map<String, dynamic> json) =>
    DeliveryReturn(
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['id'] as String? ?? '',
      status: deliveryStatusTypeFromJson(json['status']),
    );

Map<String, dynamic> _$DeliveryReturnToJson(DeliveryReturn instance) =>
    <String, dynamic>{
      'delivery_date': _dateToJson(instance.deliveryDate),
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'status': deliveryStatusTypeToJson(instance.status),
    };

DeliveryUpdate _$DeliveryUpdateFromJson(Map<String, dynamic> json) =>
    DeliveryUpdate(
      deliveryDate: json['delivery_date'] == null
          ? null
          : DateTime.parse(json['delivery_date'] as String),
    );

Map<String, dynamic> _$DeliveryUpdateToJson(DeliveryUpdate instance) =>
    <String, dynamic>{
      'delivery_date': _dateToJson(instance.deliveryDate),
    };

DetailedPlayer _$DetailedPlayerFromJson(Map<String, dynamic> json) =>
    DetailedPlayer(
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
      info: json['info'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$DetailedPlayerToJson(DetailedPlayer instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'info': instance.info,
    };

EventApplicant _$EventApplicantFromJson(Map<String, dynamic> json) =>
    EventApplicant(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      promo: json['promo'] as int? ?? 0,
      phone: json['phone'] as String? ?? '',
    );

Map<String, dynamic> _$EventApplicantToJson(EventApplicant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'email': instance.email,
      'promo': instance.promo,
      'phone': instance.phone,
    };

EventBase _$EventBaseFromJson(Map<String, dynamic> json) => EventBase(
      name: json['name'] as String? ?? '',
      organizer: json['organizer'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      allDay: json['all_day'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      type: calendarEventTypeFromJson(json['type']),
      description: json['description'] as String? ?? '',
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
    );

Map<String, dynamic> _$EventBaseToJson(EventBase instance) => <String, dynamic>{
      'name': instance.name,
      'organizer': instance.organizer,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'all_day': instance.allDay,
      'location': instance.location,
      'type': calendarEventTypeToJson(instance.type),
      'description': instance.description,
      'recurrence_rule': instance.recurrenceRule,
    };

EventComplete _$EventCompleteFromJson(Map<String, dynamic> json) =>
    EventComplete(
      name: json['name'] as String? ?? '',
      organizer: json['organizer'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      allDay: json['all_day'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      type: calendarEventTypeFromJson(json['type']),
      description: json['description'] as String? ?? '',
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
      id: json['id'] as String? ?? '',
      decision: appUtilsTypesCalendarTypesDecisionFromJson(json['decision']),
      applicantId: json['applicant_id'] as String? ?? '',
    );

Map<String, dynamic> _$EventCompleteToJson(EventComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'organizer': instance.organizer,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'all_day': instance.allDay,
      'location': instance.location,
      'type': calendarEventTypeToJson(instance.type),
      'description': instance.description,
      'recurrence_rule': instance.recurrenceRule,
      'id': instance.id,
      'decision': appUtilsTypesCalendarTypesDecisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
    };

EventEdit _$EventEditFromJson(Map<String, dynamic> json) => EventEdit(
      name: json['name'] as String? ?? '',
      organizer: json['organizer'] as String? ?? '',
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      allDay: json['all_day'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      type: calendarEventTypeNullableFromJson(json['type']),
      description: json['description'] as String? ?? '',
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
    );

Map<String, dynamic> _$EventEditToJson(EventEdit instance) => <String, dynamic>{
      'name': instance.name,
      'organizer': instance.organizer,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'all_day': instance.allDay,
      'location': instance.location,
      'type': calendarEventTypeNullableToJson(instance.type),
      'description': instance.description,
      'recurrence_rule': instance.recurrenceRule,
    };

EventReturn _$EventReturnFromJson(Map<String, dynamic> json) => EventReturn(
      name: json['name'] as String? ?? '',
      organizer: json['organizer'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      allDay: json['all_day'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      type: calendarEventTypeFromJson(json['type']),
      description: json['description'] as String? ?? '',
      recurrenceRule: json['recurrence_rule'] as String? ?? '',
      id: json['id'] as String? ?? '',
      decision: appUtilsTypesCalendarTypesDecisionFromJson(json['decision']),
      applicantId: json['applicant_id'] as String? ?? '',
      applicant:
          EventApplicant.fromJson(json['applicant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventReturnToJson(EventReturn instance) =>
    <String, dynamic>{
      'name': instance.name,
      'organizer': instance.organizer,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'all_day': instance.allDay,
      'location': instance.location,
      'type': calendarEventTypeToJson(instance.type),
      'description': instance.description,
      'recurrence_rule': instance.recurrenceRule,
      'id': instance.id,
      'decision': appUtilsTypesCalendarTypesDecisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
      'applicant': instance.applicant.toJson(),
    };

FirebaseDevice _$FirebaseDeviceFromJson(Map<String, dynamic> json) =>
    FirebaseDevice(
      userId: json['user_id'] as String? ?? '',
      firebaseDeviceToken: json['firebase_device_token'] as String? ?? '',
    );

Map<String, dynamic> _$FirebaseDeviceToJson(FirebaseDevice instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'firebase_device_token': instance.firebaseDeviceToken,
    };

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      mode: capsModeFromJson(json['mode']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      id: json['id'] as String? ?? '',
      gamePlayers: (json['game_players'] as List<dynamic>?)
              ?.map((e) => GamePlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isConfirmed: json['is_confirmed'] as bool? ?? false,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'mode': capsModeToJson(instance.mode),
      'timestamp': instance.timestamp.toIso8601String(),
      'id': instance.id,
      'game_players': instance.gamePlayers.map((e) => e.toJson()).toList(),
      'is_confirmed': instance.isConfirmed,
    };

GameCreateRequest _$GameCreateRequestFromJson(Map<String, dynamic> json) =>
    GameCreateRequest(
      mode: capsModeFromJson(json['mode']),
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => GamePlayerBase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GameCreateRequestToJson(GameCreateRequest instance) =>
    <String, dynamic>{
      'mode': capsModeToJson(instance.mode),
      'players': instance.players.map((e) => e.toJson()).toList(),
    };

GameMode _$GameModeFromJson(Map<String, dynamic> json) => GameMode(
      mode: capsModeFromJson(json['mode']),
    );

Map<String, dynamic> _$GameModeToJson(GameMode instance) => <String, dynamic>{
      'mode': capsModeToJson(instance.mode),
    };

GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) => GamePlayer(
      userId: json['user_id'] as String? ?? '',
      team: json['team'] as int? ?? 0,
      score: json['score'] as int? ?? 0,
      eloGain: json['elo_gain'] as int? ?? 0,
      hasConfirmed: json['has_confirmed'] as bool? ?? false,
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GamePlayerToJson(GamePlayer instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'team': instance.team,
      'score': instance.score,
      'elo_gain': instance.eloGain,
      'has_confirmed': instance.hasConfirmed,
      'user': instance.user.toJson(),
    };

GamePlayerBase _$GamePlayerBaseFromJson(Map<String, dynamic> json) =>
    GamePlayerBase(
      userId: json['user_id'] as String? ?? '',
      team: json['team'] as int? ?? 0,
      score: json['score'] as int? ?? 0,
    );

Map<String, dynamic> _$GamePlayerBaseToJson(GamePlayerBase instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'team': instance.team,
      'score': instance.score,
    };

HTTPValidationError _$HTTPValidationErrorFromJson(Map<String, dynamic> json) =>
    HTTPValidationError(
      detail: (json['detail'] as List<dynamic>?)
              ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$HTTPValidationErrorToJson(
        HTTPValidationError instance) =>
    <String, dynamic>{
      'detail': instance.detail?.map((e) => e.toJson()).toList(),
    };

Information _$InformationFromJson(Map<String, dynamic> json) => Information(
      manager: json['manager'] as String? ?? '',
      link: json['link'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$InformationToJson(Information instance) =>
    <String, dynamic>{
      'manager': instance.manager,
      'link': instance.link,
      'description': instance.description,
    };

InformationEdit _$InformationEditFromJson(Map<String, dynamic> json) =>
    InformationEdit(
      manager: json['manager'] as String? ?? '',
      link: json['link'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$InformationEditToJson(InformationEdit instance) =>
    <String, dynamic>{
      'manager': instance.manager,
      'link': instance.link,
      'description': instance.description,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String? ?? '',
      suggestedCaution: json['suggested_caution'] as int? ?? 0,
      totalQuantity: json['total_quantity'] as int? ?? 0,
      suggestedLendingDuration:
          (json['suggested_lending_duration'] as num?)?.toDouble() ?? 0.0,
      id: json['id'] as String? ?? '',
      loanerId: json['loaner_id'] as String? ?? '',
      loanedQuantity: json['loaned_quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'suggested_caution': instance.suggestedCaution,
      'total_quantity': instance.totalQuantity,
      'suggested_lending_duration': instance.suggestedLendingDuration,
      'id': instance.id,
      'loaner_id': instance.loanerId,
      'loaned_quantity': instance.loanedQuantity,
    };

ItemBase _$ItemBaseFromJson(Map<String, dynamic> json) => ItemBase(
      name: json['name'] as String? ?? '',
      suggestedCaution: json['suggested_caution'] as int? ?? 0,
      totalQuantity: json['total_quantity'] as int? ?? 0,
      suggestedLendingDuration:
          (json['suggested_lending_duration'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ItemBaseToJson(ItemBase instance) => <String, dynamic>{
      'name': instance.name,
      'suggested_caution': instance.suggestedCaution,
      'total_quantity': instance.totalQuantity,
      'suggested_lending_duration': instance.suggestedLendingDuration,
    };

ItemBorrowed _$ItemBorrowedFromJson(Map<String, dynamic> json) => ItemBorrowed(
      itemId: json['item_id'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$ItemBorrowedToJson(ItemBorrowed instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'quantity': instance.quantity,
    };

ItemQuantity _$ItemQuantityFromJson(Map<String, dynamic> json) => ItemQuantity(
      quantity: json['quantity'] as int? ?? 0,
      itemSimple:
          ItemSimple.fromJson(json['itemSimple'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemQuantityToJson(ItemQuantity instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'itemSimple': instance.itemSimple.toJson(),
    };

ItemSimple _$ItemSimpleFromJson(Map<String, dynamic> json) => ItemSimple(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      loanerId: json['loaner_id'] as String? ?? '',
    );

Map<String, dynamic> _$ItemSimpleToJson(ItemSimple instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'loaner_id': instance.loanerId,
    };

ItemUpdate _$ItemUpdateFromJson(Map<String, dynamic> json) => ItemUpdate(
      name: json['name'] as String? ?? '',
      suggestedCaution: json['suggested_caution'] as int? ?? 0,
      totalQuantity: json['total_quantity'] as int? ?? 0,
      suggestedLendingDuration:
          (json['suggested_lending_duration'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ItemUpdateToJson(ItemUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'suggested_caution': instance.suggestedCaution,
      'total_quantity': instance.totalQuantity,
      'suggested_lending_duration': instance.suggestedLendingDuration,
    };

ListBase _$ListBaseFromJson(Map<String, dynamic> json) => ListBase(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: listTypeFromJson(json['type']),
      sectionId: json['section_id'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => ListMemberBase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      program: json['program'] as String? ?? '',
    );

Map<String, dynamic> _$ListBaseToJson(ListBase instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': listTypeToJson(instance.type),
      'section_id': instance.sectionId,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'program': instance.program,
    };

ListEdit _$ListEditFromJson(Map<String, dynamic> json) => ListEdit(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: listTypeNullableFromJson(json['type']),
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => ListMemberBase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      program: json['program'] as String? ?? '',
    );

Map<String, dynamic> _$ListEditToJson(ListEdit instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': listTypeNullableToJson(instance.type),
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'program': instance.program,
    };

ListMemberBase _$ListMemberBaseFromJson(Map<String, dynamic> json) =>
    ListMemberBase(
      userId: json['user_id'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );

Map<String, dynamic> _$ListMemberBaseToJson(ListMemberBase instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'role': instance.role,
    };

ListMemberComplete _$ListMemberCompleteFromJson(Map<String, dynamic> json) =>
    ListMemberComplete(
      userId: json['user_id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListMemberCompleteToJson(ListMemberComplete instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'role': instance.role,
      'user': instance.user.toJson(),
    };

ListReturn _$ListReturnFromJson(Map<String, dynamic> json) => ListReturn(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: listTypeFromJson(json['type']),
      section:
          SectionComplete.fromJson(json['section'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>?)
              ?.map(
                  (e) => ListMemberComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      program: json['program'] as String? ?? '',
    );

Map<String, dynamic> _$ListReturnToJson(ListReturn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': listTypeToJson(instance.type),
      'section': instance.section.toJson(),
      'members': instance.members.map((e) => e.toJson()).toList(),
      'program': instance.program,
    };

Loan _$LoanFromJson(Map<String, dynamic> json) => Loan(
      borrowerId: json['borrower_id'] as String? ?? '',
      loanerId: json['loaner_id'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      notes: json['notes'] as String? ?? '',
      caution: json['caution'] as String? ?? '',
      id: json['id'] as String? ?? '',
      returned: json['returned'] as bool? ?? false,
      itemsQty: (json['items_qty'] as List<dynamic>?)
              ?.map((e) => ItemQuantity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      borrower:
          CoreUserSimple.fromJson(json['borrower'] as Map<String, dynamic>),
      loaner: Loaner.fromJson(json['loaner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoanToJson(Loan instance) => <String, dynamic>{
      'borrower_id': instance.borrowerId,
      'loaner_id': instance.loanerId,
      'start': _dateToJson(instance.start),
      'end': _dateToJson(instance.end),
      'notes': instance.notes,
      'caution': instance.caution,
      'id': instance.id,
      'returned': instance.returned,
      'items_qty': instance.itemsQty.map((e) => e.toJson()).toList(),
      'borrower': instance.borrower.toJson(),
      'loaner': instance.loaner.toJson(),
    };

LoanCreation _$LoanCreationFromJson(Map<String, dynamic> json) => LoanCreation(
      borrowerId: json['borrower_id'] as String? ?? '',
      loanerId: json['loaner_id'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      notes: json['notes'] as String? ?? '',
      caution: json['caution'] as String? ?? '',
      itemsBorrowed: (json['items_borrowed'] as List<dynamic>?)
              ?.map((e) => ItemBorrowed.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LoanCreationToJson(LoanCreation instance) =>
    <String, dynamic>{
      'borrower_id': instance.borrowerId,
      'loaner_id': instance.loanerId,
      'start': _dateToJson(instance.start),
      'end': _dateToJson(instance.end),
      'notes': instance.notes,
      'caution': instance.caution,
      'items_borrowed': instance.itemsBorrowed.map((e) => e.toJson()).toList(),
    };

LoanExtend _$LoanExtendFromJson(Map<String, dynamic> json) => LoanExtend(
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LoanExtendToJson(LoanExtend instance) =>
    <String, dynamic>{
      'end': _dateToJson(instance.end),
      'duration': instance.duration,
    };

LoanUpdate _$LoanUpdateFromJson(Map<String, dynamic> json) => LoanUpdate(
      borrowerId: json['borrower_id'] as String? ?? '',
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      notes: json['notes'] as String? ?? '',
      caution: json['caution'] as String? ?? '',
      returned: json['returned'] as bool? ?? false,
      itemsBorrowed: (json['items_borrowed'] as List<dynamic>?)
              ?.map((e) => ItemBorrowed.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LoanUpdateToJson(LoanUpdate instance) =>
    <String, dynamic>{
      'borrower_id': instance.borrowerId,
      'start': _dateToJson(instance.start),
      'end': _dateToJson(instance.end),
      'notes': instance.notes,
      'caution': instance.caution,
      'returned': instance.returned,
      'items_borrowed': instance.itemsBorrowed?.map((e) => e.toJson()).toList(),
    };

Loaner _$LoanerFromJson(Map<String, dynamic> json) => Loaner(
      name: json['name'] as String? ?? '',
      groupManagerId: json['group_manager_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$LoanerToJson(Loaner instance) => <String, dynamic>{
      'name': instance.name,
      'group_manager_id': instance.groupManagerId,
      'id': instance.id,
    };

LoanerBase _$LoanerBaseFromJson(Map<String, dynamic> json) => LoanerBase(
      name: json['name'] as String? ?? '',
      groupManagerId: json['group_manager_id'] as String? ?? '',
    );

Map<String, dynamic> _$LoanerBaseToJson(LoanerBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_manager_id': instance.groupManagerId,
    };

LoanerUpdate _$LoanerUpdateFromJson(Map<String, dynamic> json) => LoanerUpdate(
      name: json['name'] as String? ?? '',
      groupManagerId: json['group_manager_id'] as String? ?? '',
    );

Map<String, dynamic> _$LoanerUpdateToJson(LoanerUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_manager_id': instance.groupManagerId,
    };

MailMigrationRequest _$MailMigrationRequestFromJson(
        Map<String, dynamic> json) =>
    MailMigrationRequest(
      newEmail: json['new_email'] as String? ?? '',
    );

Map<String, dynamic> _$MailMigrationRequestToJson(
        MailMigrationRequest instance) =>
    <String, dynamic>{
      'new_email': instance.newEmail,
    };

Manager _$ManagerFromJson(Map<String, dynamic> json) => Manager(
      name: json['name'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$ManagerToJson(Manager instance) => <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
      'id': instance.id,
    };

ManagerBase _$ManagerBaseFromJson(Map<String, dynamic> json) => ManagerBase(
      name: json['name'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$ManagerBaseToJson(ManagerBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
    };

ManagerUpdate _$ManagerUpdateFromJson(Map<String, dynamic> json) =>
    ManagerUpdate(
      name: json['name'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$ManagerUpdateToJson(ManagerUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      context: json['context'] as String? ?? '',
      isVisible: json['is_visible'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      actionModule: json['action_module'] as String? ?? '',
      actionTable: json['action_table'] as String? ?? '',
      deliveryDatetime: json['delivery_datetime'] == null
          ? null
          : DateTime.parse(json['delivery_datetime'] as String),
      expireOn: DateTime.parse(json['expire_on'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'context': instance.context,
      'is_visible': instance.isVisible,
      'title': instance.title,
      'content': instance.content,
      'action_module': instance.actionModule,
      'action_table': instance.actionTable,
      'delivery_datetime': instance.deliveryDatetime?.toIso8601String(),
      'expire_on': _dateToJson(instance.expireOn),
    };

ModuleVisibility _$ModuleVisibilityFromJson(Map<String, dynamic> json) =>
    ModuleVisibility(
      root: json['root'] as String? ?? '',
      allowedGroupIds: (json['allowed_group_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ModuleVisibilityToJson(ModuleVisibility instance) =>
    <String, dynamic>{
      'root': instance.root,
      'allowed_group_ids': instance.allowedGroupIds,
    };

ModuleVisibilityCreate _$ModuleVisibilityCreateFromJson(
        Map<String, dynamic> json) =>
    ModuleVisibilityCreate(
      root: json['root'] as String? ?? '',
      allowedGroupId: json['allowed_group_id'] as String? ?? '',
    );

Map<String, dynamic> _$ModuleVisibilityCreateToJson(
        ModuleVisibilityCreate instance) =>
    <String, dynamic>{
      'root': instance.root,
      'allowed_group_id': instance.allowedGroupId,
    };

OrderBase _$OrderBaseFromJson(Map<String, dynamic> json) => OrderBase(
      userId: json['user_id'] as String? ?? '',
      deliveryId: json['delivery_id'] as String? ?? '',
      productsIds: (json['products_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      collectionSlot: amapSlotTypeFromJson(json['collection_slot']),
      productsQuantity: (json['products_quantity'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderBaseToJson(OrderBase instance) => <String, dynamic>{
      'user_id': instance.userId,
      'delivery_id': instance.deliveryId,
      'products_ids': instance.productsIds,
      'collection_slot': amapSlotTypeToJson(instance.collectionSlot),
      'products_quantity': instance.productsQuantity,
    };

OrderEdit _$OrderEditFromJson(Map<String, dynamic> json) => OrderEdit(
      productsIds: (json['products_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      collectionSlot: amapSlotTypeNullableFromJson(json['collection_slot']),
      productsQuantity: (json['products_quantity'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderEditToJson(OrderEdit instance) => <String, dynamic>{
      'products_ids': instance.productsIds,
      'collection_slot': amapSlotTypeNullableToJson(instance.collectionSlot),
      'products_quantity': instance.productsQuantity,
    };

OrderReturn _$OrderReturnFromJson(Map<String, dynamic> json) => OrderReturn(
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
      deliveryId: json['delivery_id'] as String? ?? '',
      productsdetail: (json['productsdetail'] as List<dynamic>?)
              ?.map((e) => ProductQuantity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      collectionSlot: amapSlotTypeFromJson(json['collection_slot']),
      orderId: json['order_id'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      orderingDate: DateTime.parse(json['ordering_date'] as String),
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
    );

Map<String, dynamic> _$OrderReturnToJson(OrderReturn instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'delivery_id': instance.deliveryId,
      'productsdetail': instance.productsdetail.map((e) => e.toJson()).toList(),
      'collection_slot': amapSlotTypeToJson(instance.collectionSlot),
      'order_id': instance.orderId,
      'amount': instance.amount,
      'ordering_date': instance.orderingDate.toIso8601String(),
      'delivery_date': _dateToJson(instance.deliveryDate),
    };

PackTicketBase _$PackTicketBaseFromJson(Map<String, dynamic> json) =>
    PackTicketBase(
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      packSize: json['pack_size'] as int? ?? 0,
      raffleId: json['raffle_id'] as String? ?? '',
    );

Map<String, dynamic> _$PackTicketBaseToJson(PackTicketBase instance) =>
    <String, dynamic>{
      'price': instance.price,
      'pack_size': instance.packSize,
      'raffle_id': instance.raffleId,
    };

PackTicketEdit _$PackTicketEditFromJson(Map<String, dynamic> json) =>
    PackTicketEdit(
      raffleId: json['raffle_id'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      packSize: json['pack_size'] as int? ?? 0,
    );

Map<String, dynamic> _$PackTicketEditToJson(PackTicketEdit instance) =>
    <String, dynamic>{
      'raffle_id': instance.raffleId,
      'price': instance.price,
      'pack_size': instance.packSize,
    };

PackTicketSimple _$PackTicketSimpleFromJson(Map<String, dynamic> json) =>
    PackTicketSimple(
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      packSize: json['pack_size'] as int? ?? 0,
      raffleId: json['raffle_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$PackTicketSimpleToJson(PackTicketSimple instance) =>
    <String, dynamic>{
      'price': instance.price,
      'pack_size': instance.packSize,
      'raffle_id': instance.raffleId,
      'id': instance.id,
    };

PlayerBase _$PlayerBaseFromJson(Map<String, dynamic> json) => PlayerBase(
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
      elo: json['elo'] as int? ?? 0,
      mode: capsModeFromJson(json['mode']),
    );

Map<String, dynamic> _$PlayerBaseToJson(PlayerBase instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'elo': instance.elo,
      'mode': capsModeToJson(instance.mode),
    };

PlayerModeInfo _$PlayerModeInfoFromJson(Map<String, dynamic> json) =>
    PlayerModeInfo(
      elo: json['elo'] as int? ?? 0,
      winrate: (json['winrate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$PlayerModeInfoToJson(PlayerModeInfo instance) =>
    <String, dynamic>{
      'elo': instance.elo,
      'winrate': instance.winrate,
    };

PrizeBase _$PrizeBaseFromJson(Map<String, dynamic> json) => PrizeBase(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      raffleId: json['raffle_id'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$PrizeBaseToJson(PrizeBase instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'raffle_id': instance.raffleId,
      'quantity': instance.quantity,
    };

PrizeEdit _$PrizeEditFromJson(Map<String, dynamic> json) => PrizeEdit(
      raffleId: json['raffle_id'] as String? ?? '',
      description: json['description'] as String? ?? '',
      name: json['name'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$PrizeEditToJson(PrizeEdit instance) => <String, dynamic>{
      'raffle_id': instance.raffleId,
      'description': instance.description,
      'name': instance.name,
      'quantity': instance.quantity,
    };

PrizeSimple _$PrizeSimpleFromJson(Map<String, dynamic> json) => PrizeSimple(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      raffleId: json['raffle_id'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$PrizeSimpleToJson(PrizeSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'raffle_id': instance.raffleId,
      'quantity': instance.quantity,
      'id': instance.id,
    };

ProductComplete _$ProductCompleteFromJson(Map<String, dynamic> json) =>
    ProductComplete(
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$ProductCompleteToJson(ProductComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'id': instance.id,
    };

ProductEdit _$ProductEditFromJson(Map<String, dynamic> json) => ProductEdit(
      category: json['category'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ProductEditToJson(ProductEdit instance) =>
    <String, dynamic>{
      'category': instance.category,
      'name': instance.name,
      'price': instance.price,
    };

ProductQuantity _$ProductQuantityFromJson(Map<String, dynamic> json) =>
    ProductQuantity(
      quantity: json['quantity'] as int? ?? 0,
      product:
          ProductComplete.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductQuantityToJson(ProductQuantity instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product.toJson(),
    };

ProductSimple _$ProductSimpleFromJson(Map<String, dynamic> json) =>
    ProductSimple(
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$ProductSimpleToJson(ProductSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
    };

RaffleBase _$RaffleBaseFromJson(Map<String, dynamic> json) => RaffleBase(
      name: json['name'] as String? ?? '',
      status: raffleStatusTypeNullableFromJson(json['status']),
      description: json['description'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$RaffleBaseToJson(RaffleBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': raffleStatusTypeNullableToJson(instance.status),
      'description': instance.description,
      'group_id': instance.groupId,
    };

RaffleComplete _$RaffleCompleteFromJson(Map<String, dynamic> json) =>
    RaffleComplete(
      name: json['name'] as String? ?? '',
      status: raffleStatusTypeNullableFromJson(json['status']),
      description: json['description'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
      group: CoreGroupSimple.fromJson(json['group'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RaffleCompleteToJson(RaffleComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': raffleStatusTypeNullableToJson(instance.status),
      'description': instance.description,
      'group_id': instance.groupId,
      'id': instance.id,
      'group': instance.group.toJson(),
    };

RaffleEdit _$RaffleEditFromJson(Map<String, dynamic> json) => RaffleEdit(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$RaffleEditToJson(RaffleEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

RaffleSimple _$RaffleSimpleFromJson(Map<String, dynamic> json) => RaffleSimple(
      name: json['name'] as String? ?? '',
      status: raffleStatusTypeNullableFromJson(json['status']),
      description: json['description'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$RaffleSimpleToJson(RaffleSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': raffleStatusTypeNullableToJson(instance.status),
      'description': instance.description,
      'group_id': instance.groupId,
      'id': instance.id,
    };

RaffleStats _$RaffleStatsFromJson(Map<String, dynamic> json) => RaffleStats(
      ticketsSold: json['tickets_sold'] as int? ?? 0,
      amountRaised: (json['amount_raised'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$RaffleStatsToJson(RaffleStats instance) =>
    <String, dynamic>{
      'tickets_sold': instance.ticketsSold,
      'amount_raised': instance.amountRaised,
    };

ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequest(
      resetToken: json['reset_token'] as String? ?? '',
      newPassword: json['new_password'] as String? ?? '',
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'reset_token': instance.resetToken,
      'new_password': instance.newPassword,
    };

RoomBase _$RoomBaseFromJson(Map<String, dynamic> json) => RoomBase(
      name: json['name'] as String? ?? '',
      managerId: json['manager_id'] as String? ?? '',
    );

Map<String, dynamic> _$RoomBaseToJson(RoomBase instance) => <String, dynamic>{
      'name': instance.name,
      'manager_id': instance.managerId,
    };

RoomComplete _$RoomCompleteFromJson(Map<String, dynamic> json) => RoomComplete(
      name: json['name'] as String? ?? '',
      managerId: json['manager_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$RoomCompleteToJson(RoomComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'manager_id': instance.managerId,
      'id': instance.id,
    };

SectionBase _$SectionBaseFromJson(Map<String, dynamic> json) => SectionBase(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$SectionBaseToJson(SectionBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

SectionComplete _$SectionCompleteFromJson(Map<String, dynamic> json) =>
    SectionComplete(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$SectionCompleteToJson(SectionComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'id': instance.id,
    };

TicketComplete _$TicketCompleteFromJson(Map<String, dynamic> json) =>
    TicketComplete(
      packId: json['pack_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      winningPrize: json['winning_prize'] as String? ?? '',
      id: json['id'] as String? ?? '',
      prize: json['prize'] == null
          ? null
          : PrizeSimple.fromJson(json['prize'] as Map<String, dynamic>),
      packTicket: PackTicketSimple.fromJson(
          json['pack_ticket'] as Map<String, dynamic>),
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketCompleteToJson(TicketComplete instance) =>
    <String, dynamic>{
      'pack_id': instance.packId,
      'user_id': instance.userId,
      'winning_prize': instance.winningPrize,
      'id': instance.id,
      'prize': instance.prize?.toJson(),
      'pack_ticket': instance.packTicket.toJson(),
      'user': instance.user.toJson(),
    };

TicketSimple _$TicketSimpleFromJson(Map<String, dynamic> json) => TicketSimple(
      packId: json['pack_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      winningPrize: json['winning_prize'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$TicketSimpleToJson(TicketSimple instance) =>
    <String, dynamic>{
      'pack_id': instance.packId,
      'user_id': instance.userId,
      'winning_prize': instance.winningPrize,
      'id': instance.id,
    };

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      accessToken: json['access_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? '',
      expiresIn: json['expires_in'] as int? ?? 0,
      scopes: json['scopes'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      idToken: json['id_token'] as String? ?? '',
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'scopes': instance.scopes,
      'refresh_token': instance.refreshToken,
      'id_token': instance.idToken,
    };

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) =>
    ValidationError(
      loc: (json['loc'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
          [],
      msg: json['msg'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'loc': instance.loc,
      'msg': instance.msg,
      'type': instance.type,
    };

VoteBase _$VoteBaseFromJson(Map<String, dynamic> json) => VoteBase(
      listId: json['list_id'] as String? ?? '',
    );

Map<String, dynamic> _$VoteBaseToJson(VoteBase instance) => <String, dynamic>{
      'list_id': instance.listId,
    };

VoteStats _$VoteStatsFromJson(Map<String, dynamic> json) => VoteStats(
      sectionId: json['section_id'] as String? ?? '',
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$VoteStatsToJson(VoteStats instance) => <String, dynamic>{
      'section_id': instance.sectionId,
      'count': instance.count,
    };

VoteStatus _$VoteStatusFromJson(Map<String, dynamic> json) => VoteStatus(
      status: statusTypeFromJson(json['status']),
    );

Map<String, dynamic> _$VoteStatusToJson(VoteStatus instance) =>
    <String, dynamic>{
      'status': statusTypeToJson(instance.status),
    };

VoterGroup _$VoterGroupFromJson(Map<String, dynamic> json) => VoterGroup(
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$VoterGroupToJson(VoterGroup instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
    };

AppSchemasSchemasAmapCashComplete _$AppSchemasSchemasAmapCashCompleteFromJson(
        Map<String, dynamic> json) =>
    AppSchemasSchemasAmapCashComplete(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      userId: json['user_id'] as String? ?? '',
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppSchemasSchemasAmapCashCompleteToJson(
        AppSchemasSchemasAmapCashComplete instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'user_id': instance.userId,
      'user': instance.user.toJson(),
    };

AppSchemasSchemasAmapCashEdit _$AppSchemasSchemasAmapCashEditFromJson(
        Map<String, dynamic> json) =>
    AppSchemasSchemasAmapCashEdit(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$AppSchemasSchemasAmapCashEditToJson(
        AppSchemasSchemasAmapCashEdit instance) =>
    <String, dynamic>{
      'balance': instance.balance,
    };

AppSchemasSchemasCampaignResult _$AppSchemasSchemasCampaignResultFromJson(
        Map<String, dynamic> json) =>
    AppSchemasSchemasCampaignResult(
      listId: json['list_id'] as String? ?? '',
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$AppSchemasSchemasCampaignResultToJson(
        AppSchemasSchemasCampaignResult instance) =>
    <String, dynamic>{
      'list_id': instance.listId,
      'count': instance.count,
    };

AppSchemasSchemasRaffleCashComplete
    _$AppSchemasSchemasRaffleCashCompleteFromJson(Map<String, dynamic> json) =>
        AppSchemasSchemasRaffleCashComplete(
          balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
          userId: json['user_id'] as String? ?? '',
          user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AppSchemasSchemasRaffleCashCompleteToJson(
        AppSchemasSchemasRaffleCashComplete instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'user_id': instance.userId,
      'user': instance.user.toJson(),
    };

AppSchemasSchemasRaffleCashEdit _$AppSchemasSchemasRaffleCashEditFromJson(
        Map<String, dynamic> json) =>
    AppSchemasSchemasRaffleCashEdit(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$AppSchemasSchemasRaffleCashEditToJson(
        AppSchemasSchemasRaffleCashEdit instance) =>
    <String, dynamic>{
      'balance': instance.balance,
    };

AppUtilsTypesStandardResponsesResult
    _$AppUtilsTypesStandardResponsesResultFromJson(Map<String, dynamic> json) =>
        AppUtilsTypesStandardResponsesResult(
          success: json['success'] as bool? ?? true,
        );

Map<String, dynamic> _$AppUtilsTypesStandardResponsesResultToJson(
        AppUtilsTypesStandardResponsesResult instance) =>
    <String, dynamic>{
      'success': instance.success,
    };
