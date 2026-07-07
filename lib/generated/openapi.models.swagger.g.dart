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
  postToFeed: json['post_to_feed'] as bool? ?? false,
  notification: json['notification'] as bool? ?? false,
);

Map<String, dynamic> _$AdvertBaseToJson(AdvertBase instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'advertiser_id': instance.advertiserId,
      'post_to_feed': instance.postToFeed,
      'notification': instance.notification,
    };

AdvertComplete _$AdvertCompleteFromJson(Map<String, dynamic> json) =>
    AdvertComplete(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      advertiserId: json['advertiser_id'] as String? ?? '',
      postToFeed: json['post_to_feed'] as bool? ?? false,
      notification: json['notification'] as bool? ?? false,
      id: json['id'] as String? ?? '',
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$AdvertCompleteToJson(AdvertComplete instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'advertiser_id': instance.advertiserId,
      'post_to_feed': instance.postToFeed,
      'notification': instance.notification,
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
    };

AdvertUpdate _$AdvertUpdateFromJson(Map<String, dynamic> json) => AdvertUpdate(
  title: json['title'] as String?,
  content: json['content'] as String?,
);

Map<String, dynamic> _$AdvertUpdateToJson(AdvertUpdate instance) =>
    <String, dynamic>{'title': instance.title, 'content': instance.content};

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
  questionId: json['question_id'] as String? ?? '',
  answer: json['answer'],
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
  'question_id': instance.questionId,
  'answer': instance.answer,
  'id': instance.id,
};

AnswerBoolean _$AnswerBooleanFromJson(Map<String, dynamic> json) =>
    AnswerBoolean(
      answerType: json['answer_type'] as String? ?? '',
      answer: json['answer'] as bool? ?? false,
    );

Map<String, dynamic> _$AnswerBooleanToJson(AnswerBoolean instance) =>
    <String, dynamic>{
      'answer_type': instance.answerType,
      'answer': instance.answer,
    };

AnswerCreate _$AnswerCreateFromJson(Map<String, dynamic> json) => AnswerCreate(
  questionId: json['question_id'] as String? ?? '',
  answer: json['answer'],
);

Map<String, dynamic> _$AnswerCreateToJson(AnswerCreate instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'answer': instance.answer,
    };

