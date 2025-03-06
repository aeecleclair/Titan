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

AdminTransferInfo _$AdminTransferInfoFromJson(Map<String, dynamic> json) =>
    AdminTransferInfo(
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      transferType: transferTypeFromJson(json['transfer_type']),
      creditedUserId: json['creditedUserId'],
    );

Map<String, dynamic> _$AdminTransferInfoToJson(AdminTransferInfo instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'transfer_type': transferTypeToJson(instance.transferType),
      'creditedUserId': instance.creditedUserId,
    };

AdvertBase _$AdvertBaseFromJson(Map<String, dynamic> json) => AdvertBase(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      advertiserId: json['advertiser_id'] as String? ?? '',
      tags: json['tags'],
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
      tags: json['tags'],
      id: json['id'] as String? ?? '',
      advertiser: AdvertiserComplete.fromJson(
          json['advertiser'] as Map<String, dynamic>),
      date: json['date'],
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
      'date': instance.date,
    };

AdvertUpdate _$AdvertUpdateFromJson(Map<String, dynamic> json) => AdvertUpdate(
      title: json['title'],
      content: json['content'],
      tags: json['tags'],
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
      name: json['name'],
      groupManagerId: json['groupManagerId'],
    );

Map<String, dynamic> _$AdvertiserUpdateToJson(AdvertiserUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groupManagerId': instance.groupManagerId,
    };

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      promo: json['promo'],
      phone: json['phone'],
    );

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
      'email': instance.email,
      'promo': instance.promo,
      'phone': instance.phone,
    };