AnswerNumber _$AnswerNumberFromJson(Map<String, dynamic> json) => AnswerNumber(
  answerType: json['answer_type'] as String? ?? '',
  answer: (json['answer'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AnswerNumberToJson(AnswerNumber instance) =>
    <String, dynamic>{
      'answer_type': instance.answerType,
      'answer': instance.answer,
    };

AnswerText _$AnswerTextFromJson(Map<String, dynamic> json) => AnswerText(
  answerType: json['answer_type'] as String? ?? '',
  answer: json['answer'] as String? ?? '',
);

Map<String, dynamic> _$AnswerTextToJson(AnswerText instance) =>
    <String, dynamic>{
      'answer_type': instance.answerType,
      'answer': instance.answer,
    };

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
  name: json['name'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  nickname: json['nickname'] as String?,
  id: json['id'] as String? ?? '',
  accountType: accountTypeFromJson(json['account_type']),
  schoolId: json['school_id'] as String? ?? '',
  email: json['email'] as String? ?? '',
  promo: (json['promo'] as num?)?.toInt(),
  phone: json['phone'] as String?,
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

Association _$AssociationFromJson(Map<String, dynamic> json) => Association(
  name: json['name'] as String? ?? '',
  groupId: json['group_id'] as String? ?? '',
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$AssociationToJson(Association instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
      'id': instance.id,
    };

AssociationComplete _$AssociationCompleteFromJson(Map<String, dynamic> json) =>
    AssociationComplete(
      name: json['name'] as String? ?? '',
      groupementId: json['groupement_id'] as String? ?? '',
      mandateYear: (json['mandate_year'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      associatedGroups:
          (json['associated_groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      deactivated: json['deactivated'] as bool? ?? false,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$AssociationCompleteToJson(
  AssociationComplete instance,
) => <String, dynamic>{
  'name': instance.name,
  'groupement_id': instance.groupementId,
  'mandate_year': instance.mandateYear,
  'description': instance.description,
  'associated_groups': instance.associatedGroups,
  'deactivated': instance.deactivated,
  'id': instance.id,
};

AssociationEdit _$AssociationEditFromJson(Map<String, dynamic> json) =>
    AssociationEdit(
      name: json['name'] as String?,
      groupementId: json['groupement_id'] as String?,
      description: json['description'] as String?,
      mandateYear: (json['mandate_year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssociationEditToJson(AssociationEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groupement_id': instance.groupementId,
      'description': instance.description,
      'mandate_year': instance.mandateYear,
    };

AssociationGroupement _$AssociationGroupementFromJson(
  Map<String, dynamic> json,
) => AssociationGroupement(
  name: json['name'] as String? ?? '',
  managerGroupId: json['manager_group_id'] as String? ?? '',
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$AssociationGroupementToJson(
  AssociationGroupement instance,
) => <String, dynamic>{
  'name': instance.name,
  'manager_group_id': instance.managerGroupId,
  'id': instance.id,
};

AssociationGroupementBase _$AssociationGroupementBaseFromJson(
  Map<String, dynamic> json,
) => AssociationGroupementBase(
  name: json['name'] as String? ?? '',
  managerGroupId: json['manager_group_id'] as String? ?? '',
);

Map<String, dynamic> _$AssociationGroupementBaseToJson(
  AssociationGroupementBase instance,
) => <String, dynamic>{
  'name': instance.name,
  'manager_group_id': instance.managerGroupId,
};

AssociationGroupsEdit _$AssociationGroupsEditFromJson(
  Map<String, dynamic> json,
) => AssociationGroupsEdit(
  associatedGroups:
      (json['associated_groups'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
);

Map<String, dynamic> _$AssociationGroupsEditToJson(
  AssociationGroupsEdit instance,
) => <String, dynamic>{'associated_groups': instance.associatedGroups};

AssociationUpdate _$AssociationUpdateFromJson(Map<String, dynamic> json) =>
    AssociationUpdate(
      name: json['name'] as String?,
      groupId: json['group_id'] as String?,
    );

Map<String, dynamic> _$AssociationUpdateToJson(AssociationUpdate instance) =>
    <String, dynamic>{'name': instance.name, 'group_id': instance.groupId};

BatchPurchase _$BatchPurchaseFromJson(Map<String, dynamic> json) =>
    BatchPurchase(
      userEmails:
          (json['user_emails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      productVariantId: json['product_variant_id'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BatchPurchaseToJson(BatchPurchase instance) =>
    <String, dynamic>{
      'user_emails': instance.userEmails,
      'product_variant_id': instance.productVariantId,
      'quantity': instance.quantity,
    };

BatchResult _$BatchResultFromJson(Map<String, dynamic> json) =>
    BatchResult(failed: json['failed'] as Map<String, dynamic>);

Map<String, dynamic> _$BatchResultToJson(BatchResult instance) =>
    <String, dynamic>{'failed': instance.failed};

BatchValidation _$BatchValidationFromJson(Map<String, dynamic> json) =>
    BatchValidation(
      userEmails:
          (json['user_emails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      productVariantId: json['product_variant_id'] as String? ?? '',
      validated: json['validated'] as bool? ?? false,
    );

Map<String, dynamic> _$BatchValidationToJson(BatchValidation instance) =>
    <String, dynamic>{
      'user_emails': instance.userEmails,
      'product_variant_id': instance.productVariantId,
      'validated': instance.validated,
    };

BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost
_$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostFromJson(
  Map<String, dynamic> json,
) => BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost(
  clientId: json['client_id'] as String? ?? '',
  redirectUri: json['redirect_uri'] as String?,
  responseType: json['response_type'] as String? ?? '',
  scope: json['scope'] as String?,
  state: json['state'] as String?,
  nonce: json['nonce'] as String?,
  codeChallenge: json['code_challenge'] as String?,
  codeChallengeMethod: json['code_challenge_method'] as String?,
  email: json['email'] as String? ?? '',
  password: json['password'] as String? ?? '',
);

Map<String, dynamic>
_$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostToJson(
  BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost instance,
) => <String, dynamic>{
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
  Map<String, dynamic> json,
) => BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic>
_$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostToJson(
  BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateAssociationLogoAssociationsAssociationIdLogoPost
_$BodyCreateAssociationLogoAssociationsAssociationIdLogoPostFromJson(
  Map<String, dynamic> json,
) => BodyCreateAssociationLogoAssociationsAssociationIdLogoPost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic>
_$BodyCreateAssociationLogoAssociationsAssociationIdLogoPostToJson(
  BodyCreateAssociationLogoAssociationsAssociationIdLogoPost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost
_$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostFromJson(
  Map<String, dynamic> json,
) => BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic>
_$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostToJson(
  BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost
  instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateCampaignsLogoCampaignListsListIdLogoPost
_$BodyCreateCampaignsLogoCampaignListsListIdLogoPostFromJson(
  Map<String, dynamic> json,
) => BodyCreateCampaignsLogoCampaignListsListIdLogoPost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic> _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostToJson(
  BodyCreateCampaignsLogoCampaignListsListIdLogoPost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost
_$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostFromJson(
  Map<String, dynamic> json,
) => BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic>
_$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostToJson(
  BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost
_$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostFromJson(
  Map<String, dynamic> json,
) => BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic>
_$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostToJson(
  BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost
_$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostFromJson(
  Map<String, dynamic> json,
) => BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic>
_$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostToJson(
  BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateEventImageCalendarEventsEventIdImagePost
_$BodyCreateEventImageCalendarEventsEventIdImagePostFromJson(
  Map<String, dynamic> json,
) => BodyCreateEventImageCalendarEventsEventIdImagePost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic> _$BodyCreateEventImageCalendarEventsEventIdImagePostToJson(
  BodyCreateEventImageCalendarEventsEventIdImagePost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateGroupLogoGroupsGroupIdLogoPost
_$BodyCreateGroupLogoGroupsGroupIdLogoPostFromJson(Map<String, dynamic> json) =>
    BodyCreateGroupLogoGroupsGroupIdLogoPost(
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$BodyCreateGroupLogoGroupsGroupIdLogoPostToJson(
  BodyCreateGroupLogoGroupsGroupIdLogoPost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreatePaperPdfAndCoverPhPaperIdPdfPost
_$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostFromJson(
  Map<String, dynamic> json,
) => BodyCreatePaperPdfAndCoverPhPaperIdPdfPost(
  pdf: json['pdf'] as String? ?? '',
);

Map<String, dynamic> _$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostToJson(
  BodyCreatePaperPdfAndCoverPhPaperIdPdfPost instance,
) => <String, dynamic>{'pdf': instance.pdf};

BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost
_$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostFromJson(
  Map<String, dynamic> json,
) => BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost(
  image: json['image'] as String? ?? '',
);

Map<String, dynamic>
_$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostToJson(
  BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost instance,
) => <String, dynamic>{'image': instance.image};

BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost
_$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostFromJson(
  Map<String, dynamic> json,
) =>
    BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost(
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic>
_$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostToJson(
  BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost
  instance,
) => <String, dynamic>{'image': instance.image};

BodyIntrospectAuthIntrospectPost _$BodyIntrospectAuthIntrospectPostFromJson(
  Map<String, dynamic> json,
) => BodyIntrospectAuthIntrospectPost(
  token: json['token'] as String? ?? '',
  tokenTypeHint: json['token_type_hint'] as String?,
  clientId: json['client_id'] as String?,
  clientSecret: json['client_secret'] as String?,
);

Map<String, dynamic> _$BodyIntrospectAuthIntrospectPostToJson(
  BodyIntrospectAuthIntrospectPost instance,
) => <String, dynamic>{
  'token': instance.token,
  'token_type_hint': instance.tokenTypeHint,
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
};

BodyLoginForAccessTokenAuthSimpleTokenPost
_$BodyLoginForAccessTokenAuthSimpleTokenPostFromJson(
  Map<String, dynamic> json,
) => BodyLoginForAccessTokenAuthSimpleTokenPost(
  grantType: json['grant_type'] as String?,
  username: json['username'] as String? ?? '',
  password: json['password'] as String? ?? '',
  scope: json['scope'] as String? ?? '',
  clientId: json['client_id'] as String?,
  clientSecret: json['client_secret'] as String?,
);

Map<String, dynamic> _$BodyLoginForAccessTokenAuthSimpleTokenPostToJson(
  BodyLoginForAccessTokenAuthSimpleTokenPost instance,
) => <String, dynamic>{
  'grant_type': instance.grantType,
  'username': instance.username,
  'password': instance.password,
  'scope': instance.scope,
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
};

BodyPostAuthorizePageAuthAuthorizePost
_$BodyPostAuthorizePageAuthAuthorizePostFromJson(Map<String, dynamic> json) =>
    BodyPostAuthorizePageAuthAuthorizePost(
      responseType: json['response_type'] as String? ?? '',
      clientId: json['client_id'] as String? ?? '',
      redirectUri: json['redirect_uri'] as String? ?? '',
      scope: json['scope'] as String?,
      state: json['state'] as String?,
      nonce: json['nonce'] as String?,
      codeChallenge: json['code_challenge'] as String?,
      codeChallengeMethod: json['code_challenge_method'] as String?,
    );

Map<String, dynamic> _$BodyPostAuthorizePageAuthAuthorizePostToJson(
  BodyPostAuthorizePageAuthAuthorizePost instance,
) => <String, dynamic>{
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
  Map<String, dynamic> json,
) => BodyRecoverUserUsersRecoverPost(email: json['email'] as String? ?? '');

Map<String, dynamic> _$BodyRecoverUserUsersRecoverPostToJson(
  BodyRecoverUserUsersRecoverPost instance,
) => <String, dynamic>{'email': instance.email};

BodyRegisterFirebaseDeviceNotificationDevicesPost
_$BodyRegisterFirebaseDeviceNotificationDevicesPostFromJson(
  Map<String, dynamic> json,
) => BodyRegisterFirebaseDeviceNotificationDevicesPost(
  firebaseToken: json['firebase_token'] as String? ?? '',
);

Map<String, dynamic> _$BodyRegisterFirebaseDeviceNotificationDevicesPostToJson(
  BodyRegisterFirebaseDeviceNotificationDevicesPost instance,
) => <String, dynamic>{'firebase_token': instance.firebaseToken};

BodyTokenAuthTokenPost _$BodyTokenAuthTokenPostFromJson(
  Map<String, dynamic> json,
) => BodyTokenAuthTokenPost(
  refreshToken: json['refresh_token'] as String?,
  grantType: json['grant_type'] as String? ?? '',
  code: json['code'] as String?,
  redirectUri: json['redirect_uri'] as String?,
  clientId: json['client_id'] as String?,
  clientSecret: json['client_secret'] as String?,
  codeVerifier: json['code_verifier'] as String?,
);

Map<String, dynamic> _$BodyTokenAuthTokenPostToJson(
  BodyTokenAuthTokenPost instance,
) => <String, dynamic>{
  'refresh_token': instance.refreshToken,
  'grant_type': instance.grantType,
  'code': instance.code,
  'redirect_uri': instance.redirectUri,
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
  'code_verifier': instance.codeVerifier,
};

BodyUploadDocumentRaidDocumentDocumentTypePost
_$BodyUploadDocumentRaidDocumentDocumentTypePostFromJson(
  Map<String, dynamic> json,
) => BodyUploadDocumentRaidDocumentDocumentTypePost(
  file: json['file'] as String? ?? '',
);

Map<String, dynamic> _$BodyUploadDocumentRaidDocumentDocumentTypePostToJson(
  BodyUploadDocumentRaidDocumentDocumentTypePost instance,
) => <String, dynamic>{'file': instance.file};

BodyUploadParticipantCertificateCompetitionParticipantsSportsSportIdCertificatePost
_$BodyUploadParticipantCertificateCompetitionParticipantsSportsSportIdCertificatePostFromJson(
  Map<String, dynamic> json,
) =>
    BodyUploadParticipantCertificateCompetitionParticipantsSportsSportIdCertificatePost(
      certificate: json['certificate'] as String? ?? '',
    );

Map<String, dynamic>
_$BodyUploadParticipantCertificateCompetitionParticipantsSportsSportIdCertificatePostToJson(
  BodyUploadParticipantCertificateCompetitionParticipantsSportsSportIdCertificatePost
  instance,
) => <String, dynamic>{'certificate': instance.certificate};

BookingBase _$BookingBaseFromJson(Map<String, dynamic> json) => BookingBase(
  reason: json['reason'] as String? ?? '',
  start: DateTime.parse(json['start'] as String),
  end: DateTime.parse(json['end'] as String),
  creation: DateTime.parse(json['creation'] as String),
  note: json['note'] as String?,
  roomId: json['room_id'] as String? ?? '',
  key: json['key'] as bool? ?? false,
  recurrenceRule: json['recurrence_rule'] as String?,
  entity: json['entity'] as String?,
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
      'recurrence_rule': instance.recurrenceRule,
      'entity': instance.entity,
    };

BookingEdit _$BookingEditFromJson(Map<String, dynamic> json) => BookingEdit(
  reason: json['reason'] as String?,
  start: json['start'] == null ? null : DateTime.parse(json['start'] as String),
  end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  note: json['note'] as String?,
  roomId: json['room_id'] as String?,
  key: json['key'] as bool?,
  recurrenceRule: json['recurrence_rule'] as String?,
  entity: json['entity'] as String?,
);

Map<String, dynamic> _$BookingEditToJson(BookingEdit instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'note': instance.note,
      'room_id': instance.roomId,
      'key': instance.key,
      'recurrence_rule': instance.recurrenceRule,
      'entity': instance.entity,
    };

BookingReturn _$BookingReturnFromJson(Map<String, dynamic> json) =>
    BookingReturn(
      reason: json['reason'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      creation: DateTime.parse(json['creation'] as String),
      note: json['note'] as String?,
      roomId: json['room_id'] as String? ?? '',
      key: json['key'] as bool? ?? false,
      recurrenceRule: json['recurrence_rule'] as String?,
      entity: json['entity'] as String?,
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
      'recurrence_rule': instance.recurrenceRule,
      'entity': instance.entity,
      'id': instance.id,
      'decision': decisionToJson(instance.decision),
      'applicant_id': instance.applicantId,
      'room': instance.room.toJson(),
    };

BookingReturnApplicant _$BookingReturnApplicantFromJson(
  Map<String, dynamic> json,
) => BookingReturnApplicant(
  reason: json['reason'] as String? ?? '',
  start: DateTime.parse(json['start'] as String),
  end: DateTime.parse(json['end'] as String),
  creation: DateTime.parse(json['creation'] as String),
  note: json['note'] as String?,
  roomId: json['room_id'] as String? ?? '',
  key: json['key'] as bool? ?? false,
  recurrenceRule: json['recurrence_rule'] as String?,
  entity: json['entity'] as String?,
  id: json['id'] as String? ?? '',
  decision: decisionFromJson(json['decision']),
  applicantId: json['applicant_id'] as String? ?? '',
  room: RoomComplete.fromJson(json['room'] as Map<String, dynamic>),
  applicant: Applicant.fromJson(json['applicant'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingReturnApplicantToJson(
  BookingReturnApplicant instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'start': instance.start.toIso8601String(),
  'end': instance.end.toIso8601String(),
  'creation': instance.creation.toIso8601String(),
  'note': instance.note,
  'room_id': instance.roomId,
  'key': instance.key,
  'recurrence_rule': instance.recurrenceRule,
  'entity': instance.entity,
  'id': instance.id,
  'decision': decisionToJson(instance.decision),
  'applicant_id': instance.applicantId,
  'room': instance.room.toJson(),
  'applicant': instance.applicant.toJson(),
};

BookingReturnSimpleApplicant _$BookingReturnSimpleApplicantFromJson(
  Map<String, dynamic> json,
) => BookingReturnSimpleApplicant(
  reason: json['reason'] as String? ?? '',
  start: DateTime.parse(json['start'] as String),
  end: DateTime.parse(json['end'] as String),
  creation: DateTime.parse(json['creation'] as String),
  note: json['note'] as String?,
  roomId: json['room_id'] as String? ?? '',
  key: json['key'] as bool? ?? false,
  recurrenceRule: json['recurrence_rule'] as String?,
  entity: json['entity'] as String?,
  id: json['id'] as String? ?? '',
  decision: decisionFromJson(json['decision']),
  applicantId: json['applicant_id'] as String? ?? '',
  room: RoomComplete.fromJson(json['room'] as Map<String, dynamic>),
  applicant: CoreUserSimple.fromJson(json['applicant'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingReturnSimpleApplicantToJson(
  BookingReturnSimpleApplicant instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'start': instance.start.toIso8601String(),
  'end': instance.end.toIso8601String(),
  'creation': instance.creation.toIso8601String(),
  'note': instance.note,
  'room_id': instance.roomId,
  'key': instance.key,
  'recurrence_rule': instance.recurrenceRule,
  'entity': instance.entity,
  'id': instance.id,
  'decision': decisionToJson(instance.decision),
  'applicant_id': instance.applicantId,
  'room': instance.room.toJson(),
  'applicant': instance.applicant.toJson(),
};

CashEdit _$CashEditFromJson(Map<String, dynamic> json) =>
    CashEdit(balance: (json['balance'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$CashEditToJson(CashEdit instance) => <String, dynamic>{
  'balance': instance.balance,
};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String? ?? '',
  eventId: json['event_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  price: (json['price'] as num?)?.toInt() ?? 0,
  requiredMembership: json['required_membership'] as String?,
  disabled: json['disabled'] as bool? ?? false,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'event_id': instance.eventId,
  'name': instance.name,
  'price': instance.price,
  'required_membership': instance.requiredMembership,
  'disabled': instance.disabled,
};

CategoryAdmin _$CategoryAdminFromJson(Map<String, dynamic> json) =>
    CategoryAdmin(
      id: json['id'] as String? ?? '',
      eventId: json['event_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      requiredMembership: json['required_membership'] as String?,
      disabled: json['disabled'] as bool? ?? false,
      quota: (json['quota'] as num?)?.toInt(),
      ticketsInCheckout: (json['tickets_in_checkout'] as num?)?.toInt() ?? 0,
      ticketsSold: (json['tickets_sold'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CategoryAdminToJson(CategoryAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'price': instance.price,
      'required_membership': instance.requiredMembership,
      'disabled': instance.disabled,
      'quota': instance.quota,
      'tickets_in_checkout': instance.ticketsInCheckout,
      'tickets_sold': instance.ticketsSold,
    };

CategoryComplete _$CategoryCompleteFromJson(Map<String, dynamic> json) =>
    CategoryComplete(
      id: json['id'] as String? ?? '',
      eventId: json['event_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      requiredMembership: json['required_membership'] as String?,
      disabled: json['disabled'] as bool? ?? false,
      quota: (json['quota'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryCompleteToJson(CategoryComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'price': instance.price,
      'required_membership': instance.requiredMembership,
      'disabled': instance.disabled,
      'quota': instance.quota,
    };

CategoryCreate _$CategoryCreateFromJson(Map<String, dynamic> json) =>
    CategoryCreate(
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      quota: (json['quota'] as num?)?.toInt(),
      requiredMembership: json['required_membership'] as String?,
    );

Map<String, dynamic> _$CategoryCreateToJson(CategoryCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quota': instance.quota,
      'required_membership': instance.requiredMembership,
    };

CategoryPublic _$CategoryPublicFromJson(Map<String, dynamic> json) =>
    CategoryPublic(
      id: json['id'] as String? ?? '',
      eventId: json['event_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      requiredMembership: json['required_membership'] as String?,
      disabled: json['disabled'] as bool? ?? false,
      soldOut: json['sold_out'] as bool? ?? false,
    );

Map<String, dynamic> _$CategoryPublicToJson(CategoryPublic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'price': instance.price,
      'required_membership': instance.requiredMembership,
      'disabled': instance.disabled,
      'sold_out': instance.soldOut,
    };

CategoryUpdate _$CategoryUpdateFromJson(Map<String, dynamic> json) =>
    CategoryUpdate(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      quota: (json['quota'] as num?)?.toInt(),
      requiredMembership: json['required_membership'] as String?,
      disabled: json['disabled'] as bool?,
    );

Map<String, dynamic> _$CategoryUpdateToJson(CategoryUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quota': instance.quota,
      'required_membership': instance.requiredMembership,
      'disabled': instance.disabled,
    };

CdrUser _$CdrUserFromJson(Map<String, dynamic> json) => CdrUser(
  name: json['name'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  nickname: json['nickname'] as String?,
  id: json['id'] as String? ?? '',
  accountType: accountTypeFromJson(json['account_type']),
  schoolId: json['school_id'] as String? ?? '',
  curriculum: json['curriculum'] == null
      ? null
      : CurriculumComplete.fromJson(json['curriculum'] as Map<String, dynamic>),
  promo: (json['promo'] as num?)?.toInt(),
  email: json['email'] as String? ?? '',
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  phone: json['phone'] as String?,
  floor: json['floor'] as String?,
);

Map<String, dynamic> _$CdrUserToJson(CdrUser instance) => <String, dynamic>{
  'name': instance.name,
  'firstname': instance.firstname,
  'nickname': instance.nickname,
  'id': instance.id,
  'account_type': accountTypeToJson(instance.accountType),
  'school_id': instance.schoolId,
  'curriculum': instance.curriculum?.toJson(),
  'promo': instance.promo,
  'email': instance.email,
  'birthday': _dateToJson(instance.birthday),
  'phone': instance.phone,
  'floor': instance.floor,
};

CdrUserPreview _$CdrUserPreviewFromJson(Map<String, dynamic> json) =>
    CdrUserPreview(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String?,
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      curriculum: json['curriculum'] == null
          ? null
          : CurriculumComplete.fromJson(
              json['curriculum'] as Map<String, dynamic>,
            ),
      promo: (json['promo'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CdrUserPreviewToJson(CdrUserPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'nickname': instance.nickname,
      'id': instance.id,
      'account_type': accountTypeToJson(instance.accountType),
      'school_id': instance.schoolId,
      'curriculum': instance.curriculum?.toJson(),
      'promo': instance.promo,
    };

CdrUserUpdate _$CdrUserUpdateFromJson(Map<String, dynamic> json) =>
    CdrUserUpdate(
      promo: (json['promo'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String?,
      floor: json['floor'] as String?,
    );

Map<String, dynamic> _$CdrUserUpdateToJson(CdrUserUpdate instance) =>
    <String, dynamic>{
      'promo': instance.promo,
      'nickname': instance.nickname,
      'email': instance.email,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'floor': instance.floor,
    };

CdrYear _$CdrYearFromJson(Map<String, dynamic> json) =>
    CdrYear(year: (json['year'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$CdrYearToJson(CdrYear instance) => <String, dynamic>{
  'year': instance.year,
};

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => ChangePasswordRequest(
  email: json['email'] as String? ?? '',
  oldPassword: json['old_password'] as String? ?? '',
  newPassword: json['new_password'] as String? ?? '',
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  ChangePasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'old_password': instance.oldPassword,
  'new_password': instance.newPassword,
};

Checkout _$CheckoutFromJson(Map<String, dynamic> json) => Checkout(
  categoryId: json['category_id'] as String? ?? '',
  sessionId: json['session_id'] as String? ?? '',
  answers:
      (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerCreate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  mypaymentRequestMethod: requestTypeFromJson(json['mypayment_request_method']),
  mypaymentTransferRedirectUrl:
      json['mypayment_transfer_redirect_url'] as String? ?? '',
);

Map<String, dynamic> _$CheckoutToJson(Checkout instance) => <String, dynamic>{
  'category_id': instance.categoryId,
  'session_id': instance.sessionId,
  'answers': instance.answers.map((e) => e.toJson()).toList(),
  'mypayment_request_method': requestTypeToJson(
    instance.mypaymentRequestMethod,
  ),
  'mypayment_transfer_redirect_url': instance.mypaymentTransferRedirectUrl,
};

CheckoutResponse _$CheckoutResponseFromJson(Map<String, dynamic> json) =>
    CheckoutResponse(
      price: (json['price'] as num?)?.toInt() ?? 0,
      expiration: DateTime.parse(json['expiration'] as String),
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$CheckoutResponseToJson(CheckoutResponse instance) =>
    <String, dynamic>{
      'price': instance.price,
      'expiration': instance.expiration.toIso8601String(),
      'payment_url': instance.paymentUrl,
    };

CineSessionBase _$CineSessionBaseFromJson(Map<String, dynamic> json) =>
    CineSessionBase(
      start: DateTime.parse(json['start'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      genre: json['genre'] as String?,
      tagline: json['tagline'] as String?,
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
      genre: json['genre'] as String?,
      tagline: json['tagline'] as String?,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CineSessionCompleteToJson(
  CineSessionComplete instance,
) => <String, dynamic>{
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
      name: json['name'] as String?,
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      overview: json['overview'] as String?,
      genre: json['genre'] as String?,
      tagline: json['tagline'] as String?,
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

CompetitionEdition _$CompetitionEditionFromJson(Map<String, dynamic> json) =>
    CompetitionEdition(
      name: json['name'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      active: json['active'] as bool? ?? true,
      inscriptionEnabled: json['inscription_enabled'] as bool? ?? false,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CompetitionEditionToJson(CompetitionEdition instance) =>
    <String, dynamic>{
      'name': instance.name,
      'year': instance.year,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'active': instance.active,
      'inscription_enabled': instance.inscriptionEnabled,
      'id': instance.id,
    };

CompetitionEditionBase _$CompetitionEditionBaseFromJson(
  Map<String, dynamic> json,
) => CompetitionEditionBase(
  name: json['name'] as String? ?? '',
  year: (json['year'] as num?)?.toInt() ?? 0,
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  active: json['active'] as bool? ?? true,
  inscriptionEnabled: json['inscription_enabled'] as bool? ?? false,
);

Map<String, dynamic> _$CompetitionEditionBaseToJson(
  CompetitionEditionBase instance,
) => <String, dynamic>{
  'name': instance.name,
  'year': instance.year,
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate.toIso8601String(),
  'active': instance.active,
  'inscription_enabled': instance.inscriptionEnabled,
};

CompetitionEditionEdit _$CompetitionEditionEditFromJson(
  Map<String, dynamic> json,
) => CompetitionEditionEdit(
  name: json['name'] as String?,
  year: (json['year'] as num?)?.toInt(),
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
);

Map<String, dynamic> _$CompetitionEditionEditToJson(
  CompetitionEditionEdit instance,
) => <String, dynamic>{
  'name': instance.name,
  'year': instance.year,
  'start_date': instance.startDate?.toIso8601String(),
  'end_date': instance.endDate?.toIso8601String(),
};

CompetitionUser _$CompetitionUserFromJson(Map<String, dynamic> json) =>
    CompetitionUser(
      sportCategory: sportCategoryFromJson(json['sport_category']),
      isPompom: json['is_pompom'] as bool? ?? false,
      isFanfare: json['is_fanfare'] as bool? ?? false,
      isCameraman: json['is_cameraman'] as bool? ?? false,
      isAthlete: json['is_athlete'] as bool? ?? false,
      allowPictures: json['allow_pictures'] as bool? ?? true,
      userId: json['user_id'] as String? ?? '',
      editionId: json['edition_id'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      validated: json['validated'] as bool? ?? false,
      user: CoreUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompetitionUserToJson(CompetitionUser instance) =>
    <String, dynamic>{
      'sport_category': sportCategoryToJson(instance.sportCategory),
      'is_pompom': instance.isPompom,
      'is_fanfare': instance.isFanfare,
      'is_cameraman': instance.isCameraman,
      'is_athlete': instance.isAthlete,
      'allow_pictures': instance.allowPictures,
      'user_id': instance.userId,
      'edition_id': instance.editionId,
      'created_at': instance.createdAt.toIso8601String(),
      'validated': instance.validated,
      'user': instance.user.toJson(),
    };

CompetitionUserBase _$CompetitionUserBaseFromJson(Map<String, dynamic> json) =>
    CompetitionUserBase(
      sportCategory: sportCategoryFromJson(json['sport_category']),
      isPompom: json['is_pompom'] as bool? ?? false,
      isFanfare: json['is_fanfare'] as bool? ?? false,
      isCameraman: json['is_cameraman'] as bool? ?? false,
      isAthlete: json['is_athlete'] as bool? ?? false,
      allowPictures: json['allow_pictures'] as bool? ?? true,
    );

Map<String, dynamic> _$CompetitionUserBaseToJson(
  CompetitionUserBase instance,
) => <String, dynamic>{
  'sport_category': sportCategoryToJson(instance.sportCategory),
  'is_pompom': instance.isPompom,
  'is_fanfare': instance.isFanfare,
  'is_cameraman': instance.isCameraman,
  'is_athlete': instance.isAthlete,
  'allow_pictures': instance.allowPictures,
};

CompetitionUserEdit _$CompetitionUserEditFromJson(Map<String, dynamic> json) =>
    CompetitionUserEdit(
      sportCategory: sportCategoryNullableFromJson(json['sport_category']),
      validated: json['validated'] as bool?,
      isPompom: json['is_pompom'] as bool?,
      isFanfare: json['is_fanfare'] as bool?,
      isCameraman: json['is_cameraman'] as bool?,
      isAthlete: json['is_athlete'] as bool?,
      allowPictures: json['allow_pictures'] as bool?,
    );

Map<String, dynamic> _$CompetitionUserEditToJson(
  CompetitionUserEdit instance,
) => <String, dynamic>{
  'sport_category': sportCategoryNullableToJson(instance.sportCategory),
  'validated': instance.validated,
  'is_pompom': instance.isPompom,
  'is_fanfare': instance.isFanfare,
  'is_cameraman': instance.isCameraman,
  'is_athlete': instance.isAthlete,
  'allow_pictures': instance.allowPictures,
};

CompetitionUserSimple _$CompetitionUserSimpleFromJson(
  Map<String, dynamic> json,
) => CompetitionUserSimple(
  sportCategory: sportCategoryFromJson(json['sport_category']),
  isPompom: json['is_pompom'] as bool? ?? false,
  isFanfare: json['is_fanfare'] as bool? ?? false,
  isCameraman: json['is_cameraman'] as bool? ?? false,
  isAthlete: json['is_athlete'] as bool? ?? false,
  allowPictures: json['allow_pictures'] as bool? ?? true,
  userId: json['user_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
  validated: json['validated'] as bool? ?? false,
);

Map<String, dynamic> _$CompetitionUserSimpleToJson(
  CompetitionUserSimple instance,
) => <String, dynamic>{
  'sport_category': sportCategoryToJson(instance.sportCategory),
  'is_pompom': instance.isPompom,
  'is_fanfare': instance.isFanfare,
  'is_cameraman': instance.isCameraman,
  'is_athlete': instance.isAthlete,
  'allow_pictures': instance.allowPictures,
  'user_id': instance.userId,
  'edition_id': instance.editionId,
  'created_at': instance.createdAt.toIso8601String(),
  'validated': instance.validated,
};

CoreAccountTypePermission _$CoreAccountTypePermissionFromJson(
  Map<String, dynamic> json,
) => CoreAccountTypePermission(
  permissionName: json['permission_name'] as String? ?? '',
  accountType: accountTypeFromJson(json['account_type']),
);

Map<String, dynamic> _$CoreAccountTypePermissionToJson(
  CoreAccountTypePermission instance,
) => <String, dynamic>{
  'permission_name': instance.permissionName,
  'account_type': accountTypeToJson(instance.accountType),
};

CoreBatchDeleteMembership _$CoreBatchDeleteMembershipFromJson(
  Map<String, dynamic> json,
) => CoreBatchDeleteMembership(groupId: json['group_id'] as String? ?? '');

Map<String, dynamic> _$CoreBatchDeleteMembershipToJson(
  CoreBatchDeleteMembership instance,
) => <String, dynamic>{'group_id': instance.groupId};

CoreBatchMembership _$CoreBatchMembershipFromJson(Map<String, dynamic> json) =>
    CoreBatchMembership(
      userEmails:
          (json['user_emails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      groupId: json['group_id'] as String? ?? '',
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CoreBatchMembershipToJson(
  CoreBatchMembership instance,
) => <String, dynamic>{
  'user_emails': instance.userEmails,
  'group_id': instance.groupId,
  'description': instance.description,
};

CoreBatchUserCreateRequest _$CoreBatchUserCreateRequestFromJson(
  Map<String, dynamic> json,
) => CoreBatchUserCreateRequest(
  email: json['email'] as String? ?? '',
  defaultGroupId: json['default_group_id'] as String?,
);

Map<String, dynamic> _$CoreBatchUserCreateRequestToJson(
  CoreBatchUserCreateRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'default_group_id': instance.defaultGroupId,
};

CoreGroup _$CoreGroupFromJson(Map<String, dynamic> json) => CoreGroup(
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  id: json['id'] as String? ?? '',
  members:
      (json['members'] as List<dynamic>?)
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
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CoreGroupCreateToJson(CoreGroupCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

CoreGroupPermission _$CoreGroupPermissionFromJson(Map<String, dynamic> json) =>
    CoreGroupPermission(
      permissionName: json['permission_name'] as String? ?? '',
      groupId: json['group_id'] as String? ?? '',
    );

Map<String, dynamic> _$CoreGroupPermissionToJson(
  CoreGroupPermission instance,
) => <String, dynamic>{
  'permission_name': instance.permissionName,
  'group_id': instance.groupId,
};

CoreGroupSimple _$CoreGroupSimpleFromJson(Map<String, dynamic> json) =>
    CoreGroupSimple(
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
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
      name: json['name'] as String?,
      description: json['description'] as String?,
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
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CoreMembershipToJson(CoreMembership instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'group_id': instance.groupId,
      'description': instance.description,
    };

CoreMembershipDelete _$CoreMembershipDeleteFromJson(
  Map<String, dynamic> json,
) => CoreMembershipDelete(
  userId: json['user_id'] as String? ?? '',
  groupId: json['group_id'] as String? ?? '',
);

Map<String, dynamic> _$CoreMembershipDeleteToJson(
  CoreMembershipDelete instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'group_id': instance.groupId,
};

CorePermission _$CorePermissionFromJson(Map<String, dynamic> json) =>
    CorePermission(
      permissionName: json['permission_name'] as String? ?? '',
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      accountTypes: accountTypeListFromJson(json['account_types'] as List?),
    );

Map<String, dynamic> _$CorePermissionToJson(CorePermission instance) =>
    <String, dynamic>{
      'permission_name': instance.permissionName,
      'groups': instance.groups,
      'account_types': accountTypeListToJson(instance.accountTypes),
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
      name: json['name'] as String?,
      emailRegex: json['email_regex'] as String?,
    );

Map<String, dynamic> _$CoreSchoolUpdateToJson(CoreSchoolUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email_regex': instance.emailRegex,
    };

CoreUser _$CoreUserFromJson(Map<String, dynamic> json) => CoreUser(
  name: json['name'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  nickname: json['nickname'] as String?,
  id: json['id'] as String? ?? '',
  accountType: accountTypeFromJson(json['account_type']),
  schoolId: json['school_id'] as String? ?? '',
  email: json['email'] as String? ?? '',
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  promo: (json['promo'] as num?)?.toInt(),
  floor: json['floor'] as String?,
  phone: json['phone'] as String?,
  createdOn: json['created_on'] == null
      ? null
      : DateTime.parse(json['created_on'] as String),
  groups:
      (json['groups'] as List<dynamic>?)
          ?.map((e) => CoreGroupSimple.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  school: json['school'] == null
      ? null
      : CoreSchool.fromJson(json['school'] as Map<String, dynamic>),
  isSuperAdmin: json['is_super_admin'] as bool? ?? false,
);

Map<String, dynamic> _$CoreUserToJson(CoreUser instance) => <String, dynamic>{
  'name': instance.name,
  'firstname': instance.firstname,
  'nickname': instance.nickname,
  'id': instance.id,
  'account_type': accountTypeToJson(instance.accountType),
  'school_id': instance.schoolId,
  'email': instance.email,
  'birthday': _dateToJson(instance.birthday),
  'promo': instance.promo,
  'floor': instance.floor,
  'phone': instance.phone,
  'created_on': instance.createdOn?.toIso8601String(),
  'groups': instance.groups?.map((e) => e.toJson()).toList(),
  'school': instance.school?.toJson(),
  'is_super_admin': instance.isSuperAdmin,
};

CoreUserActivateRequest _$CoreUserActivateRequestFromJson(
  Map<String, dynamic> json,
) => CoreUserActivateRequest(
  name: json['name'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  nickname: json['nickname'] as String?,
  activationToken: json['activation_token'] as String? ?? '',
  password: json['password'] as String? ?? '',
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  phone: json['phone'] as String?,
  floor: json['floor'] as String?,
  promo: (json['promo'] as num?)?.toInt(),
);

Map<String, dynamic> _$CoreUserActivateRequestToJson(
  CoreUserActivateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'firstname': instance.firstname,
  'nickname': instance.nickname,
  'activation_token': instance.activationToken,
  'password': instance.password,
  'birthday': _dateToJson(instance.birthday),
  'phone': instance.phone,
  'floor': instance.floor,
  'promo': instance.promo,
};

CoreUserCreateRequest _$CoreUserCreateRequestFromJson(
  Map<String, dynamic> json,
) => CoreUserCreateRequest(
  email: json['email'] as String? ?? '',
  acceptExternal: json['accept_external'] as bool?,
);

Map<String, dynamic> _$CoreUserCreateRequestToJson(
  CoreUserCreateRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'accept_external': instance.acceptExternal,
};

CoreUserFusionRequest _$CoreUserFusionRequestFromJson(
  Map<String, dynamic> json,
) => CoreUserFusionRequest(
  userKeptEmail: json['user_kept_email'] as String? ?? '',
  userDeletedEmail: json['user_deleted_email'] as String? ?? '',
);

Map<String, dynamic> _$CoreUserFusionRequestToJson(
  CoreUserFusionRequest instance,
) => <String, dynamic>{
  'user_kept_email': instance.userKeptEmail,
  'user_deleted_email': instance.userDeletedEmail,
};

CoreUserSimple _$CoreUserSimpleFromJson(Map<String, dynamic> json) =>
    CoreUserSimple(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String?,
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
      nickname: json['nickname'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String?,
      floor: json['floor'] as String?,
    );

Map<String, dynamic> _$CoreUserUpdateToJson(CoreUserUpdate instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'floor': instance.floor,
    };

CoreUserUpdateAdmin _$CoreUserUpdateAdminFromJson(Map<String, dynamic> json) =>
    CoreUserUpdateAdmin(
      email: json['email'] as String?,
      schoolId: json['school_id'] as String?,
      accountType: accountTypeNullableFromJson(json['account_type']),
      name: json['name'] as String?,
      firstname: json['firstname'] as String?,
      promo: (json['promo'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String?,
      floor: json['floor'] as String?,
    );

Map<String, dynamic> _$CoreUserUpdateAdminToJson(
  CoreUserUpdateAdmin instance,
) => <String, dynamic>{
  'email': instance.email,
  'school_id': instance.schoolId,
  'account_type': accountTypeNullableToJson(instance.accountType),
  'name': instance.name,
  'firstname': instance.firstname,
  'promo': instance.promo,
  'nickname': instance.nickname,
  'birthday': _dateToJson(instance.birthday),
  'phone': instance.phone,
  'floor': instance.floor,
};

CoreVariables _$CoreVariablesFromJson(Map<String, dynamic> json) =>
    CoreVariables(
      name: json['name'] as String? ?? '',
      entityName: json['entity_name'] as String? ?? '',
      emailPlaceholder: json['email_placeholder'] as String? ?? '',
      mainActivationForm: MainActivationForm.fromJson(
        json['main_activation_form'] as Map<String, dynamic>,
      ),
      studentEmailRegex: json['student_email_regex'] as String? ?? '',
      staffEmailRegex: json['staff_email_regex'] as String?,
      formerStudentEmailRegex: json['former_student_email_regex'] as String?,
      primaryColor: json['primary_color'] as String? ?? '',
      playStoreUrl: json['play_store_url'] as String?,
      appStoreUrl: json['app_store_url'] as String?,
    );

Map<String, dynamic> _$CoreVariablesToJson(CoreVariables instance) =>
    <String, dynamic>{
      'name': instance.name,
      'entity_name': instance.entityName,
      'email_placeholder': instance.emailPlaceholder,
      'main_activation_form': instance.mainActivationForm.toJson(),
      'student_email_regex': instance.studentEmailRegex,
      'staff_email_regex': instance.staffEmailRegex,
      'former_student_email_regex': instance.formerStudentEmailRegex,
      'primary_color': instance.primaryColor,
      'play_store_url': instance.playStoreUrl,
      'app_store_url': instance.appStoreUrl,
    };

CurriculumBase _$CurriculumBaseFromJson(Map<String, dynamic> json) =>
    CurriculumBase(name: json['name'] as String? ?? '');

Map<String, dynamic> _$CurriculumBaseToJson(CurriculumBase instance) =>
    <String, dynamic>{'name': instance.name};

CurriculumComplete _$CurriculumCompleteFromJson(Map<String, dynamic> json) =>
    CurriculumComplete(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$CurriculumCompleteToJson(CurriculumComplete instance) =>
    <String, dynamic>{'name': instance.name, 'id': instance.id};

CustomDataBase _$CustomDataBaseFromJson(Map<String, dynamic> json) =>
    CustomDataBase(value: json['value'] as String? ?? '');

Map<String, dynamic> _$CustomDataBaseToJson(CustomDataBase instance) =>
    <String, dynamic>{'value': instance.value};

CustomDataComplete _$CustomDataCompleteFromJson(Map<String, dynamic> json) =>
    CustomDataComplete(
      value: json['value'] as String? ?? '',
      fieldId: json['field_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      field: CustomDataFieldComplete.fromJson(
        json['field'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CustomDataCompleteToJson(CustomDataComplete instance) =>
    <String, dynamic>{
      'value': instance.value,
      'field_id': instance.fieldId,
      'user_id': instance.userId,
      'field': instance.field.toJson(),
    };

CustomDataFieldBase _$CustomDataFieldBaseFromJson(Map<String, dynamic> json) =>
    CustomDataFieldBase(
      name: json['name'] as String? ?? '',
      canUserAnswer: json['can_user_answer'] as bool? ?? false,
    );

Map<String, dynamic> _$CustomDataFieldBaseToJson(
  CustomDataFieldBase instance,
) => <String, dynamic>{
  'name': instance.name,
  'can_user_answer': instance.canUserAnswer,
};

CustomDataFieldComplete _$CustomDataFieldCompleteFromJson(
  Map<String, dynamic> json,
) => CustomDataFieldComplete(
  name: json['name'] as String? ?? '',
  canUserAnswer: json['can_user_answer'] as bool? ?? false,
  id: json['id'] as String? ?? '',
  productId: json['product_id'] as String? ?? '',
);

Map<String, dynamic> _$CustomDataFieldCompleteToJson(
  CustomDataFieldComplete instance,
) => <String, dynamic>{
  'name': instance.name,
  'can_user_answer': instance.canUserAnswer,
  'id': instance.id,
  'product_id': instance.productId,
};

DeliveryBase _$DeliveryBaseFromJson(Map<String, dynamic> json) => DeliveryBase(
  name: json['name'] as String? ?? '',
  deliveryDate: DateTime.parse(json['delivery_date'] as String),
  productsIds:
      (json['products_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
);

Map<String, dynamic> _$DeliveryBaseToJson(DeliveryBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'delivery_date': _dateToJson(instance.deliveryDate),
      'products_ids': instance.productsIds,
    };

DeliveryProductsUpdate _$DeliveryProductsUpdateFromJson(
  Map<String, dynamic> json,
) => DeliveryProductsUpdate(
  productsIds:
      (json['products_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
);

Map<String, dynamic> _$DeliveryProductsUpdateToJson(
  DeliveryProductsUpdate instance,
) => <String, dynamic>{'products_ids': instance.productsIds};

DeliveryReturn _$DeliveryReturnFromJson(Map<String, dynamic> json) =>
    DeliveryReturn(
      name: json['name'] as String? ?? '',
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
      products:
          (json['products'] as List<dynamic>?)
              ?.map(
                (e) => AppModulesAmapSchemasAmapProductComplete.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      id: json['id'] as String? ?? '',
      status: deliveryStatusTypeFromJson(json['status']),
    );

Map<String, dynamic> _$DeliveryReturnToJson(DeliveryReturn instance) =>
    <String, dynamic>{
      'name': instance.name,
      'delivery_date': _dateToJson(instance.deliveryDate),
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'status': deliveryStatusTypeToJson(instance.status),
    };

DeliveryUpdate _$DeliveryUpdateFromJson(Map<String, dynamic> json) =>
    DeliveryUpdate(
      name: json['name'] as String?,
      deliveryDate: json['delivery_date'] == null
          ? null
          : DateTime.parse(json['delivery_date'] as String),
    );

Map<String, dynamic> _$DeliveryUpdateToJson(DeliveryUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'delivery_date': _dateToJson(instance.deliveryDate),
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

DocumentBase _$DocumentBaseFromJson(Map<String, dynamic> json) =>
    DocumentBase(name: json['name'] as String? ?? '');

Map<String, dynamic> _$DocumentBaseToJson(DocumentBase instance) =>
    <String, dynamic>{'name': instance.name};

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
    DocumentCreation(id: json['id'] as String? ?? '');

Map<String, dynamic> _$DocumentCreationToJson(DocumentCreation instance) =>
    <String, dynamic>{'id': instance.id};

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    EmergencyContact(
      firstname: json['firstname'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'name': instance.name,
      'phone': instance.phone,
    };

EventAdmin _$EventAdminFromJson(Map<String, dynamic> json) => EventAdmin(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  storeId: json['store_id'] as String? ?? '',
  openDatetime: DateTime.parse(json['open_datetime'] as String),
  closeDatetime: json['close_datetime'] == null
      ? null
      : DateTime.parse(json['close_datetime'] as String),
  disabled: json['disabled'] as bool? ?? false,
  quota: (json['quota'] as num?)?.toInt(),
  sessions:
      (json['sessions'] as List<dynamic>?)
          ?.map((e) => SessionAdmin.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryAdmin.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionAdmin.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  ticketsInCheckout: (json['tickets_in_checkout'] as num?)?.toInt() ?? 0,
  ticketsSold: (json['tickets_sold'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$EventAdminToJson(EventAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'store_id': instance.storeId,
      'open_datetime': instance.openDatetime.toIso8601String(),
      'close_datetime': instance.closeDatetime?.toIso8601String(),
      'disabled': instance.disabled,
      'quota': instance.quota,
      'sessions': instance.sessions.map((e) => e.toJson()).toList(),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'tickets_in_checkout': instance.ticketsInCheckout,
      'tickets_sold': instance.ticketsSold,
    };

EventBaseCreation _$EventBaseCreationFromJson(Map<String, dynamic> json) =>
    EventBaseCreation(
      name: json['name'] as String? ?? '',
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      allDay: json['all_day'] as bool? ?? false,
      location: json['location'] as String? ?? '',
      description: json['description'] as String?,
      recurrenceRule: json['recurrence_rule'] as String?,
      ticketUrlOpening: json['ticket_url_opening'] == null
          ? null
          : DateTime.parse(json['ticket_url_opening'] as String),
      notification: json['notification'] as bool? ?? false,
      associationId: json['association_id'] as String? ?? '',
      ticketUrl: json['ticket_url'] as String?,
      ticketEventId: json['ticket_event_id'] as String?,
    );

Map<String, dynamic> _$EventBaseCreationToJson(EventBaseCreation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'all_day': instance.allDay,
      'location': instance.location,
      'description': instance.description,
      'recurrence_rule': instance.recurrenceRule,
      'ticket_url_opening': instance.ticketUrlOpening?.toIso8601String(),
      'notification': instance.notification,
      'association_id': instance.associationId,
      'ticket_url': instance.ticketUrl,
      'ticket_event_id': instance.ticketEventId,
    };

EventCompleteTicketUrl _$EventCompleteTicketUrlFromJson(
  Map<String, dynamic> json,
) => EventCompleteTicketUrl(
  name: json['name'] as String? ?? '',
  start: DateTime.parse(json['start'] as String),
  end: DateTime.parse(json['end'] as String),
  allDay: json['all_day'] as bool? ?? false,
  location: json['location'] as String? ?? '',
  description: json['description'] as String?,
  recurrenceRule: json['recurrence_rule'] as String?,
  ticketUrlOpening: json['ticket_url_opening'] == null
      ? null
      : DateTime.parse(json['ticket_url_opening'] as String),
  notification: json['notification'] as bool? ?? false,
  associationId: json['association_id'] as String? ?? '',
  id: json['id'] as String? ?? '',
  association: Association.fromJson(
    json['association'] as Map<String, dynamic>,
  ),
  decision: decisionFromJson(json['decision']),
  ticketUrl: json['ticket_url'] as String?,
  ticketEventId: json['ticket_event_id'] as String?,
);

Map<String, dynamic> _$EventCompleteTicketUrlToJson(
  EventCompleteTicketUrl instance,
) => <String, dynamic>{
  'name': instance.name,
  'start': instance.start.toIso8601String(),
  'end': instance.end.toIso8601String(),
  'all_day': instance.allDay,
  'location': instance.location,
  'description': instance.description,
  'recurrence_rule': instance.recurrenceRule,
  'ticket_url_opening': instance.ticketUrlOpening?.toIso8601String(),
  'notification': instance.notification,
  'association_id': instance.associationId,
  'id': instance.id,
  'association': instance.association.toJson(),
  'decision': decisionToJson(instance.decision),
  'ticket_url': instance.ticketUrl,
  'ticket_event_id': instance.ticketEventId,
};

EventCreate _$EventCreateFromJson(Map<String, dynamic> json) => EventCreate(
  storeId: json['store_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  quota: (json['quota'] as num?)?.toInt(),
  openDatetime: DateTime.parse(json['open_datetime'] as String),
  closeDatetime: json['close_datetime'] == null
      ? null
      : DateTime.parse(json['close_datetime'] as String),
  sessions:
      (json['sessions'] as List<dynamic>?)
          ?.map((e) => SessionCreate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryCreate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionCreate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$EventCreateToJson(EventCreate instance) =>
    <String, dynamic>{
      'store_id': instance.storeId,
      'name': instance.name,
      'quota': instance.quota,
      'open_datetime': instance.openDatetime.toIso8601String(),
      'close_datetime': instance.closeDatetime?.toIso8601String(),
      'sessions': instance.sessions.map((e) => e.toJson()).toList(),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

EventEdit _$EventEditFromJson(Map<String, dynamic> json) => EventEdit(
  name: json['name'] as String?,
  start: json['start'] == null ? null : DateTime.parse(json['start'] as String),
  end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  allDay: json['all_day'] as bool?,
  location: json['location'] as String?,
  description: json['description'] as String?,
  recurrenceRule: json['recurrence_rule'] as String?,
  ticketUrlOpening: json['ticket_url_opening'] == null
      ? null
      : DateTime.parse(json['ticket_url_opening'] as String),
  ticketUrl: json['ticket_url'] as String?,
  ticketEventId: json['ticket_event_id'] as String?,
  notification: json['notification'] as bool?,
);

Map<String, dynamic> _$EventEditToJson(EventEdit instance) => <String, dynamic>{
  'name': instance.name,
  'start': instance.start?.toIso8601String(),
  'end': instance.end?.toIso8601String(),
  'all_day': instance.allDay,
  'location': instance.location,
  'description': instance.description,
  'recurrence_rule': instance.recurrenceRule,
  'ticket_url_opening': instance.ticketUrlOpening?.toIso8601String(),
  'ticket_url': instance.ticketUrl,
  'ticket_event_id': instance.ticketEventId,
  'notification': instance.notification,
};

EventPublic _$EventPublicFromJson(Map<String, dynamic> json) => EventPublic(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  storeId: json['store_id'] as String? ?? '',
  openDatetime: DateTime.parse(json['open_datetime'] as String),
  closeDatetime: json['close_datetime'] == null
      ? null
      : DateTime.parse(json['close_datetime'] as String),
  disabled: json['disabled'] as bool? ?? false,
  sessions:
      (json['sessions'] as List<dynamic>?)
          ?.map((e) => SessionPublic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryPublic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionPublic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  soldOut: json['sold_out'] as bool? ?? false,
);

Map<String, dynamic> _$EventPublicToJson(EventPublic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'store_id': instance.storeId,
      'open_datetime': instance.openDatetime.toIso8601String(),
      'close_datetime': instance.closeDatetime?.toIso8601String(),
      'disabled': instance.disabled,
      'sessions': instance.sessions.map((e) => e.toJson()).toList(),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'sold_out': instance.soldOut,
    };

EventSimple _$EventSimpleFromJson(Map<String, dynamic> json) => EventSimple(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  storeId: json['store_id'] as String? ?? '',
  openDatetime: DateTime.parse(json['open_datetime'] as String),
  closeDatetime: json['close_datetime'] == null
      ? null
      : DateTime.parse(json['close_datetime'] as String),
  disabled: json['disabled'] as bool? ?? false,
);

Map<String, dynamic> _$EventSimpleToJson(EventSimple instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'store_id': instance.storeId,
      'open_datetime': instance.openDatetime.toIso8601String(),
      'close_datetime': instance.closeDatetime?.toIso8601String(),
      'disabled': instance.disabled,
    };

EventTicketUrl _$EventTicketUrlFromJson(Map<String, dynamic> json) =>
    EventTicketUrl(ticketUrl: json['ticket_url'] as String? ?? '');

Map<String, dynamic> _$EventTicketUrlToJson(EventTicketUrl instance) =>
    <String, dynamic>{'ticket_url': instance.ticketUrl};

EventUpdate _$EventUpdateFromJson(Map<String, dynamic> json) => EventUpdate(
  name: json['name'] as String?,
  quota: (json['quota'] as num?)?.toInt(),
  openDatetime: json['open_datetime'] == null
      ? null
      : DateTime.parse(json['open_datetime'] as String),
  closeDatetime: json['close_datetime'] == null
      ? null
      : DateTime.parse(json['close_datetime'] as String),
  disabled: json['disabled'] as bool?,
);

Map<String, dynamic> _$EventUpdateToJson(EventUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quota': instance.quota,
      'open_datetime': instance.openDatetime?.toIso8601String(),
      'close_datetime': instance.closeDatetime?.toIso8601String(),
      'disabled': instance.disabled,
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
    FlappyBirdScoreBase(value: (json['value'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$FlappyBirdScoreBaseToJson(
  FlappyBirdScoreBase instance,
) => <String, dynamic>{'value': instance.value};

FlappyBirdScoreCompleteFeedBack _$FlappyBirdScoreCompleteFeedBackFromJson(
  Map<String, dynamic> json,
) => FlappyBirdScoreCompleteFeedBack(
  value: (json['value'] as num?)?.toInt() ?? 0,
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
  creationTime: DateTime.parse(json['creation_time'] as String),
  position: (json['position'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FlappyBirdScoreCompleteFeedBackToJson(
  FlappyBirdScoreCompleteFeedBack instance,
) => <String, dynamic>{
  'value': instance.value,
  'user': instance.user.toJson(),
  'creation_time': instance.creationTime.toIso8601String(),
  'position': instance.position,
};

FlappyBirdScoreInDB _$FlappyBirdScoreInDBFromJson(Map<String, dynamic> json) =>
    FlappyBirdScoreInDB(
      value: (json['value'] as num?)?.toInt() ?? 0,
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
      creationTime: DateTime.parse(json['creation_time'] as String),
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
    );

Map<String, dynamic> _$FlappyBirdScoreInDBToJson(
  FlappyBirdScoreInDB instance,
) => <String, dynamic>{
  'value': instance.value,
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
  Map<String, dynamic> json,
) => GenerateTicketComplete(
  name: json['name'] as String? ?? '',
  maxUse: (json['max_use'] as num?)?.toInt() ?? 0,
  expiration: DateTime.parse(json['expiration'] as String),
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$GenerateTicketCompleteToJson(
  GenerateTicketComplete instance,
) => <String, dynamic>{
  'name': instance.name,
  'max_use': instance.maxUse,
  'expiration': instance.expiration.toIso8601String(),
  'id': instance.id,
};

GroupNotificationRequest _$GroupNotificationRequestFromJson(
  Map<String, dynamic> json,
) => GroupNotificationRequest(
  groupId: json['group_id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  content: json['content'] as String? ?? '',
);

Map<String, dynamic> _$GroupNotificationRequestToJson(
  GroupNotificationRequest instance,
) => <String, dynamic>{
  'group_id': instance.groupId,
  'title': instance.title,
  'content': instance.content,
};

HTTPValidationError _$HTTPValidationErrorFromJson(Map<String, dynamic> json) =>
    HTTPValidationError(
      detail:
          (json['detail'] as List<dynamic>?)
              ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$HTTPValidationErrorToJson(
  HTTPValidationError instance,
) => <String, dynamic>{
  'detail': instance.detail?.map((e) => e.toJson()).toList(),
};

History _$HistoryFromJson(Map<String, dynamic> json) => History(
  id: json['id'] as String? ?? '',
  type: historyTypeFromJson(json['type']),
  direction: historyDirectionFromJson(json['direction']),
  otherWalletName: json['other_wallet_name'] as String? ?? '',
  total: (json['total'] as num?)?.toInt() ?? 0,
  creation: DateTime.parse(json['creation'] as String),
  status: transactionStatusFromJson(json['status']),
  refund: json['refund'] == null
      ? null
      : HistoryRefund.fromJson(json['refund'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
  'id': instance.id,
  'type': historyTypeToJson(instance.type),
  'direction': historyDirectionToJson(instance.direction),
  'other_wallet_name': instance.otherWalletName,
  'total': instance.total,
  'creation': instance.creation.toIso8601String(),
  'status': transactionStatusToJson(instance.status),
  'refund': instance.refund?.toJson(),
};

HistoryRefund _$HistoryRefundFromJson(Map<String, dynamic> json) =>
    HistoryRefund(
      total: (json['total'] as num?)?.toInt() ?? 0,
      creation: DateTime.parse(json['creation'] as String),
    );

Map<String, dynamic> _$HistoryRefundToJson(HistoryRefund instance) =>
    <String, dynamic>{
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
    };

IcalSecret _$IcalSecretFromJson(Map<String, dynamic> json) =>
    IcalSecret(secret: json['secret'] as String? ?? '');

Map<String, dynamic> _$IcalSecretToJson(IcalSecret instance) =>
    <String, dynamic>{'secret': instance.secret};

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
      manager: json['manager'] as String?,
      link: json['link'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$InformationEditToJson(InformationEdit instance) =>
    <String, dynamic>{
      'manager': instance.manager,
      'link': instance.link,
      'description': instance.description,
    };

IntegrityCheckData _$IntegrityCheckDataFromJson(Map<String, dynamic> json) =>
    IntegrityCheckData(
      date: DateTime.parse(json['date'] as String),
      wallets:
          (json['wallets'] as List<dynamic>?)
              ?.map((e) => WalletBase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionBase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      transfers:
          (json['transfers'] as List<dynamic>?)
              ?.map((e) => Transfer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      refunds:
          (json['refunds'] as List<dynamic>?)
              ?.map((e) => RefundBase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$IntegrityCheckDataToJson(IntegrityCheckData instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'wallets': instance.wallets.map((e) => e.toJson()).toList(),
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
      'transfers': instance.transfers.map((e) => e.toJson()).toList(),
      'refunds': instance.refunds.map((e) => e.toJson()).toList(),
    };

IntrospectTokenResponse _$IntrospectTokenResponseFromJson(
  Map<String, dynamic> json,
) => IntrospectTokenResponse(active: json['active'] as bool? ?? false);

Map<String, dynamic> _$IntrospectTokenResponseToJson(
  IntrospectTokenResponse instance,
) => <String, dynamic>{'active': instance.active};

InviteToken _$InviteTokenFromJson(Map<String, dynamic> json) => InviteToken(
  teamId: json['team_id'] as String? ?? '',
  token: json['token'] as String? ?? '',
);

Map<String, dynamic> _$InviteTokenToJson(InviteToken instance) =>
    <String, dynamic>{'team_id': instance.teamId, 'token': instance.token};

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
  id: json['id'] as String? ?? '',
  reference: json['reference'] as String? ?? '',
  structureId: json['structure_id'] as String? ?? '',
  creation: DateTime.parse(json['creation'] as String),
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  total: (json['total'] as num?)?.toInt() ?? 0,
  paid: json['paid'] as bool? ?? false,
  received: json['received'] as bool? ?? false,
  structure: Structure.fromJson(json['structure'] as Map<String, dynamic>),
  details:
      (json['details'] as List<dynamic>?)
          ?.map((e) => InvoiceDetail.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
  'id': instance.id,
  'reference': instance.reference,
  'structure_id': instance.structureId,
  'creation': instance.creation.toIso8601String(),
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate.toIso8601String(),
  'total': instance.total,
  'paid': instance.paid,
  'received': instance.received,
  'structure': instance.structure.toJson(),
  'details': instance.details.map((e) => e.toJson()).toList(),
};

InvoiceDetail _$InvoiceDetailFromJson(Map<String, dynamic> json) =>
    InvoiceDetail(
      invoiceId: json['invoice_id'] as String? ?? '',
      storeId: json['store_id'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
      store: StoreSimple.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceDetailToJson(InvoiceDetail instance) =>
    <String, dynamic>{
      'invoice_id': instance.invoiceId,
      'store_id': instance.storeId,
      'total': instance.total,
      'store': instance.store.toJson(),
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
  itemSimple: ItemSimple.fromJson(json['itemSimple'] as Map<String, dynamic>),
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
  name: json['name'] as String?,
  suggestedCaution: (json['suggested_caution'] as num?)?.toInt(),
  totalQuantity: (json['total_quantity'] as num?)?.toInt(),
  suggestedLendingDuration: (json['suggested_lending_duration'] as num?)
      ?.toInt(),
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
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => ListMemberBase.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  program: json['program'] as String?,
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
  name: json['name'] as String?,
  description: json['description'] as String?,
  type: listTypeNullableFromJson(json['type']),
  members: (json['members'] as List<dynamic>?)
      ?.map((e) => ListMemberBase.fromJson(e as Map<String, dynamic>))
      .toList(),
  program: json['program'] as String?,
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
    <String, dynamic>{'user_id': instance.userId, 'role': instance.role};

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
  section: SectionComplete.fromJson(json['section'] as Map<String, dynamic>),
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => ListMemberComplete.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  program: json['program'] as String?,
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
  notes: json['notes'] as String?,
  caution: json['caution'] as String?,
  id: json['id'] as String? ?? '',
  returned: json['returned'] as bool? ?? false,
  returnedDate: json['returned_date'] == null
      ? null
      : DateTime.parse(json['returned_date'] as String),
  itemsQty:
      (json['items_qty'] as List<dynamic>?)
          ?.map((e) => ItemQuantity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  borrower: CoreUserSimple.fromJson(json['borrower'] as Map<String, dynamic>),
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
  'returned_date': _dateToJson(instance.returnedDate),
  'items_qty': instance.itemsQty.map((e) => e.toJson()).toList(),
  'borrower': instance.borrower.toJson(),
  'loaner': instance.loaner.toJson(),
};

LoanCreation _$LoanCreationFromJson(Map<String, dynamic> json) => LoanCreation(
  borrowerId: json['borrower_id'] as String? ?? '',
  loanerId: json['loaner_id'] as String? ?? '',
  start: DateTime.parse(json['start'] as String),
  end: DateTime.parse(json['end'] as String),
  notes: json['notes'] as String?,
  caution: json['caution'] as String?,
  itemsBorrowed:
      (json['items_borrowed'] as List<dynamic>?)
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
  duration: (json['duration'] as num?)?.toInt(),
);

Map<String, dynamic> _$LoanExtendToJson(LoanExtend instance) =>
    <String, dynamic>{
      'end': _dateToJson(instance.end),
      'duration': instance.duration,
    };

LoanUpdate _$LoanUpdateFromJson(Map<String, dynamic> json) => LoanUpdate(
  borrowerId: json['borrower_id'] as String?,
  start: json['start'] == null ? null : DateTime.parse(json['start'] as String),
  end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  notes: json['notes'] as String?,
  caution: json['caution'] as String?,
  returned: json['returned'] as bool?,
  itemsBorrowed: (json['items_borrowed'] as List<dynamic>?)
      ?.map((e) => ItemBorrowed.fromJson(e as Map<String, dynamic>))
      .toList(),
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
  name: json['name'] as String?,
  groupManagerId: json['group_manager_id'] as String?,
);

Map<String, dynamic> _$LoanerUpdateToJson(LoanerUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_manager_id': instance.groupManagerId,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  id: json['id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'id': instance.id,
  'edition_id': instance.editionId,
};

LocationBase _$LocationBaseFromJson(Map<String, dynamic> json) => LocationBase(
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LocationBaseToJson(LocationBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

LocationComplete _$LocationCompleteFromJson(Map<String, dynamic> json) =>
    LocationComplete(
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      id: json['id'] as String? ?? '',
      editionId: json['edition_id'] as String? ?? '',
      matches:
          (json['matches'] as List<dynamic>?)
              ?.map((e) => MatchComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LocationCompleteToJson(LocationComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'id': instance.id,
      'edition_id': instance.editionId,
      'matches': instance.matches?.map((e) => e.toJson()).toList(),
    };

LocationEdit _$LocationEditFromJson(Map<String, dynamic> json) => LocationEdit(
  name: json['name'] as String?,
  description: json['description'] as String?,
  address: json['address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LocationEditToJson(LocationEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

MailMigrationRequest _$MailMigrationRequestFromJson(
  Map<String, dynamic> json,
) => MailMigrationRequest(newEmail: json['new_email'] as String? ?? '');

Map<String, dynamic> _$MailMigrationRequestToJson(
  MailMigrationRequest instance,
) => <String, dynamic>{'new_email': instance.newEmail};

MainActivationForm _$MainActivationFormFromJson(Map<String, dynamic> json) =>
    MainActivationForm(
      fields: activationFormFieldListFromJson(json['fields'] as List?),
      floorChoices:
          (json['floor_choices'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      promotionOffset: (json['promotion_offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MainActivationFormToJson(MainActivationForm instance) =>
    <String, dynamic>{
      'fields': activationFormFieldListToJson(instance.fields),
      'floor_choices': instance.floorChoices,
      'promotion_offset': instance.promotionOffset,
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
    <String, dynamic>{'name': instance.name, 'group_id': instance.groupId};

ManagerUpdate _$ManagerUpdateFromJson(Map<String, dynamic> json) =>
    ManagerUpdate(
      name: json['name'] as String?,
      groupId: json['group_id'] as String?,
    );

Map<String, dynamic> _$ManagerUpdateToJson(ManagerUpdate instance) =>
    <String, dynamic>{'name': instance.name, 'group_id': instance.groupId};

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
  name: json['name'] as String? ?? '',
  team1Id: json['team1_id'] as String? ?? '',
  team2Id: json['team2_id'] as String? ?? '',
  locationId: json['location_id'] as String? ?? '',
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  scoreTeam1: (json['score_team1'] as num?)?.toInt(),
  scoreTeam2: (json['score_team2'] as num?)?.toInt(),
  winnerId: json['winner_id'] as String?,
  id: json['id'] as String? ?? '',
  sportId: json['sport_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
);

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
  'name': instance.name,
  'team1_id': instance.team1Id,
  'team2_id': instance.team2Id,
  'location_id': instance.locationId,
  'date': instance.date?.toIso8601String(),
  'score_team1': instance.scoreTeam1,
  'score_team2': instance.scoreTeam2,
  'winner_id': instance.winnerId,
  'id': instance.id,
  'sport_id': instance.sportId,
  'edition_id': instance.editionId,
};

MatchBase _$MatchBaseFromJson(Map<String, dynamic> json) => MatchBase(
  name: json['name'] as String? ?? '',
  team1Id: json['team1_id'] as String? ?? '',
  team2Id: json['team2_id'] as String? ?? '',
  locationId: json['location_id'] as String? ?? '',
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  scoreTeam1: (json['score_team1'] as num?)?.toInt(),
  scoreTeam2: (json['score_team2'] as num?)?.toInt(),
  winnerId: json['winner_id'] as String?,
);

Map<String, dynamic> _$MatchBaseToJson(MatchBase instance) => <String, dynamic>{
  'name': instance.name,
  'team1_id': instance.team1Id,
  'team2_id': instance.team2Id,
  'location_id': instance.locationId,
  'date': instance.date?.toIso8601String(),
  'score_team1': instance.scoreTeam1,
  'score_team2': instance.scoreTeam2,
  'winner_id': instance.winnerId,
};

MatchComplete _$MatchCompleteFromJson(Map<String, dynamic> json) =>
    MatchComplete(
      name: json['name'] as String? ?? '',
      team1Id: json['team1_id'] as String? ?? '',
      team2Id: json['team2_id'] as String? ?? '',
      locationId: json['location_id'] as String? ?? '',
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      scoreTeam1: (json['score_team1'] as num?)?.toInt(),
      scoreTeam2: (json['score_team2'] as num?)?.toInt(),
      winnerId: json['winner_id'] as String?,
      id: json['id'] as String? ?? '',
      sportId: json['sport_id'] as String? ?? '',
      editionId: json['edition_id'] as String? ?? '',
      team1: Team.fromJson(json['team1'] as Map<String, dynamic>),
      team2: Team.fromJson(json['team2'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatchCompleteToJson(MatchComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'team1_id': instance.team1Id,
      'team2_id': instance.team2Id,
      'location_id': instance.locationId,
      'date': instance.date?.toIso8601String(),
      'score_team1': instance.scoreTeam1,
      'score_team2': instance.scoreTeam2,
      'winner_id': instance.winnerId,
      'id': instance.id,
      'sport_id': instance.sportId,
      'edition_id': instance.editionId,
      'team1': instance.team1.toJson(),
      'team2': instance.team2.toJson(),
      'location': instance.location.toJson(),
    };

MatchEdit _$MatchEditFromJson(Map<String, dynamic> json) => MatchEdit(
  name: json['name'] as String?,
  sportId: json['sport_id'] as String?,
  team1Id: json['team1_id'] as String?,
  team2Id: json['team2_id'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  locationId: json['location_id'] as String?,
  scoreTeam1: (json['score_team1'] as num?)?.toInt(),
  scoreTeam2: (json['score_team2'] as num?)?.toInt(),
  winnerId: json['winner_id'] as String?,
);

Map<String, dynamic> _$MatchEditToJson(MatchEdit instance) => <String, dynamic>{
  'name': instance.name,
  'sport_id': instance.sportId,
  'team1_id': instance.team1Id,
  'team2_id': instance.team2Id,
  'date': instance.date?.toIso8601String(),
  'location_id': instance.locationId,
  'score_team1': instance.scoreTeam1,
  'score_team2': instance.scoreTeam2,
  'winner_id': instance.winnerId,
};

MemberComplete _$MemberCompleteFromJson(Map<String, dynamic> json) =>
    MemberComplete(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      nickname: json['nickname'] as String?,
      id: json['id'] as String? ?? '',
      accountType: accountTypeFromJson(json['account_type']),
      schoolId: json['school_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      promo: (json['promo'] as num?)?.toInt(),
      memberships:
          (json['memberships'] as List<dynamic>?)
              ?.map(
                (e) => MembershipComplete.fromJson(e as Map<String, dynamic>),
              )
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
      roleTags: json['role_tags'] as String? ?? '',
      memberOrder: (json['member_order'] as num?)?.toInt() ?? 0,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$MembershipCompleteToJson(MembershipComplete instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'association_id': instance.associationId,
      'mandate_year': instance.mandateYear,
      'role_name': instance.roleName,
      'role_tags': instance.roleTags,
      'member_order': instance.memberOrder,
      'id': instance.id,
    };

MembershipEdit _$MembershipEditFromJson(Map<String, dynamic> json) =>
    MembershipEdit(
      roleName: json['role_name'] as String?,
      roleTags: json['role_tags'] as String?,
      memberOrder: (json['member_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MembershipEditToJson(MembershipEdit instance) =>
    <String, dynamic>{
      'role_name': instance.roleName,
      'role_tags': instance.roleTags,
      'member_order': instance.memberOrder,
    };

MembershipSimple _$MembershipSimpleFromJson(Map<String, dynamic> json) =>
    MembershipSimple(
      name: json['name'] as String? ?? '',
      managerGroupId: json['manager_group_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$MembershipSimpleToJson(MembershipSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'manager_group_id': instance.managerGroupId,
      'id': instance.id,
    };

MembershipUserMappingEmail _$MembershipUserMappingEmailFromJson(
  Map<String, dynamic> json,
) => MembershipUserMappingEmail(
  userEmail: json['user_email'] as String? ?? '',
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
);

Map<String, dynamic> _$MembershipUserMappingEmailToJson(
  MembershipUserMappingEmail instance,
) => <String, dynamic>{
  'user_email': instance.userEmail,
  'start_date': _dateToJson(instance.startDate),
  'end_date': _dateToJson(instance.endDate),
};

MyPaymentBankAccountHolder _$MyPaymentBankAccountHolderFromJson(
  Map<String, dynamic> json,
) => MyPaymentBankAccountHolder(
  holderStructureId: json['holder_structure_id'] as String? ?? '',
);

Map<String, dynamic> _$MyPaymentBankAccountHolderToJson(
  MyPaymentBankAccountHolder instance,
) => <String, dynamic>{'holder_structure_id': instance.holderStructureId};

News _$NewsFromJson(Map<String, dynamic> json) => News(
  id: json['id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  start: DateTime.parse(json['start'] as String),
  end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  entity: json['entity'] as String? ?? '',
  location: json['location'] as String?,
  actionStart: json['action_start'] == null
      ? null
      : DateTime.parse(json['action_start'] as String),
  module: json['module'] as String? ?? '',
  moduleObjectId: json['module_object_id'] as String? ?? '',
  status: newsStatusFromJson(json['status']),
);

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'start': instance.start.toIso8601String(),
  'end': instance.end?.toIso8601String(),
  'entity': instance.entity,
  'location': instance.location,
  'action_start': instance.actionStart?.toIso8601String(),
  'module': instance.module,
  'module_object_id': instance.moduleObjectId,
  'status': newsStatusToJson(instance.status),
};

OrderBase _$OrderBaseFromJson(Map<String, dynamic> json) => OrderBase(
  userId: json['user_id'] as String? ?? '',
  deliveryId: json['delivery_id'] as String? ?? '',
  productsIds:
      (json['products_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  collectionSlot: amapSlotTypeFromJson(json['collection_slot']),
  productsQuantity:
      (json['products_quantity'] as List<dynamic>?)
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
  productsIds: (json['products_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  collectionSlot: amapSlotTypeNullableFromJson(json['collection_slot']),
  productsQuantity: (json['products_quantity'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$OrderEditToJson(OrderEdit instance) => <String, dynamic>{
  'products_ids': instance.productsIds,
  'collection_slot': amapSlotTypeNullableToJson(instance.collectionSlot),
  'products_quantity': instance.productsQuantity,
};

OrderReturn _$OrderReturnFromJson(Map<String, dynamic> json) => OrderReturn(
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
  deliveryId: json['delivery_id'] as String? ?? '',
  deliveryName: json['delivery_name'] as String? ?? '',
  productsdetail:
      (json['productsdetail'] as List<dynamic>?)
          ?.map((e) => ProductQuantity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  collectionSlot: amapSlotTypeFromJson(json['collection_slot']),
  orderId: json['order_id'] as String? ?? '',
  amount: (json['amount'] as num?)?.toInt() ?? 0,
  orderingDate: DateTime.parse(json['ordering_date'] as String),
  deliveryDate: DateTime.parse(json['delivery_date'] as String),
);

Map<String, dynamic> _$OrderReturnToJson(OrderReturn instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'delivery_id': instance.deliveryId,
      'delivery_name': instance.deliveryName,
      'productsdetail': instance.productsdetail.map((e) => e.toJson()).toList(),
      'collection_slot': amapSlotTypeToJson(instance.collectionSlot),
      'order_id': instance.orderId,
      'amount': instance.amount,
      'ordering_date': instance.orderingDate.toIso8601String(),
      'delivery_date': _dateToJson(instance.deliveryDate),
    };

PackTicketBase _$PackTicketBaseFromJson(Map<String, dynamic> json) =>
    PackTicketBase(
      price: (json['price'] as num?)?.toInt() ?? 0,
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
      raffleId: json['raffle_id'] as String?,
      price: (json['price'] as num?)?.toInt(),
      packSize: (json['pack_size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackTicketEditToJson(PackTicketEdit instance) =>
    <String, dynamic>{
      'raffle_id': instance.raffleId,
      'price': instance.price,
      'pack_size': instance.packSize,
    };

PackTicketSimple _$PackTicketSimpleFromJson(Map<String, dynamic> json) =>
    PackTicketSimple(
      price: (json['price'] as num?)?.toInt() ?? 0,
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
  name: json['name'] as String?,
  releaseDate: json['release_date'] == null
      ? null
      : DateTime.parse(json['release_date'] as String),
);

Map<String, dynamic> _$PaperUpdateToJson(PaperUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'release_date': _dateToJson(instance.releaseDate),
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
  userId: json['user_id'] as String? ?? '',
  sportId: json['sport_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  schoolId: json['school_id'] as String? ?? '',
  license: json['license'] as String?,
  certificateFileId: json['certificate_file_id'] as String?,
  isLicenseValid: json['is_license_valid'] as bool? ?? false,
  substitute: json['substitute'] as bool? ?? false,
  teamId: json['team_id'] as String? ?? '',
);

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'sport_id': instance.sportId,
      'edition_id': instance.editionId,
      'school_id': instance.schoolId,
      'license': instance.license,
      'certificate_file_id': instance.certificateFileId,
      'is_license_valid': instance.isLicenseValid,
      'substitute': instance.substitute,
      'team_id': instance.teamId,
    };

ParticipantComplete _$ParticipantCompleteFromJson(Map<String, dynamic> json) =>
    ParticipantComplete(
      userId: json['user_id'] as String? ?? '',
      sportId: json['sport_id'] as String? ?? '',
      editionId: json['edition_id'] as String? ?? '',
      schoolId: json['school_id'] as String? ?? '',
      license: json['license'] as String?,
      certificateFileId: json['certificate_file_id'] as String?,
      isLicenseValid: json['is_license_valid'] as bool? ?? false,
      substitute: json['substitute'] as bool? ?? false,
      teamId: json['team_id'] as String? ?? '',
      user: CompetitionUser.fromJson(json['user'] as Map<String, dynamic>),
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParticipantCompleteToJson(
  ParticipantComplete instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'sport_id': instance.sportId,
  'edition_id': instance.editionId,
  'school_id': instance.schoolId,
  'license': instance.license,
  'certificate_file_id': instance.certificateFileId,
  'is_license_valid': instance.isLicenseValid,
  'substitute': instance.substitute,
  'team_id': instance.teamId,
  'user': instance.user.toJson(),
  'team': instance.team.toJson(),
};

ParticipantInfo _$ParticipantInfoFromJson(Map<String, dynamic> json) =>
    ParticipantInfo(
      license: json['license'] as String?,
      substitute: json['substitute'] as bool? ?? false,
      teamId: json['team_id'] as String?,
    );

Map<String, dynamic> _$ParticipantInfoToJson(ParticipantInfo instance) =>
    <String, dynamic>{
      'license': instance.license,
      'substitute': instance.substitute,
      'team_id': instance.teamId,
    };

PaymentUrl _$PaymentUrlFromJson(Map<String, dynamic> json) =>
    PaymentUrl(url: json['url'] as String? ?? '');

Map<String, dynamic> _$PaymentUrlToJson(PaymentUrl instance) =>
    <String, dynamic>{'url': instance.url};

PlantComplete _$PlantCompleteFromJson(Map<String, dynamic> json) =>
    PlantComplete(
      id: json['id'] as String? ?? '',
      reference: json['reference'] as String? ?? '',
      state: plantStateFromJson(json['state']),
      speciesId: json['species_id'] as String? ?? '',
      propagationMethod: propagationMethodFromJson(json['propagation_method']),
      nbSeedsEnvelope: (json['nb_seeds_envelope'] as num?)?.toInt() ?? 0,
      plantingDate: json['planting_date'] == null
          ? null
          : DateTime.parse(json['planting_date'] as String),
      borrowerId: json['borrower_id'] as String?,
      nickname: json['nickname'] as String?,
      previousNote: json['previous_note'] as String?,
      currentNote: json['current_note'] as String?,
      borrowingDate: json['borrowing_date'] == null
          ? null
          : DateTime.parse(json['borrowing_date'] as String),
      ancestorId: json['ancestor_id'] as String?,
      confidential: json['confidential'] as bool? ?? false,
    );

Map<String, dynamic> _$PlantCompleteToJson(PlantComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'state': plantStateToJson(instance.state),
      'species_id': instance.speciesId,
      'propagation_method': propagationMethodToJson(instance.propagationMethod),
      'nb_seeds_envelope': instance.nbSeedsEnvelope,
      'planting_date': _dateToJson(instance.plantingDate),
      'borrower_id': instance.borrowerId,
      'nickname': instance.nickname,
      'previous_note': instance.previousNote,
      'current_note': instance.currentNote,
      'borrowing_date': _dateToJson(instance.borrowingDate),
      'ancestor_id': instance.ancestorId,
      'confidential': instance.confidential,
    };

PlantCreation _$PlantCreationFromJson(Map<String, dynamic> json) =>
    PlantCreation(
      speciesId: json['species_id'] as String? ?? '',
      propagationMethod: propagationMethodFromJson(json['propagation_method']),
      nbSeedsEnvelope: (json['nb_seeds_envelope'] as num?)?.toInt() ?? 0,
      ancestorId: json['ancestor_id'] as String?,
      previousNote: json['previous_note'] as String?,
      confidential: json['confidential'] as bool? ?? false,
    );

Map<String, dynamic> _$PlantCreationToJson(PlantCreation instance) =>
    <String, dynamic>{
      'species_id': instance.speciesId,
      'propagation_method': propagationMethodToJson(instance.propagationMethod),
      'nb_seeds_envelope': instance.nbSeedsEnvelope,
      'ancestor_id': instance.ancestorId,
      'previous_note': instance.previousNote,
      'confidential': instance.confidential,
    };

PlantEdit _$PlantEditFromJson(Map<String, dynamic> json) => PlantEdit(
  state: plantStateNullableFromJson(json['state']),
  currentNote: json['current_note'] as String?,
  confidential: json['confidential'] as bool? ?? false,
  plantingDate: json['planting_date'] == null
      ? null
      : DateTime.parse(json['planting_date'] as String),
  borrowingDate: json['borrowing_date'] == null
      ? null
      : DateTime.parse(json['borrowing_date'] as String),
  nickname: json['nickname'] as String?,
);

Map<String, dynamic> _$PlantEditToJson(PlantEdit instance) => <String, dynamic>{
  'state': plantStateNullableToJson(instance.state),
  'current_note': instance.currentNote,
  'confidential': instance.confidential,
  'planting_date': _dateToJson(instance.plantingDate),
  'borrowing_date': _dateToJson(instance.borrowingDate),
  'nickname': instance.nickname,
};

PlantSimple _$PlantSimpleFromJson(Map<String, dynamic> json) => PlantSimple(
  id: json['id'] as String? ?? '',
  reference: json['reference'] as String? ?? '',
  state: plantStateFromJson(json['state']),
  speciesId: json['species_id'] as String? ?? '',
  propagationMethod: propagationMethodFromJson(json['propagation_method']),
  nbSeedsEnvelope: (json['nb_seeds_envelope'] as num?)?.toInt() ?? 0,
  plantingDate: json['planting_date'] == null
      ? null
      : DateTime.parse(json['planting_date'] as String),
  borrowerId: json['borrower_id'] as String?,
  nickname: json['nickname'] as String?,
);

Map<String, dynamic> _$PlantSimpleToJson(PlantSimple instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'state': plantStateToJson(instance.state),
      'species_id': instance.speciesId,
      'propagation_method': propagationMethodToJson(instance.propagationMethod),
      'nb_seeds_envelope': instance.nbSeedsEnvelope,
      'planting_date': _dateToJson(instance.plantingDate),
      'borrower_id': instance.borrowerId,
      'nickname': instance.nickname,
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
  raffleId: json['raffle_id'] as String?,
  description: json['description'] as String?,
  name: json['name'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
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

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  name: json['name'] as String? ?? '',
  required: json['required'] as bool? ?? false,
  description: json['description'] as String?,
  id: json['id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'name': instance.name,
  'required': instance.required,
  'description': instance.description,
  'id': instance.id,
  'edition_id': instance.editionId,
};

ProductCompleteNoConstraint _$ProductCompleteNoConstraintFromJson(
  Map<String, dynamic> json,
) => ProductCompleteNoConstraint(
  nameFr: json['name_fr'] as String? ?? '',
  nameEn: json['name_en'] as String?,
  descriptionFr: json['description_fr'] as String?,
  descriptionEn: json['description_en'] as String?,
  availableOnline: json['available_online'] as bool? ?? false,
  needsValidation: json['needs_validation'] as bool? ?? false,
  year: (json['year'] as num?)?.toInt() ?? 0,
  id: json['id'] as String? ?? '',
  sellerId: json['seller_id'] as String? ?? '',
  variants:
      (json['variants'] as List<dynamic>?)
          ?.map(
            (e) => AppModulesCdrSchemasCdrProductVariantComplete.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
  relatedMembership: json['related_membership'] == null
      ? null
      : MembershipSimple.fromJson(
          json['related_membership'] as Map<String, dynamic>,
        ),
  tickets:
      (json['tickets'] as List<dynamic>?)
          ?.map(
            (e) => GenerateTicketComplete.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$ProductCompleteNoConstraintToJson(
  ProductCompleteNoConstraint instance,
) => <String, dynamic>{
  'name_fr': instance.nameFr,
  'name_en': instance.nameEn,
  'description_fr': instance.descriptionFr,
  'description_en': instance.descriptionEn,
  'available_online': instance.availableOnline,
  'needs_validation': instance.needsValidation,
  'year': instance.year,
  'id': instance.id,
  'seller_id': instance.sellerId,
  'variants': instance.variants?.map((e) => e.toJson()).toList(),
  'related_membership': instance.relatedMembership?.toJson(),
  'tickets': instance.tickets.map((e) => e.toJson()).toList(),
};

ProductQuantity _$ProductQuantityFromJson(Map<String, dynamic> json) =>
    ProductQuantity(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      product: AppModulesAmapSchemasAmapProductComplete.fromJson(
        json['product'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ProductQuantityToJson(ProductQuantity instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product.toJson(),
    };

ProductSimple _$ProductSimpleFromJson(Map<String, dynamic> json) =>
    ProductSimple(
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$ProductSimpleToJson(ProductSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
    };

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) =>
    ProductVariant(
      productId: json['product_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt() ?? 0,
      enabled: json['enabled'] as bool? ?? true,
      unique: json['unique'] as bool? ?? false,
      schoolType: productSchoolTypeNullableFromJson(json['school_type']),
      publicType: productPublicTypeNullableFromJson(json['public_type']),
      editionId: json['edition_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$ProductVariantToJson(ProductVariant instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'enabled': instance.enabled,
      'unique': instance.unique,
      'school_type': productSchoolTypeNullableToJson(instance.schoolType),
      'public_type': productPublicTypeNullableToJson(instance.publicType),
      'edition_id': instance.editionId,
      'id': instance.id,
    };

ProductVariantStats _$ProductVariantStatsFromJson(Map<String, dynamic> json) =>
    ProductVariantStats(
      productId: json['product_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt() ?? 0,
      enabled: json['enabled'] as bool? ?? true,
      unique: json['unique'] as bool? ?? false,
      schoolType: productSchoolTypeNullableFromJson(json['school_type']),
      publicType: productPublicTypeNullableFromJson(json['public_type']),
      editionId: json['edition_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
      booked: (json['booked'] as num?)?.toInt() ?? 0,
      paid: (json['paid'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProductVariantStatsToJson(
  ProductVariantStats instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'enabled': instance.enabled,
  'unique': instance.unique,
  'school_type': productSchoolTypeNullableToJson(instance.schoolType),
  'public_type': productPublicTypeNullableToJson(instance.publicType),
  'edition_id': instance.editionId,
  'id': instance.id,
  'booked': instance.booked,
  'paid': instance.paid,
};

Purchase _$PurchaseFromJson(Map<String, dynamic> json) => Purchase(
  productVariantId: json['product_variant_id'] as String? ?? '',
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  userId: json['user_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  validated: json['validated'] as bool? ?? false,
  purchasedOn: DateTime.parse(json['purchased_on'] as String),
);

Map<String, dynamic> _$PurchaseToJson(Purchase instance) => <String, dynamic>{
  'product_variant_id': instance.productVariantId,
  'quantity': instance.quantity,
  'user_id': instance.userId,
  'edition_id': instance.editionId,
  'validated': instance.validated,
  'purchased_on': instance.purchasedOn.toIso8601String(),
};

PurchaseEdit _$PurchaseEditFromJson(Map<String, dynamic> json) => PurchaseEdit(
  quantity: (json['quantity'] as num?)?.toInt(),
  validated: json['validated'] as bool?,
);

Map<String, dynamic> _$PurchaseEditToJson(PurchaseEdit instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'validated': instance.validated,
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
        json['product'] as Map<String, dynamic>,
      ),
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

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  id: json['id'] as String? ?? '',
  eventId: json['event_id'] as String? ?? '',
  question: json['question'] as String? ?? '',
  answerType: answerTypeFromJson(json['answer_type']),
  price: (json['price'] as num?)?.toInt(),
  required: json['required'] as bool? ?? false,
  disabled: json['disabled'] as bool? ?? false,
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'id': instance.id,
  'event_id': instance.eventId,
  'question': instance.question,
  'answer_type': answerTypeToJson(instance.answerType),
  'price': instance.price,
  'required': instance.required,
  'disabled': instance.disabled,
};

QuestionAdmin _$QuestionAdminFromJson(Map<String, dynamic> json) =>
    QuestionAdmin(
      id: json['id'] as String? ?? '',
      eventId: json['event_id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      answerType: answerTypeFromJson(json['answer_type']),
      price: (json['price'] as num?)?.toInt(),
      required: json['required'] as bool? ?? false,
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionAdminToJson(QuestionAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'question': instance.question,
      'answer_type': answerTypeToJson(instance.answerType),
      'price': instance.price,
      'required': instance.required,
      'disabled': instance.disabled,
    };

QuestionCreate _$QuestionCreateFromJson(Map<String, dynamic> json) =>
    QuestionCreate(
      question: json['question'] as String? ?? '',
      answerType: answerTypeFromJson(json['answer_type']),
      price: (json['price'] as num?)?.toInt(),
      required: json['required'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionCreateToJson(QuestionCreate instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer_type': answerTypeToJson(instance.answerType),
      'price': instance.price,
      'required': instance.required,
    };

QuestionPublic _$QuestionPublicFromJson(Map<String, dynamic> json) =>
    QuestionPublic(
      id: json['id'] as String? ?? '',
      eventId: json['event_id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      answerType: answerTypeFromJson(json['answer_type']),
      price: (json['price'] as num?)?.toInt(),
      required: json['required'] as bool? ?? false,
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionPublicToJson(QuestionPublic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'question': instance.question,
      'answer_type': answerTypeToJson(instance.answerType),
      'price': instance.price,
      'required': instance.required,
      'disabled': instance.disabled,
    };

QuestionUpdate _$QuestionUpdateFromJson(Map<String, dynamic> json) =>
    QuestionUpdate(
      question: json['question'] as String?,
      answerType: answerTypeNullableFromJson(json['answer_type']),
      price: (json['price'] as num?)?.toInt(),
      required: json['required'] as bool?,
      disabled: json['disabled'] as bool?,
    );

Map<String, dynamic> _$QuestionUpdateToJson(QuestionUpdate instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer_type': answerTypeNullableToJson(instance.answerType),
      'price': instance.price,
      'required': instance.required,
      'disabled': instance.disabled,
    };

RaffleBase _$RaffleBaseFromJson(Map<String, dynamic> json) => RaffleBase(
  name: json['name'] as String? ?? '',
  status: raffleStatusTypeNullableFromJson(json['status']),
  description: json['description'] as String?,
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
      description: json['description'] as String?,
      groupId: json['group_id'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$RaffleCompleteToJson(RaffleComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': raffleStatusTypeNullableToJson(instance.status),
      'description': instance.description,
      'group_id': instance.groupId,
      'id': instance.id,
    };

RaffleEdit _$RaffleEditFromJson(Map<String, dynamic> json) => RaffleEdit(
  name: json['name'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$RaffleEditToJson(RaffleEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

RaffleStats _$RaffleStatsFromJson(Map<String, dynamic> json) => RaffleStats(
  ticketsSold: (json['tickets_sold'] as num?)?.toInt() ?? 0,
  amountRaised: (json['amount_raised'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RaffleStatsToJson(RaffleStats instance) =>
    <String, dynamic>{
      'tickets_sold': instance.ticketsSold,
      'amount_raised': instance.amountRaised,
    };

RaidDriveFoldersCreation _$RaidDriveFoldersCreationFromJson(
  Map<String, dynamic> json,
) => RaidDriveFoldersCreation(
  parentFolderId: json['parent_folder_id'] as String? ?? '',
);

Map<String, dynamic> _$RaidDriveFoldersCreationToJson(
  RaidDriveFoldersCreation instance,
) => <String, dynamic>{'parent_folder_id': instance.parentFolderId};

RaidInformation _$RaidInformationFromJson(Map<String, dynamic> json) =>
    RaidInformation(
      raidStartDate: json['raid_start_date'] == null
          ? null
          : DateTime.parse(json['raid_start_date'] as String),
      raidEndDate: json['raid_end_date'] == null
          ? null
          : DateTime.parse(json['raid_end_date'] as String),
      raidRegisteringEndDate: json['raid_registering_end_date'] == null
          ? null
          : DateTime.parse(json['raid_registering_end_date'] as String),
      paymentLink: json['payment_link'] as String?,
      contact: json['contact'] as String?,
      president: json['president'] == null
          ? null
          : EmergencyContact.fromJson(
              json['president'] as Map<String, dynamic>,
            ),
      volunteerResponsible: json['volunteer_responsible'] == null
          ? null
          : EmergencyContact.fromJson(
              json['volunteer_responsible'] as Map<String, dynamic>,
            ),
      securityResponsible: json['security_responsible'] == null
          ? null
          : EmergencyContact.fromJson(
              json['security_responsible'] as Map<String, dynamic>,
            ),
      rescue: json['rescue'] == null
          ? null
          : EmergencyContact.fromJson(json['rescue'] as Map<String, dynamic>),
      raidRulesId: json['raid_rules_id'] as String?,
      raidInformationId: json['raid_information_id'] as String?,
    );

Map<String, dynamic> _$RaidInformationToJson(RaidInformation instance) =>
    <String, dynamic>{
      'raid_start_date': _dateToJson(instance.raidStartDate),
      'raid_end_date': _dateToJson(instance.raidEndDate),
      'raid_registering_end_date': _dateToJson(instance.raidRegisteringEndDate),
      'payment_link': instance.paymentLink,
      'contact': instance.contact,
      'president': instance.president?.toJson(),
      'volunteer_responsible': instance.volunteerResponsible?.toJson(),
      'security_responsible': instance.securityResponsible?.toJson(),
      'rescue': instance.rescue?.toJson(),
      'raid_rules_id': instance.raidRulesId,
      'raid_information_id': instance.raidInformationId,
    };

RaidParticipant _$RaidParticipantFromJson(
  Map<String, dynamic> json,
) => RaidParticipant(
  name: json['name'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  birthday: DateTime.parse(json['birthday'] as String),
  phone: json['phone'] as String? ?? '',
  email: json['email'] as String? ?? '',
  id: json['id'] as String? ?? '',
  bikeSize: sizeNullableFromJson(json['bike_size']),
  tShirtSize: sizeNullableFromJson(json['t_shirt_size']),
  situation: json['situation'] as String?,
  validationProgress: (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
  payment: json['payment'] as bool? ?? false,
  tShirtPayment: json['t_shirt_payment'] as bool? ?? false,
  numberOfDocument: (json['number_of_document'] as num?)?.toInt() ?? 0,
  numberOfValidatedDocument:
      (json['number_of_validated_document'] as num?)?.toInt() ?? 0,
  address: json['address'] as String?,
  otherSchool: json['other_school'] as String?,
  company: json['company'] as String?,
  diet: json['diet'] as String?,
  idCard: json['id_card'] == null
      ? null
      : Document.fromJson(json['id_card'] as Map<String, dynamic>),
  medicalCertificate: json['medical_certificate'] == null
      ? null
      : Document.fromJson(json['medical_certificate'] as Map<String, dynamic>),
  securityFile: json['security_file'] == null
      ? null
      : SecurityFile.fromJson(json['security_file'] as Map<String, dynamic>),
  studentCard: json['student_card'] == null
      ? null
      : Document.fromJson(json['student_card'] as Map<String, dynamic>),
  raidRules: json['raid_rules'] == null
      ? null
      : Document.fromJson(json['raid_rules'] as Map<String, dynamic>),
  parentAuthorization: json['parent_authorization'] == null
      ? null
      : Document.fromJson(json['parent_authorization'] as Map<String, dynamic>),
  attestationOnHonour: json['attestation_on_honour'] as bool? ?? false,
  isMinor: json['is_minor'] as bool? ?? false,
);

Map<String, dynamic> _$RaidParticipantToJson(RaidParticipant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'firstname': instance.firstname,
      'birthday': _dateToJson(instance.birthday),
      'phone': instance.phone,
      'email': instance.email,
      'id': instance.id,
      'bike_size': sizeNullableToJson(instance.bikeSize),
      't_shirt_size': sizeNullableToJson(instance.tShirtSize),
      'situation': instance.situation,
      'validation_progress': instance.validationProgress,
      'payment': instance.payment,
      't_shirt_payment': instance.tShirtPayment,
      'number_of_document': instance.numberOfDocument,
      'number_of_validated_document': instance.numberOfValidatedDocument,
      'address': instance.address,
      'other_school': instance.otherSchool,
      'company': instance.company,
      'diet': instance.diet,
      'id_card': instance.idCard?.toJson(),
      'medical_certificate': instance.medicalCertificate?.toJson(),
      'security_file': instance.securityFile?.toJson(),
      'student_card': instance.studentCard?.toJson(),
      'raid_rules': instance.raidRules?.toJson(),
      'parent_authorization': instance.parentAuthorization?.toJson(),
      'attestation_on_honour': instance.attestationOnHonour,
      'is_minor': instance.isMinor,
    };

RaidParticipantBase _$RaidParticipantBaseFromJson(Map<String, dynamic> json) =>
    RaidParticipantBase(
      name: json['name'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      birthday: DateTime.parse(json['birthday'] as String),
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$RaidParticipantBaseToJson(
  RaidParticipantBase instance,
) => <String, dynamic>{
  'name': instance.name,
  'firstname': instance.firstname,
  'birthday': _dateToJson(instance.birthday),
  'phone': instance.phone,
  'email': instance.email,
};

RaidParticipantPreview _$RaidParticipantPreviewFromJson(
  Map<String, dynamic> json,
) => RaidParticipantPreview(
  name: json['name'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  birthday: DateTime.parse(json['birthday'] as String),
  phone: json['phone'] as String? ?? '',
  email: json['email'] as String? ?? '',
  id: json['id'] as String? ?? '',
  bikeSize: sizeNullableFromJson(json['bike_size']),
  tShirtSize: sizeNullableFromJson(json['t_shirt_size']),
  situation: json['situation'] as String?,
  validationProgress: (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
  payment: json['payment'] as bool? ?? false,
  tShirtPayment: json['t_shirt_payment'] as bool? ?? false,
  numberOfDocument: (json['number_of_document'] as num?)?.toInt() ?? 0,
  numberOfValidatedDocument:
      (json['number_of_validated_document'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RaidParticipantPreviewToJson(
  RaidParticipantPreview instance,
) => <String, dynamic>{
  'name': instance.name,
  'firstname': instance.firstname,
  'birthday': _dateToJson(instance.birthday),
  'phone': instance.phone,
  'email': instance.email,
  'id': instance.id,
  'bike_size': sizeNullableToJson(instance.bikeSize),
  't_shirt_size': sizeNullableToJson(instance.tShirtSize),
  'situation': instance.situation,
  'validation_progress': instance.validationProgress,
  'payment': instance.payment,
  't_shirt_payment': instance.tShirtPayment,
  'number_of_document': instance.numberOfDocument,
  'number_of_validated_document': instance.numberOfValidatedDocument,
};

RaidParticipantUpdate _$RaidParticipantUpdateFromJson(
  Map<String, dynamic> json,
) => RaidParticipantUpdate(
  name: json['name'] as String?,
  firstname: json['firstname'] as String?,
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  bikeSize: sizeNullableFromJson(json['bike_size']),
  tShirtSize: sizeNullableFromJson(json['t_shirt_size']),
  situation: json['situation'] as String?,
  otherSchool: json['other_school'] as String?,
  company: json['company'] as String?,
  diet: json['diet'] as String?,
  attestationOnHonour: json['attestation_on_honour'] as bool?,
  idCardId: json['id_card_id'] as String?,
  medicalCertificateId: json['medical_certificate_id'] as String?,
  securityFileId: json['security_file_id'] as String?,
  studentCardId: json['student_card_id'] as String?,
  raidRulesId: json['raid_rules_id'] as String?,
  parentAuthorizationId: json['parent_authorization_id'] as String?,
);

Map<String, dynamic> _$RaidParticipantUpdateToJson(
  RaidParticipantUpdate instance,
) => <String, dynamic>{
  'name': instance.name,
  'firstname': instance.firstname,
  'birthday': _dateToJson(instance.birthday),
  'address': instance.address,
  'phone': instance.phone,
  'email': instance.email,
  'bike_size': sizeNullableToJson(instance.bikeSize),
  't_shirt_size': sizeNullableToJson(instance.tShirtSize),
  'situation': instance.situation,
  'other_school': instance.otherSchool,
  'company': instance.company,
  'diet': instance.diet,
  'attestation_on_honour': instance.attestationOnHonour,
  'id_card_id': instance.idCardId,
  'medical_certificate_id': instance.medicalCertificateId,
  'security_file_id': instance.securityFileId,
  'student_card_id': instance.studentCardId,
  'raid_rules_id': instance.raidRulesId,
  'parent_authorization_id': instance.parentAuthorizationId,
};

RaidPrice _$RaidPriceFromJson(Map<String, dynamic> json) => RaidPrice(
  studentPrice: (json['student_price'] as num?)?.toInt(),
  partnerPrice: (json['partner_price'] as num?)?.toInt(),
  externalPrice: (json['external_price'] as num?)?.toInt(),
  tShirtPrice: (json['t_shirt_price'] as num?)?.toInt(),
);

Map<String, dynamic> _$RaidPriceToJson(RaidPrice instance) => <String, dynamic>{
  'student_price': instance.studentPrice,
  'partner_price': instance.partnerPrice,
  'external_price': instance.externalPrice,
  't_shirt_price': instance.tShirtPrice,
};

RaidTeam _$RaidTeamFromJson(Map<String, dynamic> json) => RaidTeam(
  name: json['name'] as String? ?? '',
  id: json['id'] as String? ?? '',
  number: (json['number'] as num?)?.toInt(),
  captain: RaidParticipant.fromJson(json['captain'] as Map<String, dynamic>),
  second: json['second'] == null
      ? null
      : RaidParticipant.fromJson(json['second'] as Map<String, dynamic>),
  difficulty: difficultyNullableFromJson(json['difficulty']),
  meetingPlace: meetingPlaceNullableFromJson(json['meeting_place']),
  validationProgress: (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
  fileId: json['file_id'] as String?,
);

Map<String, dynamic> _$RaidTeamToJson(RaidTeam instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
  'number': instance.number,
  'captain': instance.captain.toJson(),
  'second': instance.second?.toJson(),
  'difficulty': difficultyNullableToJson(instance.difficulty),
  'meeting_place': meetingPlaceNullableToJson(instance.meetingPlace),
  'validation_progress': instance.validationProgress,
  'file_id': instance.fileId,
};

RaidTeamBase _$RaidTeamBaseFromJson(Map<String, dynamic> json) =>
    RaidTeamBase(name: json['name'] as String? ?? '');

Map<String, dynamic> _$RaidTeamBaseToJson(RaidTeamBase instance) =>
    <String, dynamic>{'name': instance.name};

RaidTeamPreview _$RaidTeamPreviewFromJson(
  Map<String, dynamic> json,
) => RaidTeamPreview(
  name: json['name'] as String? ?? '',
  id: json['id'] as String? ?? '',
  number: (json['number'] as num?)?.toInt(),
  captain: RaidParticipantPreview.fromJson(
    json['captain'] as Map<String, dynamic>,
  ),
  second: json['second'] == null
      ? null
      : RaidParticipantPreview.fromJson(json['second'] as Map<String, dynamic>),
  difficulty: difficultyNullableFromJson(json['difficulty']),
  meetingPlace: meetingPlaceNullableFromJson(json['meeting_place']),
  validationProgress: (json['validation_progress'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$RaidTeamPreviewToJson(RaidTeamPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'number': instance.number,
      'captain': instance.captain.toJson(),
      'second': instance.second?.toJson(),
      'difficulty': difficultyNullableToJson(instance.difficulty),
      'meeting_place': meetingPlaceNullableToJson(instance.meetingPlace),
      'validation_progress': instance.validationProgress,
    };

RaidTeamUpdate _$RaidTeamUpdateFromJson(Map<String, dynamic> json) =>
    RaidTeamUpdate(
      name: json['name'] as String?,
      number: (json['number'] as num?)?.toInt(),
      difficulty: difficultyNullableFromJson(json['difficulty']),
      meetingPlace: meetingPlaceNullableFromJson(json['meeting_place']),
    );

Map<String, dynamic> _$RaidTeamUpdateToJson(RaidTeamUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'difficulty': difficultyNullableToJson(instance.difficulty),
      'meeting_place': meetingPlaceNullableToJson(instance.meetingPlace),
    };

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      title: json['title'] as String? ?? '',
      code: json['code'] as String?,
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
      code: json['code'] as String?,
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
      title: json['title'] as String?,
      code: json['code'] as String?,
      summary: json['summary'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecommendationEditToJson(RecommendationEdit instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'summary': instance.summary,
      'description': instance.description,
    };

RefundBase _$RefundBaseFromJson(Map<String, dynamic> json) => RefundBase(
  id: json['id'] as String? ?? '',
  total: (json['total'] as num?)?.toInt() ?? 0,
  creation: DateTime.parse(json['creation'] as String),
  transactionId: json['transaction_id'] as String? ?? '',
  sellerUserId: json['seller_user_id'] as String?,
  creditedWalletId: json['credited_wallet_id'] as String? ?? '',
  debitedWalletId: json['debited_wallet_id'] as String? ?? '',
);

Map<String, dynamic> _$RefundBaseToJson(RefundBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
      'transaction_id': instance.transactionId,
      'seller_user_id': instance.sellerUserId,
      'credited_wallet_id': instance.creditedWalletId,
      'debited_wallet_id': instance.debitedWalletId,
    };

RefundInfo _$RefundInfoFromJson(Map<String, dynamic> json) => RefundInfo(
  completeRefund: json['complete_refund'] as bool? ?? false,
  amount: (json['amount'] as num?)?.toInt(),
);

Map<String, dynamic> _$RefundInfoToJson(RefundInfo instance) =>
    <String, dynamic>{
      'complete_refund': instance.completeRefund,
      'amount': instance.amount,
    };

Request$ _$Request$FromJson(Map<String, dynamic> json) => Request$(
  id: json['id'] as String? ?? '',
  walletId: json['wallet_id'] as String? ?? '',
  creation: DateTime.parse(json['creation'] as String),
  expirationDate: DateTime.parse(json['expiration_date'] as String),
  total: (json['total'] as num?)?.toInt() ?? 0,
  storeId: json['store_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  storeNote: json['store_note'] as String?,
  module: json['module'] as String? ?? '',
  objectId: json['object_id'] as String? ?? '',
  status: requestStatusFromJson(json['status']),
  transactionId: json['transaction_id'] as String?,
);

Map<String, dynamic> _$Request$ToJson(Request$ instance) => <String, dynamic>{
  'id': instance.id,
  'wallet_id': instance.walletId,
  'creation': instance.creation.toIso8601String(),
  'expiration_date': instance.expirationDate.toIso8601String(),
  'total': instance.total,
  'store_id': instance.storeId,
  'name': instance.name,
  'store_note': instance.storeNote,
  'module': instance.module,
  'object_id': instance.objectId,
  'status': requestStatusToJson(instance.status),
  'transaction_id': instance.transactionId,
};

ResetPasswordRequest _$ResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequest(
  resetToken: json['reset_token'] as String? ?? '',
  newPassword: json['new_password'] as String? ?? '',
);

Map<String, dynamic> _$ResetPasswordRequestToJson(
  ResetPasswordRequest instance,
) => <String, dynamic>{
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
    <String, dynamic>{'tags': instance.tags};

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
  id: json['id'] as String? ?? '',
  tot: (json['tot'] as num?)?.toInt() ?? 0,
  iat: DateTime.parse(json['iat'] as String),
  key: json['key'] as String? ?? '',
  store: json['store'] as bool? ?? false,
  signature: json['signature'] as String? ?? '',
  bypassMembership: json['bypass_membership'] as bool? ?? false,
);

Map<String, dynamic> _$ScanInfoToJson(ScanInfo instance) => <String, dynamic>{
  'id': instance.id,
  'tot': instance.tot,
  'iat': instance.iat.toIso8601String(),
  'key': instance.key,
  'store': instance.store,
  'signature': instance.signature,
  'bypass_membership': instance.bypassMembership,
};

SchoolExtension _$SchoolExtensionFromJson(Map<String, dynamic> json) =>
    SchoolExtension(
      schoolId: json['school_id'] as String? ?? '',
      fromLyon: json['from_lyon'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
      inscriptionEnabled: json['inscription_enabled'] as bool? ?? false,
      school: CoreSchool.fromJson(json['school'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchoolExtensionToJson(SchoolExtension instance) =>
    <String, dynamic>{
      'school_id': instance.schoolId,
      'from_lyon': instance.fromLyon,
      'active': instance.active,
      'inscription_enabled': instance.inscriptionEnabled,
      'school': instance.school.toJson(),
    };

SchoolExtensionBase _$SchoolExtensionBaseFromJson(Map<String, dynamic> json) =>
    SchoolExtensionBase(
      schoolId: json['school_id'] as String? ?? '',
      fromLyon: json['from_lyon'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
      inscriptionEnabled: json['inscription_enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$SchoolExtensionBaseToJson(
  SchoolExtensionBase instance,
) => <String, dynamic>{
  'school_id': instance.schoolId,
  'from_lyon': instance.fromLyon,
  'active': instance.active,
  'inscription_enabled': instance.inscriptionEnabled,
};

SchoolExtensionEdit _$SchoolExtensionEditFromJson(Map<String, dynamic> json) =>
    SchoolExtensionEdit(
      fromLyon: json['from_lyon'] as bool?,
      active: json['active'] as bool?,
      inscriptionEnabled: json['inscription_enabled'] as bool?,
    );

Map<String, dynamic> _$SchoolExtensionEditToJson(
  SchoolExtensionEdit instance,
) => <String, dynamic>{
  'from_lyon': instance.fromLyon,
  'active': instance.active,
  'inscription_enabled': instance.inscriptionEnabled,
};

SchoolGeneralQuota _$SchoolGeneralQuotaFromJson(
  Map<String, dynamic> json,
) => SchoolGeneralQuota(
  athleteQuota: (json['athlete_quota'] as num?)?.toInt(),
  cameramanQuota: (json['cameraman_quota'] as num?)?.toInt(),
  pompomQuota: (json['pompom_quota'] as num?)?.toInt(),
  fanfareQuota: (json['fanfare_quota'] as num?)?.toInt(),
  athleteCameramanQuota: (json['athlete_cameraman_quota'] as num?)?.toInt(),
  athletePompomQuota: (json['athlete_pompom_quota'] as num?)?.toInt(),
  athleteFanfareQuota: (json['athlete_fanfare_quota'] as num?)?.toInt(),
  nonAthleteCameramanQuota: (json['non_athlete_cameraman_quota'] as num?)
      ?.toInt(),
  nonAthletePompomQuota: (json['non_athlete_pompom_quota'] as num?)?.toInt(),
  nonAthleteFanfareQuota: (json['non_athlete_fanfare_quota'] as num?)?.toInt(),
  schoolId: json['school_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
);

Map<String, dynamic> _$SchoolGeneralQuotaToJson(SchoolGeneralQuota instance) =>
    <String, dynamic>{
      'athlete_quota': instance.athleteQuota,
      'cameraman_quota': instance.cameramanQuota,
      'pompom_quota': instance.pompomQuota,
      'fanfare_quota': instance.fanfareQuota,
      'athlete_cameraman_quota': instance.athleteCameramanQuota,
      'athlete_pompom_quota': instance.athletePompomQuota,
      'athlete_fanfare_quota': instance.athleteFanfareQuota,
      'non_athlete_cameraman_quota': instance.nonAthleteCameramanQuota,
      'non_athlete_pompom_quota': instance.nonAthletePompomQuota,
      'non_athlete_fanfare_quota': instance.nonAthleteFanfareQuota,
      'school_id': instance.schoolId,
      'edition_id': instance.editionId,
    };

SchoolGeneralQuotaBase _$SchoolGeneralQuotaBaseFromJson(
  Map<String, dynamic> json,
) => SchoolGeneralQuotaBase(
  athleteQuota: (json['athlete_quota'] as num?)?.toInt(),
  cameramanQuota: (json['cameraman_quota'] as num?)?.toInt(),
  pompomQuota: (json['pompom_quota'] as num?)?.toInt(),
  fanfareQuota: (json['fanfare_quota'] as num?)?.toInt(),
  athleteCameramanQuota: (json['athlete_cameraman_quota'] as num?)?.toInt(),
  athletePompomQuota: (json['athlete_pompom_quota'] as num?)?.toInt(),
  athleteFanfareQuota: (json['athlete_fanfare_quota'] as num?)?.toInt(),
  nonAthleteCameramanQuota: (json['non_athlete_cameraman_quota'] as num?)
      ?.toInt(),
  nonAthletePompomQuota: (json['non_athlete_pompom_quota'] as num?)?.toInt(),
  nonAthleteFanfareQuota: (json['non_athlete_fanfare_quota'] as num?)?.toInt(),
);

Map<String, dynamic> _$SchoolGeneralQuotaBaseToJson(
  SchoolGeneralQuotaBase instance,
) => <String, dynamic>{
  'athlete_quota': instance.athleteQuota,
  'cameraman_quota': instance.cameramanQuota,
  'pompom_quota': instance.pompomQuota,
  'fanfare_quota': instance.fanfareQuota,
  'athlete_cameraman_quota': instance.athleteCameramanQuota,
  'athlete_pompom_quota': instance.athletePompomQuota,
  'athlete_fanfare_quota': instance.athleteFanfareQuota,
  'non_athlete_cameraman_quota': instance.nonAthleteCameramanQuota,
  'non_athlete_pompom_quota': instance.nonAthletePompomQuota,
  'non_athlete_fanfare_quota': instance.nonAthleteFanfareQuota,
};

SchoolProductQuota _$SchoolProductQuotaFromJson(Map<String, dynamic> json) =>
    SchoolProductQuota(
      productId: json['product_id'] as String? ?? '',
      quota: (json['quota'] as num?)?.toInt() ?? 0,
      schoolId: json['school_id'] as String? ?? '',
      editionId: json['edition_id'] as String? ?? '',
    );

Map<String, dynamic> _$SchoolProductQuotaToJson(SchoolProductQuota instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'quota': instance.quota,
      'school_id': instance.schoolId,
      'edition_id': instance.editionId,
    };

SchoolProductQuotaBase _$SchoolProductQuotaBaseFromJson(
  Map<String, dynamic> json,
) => SchoolProductQuotaBase(
  productId: json['product_id'] as String? ?? '',
  quota: (json['quota'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SchoolProductQuotaBaseToJson(
  SchoolProductQuotaBase instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'quota': instance.quota,
};

SchoolProductQuotaEdit _$SchoolProductQuotaEditFromJson(
  Map<String, dynamic> json,
) => SchoolProductQuotaEdit(quota: (json['quota'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$SchoolProductQuotaEditToJson(
  SchoolProductQuotaEdit instance,
) => <String, dynamic>{'quota': instance.quota};

SchoolResult _$SchoolResultFromJson(Map<String, dynamic> json) => SchoolResult(
  schoolId: json['school_id'] as String? ?? '',
  totalPoints: (json['total_points'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SchoolResultToJson(SchoolResult instance) =>
    <String, dynamic>{
      'school_id': instance.schoolId,
      'total_points': instance.totalPoints,
    };

SchoolSportQuota _$SchoolSportQuotaFromJson(Map<String, dynamic> json) =>
    SchoolSportQuota(
      participantQuota: (json['participant_quota'] as num?)?.toInt(),
      teamQuota: (json['team_quota'] as num?)?.toInt(),
      schoolId: json['school_id'] as String? ?? '',
      sportId: json['sport_id'] as String? ?? '',
      editionId: json['edition_id'] as String? ?? '',
    );

Map<String, dynamic> _$SchoolSportQuotaToJson(SchoolSportQuota instance) =>
    <String, dynamic>{
      'participant_quota': instance.participantQuota,
      'team_quota': instance.teamQuota,
      'school_id': instance.schoolId,
      'sport_id': instance.sportId,
      'edition_id': instance.editionId,
    };

SchoolSportQuotaEdit _$SchoolSportQuotaEditFromJson(
  Map<String, dynamic> json,
) => SchoolSportQuotaEdit(
  participantQuota: (json['participant_quota'] as num?)?.toInt(),
  teamQuota: (json['team_quota'] as num?)?.toInt(),
);

Map<String, dynamic> _$SchoolSportQuotaEditToJson(
  SchoolSportQuotaEdit instance,
) => <String, dynamic>{
  'participant_quota': instance.participantQuota,
  'team_quota': instance.teamQuota,
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
  allergy: json['allergy'] as String?,
  asthma: json['asthma'] as bool? ?? false,
  intensiveCareUnit: json['intensive_care_unit'] as bool?,
  intensiveCareUnitWhen: json['intensive_care_unit_when'] as String?,
  ongoingTreatment: json['ongoing_treatment'] as String?,
  sicknesses: json['sicknesses'] as String?,
  hospitalization: json['hospitalization'] as String?,
  surgicalOperation: json['surgical_operation'] as String?,
  trauma: json['trauma'] as String?,
  family: json['family'] as String?,
  emergencyPersonFirstname: json['emergency_person_firstname'] as String?,
  emergencyPersonName: json['emergency_person_name'] as String?,
  emergencyPersonPhone: json['emergency_person_phone'] as String?,
  fileId: json['file_id'] as String?,
  validation: documentValidationFromJson(json['validation']),
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$SecurityFileToJson(SecurityFile instance) =>
    <String, dynamic>{
      'allergy': instance.allergy,
      'asthma': instance.asthma,
      'intensive_care_unit': instance.intensiveCareUnit,
      'intensive_care_unit_when': instance.intensiveCareUnitWhen,
      'ongoing_treatment': instance.ongoingTreatment,
      'sicknesses': instance.sicknesses,
      'hospitalization': instance.hospitalization,
      'surgical_operation': instance.surgicalOperation,
      'trauma': instance.trauma,
      'family': instance.family,
      'emergency_person_firstname': instance.emergencyPersonFirstname,
      'emergency_person_name': instance.emergencyPersonName,
      'emergency_person_phone': instance.emergencyPersonPhone,
      'file_id': instance.fileId,
      'validation': documentValidationToJson(instance.validation),
      'id': instance.id,
    };

SecurityFileBase _$SecurityFileBaseFromJson(Map<String, dynamic> json) =>
    SecurityFileBase(
      allergy: json['allergy'] as String?,
      asthma: json['asthma'] as bool? ?? false,
      intensiveCareUnit: json['intensive_care_unit'] as bool?,
      intensiveCareUnitWhen: json['intensive_care_unit_when'] as String?,
      ongoingTreatment: json['ongoing_treatment'] as String?,
      sicknesses: json['sicknesses'] as String?,
      hospitalization: json['hospitalization'] as String?,
      surgicalOperation: json['surgical_operation'] as String?,
      trauma: json['trauma'] as String?,
      family: json['family'] as String?,
      emergencyPersonFirstname: json['emergency_person_firstname'] as String?,
      emergencyPersonName: json['emergency_person_name'] as String?,
      emergencyPersonPhone: json['emergency_person_phone'] as String?,
      fileId: json['file_id'] as String?,
    );

Map<String, dynamic> _$SecurityFileBaseToJson(SecurityFileBase instance) =>
    <String, dynamic>{
      'allergy': instance.allergy,
      'asthma': instance.asthma,
      'intensive_care_unit': instance.intensiveCareUnit,
      'intensive_care_unit_when': instance.intensiveCareUnitWhen,
      'ongoing_treatment': instance.ongoingTreatment,
      'sicknesses': instance.sicknesses,
      'hospitalization': instance.hospitalization,
      'surgical_operation': instance.surgicalOperation,
      'trauma': instance.trauma,
      'family': instance.family,
      'emergency_person_firstname': instance.emergencyPersonFirstname,
      'emergency_person_name': instance.emergencyPersonName,
      'emergency_person_phone': instance.emergencyPersonPhone,
      'file_id': instance.fileId,
    };

SeedLibraryInformation _$SeedLibraryInformationFromJson(
  Map<String, dynamic> json,
) => SeedLibraryInformation(
  facebookUrl: json['facebook_url'] as String? ?? '',
  forumUrl: json['forum_url'] as String? ?? '',
  description: json['description'] as String? ?? '',
  contact: json['contact'] as String? ?? '',
);

Map<String, dynamic> _$SeedLibraryInformationToJson(
  SeedLibraryInformation instance,
) => <String, dynamic>{
  'facebook_url': instance.facebookUrl,
  'forum_url': instance.forumUrl,
  'description': instance.description,
  'contact': instance.contact,
};

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller(
  userId: json['user_id'] as String? ?? '',
  storeId: json['store_id'] as String? ?? '',
  canBank: json['can_bank'] as bool? ?? false,
  canSeeHistory: json['can_see_history'] as bool? ?? false,
  canCancel: json['can_cancel'] as bool? ?? false,
  canManageSellers: json['can_manage_sellers'] as bool? ?? false,
  canManageEvents: json['can_manage_events'] as bool? ?? false,
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
  'user_id': instance.userId,
  'store_id': instance.storeId,
  'can_bank': instance.canBank,
  'can_see_history': instance.canSeeHistory,
  'can_cancel': instance.canCancel,
  'can_manage_sellers': instance.canManageSellers,
  'can_manage_events': instance.canManageEvents,
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
      canManageEvents: json['can_manage_events'] as bool? ?? false,
    );

Map<String, dynamic> _$SellerCreationToJson(SellerCreation instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'can_bank': instance.canBank,
      'can_see_history': instance.canSeeHistory,
      'can_cancel': instance.canCancel,
      'can_manage_sellers': instance.canManageSellers,
      'can_manage_events': instance.canManageEvents,
    };

SellerEdit _$SellerEditFromJson(Map<String, dynamic> json) => SellerEdit(
  name: json['name'] as String?,
  groupId: json['group_id'] as String?,
  order: (json['order'] as num?)?.toInt(),
);

Map<String, dynamic> _$SellerEditToJson(SellerEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'group_id': instance.groupId,
      'order': instance.order,
    };

SellerUpdate _$SellerUpdateFromJson(Map<String, dynamic> json) => SellerUpdate(
  canBank: json['can_bank'] as bool?,
  canSeeHistory: json['can_see_history'] as bool?,
  canCancel: json['can_cancel'] as bool?,
  canManageSellers: json['can_manage_sellers'] as bool?,
  canManageEvents: json['can_manage_events'] as bool?,
);

Map<String, dynamic> _$SellerUpdateToJson(SellerUpdate instance) =>
    <String, dynamic>{
      'can_bank': instance.canBank,
      'can_see_history': instance.canSeeHistory,
      'can_cancel': instance.canCancel,
      'can_manage_sellers': instance.canManageSellers,
      'can_manage_events': instance.canManageEvents,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
  id: json['id'] as String? ?? '',
  eventId: json['event_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  startDatetime: DateTime.parse(json['start_datetime'] as String),
  disabled: json['disabled'] as bool? ?? false,
);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'id': instance.id,
  'event_id': instance.eventId,
  'name': instance.name,
  'start_datetime': instance.startDatetime.toIso8601String(),
  'disabled': instance.disabled,
};

SessionAdmin _$SessionAdminFromJson(Map<String, dynamic> json) => SessionAdmin(
  id: json['id'] as String? ?? '',
  eventId: json['event_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  startDatetime: DateTime.parse(json['start_datetime'] as String),
  disabled: json['disabled'] as bool? ?? false,
  quota: (json['quota'] as num?)?.toInt(),
  ticketsInCheckout: (json['tickets_in_checkout'] as num?)?.toInt() ?? 0,
  ticketsSold: (json['tickets_sold'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SessionAdminToJson(SessionAdmin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'start_datetime': instance.startDatetime.toIso8601String(),
      'disabled': instance.disabled,
      'quota': instance.quota,
      'tickets_in_checkout': instance.ticketsInCheckout,
      'tickets_sold': instance.ticketsSold,
    };

SessionComplete _$SessionCompleteFromJson(Map<String, dynamic> json) =>
    SessionComplete(
      id: json['id'] as String? ?? '',
      eventId: json['event_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      startDatetime: DateTime.parse(json['start_datetime'] as String),
      disabled: json['disabled'] as bool? ?? false,
      quota: (json['quota'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SessionCompleteToJson(SessionComplete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'start_datetime': instance.startDatetime.toIso8601String(),
      'disabled': instance.disabled,
      'quota': instance.quota,
    };

SessionCreate _$SessionCreateFromJson(Map<String, dynamic> json) =>
    SessionCreate(
      name: json['name'] as String? ?? '',
      startDatetime: DateTime.parse(json['start_datetime'] as String),
      quota: (json['quota'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SessionCreateToJson(SessionCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'start_datetime': instance.startDatetime.toIso8601String(),
      'quota': instance.quota,
    };

SessionPublic _$SessionPublicFromJson(Map<String, dynamic> json) =>
    SessionPublic(
      id: json['id'] as String? ?? '',
      eventId: json['event_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      startDatetime: DateTime.parse(json['start_datetime'] as String),
      disabled: json['disabled'] as bool? ?? false,
      soldOut: json['sold_out'] as bool? ?? false,
    );

Map<String, dynamic> _$SessionPublicToJson(SessionPublic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'name': instance.name,
      'start_datetime': instance.startDatetime.toIso8601String(),
      'disabled': instance.disabled,
      'sold_out': instance.soldOut,
    };

SessionUpdate _$SessionUpdateFromJson(Map<String, dynamic> json) =>
    SessionUpdate(
      name: json['name'] as String?,
      startDatetime: json['start_datetime'] == null
          ? null
          : DateTime.parse(json['start_datetime'] as String),
      quota: (json['quota'] as num?)?.toInt(),
      disabled: json['disabled'] as bool?,
    );

Map<String, dynamic> _$SessionUpdateToJson(SessionUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'start_datetime': instance.startDatetime?.toIso8601String(),
      'quota': instance.quota,
      'disabled': instance.disabled,
    };

SignatureBase _$SignatureBaseFromJson(Map<String, dynamic> json) =>
    SignatureBase(
      signatureType: documentSignatureTypeFromJson(json['signature_type']),
      numericSignatureId: json['numeric_signature_id'] as String?,
    );

Map<String, dynamic> _$SignatureBaseToJson(SignatureBase instance) =>
    <String, dynamic>{
      'signature_type': documentSignatureTypeToJson(instance.signatureType),
      'numeric_signature_id': instance.numericSignatureId,
    };

SignatureComplete _$SignatureCompleteFromJson(Map<String, dynamic> json) =>
    SignatureComplete(
      signatureType: documentSignatureTypeFromJson(json['signature_type']),
      numericSignatureId: json['numeric_signature_id'] as String?,
      userId: json['user_id'] as String? ?? '',
      documentId: json['document_id'] as String? ?? '',
    );

Map<String, dynamic> _$SignatureCompleteToJson(SignatureComplete instance) =>
    <String, dynamic>{
      'signature_type': documentSignatureTypeToJson(instance.signatureType),
      'numeric_signature_id': instance.numericSignatureId,
      'user_id': instance.userId,
      'document_id': instance.documentId,
    };

SignedContent _$SignedContentFromJson(Map<String, dynamic> json) =>
    SignedContent(
      id: json['id'] as String? ?? '',
      tot: (json['tot'] as num?)?.toInt() ?? 0,
      iat: DateTime.parse(json['iat'] as String),
      key: json['key'] as String? ?? '',
      store: json['store'] as bool? ?? false,
      signature: json['signature'] as String? ?? '',
    );

Map<String, dynamic> _$SignedContentToJson(SignedContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tot': instance.tot,
      'iat': instance.iat.toIso8601String(),
      'key': instance.key,
      'store': instance.store,
      'signature': instance.signature,
    };

SpeciesBase _$SpeciesBaseFromJson(Map<String, dynamic> json) => SpeciesBase(
  prefix: json['prefix'] as String? ?? '',
  name: json['name'] as String? ?? '',
  difficulty: (json['difficulty'] as num?)?.toInt() ?? 0,
  speciesType: speciesTypeFromJson(json['species_type']),
  card: json['card'] as String?,
  nbSeedsRecommended: (json['nb_seeds_recommended'] as num?)?.toInt(),
  startSeason: json['start_season'] == null
      ? null
      : DateTime.parse(json['start_season'] as String),
  endSeason: json['end_season'] == null
      ? null
      : DateTime.parse(json['end_season'] as String),
  timeMaturation: (json['time_maturation'] as num?)?.toInt(),
);

Map<String, dynamic> _$SpeciesBaseToJson(SpeciesBase instance) =>
    <String, dynamic>{
      'prefix': instance.prefix,
      'name': instance.name,
      'difficulty': instance.difficulty,
      'species_type': speciesTypeToJson(instance.speciesType),
      'card': instance.card,
      'nb_seeds_recommended': instance.nbSeedsRecommended,
      'start_season': _dateToJson(instance.startSeason),
      'end_season': _dateToJson(instance.endSeason),
      'time_maturation': instance.timeMaturation,
    };

SpeciesComplete _$SpeciesCompleteFromJson(Map<String, dynamic> json) =>
    SpeciesComplete(
      prefix: json['prefix'] as String? ?? '',
      name: json['name'] as String? ?? '',
      difficulty: (json['difficulty'] as num?)?.toInt() ?? 0,
      speciesType: speciesTypeFromJson(json['species_type']),
      card: json['card'] as String?,
      nbSeedsRecommended: (json['nb_seeds_recommended'] as num?)?.toInt(),
      startSeason: json['start_season'] == null
          ? null
          : DateTime.parse(json['start_season'] as String),
      endSeason: json['end_season'] == null
          ? null
          : DateTime.parse(json['end_season'] as String),
      timeMaturation: (json['time_maturation'] as num?)?.toInt(),
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$SpeciesCompleteToJson(SpeciesComplete instance) =>
    <String, dynamic>{
      'prefix': instance.prefix,
      'name': instance.name,
      'difficulty': instance.difficulty,
      'species_type': speciesTypeToJson(instance.speciesType),
      'card': instance.card,
      'nb_seeds_recommended': instance.nbSeedsRecommended,
      'start_season': _dateToJson(instance.startSeason),
      'end_season': _dateToJson(instance.endSeason),
      'time_maturation': instance.timeMaturation,
      'id': instance.id,
    };

SpeciesEdit _$SpeciesEditFromJson(Map<String, dynamic> json) => SpeciesEdit(
  name: json['name'] as String?,
  prefix: json['prefix'] as String?,
  difficulty: (json['difficulty'] as num?)?.toInt(),
  card: json['card'] as String?,
  speciesType: speciesTypeNullableFromJson(json['species_type']),
  nbSeedsRecommended: (json['nb_seeds_recommended'] as num?)?.toInt(),
  startSeason: json['start_season'] == null
      ? null
      : DateTime.parse(json['start_season'] as String),
  endSeason: json['end_season'] == null
      ? null
      : DateTime.parse(json['end_season'] as String),
  timeMaturation: (json['time_maturation'] as num?)?.toInt(),
);

Map<String, dynamic> _$SpeciesEditToJson(SpeciesEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'prefix': instance.prefix,
      'difficulty': instance.difficulty,
      'card': instance.card,
      'species_type': speciesTypeNullableToJson(instance.speciesType),
      'nb_seeds_recommended': instance.nbSeedsRecommended,
      'start_season': _dateToJson(instance.startSeason),
      'end_season': _dateToJson(instance.endSeason),
      'time_maturation': instance.timeMaturation,
    };

SpeciesTypesReturn _$SpeciesTypesReturnFromJson(Map<String, dynamic> json) =>
    SpeciesTypesReturn(
      speciesType: speciesTypeListFromJson(json['species_type'] as List?),
    );

Map<String, dynamic> _$SpeciesTypesReturnToJson(SpeciesTypesReturn instance) =>
    <String, dynamic>{
      'species_type': speciesTypeListToJson(instance.speciesType),
    };

Sport _$SportFromJson(Map<String, dynamic> json) => Sport(
  name: json['name'] as String? ?? '',
  teamSize: (json['team_size'] as num?)?.toInt() ?? 0,
  substituteMax: (json['substitute_max'] as num?)?.toInt(),
  sportCategory: sportCategoryNullableFromJson(json['sport_category']),
  active: json['active'] as bool? ?? true,
  id: json['id'] as String? ?? '',
);

Map<String, dynamic> _$SportToJson(Sport instance) => <String, dynamic>{
  'name': instance.name,
  'team_size': instance.teamSize,
  'substitute_max': instance.substituteMax,
  'sport_category': sportCategoryNullableToJson(instance.sportCategory),
  'active': instance.active,
  'id': instance.id,
};

SportBase _$SportBaseFromJson(Map<String, dynamic> json) => SportBase(
  name: json['name'] as String? ?? '',
  teamSize: (json['team_size'] as num?)?.toInt() ?? 0,
  substituteMax: (json['substitute_max'] as num?)?.toInt(),
  sportCategory: sportCategoryNullableFromJson(json['sport_category']),
  active: json['active'] as bool? ?? true,
);

Map<String, dynamic> _$SportBaseToJson(SportBase instance) => <String, dynamic>{
  'name': instance.name,
  'team_size': instance.teamSize,
  'substitute_max': instance.substituteMax,
  'sport_category': sportCategoryNullableToJson(instance.sportCategory),
  'active': instance.active,
};

SportEdit _$SportEditFromJson(Map<String, dynamic> json) => SportEdit(
  name: json['name'] as String?,
  teamSize: (json['team_size'] as num?)?.toInt(),
  substituteMax: (json['substitute_max'] as num?)?.toInt(),
  sportCategory: sportCategoryNullableFromJson(json['sport_category']),
  active: json['active'] as bool?,
);

Map<String, dynamic> _$SportEditToJson(SportEdit instance) => <String, dynamic>{
  'name': instance.name,
  'team_size': instance.teamSize,
  'substitute_max': instance.substituteMax,
  'sport_category': sportCategoryNullableToJson(instance.sportCategory),
  'active': instance.active,
};

SportPodiumRankings _$SportPodiumRankingsFromJson(Map<String, dynamic> json) =>
    SportPodiumRankings(
      rankings:
          (json['rankings'] as List<dynamic>?)
              ?.map(
                (e) => TeamSportResultBase.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$SportPodiumRankingsToJson(
  SportPodiumRankings instance,
) => <String, dynamic>{
  'rankings': instance.rankings.map((e) => e.toJson()).toList(),
};

SportQuotaInfo _$SportQuotaInfoFromJson(Map<String, dynamic> json) =>
    SportQuotaInfo(
      participantQuota: (json['participant_quota'] as num?)?.toInt(),
      teamQuota: (json['team_quota'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SportQuotaInfoToJson(SportQuotaInfo instance) =>
    <String, dynamic>{
      'participant_quota': instance.participantQuota,
      'team_quota': instance.teamQuota,
    };

Status _$StatusFromJson(Map<String, dynamic> json) =>
    Status(status: Status.cdrStatusStatusNullableFromJson(json['status']));

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'status': cdrStatusNullableToJson(instance.status),
};

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
  name: json['name'] as String? ?? '',
  associationId: json['association_id'] as String?,
  id: json['id'] as String? ?? '',
  structureId: json['structure_id'] as String? ?? '',
  walletId: json['wallet_id'] as String? ?? '',
  creation: DateTime.parse(json['creation'] as String),
  structure: Structure.fromJson(json['structure'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'name': instance.name,
  'association_id': instance.associationId,
  'id': instance.id,
  'structure_id': instance.structureId,
  'wallet_id': instance.walletId,
  'creation': instance.creation.toIso8601String(),
  'structure': instance.structure.toJson(),
};

StoreBase _$StoreBaseFromJson(Map<String, dynamic> json) => StoreBase(
  name: json['name'] as String? ?? '',
  associationId: json['association_id'] as String?,
);

Map<String, dynamic> _$StoreBaseToJson(StoreBase instance) => <String, dynamic>{
  'name': instance.name,
  'association_id': instance.associationId,
};

StoreSimple _$StoreSimpleFromJson(Map<String, dynamic> json) => StoreSimple(
  name: json['name'] as String? ?? '',
  associationId: json['association_id'] as String?,
  id: json['id'] as String? ?? '',
  structureId: json['structure_id'] as String? ?? '',
  walletId: json['wallet_id'] as String? ?? '',
  creation: DateTime.parse(json['creation'] as String),
);

Map<String, dynamic> _$StoreSimpleToJson(StoreSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
      'association_id': instance.associationId,
      'id': instance.id,
      'structure_id': instance.structureId,
      'wallet_id': instance.walletId,
      'creation': instance.creation.toIso8601String(),
    };

StoreUpdate _$StoreUpdateFromJson(Map<String, dynamic> json) => StoreUpdate(
  name: json['name'] as String?,
  associationId: json['association_id'] as String?,
);

Map<String, dynamic> _$StoreUpdateToJson(StoreUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'association_id': instance.associationId,
    };

Structure _$StructureFromJson(Map<String, dynamic> json) => Structure(
  shortId: json['short_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  associationMembershipId: json['association_membership_id'] as String?,
  managerUserId: json['manager_user_id'] as String? ?? '',
  siegeAddressStreet: json['siege_address_street'] as String? ?? '',
  siegeAddressCity: json['siege_address_city'] as String? ?? '',
  siegeAddressZipcode: json['siege_address_zipcode'] as String? ?? '',
  siegeAddressCountry: json['siege_address_country'] as String? ?? '',
  siret: json['siret'] as String?,
  iban: json['iban'] as String? ?? '',
  bic: json['bic'] as String? ?? '',
  id: json['id'] as String? ?? '',
  creation: DateTime.parse(json['creation'] as String),
  managerUser: CoreUserSimple.fromJson(
    json['manager_user'] as Map<String, dynamic>,
  ),
  associationMembership: json['association_membership'] == null
      ? null
      : MembershipSimple.fromJson(
          json['association_membership'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$StructureToJson(Structure instance) => <String, dynamic>{
  'short_id': instance.shortId,
  'name': instance.name,
  'association_membership_id': instance.associationMembershipId,
  'manager_user_id': instance.managerUserId,
  'siege_address_street': instance.siegeAddressStreet,
  'siege_address_city': instance.siegeAddressCity,
  'siege_address_zipcode': instance.siegeAddressZipcode,
  'siege_address_country': instance.siegeAddressCountry,
  'siret': instance.siret,
  'iban': instance.iban,
  'bic': instance.bic,
  'id': instance.id,
  'creation': instance.creation.toIso8601String(),
  'manager_user': instance.managerUser.toJson(),
  'association_membership': instance.associationMembership?.toJson(),
};

StructureBase _$StructureBaseFromJson(Map<String, dynamic> json) =>
    StructureBase(
      shortId: json['short_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      associationMembershipId: json['association_membership_id'] as String?,
      managerUserId: json['manager_user_id'] as String? ?? '',
      siegeAddressStreet: json['siege_address_street'] as String? ?? '',
      siegeAddressCity: json['siege_address_city'] as String? ?? '',
      siegeAddressZipcode: json['siege_address_zipcode'] as String? ?? '',
      siegeAddressCountry: json['siege_address_country'] as String? ?? '',
      siret: json['siret'] as String?,
      iban: json['iban'] as String? ?? '',
      bic: json['bic'] as String? ?? '',
    );

Map<String, dynamic> _$StructureBaseToJson(StructureBase instance) =>
    <String, dynamic>{
      'short_id': instance.shortId,
      'name': instance.name,
      'association_membership_id': instance.associationMembershipId,
      'manager_user_id': instance.managerUserId,
      'siege_address_street': instance.siegeAddressStreet,
      'siege_address_city': instance.siegeAddressCity,
      'siege_address_zipcode': instance.siegeAddressZipcode,
      'siege_address_country': instance.siegeAddressCountry,
      'siret': instance.siret,
      'iban': instance.iban,
      'bic': instance.bic,
    };

StructureTranfert _$StructureTranfertFromJson(Map<String, dynamic> json) =>
    StructureTranfert(
      newManagerUserId: json['new_manager_user_id'] as String? ?? '',
    );

Map<String, dynamic> _$StructureTranfertToJson(StructureTranfert instance) =>
    <String, dynamic>{'new_manager_user_id': instance.newManagerUserId};

StructureUpdate _$StructureUpdateFromJson(Map<String, dynamic> json) =>
    StructureUpdate(
      name: json['name'] as String?,
      shortId: json['short_id'] as String?,
      associationMembershipId: json['association_membership_id'] as String?,
      siret: json['siret'] as String?,
      siegeAddressStreet: json['siege_address_street'] as String?,
      siegeAddressCity: json['siege_address_city'] as String?,
      siegeAddressZipcode: json['siege_address_zipcode'] as String?,
      siegeAddressCountry: json['siege_address_country'] as String?,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
    );

Map<String, dynamic> _$StructureUpdateToJson(StructureUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'short_id': instance.shortId,
      'association_membership_id': instance.associationMembershipId,
      'siret': instance.siret,
      'siege_address_street': instance.siegeAddressStreet,
      'siege_address_city': instance.siegeAddressCity,
      'siege_address_zipcode': instance.siegeAddressZipcode,
      'siege_address_country': instance.siegeAddressCountry,
      'iban': instance.iban,
      'bic': instance.bic,
    };

TOSSignature _$TOSSignatureFromJson(Map<String, dynamic> json) => TOSSignature(
  acceptedTosVersion: (json['accepted_tos_version'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TOSSignatureToJson(TOSSignature instance) =>
    <String, dynamic>{'accepted_tos_version': instance.acceptedTosVersion};

TOSSignatureResponse _$TOSSignatureResponseFromJson(
  Map<String, dynamic> json,
) => TOSSignatureResponse(
  acceptedTosVersion: (json['accepted_tos_version'] as num?)?.toInt() ?? 0,
  latestTosVersion: (json['latest_tos_version'] as num?)?.toInt() ?? 0,
  tosContent: json['tos_content'] as String? ?? '',
  maxTransactionTotal: (json['max_transaction_total'] as num?)?.toInt() ?? 0,
  maxWalletBalance: (json['max_wallet_balance'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TOSSignatureResponseToJson(
  TOSSignatureResponse instance,
) => <String, dynamic>{
  'accepted_tos_version': instance.acceptedTosVersion,
  'latest_tos_version': instance.latestTosVersion,
  'tos_content': instance.tosContent,
  'max_transaction_total': instance.maxTransactionTotal,
  'max_wallet_balance': instance.maxWalletBalance,
};

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
  name: json['name'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  schoolId: json['school_id'] as String? ?? '',
  sportId: json['sport_id'] as String? ?? '',
  captainId: json['captain_id'] as String? ?? '',
  id: json['id'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'name': instance.name,
  'edition_id': instance.editionId,
  'school_id': instance.schoolId,
  'sport_id': instance.sportId,
  'captain_id': instance.captainId,
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
};

TeamComplete _$TeamCompleteFromJson(Map<String, dynamic> json) => TeamComplete(
  name: json['name'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  schoolId: json['school_id'] as String? ?? '',
  sportId: json['sport_id'] as String? ?? '',
  captainId: json['captain_id'] as String? ?? '',
  id: json['id'] as String? ?? '',
  createdAt: DateTime.parse(json['created_at'] as String),
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => ParticipantComplete.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$TeamCompleteToJson(TeamComplete instance) =>
    <String, dynamic>{
      'name': instance.name,
      'edition_id': instance.editionId,
      'school_id': instance.schoolId,
      'sport_id': instance.sportId,
      'captain_id': instance.captainId,
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'participants': instance.participants.map((e) => e.toJson()).toList(),
    };

TeamEdit _$TeamEditFromJson(Map<String, dynamic> json) => TeamEdit(
  name: json['name'] as String?,
  captainId: json['captain_id'] as String?,
);

Map<String, dynamic> _$TeamEditToJson(TeamEdit instance) => <String, dynamic>{
  'name': instance.name,
  'captain_id': instance.captainId,
};

TeamInfo _$TeamInfoFromJson(Map<String, dynamic> json) => TeamInfo(
  name: json['name'] as String? ?? '',
  schoolId: json['school_id'] as String? ?? '',
  sportId: json['sport_id'] as String? ?? '',
  captainId: json['captain_id'] as String? ?? '',
);

Map<String, dynamic> _$TeamInfoToJson(TeamInfo instance) => <String, dynamic>{
  'name': instance.name,
  'school_id': instance.schoolId,
  'sport_id': instance.sportId,
  'captain_id': instance.captainId,
};

TeamSportResult _$TeamSportResultFromJson(Map<String, dynamic> json) =>
    TeamSportResult(
      schoolId: json['school_id'] as String? ?? '',
      sportId: json['sport_id'] as String? ?? '',
      teamId: json['team_id'] as String? ?? '',
      points: (json['points'] as num?)?.toInt() ?? 0,
      editionId: json['edition_id'] as String? ?? '',
      rank: (json['rank'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TeamSportResultToJson(TeamSportResult instance) =>
    <String, dynamic>{
      'school_id': instance.schoolId,
      'sport_id': instance.sportId,
      'team_id': instance.teamId,
      'points': instance.points,
      'edition_id': instance.editionId,
      'rank': instance.rank,
    };

TeamSportResultBase _$TeamSportResultBaseFromJson(Map<String, dynamic> json) =>
    TeamSportResultBase(
      schoolId: json['school_id'] as String? ?? '',
      sportId: json['sport_id'] as String? ?? '',
      teamId: json['team_id'] as String? ?? '',
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TeamSportResultBaseToJson(
  TeamSportResultBase instance,
) => <String, dynamic>{
  'school_id': instance.schoolId,
  'sport_id': instance.sportId,
  'team_id': instance.teamId,
  'points': instance.points,
};

TeamSportResultComplete _$TeamSportResultCompleteFromJson(
  Map<String, dynamic> json,
) => TeamSportResultComplete(
  schoolId: json['school_id'] as String? ?? '',
  sportId: json['sport_id'] as String? ?? '',
  teamId: json['team_id'] as String? ?? '',
  points: (json['points'] as num?)?.toInt() ?? 0,
  editionId: json['edition_id'] as String? ?? '',
  rank: (json['rank'] as num?)?.toInt() ?? 0,
  team: Team.fromJson(json['team'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TeamSportResultCompleteToJson(
  TeamSportResultComplete instance,
) => <String, dynamic>{
  'school_id': instance.schoolId,
  'sport_id': instance.sportId,
  'team_id': instance.teamId,
  'points': instance.points,
  'edition_id': instance.editionId,
  'rank': instance.rank,
  'team': instance.team.toJson(),
};

TheMovieDB _$TheMovieDBFromJson(Map<String, dynamic> json) => TheMovieDB(
  genres:
      (json['genres'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
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

TicketChangeOverInvitation _$TicketChangeOverInvitationFromJson(
  Map<String, dynamic> json,
) => TicketChangeOverInvitation(
  ticketId: json['ticket_id'] as String? ?? '',
  email: json['email'] as String? ?? '',
);

Map<String, dynamic> _$TicketChangeOverInvitationToJson(
  TicketChangeOverInvitation instance,
) => <String, dynamic>{'ticket_id': instance.ticketId, 'email': instance.email};

TicketScan _$TicketScanFromJson(Map<String, dynamic> json) =>
    TicketScan(tag: json['tag'] as String? ?? '');

Map<String, dynamic> _$TicketScanToJson(TicketScan instance) =>
    <String, dynamic>{'tag': instance.tag};

TicketSecret _$TicketSecretFromJson(Map<String, dynamic> json) =>
    TicketSecret(qrCodeSecret: json['qr_code_secret'] as String? ?? '');

Map<String, dynamic> _$TicketSecretToJson(TicketSecret instance) =>
    <String, dynamic>{'qr_code_secret': instance.qrCodeSecret};

TicketSimple _$TicketSimpleFromJson(Map<String, dynamic> json) => TicketSimple(
  packId: json['pack_id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  winningPrize: json['winning_prize'] as String?,
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
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 0,
      scope: json['scope'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      idToken: json['id_token'] as String?,
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'scope': instance.scope,
      'refresh_token': instance.refreshToken,
      'id_token': instance.idToken,
    };

TopicUser _$TopicUserFromJson(Map<String, dynamic> json) => TopicUser(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  moduleRoot: json['module_root'] as String? ?? '',
  topicIdentifier: json['topic_identifier'] as String?,
  isUserSubscribed: json['is_user_subscribed'] as bool? ?? false,
);

Map<String, dynamic> _$TopicUserToJson(TopicUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'module_root': instance.moduleRoot,
  'topic_identifier': instance.topicIdentifier,
  'is_user_subscribed': instance.isUserSubscribed,
};

TransactionBase _$TransactionBaseFromJson(Map<String, dynamic> json) =>
    TransactionBase(
      id: json['id'] as String? ?? '',
      debitedWalletId: json['debited_wallet_id'] as String? ?? '',
      creditedWalletId: json['credited_wallet_id'] as String? ?? '',
      transactionType: transactionTypeFromJson(json['transaction_type']),
      sellerUserId: json['seller_user_id'] as String?,
      total: (json['total'] as num?)?.toInt() ?? 0,
      creation: DateTime.parse(json['creation'] as String),
      status: transactionStatusFromJson(json['status']),
      qrCodeId: json['qr_code_id'] as String?,
    );

Map<String, dynamic> _$TransactionBaseToJson(TransactionBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'debited_wallet_id': instance.debitedWalletId,
      'credited_wallet_id': instance.creditedWalletId,
      'transaction_type': transactionTypeToJson(instance.transactionType),
      'seller_user_id': instance.sellerUserId,
      'total': instance.total,
      'creation': instance.creation.toIso8601String(),
      'status': transactionStatusToJson(instance.status),
      'qr_code_id': instance.qrCodeId,
    };

Transfer _$TransferFromJson(Map<String, dynamic> json) => Transfer(
  id: json['id'] as String? ?? '',
  origin: transferOriginFromJson(json['origin']),
  transferIdentifier: json['transfer_identifier'] as String? ?? '',
  approverUserId: json['approver_user_id'] as String?,
  walletId: json['wallet_id'] as String? ?? '',
  total: (json['total'] as num?)?.toInt() ?? 0,
  creation: DateTime.parse(json['creation'] as String),
  confirmed: json['confirmed'] as bool? ?? false,
  module: json['module'] as String?,
  objectId: json['object_id'] as String?,
  type: transferTypeFromJson(json['type']),
);

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
  'id': instance.id,
  'origin': transferOriginToJson(instance.origin),
  'transfer_identifier': instance.transferIdentifier,
  'approver_user_id': instance.approverUserId,
  'wallet_id': instance.walletId,
  'total': instance.total,
  'creation': instance.creation.toIso8601String(),
  'confirmed': instance.confirmed,
  'module': instance.module,
  'object_id': instance.objectId,
  'type': transferTypeToJson(instance.type),
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

UserGroupMembership _$UserGroupMembershipFromJson(Map<String, dynamic> json) =>
    UserGroupMembership(
      userId: json['user_id'] as String? ?? '',
      group: competitionGroupTypeFromJson(json['group']),
      editionId: json['edition_id'] as String? ?? '',
    );

Map<String, dynamic> _$UserGroupMembershipToJson(
  UserGroupMembership instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'group': competitionGroupTypeToJson(instance.group),
  'edition_id': instance.editionId,
};

UserGroupMembershipComplete _$UserGroupMembershipCompleteFromJson(
  Map<String, dynamic> json,
) => UserGroupMembershipComplete(
  userId: json['user_id'] as String? ?? '',
  group: competitionGroupTypeFromJson(json['group']),
  editionId: json['edition_id'] as String? ?? '',
  user: CoreUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserGroupMembershipCompleteToJson(
  UserGroupMembershipComplete instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'group': competitionGroupTypeToJson(instance.group),
  'edition_id': instance.editionId,
  'user': instance.user.toJson(),
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
  Map<String, dynamic> json,
) => UserMembershipComplete(
  associationMembershipId: json['association_membership_id'] as String? ?? '',
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  id: json['id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserMembershipCompleteToJson(
  UserMembershipComplete instance,
) => <String, dynamic>{
  'association_membership_id': instance.associationMembershipId,
  'start_date': _dateToJson(instance.startDate),
  'end_date': _dateToJson(instance.endDate),
  'id': instance.id,
  'user_id': instance.userId,
  'user': instance.user.toJson(),
};

UserMembershipEdit _$UserMembershipEditFromJson(Map<String, dynamic> json) =>
    UserMembershipEdit(
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$UserMembershipEditToJson(UserMembershipEdit instance) =>
    <String, dynamic>{
      'start_date': _dateToJson(instance.startDate),
      'end_date': _dateToJson(instance.endDate),
    };

UserStore _$UserStoreFromJson(Map<String, dynamic> json) => UserStore(
  name: json['name'] as String? ?? '',
  associationId: json['association_id'] as String?,
  id: json['id'] as String? ?? '',
  structureId: json['structure_id'] as String? ?? '',
  walletId: json['wallet_id'] as String? ?? '',
  creation: DateTime.parse(json['creation'] as String),
  structure: Structure.fromJson(json['structure'] as Map<String, dynamic>),
  canBank: json['can_bank'] as bool? ?? false,
  canSeeHistory: json['can_see_history'] as bool? ?? false,
  canCancel: json['can_cancel'] as bool? ?? false,
  canManageSellers: json['can_manage_sellers'] as bool? ?? false,
);

Map<String, dynamic> _$UserStoreToJson(UserStore instance) => <String, dynamic>{
  'name': instance.name,
  'association_id': instance.associationId,
  'id': instance.id,
  'structure_id': instance.structureId,
  'wallet_id': instance.walletId,
  'creation': instance.creation.toIso8601String(),
  'structure': instance.structure.toJson(),
  'can_bank': instance.canBank,
  'can_see_history': instance.canSeeHistory,
  'can_cancel': instance.canCancel,
  'can_manage_sellers': instance.canManageSellers,
};

UserTicket _$UserTicketFromJson(Map<String, dynamic> json) => UserTicket(
  name: json['name'] as String? ?? '',
  firstname: json['firstname'] as String? ?? '',
  nickname: json['nickname'] as String?,
  id: json['id'] as String? ?? '',
  accountType: accountTypeFromJson(json['account_type']),
  schoolId: json['school_id'] as String? ?? '',
  promo: (json['promo'] as num?)?.toInt(),
  floor: json['floor'] as String?,
  createdOn: json['created_on'] == null
      ? null
      : DateTime.parse(json['created_on'] as String),
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
      'created_on': instance.createdOn?.toIso8601String(),
    };

ValidationError _$ValidationErrorFromJson(
  Map<String, dynamic> json,
) => ValidationError(
  loc: (json['loc'] as List<dynamic>?)?.map((e) => e as Object).toList() ?? [],
  msg: json['msg'] as String? ?? '',
  type: json['type'] as String? ?? '',
  input: json['input'],
  ctx: json['ctx'],
);

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'loc': instance.loc,
      'msg': instance.msg,
      'type': instance.type,
      'input': instance.input,
      'ctx': instance.ctx,
    };

VolunteerRegistrationComplete _$VolunteerRegistrationCompleteFromJson(
  Map<String, dynamic> json,
) => VolunteerRegistrationComplete(
  userId: json['user_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  shiftId: json['shift_id'] as String? ?? '',
  registeredAt: DateTime.parse(json['registered_at'] as String),
  validated: json['validated'] as bool? ?? false,
  shift: VolunteerShiftComplete.fromJson(json['shift'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VolunteerRegistrationCompleteToJson(
  VolunteerRegistrationComplete instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'edition_id': instance.editionId,
  'shift_id': instance.shiftId,
  'registered_at': instance.registeredAt.toIso8601String(),
  'validated': instance.validated,
  'shift': instance.shift.toJson(),
};

VolunteerShift _$VolunteerShiftFromJson(Map<String, dynamic> json) =>
    VolunteerShift(
      name: json['name'] as String? ?? '',
      managerId: json['manager_id'] as String? ?? '',
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toInt() ?? 0,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      location: json['location'] as String?,
      maxVolunteers: (json['max_volunteers'] as num?)?.toInt() ?? 0,
      id: json['id'] as String? ?? '',
      editionId: json['edition_id'] as String? ?? '',
    );

Map<String, dynamic> _$VolunteerShiftToJson(VolunteerShift instance) =>
    <String, dynamic>{
      'name': instance.name,
      'manager_id': instance.managerId,
      'description': instance.description,
      'value': instance.value,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'location': instance.location,
      'max_volunteers': instance.maxVolunteers,
      'id': instance.id,
      'edition_id': instance.editionId,
    };

VolunteerShiftBase _$VolunteerShiftBaseFromJson(Map<String, dynamic> json) =>
    VolunteerShiftBase(
      name: json['name'] as String? ?? '',
      managerId: json['manager_id'] as String? ?? '',
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toInt() ?? 0,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      location: json['location'] as String?,
      maxVolunteers: (json['max_volunteers'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VolunteerShiftBaseToJson(VolunteerShiftBase instance) =>
    <String, dynamic>{
      'name': instance.name,
      'manager_id': instance.managerId,
      'description': instance.description,
      'value': instance.value,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'location': instance.location,
      'max_volunteers': instance.maxVolunteers,
    };

VolunteerShiftComplete _$VolunteerShiftCompleteFromJson(
  Map<String, dynamic> json,
) => VolunteerShiftComplete(
  name: json['name'] as String? ?? '',
  managerId: json['manager_id'] as String? ?? '',
  description: json['description'] as String?,
  value: (json['value'] as num?)?.toInt() ?? 0,
  startTime: DateTime.parse(json['start_time'] as String),
  endTime: DateTime.parse(json['end_time'] as String),
  location: json['location'] as String?,
  maxVolunteers: (json['max_volunteers'] as num?)?.toInt() ?? 0,
  id: json['id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  manager: CoreUser.fromJson(json['manager'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VolunteerShiftCompleteToJson(
  VolunteerShiftComplete instance,
) => <String, dynamic>{
  'name': instance.name,
  'manager_id': instance.managerId,
  'description': instance.description,
  'value': instance.value,
  'start_time': instance.startTime.toIso8601String(),
  'end_time': instance.endTime.toIso8601String(),
  'location': instance.location,
  'max_volunteers': instance.maxVolunteers,
  'id': instance.id,
  'edition_id': instance.editionId,
  'manager': instance.manager.toJson(),
};

VolunteerShiftEdit _$VolunteerShiftEditFromJson(Map<String, dynamic> json) =>
    VolunteerShiftEdit(
      name: json['name'] as String?,
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toInt(),
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      location: json['location'] as String?,
      maxVolunteers: (json['max_volunteers'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VolunteerShiftEditToJson(VolunteerShiftEdit instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'location': instance.location,
      'max_volunteers': instance.maxVolunteers,
    };

VoteBase _$VoteBaseFromJson(Map<String, dynamic> json) =>
    VoteBase(listId: json['list_id'] as String? ?? '');

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

VoteStatus _$VoteStatusFromJson(Map<String, dynamic> json) =>
    VoteStatus(status: statusTypeFromJson(json['status']));

Map<String, dynamic> _$VoteStatusToJson(VoteStatus instance) =>
    <String, dynamic>{'status': statusTypeToJson(instance.status)};

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
  id: json['id'] as String? ?? '',
  type: walletTypeFromJson(json['type']),
  balance: (json['balance'] as num?)?.toInt() ?? 0,
  store: json['store'] == null
      ? null
      : Store.fromJson(json['store'] as Map<String, dynamic>),
  user: json['user'] == null
      ? null
      : CoreUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
  'id': instance.id,
  'type': walletTypeToJson(instance.type),
  'balance': instance.balance,
  'store': instance.store?.toJson(),
  'user': instance.user?.toJson(),
};

WalletBase _$WalletBaseFromJson(Map<String, dynamic> json) => WalletBase(
  id: json['id'] as String? ?? '',
  type: walletTypeFromJson(json['type']),
  balance: (json['balance'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$WalletBaseToJson(WalletBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': walletTypeToJson(instance.type),
      'balance': instance.balance,
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
  Map<String, dynamic> json,
) => WalletDeviceCreation(
  name: json['name'] as String? ?? '',
  ed25519PublicKey: json['ed25519_public_key'] as String? ?? '',
);

Map<String, dynamic> _$WalletDeviceCreationToJson(
  WalletDeviceCreation instance,
) => <String, dynamic>{
  'name': instance.name,
  'ed25519_public_key': instance.ed25519PublicKey,
};

AppCoreAssociationsSchemasAssociationsAssociationBase
_$AppCoreAssociationsSchemasAssociationsAssociationBaseFromJson(
  Map<String, dynamic> json,
) => AppCoreAssociationsSchemasAssociationsAssociationBase(
  name: json['name'] as String? ?? '',
  groupId: json['group_id'] as String? ?? '',
);

Map<String, dynamic>
_$AppCoreAssociationsSchemasAssociationsAssociationBaseToJson(
  AppCoreAssociationsSchemasAssociationsAssociationBase instance,
) => <String, dynamic>{'name': instance.name, 'group_id': instance.groupId};

AppCoreMembershipsSchemasMembershipsMembershipBase
_$AppCoreMembershipsSchemasMembershipsMembershipBaseFromJson(
  Map<String, dynamic> json,
) => AppCoreMembershipsSchemasMembershipsMembershipBase(
  name: json['name'] as String? ?? '',
  managerGroupId: json['manager_group_id'] as String? ?? '',
);

Map<String, dynamic> _$AppCoreMembershipsSchemasMembershipsMembershipBaseToJson(
  AppCoreMembershipsSchemasMembershipsMembershipBase instance,
) => <String, dynamic>{
  'name': instance.name,
  'manager_group_id': instance.managerGroupId,
};

AppCoreTicketsSchemasTicketsTicket _$AppCoreTicketsSchemasTicketsTicketFromJson(
  Map<String, dynamic> json,
) => AppCoreTicketsSchemasTicketsTicket(
  id: json['id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  price: (json['price'] as num?)?.toInt() ?? 0,
  scanned: json['scanned'] as bool? ?? false,
  eventId: json['event_id'] as String? ?? '',
  categoryId: json['category_id'] as String? ?? '',
  sessionId: json['session_id'] as String? ?? '',
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  session: Session.fromJson(json['session'] as Map<String, dynamic>),
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
  answers:
      (json['answers'] as List<dynamic>?)
          ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AppCoreTicketsSchemasTicketsTicketToJson(
  AppCoreTicketsSchemasTicketsTicket instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'price': instance.price,
  'scanned': instance.scanned,
  'event_id': instance.eventId,
  'category_id': instance.categoryId,
  'session_id': instance.sessionId,
  'category': instance.category.toJson(),
  'session': instance.session.toJson(),
  'user': instance.user.toJson(),
  'answers': instance.answers.map((e) => e.toJson()).toList(),
};

AppCoreTicketsSchemasTicketsTicketComplete
_$AppCoreTicketsSchemasTicketsTicketCompleteFromJson(
  Map<String, dynamic> json,
) => AppCoreTicketsSchemasTicketsTicketComplete(
  id: json['id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  price: (json['price'] as num?)?.toInt() ?? 0,
  scanned: json['scanned'] as bool? ?? false,
  eventId: json['event_id'] as String? ?? '',
  categoryId: json['category_id'] as String? ?? '',
  sessionId: json['session_id'] as String? ?? '',
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  session: Session.fromJson(json['session'] as Map<String, dynamic>),
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
  answers:
      (json['answers'] as List<dynamic>?)
          ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  event: EventSimple.fromJson(json['event'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppCoreTicketsSchemasTicketsTicketCompleteToJson(
  AppCoreTicketsSchemasTicketsTicketComplete instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'price': instance.price,
  'scanned': instance.scanned,
  'event_id': instance.eventId,
  'category_id': instance.categoryId,
  'session_id': instance.sessionId,
  'category': instance.category.toJson(),
  'session': instance.session.toJson(),
  'user': instance.user.toJson(),
  'answers': instance.answers.map((e) => e.toJson()).toList(),
  'event': instance.event.toJson(),
};

AppModulesAmapSchemasAmapCashComplete
_$AppModulesAmapSchemasAmapCashCompleteFromJson(Map<String, dynamic> json) =>
    AppModulesAmapSchemasAmapCashComplete(
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      userId: json['user_id'] as String? ?? '',
      user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
      lastOrderDate: DateTime.parse(json['last_order_date'] as String),
    );

Map<String, dynamic> _$AppModulesAmapSchemasAmapCashCompleteToJson(
  AppModulesAmapSchemasAmapCashComplete instance,
) => <String, dynamic>{
  'balance': instance.balance,
  'user_id': instance.userId,
  'user': instance.user.toJson(),
  'last_order_date': instance.lastOrderDate.toIso8601String(),
};

AppModulesAmapSchemasAmapProductComplete
_$AppModulesAmapSchemasAmapProductCompleteFromJson(Map<String, dynamic> json) =>
    AppModulesAmapSchemasAmapProductComplete(
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      category: json['category'] as String? ?? '',
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$AppModulesAmapSchemasAmapProductCompleteToJson(
  AppModulesAmapSchemasAmapProductComplete instance,
) => <String, dynamic>{
  'name': instance.name,
  'price': instance.price,
  'category': instance.category,
  'id': instance.id,
};

AppModulesAmapSchemasAmapProductEdit
_$AppModulesAmapSchemasAmapProductEditFromJson(Map<String, dynamic> json) =>
    AppModulesAmapSchemasAmapProductEdit(
      category: json['category'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppModulesAmapSchemasAmapProductEditToJson(
  AppModulesAmapSchemasAmapProductEdit instance,
) => <String, dynamic>{
  'category': instance.category,
  'name': instance.name,
  'price': instance.price,
};

AppModulesCampaignSchemasCampaignResult
_$AppModulesCampaignSchemasCampaignResultFromJson(Map<String, dynamic> json) =>
    AppModulesCampaignSchemasCampaignResult(
      listId: json['list_id'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AppModulesCampaignSchemasCampaignResultToJson(
  AppModulesCampaignSchemasCampaignResult instance,
) => <String, dynamic>{'list_id': instance.listId, 'count': instance.count};

AppModulesCdrSchemasCdrPaymentBase _$AppModulesCdrSchemasCdrPaymentBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesCdrSchemasCdrPaymentBase(
  total: (json['total'] as num?)?.toInt() ?? 0,
  paymentType: paymentTypeFromJson(json['payment_type']),
);

Map<String, dynamic> _$AppModulesCdrSchemasCdrPaymentBaseToJson(
  AppModulesCdrSchemasCdrPaymentBase instance,
) => <String, dynamic>{
  'total': instance.total,
  'payment_type': paymentTypeToJson(instance.paymentType),
};

AppModulesCdrSchemasCdrPaymentComplete
_$AppModulesCdrSchemasCdrPaymentCompleteFromJson(Map<String, dynamic> json) =>
    AppModulesCdrSchemasCdrPaymentComplete(
      total: (json['total'] as num?)?.toInt() ?? 0,
      paymentType: paymentTypeFromJson(json['payment_type']),
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AppModulesCdrSchemasCdrPaymentCompleteToJson(
  AppModulesCdrSchemasCdrPaymentComplete instance,
) => <String, dynamic>{
  'total': instance.total,
  'payment_type': paymentTypeToJson(instance.paymentType),
  'id': instance.id,
  'user_id': instance.userId,
  'year': instance.year,
};

AppModulesCdrSchemasCdrProductBase _$AppModulesCdrSchemasCdrProductBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesCdrSchemasCdrProductBase(
  nameFr: json['name_fr'] as String? ?? '',
  nameEn: json['name_en'] as String?,
  descriptionFr: json['description_fr'] as String?,
  descriptionEn: json['description_en'] as String?,
  availableOnline: json['available_online'] as bool? ?? false,
  needsValidation: json['needs_validation'] as bool? ?? true,
  relatedMembership: json['related_membership'] == null
      ? null
      : MembershipSimple.fromJson(
          json['related_membership'] as Map<String, dynamic>,
        ),
  tickets:
      (json['tickets'] as List<dynamic>?)
          ?.map((e) => GenerateTicketBase.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  productConstraints:
      (json['product_constraints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  documentConstraints:
      (json['document_constraints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
);

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductBaseToJson(
  AppModulesCdrSchemasCdrProductBase instance,
) => <String, dynamic>{
  'name_fr': instance.nameFr,
  'name_en': instance.nameEn,
  'description_fr': instance.descriptionFr,
  'description_en': instance.descriptionEn,
  'available_online': instance.availableOnline,
  'needs_validation': instance.needsValidation,
  'related_membership': instance.relatedMembership?.toJson(),
  'tickets': instance.tickets?.map((e) => e.toJson()).toList(),
  'product_constraints': instance.productConstraints,
  'document_constraints': instance.documentConstraints,
};

AppModulesCdrSchemasCdrProductComplete
_$AppModulesCdrSchemasCdrProductCompleteFromJson(Map<String, dynamic> json) =>
    AppModulesCdrSchemasCdrProductComplete(
      nameFr: json['name_fr'] as String? ?? '',
      nameEn: json['name_en'] as String?,
      descriptionFr: json['description_fr'] as String?,
      descriptionEn: json['description_en'] as String?,
      availableOnline: json['available_online'] as bool? ?? false,
      needsValidation: json['needs_validation'] as bool? ?? false,
      id: json['id'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      sellerId: json['seller_id'] as String? ?? '',
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map(
                (e) => AppModulesCdrSchemasCdrProductVariantComplete.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      relatedMembership: json['related_membership'] == null
          ? null
          : MembershipSimple.fromJson(
              json['related_membership'] as Map<String, dynamic>,
            ),
      productConstraints:
          (json['product_constraints'] as List<dynamic>?)
              ?.map(
                (e) => ProductCompleteNoConstraint.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      documentConstraints:
          (json['document_constraints'] as List<dynamic>?)
              ?.map((e) => DocumentComplete.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tickets:
          (json['tickets'] as List<dynamic>?)
              ?.map(
                (e) =>
                    GenerateTicketComplete.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductCompleteToJson(
  AppModulesCdrSchemasCdrProductComplete instance,
) => <String, dynamic>{
  'name_fr': instance.nameFr,
  'name_en': instance.nameEn,
  'description_fr': instance.descriptionFr,
  'description_en': instance.descriptionEn,
  'available_online': instance.availableOnline,
  'needs_validation': instance.needsValidation,
  'id': instance.id,
  'year': instance.year,
  'seller_id': instance.sellerId,
  'variants': instance.variants?.map((e) => e.toJson()).toList(),
  'related_membership': instance.relatedMembership?.toJson(),
  'product_constraints': instance.productConstraints
      ?.map((e) => e.toJson())
      .toList(),
  'document_constraints': instance.documentConstraints
      ?.map((e) => e.toJson())
      .toList(),
  'tickets': instance.tickets?.map((e) => e.toJson()).toList(),
};

AppModulesCdrSchemasCdrProductEdit _$AppModulesCdrSchemasCdrProductEditFromJson(
  Map<String, dynamic> json,
) => AppModulesCdrSchemasCdrProductEdit(
  nameFr: json['name_fr'] as String?,
  nameEn: json['name_en'] as String?,
  descriptionFr: json['description_fr'] as String?,
  descriptionEn: json['description_en'] as String?,
  description: json['description'] as String?,
  availableOnline: json['available_online'] as bool?,
  relatedMembership: json['related_membership'] == null
      ? null
      : MembershipSimple.fromJson(
          json['related_membership'] as Map<String, dynamic>,
        ),
  productConstraints: (json['product_constraints'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  documentConstraints: (json['document_constraints'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductEditToJson(
  AppModulesCdrSchemasCdrProductEdit instance,
) => <String, dynamic>{
  'name_fr': instance.nameFr,
  'name_en': instance.nameEn,
  'description_fr': instance.descriptionFr,
  'description_en': instance.descriptionEn,
  'description': instance.description,
  'available_online': instance.availableOnline,
  'related_membership': instance.relatedMembership?.toJson(),
  'product_constraints': instance.productConstraints,
  'document_constraints': instance.documentConstraints,
};

AppModulesCdrSchemasCdrProductVariantBase
_$AppModulesCdrSchemasCdrProductVariantBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesCdrSchemasCdrProductVariantBase(
  nameFr: json['name_fr'] as String? ?? '',
  nameEn: json['name_en'] as String?,
  descriptionFr: json['description_fr'] as String?,
  descriptionEn: json['description_en'] as String?,
  price: (json['price'] as num?)?.toInt() ?? 0,
  enabled: json['enabled'] as bool? ?? false,
  unique: json['unique'] as bool? ?? false,
  allowedCurriculum:
      (json['allowed_curriculum'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  relatedMembershipAddedDuration:
      json['related_membership_added_duration'] as String?,
);

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductVariantBaseToJson(
  AppModulesCdrSchemasCdrProductVariantBase instance,
) => <String, dynamic>{
  'name_fr': instance.nameFr,
  'name_en': instance.nameEn,
  'description_fr': instance.descriptionFr,
  'description_en': instance.descriptionEn,
  'price': instance.price,
  'enabled': instance.enabled,
  'unique': instance.unique,
  'allowed_curriculum': instance.allowedCurriculum,
  'related_membership_added_duration': instance.relatedMembershipAddedDuration,
};

AppModulesCdrSchemasCdrProductVariantComplete
_$AppModulesCdrSchemasCdrProductVariantCompleteFromJson(
  Map<String, dynamic> json,
) => AppModulesCdrSchemasCdrProductVariantComplete(
  id: json['id'] as String? ?? '',
  year: (json['year'] as num?)?.toInt() ?? 0,
  productId: json['product_id'] as String? ?? '',
  nameFr: json['name_fr'] as String? ?? '',
  nameEn: json['name_en'] as String?,
  descriptionFr: json['description_fr'] as String?,
  descriptionEn: json['description_en'] as String?,
  price: (json['price'] as num?)?.toInt() ?? 0,
  enabled: json['enabled'] as bool? ?? false,
  unique: json['unique'] as bool? ?? false,
  allowedCurriculum:
      (json['allowed_curriculum'] as List<dynamic>?)
          ?.map((e) => CurriculumComplete.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  relatedMembershipAddedDuration:
      json['related_membership_added_duration'] as String?,
);

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductVariantCompleteToJson(
  AppModulesCdrSchemasCdrProductVariantComplete instance,
) => <String, dynamic>{
  'id': instance.id,
  'year': instance.year,
  'product_id': instance.productId,
  'name_fr': instance.nameFr,
  'name_en': instance.nameEn,
  'description_fr': instance.descriptionFr,
  'description_en': instance.descriptionEn,
  'price': instance.price,
  'enabled': instance.enabled,
  'unique': instance.unique,
  'allowed_curriculum': instance.allowedCurriculum
      ?.map((e) => e.toJson())
      .toList(),
  'related_membership_added_duration': instance.relatedMembershipAddedDuration,
};

AppModulesCdrSchemasCdrProductVariantEdit
_$AppModulesCdrSchemasCdrProductVariantEditFromJson(
  Map<String, dynamic> json,
) => AppModulesCdrSchemasCdrProductVariantEdit(
  nameFr: json['name_fr'] as String?,
  nameEn: json['name_en'] as String?,
  descriptionFr: json['description_fr'] as String?,
  descriptionEn: json['description_en'] as String?,
  price: (json['price'] as num?)?.toInt(),
  enabled: json['enabled'] as bool?,
  unique: json['unique'] as bool?,
  allowedCurriculum: (json['allowed_curriculum'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  relatedMembershipAddedDuration:
      json['related_membership_added_duration'] as String?,
);

Map<String, dynamic> _$AppModulesCdrSchemasCdrProductVariantEditToJson(
  AppModulesCdrSchemasCdrProductVariantEdit instance,
) => <String, dynamic>{
  'name_fr': instance.nameFr,
  'name_en': instance.nameEn,
  'description_fr': instance.descriptionFr,
  'description_en': instance.descriptionEn,
  'price': instance.price,
  'enabled': instance.enabled,
  'unique': instance.unique,
  'allowed_curriculum': instance.allowedCurriculum,
  'related_membership_added_duration': instance.relatedMembershipAddedDuration,
};

AppModulesCdrSchemasCdrPurchaseBase
_$AppModulesCdrSchemasCdrPurchaseBaseFromJson(Map<String, dynamic> json) =>
    AppModulesCdrSchemasCdrPurchaseBase(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AppModulesCdrSchemasCdrPurchaseBaseToJson(
  AppModulesCdrSchemasCdrPurchaseBase instance,
) => <String, dynamic>{'quantity': instance.quantity};

AppModulesCdrSchemasCdrPurchaseComplete
_$AppModulesCdrSchemasCdrPurchaseCompleteFromJson(Map<String, dynamic> json) =>
    AppModulesCdrSchemasCdrPurchaseComplete(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      userId: json['user_id'] as String? ?? '',
      productVariantId: json['product_variant_id'] as String? ?? '',
      validated: json['validated'] as bool? ?? false,
      purchasedOn: DateTime.parse(json['purchased_on'] as String),
    );

Map<String, dynamic> _$AppModulesCdrSchemasCdrPurchaseCompleteToJson(
  AppModulesCdrSchemasCdrPurchaseComplete instance,
) => <String, dynamic>{
  'quantity': instance.quantity,
  'user_id': instance.userId,
  'product_variant_id': instance.productVariantId,
  'validated': instance.validated,
  'purchased_on': instance.purchasedOn.toIso8601String(),
};

AppModulesCdrSchemasCdrTicket _$AppModulesCdrSchemasCdrTicketFromJson(
  Map<String, dynamic> json,
) => AppModulesCdrSchemasCdrTicket(
  id: json['id'] as String? ?? '',
  productVariant: AppModulesCdrSchemasCdrProductVariantComplete.fromJson(
    json['product_variant'] as Map<String, dynamic>,
  ),
  user: UserTicket.fromJson(json['user'] as Map<String, dynamic>),
  scanLeft: (json['scan_left'] as num?)?.toInt() ?? 0,
  tags: json['tags'] as String? ?? '',
  expiration: DateTime.parse(json['expiration'] as String),
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$AppModulesCdrSchemasCdrTicketToJson(
  AppModulesCdrSchemasCdrTicket instance,
) => <String, dynamic>{
  'id': instance.id,
  'product_variant': instance.productVariant.toJson(),
  'user': instance.user.toJson(),
  'scan_left': instance.scanLeft,
  'tags': instance.tags,
  'expiration': instance.expiration.toIso8601String(),
  'name': instance.name,
};

AppModulesPhonebookSchemasPhonebookAssociationBase
_$AppModulesPhonebookSchemasPhonebookAssociationBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesPhonebookSchemasPhonebookAssociationBase(
  name: json['name'] as String? ?? '',
  groupementId: json['groupement_id'] as String? ?? '',
  mandateYear: (json['mandate_year'] as num?)?.toInt() ?? 0,
  description: json['description'] as String?,
  associatedGroups:
      (json['associated_groups'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  deactivated: json['deactivated'] as bool? ?? false,
);

Map<String, dynamic> _$AppModulesPhonebookSchemasPhonebookAssociationBaseToJson(
  AppModulesPhonebookSchemasPhonebookAssociationBase instance,
) => <String, dynamic>{
  'name': instance.name,
  'groupement_id': instance.groupementId,
  'mandate_year': instance.mandateYear,
  'description': instance.description,
  'associated_groups': instance.associatedGroups,
  'deactivated': instance.deactivated,
};

AppModulesPhonebookSchemasPhonebookMembershipBase
_$AppModulesPhonebookSchemasPhonebookMembershipBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesPhonebookSchemasPhonebookMembershipBase(
  userId: json['user_id'] as String? ?? '',
  associationId: json['association_id'] as String? ?? '',
  mandateYear: (json['mandate_year'] as num?)?.toInt() ?? 0,
  roleName: json['role_name'] as String? ?? '',
  roleTags: json['role_tags'] as String? ?? '',
  memberOrder: (json['member_order'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AppModulesPhonebookSchemasPhonebookMembershipBaseToJson(
  AppModulesPhonebookSchemasPhonebookMembershipBase instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'association_id': instance.associationId,
  'mandate_year': instance.mandateYear,
  'role_name': instance.roleName,
  'role_tags': instance.roleTags,
  'member_order': instance.memberOrder,
};

AppModulesRaffleSchemasRaffleCashComplete
_$AppModulesRaffleSchemasRaffleCashCompleteFromJson(
  Map<String, dynamic> json,
) => AppModulesRaffleSchemasRaffleCashComplete(
  balance: (json['balance'] as num?)?.toInt() ?? 0,
  userId: json['user_id'] as String? ?? '',
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppModulesRaffleSchemasRaffleCashCompleteToJson(
  AppModulesRaffleSchemasRaffleCashComplete instance,
) => <String, dynamic>{
  'balance': instance.balance,
  'user_id': instance.userId,
  'user': instance.user.toJson(),
};

AppModulesRaffleSchemasRaffleTicketComplete
_$AppModulesRaffleSchemasRaffleTicketCompleteFromJson(
  Map<String, dynamic> json,
) => AppModulesRaffleSchemasRaffleTicketComplete(
  packId: json['pack_id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  winningPrize: json['winning_prize'] as String?,
  id: json['id'] as String? ?? '',
  prize: json['prize'] == null
      ? null
      : PrizeSimple.fromJson(json['prize'] as Map<String, dynamic>),
  packTicket: PackTicketSimple.fromJson(
    json['pack_ticket'] as Map<String, dynamic>,
  ),
  user: CoreUserSimple.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppModulesRaffleSchemasRaffleTicketCompleteToJson(
  AppModulesRaffleSchemasRaffleTicketComplete instance,
) => <String, dynamic>{
  'pack_id': instance.packId,
  'user_id': instance.userId,
  'winning_prize': instance.winningPrize,
  'id': instance.id,
  'prize': instance.prize?.toJson(),
  'pack_ticket': instance.packTicket.toJson(),
  'user': instance.user.toJson(),
};

AppModulesSportCompetitionSchemasSportCompetitionPaymentBase
_$AppModulesSportCompetitionSchemasSportCompetitionPaymentBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionPaymentBase(
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionPaymentBaseToJson(
  AppModulesSportCompetitionSchemasSportCompetitionPaymentBase instance,
) => <String, dynamic>{'total': instance.total};

AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete
_$AppModulesSportCompetitionSchemasSportCompetitionPaymentCompleteFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete(
  total: (json['total'] as num?)?.toInt() ?? 0,
  id: json['id'] as String? ?? '',
  userId: json['user_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  method: paiementMethodTypeFromJson(json['method']),
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionPaymentCompleteToJson(
  AppModulesSportCompetitionSchemasSportCompetitionPaymentComplete instance,
) => <String, dynamic>{
  'total': instance.total,
  'id': instance.id,
  'user_id': instance.userId,
  'edition_id': instance.editionId,
  'method': paiementMethodTypeToJson(instance.method),
};

AppModulesSportCompetitionSchemasSportCompetitionProductBase
_$AppModulesSportCompetitionSchemasSportCompetitionProductBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionProductBase(
  name: json['name'] as String? ?? '',
  required: json['required'] as bool? ?? false,
  description: json['description'] as String?,
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionProductBaseToJson(
  AppModulesSportCompetitionSchemasSportCompetitionProductBase instance,
) => <String, dynamic>{
  'name': instance.name,
  'required': instance.required,
  'description': instance.description,
};

AppModulesSportCompetitionSchemasSportCompetitionProductComplete
_$AppModulesSportCompetitionSchemasSportCompetitionProductCompleteFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionProductComplete(
  name: json['name'] as String? ?? '',
  required: json['required'] as bool? ?? false,
  description: json['description'] as String?,
  id: json['id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  variants:
      (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductVariantStats.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionProductCompleteToJson(
  AppModulesSportCompetitionSchemasSportCompetitionProductComplete instance,
) => <String, dynamic>{
  'name': instance.name,
  'required': instance.required,
  'description': instance.description,
  'id': instance.id,
  'edition_id': instance.editionId,
  'variants': instance.variants?.map((e) => e.toJson()).toList(),
};

AppModulesSportCompetitionSchemasSportCompetitionProductEdit
_$AppModulesSportCompetitionSchemasSportCompetitionProductEditFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionProductEdit(
  name: json['name'] as String?,
  required: json['required'] as bool?,
  description: json['description'] as String?,
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionProductEditToJson(
  AppModulesSportCompetitionSchemasSportCompetitionProductEdit instance,
) => <String, dynamic>{
  'name': instance.name,
  'required': instance.required,
  'description': instance.description,
};

AppModulesSportCompetitionSchemasSportCompetitionProductVariantBase
_$AppModulesSportCompetitionSchemasSportCompetitionProductVariantBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionProductVariantBase(
  productId: json['product_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toInt() ?? 0,
  enabled: json['enabled'] as bool? ?? true,
  unique: json['unique'] as bool? ?? false,
  schoolType: productSchoolTypeNullableFromJson(json['school_type']),
  publicType: productPublicTypeNullableFromJson(json['public_type']),
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionProductVariantBaseToJson(
  AppModulesSportCompetitionSchemasSportCompetitionProductVariantBase instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'enabled': instance.enabled,
  'unique': instance.unique,
  'school_type': productSchoolTypeNullableToJson(instance.schoolType),
  'public_type': productPublicTypeNullableToJson(instance.publicType),
};

AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
_$AppModulesSportCompetitionSchemasSportCompetitionProductVariantCompleteFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete(
  productId: json['product_id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toInt() ?? 0,
  enabled: json['enabled'] as bool? ?? true,
  unique: json['unique'] as bool? ?? false,
  schoolType: productSchoolTypeNullableFromJson(json['school_type']),
  publicType: productPublicTypeNullableFromJson(json['public_type']),
  editionId: json['edition_id'] as String? ?? '',
  id: json['id'] as String? ?? '',
  product: Product.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionProductVariantCompleteToJson(
  AppModulesSportCompetitionSchemasSportCompetitionProductVariantComplete
  instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'enabled': instance.enabled,
  'unique': instance.unique,
  'school_type': productSchoolTypeNullableToJson(instance.schoolType),
  'public_type': productPublicTypeNullableToJson(instance.publicType),
  'edition_id': instance.editionId,
  'id': instance.id,
  'product': instance.product.toJson(),
};

AppModulesSportCompetitionSchemasSportCompetitionProductVariantEdit
_$AppModulesSportCompetitionSchemasSportCompetitionProductVariantEditFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionProductVariantEdit(
  name: json['name'] as String?,
  description: json['description'] as String?,
  price: (json['price'] as num?)?.toInt(),
  enabled: json['enabled'] as bool?,
  unique: json['unique'] as bool?,
  schoolType: productSchoolTypeNullableFromJson(json['school_type']),
  publicType: productPublicTypeNullableFromJson(json['public_type']),
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionProductVariantEditToJson(
  AppModulesSportCompetitionSchemasSportCompetitionProductVariantEdit instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'enabled': instance.enabled,
  'unique': instance.unique,
  'school_type': productSchoolTypeNullableToJson(instance.schoolType),
  'public_type': productPublicTypeNullableToJson(instance.publicType),
};

AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase
_$AppModulesSportCompetitionSchemasSportCompetitionPurchaseBaseFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase(
  productVariantId: json['product_variant_id'] as String? ?? '',
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionPurchaseBaseToJson(
  AppModulesSportCompetitionSchemasSportCompetitionPurchaseBase instance,
) => <String, dynamic>{
  'product_variant_id': instance.productVariantId,
  'quantity': instance.quantity,
};

AppModulesSportCompetitionSchemasSportCompetitionPurchaseComplete
_$AppModulesSportCompetitionSchemasSportCompetitionPurchaseCompleteFromJson(
  Map<String, dynamic> json,
) => AppModulesSportCompetitionSchemasSportCompetitionPurchaseComplete(
  productVariantId: json['product_variant_id'] as String? ?? '',
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  userId: json['user_id'] as String? ?? '',
  editionId: json['edition_id'] as String? ?? '',
  validated: json['validated'] as bool? ?? false,
  purchasedOn: DateTime.parse(json['purchased_on'] as String),
  productVariant: ProductVariant.fromJson(
    json['product_variant'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic>
_$AppModulesSportCompetitionSchemasSportCompetitionPurchaseCompleteToJson(
  AppModulesSportCompetitionSchemasSportCompetitionPurchaseComplete instance,
) => <String, dynamic>{
  'product_variant_id': instance.productVariantId,
  'quantity': instance.quantity,
  'user_id': instance.userId,
  'edition_id': instance.editionId,
  'validated': instance.validated,
  'purchased_on': instance.purchasedOn.toIso8601String(),
  'product_variant': instance.productVariant.toJson(),
};

AppTypesStandardResponsesResult _$AppTypesStandardResponsesResultFromJson(
  Map<String, dynamic> json,
) => AppTypesStandardResponsesResult(success: json['success'] as bool? ?? true);

Map<String, dynamic> _$AppTypesStandardResponsesResultToJson(
  AppTypesStandardResponsesResult instance,
) => <String, dynamic>{'success': instance.success};