AssociationBase _$AssociationBaseFromJson(Map<String, dynamic> json) =>
    AssociationBase(
      name: json['name'] as String? ?? '',
      kind: kindsFromJson(json['kind']),
      mandateYear: (json['mandate_year'] as num?)?.toInt() ?? 0,
      description: json['description'],
      associatedGroups: (json['associated_groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      deactivated: json['deactivated'] as bool? ?? false,
    );

Map<String, dynamic> _$AssociationBaseToJson(AssociationBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': kindsToJson(instance.kind),
      'mandate_year': instance.mandateYear,
      'description': instance.description,
      'associated_groups': instance.associatedGroups,
      'deactivated': instance.deactivated,
    };

AssociationComplete _$AssociationCompleteFromJson(Map<String, dynamic> json) =>
    AssociationComplete(
      name: json['name'] as String? ?? '',
      kind: kindsFromJson(json['kind']),
      mandateYear: (json['mandate_year'] as num?)?.toInt() ?? 0,
      description: json['description'],
      associatedGroups: (json['associated_groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      deactivated: json['deactivated'] as bool? ?? false,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$AssociationCompleteToJson(
        AssociationComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': kindsToJson(instance.kind),
      'mandate_year': instance.mandateYear,
      'description': instance.description,
      'associated_groups': instance.associatedGroups,
      'deactivated': instance.deactivated,
      'id': instance.id,
    };

AssociationEdit _$AssociationEditFromJson(Map<String, dynamic> json) =>
    AssociationEdit(
      name: json['name'],
      kind: json['kind'],
      description: json['description'],
      mandateYear: json['mandateYear'],
    );

Map<String, dynamic> _$AssociationEditToJson(AssociationEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': instance.kind,
      'description': instance.description,
      'mandateYear': instance.mandateYear,
    };

AssociationGroupsEdit _$AssociationGroupsEditFromJson(
        Map<String, dynamic> json) =>
    AssociationGroupsEdit(
      associatedGroups: (json['associated_groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$AssociationGroupsEditToJson(
        AssociationGroupsEdit instance) =>
    <String, dynamic>{
      'associated_groups': instance.associatedGroups,
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
          redirectUri: json['redirectUri'],
          responseType: json['response_type'] as String? ?? '',
          scope: json['scope'],
          state: json['state'],
          nonce: json['nonce'],
          codeChallenge: json['codeChallenge'],
          codeChallengeMethod: json['codeChallengeMethod'],
          email: json['email'] as String? ?? '',
          password: json['password'] as String? ?? '',
        );

Map<String, dynamic>
    _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostToJson(
            BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost
                instance) =>
        <String, dynamic>{
          'client_id': instance.clientId,
          'redirectUri': instance.redirectUri,
          'response_type': instance.responseType,
          'scope': instance.scope,
          'state': instance.state,
          'nonce': instance.nonce,
          'codeChallenge': instance.codeChallenge,
          'codeChallengeMethod': instance.codeChallengeMethod,
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

BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost
    _$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostFromJson(
            Map<String, dynamic> json) =>
        BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost(
          image: json['image'] as String? ?? '',
        );

Map<String, dynamic>
    _$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostToJson(
            BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost
                instance) =>
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

BodyCreatePaperPdfAndCoverPhPaperIdPdfPost
    _$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostFromJson(
            Map<String, dynamic> json) =>
        BodyCreatePaperPdfAndCoverPhPaperIdPdfPost(
          pdf: json['pdf'] as String? ?? '',
        );

Map<String, dynamic> _$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostToJson(
        BodyCreatePaperPdfAndCoverPhPaperIdPdfPost instance) =>
    <String, dynamic>{
      'pdf': instance.pdf,
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

BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost
    _$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostFromJson(
            Map<String, dynamic> json) =>
        BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost(
          image: json['image'] as String? ?? '',
        );

Map<String, dynamic>
    _$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostToJson(
            BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost
                instance) =>
        <String, dynamic>{
          'image': instance.image,
        };

BodyIntrospectAuthIntrospectPost _$BodyIntrospectAuthIntrospectPostFromJson(
        Map<String, dynamic> json) =>
    BodyIntrospectAuthIntrospectPost(
      token: json['token'] as String? ?? '',
      tokenTypeHint: json['tokenTypeHint'],
      clientId: json['clientId'],
      clientSecret: json['clientSecret'],
    );

Map<String, dynamic> _$BodyIntrospectAuthIntrospectPostToJson(
        BodyIntrospectAuthIntrospectPost instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tokenTypeHint': instance.tokenTypeHint,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };

BodyLoginForAccessTokenAuthSimpleTokenPost
    _$BodyLoginForAccessTokenAuthSimpleTokenPostFromJson(
            Map<String, dynamic> json) =>
        BodyLoginForAccessTokenAuthSimpleTokenPost(
          grantType: json['grantType'],
          username: json['username'] as String? ?? '',
          password: json['password'] as String? ?? '',
          scope: json['scope'] as String? ?? '',
          clientId: json['clientId'],
          clientSecret: json['clientSecret'],
        );

Map<String, dynamic> _$BodyLoginForAccessTokenAuthSimpleTokenPostToJson(
        BodyLoginForAccessTokenAuthSimpleTokenPost instance) =>
    <String, dynamic>{
      'grantType': instance.grantType,
      'username': instance.username,
      'password': instance.password,
      'scope': instance.scope,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
    };

BodyPostAuthorizePageAuthAuthorizePost
    _$BodyPostAuthorizePageAuthAuthorizePostFromJson(
            Map<String, dynamic> json) =>
        BodyPostAuthorizePageAuthAuthorizePost(
          responseType: json['response_type'] as String? ?? '',
          clientId: json['client_id'] as String? ?? '',
          redirectUri: json['redirect_uri'] as String? ?? '',
          scope: json['scope'],
          state: json['state'],
          nonce: json['nonce'],
          codeChallenge: json['codeChallenge'],
          codeChallengeMethod: json['codeChallengeMethod'],
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
      'codeChallenge': instance.codeChallenge,
      'codeChallengeMethod': instance.codeChallengeMethod,
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
      refreshToken: json['refreshToken'],
      grantType: json['grant_type'] as String? ?? '',
      code: json['code'],
      redirectUri: json['redirectUri'],
      clientId: json['clientId'],
      clientSecret: json['clientSecret'],
      codeVerifier: json['codeVerifier'],
    );

Map<String, dynamic> _$BodyTokenAuthTokenPostToJson(
        BodyTokenAuthTokenPost instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'grant_type': instance.grantType,
      'code': instance.code,
      'redirectUri': instance.redirectUri,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'codeVerifier': instance.codeVerifier,
    };

BodyUploadDocumentRaidDocumentDocumentTypePost
    _$BodyUploadDocumentRaidDocumentDocumentTypePostFromJson(
            Map<String, dynamic> json) =>
        BodyUploadDocumentRaidDocumentDocumentTypePost(
          file: json['file'] as String? ?? '',
        );

Map<String, dynamic> _$BodyUploadDocumentRaidDocumentDocumentTypePostToJson(
        BodyUploadDocumentRaidDocumentDocumentTypePost instance) =>
    <String, dynamic>{
      'file': instance.file,
    };

BookingBase _$BookingBaseFromJson(Map<String, dynamic> json) => BookingBase(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      creation: DateTime.parse(json['creation'] as String),
      note: json['note'],
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrenceRule'],
      entity: json['entity'],
    );

Map<String, dynamic> _$BookingBaseToJson(BookingBase instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'creation': instance.creation.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrenceRule': instance.recurrenceRule,
      'entity': instance.entity,
    };

BookingEdit _$BookingEditFromJson(Map<String, dynamic> json) => BookingEdit(
      reason: json['reason'],
      start: json['start'],
      end: json['end'],
      note: json['note'],
      roomId: json['roomId'],
      key: json['key'],
      recurrenceRule: json['recurrenceRule'],
      entity: json['entity'],
    );

Map<String, dynamic> _$BookingEditToJson(BookingEdit instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start,
      'end': instance.end,
      'note': instance.note,
      'roomId': instance.roomId,
      'key': instance.key,
      'recurrenceRule': instance.recurrenceRule,
      'entity': instance.entity,
    };

BookingReturn _$BookingReturnFromJson(Map<String, dynamic> json) =>
    BookingReturn(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      creation: DateTime.parse(json['creation'] as String),
      note: json['note'],
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrenceRule'],
      entity: json['entity'],
      id: json['id'] as String? ?? '',
      decision: decisionFromJson(json['decision']),
      applicantId: json['applicant_id'] as String? ?? '',
      room: RoomComplete.fromJson(json['room'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingReturnToJson(BookingReturn instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'creation': instance.creation.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrenceRule': instance.recurrenceRule,
      'entity': instance.entity,
      'id': instance.id,
      'decision': decisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
      'room': instance.room.toJson(),
    };

BookingReturnApplicant _$BookingReturnApplicantFromJson(
        Map<String, dynamic> json) =>
    BookingReturnApplicant(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      creation: DateTime.parse(json['creation'] as String),
      note: json['note'],
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrenceRule'],
      entity: json['entity'],
      id: json['id'] as String? ?? '',
      decision: decisionFromJson(json['decision']),
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
      'creation': instance.creation.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrenceRule': instance.recurrenceRule,
      'entity': instance.entity,
      'id': instance.id,
      'decision': decisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
      'room': instance.room.toJson(),
      'applicant': instance.applicant.toJson(),
    };

BookingReturnSimpleApplicant _$BookingReturnSimpleApplicantFromJson(
        Map<String, dynamic> json) =>
    BookingReturnSimpleApplicant(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      creation: DateTime.parse(json['creation'] as String),
      note: json['note'],
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrenceRule'],
      entity: json['entity'],
      id: json['id'] as String? ?? '',
      decision: decisionFromJson(json['decision']),
      applicantId: json['applicant_id'] as String? ?? '',
      room: RoomComplete.fromJson(json['room'] as Map<String, dynamic>),
      applicant:
          CoreUserSimple.fromJson(json['applicant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingReturnSimpleApplicantToJson(
        BookingReturnSimpleApplicant instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'creation': instance.creation.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrenceRule': instance.recurrenceRule,
      'entity': instance.entity,
      'id': instance.id,
      'decision': decisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
      'room': instance.room.toJson(),
      'applicant': instance.applicant.toJson(),
    };

CashComplete _$CashCompleteFromJson(Map<String, dynamic> json) => CashComplete(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      userId: json['user_id'] as String? ?? '',
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashCompleteToJson(CashComplete instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'user_id': instance.userId,
      'user': instance.user.toJson(),
    };

CashEdit _$CashEditFromJson(Map<String, dynamic> json) => CashEdit(
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$CashEditToJson(CashEdit instance) => <String, dynamic>{
      'balance': instance.balance,
    };

CdrUser _$CdrUserFromJson(Map<String, dynamic> json) => CdrUser(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      curriculum: json['curriculum'],
      promo: json['promo'],
      email: json['email'] as String? ?? '',
      birthday: json['birthday'],
      phone: json['phone'],
      floor: json['floor'],
    );

Map<String, dynamic> _$CdrUserToJson(CdrUser instance) => <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
      'curriculum': instance.curriculum,
      'promo': instance.promo,
      'email': instance.email,
      'birthday': instance.birthday,
      'phone': instance.phone,
      'floor': instance.floor,
    };

CdrUserPreview _$CdrUserPreviewFromJson(Map<String, dynamic> json) =>
    CdrUserPreview(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      curriculum: json['curriculum'],
    );

Map<String, dynamic> _$CdrUserPreviewToJson(CdrUserPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
      'curriculum': instance.curriculum,
    };

CdrUserUpdate _$CdrUserUpdateFromJson(Map<String, dynamic> json) =>
    CdrUserUpdate(
      promo: json['promo'],
      nickname: json['nickname'],
      email: json['email'],
      birthday: json['birthday'],
      phone: json['phone'],
      floor: json['floor'],
    );

Map<String, dynamic> _$CdrUserUpdateToJson(CdrUserUpdate instance) =>
    <String, dynamic>{
      'promo': instance.promo,
      'nickname': instance.nickname,
      'email': instance.email,
      'birthday': instance.birthday,
      'phone': instance.phone,
      'floor': instance.floor,
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

CheckoutComplete _$CheckoutCompleteFromJson(Map<String, dynamic> json) =>
    CheckoutComplete(
      id: json['id'] as String? ?? '',
      module: json['module'] as String? ?? '',
      name: json['name'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => CheckoutPayment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      paymentCompleted: json['payment_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$CheckoutCompleteToJson(CheckoutComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'module': instance.module,
      'name': instance.name,
      'amount': instance.amount,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
      'payment_completed': instance.paymentCompleted,
    };

CheckoutPayment _$CheckoutPaymentFromJson(Map<String, dynamic> json) =>
    CheckoutPayment(
      id: json['id'] as String? ?? '',
      paidAmount: (json['paid_amount'] as num?)?.toInt() ?? 0,
      checkoutId: json['checkout_id'] as String? ?? '',
    );

Map<String, dynamic> _$CheckoutPaymentToJson(CheckoutPayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paid_amount': instance.paidAmount,
      'checkout_id': instance.checkoutId,
    };

CineSessionBase _$CineSessionBaseFromJson(Map<String, dynamic> json) =>
    CineSessionBase(
      start: DateTime.parse(json['start'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      genre: json['genre'],
      tagline: json['tagline'],
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
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      genre: json['genre'],
      tagline: json['tagline'],
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
      name: json['name'],
      start: json['start'],
      duration: json['duration'],
      overview: json['overview'],
      genre: json['genre'],
      tagline: json['tagline'],
    );

Map<String, dynamic> _$CineSessionUpdateToJson(CineSessionUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'start': instance.start,
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
      description: json['description'],
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
    );

Map<String, dynamic> _$CoreBatchUserCreateRequestToJson(
        CoreBatchUserCreateRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

CoreGroup _$CoreGroupFromJson(Map<String, dynamic> json) => CoreGroup(
      name: json['name'] as String? ?? '',
      description: json['description'],
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
      description: json['description'],
    );

Map<String, dynamic> _$CoreGroupCreateToJson(CoreGroupCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

CoreGroupSimple _$CoreGroupSimpleFromJson(Map<String, dynamic> json) =>
    CoreGroupSimple(
      name: json['name'] as String? ?? '',
      description: json['description'],
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
      name: json['name'],
      description: json['description'],
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
      minimalTitanVersionCode:
          (json['minimal_titan_version_code'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CoreInformationToJson(CoreInformation instance) =>
    <String, dynamic>{
      'ready': instance.ready,
      'version': instance.version,
      'minimal_titan_version_code': instance.minimalTitanVersionCode,
    };

CoreMembership _$CoreMembershipFromJson(Map<String, dynamic> json) =>
    CoreMembership(
      userId: json['user_id'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      description: json['description'],
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

CoreSchool _$CoreSchoolFromJson(Map<String, dynamic> json) => CoreSchool(
      name: json['name'] as String? ?? '',
      emailRegex: json['email_regex'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CoreSchoolToJson(CoreSchool instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email_regex': instance.emailRegex,
      'id': instance.id,
    };

CoreSchoolBase _$CoreSchoolBaseFromJson(Map<String, dynamic> json) =>
    CoreSchoolBase(
      name: json['name'] as String? ?? '',
      emailRegex: json['email_regex'] as String? ?? '',
    );

Map<String, dynamic> _$CoreSchoolBaseToJson(CoreSchoolBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email_regex': instance.emailRegex,
    };

CoreSchoolUpdate _$CoreSchoolUpdateFromJson(Map<String, dynamic> json) =>
    CoreSchoolUpdate(
      name: json['name'],
      emailRegex: json['emailRegex'],
    );

Map<String, dynamic> _$CoreSchoolUpdateToJson(CoreSchoolUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'emailRegex': instance.emailRegex,
    };

CoreUser _$CoreUserFromJson(Map<String, dynamic> json) => CoreUser(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      birthday: json['birthday'],
      promo: json['promo'],
      floor: json['floor'],
      phone: json['phone'],
      createdOn: json['createdOn'],
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => CoreGroupSimple.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      school: json['school'],
    );

Map<String, dynamic> _$CoreUserToJson(CoreUser instance) => <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
      'email': instance.email,
      'birthday': instance.birthday,
      'promo': instance.promo,
      'floor': instance.floor,
      'phone': instance.phone,
      'createdOn': instance.createdOn,
      'groups': instance.groups?.map((e) => e.toJson()).toList(),
      'school': instance.school,
    };

CoreUserActivateRequest _$CoreUserActivateRequestFromJson(
        Map<String, dynamic> json) =>
    CoreUserActivateRequest(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      activationToken: json['activation_token'] as String? ?? '',
      password: json['password'] as String? ?? '',
      birthday: json['birthday'],
      phone: json['phone'],
      floor: json['floor'],
      promo: json['promo'],
    );

Map<String, dynamic> _$CoreUserActivateRequestToJson(
        CoreUserActivateRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'activation_token': instance.activationToken,
      'password': instance.password,
      'birthday': instance.birthday,
      'phone': instance.phone,
      'floor': instance.floor,
      'promo': instance.promo,
    };

CoreUserCreateRequest _$CoreUserCreateRequestFromJson(
        Map<String, dynamic> json) =>
    CoreUserCreateRequest(
      email: json['email'] as String? ?? '',
      acceptExternal: json['acceptExternal'],
    );

Map<String, dynamic> _$CoreUserCreateRequestToJson(
        CoreUserCreateRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'acceptExternal': instance.acceptExternal,
    };

CoreUserFusionRequest _$CoreUserFusionRequestFromJson(
        Map<String, dynamic> json) =>
    CoreUserFusionRequest(
      userKeptEmail: json['user_kept_email'] as String? ?? '',
      userDeletedEmail: json['user_deleted_email'] as String? ?? '',
    );

Map<String, dynamic> _$CoreUserFusionRequestToJson(
        CoreUserFusionRequest instance) =>
    <String, dynamic>{
      'user_kept_email': instance.userKeptEmail,
      'user_deleted_email': instance.userDeletedEmail,
    };

CoreUserSimple _$CoreUserSimpleFromJson(Map<String, dynamic> json) =>
    CoreUserSimple(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
    );

Map<String, dynamic> _$CoreUserSimpleToJson(CoreUserSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
    };

CoreUserUpdate _$CoreUserUpdateFromJson(Map<String, dynamic> json) =>
    CoreUserUpdate(
      nickname: json['nickname'],
      birthday: json['birthday'],
      phone: json['phone'],
      floor: json['floor'],
    );

Map<String, dynamic> _$CoreUserUpdateToJson(CoreUserUpdate instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'birthday': instance.birthday,
      'phone': instance.phone,
      'floor': instance.floor,
    };

CoreUserUpdateAdmin _$CoreUserUpdateAdminFromJson(Map<String, dynamic> json) =>
    CoreUserUpdateAdmin(
      email: json['email'],
      schoolId: json['schoolId'],
      accountType: json['accountType'],
      name: json['name'],
      firstname: json['firstname'],
      promo: json['promo'],
      nickname: json['nickname'],
      birthday: json['birthday'],
      phone: json['phone'],
      floor: json['floor'],
    );

Map<String, dynamic> _$CoreUserUpdateAdminToJson(
        CoreUserUpdateAdmin instance) =>
    <String, dynamic>{
      'email': instance.email,
      'schoolId': instance.schoolId,
      'accountType': instance.accountType,
      'name': instance.name,
      'firstname': instance.firstname,
      'promo': instance.promo,
      'nickname': instance.nickname,
      'birthday': instance.birthday,
      'phone': instance.phone,
      'floor': instance.floor,
    };

CurriculumBase _$CurriculumBaseFromJson(Map<String, dynamic> json) =>
    CurriculumBase(
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$CurriculumBaseToJson(CurriculumBase instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

CurriculumComplete _$CurriculumCompleteFromJson(Map<String, dynamic> json) =>
    CurriculumComplete(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CurriculumCompleteToJson(CurriculumComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

CustomDataBase _$CustomDataBaseFromJson(Map<String, dynamic> json) =>
    CustomDataBase(
      $value: json['value'] as String? ?? '',
    );

Map<String, dynamic> _$CustomDataBaseToJson(CustomDataBase instance) =>
    <String, dynamic>{
      'value': instance.$value,
    };

CustomDataComplete _$CustomDataCompleteFromJson(Map<String, dynamic> json) =>
    CustomDataComplete(
      $value: json['value'] as String? ?? '',
      fieldId: json['field_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      field: CustomDataFieldComplete.fromJson(
          json['field'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomDataCompleteToJson(CustomDataComplete instance) =>
    <String, dynamic>{
      'value': instance.$value,
      'field_id': instance.fieldId,
      'user_id': instance.userId,
      'field': instance.field.toJson(),
    };

CustomDataFieldBase _$CustomDataFieldBaseFromJson(Map<String, dynamic> json) =>
    CustomDataFieldBase(
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$CustomDataFieldBaseToJson(
        CustomDataFieldBase instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

CustomDataFieldComplete _$CustomDataFieldCompleteFromJson(
        Map<String, dynamic> json) =>
    CustomDataFieldComplete(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
    );

Map<String, dynamic> _$CustomDataFieldCompleteToJson(
        CustomDataFieldComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'product_id': instance.productId,
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
              ?.map((e) => AppModulesAmapSchemasAmapProductComplete.fromJson(
                  e as Map<String, dynamic>))
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
      deliveryDate: json['deliveryDate'],
    );

Map<String, dynamic> _$DeliveryUpdateToJson(DeliveryUpdate instance) =>
    <String, dynamic>{
      'deliveryDate': instance.deliveryDate,
    };

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      type: documentTypeFromJson(json['type']),
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      uploadedAt: DateTime.parse(json['uploaded_at'] as String),
      validation: documentValidationFromJson(json['validation']),
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'type': documentTypeToJson(instance.type),
      'name': instance.name,
      'id': instance.id,
      'uploaded_at': _dateToJson(instance.uploadedAt),
      'validation': documentValidationToJson(instance.validation),
    };

DocumentBase _$DocumentBaseFromJson(Map<String, dynamic> json) => DocumentBase(
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$DocumentBaseToJson(DocumentBase instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

DocumentComplete _$DocumentCompleteFromJson(Map<String, dynamic> json) =>
    DocumentComplete(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      sellerId: json['seller_id'] as String? ?? '',
    );

Map<String, dynamic> _$DocumentCompleteToJson(DocumentComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'seller_id': instance.sellerId,
    };

DocumentCreation _$DocumentCreationFromJson(Map<String, dynamic> json) =>
    DocumentCreation(
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$DocumentCreationToJson(DocumentCreation instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    EmergencyContact(
      firstname: json['firstname'],
      name: json['name'],
      phone: json['phone'],
    );

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'name': instance.name,
      'phone': instance.phone,
    };

EventApplicant _$EventApplicantFromJson(Map<String, dynamic> json) =>
    EventApplicant(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      promo: json['promo'],
      phone: json['phone'],
    );

Map<String, dynamic> _$EventApplicantToJson(EventApplicant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
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
      recurrenceRule: json['recurrenceRule'],
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
      'recurrenceRule': instance.recurrenceRule,
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
      recurrenceRule: json['recurrenceRule'],
      id: json['id'] as String? ?? '',
      decision: decisionFromJson(json['decision']),
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
      'recurrenceRule': instance.recurrenceRule,
      'id': instance.id,
      'decision': decisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
    };

EventEdit _$EventEditFromJson(Map<String, dynamic> json) => EventEdit(
      name: json['name'],
      organizer: json['organizer'],
      start: json['start'],
      end: json['end'],
      allDay: json['allDay'],
      location: json['location'],
      type: json['type'],
      description: json['description'],
      recurrenceRule: json['recurrenceRule'],
    );

Map<String, dynamic> _$EventEditToJson(EventEdit instance) => <String, dynamic>{
      'name': instance.name,
      'organizer': instance.organizer,
      'start': instance.start,
      'end': instance.end,
      'allDay': instance.allDay,
      'location': instance.location,
      'type': instance.type,
      'description': instance.description,
      'recurrenceRule': instance.recurrenceRule,
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
      recurrenceRule: json['recurrenceRule'],
      id: json['id'] as String? ?? '',
      decision: decisionFromJson(json['decision']),
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
      'recurrenceRule': instance.recurrenceRule,
      'id': instance.id,
      'decision': decisionToJson(instance.decision),
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

FlappyBirdScoreBase _$FlappyBirdScoreBaseFromJson(Map<String, dynamic> json) =>
    FlappyBirdScoreBase(
      $value: (json['value'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$FlappyBirdScoreBaseToJson(
        FlappyBirdScoreBase instance) =>
    <String, dynamic>{
      'value': instance.$value,
    };

FlappyBirdScoreCompleteFeedBack _$FlappyBirdScoreCompleteFeedBackFromJson(
        Map<String, dynamic> json) =>
    FlappyBirdScoreCompleteFeedBack(
      $value: (json['value'] as num?)?.toInt() ?? 0,
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
      creationTime: DateTime.parse(json['creation_time'] as String),
      position: (json['position'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$FlappyBirdScoreCompleteFeedBackToJson(
        FlappyBirdScoreCompleteFeedBack instance) =>
    <String, dynamic>{
      'value': instance.$value,
      'user': instance.user.toJson(),
      'creation_time': instance.creationTime.toIso8601String(),
      'position': instance.position,
    };

FlappyBirdScoreInDB _$FlappyBirdScoreInDBFromJson(Map<String, dynamic> json) =>
    FlappyBirdScoreInDB(
      $value: (json['value'] as num?)?.toInt() ?? 0,
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
      creationTime: DateTime.parse(json['creation_time'] as String),
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
    );

Map<String, dynamic> _$FlappyBirdScoreInDBToJson(
        FlappyBirdScoreInDB instance) =>
    <String, dynamic>{
      'value': instance.$value,
      'user': instance.user.toJson(),
      'creation_time': instance.creationTime.toIso8601String(),
      'id': instance.id,
      'user_id': instance.userId,
    };

GenerateTicketBase _$GenerateTicketBaseFromJson(Map<String, dynamic> json) =>
    GenerateTicketBase(
      name: json['name'] as String? ?? '',
      maxUse: (json['max_use'] as num?)?.toInt() ?? 0,
      expiration: DateTime.parse(json['expiration'] as String),
    );

Map<String, dynamic> _$GenerateTicketBaseToJson(GenerateTicketBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'max_use': instance.maxUse,
      'expiration': instance.expiration.toIso8601String(),
    };

GenerateTicketComplete _$GenerateTicketCompleteFromJson(
        Map<String, dynamic> json) =>
    GenerateTicketComplete(
      name: json['name'] as String? ?? '',
      maxUse: (json['max_use'] as num?)?.toInt() ?? 0,
      expiration: DateTime.parse(json['expiration'] as String),
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$GenerateTicketCompleteToJson(
        GenerateTicketComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'max_use': instance.maxUse,
      'expiration': instance.expiration.toIso8601String(),
      'id': instance.id,
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

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      id: json['id'] as String? ?? '',
      type: historyTypeFromJson(json['type']),
      otherWalletName: json['other_wallet_name'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      creation: DateTime.parse(json['creation'] as String),
      status: transactionStatusFromJson(json['status']),
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'id': instance.id,
      'type': historyTypeToJson(instance.type),
      'other_wallet_name': instance.otherWalletName,
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
      'status': transactionStatusToJson(instance.status),
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
      manager: json['manager'],
      link: json['link'],
      description: json['description'],
    );

Map<String, dynamic> _$InformationEditToJson(InformationEdit instance) =>
    <String, dynamic>{
      'manager': instance.manager,
      'link': instance.link,
      'description': instance.description,
    };

IntrospectTokenResponse _$IntrospectTokenResponseFromJson(
        Map<String, dynamic> json) =>
    IntrospectTokenResponse(
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$IntrospectTokenResponseToJson(
        IntrospectTokenResponse instance) =>
    <String, dynamic>{
      'active': instance.active,
    };

InviteToken _$InviteTokenFromJson(Map<String, dynamic> json) => InviteToken(
      teamId: json['team_id'] as String? ?? '',
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$InviteTokenToJson(InviteToken instance) =>
    <String, dynamic>{
      'team_id': instance.teamId,
      'token': instance.token,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String? ?? '',
      suggestedCaution: (json['suggested_caution'] as num?)?.toInt() ?? 0,
      totalQuantity: (json['total_quantity'] as num?)?.toInt() ?? 0,
      suggestedLendingDuration:
          (json['suggested_lending_duration'] as num?)?.toInt() ?? 0,
      id: json['id'] as String? ?? '',
      loanerId: json['loaner_id'] as String? ?? '',
      loanedQuantity: (json['loaned_quantity'] as num?)?.toInt() ?? 0,
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
      suggestedCaution: (json['suggested_caution'] as num?)?.toInt() ?? 0,
      totalQuantity: (json['total_quantity'] as num?)?.toInt() ?? 0,
      suggestedLendingDuration:
          (json['suggested_lending_duration'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ItemBaseToJson(ItemBase instance) => <String, dynamic>{
      'name': instance.name,
      'suggested_caution': instance.suggestedCaution,
      'total_quantity': instance.totalQuantity,
      'suggested_lending_duration': instance.suggestedLendingDuration,
    };

ItemBorrowed _$ItemBorrowedFromJson(Map<String, dynamic> json) => ItemBorrowed(
      itemId: json['item_id'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ItemBorrowedToJson(ItemBorrowed instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'quantity': instance.quantity,
    };

ItemQuantity _$ItemQuantityFromJson(Map<String, dynamic> json) => ItemQuantity(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
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
      name: json['name'],
      suggestedCaution: json['suggestedCaution'],
      totalQuantity: json['totalQuantity'],
      suggestedLendingDuration: json['suggestedLendingDuration'],
    );

Map<String, dynamic> _$ItemUpdateToJson(ItemUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'suggestedCaution': instance.suggestedCaution,
      'totalQuantity': instance.totalQuantity,
      'suggestedLendingDuration': instance.suggestedLendingDuration,
    };

KindsReturn _$KindsReturnFromJson(Map<String, dynamic> json) => KindsReturn(
      kinds: kindsListFromJson(json['kinds'] as List?),
    );

Map<String, dynamic> _$KindsReturnToJson(KindsReturn instance) =>
    <String, dynamic>{
      'kinds': kindsListToJson(instance.kinds),
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
      program: json['program'],
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
      name: json['name'],
      description: json['description'],
      type: json['type'],
      members: json['members'],
      program: json['program'],
    );

Map<String, dynamic> _$ListEditToJson(ListEdit instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'members': instance.members,
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
      program: json['program'],
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
      notes: json['notes'],
      caution: json['caution'],
      id: json['id'] as String? ?? '',
      returned: json['returned'] as bool? ?? false,
      returnedDate: json['returnedDate'],
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
      'returnedDate': instance.returnedDate,
      'items_qty': instance.itemsQty.map((e) => e.toJson()).toList(),
      'borrower': instance.borrower.toJson(),
      'loaner': instance.loaner.toJson(),
    };

LoanCreation _$LoanCreationFromJson(Map<String, dynamic> json) => LoanCreation(
      borrowerId: json['borrower_id'] as String? ?? '',
      loanerId: json['loaner_id'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      notes: json['notes'],
      caution: json['caution'],
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
      end: json['end'],
      duration: json['duration'],
    );

Map<String, dynamic> _$LoanExtendToJson(LoanExtend instance) =>
    <String, dynamic>{
      'end': instance.end,
      'duration': instance.duration,
    };

LoanUpdate _$LoanUpdateFromJson(Map<String, dynamic> json) => LoanUpdate(
      borrowerId: json['borrowerId'],
      start: json['start'],
      end: json['end'],
      notes: json['notes'],
      caution: json['caution'],
      returned: json['returned'],
      itemsBorrowed: json['itemsBorrowed'],
    );

Map<String, dynamic> _$LoanUpdateToJson(LoanUpdate instance) =>
    <String, dynamic>{
      'borrowerId': instance.borrowerId,
      'start': instance.start,
      'end': instance.end,
      'notes': instance.notes,
      'caution': instance.caution,
      'returned': instance.returned,
      'itemsBorrowed': instance.itemsBorrowed,
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
      name: json['name'],
      groupManagerId: json['groupManagerId'],
    );

Map<String, dynamic> _$LoanerUpdateToJson(LoanerUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groupManagerId': instance.groupManagerId,
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
      name: json['name'],
      groupId: json['groupId'],
    );

Map<String, dynamic> _$ManagerUpdateToJson(ManagerUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groupId': instance.groupId,
    };

MemberComplete _$MemberCompleteFromJson(Map<String, dynamic> json) =>
    MemberComplete(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'],
      promo: json['promo'],
      memberships: (json['memberships'] as List<dynamic>?)
              ?.map(
                  (e) => MembershipComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MemberCompleteToJson(MemberComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
      'email': instance.email,
      'phone': instance.phone,
      'promo': instance.promo,
      'memberships': instance.memberships.map((e) => e.toJson()).toList(),
    };

MembershipComplete _$MembershipCompleteFromJson(Map<String, dynamic> json) =>
    MembershipComplete(
      userId: json['user_id'] as String? ?? '',
      associationId: json['association_id'] as String? ?? '',
      mandateYear: (json['mandate_year'] as num?)?.toInt() ?? 0,
      roleName: json['role_name'] as String? ?? '',
      roleTags: json['roleTags'],
      memberOrder: (json['member_order'] as num?)?.toInt() ?? 0,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$MembershipCompleteToJson(MembershipComplete instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'association_id': instance.associationId,
      'mandate_year': instance.mandateYear,
      'role_name': instance.roleName,
      'roleTags': instance.roleTags,
      'member_order': instance.memberOrder,
      'id': instance.id,
    };

MembershipEdit _$MembershipEditFromJson(Map<String, dynamic> json) =>
    MembershipEdit(
      roleName: json['roleName'],
      roleTags: json['roleTags'],
      memberOrder: json['memberOrder'],
    );

Map<String, dynamic> _$MembershipEditToJson(MembershipEdit instance) =>
    <String, dynamic>{
      'roleName': instance.roleName,
      'roleTags': instance.roleTags,
      'memberOrder': instance.memberOrder,
    };

MembershipSimple _$MembershipSimpleFromJson(Map<String, dynamic> json) =>
    MembershipSimple(
      name: json['name'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$MembershipSimpleToJson(MembershipSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
      'id': instance.id,
    };

MembershipUserMappingEmail _$MembershipUserMappingEmailFromJson(
        Map<String, dynamic> json) =>
    MembershipUserMappingEmail(
      userEmail: json['user_email'] as String? ?? '',
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$MembershipUserMappingEmailToJson(
        MembershipUserMappingEmail instance) =>
    <String, dynamic>{
      'user_email': instance.userEmail,
      'start_date': _dateToJson(instance.startDate),
      'end_date': _dateToJson(instance.endDate),
    };

ModuleVisibility _$ModuleVisibilityFromJson(Map<String, dynamic> json) =>
    ModuleVisibility(
      root: json['root'] as String? ?? '',
      allowedGroupIds: (json['allowed_group_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      allowedAccountTypes:
          accountTypeListFromJson(json['allowed_account_types'] as List?),
    );

Map<String, dynamic> _$ModuleVisibilityToJson(ModuleVisibility instance) =>
    <String, dynamic>{
      'root': instance.root,
      'allowed_group_ids': instance.allowedGroupIds,
      'allowed_account_types':
          accountTypeListToJson(instance.allowedAccountTypes),
    };

ModuleVisibilityCreate _$ModuleVisibilityCreateFromJson(
        Map<String, dynamic> json) =>
    ModuleVisibilityCreate(
      root: json['root'] as String? ?? '',
      allowedGroupId: json['allowedGroupId'],
      allowedAccountType: json['allowedAccountType'],
    );

Map<String, dynamic> _$ModuleVisibilityCreateToJson(
        ModuleVisibilityCreate instance) =>
    <String, dynamic>{
      'root': instance.root,
      'allowedGroupId': instance.allowedGroupId,
      'allowedAccountType': instance.allowedAccountType,
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
              ?.map((e) => (e as num).toInt())
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
      productsIds: json['productsIds'],
      collectionSlot: json['collectionSlot'],
      productsQuantity: json['productsQuantity'],
    );

Map<String, dynamic> _$OrderEditToJson(OrderEdit instance) => <String, dynamic>{
      'productsIds': instance.productsIds,
      'collectionSlot': instance.collectionSlot,
      'productsQuantity': instance.productsQuantity,
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
      packSize: (json['pack_size'] as num?)?.toInt() ?? 0,
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
      raffleId: json['raffleId'],
      price: json['price'],
      packSize: json['packSize'],
    );

Map<String, dynamic> _$PackTicketEditToJson(PackTicketEdit instance) =>
    <String, dynamic>{
      'raffleId': instance.raffleId,
      'price': instance.price,
      'packSize': instance.packSize,
    };

PackTicketSimple _$PackTicketSimpleFromJson(Map<String, dynamic> json) =>
    PackTicketSimple(
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      packSize: (json['pack_size'] as num?)?.toInt() ?? 0,
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

PaperBase _$PaperBaseFromJson(Map<String, dynamic> json) => PaperBase(
      name: json['name'] as String? ?? '',
      releaseDate: DateTime.parse(json['release_date'] as String),
    );

Map<String, dynamic> _$PaperBaseToJson(PaperBase instance) => <String, dynamic>{
      'name': instance.name,
      'release_date': _dateToJson(instance.releaseDate),
    };

PaperComplete _$PaperCompleteFromJson(Map<String, dynamic> json) =>
    PaperComplete(
      name: json['name'] as String? ?? '',
      releaseDate: DateTime.parse(json['release_date'] as String),
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$PaperCompleteToJson(PaperComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'release_date': _dateToJson(instance.releaseDate),
      'id': instance.id,
    };

PaperUpdate _$PaperUpdateFromJson(Map<String, dynamic> json) => PaperUpdate(
      name: json['name'],
      releaseDate: json['releaseDate'],
    );

Map<String, dynamic> _$PaperUpdateToJson(PaperUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'releaseDate': instance.releaseDate,
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      birthday: DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      id: json['id'] as String? ?? '',
      bikeSize: json['bikeSize'],
      tShirtSize: json['tShirtSize'],
      situation: json['situation'],
      validationProgress:
          (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
      payment: json['payment'] as bool? ?? false,
      tShirtPayment: json['t_shirt_payment'] as bool? ?? false,
      numberOfDocument: (json['number_of_document'] as num?)?.toInt() ?? 0,
      numberOfValidatedDocument:
          (json['number_of_validated_document'] as num?)?.toInt() ?? 0,
      address: json['address'],
      otherSchool: json['otherSchool'],
      company: json['company'],
      diet: json['diet'],
      idCard: json['idCard'],
      medicalCertificate: json['medicalCertificate'],
      securityFile: json['securityFile'],
      studentCard: json['studentCard'],
      raidRules: json['raidRules'],
      parentAuthorization: json['parentAuthorization'],
      attestationOnHonour: json['attestation_on_honour'] as bool? ?? false,
      isMinor: json['is_minor'] as bool? ?? false,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'email': instance.email,
      'id': instance.id,
      'bikeSize': instance.bikeSize,
      'tShirtSize': instance.tShirtSize,
      'situation': instance.situation,
      'validation_progress': instance.validationProgress,
      'payment': instance.payment,
      't_shirt_payment': instance.tShirtPayment,
      'number_of_document': instance.numberOfDocument,
      'number_of_validated_document': instance.numberOfValidatedDocument,
      'address': instance.address,
      'otherSchool': instance.otherSchool,
      'company': instance.company,
      'diet': instance.diet,
      'idCard': instance.idCard,
      'medicalCertificate': instance.medicalCertificate,
      'securityFile': instance.securityFile,
      'studentCard': instance.studentCard,
      'raidRules': instance.raidRules,
      'parentAuthorization': instance.parentAuthorization,
      'attestation_on_honour': instance.attestationOnHonour,
      'is_minor': instance.isMinor,
    };

ParticipantBase _$ParticipantBaseFromJson(Map<String, dynamic> json) =>
    ParticipantBase(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      birthday: DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$ParticipantBaseToJson(ParticipantBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'email': instance.email,
    };

ParticipantPreview _$ParticipantPreviewFromJson(Map<String, dynamic> json) =>
    ParticipantPreview(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      birthday: DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      id: json['id'] as String? ?? '',
      bikeSize: json['bikeSize'],
      tShirtSize: json['tShirtSize'],
      situation: json['situation'],
      validationProgress:
          (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
      payment: json['payment'] as bool? ?? false,
      tShirtPayment: json['t_shirt_payment'] as bool? ?? false,
      numberOfDocument: (json['number_of_document'] as num?)?.toInt() ?? 0,
      numberOfValidatedDocument:
          (json['number_of_validated_document'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ParticipantPreviewToJson(ParticipantPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'email': instance.email,
      'id': instance.id,
      'bikeSize': instance.bikeSize,
      'tShirtSize': instance.tShirtSize,
      'situation': instance.situation,
      'validation_progress': instance.validationProgress,
      'payment': instance.payment,
      't_shirt_payment': instance.tShirtPayment,
      'number_of_document': instance.numberOfDocument,
      'number_of_validated_document': instance.numberOfValidatedDocument,
    };

ParticipantUpdate _$ParticipantUpdateFromJson(Map<String, dynamic> json) =>
    ParticipantUpdate(
      name: json['name'],
      firstname: json['firstname'],
      birthday: json['birthday'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      bikeSize: json['bikeSize'],
      tShirtSize: json['tShirtSize'],
      situation: json['situation'],
      otherSchool: json['otherSchool'],
      company: json['company'],
      diet: json['diet'],
      attestationOnHonour: json['attestationOnHonour'],
      idCardId: json['idCardId'],
      medicalCertificateId: json['medicalCertificateId'],
      securityFileId: json['securityFileId'],
      studentCardId: json['studentCardId'],
      raidRulesId: json['raidRulesId'],
      parentAuthorizationId: json['parentAuthorizationId'],
    );

Map<String, dynamic> _$ParticipantUpdateToJson(ParticipantUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'birthday': instance.birthday,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'bikeSize': instance.bikeSize,
      'tShirtSize': instance.tShirtSize,
      'situation': instance.situation,
      'otherSchool': instance.otherSchool,
      'company': instance.company,
      'diet': instance.diet,
      'attestationOnHonour': instance.attestationOnHonour,
      'idCardId': instance.idCardId,
      'medicalCertificateId': instance.medicalCertificateId,
      'securityFileId': instance.securityFileId,
      'studentCardId': instance.studentCardId,
      'raidRulesId': instance.raidRulesId,
      'parentAuthorizationId': instance.parentAuthorizationId,
    };

PaymentBase _$PaymentBaseFromJson(Map<String, dynamic> json) => PaymentBase(
      total: (json['total'] as num?)?.toInt() ?? 0,
      paymentType: paymentTypeFromJson(json['payment_type']),
    );

Map<String, dynamic> _$PaymentBaseToJson(PaymentBase instance) =>
    <String, dynamic>{
      'total': instance.total,
      'payment_type': paymentTypeToJson(instance.paymentType),
    };

PaymentComplete _$PaymentCompleteFromJson(Map<String, dynamic> json) =>
    PaymentComplete(
      total: (json['total'] as num?)?.toInt() ?? 0,
      paymentType: paymentTypeFromJson(json['payment_type']),
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
    );

Map<String, dynamic> _$PaymentCompleteToJson(PaymentComplete instance) =>
    <String, dynamic>{
      'total': instance.total,
      'payment_type': paymentTypeToJson(instance.paymentType),
      'id': instance.id,
      'user_id': instance.userId,
    };

PaymentUrl _$PaymentUrlFromJson(Map<String, dynamic> json) => PaymentUrl(
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$PaymentUrlToJson(PaymentUrl instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

PrizeBase _$PrizeBaseFromJson(Map<String, dynamic> json) => PrizeBase(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      raffleId: json['raffle_id'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PrizeBaseToJson(PrizeBase instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'raffle_id': instance.raffleId,
      'quantity': instance.quantity,
    };

PrizeEdit _$PrizeEditFromJson(Map<String, dynamic> json) => PrizeEdit(
      raffleId: json['raffleId'],
      description: json['description'],
      name: json['name'],
      quantity: json['quantity'],
    );

Map<String, dynamic> _$PrizeEditToJson(PrizeEdit instance) => <String, dynamic>{
      'raffleId': instance.raffleId,
      'description': instance.description,
      'name': instance.name,
      'quantity': instance.quantity,
    };

PrizeSimple _$PrizeSimpleFromJson(Map<String, dynamic> json) => PrizeSimple(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      raffleId: json['raffle_id'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
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

ProductBase _$ProductBaseFromJson(Map<String, dynamic> json) => ProductBase(
      nameFr: json['name_fr'] as String? ?? '',
      nameEn: json['nameEn'],
      descriptionFr: json['descriptionFr'],
      descriptionEn: json['descriptionEn'],
      availableOnline: json['available_online'] as bool? ?? false,
      relatedMembership: json['relatedMembership'],
      tickets: (json['tickets'] as List<dynamic>?)
              ?.map(
                  (e) => GenerateTicketBase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      productConstraints: (json['product_constraints'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      documentConstraints: (json['document_constraints'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProductBaseToJson(ProductBase instance) =>
    <String, dynamic>{
      'name_fr': instance.nameFr,
      'nameEn': instance.nameEn,
      'descriptionFr': instance.descriptionFr,
      'descriptionEn': instance.descriptionEn,
      'available_online': instance.availableOnline,
      'relatedMembership': instance.relatedMembership,
      'tickets': instance.tickets?.map((e) => e.toJson()).toList(),
      'product_constraints': instance.productConstraints,
      'document_constraints': instance.documentConstraints,
    };

ProductCompleteNoConstraint _$ProductCompleteNoConstraintFromJson(
        Map<String, dynamic> json) =>
    ProductCompleteNoConstraint(
      nameFr: json['name_fr'] as String? ?? '',
      nameEn: json['nameEn'],
      descriptionFr: json['descriptionFr'],
      descriptionEn: json['descriptionEn'],
      availableOnline: json['available_online'] as bool? ?? false,
      id: json['id'] as String? ?? '',
      sellerId: json['seller_id'] as String? ?? '',
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) =>
                  ProductVariantComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      relatedMembership: json['relatedMembership'],
      tickets: (json['tickets'] as List<dynamic>?)
              ?.map((e) =>
                  GenerateTicketComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProductCompleteNoConstraintToJson(
        ProductCompleteNoConstraint instance) =>
    <String, dynamic>{
      'name_fr': instance.nameFr,
      'nameEn': instance.nameEn,
      'descriptionFr': instance.descriptionFr,
      'descriptionEn': instance.descriptionEn,
      'available_online': instance.availableOnline,
      'id': instance.id,
      'seller_id': instance.sellerId,
      'variants': instance.variants?.map((e) => e.toJson()).toList(),
      'relatedMembership': instance.relatedMembership,
      'tickets': instance.tickets.map((e) => e.toJson()).toList(),
    };

ProductQuantity _$ProductQuantityFromJson(Map<String, dynamic> json) =>
    ProductQuantity(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      product: AppModulesAmapSchemasAmapProductComplete.fromJson(
          json['product'] as Map<String, dynamic>),
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

ProductVariantBase _$ProductVariantBaseFromJson(Map<String, dynamic> json) =>
    ProductVariantBase(
      nameFr: json['name_fr'] as String? ?? '',
      nameEn: json['nameEn'],
      descriptionFr: json['descriptionFr'],
      descriptionEn: json['descriptionEn'],
      price: (json['price'] as num?)?.toInt() ?? 0,
      enabled: json['enabled'] as bool? ?? false,
      unique: json['unique'] as bool? ?? false,
      allowedCurriculum: (json['allowed_curriculum'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      relatedMembershipAddedDuration: json['relatedMembershipAddedDuration'],
    );

Map<String, dynamic> _$ProductVariantBaseToJson(ProductVariantBase instance) =>
    <String, dynamic>{
      'name_fr': instance.nameFr,
      'nameEn': instance.nameEn,
      'descriptionFr': instance.descriptionFr,
      'descriptionEn': instance.descriptionEn,
      'price': instance.price,
      'enabled': instance.enabled,
      'unique': instance.unique,
      'allowed_curriculum': instance.allowedCurriculum,
      'relatedMembershipAddedDuration': instance.relatedMembershipAddedDuration,
    };

ProductVariantComplete _$ProductVariantCompleteFromJson(
        Map<String, dynamic> json) =>
    ProductVariantComplete(
      id: json['id'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      nameFr: json['name_fr'] as String? ?? '',
      nameEn: json['nameEn'],
      descriptionFr: json['descriptionFr'],
      descriptionEn: json['descriptionEn'],
      price: (json['price'] as num?)?.toInt() ?? 0,
      enabled: json['enabled'] as bool? ?? false,
      unique: json['unique'] as bool? ?? false,
      allowedCurriculum: (json['allowed_curriculum'] as List<dynamic>?)
              ?.map(
                  (e) => CurriculumComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      relatedMembershipAddedDuration: json['relatedMembershipAddedDuration'],
    );

Map<String, dynamic> _$ProductVariantCompleteToJson(
        ProductVariantComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'name_fr': instance.nameFr,
      'nameEn': instance.nameEn,
      'descriptionFr': instance.descriptionFr,
      'descriptionEn': instance.descriptionEn,
      'price': instance.price,
      'enabled': instance.enabled,
      'unique': instance.unique,
      'allowed_curriculum':
          instance.allowedCurriculum?.map((e) => e.toJson()).toList(),
      'relatedMembershipAddedDuration': instance.relatedMembershipAddedDuration,
    };

ProductVariantEdit _$ProductVariantEditFromJson(Map<String, dynamic> json) =>
    ProductVariantEdit(
      nameFr: json['nameFr'],
      nameEn: json['nameEn'],
      descriptionFr: json['descriptionFr'],
      descriptionEn: json['descriptionEn'],
      price: json['price'],
      enabled: json['enabled'],
      unique: json['unique'],
      allowedCurriculum: json['allowedCurriculum'],
      relatedMembershipAddedDuration: json['relatedMembershipAddedDuration'],
    );

Map<String, dynamic> _$ProductVariantEditToJson(ProductVariantEdit instance) =>
    <String, dynamic>{
      'nameFr': instance.nameFr,
      'nameEn': instance.nameEn,
      'descriptionFr': instance.descriptionFr,
      'descriptionEn': instance.descriptionEn,
      'price': instance.price,
      'enabled': instance.enabled,
      'unique': instance.unique,
      'allowedCurriculum': instance.allowedCurriculum,
      'relatedMembershipAddedDuration': instance.relatedMembershipAddedDuration,
    };

PurchaseBase _$PurchaseBaseFromJson(Map<String, dynamic> json) => PurchaseBase(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PurchaseBaseToJson(PurchaseBase instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
    };

PurchaseComplete _$PurchaseCompleteFromJson(Map<String, dynamic> json) =>
    PurchaseComplete(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      userId: json['user_id'] as String? ?? '',
      productVariantId: json['product_variant_id'] as String? ?? '',
      validated: json['validated'] as bool? ?? false,
      purchasedOn: DateTime.parse(json['purchased_on'] as String),
    );

Map<String, dynamic> _$PurchaseCompleteToJson(PurchaseComplete instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'user_id': instance.userId,
      'product_variant_id': instance.productVariantId,
      'validated': instance.validated,
      'purchased_on': instance.purchasedOn.toIso8601String(),
    };

PurchaseReturn _$PurchaseReturnFromJson(Map<String, dynamic> json) =>
    PurchaseReturn(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      userId: json['user_id'] as String? ?? '',
      productVariantId: json['product_variant_id'] as String? ?? '',
      validated: json['validated'] as bool? ?? false,
      purchasedOn: DateTime.parse(json['purchased_on'] as String),
      price: (json['price'] as num?)?.toInt() ?? 0,
      product: AppModulesCdrSchemasCdrProductComplete.fromJson(
          json['product'] as Map<String, dynamic>),
      seller: SellerComplete.fromJson(json['seller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurchaseReturnToJson(PurchaseReturn instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'user_id': instance.userId,
      'product_variant_id': instance.productVariantId,
      'validated': instance.validated,
      'purchased_on': instance.purchasedOn.toIso8601String(),
      'price': instance.price,
      'product': instance.product.toJson(),
      'seller': instance.seller.toJson(),
    };

RaffleBase _$RaffleBaseFromJson(Map<String, dynamic> json) => RaffleBase(
      name: json['name'] as String? ?? '',
      status: json['status'],
      description: json['description'],
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$RaffleBaseToJson(RaffleBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
      'group_id': instance.groupId,
    };

RaffleComplete _$RaffleCompleteFromJson(Map<String, dynamic> json) =>
    RaffleComplete(
      name: json['name'] as String? ?? '',
      status: json['status'],
      description: json['description'],
      groupId: json['group_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$RaffleCompleteToJson(RaffleComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
      'group_id': instance.groupId,
      'id': instance.id,
    };

RaffleEdit _$RaffleEditFromJson(Map<String, dynamic> json) => RaffleEdit(
      name: json['name'],
      description: json['description'],
    );

Map<String, dynamic> _$RaffleEditToJson(RaffleEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

RaffleStats _$RaffleStatsFromJson(Map<String, dynamic> json) => RaffleStats(
      ticketsSold: (json['tickets_sold'] as num?)?.toInt() ?? 0,
      amountRaised: (json['amount_raised'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$RaffleStatsToJson(RaffleStats instance) =>
    <String, dynamic>{
      'tickets_sold': instance.ticketsSold,
      'amount_raised': instance.amountRaised,
    };

RaidDriveFoldersCreation _$RaidDriveFoldersCreationFromJson(
        Map<String, dynamic> json) =>
    RaidDriveFoldersCreation(
      parentFolderId: json['parent_folder_id'] as String? ?? '',
    );

Map<String, dynamic> _$RaidDriveFoldersCreationToJson(
        RaidDriveFoldersCreation instance) =>
    <String, dynamic>{
      'parent_folder_id': instance.parentFolderId,
    };

RaidInformation _$RaidInformationFromJson(Map<String, dynamic> json) =>
    RaidInformation(
      raidStartDate: json['raidStartDate'],
      raidEndDate: json['raidEndDate'],
      raidRegisteringEndDate: json['raidRegisteringEndDate'],
      paymentLink: json['paymentLink'],
      contact: json['contact'],
      president: json['president'],
      volunteerResponsible: json['volunteerResponsible'],
      securityResponsible: json['securityResponsible'],
      rescue: json['rescue'],
      raidRulesId: json['raidRulesId'],
      raidInformationId: json['raidInformationId'],
    );

Map<String, dynamic> _$RaidInformationToJson(RaidInformation instance) =>
    <String, dynamic>{
      'raidStartDate': instance.raidStartDate,
      'raidEndDate': instance.raidEndDate,
      'raidRegisteringEndDate': instance.raidRegisteringEndDate,
      'paymentLink': instance.paymentLink,
      'contact': instance.contact,
      'president': instance.president,
      'volunteerResponsible': instance.volunteerResponsible,
      'securityResponsible': instance.securityResponsible,
      'rescue': instance.rescue,
      'raidRulesId': instance.raidRulesId,
      'raidInformationId': instance.raidInformationId,
    };

RaidPrice _$RaidPriceFromJson(Map<String, dynamic> json) => RaidPrice(
      studentPrice: json['studentPrice'],
      partnerPrice: json['partnerPrice'],
      tShirtPrice: json['tShirtPrice'],
    );

Map<String, dynamic> _$RaidPriceToJson(RaidPrice instance) => <String, dynamic>{
      'studentPrice': instance.studentPrice,
      'partnerPrice': instance.partnerPrice,
      'tShirtPrice': instance.tShirtPrice,
    };

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      title: json['title'] as String? ?? '',
      code: json['code'],
      summary: json['summary'] as String? ?? '',
      description: json['description'] as String? ?? '',
      id: json['id'] as String? ?? '',
      creation: DateTime.parse(json['creation'] as String),
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'summary': instance.summary,
      'description': instance.description,
      'id': instance.id,
      'creation': instance.creation.toIso8601String(),
    };

RecommendationBase _$RecommendationBaseFromJson(Map<String, dynamic> json) =>
    RecommendationBase(
      title: json['title'] as String? ?? '',
      code: json['code'],
      summary: json['summary'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$RecommendationBaseToJson(RecommendationBase instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'summary': instance.summary,
      'description': instance.description,
    };

RecommendationEdit _$RecommendationEditFromJson(Map<String, dynamic> json) =>
    RecommendationEdit(
      title: json['title'],
      code: json['code'],
      summary: json['summary'],
      description: json['description'],
    );

Map<String, dynamic> _$RecommendationEditToJson(RecommendationEdit instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'summary': instance.summary,
      'description': instance.description,
    };

Refund _$RefundFromJson(Map<String, dynamic> json) => Refund(
      id: json['id'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      creation: DateTime.parse(json['creation'] as String),
      transactionId: json['transaction_id'] as String? ?? '',
      sellerUserId: json['sellerUserId'],
      creditedWalletId: json['credited_wallet_id'] as String? ?? '',
      debitedWalletId: json['debited_wallet_id'] as String? ?? '',
      transaction:
          Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      creditedWallet:
          WalletInfo.fromJson(json['credited_wallet'] as Map<String, dynamic>),
      debitedWallet:
          WalletInfo.fromJson(json['debited_wallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RefundToJson(Refund instance) => <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
      'transaction_id': instance.transactionId,
      'sellerUserId': instance.sellerUserId,
      'credited_wallet_id': instance.creditedWalletId,
      'debited_wallet_id': instance.debitedWalletId,
      'transaction': instance.transaction.toJson(),
      'credited_wallet': instance.creditedWallet.toJson(),
      'debited_wallet': instance.debitedWallet.toJson(),
    };

RefundInfo _$RefundInfoFromJson(Map<String, dynamic> json) => RefundInfo(
      completeRefund: json['complete_refund'] as bool? ?? false,
      amount: json['amount'],
    );

Map<String, dynamic> _$RefundInfoToJson(RefundInfo instance) =>
    <String, dynamic>{
      'complete_refund': instance.completeRefund,
      'amount': instance.amount,
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

RoleTagsReturn _$RoleTagsReturnFromJson(Map<String, dynamic> json) =>
    RoleTagsReturn(
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$RoleTagsReturnToJson(RoleTagsReturn instance) =>
    <String, dynamic>{
      'tags': instance.tags,
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

ScanInfo _$ScanInfoFromJson(Map<String, dynamic> json) => ScanInfo(
      qrCodeId: json['qr_code_id'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      creation: DateTime.parse(json['creation'] as String),
      walletDeviceId: json['wallet_device_id'] as String? ?? '',
      store: json['store'] as bool? ?? false,
      signature: json['signature'] as String? ?? '',
      bypassMembership: json['bypass_membership'] as bool? ?? false,
    );

Map<String, dynamic> _$ScanInfoToJson(ScanInfo instance) => <String, dynamic>{
      'qr_code_id': instance.qrCodeId,
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
      'wallet_device_id': instance.walletDeviceId,
      'store': instance.store,
      'signature': instance.signature,
      'bypass_membership': instance.bypassMembership,
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

SecurityFile _$SecurityFileFromJson(Map<String, dynamic> json) => SecurityFile(
      allergy: json['allergy'],
      asthma: json['asthma'] as bool? ?? false,
      intensiveCareUnit: json['intensiveCareUnit'],
      intensiveCareUnitWhen: json['intensiveCareUnitWhen'],
      ongoingTreatment: json['ongoingTreatment'],
      sicknesses: json['sicknesses'],
      hospitalization: json['hospitalization'],
      surgicalOperation: json['surgicalOperation'],
      trauma: json['trauma'],
      family: json['family'],
      emergencyPersonFirstname: json['emergencyPersonFirstname'],
      emergencyPersonName: json['emergencyPersonName'],
      emergencyPersonPhone: json['emergencyPersonPhone'],
      fileId: json['fileId'],
      validation: documentValidationFromJson(json['validation']),
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$SecurityFileToJson(SecurityFile instance) =>
    <String, dynamic>{
      'allergy': instance.allergy,
      'asthma': instance.asthma,
      'intensiveCareUnit': instance.intensiveCareUnit,
      'intensiveCareUnitWhen': instance.intensiveCareUnitWhen,
      'ongoingTreatment': instance.ongoingTreatment,
      'sicknesses': instance.sicknesses,
      'hospitalization': instance.hospitalization,
      'surgicalOperation': instance.surgicalOperation,
      'trauma': instance.trauma,
      'family': instance.family,
      'emergencyPersonFirstname': instance.emergencyPersonFirstname,
      'emergencyPersonName': instance.emergencyPersonName,
      'emergencyPersonPhone': instance.emergencyPersonPhone,
      'fileId': instance.fileId,
      'validation': documentValidationToJson(instance.validation),
      'id': instance.id,
    };

SecurityFileBase _$SecurityFileBaseFromJson(Map<String, dynamic> json) =>
    SecurityFileBase(
      allergy: json['allergy'],
      asthma: json['asthma'] as bool? ?? false,
      intensiveCareUnit: json['intensiveCareUnit'],
      intensiveCareUnitWhen: json['intensiveCareUnitWhen'],
      ongoingTreatment: json['ongoingTreatment'],
      sicknesses: json['sicknesses'],
      hospitalization: json['hospitalization'],
      surgicalOperation: json['surgicalOperation'],
      trauma: json['trauma'],
      family: json['family'],
      emergencyPersonFirstname: json['emergencyPersonFirstname'],
      emergencyPersonName: json['emergencyPersonName'],
      emergencyPersonPhone: json['emergencyPersonPhone'],
      fileId: json['fileId'],
    );

Map<String, dynamic> _$SecurityFileBaseToJson(SecurityFileBase instance) =>
    <String, dynamic>{
      'allergy': instance.allergy,
      'asthma': instance.asthma,
      'intensiveCareUnit': instance.intensiveCareUnit,
      'intensiveCareUnitWhen': instance.intensiveCareUnitWhen,
      'ongoingTreatment': instance.ongoingTreatment,
      'sicknesses': instance.sicknesses,
      'hospitalization': instance.hospitalization,
      'surgicalOperation': instance.surgicalOperation,
      'trauma': instance.trauma,
      'family': instance.family,
      'emergencyPersonFirstname': instance.emergencyPersonFirstname,
      'emergencyPersonName': instance.emergencyPersonName,
      'emergencyPersonPhone': instance.emergencyPersonPhone,
      'fileId': instance.fileId,
    };

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller(
      userId: json['user_id'] as String? ?? '',
      storeId: json['store_id'] as String? ?? '',
      canBank: json['can_bank'] as bool? ?? false,
      canSeeHistory: json['can_see_history'] as bool? ?? false,
      canCancel: json['can_cancel'] as bool? ?? false,
      canManageSellers: json['can_manage_sellers'] as bool? ?? false,
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'user_id': instance.userId,
      'store_id': instance.storeId,
      'can_bank': instance.canBank,
      'can_see_history': instance.canSeeHistory,
      'can_cancel': instance.canCancel,
      'can_manage_sellers': instance.canManageSellers,
      'user': instance.user.toJson(),
    };

SellerBase _$SellerBaseFromJson(Map<String, dynamic> json) => SellerBase(
      name: json['name'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SellerBaseToJson(SellerBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
      'order': instance.order,
    };

SellerComplete _$SellerCompleteFromJson(Map<String, dynamic> json) =>
    SellerComplete(
      name: json['name'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$SellerCompleteToJson(SellerComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
      'order': instance.order,
      'id': instance.id,
    };

SellerCreation _$SellerCreationFromJson(Map<String, dynamic> json) =>
    SellerCreation(
      userId: json['user_id'] as String? ?? '',
      canBank: json['can_bank'] as bool? ?? false,
      canSeeHistory: json['can_see_history'] as bool? ?? false,
      canCancel: json['can_cancel'] as bool? ?? false,
      canManageSellers: json['can_manage_sellers'] as bool? ?? false,
    );

Map<String, dynamic> _$SellerCreationToJson(SellerCreation instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'can_bank': instance.canBank,
      'can_see_history': instance.canSeeHistory,
      'can_cancel': instance.canCancel,
      'can_manage_sellers': instance.canManageSellers,
    };

SellerEdit _$SellerEditFromJson(Map<String, dynamic> json) => SellerEdit(
      name: json['name'],
      groupId: json['groupId'],
      order: json['order'],
    );

Map<String, dynamic> _$SellerEditToJson(SellerEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groupId': instance.groupId,
      'order': instance.order,
    };

SellerUpdate _$SellerUpdateFromJson(Map<String, dynamic> json) => SellerUpdate(
      canBank: json['canBank'],
      canSeeHistory: json['canSeeHistory'],
      canCancel: json['canCancel'],
      canManageSellers: json['canManageSellers'],
    );

Map<String, dynamic> _$SellerUpdateToJson(SellerUpdate instance) =>
    <String, dynamic>{
      'canBank': instance.canBank,
      'canSeeHistory': instance.canSeeHistory,
      'canCancel': instance.canCancel,
      'canManageSellers': instance.canManageSellers,
    };

SignatureBase _$SignatureBaseFromJson(Map<String, dynamic> json) =>
    SignatureBase(
      signatureType: documentSignatureTypeFromJson(json['signature_type']),
      numericSignatureId: json['numericSignatureId'],
    );

Map<String, dynamic> _$SignatureBaseToJson(SignatureBase instance) =>
    <String, dynamic>{
      'signature_type': documentSignatureTypeToJson(instance.signatureType),
      'numericSignatureId': instance.numericSignatureId,
    };

SignatureComplete _$SignatureCompleteFromJson(Map<String, dynamic> json) =>
    SignatureComplete(
      signatureType: documentSignatureTypeFromJson(json['signature_type']),
      numericSignatureId: json['numericSignatureId'],
      userId: json['user_id'] as String? ?? '',
      documentId: json['document_id'] as String? ?? '',
    );

Map<String, dynamic> _$SignatureCompleteToJson(SignatureComplete instance) =>
    <String, dynamic>{
      'signature_type': documentSignatureTypeToJson(instance.signatureType),
      'numericSignatureId': instance.numericSignatureId,
      'user_id': instance.userId,
      'document_id': instance.documentId,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      status: Status.cdrStatusStatusNullableFromJson(json['status']),
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'status': cdrStatusNullableToJson(instance.status),
    };

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      structureId: json['structure_id'] as String? ?? '',
      walletId: json['wallet_id'] as String? ?? '',
      structure: Structure.fromJson(json['structure'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'structure_id': instance.structureId,
      'wallet_id': instance.walletId,
      'structure': instance.structure.toJson(),
    };

StoreBase _$StoreBaseFromJson(Map<String, dynamic> json) => StoreBase(
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$StoreBaseToJson(StoreBase instance) => <String, dynamic>{
      'name': instance.name,
    };

StoreUpdate _$StoreUpdateFromJson(Map<String, dynamic> json) => StoreUpdate(
      name: json['name'],
    );

Map<String, dynamic> _$StoreUpdateToJson(StoreUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Structure _$StructureFromJson(Map<String, dynamic> json) => Structure(
      name: json['name'] as String? ?? '',
      associationMembershipId: json['associationMembershipId'],
      managerUserId: json['manager_user_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
      managerUser:
          CoreUserSimple.fromJson(json['manager_user'] as Map<String, dynamic>),
      associationMembership: json['associationMembership'],
    );

Map<String, dynamic> _$StructureToJson(Structure instance) => <String, dynamic>{
      'name': instance.name,
      'associationMembershipId': instance.associationMembershipId,
      'manager_user_id': instance.managerUserId,
      'id': instance.id,
      'manager_user': instance.managerUser.toJson(),
      'associationMembership': instance.associationMembership,
    };

StructureBase _$StructureBaseFromJson(Map<String, dynamic> json) =>
    StructureBase(
      name: json['name'] as String? ?? '',
      associationMembershipId: json['associationMembershipId'],
      managerUserId: json['manager_user_id'] as String? ?? '',
    );

Map<String, dynamic> _$StructureBaseToJson(StructureBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'associationMembershipId': instance.associationMembershipId,
      'manager_user_id': instance.managerUserId,
    };

StructureTranfert _$StructureTranfertFromJson(Map<String, dynamic> json) =>
    StructureTranfert(
      newManagerUserId: json['new_manager_user_id'] as String? ?? '',
    );

Map<String, dynamic> _$StructureTranfertToJson(StructureTranfert instance) =>
    <String, dynamic>{
      'new_manager_user_id': instance.newManagerUserId,
    };

StructureUpdate _$StructureUpdateFromJson(Map<String, dynamic> json) =>
    StructureUpdate(
      name: json['name'],
      associationMembershipId: json['associationMembershipId'],
    );

Map<String, dynamic> _$StructureUpdateToJson(StructureUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'associationMembershipId': instance.associationMembershipId,
    };

TOSSignature _$TOSSignatureFromJson(Map<String, dynamic> json) => TOSSignature(
      acceptedTosVersion: (json['accepted_tos_version'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TOSSignatureToJson(TOSSignature instance) =>
    <String, dynamic>{
      'accepted_tos_version': instance.acceptedTosVersion,
    };

TOSSignatureResponse _$TOSSignatureResponseFromJson(
        Map<String, dynamic> json) =>
    TOSSignatureResponse(
      acceptedTosVersion: (json['accepted_tos_version'] as num?)?.toInt() ?? 0,
      latestTosVersion: (json['latest_tos_version'] as num?)?.toInt() ?? 0,
      tosContent: json['tos_content'] as String? ?? '',
      maxTransactionTotal:
          (json['max_transaction_total'] as num?)?.toInt() ?? 0,
      maxWalletBalance: (json['max_wallet_balance'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TOSSignatureResponseToJson(
        TOSSignatureResponse instance) =>
    <String, dynamic>{
      'accepted_tos_version': instance.acceptedTosVersion,
      'latest_tos_version': instance.latestTosVersion,
      'tos_content': instance.tosContent,
      'max_transaction_total': instance.maxTransactionTotal,
      'max_wallet_balance': instance.maxWalletBalance,
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      number: json['number'],
      captain: Participant.fromJson(json['captain'] as Map<String, dynamic>),
      second: json['second'],
      difficulty: json['difficulty'],
      meetingPlace: json['meetingPlace'],
      validationProgress:
          (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
      fileId: json['fileId'],
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'number': instance.number,
      'captain': instance.captain.toJson(),
      'second': instance.second,
      'difficulty': instance.difficulty,
      'meetingPlace': instance.meetingPlace,
      'validation_progress': instance.validationProgress,
      'fileId': instance.fileId,
    };

TeamBase _$TeamBaseFromJson(Map<String, dynamic> json) => TeamBase(
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$TeamBaseToJson(TeamBase instance) => <String, dynamic>{
      'name': instance.name,
    };

TeamPreview _$TeamPreviewFromJson(Map<String, dynamic> json) => TeamPreview(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      number: json['number'],
      captain:
          ParticipantPreview.fromJson(json['captain'] as Map<String, dynamic>),
      second: json['second'],
      difficulty: json['difficulty'],
      meetingPlace: json['meetingPlace'],
      validationProgress:
          (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$TeamPreviewToJson(TeamPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'number': instance.number,
      'captain': instance.captain.toJson(),
      'second': instance.second,
      'difficulty': instance.difficulty,
      'meetingPlace': instance.meetingPlace,
      'validation_progress': instance.validationProgress,
    };

TeamUpdate _$TeamUpdateFromJson(Map<String, dynamic> json) => TeamUpdate(
      name: json['name'],
      number: json['number'],
      difficulty: json['difficulty'],
      meetingPlace: json['meetingPlace'],
    );

Map<String, dynamic> _$TeamUpdateToJson(TeamUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'difficulty': instance.difficulty,
      'meetingPlace': instance.meetingPlace,
    };

TheMovieDB _$TheMovieDBFromJson(Map<String, dynamic> json) => TheMovieDB(
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String? ?? '',
      title: json['title'] as String? ?? '',
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
      tagline: json['tagline'] as String? ?? '',
    );

Map<String, dynamic> _$TheMovieDBToJson(TheMovieDB instance) =>
    <String, dynamic>{
      'genres': instance.genres,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'runtime': instance.runtime,
      'tagline': instance.tagline,
    };

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['id'] as String? ?? '',
      productVariant: ProductVariantComplete.fromJson(
          json['product_variant'] as Map<String, dynamic>),
      user: UserTicket.fromJson(json['user'] as Map<String, dynamic>),
      scanLeft: (json['scan_left'] as num?)?.toInt() ?? 0,
      tags: json['tags'] as String? ?? '',
      expiration: DateTime.parse(json['expiration'] as String),
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'product_variant': instance.productVariant.toJson(),
      'user': instance.user.toJson(),
      'scan_left': instance.scanLeft,
      'tags': instance.tags,
      'expiration': instance.expiration.toIso8601String(),
      'name': instance.name,
    };

TicketComplete _$TicketCompleteFromJson(Map<String, dynamic> json) =>
    TicketComplete(
      packId: json['pack_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      winningPrize: json['winningPrize'],
      id: json['id'] as String? ?? '',
      prize: json['prize'],
      packTicket: PackTicketSimple.fromJson(
          json['pack_ticket'] as Map<String, dynamic>),
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketCompleteToJson(TicketComplete instance) =>
    <String, dynamic>{
      'pack_id': instance.packId,
      'user_id': instance.userId,
      'winningPrize': instance.winningPrize,
      'id': instance.id,
      'prize': instance.prize,
      'pack_ticket': instance.packTicket.toJson(),
      'user': instance.user.toJson(),
    };

TicketScan _$TicketScanFromJson(Map<String, dynamic> json) => TicketScan(
      tag: json['tag'] as String? ?? '',
    );

Map<String, dynamic> _$TicketScanToJson(TicketScan instance) =>
    <String, dynamic>{
      'tag': instance.tag,
    };

TicketSecret _$TicketSecretFromJson(Map<String, dynamic> json) => TicketSecret(
      qrCodeSecret: json['qr_code_secret'] as String? ?? '',
    );

Map<String, dynamic> _$TicketSecretToJson(TicketSecret instance) =>
    <String, dynamic>{
      'qr_code_secret': instance.qrCodeSecret,
    };

TicketSimple _$TicketSimpleFromJson(Map<String, dynamic> json) => TicketSimple(
      packId: json['pack_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      winningPrize: json['winningPrize'],
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$TicketSimpleToJson(TicketSimple instance) =>
    <String, dynamic>{
      'pack_id': instance.packId,
      'user_id': instance.userId,
      'winningPrize': instance.winningPrize,
      'id': instance.id,
    };

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      accessToken: json['access_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? '',
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 0,
      scope: json['scope'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      idToken: json['idToken'],
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'scope': instance.scope,
      'refresh_token': instance.refreshToken,
      'idToken': instance.idToken,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as String? ?? '',
      debitedWalletId: json['debited_wallet_id'] as String? ?? '',
      creditedWalletId: json['credited_wallet_id'] as String? ?? '',
      transactionType: transactionTypeFromJson(json['transaction_type']),
      sellerUserId: json['sellerUserId'],
      total: (json['total'] as num?)?.toInt() ?? 0,
      creation: DateTime.parse(json['creation'] as String),
      status: transactionStatusFromJson(json['status']),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'debited_wallet_id': instance.debitedWalletId,
      'credited_wallet_id': instance.creditedWalletId,
      'transaction_type': transactionTypeToJson(instance.transactionType),
      'sellerUserId': instance.sellerUserId,
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
      'status': transactionStatusToJson(instance.status),
    };

Transfer _$TransferFromJson(Map<String, dynamic> json) => Transfer(
      id: json['id'] as String? ?? '',
      type: transferTypeFromJson(json['type']),
      transferIdentifier: json['transfer_identifier'] as String? ?? '',
      approverUserId: json['approverUserId'],
      walletId: json['wallet_id'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      creation: DateTime.parse(json['creation'] as String),
      confirmed: json['confirmed'] as bool? ?? false,
    );

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'id': instance.id,
      'type': transferTypeToJson(instance.type),
      'transfer_identifier': instance.transferIdentifier,
      'approverUserId': instance.approverUserId,
      'wallet_id': instance.walletId,
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
      'confirmed': instance.confirmed,
    };

TransferInfo _$TransferInfoFromJson(Map<String, dynamic> json) => TransferInfo(
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      redirectUrl: json['redirect_url'] as String? ?? '',
    );

Map<String, dynamic> _$TransferInfoToJson(TransferInfo instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'redirect_url': instance.redirectUrl,
    };

UserMembershipBase _$UserMembershipBaseFromJson(Map<String, dynamic> json) =>
    UserMembershipBase(
      associationMembershipId:
          json['association_membership_id'] as String? ?? '',
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$UserMembershipBaseToJson(UserMembershipBase instance) =>
    <String, dynamic>{
      'association_membership_id': instance.associationMembershipId,
      'start_date': _dateToJson(instance.startDate),
      'end_date': _dateToJson(instance.endDate),
    };

UserMembershipComplete _$UserMembershipCompleteFromJson(
        Map<String, dynamic> json) =>
    UserMembershipComplete(
      associationMembershipId:
          json['association_membership_id'] as String? ?? '',
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserMembershipCompleteToJson(
        UserMembershipComplete instance) =>
    <String, dynamic>{
      'association_membership_id': instance.associationMembershipId,
      'start_date': _dateToJson(instance.startDate),
      'end_date': _dateToJson(instance.endDate),
      'id': instance.id,
      'user_id': instance.userId,
      'user': instance.user.toJson(),
    };

UserMembershipEdit _$UserMembershipEditFromJson(Map<String, dynamic> json) =>
    UserMembershipEdit(
      startDate: json['startDate'],
      endDate: json['endDate'],
    );

Map<String, dynamic> _$UserMembershipEditToJson(UserMembershipEdit instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

UserStore _$UserStoreFromJson(Map<String, dynamic> json) => UserStore(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      structureId: json['structure_id'] as String? ?? '',
      walletId: json['wallet_id'] as String? ?? '',
      structure: Structure.fromJson(json['structure'] as Map<String, dynamic>),
      canBank: json['can_bank'] as bool? ?? false,
      canSeeHistory: json['can_see_history'] as bool? ?? false,
      canCancel: json['can_cancel'] as bool? ?? false,
      canManageSellers: json['can_manage_sellers'] as bool? ?? false,
    );

Map<String, dynamic> _$UserStoreToJson(UserStore instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'structure_id': instance.structureId,
      'wallet_id': instance.walletId,
      'structure': instance.structure.toJson(),
      'can_bank': instance.canBank,
      'can_see_history': instance.canSeeHistory,
      'can_cancel': instance.canCancel,
      'can_manage_sellers': instance.canManageSellers,
    };

UserTicket _$UserTicketFromJson(Map<String, dynamic> json) => UserTicket(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'],
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      promo: json['promo'],
      floor: json['floor'],
      createdOn: json['createdOn'],
    );

Map<String, dynamic> _$UserTicketToJson(UserTicket instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
      'promo': instance.promo,
      'floor': instance.floor,
      'createdOn': instance.createdOn,
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
      count: (json['count'] as num?)?.toInt() ?? 0,
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

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['id'] as String? ?? '',
      type: walletTypeFromJson(json['type']),
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      store: json['store'],
      user: json['user'],
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'type': walletTypeToJson(instance.type),
      'balance': instance.balance,
      'store': instance.store,
      'user': instance.user,
    };

WalletDevice _$WalletDeviceFromJson(Map<String, dynamic> json) => WalletDevice(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      walletId: json['wallet_id'] as String? ?? '',
      creation: DateTime.parse(json['creation'] as String),
      status: walletDeviceStatusFromJson(json['status']),
    );

Map<String, dynamic> _$WalletDeviceToJson(WalletDevice instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'wallet_id': instance.walletId,
      'creation': instance.creation.toIso8601String(),
      'status': walletDeviceStatusToJson(instance.status),
    };

WalletDeviceCreation _$WalletDeviceCreationFromJson(
        Map<String, dynamic> json) =>
    WalletDeviceCreation(
      name: json['name'] as String? ?? '',
      ed25519PublicKey: json['ed25519_public_key'] as String? ?? '',
    );

Map<String, dynamic> _$WalletDeviceCreationToJson(
        WalletDeviceCreation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ed25519_public_key': instance.ed25519PublicKey,
    };

WalletInfo _$WalletInfoFromJson(Map<String, dynamic> json) => WalletInfo(
      id: json['id'] as String? ?? '',
      type: walletTypeFromJson(json['type']),
      ownerName: json['ownerName'],
    );

Map<String, dynamic> _$WalletInfoToJson(WalletInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': walletTypeToJson(instance.type),
      'ownerName': instance.ownerName,
    };

AppCoreMembershipsSchemasMembershipsMembershipBase
    _$AppCoreMembershipsSchemasMembershipsMembershipBaseFromJson(
            Map<String, dynamic> json) =>
        AppCoreMembershipsSchemasMembershipsMembershipBase(
          name: json['name'] as String? ?? '',
          groupId: json['group_id'] as String? ?? '',
        );

Map<String, dynamic> _$AppCoreMembershipsSchemasMembershipsMembershipBaseToJson(
        AppCoreMembershipsSchemasMembershipsMembershipBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
    };

AppModulesAmapSchemasAmapProductComplete
    _$AppModulesAmapSchemasAmapProductCompleteFromJson(
            Map<String, dynamic> json) =>
        AppModulesAmapSchemasAmapProductComplete(
          name: json['name'] as String? ?? '',
          price: (json['price'] as num?)?.toDouble() ?? 0.0,
          category: json['category'] as String? ?? '',
          id: json['id'] as String? ?? '',
        );

Map<String, dynamic> _$AppModulesAmapSchemasAmapProductCompleteToJson(
        AppModulesAmapSchemasAmapProductComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'id': instance.id,
    };

AppModulesAmapSchemasAmapProductEdit
    _$AppModulesAmapSchemasAmapProductEditFromJson(Map<String, dynamic> json) =>
        AppModulesAmapSchemasAmapProductEdit(
          category: json['category'],
          name: json['name'],
          price: json['price'],
        );

Map<String, dynamic> _$AppModulesAmapSchemasAmapProductEditToJson(
        AppModulesAmapSchemasAmapProductEdit instance) =>
    <String, dynamic>{
      'category': instance.category,
      'name': instance.name,
      'price': instance.price,
    };

AppModulesCampaignSchemasCampaignResult
    _$AppModulesCampaignSchemasCampaignResultFromJson(
            Map<String, dynamic> json) =>
        AppModulesCampaignSchemasCampaignResult(
          listId: json['list_id'] as String? ?? '',
          count: (json['count'] as num?)?.toInt() ?? 0,
        );

Map<String, dynamic> _$AppModulesCampaignSchemasCampaignResultToJson(
        AppModulesCampaignSchemasCampaignResult instance) =>
    <String, dynamic>{
      'list_id': instance.listId,
      'count': instance.count,
    };

AppModulesCdrSchemasCdrProductComplete
    _$AppModulesCdrSchemasCdrProductCompleteFromJson(
            Map<String, dynamic> json) =>
        AppModulesCdrSchemasCdrProductComplete(
          nameFr: json['name_fr'] as String? ?? '',
          nameEn: json['nameEn'],
          descriptionFr: json['descriptionFr'],
          descriptionEn: json['descriptionEn'],
          availableOnline: json['available_online'] as bool? ?? false,
          id: json['id'] as String? ?? '',
          sellerId: json['seller_id'] as String? ?? '',
          variants: (json['variants'] as List<dynamic>?)
                  ?.map((e) => ProductVariantComplete.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
          relatedMembership: json['relatedMembership'],
          productConstraints: (json['product_constraints'] as List<dynamic>?)
                  ?.map((e) => ProductCompleteNoConstraint.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
          documentConstraints: (json['document_constraints'] as List<dynamic>?)
                  ?.map((e) =>
                      DocumentComplete.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
          tickets: (json['tickets'] as List<dynamic>?)
                  ?.map((e) => GenerateTicketComplete.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductCompleteToJson(
        AppModulesCdrSchemasCdrProductComplete instance) =>
    <String, dynamic>{
      'name_fr': instance.nameFr,
      'nameEn': instance.nameEn,
      'descriptionFr': instance.descriptionFr,
      'descriptionEn': instance.descriptionEn,
      'available_online': instance.availableOnline,
      'id': instance.id,
      'seller_id': instance.sellerId,
      'variants': instance.variants?.map((e) => e.toJson()).toList(),
      'relatedMembership': instance.relatedMembership,
      'product_constraints':
          instance.productConstraints?.map((e) => e.toJson()).toList(),
      'document_constraints':
          instance.documentConstraints?.map((e) => e.toJson()).toList(),
      'tickets': instance.tickets?.map((e) => e.toJson()).toList(),
    };

AppModulesCdrSchemasCdrProductEdit _$AppModulesCdrSchemasCdrProductEditFromJson(
        Map<String, dynamic> json) =>
    AppModulesCdrSchemasCdrProductEdit(
      nameFr: json['nameFr'],
      nameEn: json['nameEn'],
      descriptionFr: json['descriptionFr'],
      descriptionEn: json['descriptionEn'],
      description: json['description'],
      availableOnline: json['availableOnline'],
      relatedMembership: json['relatedMembership'],
      productConstraints: json['productConstraints'],
      documentConstraints: json['documentConstraints'],
    );

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductEditToJson(
        AppModulesCdrSchemasCdrProductEdit instance) =>
    <String, dynamic>{
      'nameFr': instance.nameFr,
      'nameEn': instance.nameEn,
      'descriptionFr': instance.descriptionFr,
      'descriptionEn': instance.descriptionEn,
      'description': instance.description,
      'availableOnline': instance.availableOnline,
      'relatedMembership': instance.relatedMembership,
      'productConstraints': instance.productConstraints,
      'documentConstraints': instance.documentConstraints,
    };

AppModulesPhonebookSchemasPhonebookMembershipBase
    _$AppModulesPhonebookSchemasPhonebookMembershipBaseFromJson(
            Map<String, dynamic> json) =>
        AppModulesPhonebookSchemasPhonebookMembershipBase(
          userId: json['user_id'] as String? ?? '',
          associationId: json['association_id'] as String? ?? '',
          mandateYear: (json['mandate_year'] as num?)?.toInt() ?? 0,
          roleName: json['role_name'] as String? ?? '',
          roleTags: json['roleTags'],
          memberOrder: (json['member_order'] as num?)?.toInt() ?? 0,
        );

Map<String, dynamic> _$AppModulesPhonebookSchemasPhonebookMembershipBaseToJson(
        AppModulesPhonebookSchemasPhonebookMembershipBase instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'association_id': instance.associationId,
      'mandate_year': instance.mandateYear,
      'role_name': instance.roleName,
      'roleTags': instance.roleTags,
      'member_order': instance.memberOrder,
    };

AppTypesStandardResponsesResult _$AppTypesStandardResponsesResultFromJson(
        Map<String, dynamic> json) =>
    AppTypesStandardResponsesResult(
      success: json['success'] as bool? ?? true,
    );

Map<String, dynamic> _$AppTypesStandardResponsesResultToJson(
        AppTypesStandardResponsesResult instance) =>
    <String, dynamic>{
      'success': instance.success,
    };
