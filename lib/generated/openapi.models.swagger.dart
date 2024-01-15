// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'openapi.enums.swagger.dart' as enums;

part 'openapi.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class AccessToken {
  const AccessToken({
    required this.accessToken,
    required this.tokenType,
  });

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);

  static const toJsonFactory = _$AccessTokenToJson;
  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);

  @JsonKey(name: 'access_token', defaultValue: '')
  final String accessToken;
  @JsonKey(name: 'token_type', defaultValue: '')
  final String tokenType;
  static const fromJsonFactory = _$AccessTokenFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AccessToken &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality()
                    .equals(other.tokenType, tokenType)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(tokenType) ^
      runtimeType.hashCode;
}

extension $AccessTokenExtension on AccessToken {
  AccessToken copyWith({String? accessToken, String? tokenType}) {
    return AccessToken(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType);
  }

  AccessToken copyWithWrapped(
      {Wrapped<String>? accessToken, Wrapped<String>? tokenType}) {
    return AccessToken(
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        tokenType: (tokenType != null ? tokenType.value : this.tokenType));
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertBase {
  const AdvertBase({
    required this.title,
    required this.content,
    required this.advertiserId,
    this.tags,
  });

  factory AdvertBase.fromJson(Map<String, dynamic> json) =>
      _$AdvertBaseFromJson(json);

  static const toJsonFactory = _$AdvertBaseToJson;
  Map<String, dynamic> toJson() => _$AdvertBaseToJson(this);

  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'content', defaultValue: '')
  final String content;
  @JsonKey(name: 'advertiser_id', defaultValue: '')
  final String advertiserId;
  @JsonKey(name: 'tags', defaultValue: '')
  final String? tags;
  static const fromJsonFactory = _$AdvertBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvertBase &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.advertiserId, advertiserId) ||
                const DeepCollectionEquality()
                    .equals(other.advertiserId, advertiserId)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(advertiserId) ^
      const DeepCollectionEquality().hash(tags) ^
      runtimeType.hashCode;
}

extension $AdvertBaseExtension on AdvertBase {
  AdvertBase copyWith(
      {String? title, String? content, String? advertiserId, String? tags}) {
    return AdvertBase(
        title: title ?? this.title,
        content: content ?? this.content,
        advertiserId: advertiserId ?? this.advertiserId,
        tags: tags ?? this.tags);
  }

  AdvertBase copyWithWrapped(
      {Wrapped<String>? title,
      Wrapped<String>? content,
      Wrapped<String>? advertiserId,
      Wrapped<String?>? tags}) {
    return AdvertBase(
        title: (title != null ? title.value : this.title),
        content: (content != null ? content.value : this.content),
        advertiserId:
            (advertiserId != null ? advertiserId.value : this.advertiserId),
        tags: (tags != null ? tags.value : this.tags));
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertReturnComplete {
  const AdvertReturnComplete({
    required this.title,
    required this.content,
    required this.advertiserId,
    this.tags,
    required this.id,
    required this.advertiser,
    this.date,
  });

  factory AdvertReturnComplete.fromJson(Map<String, dynamic> json) =>
      _$AdvertReturnCompleteFromJson(json);

  static const toJsonFactory = _$AdvertReturnCompleteToJson;
  Map<String, dynamic> toJson() => _$AdvertReturnCompleteToJson(this);

  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'content', defaultValue: '')
  final String content;
  @JsonKey(name: 'advertiser_id', defaultValue: '')
  final String advertiserId;
  @JsonKey(name: 'tags', defaultValue: '')
  final String? tags;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'advertiser')
  final AdvertiserComplete advertiser;
  @JsonKey(name: 'date')
  final DateTime? date;
  static const fromJsonFactory = _$AdvertReturnCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvertReturnComplete &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.advertiserId, advertiserId) ||
                const DeepCollectionEquality()
                    .equals(other.advertiserId, advertiserId)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.advertiser, advertiser) ||
                const DeepCollectionEquality()
                    .equals(other.advertiser, advertiser)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(advertiserId) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(advertiser) ^
      const DeepCollectionEquality().hash(date) ^
      runtimeType.hashCode;
}

extension $AdvertReturnCompleteExtension on AdvertReturnComplete {
  AdvertReturnComplete copyWith(
      {String? title,
      String? content,
      String? advertiserId,
      String? tags,
      String? id,
      AdvertiserComplete? advertiser,
      DateTime? date}) {
    return AdvertReturnComplete(
        title: title ?? this.title,
        content: content ?? this.content,
        advertiserId: advertiserId ?? this.advertiserId,
        tags: tags ?? this.tags,
        id: id ?? this.id,
        advertiser: advertiser ?? this.advertiser,
        date: date ?? this.date);
  }

  AdvertReturnComplete copyWithWrapped(
      {Wrapped<String>? title,
      Wrapped<String>? content,
      Wrapped<String>? advertiserId,
      Wrapped<String?>? tags,
      Wrapped<String>? id,
      Wrapped<AdvertiserComplete>? advertiser,
      Wrapped<DateTime?>? date}) {
    return AdvertReturnComplete(
        title: (title != null ? title.value : this.title),
        content: (content != null ? content.value : this.content),
        advertiserId:
            (advertiserId != null ? advertiserId.value : this.advertiserId),
        tags: (tags != null ? tags.value : this.tags),
        id: (id != null ? id.value : this.id),
        advertiser: (advertiser != null ? advertiser.value : this.advertiser),
        date: (date != null ? date.value : this.date));
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertUpdate {
  const AdvertUpdate({
    this.title,
    this.content,
    this.tags,
  });

  factory AdvertUpdate.fromJson(Map<String, dynamic> json) =>
      _$AdvertUpdateFromJson(json);

  static const toJsonFactory = _$AdvertUpdateToJson;
  Map<String, dynamic> toJson() => _$AdvertUpdateToJson(this);

  @JsonKey(name: 'title', defaultValue: '')
  final String? title;
  @JsonKey(name: 'content', defaultValue: '')
  final String? content;
  @JsonKey(name: 'tags', defaultValue: '')
  final String? tags;
  static const fromJsonFactory = _$AdvertUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvertUpdate &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(tags) ^
      runtimeType.hashCode;
}

extension $AdvertUpdateExtension on AdvertUpdate {
  AdvertUpdate copyWith({String? title, String? content, String? tags}) {
    return AdvertUpdate(
        title: title ?? this.title,
        content: content ?? this.content,
        tags: tags ?? this.tags);
  }

  AdvertUpdate copyWithWrapped(
      {Wrapped<String?>? title,
      Wrapped<String?>? content,
      Wrapped<String?>? tags}) {
    return AdvertUpdate(
        title: (title != null ? title.value : this.title),
        content: (content != null ? content.value : this.content),
        tags: (tags != null ? tags.value : this.tags));
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertiserBase {
  const AdvertiserBase({
    required this.name,
    required this.groupManagerId,
  });

  factory AdvertiserBase.fromJson(Map<String, dynamic> json) =>
      _$AdvertiserBaseFromJson(json);

  static const toJsonFactory = _$AdvertiserBaseToJson;
  Map<String, dynamic> toJson() => _$AdvertiserBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_manager_id', defaultValue: '')
  final String groupManagerId;
  static const fromJsonFactory = _$AdvertiserBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvertiserBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality()
                    .equals(other.groupManagerId, groupManagerId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupManagerId) ^
      runtimeType.hashCode;
}

extension $AdvertiserBaseExtension on AdvertiserBase {
  AdvertiserBase copyWith({String? name, String? groupManagerId}) {
    return AdvertiserBase(
        name: name ?? this.name,
        groupManagerId: groupManagerId ?? this.groupManagerId);
  }

  AdvertiserBase copyWithWrapped(
      {Wrapped<String>? name, Wrapped<String>? groupManagerId}) {
    return AdvertiserBase(
        name: (name != null ? name.value : this.name),
        groupManagerId: (groupManagerId != null
            ? groupManagerId.value
            : this.groupManagerId));
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertiserComplete {
  const AdvertiserComplete({
    required this.name,
    required this.groupManagerId,
    required this.id,
  });

  factory AdvertiserComplete.fromJson(Map<String, dynamic> json) =>
      _$AdvertiserCompleteFromJson(json);

  static const toJsonFactory = _$AdvertiserCompleteToJson;
  Map<String, dynamic> toJson() => _$AdvertiserCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_manager_id', defaultValue: '')
  final String groupManagerId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$AdvertiserCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvertiserComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality()
                    .equals(other.groupManagerId, groupManagerId)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupManagerId) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $AdvertiserCompleteExtension on AdvertiserComplete {
  AdvertiserComplete copyWith(
      {String? name, String? groupManagerId, String? id}) {
    return AdvertiserComplete(
        name: name ?? this.name,
        groupManagerId: groupManagerId ?? this.groupManagerId,
        id: id ?? this.id);
  }

  AdvertiserComplete copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? groupManagerId,
      Wrapped<String>? id}) {
    return AdvertiserComplete(
        name: (name != null ? name.value : this.name),
        groupManagerId: (groupManagerId != null
            ? groupManagerId.value
            : this.groupManagerId),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertiserUpdate {
  const AdvertiserUpdate({
    this.name,
    this.groupManagerId,
  });

  factory AdvertiserUpdate.fromJson(Map<String, dynamic> json) =>
      _$AdvertiserUpdateFromJson(json);

  static const toJsonFactory = _$AdvertiserUpdateToJson;
  Map<String, dynamic> toJson() => _$AdvertiserUpdateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'group_manager_id', defaultValue: '')
  final String? groupManagerId;
  static const fromJsonFactory = _$AdvertiserUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdvertiserUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality()
                    .equals(other.groupManagerId, groupManagerId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupManagerId) ^
      runtimeType.hashCode;
}

extension $AdvertiserUpdateExtension on AdvertiserUpdate {
  AdvertiserUpdate copyWith({String? name, String? groupManagerId}) {
    return AdvertiserUpdate(
        name: name ?? this.name,
        groupManagerId: groupManagerId ?? this.groupManagerId);
  }

  AdvertiserUpdate copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<String?>? groupManagerId}) {
    return AdvertiserUpdate(
        name: (name != null ? name.value : this.name),
        groupManagerId: (groupManagerId != null
            ? groupManagerId.value
            : this.groupManagerId));
  }
}

@JsonSerializable(explicitToJson: true)
class Applicant {
  const Applicant({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.email,
    this.promo,
    this.phone,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) =>
      _$ApplicantFromJson(json);

  static const toJsonFactory = _$ApplicantToJson;
  Map<String, dynamic> toJson() => _$ApplicantToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'promo', defaultValue: 0)
  final int? promo;
  @JsonKey(name: 'phone', defaultValue: '')
  final String? phone;
  static const fromJsonFactory = _$ApplicantFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Applicant &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(phone) ^
      runtimeType.hashCode;
}

extension $ApplicantExtension on Applicant {
  Applicant copyWith(
      {String? name,
      String? firstname,
      String? nickname,
      String? id,
      String? email,
      int? promo,
      String? phone}) {
    return Applicant(
        name: name ?? this.name,
        firstname: firstname ?? this.firstname,
        nickname: nickname ?? this.nickname,
        id: id ?? this.id,
        email: email ?? this.email,
        promo: promo ?? this.promo,
        phone: phone ?? this.phone);
  }

  Applicant copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? firstname,
      Wrapped<String?>? nickname,
      Wrapped<String>? id,
      Wrapped<String>? email,
      Wrapped<int?>? promo,
      Wrapped<String?>? phone}) {
    return Applicant(
        name: (name != null ? name.value : this.name),
        firstname: (firstname != null ? firstname.value : this.firstname),
        nickname: (nickname != null ? nickname.value : this.nickname),
        id: (id != null ? id.value : this.id),
        email: (email != null ? email.value : this.email),
        promo: (promo != null ? promo.value : this.promo),
        phone: (phone != null ? phone.value : this.phone));
  }
}

@JsonSerializable(explicitToJson: true)
class BatchResult {
  const BatchResult({
    required this.failed,
  });

  factory BatchResult.fromJson(Map<String, dynamic> json) =>
      _$BatchResultFromJson(json);

  static const toJsonFactory = _$BatchResultToJson;
  Map<String, dynamic> toJson() => _$BatchResultToJson(this);

  @JsonKey(name: 'failed')
  final Map<String, dynamic> failed;
  static const fromJsonFactory = _$BatchResultFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BatchResult &&
            (identical(other.failed, failed) ||
                const DeepCollectionEquality().equals(other.failed, failed)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(failed) ^ runtimeType.hashCode;
}

extension $BatchResultExtension on BatchResult {
  BatchResult copyWith({Map<String, dynamic>? failed}) {
    return BatchResult(failed: failed ?? this.failed);
  }

  BatchResult copyWithWrapped({Wrapped<Map<String, dynamic>>? failed}) {
    return BatchResult(failed: (failed != null ? failed.value : this.failed));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost {
  const BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost({
    required this.clientId,
    this.redirectUri,
    required this.responseType,
    this.scope,
    this.state,
    this.nonce,
    this.codeChallenge,
    this.codeChallengeMethod,
    required this.email,
    required this.password,
  });

  factory BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostFromJson(
          json);

  static const toJsonFactory =
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostToJson(
          this);

  @JsonKey(name: 'client_id', defaultValue: '')
  final String clientId;
  @JsonKey(name: 'redirect_uri', defaultValue: '')
  final String? redirectUri;
  @JsonKey(name: 'response_type', defaultValue: '')
  final String responseType;
  @JsonKey(name: 'scope', defaultValue: '')
  final String? scope;
  @JsonKey(name: 'state', defaultValue: '')
  final String? state;
  @JsonKey(name: 'nonce', defaultValue: '')
  final String? nonce;
  @JsonKey(name: 'code_challenge', defaultValue: '')
  final String? codeChallenge;
  @JsonKey(name: 'code_challenge_method', defaultValue: '')
  final String? codeChallengeMethod;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  static const fromJsonFactory =
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality()
                    .equals(other.redirectUri, redirectUri)) &&
            (identical(other.responseType, responseType) ||
                const DeepCollectionEquality()
                    .equals(other.responseType, responseType)) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.nonce, nonce) ||
                const DeepCollectionEquality().equals(other.nonce, nonce)) &&
            (identical(other.codeChallenge, codeChallenge) ||
                const DeepCollectionEquality()
                    .equals(other.codeChallenge, codeChallenge)) &&
            (identical(other.codeChallengeMethod, codeChallengeMethod) ||
                const DeepCollectionEquality()
                    .equals(other.codeChallengeMethod, codeChallengeMethod)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(redirectUri) ^
      const DeepCollectionEquality().hash(responseType) ^
      const DeepCollectionEquality().hash(scope) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(nonce) ^
      const DeepCollectionEquality().hash(codeChallenge) ^
      const DeepCollectionEquality().hash(codeChallengeMethod) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostExtension
    on BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost {
  BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost copyWith(
      {String? clientId,
      String? redirectUri,
      String? responseType,
      String? scope,
      String? state,
      String? nonce,
      String? codeChallenge,
      String? codeChallengeMethod,
      String? email,
      String? password}) {
    return BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost(
        clientId: clientId ?? this.clientId,
        redirectUri: redirectUri ?? this.redirectUri,
        responseType: responseType ?? this.responseType,
        scope: scope ?? this.scope,
        state: state ?? this.state,
        nonce: nonce ?? this.nonce,
        codeChallenge: codeChallenge ?? this.codeChallenge,
        codeChallengeMethod: codeChallengeMethod ?? this.codeChallengeMethod,
        email: email ?? this.email,
        password: password ?? this.password);
  }

  BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost
      copyWithWrapped(
          {Wrapped<String>? clientId,
          Wrapped<String?>? redirectUri,
          Wrapped<String>? responseType,
          Wrapped<String?>? scope,
          Wrapped<String?>? state,
          Wrapped<String?>? nonce,
          Wrapped<String?>? codeChallenge,
          Wrapped<String?>? codeChallengeMethod,
          Wrapped<String>? email,
          Wrapped<String>? password}) {
    return BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost(
        clientId: (clientId != null ? clientId.value : this.clientId),
        redirectUri:
            (redirectUri != null ? redirectUri.value : this.redirectUri),
        responseType:
            (responseType != null ? responseType.value : this.responseType),
        scope: (scope != null ? scope.value : this.scope),
        state: (state != null ? state.value : this.state),
        nonce: (nonce != null ? nonce.value : this.nonce),
        codeChallenge:
            (codeChallenge != null ? codeChallenge.value : this.codeChallenge),
        codeChallengeMethod: (codeChallengeMethod != null
            ? codeChallengeMethod.value
            : this.codeChallengeMethod),
        email: (email != null ? email.value : this.email),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost {
  const BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost({
    required this.image,
  });

  factory BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostFromJson(json);

  static const toJsonFactory =
      _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostExtension
    on BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost {
  BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost copyWith(
      {String? image}) {
    return BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost(
        image: image ?? this.image);
  }

  BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost copyWithWrapped(
      {Wrapped<String>? image}) {
    return BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost(
        image: (image != null ? image.value : this.image));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCampaignsLogoCampaignListsListIdLogoPost {
  const BodyCreateCampaignsLogoCampaignListsListIdLogoPost({
    required this.image,
  });

  factory BodyCreateCampaignsLogoCampaignListsListIdLogoPost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostFromJson(json);

  static const toJsonFactory =
      _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyCreateCampaignsLogoCampaignListsListIdLogoPost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreateCampaignsLogoCampaignListsListIdLogoPostExtension
    on BodyCreateCampaignsLogoCampaignListsListIdLogoPost {
  BodyCreateCampaignsLogoCampaignListsListIdLogoPost copyWith({String? image}) {
    return BodyCreateCampaignsLogoCampaignListsListIdLogoPost(
        image: image ?? this.image);
  }

  BodyCreateCampaignsLogoCampaignListsListIdLogoPost copyWithWrapped(
      {Wrapped<String>? image}) {
    return BodyCreateCampaignsLogoCampaignListsListIdLogoPost(
        image: (image != null ? image.value : this.image));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost {
  const BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost({
    required this.image,
  });

  factory BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostFromJson(json);

  static const toJsonFactory =
      _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostExtension
    on BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost {
  BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost copyWith(
      {String? image}) {
    return BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost(
        image: image ?? this.image);
  }

  BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost copyWithWrapped(
      {Wrapped<String>? image}) {
    return BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost(
        image: (image != null ? image.value : this.image));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost {
  const BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost({
    required this.image,
  });

  factory BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostFromJson(json);

  static const toJsonFactory =
      _$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPostExtension
    on BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost {
  BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost copyWith(
      {String? image}) {
    return BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost(
        image: image ?? this.image);
  }

  BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost copyWithWrapped(
      {Wrapped<String>? image}) {
    return BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost(
        image: (image != null ? image.value : this.image));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost {
  const BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost({
    required this.image,
  });

  factory BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostFromJson(
          json);

  static const toJsonFactory =
      _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostToJson(
          this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostExtension
    on BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost {
  BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost copyWith(
      {String? image}) {
    return BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost(
        image: image ?? this.image);
  }

  BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost copyWithWrapped(
      {Wrapped<String>? image}) {
    return BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost(
        image: (image != null ? image.value : this.image));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost {
  const BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost({
    required this.image,
  });

  factory BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostFromJson(json);

  static const toJsonFactory =
      _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostExtension
    on BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost {
  BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost copyWith(
      {String? image}) {
    return BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost(
        image: image ?? this.image);
  }

  BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost copyWithWrapped(
      {Wrapped<String>? image}) {
    return BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost(
        image: (image != null ? image.value : this.image));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyLoginForAccessTokenAuthSimpleTokenPost {
  const BodyLoginForAccessTokenAuthSimpleTokenPost({
    this.grantType,
    required this.username,
    required this.password,
    this.scope,
    this.clientId,
    this.clientSecret,
  });

  factory BodyLoginForAccessTokenAuthSimpleTokenPost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyLoginForAccessTokenAuthSimpleTokenPostFromJson(json);

  static const toJsonFactory =
      _$BodyLoginForAccessTokenAuthSimpleTokenPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyLoginForAccessTokenAuthSimpleTokenPostToJson(this);

  @JsonKey(name: 'grant_type', defaultValue: '')
  final String? grantType;
  @JsonKey(name: 'username', defaultValue: '')
  final String username;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  @JsonKey(name: 'scope', defaultValue: '')
  final String? scope;
  @JsonKey(name: 'client_id', defaultValue: '')
  final String? clientId;
  @JsonKey(name: 'client_secret', defaultValue: '')
  final String? clientSecret;
  static const fromJsonFactory =
      _$BodyLoginForAccessTokenAuthSimpleTokenPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyLoginForAccessTokenAuthSimpleTokenPost &&
            (identical(other.grantType, grantType) ||
                const DeepCollectionEquality()
                    .equals(other.grantType, grantType)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality()
                    .equals(other.clientSecret, clientSecret)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(grantType) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(scope) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(clientSecret) ^
      runtimeType.hashCode;
}

extension $BodyLoginForAccessTokenAuthSimpleTokenPostExtension
    on BodyLoginForAccessTokenAuthSimpleTokenPost {
  BodyLoginForAccessTokenAuthSimpleTokenPost copyWith(
      {String? grantType,
      String? username,
      String? password,
      String? scope,
      String? clientId,
      String? clientSecret}) {
    return BodyLoginForAccessTokenAuthSimpleTokenPost(
        grantType: grantType ?? this.grantType,
        username: username ?? this.username,
        password: password ?? this.password,
        scope: scope ?? this.scope,
        clientId: clientId ?? this.clientId,
        clientSecret: clientSecret ?? this.clientSecret);
  }

  BodyLoginForAccessTokenAuthSimpleTokenPost copyWithWrapped(
      {Wrapped<String?>? grantType,
      Wrapped<String>? username,
      Wrapped<String>? password,
      Wrapped<String?>? scope,
      Wrapped<String?>? clientId,
      Wrapped<String?>? clientSecret}) {
    return BodyLoginForAccessTokenAuthSimpleTokenPost(
        grantType: (grantType != null ? grantType.value : this.grantType),
        username: (username != null ? username.value : this.username),
        password: (password != null ? password.value : this.password),
        scope: (scope != null ? scope.value : this.scope),
        clientId: (clientId != null ? clientId.value : this.clientId),
        clientSecret:
            (clientSecret != null ? clientSecret.value : this.clientSecret));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyPostAuthorizePageAuthAuthorizePost {
  const BodyPostAuthorizePageAuthAuthorizePost({
    required this.responseType,
    required this.clientId,
    required this.redirectUri,
    this.scope,
    this.state,
    this.nonce,
    this.codeChallenge,
    this.codeChallengeMethod,
  });

  factory BodyPostAuthorizePageAuthAuthorizePost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyPostAuthorizePageAuthAuthorizePostFromJson(json);

  static const toJsonFactory = _$BodyPostAuthorizePageAuthAuthorizePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyPostAuthorizePageAuthAuthorizePostToJson(this);

  @JsonKey(name: 'response_type', defaultValue: '')
  final String responseType;
  @JsonKey(name: 'client_id', defaultValue: '')
  final String clientId;
  @JsonKey(name: 'redirect_uri', defaultValue: '')
  final String redirectUri;
  @JsonKey(name: 'scope', defaultValue: '')
  final String? scope;
  @JsonKey(name: 'state', defaultValue: '')
  final String? state;
  @JsonKey(name: 'nonce', defaultValue: '')
  final String? nonce;
  @JsonKey(name: 'code_challenge', defaultValue: '')
  final String? codeChallenge;
  @JsonKey(name: 'code_challenge_method', defaultValue: '')
  final String? codeChallengeMethod;
  static const fromJsonFactory =
      _$BodyPostAuthorizePageAuthAuthorizePostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyPostAuthorizePageAuthAuthorizePost &&
            (identical(other.responseType, responseType) ||
                const DeepCollectionEquality()
                    .equals(other.responseType, responseType)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality()
                    .equals(other.redirectUri, redirectUri)) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.nonce, nonce) ||
                const DeepCollectionEquality().equals(other.nonce, nonce)) &&
            (identical(other.codeChallenge, codeChallenge) ||
                const DeepCollectionEquality()
                    .equals(other.codeChallenge, codeChallenge)) &&
            (identical(other.codeChallengeMethod, codeChallengeMethod) ||
                const DeepCollectionEquality()
                    .equals(other.codeChallengeMethod, codeChallengeMethod)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(responseType) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(redirectUri) ^
      const DeepCollectionEquality().hash(scope) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(nonce) ^
      const DeepCollectionEquality().hash(codeChallenge) ^
      const DeepCollectionEquality().hash(codeChallengeMethod) ^
      runtimeType.hashCode;
}

extension $BodyPostAuthorizePageAuthAuthorizePostExtension
    on BodyPostAuthorizePageAuthAuthorizePost {
  BodyPostAuthorizePageAuthAuthorizePost copyWith(
      {String? responseType,
      String? clientId,
      String? redirectUri,
      String? scope,
      String? state,
      String? nonce,
      String? codeChallenge,
      String? codeChallengeMethod}) {
    return BodyPostAuthorizePageAuthAuthorizePost(
        responseType: responseType ?? this.responseType,
        clientId: clientId ?? this.clientId,
        redirectUri: redirectUri ?? this.redirectUri,
        scope: scope ?? this.scope,
        state: state ?? this.state,
        nonce: nonce ?? this.nonce,
        codeChallenge: codeChallenge ?? this.codeChallenge,
        codeChallengeMethod: codeChallengeMethod ?? this.codeChallengeMethod);
  }

  BodyPostAuthorizePageAuthAuthorizePost copyWithWrapped(
      {Wrapped<String>? responseType,
      Wrapped<String>? clientId,
      Wrapped<String>? redirectUri,
      Wrapped<String?>? scope,
      Wrapped<String?>? state,
      Wrapped<String?>? nonce,
      Wrapped<String?>? codeChallenge,
      Wrapped<String?>? codeChallengeMethod}) {
    return BodyPostAuthorizePageAuthAuthorizePost(
        responseType:
            (responseType != null ? responseType.value : this.responseType),
        clientId: (clientId != null ? clientId.value : this.clientId),
        redirectUri:
            (redirectUri != null ? redirectUri.value : this.redirectUri),
        scope: (scope != null ? scope.value : this.scope),
        state: (state != null ? state.value : this.state),
        nonce: (nonce != null ? nonce.value : this.nonce),
        codeChallenge:
            (codeChallenge != null ? codeChallenge.value : this.codeChallenge),
        codeChallengeMethod: (codeChallengeMethod != null
            ? codeChallengeMethod.value
            : this.codeChallengeMethod));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyRecoverUserUsersRecoverPost {
  const BodyRecoverUserUsersRecoverPost({
    required this.email,
  });

  factory BodyRecoverUserUsersRecoverPost.fromJson(Map<String, dynamic> json) =>
      _$BodyRecoverUserUsersRecoverPostFromJson(json);

  static const toJsonFactory = _$BodyRecoverUserUsersRecoverPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyRecoverUserUsersRecoverPostToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  static const fromJsonFactory = _$BodyRecoverUserUsersRecoverPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyRecoverUserUsersRecoverPost &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $BodyRecoverUserUsersRecoverPostExtension
    on BodyRecoverUserUsersRecoverPost {
  BodyRecoverUserUsersRecoverPost copyWith({String? email}) {
    return BodyRecoverUserUsersRecoverPost(email: email ?? this.email);
  }

  BodyRecoverUserUsersRecoverPost copyWithWrapped({Wrapped<String>? email}) {
    return BodyRecoverUserUsersRecoverPost(
        email: (email != null ? email.value : this.email));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyRegisterFirebaseDeviceNotificationDevicesPost {
  const BodyRegisterFirebaseDeviceNotificationDevicesPost({
    required this.firebaseToken,
  });

  factory BodyRegisterFirebaseDeviceNotificationDevicesPost.fromJson(
          Map<String, dynamic> json) =>
      _$BodyRegisterFirebaseDeviceNotificationDevicesPostFromJson(json);

  static const toJsonFactory =
      _$BodyRegisterFirebaseDeviceNotificationDevicesPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyRegisterFirebaseDeviceNotificationDevicesPostToJson(this);

  @JsonKey(name: 'firebase_token', defaultValue: '')
  final String firebaseToken;
  static const fromJsonFactory =
      _$BodyRegisterFirebaseDeviceNotificationDevicesPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyRegisterFirebaseDeviceNotificationDevicesPost &&
            (identical(other.firebaseToken, firebaseToken) ||
                const DeepCollectionEquality()
                    .equals(other.firebaseToken, firebaseToken)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firebaseToken) ^ runtimeType.hashCode;
}

extension $BodyRegisterFirebaseDeviceNotificationDevicesPostExtension
    on BodyRegisterFirebaseDeviceNotificationDevicesPost {
  BodyRegisterFirebaseDeviceNotificationDevicesPost copyWith(
      {String? firebaseToken}) {
    return BodyRegisterFirebaseDeviceNotificationDevicesPost(
        firebaseToken: firebaseToken ?? this.firebaseToken);
  }

  BodyRegisterFirebaseDeviceNotificationDevicesPost copyWithWrapped(
      {Wrapped<String>? firebaseToken}) {
    return BodyRegisterFirebaseDeviceNotificationDevicesPost(
        firebaseToken:
            (firebaseToken != null ? firebaseToken.value : this.firebaseToken));
  }
}

@JsonSerializable(explicitToJson: true)
class BodyTokenAuthTokenPost {
  const BodyTokenAuthTokenPost({
    this.refreshToken,
    required this.grantType,
    this.code,
    this.redirectUri,
    this.clientId,
    this.clientSecret,
    this.codeVerifier,
  });

  factory BodyTokenAuthTokenPost.fromJson(Map<String, dynamic> json) =>
      _$BodyTokenAuthTokenPostFromJson(json);

  static const toJsonFactory = _$BodyTokenAuthTokenPostToJson;
  Map<String, dynamic> toJson() => _$BodyTokenAuthTokenPostToJson(this);

  @JsonKey(name: 'refresh_token', defaultValue: '')
  final String? refreshToken;
  @JsonKey(name: 'grant_type', defaultValue: '')
  final String grantType;
  @JsonKey(name: 'code', defaultValue: '')
  final String? code;
  @JsonKey(name: 'redirect_uri', defaultValue: '')
  final String? redirectUri;
  @JsonKey(name: 'client_id', defaultValue: '')
  final String? clientId;
  @JsonKey(name: 'client_secret', defaultValue: '')
  final String? clientSecret;
  @JsonKey(name: 'code_verifier', defaultValue: '')
  final String? codeVerifier;
  static const fromJsonFactory = _$BodyTokenAuthTokenPostFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BodyTokenAuthTokenPost &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.grantType, grantType) ||
                const DeepCollectionEquality()
                    .equals(other.grantType, grantType)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality()
                    .equals(other.redirectUri, redirectUri)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality()
                    .equals(other.clientId, clientId)) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality()
                    .equals(other.clientSecret, clientSecret)) &&
            (identical(other.codeVerifier, codeVerifier) ||
                const DeepCollectionEquality()
                    .equals(other.codeVerifier, codeVerifier)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(grantType) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(redirectUri) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(clientSecret) ^
      const DeepCollectionEquality().hash(codeVerifier) ^
      runtimeType.hashCode;
}

extension $BodyTokenAuthTokenPostExtension on BodyTokenAuthTokenPost {
  BodyTokenAuthTokenPost copyWith(
      {String? refreshToken,
      String? grantType,
      String? code,
      String? redirectUri,
      String? clientId,
      String? clientSecret,
      String? codeVerifier}) {
    return BodyTokenAuthTokenPost(
        refreshToken: refreshToken ?? this.refreshToken,
        grantType: grantType ?? this.grantType,
        code: code ?? this.code,
        redirectUri: redirectUri ?? this.redirectUri,
        clientId: clientId ?? this.clientId,
        clientSecret: clientSecret ?? this.clientSecret,
        codeVerifier: codeVerifier ?? this.codeVerifier);
  }

  BodyTokenAuthTokenPost copyWithWrapped(
      {Wrapped<String?>? refreshToken,
      Wrapped<String>? grantType,
      Wrapped<String?>? code,
      Wrapped<String?>? redirectUri,
      Wrapped<String?>? clientId,
      Wrapped<String?>? clientSecret,
      Wrapped<String?>? codeVerifier}) {
    return BodyTokenAuthTokenPost(
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        grantType: (grantType != null ? grantType.value : this.grantType),
        code: (code != null ? code.value : this.code),
        redirectUri:
            (redirectUri != null ? redirectUri.value : this.redirectUri),
        clientId: (clientId != null ? clientId.value : this.clientId),
        clientSecret:
            (clientSecret != null ? clientSecret.value : this.clientSecret),
        codeVerifier:
            (codeVerifier != null ? codeVerifier.value : this.codeVerifier));
  }
}

@JsonSerializable(explicitToJson: true)
class BookingBase {
  const BookingBase({
    required this.reason,
    required this.start,
    required this.end,
    required this.creation,
    this.note,
    required this.roomId,
    required this.key,
    this.recurrenceRule,
    this.entity,
  });

  factory BookingBase.fromJson(Map<String, dynamic> json) =>
      _$BookingBaseFromJson(json);

  static const toJsonFactory = _$BookingBaseToJson;
  Map<String, dynamic> toJson() => _$BookingBaseToJson(this);

  @JsonKey(name: 'reason', defaultValue: '')
  final String reason;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(name: 'note', defaultValue: '')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  @JsonKey(name: 'entity', defaultValue: '')
  final String? entity;
  static const fromJsonFactory = _$BookingBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BookingBase &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality()
                    .equals(other.creation, creation)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(reason) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      const DeepCollectionEquality().hash(entity) ^
      runtimeType.hashCode;
}

extension $BookingBaseExtension on BookingBase {
  BookingBase copyWith(
      {String? reason,
      DateTime? start,
      DateTime? end,
      DateTime? creation,
      String? note,
      String? roomId,
      bool? key,
      String? recurrenceRule,
      String? entity}) {
    return BookingBase(
        reason: reason ?? this.reason,
        start: start ?? this.start,
        end: end ?? this.end,
        creation: creation ?? this.creation,
        note: note ?? this.note,
        roomId: roomId ?? this.roomId,
        key: key ?? this.key,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        entity: entity ?? this.entity);
  }

  BookingBase copyWithWrapped(
      {Wrapped<String>? reason,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<DateTime>? creation,
      Wrapped<String?>? note,
      Wrapped<String>? roomId,
      Wrapped<bool>? key,
      Wrapped<String?>? recurrenceRule,
      Wrapped<String?>? entity}) {
    return BookingBase(
        reason: (reason != null ? reason.value : this.reason),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        creation: (creation != null ? creation.value : this.creation),
        note: (note != null ? note.value : this.note),
        roomId: (roomId != null ? roomId.value : this.roomId),
        key: (key != null ? key.value : this.key),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule),
        entity: (entity != null ? entity.value : this.entity));
  }
}

@JsonSerializable(explicitToJson: true)
class BookingEdit {
  const BookingEdit({
    this.reason,
    this.start,
    this.end,
    this.note,
    this.roomId,
    this.key,
    this.recurrenceRule,
    this.entity,
  });

  factory BookingEdit.fromJson(Map<String, dynamic> json) =>
      _$BookingEditFromJson(json);

  static const toJsonFactory = _$BookingEditToJson;
  Map<String, dynamic> toJson() => _$BookingEditToJson(this);

  @JsonKey(name: 'reason', defaultValue: '')
  final String? reason;
  @JsonKey(name: 'start')
  final DateTime? start;
  @JsonKey(name: 'end')
  final DateTime? end;
  @JsonKey(name: 'note', defaultValue: '')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String? roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool? key;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  @JsonKey(name: 'entity', defaultValue: '')
  final String? entity;
  static const fromJsonFactory = _$BookingEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BookingEdit &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(reason) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      const DeepCollectionEquality().hash(entity) ^
      runtimeType.hashCode;
}

extension $BookingEditExtension on BookingEdit {
  BookingEdit copyWith(
      {String? reason,
      DateTime? start,
      DateTime? end,
      String? note,
      String? roomId,
      bool? key,
      String? recurrenceRule,
      String? entity}) {
    return BookingEdit(
        reason: reason ?? this.reason,
        start: start ?? this.start,
        end: end ?? this.end,
        note: note ?? this.note,
        roomId: roomId ?? this.roomId,
        key: key ?? this.key,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        entity: entity ?? this.entity);
  }

  BookingEdit copyWithWrapped(
      {Wrapped<String?>? reason,
      Wrapped<DateTime?>? start,
      Wrapped<DateTime?>? end,
      Wrapped<String?>? note,
      Wrapped<String?>? roomId,
      Wrapped<bool?>? key,
      Wrapped<String?>? recurrenceRule,
      Wrapped<String?>? entity}) {
    return BookingEdit(
        reason: (reason != null ? reason.value : this.reason),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        note: (note != null ? note.value : this.note),
        roomId: (roomId != null ? roomId.value : this.roomId),
        key: (key != null ? key.value : this.key),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule),
        entity: (entity != null ? entity.value : this.entity));
  }
}

@JsonSerializable(explicitToJson: true)
class BookingReturn {
  const BookingReturn({
    required this.reason,
    required this.start,
    required this.end,
    required this.creation,
    this.note,
    required this.roomId,
    required this.key,
    this.recurrenceRule,
    this.entity,
    required this.id,
    required this.decision,
    required this.applicantId,
    required this.room,
  });

  factory BookingReturn.fromJson(Map<String, dynamic> json) =>
      _$BookingReturnFromJson(json);

  static const toJsonFactory = _$BookingReturnToJson;
  Map<String, dynamic> toJson() => _$BookingReturnToJson(this);

  @JsonKey(name: 'reason', defaultValue: '')
  final String reason;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(name: 'note', defaultValue: '')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  @JsonKey(name: 'entity', defaultValue: '')
  final String? entity;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'decision',
    toJson: appUtilsTypesBookingTypeDecisionToJson,
    fromJson: appUtilsTypesBookingTypeDecisionFromJson,
  )
  final enums.AppUtilsTypesBookingTypeDecision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'room')
  final RoomComplete room;
  static const fromJsonFactory = _$BookingReturnFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BookingReturn &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality()
                    .equals(other.creation, creation)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality()
                    .equals(other.decision, decision)) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality()
                    .equals(other.applicantId, applicantId)) &&
            (identical(other.room, room) ||
                const DeepCollectionEquality().equals(other.room, room)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(reason) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      const DeepCollectionEquality().hash(entity) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(decision) ^
      const DeepCollectionEquality().hash(applicantId) ^
      const DeepCollectionEquality().hash(room) ^
      runtimeType.hashCode;
}

extension $BookingReturnExtension on BookingReturn {
  BookingReturn copyWith(
      {String? reason,
      DateTime? start,
      DateTime? end,
      DateTime? creation,
      String? note,
      String? roomId,
      bool? key,
      String? recurrenceRule,
      String? entity,
      String? id,
      enums.AppUtilsTypesBookingTypeDecision? decision,
      String? applicantId,
      RoomComplete? room}) {
    return BookingReturn(
        reason: reason ?? this.reason,
        start: start ?? this.start,
        end: end ?? this.end,
        creation: creation ?? this.creation,
        note: note ?? this.note,
        roomId: roomId ?? this.roomId,
        key: key ?? this.key,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        entity: entity ?? this.entity,
        id: id ?? this.id,
        decision: decision ?? this.decision,
        applicantId: applicantId ?? this.applicantId,
        room: room ?? this.room);
  }

  BookingReturn copyWithWrapped(
      {Wrapped<String>? reason,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<DateTime>? creation,
      Wrapped<String?>? note,
      Wrapped<String>? roomId,
      Wrapped<bool>? key,
      Wrapped<String?>? recurrenceRule,
      Wrapped<String?>? entity,
      Wrapped<String>? id,
      Wrapped<enums.AppUtilsTypesBookingTypeDecision>? decision,
      Wrapped<String>? applicantId,
      Wrapped<RoomComplete>? room}) {
    return BookingReturn(
        reason: (reason != null ? reason.value : this.reason),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        creation: (creation != null ? creation.value : this.creation),
        note: (note != null ? note.value : this.note),
        roomId: (roomId != null ? roomId.value : this.roomId),
        key: (key != null ? key.value : this.key),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule),
        entity: (entity != null ? entity.value : this.entity),
        id: (id != null ? id.value : this.id),
        decision: (decision != null ? decision.value : this.decision),
        applicantId:
            (applicantId != null ? applicantId.value : this.applicantId),
        room: (room != null ? room.value : this.room));
  }
}

@JsonSerializable(explicitToJson: true)
class BookingReturnApplicant {
  const BookingReturnApplicant({
    required this.reason,
    required this.start,
    required this.end,
    required this.creation,
    this.note,
    required this.roomId,
    required this.key,
    this.recurrenceRule,
    this.entity,
    required this.id,
    required this.decision,
    required this.applicantId,
    required this.room,
    required this.applicant,
  });

  factory BookingReturnApplicant.fromJson(Map<String, dynamic> json) =>
      _$BookingReturnApplicantFromJson(json);

  static const toJsonFactory = _$BookingReturnApplicantToJson;
  Map<String, dynamic> toJson() => _$BookingReturnApplicantToJson(this);

  @JsonKey(name: 'reason', defaultValue: '')
  final String reason;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(name: 'note', defaultValue: '')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  @JsonKey(name: 'entity', defaultValue: '')
  final String? entity;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'decision',
    toJson: appUtilsTypesBookingTypeDecisionToJson,
    fromJson: appUtilsTypesBookingTypeDecisionFromJson,
  )
  final enums.AppUtilsTypesBookingTypeDecision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'room')
  final RoomComplete room;
  @JsonKey(name: 'applicant')
  final Applicant applicant;
  static const fromJsonFactory = _$BookingReturnApplicantFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BookingReturnApplicant &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality()
                    .equals(other.creation, creation)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality()
                    .equals(other.decision, decision)) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality()
                    .equals(other.applicantId, applicantId)) &&
            (identical(other.room, room) ||
                const DeepCollectionEquality().equals(other.room, room)) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality()
                    .equals(other.applicant, applicant)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(reason) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      const DeepCollectionEquality().hash(entity) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(decision) ^
      const DeepCollectionEquality().hash(applicantId) ^
      const DeepCollectionEquality().hash(room) ^
      const DeepCollectionEquality().hash(applicant) ^
      runtimeType.hashCode;
}

extension $BookingReturnApplicantExtension on BookingReturnApplicant {
  BookingReturnApplicant copyWith(
      {String? reason,
      DateTime? start,
      DateTime? end,
      DateTime? creation,
      String? note,
      String? roomId,
      bool? key,
      String? recurrenceRule,
      String? entity,
      String? id,
      enums.AppUtilsTypesBookingTypeDecision? decision,
      String? applicantId,
      RoomComplete? room,
      Applicant? applicant}) {
    return BookingReturnApplicant(
        reason: reason ?? this.reason,
        start: start ?? this.start,
        end: end ?? this.end,
        creation: creation ?? this.creation,
        note: note ?? this.note,
        roomId: roomId ?? this.roomId,
        key: key ?? this.key,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        entity: entity ?? this.entity,
        id: id ?? this.id,
        decision: decision ?? this.decision,
        applicantId: applicantId ?? this.applicantId,
        room: room ?? this.room,
        applicant: applicant ?? this.applicant);
  }

  BookingReturnApplicant copyWithWrapped(
      {Wrapped<String>? reason,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<DateTime>? creation,
      Wrapped<String?>? note,
      Wrapped<String>? roomId,
      Wrapped<bool>? key,
      Wrapped<String?>? recurrenceRule,
      Wrapped<String?>? entity,
      Wrapped<String>? id,
      Wrapped<enums.AppUtilsTypesBookingTypeDecision>? decision,
      Wrapped<String>? applicantId,
      Wrapped<RoomComplete>? room,
      Wrapped<Applicant>? applicant}) {
    return BookingReturnApplicant(
        reason: (reason != null ? reason.value : this.reason),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        creation: (creation != null ? creation.value : this.creation),
        note: (note != null ? note.value : this.note),
        roomId: (roomId != null ? roomId.value : this.roomId),
        key: (key != null ? key.value : this.key),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule),
        entity: (entity != null ? entity.value : this.entity),
        id: (id != null ? id.value : this.id),
        decision: (decision != null ? decision.value : this.decision),
        applicantId:
            (applicantId != null ? applicantId.value : this.applicantId),
        room: (room != null ? room.value : this.room),
        applicant: (applicant != null ? applicant.value : this.applicant));
  }
}

@JsonSerializable(explicitToJson: true)
class BookingReturnSimpleApplicant {
  const BookingReturnSimpleApplicant({
    required this.reason,
    required this.start,
    required this.end,
    required this.creation,
    this.note,
    required this.roomId,
    required this.key,
    this.recurrenceRule,
    this.entity,
    required this.id,
    required this.decision,
    required this.applicantId,
    required this.room,
    required this.applicant,
  });

  factory BookingReturnSimpleApplicant.fromJson(Map<String, dynamic> json) =>
      _$BookingReturnSimpleApplicantFromJson(json);

  static const toJsonFactory = _$BookingReturnSimpleApplicantToJson;
  Map<String, dynamic> toJson() => _$BookingReturnSimpleApplicantToJson(this);

  @JsonKey(name: 'reason', defaultValue: '')
  final String reason;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(name: 'note', defaultValue: '')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  @JsonKey(name: 'entity', defaultValue: '')
  final String? entity;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'decision',
    toJson: appUtilsTypesBookingTypeDecisionToJson,
    fromJson: appUtilsTypesBookingTypeDecisionFromJson,
  )
  final enums.AppUtilsTypesBookingTypeDecision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'room')
  final RoomComplete room;
  @JsonKey(name: 'applicant')
  final CoreUserSimple applicant;
  static const fromJsonFactory = _$BookingReturnSimpleApplicantFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BookingReturnSimpleApplicant &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality()
                    .equals(other.creation, creation)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality()
                    .equals(other.decision, decision)) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality()
                    .equals(other.applicantId, applicantId)) &&
            (identical(other.room, room) ||
                const DeepCollectionEquality().equals(other.room, room)) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality()
                    .equals(other.applicant, applicant)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(reason) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      const DeepCollectionEquality().hash(entity) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(decision) ^
      const DeepCollectionEquality().hash(applicantId) ^
      const DeepCollectionEquality().hash(room) ^
      const DeepCollectionEquality().hash(applicant) ^
      runtimeType.hashCode;
}

extension $BookingReturnSimpleApplicantExtension
    on BookingReturnSimpleApplicant {
  BookingReturnSimpleApplicant copyWith(
      {String? reason,
      DateTime? start,
      DateTime? end,
      DateTime? creation,
      String? note,
      String? roomId,
      bool? key,
      String? recurrenceRule,
      String? entity,
      String? id,
      enums.AppUtilsTypesBookingTypeDecision? decision,
      String? applicantId,
      RoomComplete? room,
      CoreUserSimple? applicant}) {
    return BookingReturnSimpleApplicant(
        reason: reason ?? this.reason,
        start: start ?? this.start,
        end: end ?? this.end,
        creation: creation ?? this.creation,
        note: note ?? this.note,
        roomId: roomId ?? this.roomId,
        key: key ?? this.key,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        entity: entity ?? this.entity,
        id: id ?? this.id,
        decision: decision ?? this.decision,
        applicantId: applicantId ?? this.applicantId,
        room: room ?? this.room,
        applicant: applicant ?? this.applicant);
  }

  BookingReturnSimpleApplicant copyWithWrapped(
      {Wrapped<String>? reason,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<DateTime>? creation,
      Wrapped<String?>? note,
      Wrapped<String>? roomId,
      Wrapped<bool>? key,
      Wrapped<String?>? recurrenceRule,
      Wrapped<String?>? entity,
      Wrapped<String>? id,
      Wrapped<enums.AppUtilsTypesBookingTypeDecision>? decision,
      Wrapped<String>? applicantId,
      Wrapped<RoomComplete>? room,
      Wrapped<CoreUserSimple>? applicant}) {
    return BookingReturnSimpleApplicant(
        reason: (reason != null ? reason.value : this.reason),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        creation: (creation != null ? creation.value : this.creation),
        note: (note != null ? note.value : this.note),
        roomId: (roomId != null ? roomId.value : this.roomId),
        key: (key != null ? key.value : this.key),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule),
        entity: (entity != null ? entity.value : this.entity),
        id: (id != null ? id.value : this.id),
        decision: (decision != null ? decision.value : this.decision),
        applicantId:
            (applicantId != null ? applicantId.value : this.applicantId),
        room: (room != null ? room.value : this.room),
        applicant: (applicant != null ? applicant.value : this.applicant));
  }
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordRequest {
  const ChangePasswordRequest({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  static const toJsonFactory = _$ChangePasswordRequestToJson;
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'old_password', defaultValue: '')
  final String oldPassword;
  @JsonKey(name: 'new_password', defaultValue: '')
  final String newPassword;
  static const fromJsonFactory = _$ChangePasswordRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ChangePasswordRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.oldPassword, oldPassword) ||
                const DeepCollectionEquality()
                    .equals(other.oldPassword, oldPassword)) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality()
                    .equals(other.newPassword, newPassword)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(oldPassword) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $ChangePasswordRequestExtension on ChangePasswordRequest {
  ChangePasswordRequest copyWith(
      {String? email, String? oldPassword, String? newPassword}) {
    return ChangePasswordRequest(
        email: email ?? this.email,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword);
  }

  ChangePasswordRequest copyWithWrapped(
      {Wrapped<String>? email,
      Wrapped<String>? oldPassword,
      Wrapped<String>? newPassword}) {
    return ChangePasswordRequest(
        email: (email != null ? email.value : this.email),
        oldPassword:
            (oldPassword != null ? oldPassword.value : this.oldPassword),
        newPassword:
            (newPassword != null ? newPassword.value : this.newPassword));
  }
}

@JsonSerializable(explicitToJson: true)
class CineSessionBase {
  const CineSessionBase({
    required this.start,
    required this.duration,
    required this.name,
    this.overview,
    this.genre,
    this.tagline,
  });

  factory CineSessionBase.fromJson(Map<String, dynamic> json) =>
      _$CineSessionBaseFromJson(json);

  static const toJsonFactory = _$CineSessionBaseToJson;
  Map<String, dynamic> toJson() => _$CineSessionBaseToJson(this);

  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'duration', defaultValue: 0)
  final int duration;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'overview', defaultValue: '')
  final String? overview;
  @JsonKey(name: 'genre', defaultValue: '')
  final String? genre;
  @JsonKey(name: 'tagline', defaultValue: '')
  final String? tagline;
  static const fromJsonFactory = _$CineSessionBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CineSessionBase &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality()
                    .equals(other.overview, overview)) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality().equals(other.tagline, tagline)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(tagline) ^
      runtimeType.hashCode;
}

extension $CineSessionBaseExtension on CineSessionBase {
  CineSessionBase copyWith(
      {DateTime? start,
      int? duration,
      String? name,
      String? overview,
      String? genre,
      String? tagline}) {
    return CineSessionBase(
        start: start ?? this.start,
        duration: duration ?? this.duration,
        name: name ?? this.name,
        overview: overview ?? this.overview,
        genre: genre ?? this.genre,
        tagline: tagline ?? this.tagline);
  }

  CineSessionBase copyWithWrapped(
      {Wrapped<DateTime>? start,
      Wrapped<int>? duration,
      Wrapped<String>? name,
      Wrapped<String?>? overview,
      Wrapped<String?>? genre,
      Wrapped<String?>? tagline}) {
    return CineSessionBase(
        start: (start != null ? start.value : this.start),
        duration: (duration != null ? duration.value : this.duration),
        name: (name != null ? name.value : this.name),
        overview: (overview != null ? overview.value : this.overview),
        genre: (genre != null ? genre.value : this.genre),
        tagline: (tagline != null ? tagline.value : this.tagline));
  }
}

@JsonSerializable(explicitToJson: true)
class CineSessionComplete {
  const CineSessionComplete({
    required this.start,
    required this.duration,
    required this.name,
    this.overview,
    this.genre,
    this.tagline,
    required this.id,
  });

  factory CineSessionComplete.fromJson(Map<String, dynamic> json) =>
      _$CineSessionCompleteFromJson(json);

  static const toJsonFactory = _$CineSessionCompleteToJson;
  Map<String, dynamic> toJson() => _$CineSessionCompleteToJson(this);

  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'duration', defaultValue: 0)
  final int duration;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'overview', defaultValue: '')
  final String? overview;
  @JsonKey(name: 'genre', defaultValue: '')
  final String? genre;
  @JsonKey(name: 'tagline', defaultValue: '')
  final String? tagline;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$CineSessionCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CineSessionComplete &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality()
                    .equals(other.overview, overview)) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality()
                    .equals(other.tagline, tagline)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(tagline) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $CineSessionCompleteExtension on CineSessionComplete {
  CineSessionComplete copyWith(
      {DateTime? start,
      int? duration,
      String? name,
      String? overview,
      String? genre,
      String? tagline,
      String? id}) {
    return CineSessionComplete(
        start: start ?? this.start,
        duration: duration ?? this.duration,
        name: name ?? this.name,
        overview: overview ?? this.overview,
        genre: genre ?? this.genre,
        tagline: tagline ?? this.tagline,
        id: id ?? this.id);
  }

  CineSessionComplete copyWithWrapped(
      {Wrapped<DateTime>? start,
      Wrapped<int>? duration,
      Wrapped<String>? name,
      Wrapped<String?>? overview,
      Wrapped<String?>? genre,
      Wrapped<String?>? tagline,
      Wrapped<String>? id}) {
    return CineSessionComplete(
        start: (start != null ? start.value : this.start),
        duration: (duration != null ? duration.value : this.duration),
        name: (name != null ? name.value : this.name),
        overview: (overview != null ? overview.value : this.overview),
        genre: (genre != null ? genre.value : this.genre),
        tagline: (tagline != null ? tagline.value : this.tagline),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class CineSessionUpdate {
  const CineSessionUpdate({
    this.name,
    this.start,
    this.duration,
    this.overview,
    this.genre,
    this.tagline,
  });

  factory CineSessionUpdate.fromJson(Map<String, dynamic> json) =>
      _$CineSessionUpdateFromJson(json);

  static const toJsonFactory = _$CineSessionUpdateToJson;
  Map<String, dynamic> toJson() => _$CineSessionUpdateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'start')
  final DateTime? start;
  @JsonKey(name: 'duration', defaultValue: 0)
  final int? duration;
  @JsonKey(name: 'overview', defaultValue: '')
  final String? overview;
  @JsonKey(name: 'genre', defaultValue: '')
  final String? genre;
  @JsonKey(name: 'tagline', defaultValue: '')
  final String? tagline;
  static const fromJsonFactory = _$CineSessionUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CineSessionUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality()
                    .equals(other.overview, overview)) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality().equals(other.tagline, tagline)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(tagline) ^
      runtimeType.hashCode;
}

extension $CineSessionUpdateExtension on CineSessionUpdate {
  CineSessionUpdate copyWith(
      {String? name,
      DateTime? start,
      int? duration,
      String? overview,
      String? genre,
      String? tagline}) {
    return CineSessionUpdate(
        name: name ?? this.name,
        start: start ?? this.start,
        duration: duration ?? this.duration,
        overview: overview ?? this.overview,
        genre: genre ?? this.genre,
        tagline: tagline ?? this.tagline);
  }

  CineSessionUpdate copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<DateTime?>? start,
      Wrapped<int?>? duration,
      Wrapped<String?>? overview,
      Wrapped<String?>? genre,
      Wrapped<String?>? tagline}) {
    return CineSessionUpdate(
        name: (name != null ? name.value : this.name),
        start: (start != null ? start.value : this.start),
        duration: (duration != null ? duration.value : this.duration),
        overview: (overview != null ? overview.value : this.overview),
        genre: (genre != null ? genre.value : this.genre),
        tagline: (tagline != null ? tagline.value : this.tagline));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreBatchDeleteMembership {
  const CoreBatchDeleteMembership({
    required this.groupId,
  });

  factory CoreBatchDeleteMembership.fromJson(Map<String, dynamic> json) =>
      _$CoreBatchDeleteMembershipFromJson(json);

  static const toJsonFactory = _$CoreBatchDeleteMembershipToJson;
  Map<String, dynamic> toJson() => _$CoreBatchDeleteMembershipToJson(this);

  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$CoreBatchDeleteMembershipFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreBatchDeleteMembership &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(groupId) ^ runtimeType.hashCode;
}

extension $CoreBatchDeleteMembershipExtension on CoreBatchDeleteMembership {
  CoreBatchDeleteMembership copyWith({String? groupId}) {
    return CoreBatchDeleteMembership(groupId: groupId ?? this.groupId);
  }

  CoreBatchDeleteMembership copyWithWrapped({Wrapped<String>? groupId}) {
    return CoreBatchDeleteMembership(
        groupId: (groupId != null ? groupId.value : this.groupId));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreBatchMembership {
  const CoreBatchMembership({
    required this.userEmails,
    required this.groupId,
    this.description,
  });

  factory CoreBatchMembership.fromJson(Map<String, dynamic> json) =>
      _$CoreBatchMembershipFromJson(json);

  static const toJsonFactory = _$CoreBatchMembershipToJson;
  Map<String, dynamic> toJson() => _$CoreBatchMembershipToJson(this);

  @JsonKey(name: 'user_emails', defaultValue: <String>[])
  final List<String> userEmails;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  static const fromJsonFactory = _$CoreBatchMembershipFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreBatchMembership &&
            (identical(other.userEmails, userEmails) ||
                const DeepCollectionEquality()
                    .equals(other.userEmails, userEmails)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality()
                    .equals(other.groupId, groupId)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userEmails) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $CoreBatchMembershipExtension on CoreBatchMembership {
  CoreBatchMembership copyWith(
      {List<String>? userEmails, String? groupId, String? description}) {
    return CoreBatchMembership(
        userEmails: userEmails ?? this.userEmails,
        groupId: groupId ?? this.groupId,
        description: description ?? this.description);
  }

  CoreBatchMembership copyWithWrapped(
      {Wrapped<List<String>>? userEmails,
      Wrapped<String>? groupId,
      Wrapped<String?>? description}) {
    return CoreBatchMembership(
        userEmails: (userEmails != null ? userEmails.value : this.userEmails),
        groupId: (groupId != null ? groupId.value : this.groupId),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreBatchUserCreateRequest {
  const CoreBatchUserCreateRequest({
    required this.email,
    required this.accountType,
  });

  factory CoreBatchUserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CoreBatchUserCreateRequestFromJson(json);

  static const toJsonFactory = _$CoreBatchUserCreateRequestToJson;
  Map<String, dynamic> toJson() => _$CoreBatchUserCreateRequestToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  static const fromJsonFactory = _$CoreBatchUserCreateRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreBatchUserCreateRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality()
                    .equals(other.accountType, accountType)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(accountType) ^
      runtimeType.hashCode;
}

extension $CoreBatchUserCreateRequestExtension on CoreBatchUserCreateRequest {
  CoreBatchUserCreateRequest copyWith(
      {String? email, enums.AccountType? accountType}) {
    return CoreBatchUserCreateRequest(
        email: email ?? this.email,
        accountType: accountType ?? this.accountType);
  }

  CoreBatchUserCreateRequest copyWithWrapped(
      {Wrapped<String>? email, Wrapped<enums.AccountType>? accountType}) {
    return CoreBatchUserCreateRequest(
        email: (email != null ? email.value : this.email),
        accountType:
            (accountType != null ? accountType.value : this.accountType));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreGroup {
  const CoreGroup({
    required this.name,
    this.description,
    required this.id,
    this.members,
  });

  factory CoreGroup.fromJson(Map<String, dynamic> json) =>
      _$CoreGroupFromJson(json);

  static const toJsonFactory = _$CoreGroupToJson;
  Map<String, dynamic> toJson() => _$CoreGroupToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'members', defaultValue: <CoreUserSimple>[])
  final List<CoreUserSimple>? members;
  static const fromJsonFactory = _$CoreGroupFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreGroup &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality().equals(other.members, members)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(members) ^
      runtimeType.hashCode;
}

extension $CoreGroupExtension on CoreGroup {
  CoreGroup copyWith(
      {String? name,
      String? description,
      String? id,
      List<CoreUserSimple>? members}) {
    return CoreGroup(
        name: name ?? this.name,
        description: description ?? this.description,
        id: id ?? this.id,
        members: members ?? this.members);
  }

  CoreGroup copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String?>? description,
      Wrapped<String>? id,
      Wrapped<List<CoreUserSimple>?>? members}) {
    return CoreGroup(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id),
        members: (members != null ? members.value : this.members));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreGroupCreate {
  const CoreGroupCreate({
    required this.name,
    this.description,
  });

  factory CoreGroupCreate.fromJson(Map<String, dynamic> json) =>
      _$CoreGroupCreateFromJson(json);

  static const toJsonFactory = _$CoreGroupCreateToJson;
  Map<String, dynamic> toJson() => _$CoreGroupCreateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  static const fromJsonFactory = _$CoreGroupCreateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreGroupCreate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $CoreGroupCreateExtension on CoreGroupCreate {
  CoreGroupCreate copyWith({String? name, String? description}) {
    return CoreGroupCreate(
        name: name ?? this.name, description: description ?? this.description);
  }

  CoreGroupCreate copyWithWrapped(
      {Wrapped<String>? name, Wrapped<String?>? description}) {
    return CoreGroupCreate(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreGroupSimple {
  const CoreGroupSimple({
    required this.name,
    this.description,
    required this.id,
  });

  factory CoreGroupSimple.fromJson(Map<String, dynamic> json) =>
      _$CoreGroupSimpleFromJson(json);

  static const toJsonFactory = _$CoreGroupSimpleToJson;
  Map<String, dynamic> toJson() => _$CoreGroupSimpleToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$CoreGroupSimpleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreGroupSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $CoreGroupSimpleExtension on CoreGroupSimple {
  CoreGroupSimple copyWith({String? name, String? description, String? id}) {
    return CoreGroupSimple(
        name: name ?? this.name,
        description: description ?? this.description,
        id: id ?? this.id);
  }

  CoreGroupSimple copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String?>? description,
      Wrapped<String>? id}) {
    return CoreGroupSimple(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreGroupUpdate {
  const CoreGroupUpdate({
    this.name,
    this.description,
  });

  factory CoreGroupUpdate.fromJson(Map<String, dynamic> json) =>
      _$CoreGroupUpdateFromJson(json);

  static const toJsonFactory = _$CoreGroupUpdateToJson;
  Map<String, dynamic> toJson() => _$CoreGroupUpdateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  static const fromJsonFactory = _$CoreGroupUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreGroupUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $CoreGroupUpdateExtension on CoreGroupUpdate {
  CoreGroupUpdate copyWith({String? name, String? description}) {
    return CoreGroupUpdate(
        name: name ?? this.name, description: description ?? this.description);
  }

  CoreGroupUpdate copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<String?>? description}) {
    return CoreGroupUpdate(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreInformation {
  const CoreInformation({
    required this.ready,
    required this.version,
    required this.minimalTitanVersionCode,
    required this.minimalTitanVersion,
  });

  factory CoreInformation.fromJson(Map<String, dynamic> json) =>
      _$CoreInformationFromJson(json);

  static const toJsonFactory = _$CoreInformationToJson;
  Map<String, dynamic> toJson() => _$CoreInformationToJson(this);

  @JsonKey(name: 'ready', defaultValue: false)
  final bool ready;
  @JsonKey(name: 'version', defaultValue: '')
  final String version;
  @JsonKey(name: 'minimal_titan_version_code', defaultValue: 0)
  final int minimalTitanVersionCode;
  @JsonKey(name: 'minimal_titan_version', defaultValue: '')
  final String minimalTitanVersion;
  static const fromJsonFactory = _$CoreInformationFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreInformation &&
            (identical(other.ready, ready) ||
                const DeepCollectionEquality().equals(other.ready, ready)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(
                    other.minimalTitanVersionCode, minimalTitanVersionCode) ||
                const DeepCollectionEquality().equals(
                    other.minimalTitanVersionCode, minimalTitanVersionCode)) &&
            (identical(other.minimalTitanVersion, minimalTitanVersion) ||
                const DeepCollectionEquality()
                    .equals(other.minimalTitanVersion, minimalTitanVersion)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ready) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(minimalTitanVersionCode) ^
      const DeepCollectionEquality().hash(minimalTitanVersion) ^
      runtimeType.hashCode;
}

extension $CoreInformationExtension on CoreInformation {
  CoreInformation copyWith(
      {bool? ready,
      String? version,
      int? minimalTitanVersionCode,
      String? minimalTitanVersion}) {
    return CoreInformation(
        ready: ready ?? this.ready,
        version: version ?? this.version,
        minimalTitanVersionCode:
            minimalTitanVersionCode ?? this.minimalTitanVersionCode,
        minimalTitanVersion: minimalTitanVersion ?? this.minimalTitanVersion);
  }

  CoreInformation copyWithWrapped(
      {Wrapped<bool>? ready,
      Wrapped<String>? version,
      Wrapped<int>? minimalTitanVersionCode,
      Wrapped<String>? minimalTitanVersion}) {
    return CoreInformation(
        ready: (ready != null ? ready.value : this.ready),
        version: (version != null ? version.value : this.version),
        minimalTitanVersionCode: (minimalTitanVersionCode != null
            ? minimalTitanVersionCode.value
            : this.minimalTitanVersionCode),
        minimalTitanVersion: (minimalTitanVersion != null
            ? minimalTitanVersion.value
            : this.minimalTitanVersion));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreMembership {
  const CoreMembership({
    required this.userId,
    required this.groupId,
    this.description,
  });

  factory CoreMembership.fromJson(Map<String, dynamic> json) =>
      _$CoreMembershipFromJson(json);

  static const toJsonFactory = _$CoreMembershipToJson;
  Map<String, dynamic> toJson() => _$CoreMembershipToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  static const fromJsonFactory = _$CoreMembershipFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreMembership &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality()
                    .equals(other.groupId, groupId)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $CoreMembershipExtension on CoreMembership {
  CoreMembership copyWith(
      {String? userId, String? groupId, String? description}) {
    return CoreMembership(
        userId: userId ?? this.userId,
        groupId: groupId ?? this.groupId,
        description: description ?? this.description);
  }

  CoreMembership copyWithWrapped(
      {Wrapped<String>? userId,
      Wrapped<String>? groupId,
      Wrapped<String?>? description}) {
    return CoreMembership(
        userId: (userId != null ? userId.value : this.userId),
        groupId: (groupId != null ? groupId.value : this.groupId),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreMembershipDelete {
  const CoreMembershipDelete({
    required this.userId,
    required this.groupId,
  });

  factory CoreMembershipDelete.fromJson(Map<String, dynamic> json) =>
      _$CoreMembershipDeleteFromJson(json);

  static const toJsonFactory = _$CoreMembershipDeleteToJson;
  Map<String, dynamic> toJson() => _$CoreMembershipDeleteToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$CoreMembershipDeleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreMembershipDelete &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(groupId) ^
      runtimeType.hashCode;
}

extension $CoreMembershipDeleteExtension on CoreMembershipDelete {
  CoreMembershipDelete copyWith({String? userId, String? groupId}) {
    return CoreMembershipDelete(
        userId: userId ?? this.userId, groupId: groupId ?? this.groupId);
  }

  CoreMembershipDelete copyWithWrapped(
      {Wrapped<String>? userId, Wrapped<String>? groupId}) {
    return CoreMembershipDelete(
        userId: (userId != null ? userId.value : this.userId),
        groupId: (groupId != null ? groupId.value : this.groupId));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUser {
  const CoreUser({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.email,
    this.birthday,
    this.promo,
    required this.floor,
    this.phone,
    this.createdOn,
    this.groups,
  });

  factory CoreUser.fromJson(Map<String, dynamic> json) =>
      _$CoreUserFromJson(json);

  static const toJsonFactory = _$CoreUserToJson;
  Map<String, dynamic> toJson() => _$CoreUserToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'birthday', toJson: _dateToJson)
  final DateTime? birthday;
  @JsonKey(name: 'promo', defaultValue: 0)
  final int? promo;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeToJson,
    fromJson: floorsTypeFromJson,
  )
  final enums.FloorsType floor;
  @JsonKey(name: 'phone', defaultValue: '')
  final String? phone;
  @JsonKey(name: 'created_on')
  final DateTime? createdOn;
  @JsonKey(name: 'groups', defaultValue: <CoreGroupSimple>[])
  final List<CoreGroupSimple>? groups;
  static const fromJsonFactory = _$CoreUserFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreUser &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality()
                    .equals(other.birthday, birthday)) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.createdOn, createdOn) ||
                const DeepCollectionEquality()
                    .equals(other.createdOn, createdOn)) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(floor) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(createdOn) ^
      const DeepCollectionEquality().hash(groups) ^
      runtimeType.hashCode;
}

extension $CoreUserExtension on CoreUser {
  CoreUser copyWith(
      {String? name,
      String? firstname,
      String? nickname,
      String? id,
      String? email,
      DateTime? birthday,
      int? promo,
      enums.FloorsType? floor,
      String? phone,
      DateTime? createdOn,
      List<CoreGroupSimple>? groups}) {
    return CoreUser(
        name: name ?? this.name,
        firstname: firstname ?? this.firstname,
        nickname: nickname ?? this.nickname,
        id: id ?? this.id,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        promo: promo ?? this.promo,
        floor: floor ?? this.floor,
        phone: phone ?? this.phone,
        createdOn: createdOn ?? this.createdOn,
        groups: groups ?? this.groups);
  }

  CoreUser copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? firstname,
      Wrapped<String?>? nickname,
      Wrapped<String>? id,
      Wrapped<String>? email,
      Wrapped<DateTime?>? birthday,
      Wrapped<int?>? promo,
      Wrapped<enums.FloorsType>? floor,
      Wrapped<String?>? phone,
      Wrapped<DateTime?>? createdOn,
      Wrapped<List<CoreGroupSimple>?>? groups}) {
    return CoreUser(
        name: (name != null ? name.value : this.name),
        firstname: (firstname != null ? firstname.value : this.firstname),
        nickname: (nickname != null ? nickname.value : this.nickname),
        id: (id != null ? id.value : this.id),
        email: (email != null ? email.value : this.email),
        birthday: (birthday != null ? birthday.value : this.birthday),
        promo: (promo != null ? promo.value : this.promo),
        floor: (floor != null ? floor.value : this.floor),
        phone: (phone != null ? phone.value : this.phone),
        createdOn: (createdOn != null ? createdOn.value : this.createdOn),
        groups: (groups != null ? groups.value : this.groups));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserActivateRequest {
  const CoreUserActivateRequest({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.activationToken,
    required this.password,
    this.birthday,
    this.phone,
    required this.floor,
    this.promo,
  });

  factory CoreUserActivateRequest.fromJson(Map<String, dynamic> json) =>
      _$CoreUserActivateRequestFromJson(json);

  static const toJsonFactory = _$CoreUserActivateRequestToJson;
  Map<String, dynamic> toJson() => _$CoreUserActivateRequestToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;
  @JsonKey(name: 'activation_token', defaultValue: '')
  final String activationToken;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  @JsonKey(name: 'birthday', toJson: _dateToJson)
  final DateTime? birthday;
  @JsonKey(name: 'phone', defaultValue: '')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeToJson,
    fromJson: floorsTypeFromJson,
  )
  final enums.FloorsType floor;
  @JsonKey(name: 'promo', defaultValue: 0)
  final int? promo;
  static const fromJsonFactory = _$CoreUserActivateRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreUserActivateRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.activationToken, activationToken) ||
                const DeepCollectionEquality()
                    .equals(other.activationToken, activationToken)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality()
                    .equals(other.birthday, birthday)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(activationToken) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(floor) ^
      const DeepCollectionEquality().hash(promo) ^
      runtimeType.hashCode;
}

extension $CoreUserActivateRequestExtension on CoreUserActivateRequest {
  CoreUserActivateRequest copyWith(
      {String? name,
      String? firstname,
      String? nickname,
      String? activationToken,
      String? password,
      DateTime? birthday,
      String? phone,
      enums.FloorsType? floor,
      int? promo}) {
    return CoreUserActivateRequest(
        name: name ?? this.name,
        firstname: firstname ?? this.firstname,
        nickname: nickname ?? this.nickname,
        activationToken: activationToken ?? this.activationToken,
        password: password ?? this.password,
        birthday: birthday ?? this.birthday,
        phone: phone ?? this.phone,
        floor: floor ?? this.floor,
        promo: promo ?? this.promo);
  }

  CoreUserActivateRequest copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? firstname,
      Wrapped<String?>? nickname,
      Wrapped<String>? activationToken,
      Wrapped<String>? password,
      Wrapped<DateTime?>? birthday,
      Wrapped<String?>? phone,
      Wrapped<enums.FloorsType>? floor,
      Wrapped<int?>? promo}) {
    return CoreUserActivateRequest(
        name: (name != null ? name.value : this.name),
        firstname: (firstname != null ? firstname.value : this.firstname),
        nickname: (nickname != null ? nickname.value : this.nickname),
        activationToken: (activationToken != null
            ? activationToken.value
            : this.activationToken),
        password: (password != null ? password.value : this.password),
        birthday: (birthday != null ? birthday.value : this.birthday),
        phone: (phone != null ? phone.value : this.phone),
        floor: (floor != null ? floor.value : this.floor),
        promo: (promo != null ? promo.value : this.promo));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserCreateRequest {
  const CoreUserCreateRequest({
    required this.email,
  });

  factory CoreUserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CoreUserCreateRequestFromJson(json);

  static const toJsonFactory = _$CoreUserCreateRequestToJson;
  Map<String, dynamic> toJson() => _$CoreUserCreateRequestToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  static const fromJsonFactory = _$CoreUserCreateRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreUserCreateRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $CoreUserCreateRequestExtension on CoreUserCreateRequest {
  CoreUserCreateRequest copyWith({String? email}) {
    return CoreUserCreateRequest(email: email ?? this.email);
  }

  CoreUserCreateRequest copyWithWrapped({Wrapped<String>? email}) {
    return CoreUserCreateRequest(
        email: (email != null ? email.value : this.email));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserSimple {
  const CoreUserSimple({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
  });

  factory CoreUserSimple.fromJson(Map<String, dynamic> json) =>
      _$CoreUserSimpleFromJson(json);

  static const toJsonFactory = _$CoreUserSimpleToJson;
  Map<String, dynamic> toJson() => _$CoreUserSimpleToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$CoreUserSimpleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreUserSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $CoreUserSimpleExtension on CoreUserSimple {
  CoreUserSimple copyWith(
      {String? name, String? firstname, String? nickname, String? id}) {
    return CoreUserSimple(
        name: name ?? this.name,
        firstname: firstname ?? this.firstname,
        nickname: nickname ?? this.nickname,
        id: id ?? this.id);
  }

  CoreUserSimple copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? firstname,
      Wrapped<String?>? nickname,
      Wrapped<String>? id}) {
    return CoreUserSimple(
        name: (name != null ? name.value : this.name),
        firstname: (firstname != null ? firstname.value : this.firstname),
        nickname: (nickname != null ? nickname.value : this.nickname),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserUpdate {
  const CoreUserUpdate({
    this.nickname,
    this.birthday,
    this.phone,
    this.floor,
  });

  factory CoreUserUpdate.fromJson(Map<String, dynamic> json) =>
      _$CoreUserUpdateFromJson(json);

  static const toJsonFactory = _$CoreUserUpdateToJson;
  Map<String, dynamic> toJson() => _$CoreUserUpdateToJson(this);

  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;
  @JsonKey(name: 'birthday', toJson: _dateToJson)
  final DateTime? birthday;
  @JsonKey(name: 'phone', defaultValue: '')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  static const fromJsonFactory = _$CoreUserUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreUserUpdate &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality()
                    .equals(other.birthday, birthday)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(floor) ^
      runtimeType.hashCode;
}

extension $CoreUserUpdateExtension on CoreUserUpdate {
  CoreUserUpdate copyWith(
      {String? nickname,
      DateTime? birthday,
      String? phone,
      enums.FloorsType? floor}) {
    return CoreUserUpdate(
        nickname: nickname ?? this.nickname,
        birthday: birthday ?? this.birthday,
        phone: phone ?? this.phone,
        floor: floor ?? this.floor);
  }

  CoreUserUpdate copyWithWrapped(
      {Wrapped<String?>? nickname,
      Wrapped<DateTime?>? birthday,
      Wrapped<String?>? phone,
      Wrapped<enums.FloorsType?>? floor}) {
    return CoreUserUpdate(
        nickname: (nickname != null ? nickname.value : this.nickname),
        birthday: (birthday != null ? birthday.value : this.birthday),
        phone: (phone != null ? phone.value : this.phone),
        floor: (floor != null ? floor.value : this.floor));
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserUpdateAdmin {
  const CoreUserUpdateAdmin({
    this.name,
    this.firstname,
    this.promo,
    this.nickname,
    this.birthday,
    this.phone,
    this.floor,
  });

  factory CoreUserUpdateAdmin.fromJson(Map<String, dynamic> json) =>
      _$CoreUserUpdateAdminFromJson(json);

  static const toJsonFactory = _$CoreUserUpdateAdminToJson;
  Map<String, dynamic> toJson() => _$CoreUserUpdateAdminToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String? firstname;
  @JsonKey(name: 'promo', defaultValue: 0)
  final int? promo;
  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;
  @JsonKey(name: 'birthday', toJson: _dateToJson)
  final DateTime? birthday;
  @JsonKey(name: 'phone', defaultValue: '')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  static const fromJsonFactory = _$CoreUserUpdateAdminFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CoreUserUpdateAdmin &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality()
                    .equals(other.birthday, birthday)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(floor) ^
      runtimeType.hashCode;
}

extension $CoreUserUpdateAdminExtension on CoreUserUpdateAdmin {
  CoreUserUpdateAdmin copyWith(
      {String? name,
      String? firstname,
      int? promo,
      String? nickname,
      DateTime? birthday,
      String? phone,
      enums.FloorsType? floor}) {
    return CoreUserUpdateAdmin(
        name: name ?? this.name,
        firstname: firstname ?? this.firstname,
        promo: promo ?? this.promo,
        nickname: nickname ?? this.nickname,
        birthday: birthday ?? this.birthday,
        phone: phone ?? this.phone,
        floor: floor ?? this.floor);
  }

  CoreUserUpdateAdmin copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? firstname,
      Wrapped<int?>? promo,
      Wrapped<String?>? nickname,
      Wrapped<DateTime?>? birthday,
      Wrapped<String?>? phone,
      Wrapped<enums.FloorsType?>? floor}) {
    return CoreUserUpdateAdmin(
        name: (name != null ? name.value : this.name),
        firstname: (firstname != null ? firstname.value : this.firstname),
        promo: (promo != null ? promo.value : this.promo),
        nickname: (nickname != null ? nickname.value : this.nickname),
        birthday: (birthday != null ? birthday.value : this.birthday),
        phone: (phone != null ? phone.value : this.phone),
        floor: (floor != null ? floor.value : this.floor));
  }
}

@JsonSerializable(explicitToJson: true)
class DeliveryBase {
  const DeliveryBase({
    required this.deliveryDate,
    this.productsIds,
  });

  factory DeliveryBase.fromJson(Map<String, dynamic> json) =>
      _$DeliveryBaseFromJson(json);

  static const toJsonFactory = _$DeliveryBaseToJson;
  Map<String, dynamic> toJson() => _$DeliveryBaseToJson(this);

  @JsonKey(name: 'delivery_date', toJson: _dateToJson)
  final DateTime deliveryDate;
  @JsonKey(name: 'products_ids', defaultValue: <String>[])
  final List<String>? productsIds;
  static const fromJsonFactory = _$DeliveryBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliveryBase &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryDate, deliveryDate)) &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality()
                    .equals(other.productsIds, productsIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(deliveryDate) ^
      const DeepCollectionEquality().hash(productsIds) ^
      runtimeType.hashCode;
}

extension $DeliveryBaseExtension on DeliveryBase {
  DeliveryBase copyWith({DateTime? deliveryDate, List<String>? productsIds}) {
    return DeliveryBase(
        deliveryDate: deliveryDate ?? this.deliveryDate,
        productsIds: productsIds ?? this.productsIds);
  }

  DeliveryBase copyWithWrapped(
      {Wrapped<DateTime>? deliveryDate, Wrapped<List<String>?>? productsIds}) {
    return DeliveryBase(
        deliveryDate:
            (deliveryDate != null ? deliveryDate.value : this.deliveryDate),
        productsIds:
            (productsIds != null ? productsIds.value : this.productsIds));
  }
}

@JsonSerializable(explicitToJson: true)
class DeliveryProductsUpdate {
  const DeliveryProductsUpdate({
    required this.productsIds,
  });

  factory DeliveryProductsUpdate.fromJson(Map<String, dynamic> json) =>
      _$DeliveryProductsUpdateFromJson(json);

  static const toJsonFactory = _$DeliveryProductsUpdateToJson;
  Map<String, dynamic> toJson() => _$DeliveryProductsUpdateToJson(this);

  @JsonKey(name: 'products_ids', defaultValue: <String>[])
  final List<String> productsIds;
  static const fromJsonFactory = _$DeliveryProductsUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliveryProductsUpdate &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality()
                    .equals(other.productsIds, productsIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productsIds) ^ runtimeType.hashCode;
}

extension $DeliveryProductsUpdateExtension on DeliveryProductsUpdate {
  DeliveryProductsUpdate copyWith({List<String>? productsIds}) {
    return DeliveryProductsUpdate(productsIds: productsIds ?? this.productsIds);
  }

  DeliveryProductsUpdate copyWithWrapped({Wrapped<List<String>>? productsIds}) {
    return DeliveryProductsUpdate(
        productsIds:
            (productsIds != null ? productsIds.value : this.productsIds));
  }
}

@JsonSerializable(explicitToJson: true)
class DeliveryReturn {
  const DeliveryReturn({
    required this.deliveryDate,
    this.products,
    required this.id,
    required this.status,
  });

  factory DeliveryReturn.fromJson(Map<String, dynamic> json) =>
      _$DeliveryReturnFromJson(json);

  static const toJsonFactory = _$DeliveryReturnToJson;
  Map<String, dynamic> toJson() => _$DeliveryReturnToJson(this);

  @JsonKey(name: 'delivery_date', toJson: _dateToJson)
  final DateTime deliveryDate;
  @JsonKey(name: 'products', defaultValue: <ProductComplete>[])
  final List<ProductComplete>? products;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'status',
    toJson: deliveryStatusTypeToJson,
    fromJson: deliveryStatusTypeFromJson,
  )
  final enums.DeliveryStatusType status;
  static const fromJsonFactory = _$DeliveryReturnFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliveryReturn &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryDate, deliveryDate)) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality()
                    .equals(other.products, products)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(deliveryDate) ^
      const DeepCollectionEquality().hash(products) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $DeliveryReturnExtension on DeliveryReturn {
  DeliveryReturn copyWith(
      {DateTime? deliveryDate,
      List<ProductComplete>? products,
      String? id,
      enums.DeliveryStatusType? status}) {
    return DeliveryReturn(
        deliveryDate: deliveryDate ?? this.deliveryDate,
        products: products ?? this.products,
        id: id ?? this.id,
        status: status ?? this.status);
  }

  DeliveryReturn copyWithWrapped(
      {Wrapped<DateTime>? deliveryDate,
      Wrapped<List<ProductComplete>?>? products,
      Wrapped<String>? id,
      Wrapped<enums.DeliveryStatusType>? status}) {
    return DeliveryReturn(
        deliveryDate:
            (deliveryDate != null ? deliveryDate.value : this.deliveryDate),
        products: (products != null ? products.value : this.products),
        id: (id != null ? id.value : this.id),
        status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class DeliveryUpdate {
  const DeliveryUpdate({
    this.deliveryDate,
  });

  factory DeliveryUpdate.fromJson(Map<String, dynamic> json) =>
      _$DeliveryUpdateFromJson(json);

  static const toJsonFactory = _$DeliveryUpdateToJson;
  Map<String, dynamic> toJson() => _$DeliveryUpdateToJson(this);

  @JsonKey(name: 'delivery_date', toJson: _dateToJson)
  final DateTime? deliveryDate;
  static const fromJsonFactory = _$DeliveryUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeliveryUpdate &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryDate, deliveryDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(deliveryDate) ^ runtimeType.hashCode;
}

extension $DeliveryUpdateExtension on DeliveryUpdate {
  DeliveryUpdate copyWith({DateTime? deliveryDate}) {
    return DeliveryUpdate(deliveryDate: deliveryDate ?? this.deliveryDate);
  }

  DeliveryUpdate copyWithWrapped({Wrapped<DateTime?>? deliveryDate}) {
    return DeliveryUpdate(
        deliveryDate:
            (deliveryDate != null ? deliveryDate.value : this.deliveryDate));
  }
}

@JsonSerializable(explicitToJson: true)
class EventApplicant {
  const EventApplicant({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.email,
    this.promo,
    this.phone,
  });

  factory EventApplicant.fromJson(Map<String, dynamic> json) =>
      _$EventApplicantFromJson(json);

  static const toJsonFactory = _$EventApplicantToJson;
  Map<String, dynamic> toJson() => _$EventApplicantToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname', defaultValue: '')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'promo', defaultValue: 0)
  final int? promo;
  @JsonKey(name: 'phone', defaultValue: '')
  final String? phone;
  static const fromJsonFactory = _$EventApplicantFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventApplicant &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality()
                    .equals(other.firstname, firstname)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality()
                    .equals(other.nickname, nickname)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(phone) ^
      runtimeType.hashCode;
}

extension $EventApplicantExtension on EventApplicant {
  EventApplicant copyWith(
      {String? name,
      String? firstname,
      String? nickname,
      String? id,
      String? email,
      int? promo,
      String? phone}) {
    return EventApplicant(
        name: name ?? this.name,
        firstname: firstname ?? this.firstname,
        nickname: nickname ?? this.nickname,
        id: id ?? this.id,
        email: email ?? this.email,
        promo: promo ?? this.promo,
        phone: phone ?? this.phone);
  }

  EventApplicant copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? firstname,
      Wrapped<String?>? nickname,
      Wrapped<String>? id,
      Wrapped<String>? email,
      Wrapped<int?>? promo,
      Wrapped<String?>? phone}) {
    return EventApplicant(
        name: (name != null ? name.value : this.name),
        firstname: (firstname != null ? firstname.value : this.firstname),
        nickname: (nickname != null ? nickname.value : this.nickname),
        id: (id != null ? id.value : this.id),
        email: (email != null ? email.value : this.email),
        promo: (promo != null ? promo.value : this.promo),
        phone: (phone != null ? phone.value : this.phone));
  }
}

@JsonSerializable(explicitToJson: true)
class EventBase {
  const EventBase({
    required this.name,
    required this.organizer,
    required this.start,
    required this.end,
    required this.allDay,
    required this.location,
    required this.type,
    required this.description,
    this.recurrenceRule,
  });

  factory EventBase.fromJson(Map<String, dynamic> json) =>
      _$EventBaseFromJson(json);

  static const toJsonFactory = _$EventBaseToJson;
  Map<String, dynamic> toJson() => _$EventBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'organizer', defaultValue: '')
  final String organizer;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'all_day', defaultValue: false)
  final bool allDay;
  @JsonKey(name: 'location', defaultValue: '')
  final String location;
  @JsonKey(
    name: 'type',
    toJson: calendarEventTypeToJson,
    fromJson: calendarEventTypeFromJson,
  )
  final enums.CalendarEventType type;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  static const fromJsonFactory = _$EventBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality()
                    .equals(other.organizer, organizer)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(organizer) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(allDay) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      runtimeType.hashCode;
}

extension $EventBaseExtension on EventBase {
  EventBase copyWith(
      {String? name,
      String? organizer,
      DateTime? start,
      DateTime? end,
      bool? allDay,
      String? location,
      enums.CalendarEventType? type,
      String? description,
      String? recurrenceRule}) {
    return EventBase(
        name: name ?? this.name,
        organizer: organizer ?? this.organizer,
        start: start ?? this.start,
        end: end ?? this.end,
        allDay: allDay ?? this.allDay,
        location: location ?? this.location,
        type: type ?? this.type,
        description: description ?? this.description,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule);
  }

  EventBase copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? organizer,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<bool>? allDay,
      Wrapped<String>? location,
      Wrapped<enums.CalendarEventType>? type,
      Wrapped<String>? description,
      Wrapped<String?>? recurrenceRule}) {
    return EventBase(
        name: (name != null ? name.value : this.name),
        organizer: (organizer != null ? organizer.value : this.organizer),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        allDay: (allDay != null ? allDay.value : this.allDay),
        location: (location != null ? location.value : this.location),
        type: (type != null ? type.value : this.type),
        description:
            (description != null ? description.value : this.description),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule));
  }
}

@JsonSerializable(explicitToJson: true)
class EventComplete {
  const EventComplete({
    required this.name,
    required this.organizer,
    required this.start,
    required this.end,
    required this.allDay,
    required this.location,
    required this.type,
    required this.description,
    this.recurrenceRule,
    required this.id,
    required this.decision,
    required this.applicantId,
  });

  factory EventComplete.fromJson(Map<String, dynamic> json) =>
      _$EventCompleteFromJson(json);

  static const toJsonFactory = _$EventCompleteToJson;
  Map<String, dynamic> toJson() => _$EventCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'organizer', defaultValue: '')
  final String organizer;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'all_day', defaultValue: false)
  final bool allDay;
  @JsonKey(name: 'location', defaultValue: '')
  final String location;
  @JsonKey(
    name: 'type',
    toJson: calendarEventTypeToJson,
    fromJson: calendarEventTypeFromJson,
  )
  final enums.CalendarEventType type;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'decision',
    toJson: appUtilsTypesCalendarTypesDecisionToJson,
    fromJson: appUtilsTypesCalendarTypesDecisionFromJson,
  )
  final enums.AppUtilsTypesCalendarTypesDecision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  static const fromJsonFactory = _$EventCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality()
                    .equals(other.organizer, organizer)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality()
                    .equals(other.decision, decision)) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality()
                    .equals(other.applicantId, applicantId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(organizer) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(allDay) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(decision) ^
      const DeepCollectionEquality().hash(applicantId) ^
      runtimeType.hashCode;
}

extension $EventCompleteExtension on EventComplete {
  EventComplete copyWith(
      {String? name,
      String? organizer,
      DateTime? start,
      DateTime? end,
      bool? allDay,
      String? location,
      enums.CalendarEventType? type,
      String? description,
      String? recurrenceRule,
      String? id,
      enums.AppUtilsTypesCalendarTypesDecision? decision,
      String? applicantId}) {
    return EventComplete(
        name: name ?? this.name,
        organizer: organizer ?? this.organizer,
        start: start ?? this.start,
        end: end ?? this.end,
        allDay: allDay ?? this.allDay,
        location: location ?? this.location,
        type: type ?? this.type,
        description: description ?? this.description,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        id: id ?? this.id,
        decision: decision ?? this.decision,
        applicantId: applicantId ?? this.applicantId);
  }

  EventComplete copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? organizer,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<bool>? allDay,
      Wrapped<String>? location,
      Wrapped<enums.CalendarEventType>? type,
      Wrapped<String>? description,
      Wrapped<String?>? recurrenceRule,
      Wrapped<String>? id,
      Wrapped<enums.AppUtilsTypesCalendarTypesDecision>? decision,
      Wrapped<String>? applicantId}) {
    return EventComplete(
        name: (name != null ? name.value : this.name),
        organizer: (organizer != null ? organizer.value : this.organizer),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        allDay: (allDay != null ? allDay.value : this.allDay),
        location: (location != null ? location.value : this.location),
        type: (type != null ? type.value : this.type),
        description:
            (description != null ? description.value : this.description),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule),
        id: (id != null ? id.value : this.id),
        decision: (decision != null ? decision.value : this.decision),
        applicantId:
            (applicantId != null ? applicantId.value : this.applicantId));
  }
}

@JsonSerializable(explicitToJson: true)
class EventEdit {
  const EventEdit({
    this.name,
    this.organizer,
    this.start,
    this.end,
    this.allDay,
    this.location,
    this.type,
    this.description,
    this.recurrenceRule,
  });

  factory EventEdit.fromJson(Map<String, dynamic> json) =>
      _$EventEditFromJson(json);

  static const toJsonFactory = _$EventEditToJson;
  Map<String, dynamic> toJson() => _$EventEditToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'organizer', defaultValue: '')
  final String? organizer;
  @JsonKey(name: 'start')
  final DateTime? start;
  @JsonKey(name: 'end')
  final DateTime? end;
  @JsonKey(name: 'all_day', defaultValue: false)
  final bool? allDay;
  @JsonKey(name: 'location', defaultValue: '')
  final String? location;
  @JsonKey(
    name: 'type',
    toJson: calendarEventTypeNullableToJson,
    fromJson: calendarEventTypeNullableFromJson,
  )
  final enums.CalendarEventType? type;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  static const fromJsonFactory = _$EventEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality()
                    .equals(other.organizer, organizer)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(organizer) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(allDay) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      runtimeType.hashCode;
}

extension $EventEditExtension on EventEdit {
  EventEdit copyWith(
      {String? name,
      String? organizer,
      DateTime? start,
      DateTime? end,
      bool? allDay,
      String? location,
      enums.CalendarEventType? type,
      String? description,
      String? recurrenceRule}) {
    return EventEdit(
        name: name ?? this.name,
        organizer: organizer ?? this.organizer,
        start: start ?? this.start,
        end: end ?? this.end,
        allDay: allDay ?? this.allDay,
        location: location ?? this.location,
        type: type ?? this.type,
        description: description ?? this.description,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule);
  }

  EventEdit copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? organizer,
      Wrapped<DateTime?>? start,
      Wrapped<DateTime?>? end,
      Wrapped<bool?>? allDay,
      Wrapped<String?>? location,
      Wrapped<enums.CalendarEventType?>? type,
      Wrapped<String?>? description,
      Wrapped<String?>? recurrenceRule}) {
    return EventEdit(
        name: (name != null ? name.value : this.name),
        organizer: (organizer != null ? organizer.value : this.organizer),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        allDay: (allDay != null ? allDay.value : this.allDay),
        location: (location != null ? location.value : this.location),
        type: (type != null ? type.value : this.type),
        description:
            (description != null ? description.value : this.description),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule));
  }
}

@JsonSerializable(explicitToJson: true)
class EventReturn {
  const EventReturn({
    required this.name,
    required this.organizer,
    required this.start,
    required this.end,
    required this.allDay,
    required this.location,
    required this.type,
    required this.description,
    this.recurrenceRule,
    required this.id,
    required this.decision,
    required this.applicantId,
    required this.applicant,
  });

  factory EventReturn.fromJson(Map<String, dynamic> json) =>
      _$EventReturnFromJson(json);

  static const toJsonFactory = _$EventReturnToJson;
  Map<String, dynamic> toJson() => _$EventReturnToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'organizer', defaultValue: '')
  final String organizer;
  @JsonKey(name: 'start')
  final DateTime start;
  @JsonKey(name: 'end')
  final DateTime end;
  @JsonKey(name: 'all_day', defaultValue: false)
  final bool allDay;
  @JsonKey(name: 'location', defaultValue: '')
  final String location;
  @JsonKey(
    name: 'type',
    toJson: calendarEventTypeToJson,
    fromJson: calendarEventTypeFromJson,
  )
  final enums.CalendarEventType type;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'recurrence_rule', defaultValue: '')
  final String? recurrenceRule;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'decision',
    toJson: appUtilsTypesCalendarTypesDecisionToJson,
    fromJson: appUtilsTypesCalendarTypesDecisionFromJson,
  )
  final enums.AppUtilsTypesCalendarTypesDecision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'applicant')
  final EventApplicant applicant;
  static const fromJsonFactory = _$EventReturnFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is EventReturn &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality()
                    .equals(other.organizer, organizer)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality()
                    .equals(other.recurrenceRule, recurrenceRule)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality()
                    .equals(other.decision, decision)) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality()
                    .equals(other.applicantId, applicantId)) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality()
                    .equals(other.applicant, applicant)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(organizer) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(allDay) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(recurrenceRule) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(decision) ^
      const DeepCollectionEquality().hash(applicantId) ^
      const DeepCollectionEquality().hash(applicant) ^
      runtimeType.hashCode;
}

extension $EventReturnExtension on EventReturn {
  EventReturn copyWith(
      {String? name,
      String? organizer,
      DateTime? start,
      DateTime? end,
      bool? allDay,
      String? location,
      enums.CalendarEventType? type,
      String? description,
      String? recurrenceRule,
      String? id,
      enums.AppUtilsTypesCalendarTypesDecision? decision,
      String? applicantId,
      EventApplicant? applicant}) {
    return EventReturn(
        name: name ?? this.name,
        organizer: organizer ?? this.organizer,
        start: start ?? this.start,
        end: end ?? this.end,
        allDay: allDay ?? this.allDay,
        location: location ?? this.location,
        type: type ?? this.type,
        description: description ?? this.description,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        id: id ?? this.id,
        decision: decision ?? this.decision,
        applicantId: applicantId ?? this.applicantId,
        applicant: applicant ?? this.applicant);
  }

  EventReturn copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? organizer,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<bool>? allDay,
      Wrapped<String>? location,
      Wrapped<enums.CalendarEventType>? type,
      Wrapped<String>? description,
      Wrapped<String?>? recurrenceRule,
      Wrapped<String>? id,
      Wrapped<enums.AppUtilsTypesCalendarTypesDecision>? decision,
      Wrapped<String>? applicantId,
      Wrapped<EventApplicant>? applicant}) {
    return EventReturn(
        name: (name != null ? name.value : this.name),
        organizer: (organizer != null ? organizer.value : this.organizer),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        allDay: (allDay != null ? allDay.value : this.allDay),
        location: (location != null ? location.value : this.location),
        type: (type != null ? type.value : this.type),
        description:
            (description != null ? description.value : this.description),
        recurrenceRule: (recurrenceRule != null
            ? recurrenceRule.value
            : this.recurrenceRule),
        id: (id != null ? id.value : this.id),
        decision: (decision != null ? decision.value : this.decision),
        applicantId:
            (applicantId != null ? applicantId.value : this.applicantId),
        applicant: (applicant != null ? applicant.value : this.applicant));
  }
}

@JsonSerializable(explicitToJson: true)
class FirebaseDevice {
  const FirebaseDevice({
    required this.userId,
    this.firebaseDeviceToken,
  });

  factory FirebaseDevice.fromJson(Map<String, dynamic> json) =>
      _$FirebaseDeviceFromJson(json);

  static const toJsonFactory = _$FirebaseDeviceToJson;
  Map<String, dynamic> toJson() => _$FirebaseDeviceToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'firebase_device_token', defaultValue: '')
  final String? firebaseDeviceToken;
  static const fromJsonFactory = _$FirebaseDeviceFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FirebaseDevice &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.firebaseDeviceToken, firebaseDeviceToken) ||
                const DeepCollectionEquality()
                    .equals(other.firebaseDeviceToken, firebaseDeviceToken)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(firebaseDeviceToken) ^
      runtimeType.hashCode;
}

extension $FirebaseDeviceExtension on FirebaseDevice {
  FirebaseDevice copyWith({String? userId, String? firebaseDeviceToken}) {
    return FirebaseDevice(
        userId: userId ?? this.userId,
        firebaseDeviceToken: firebaseDeviceToken ?? this.firebaseDeviceToken);
  }

  FirebaseDevice copyWithWrapped(
      {Wrapped<String>? userId, Wrapped<String?>? firebaseDeviceToken}) {
    return FirebaseDevice(
        userId: (userId != null ? userId.value : this.userId),
        firebaseDeviceToken: (firebaseDeviceToken != null
            ? firebaseDeviceToken.value
            : this.firebaseDeviceToken));
  }
}

@JsonSerializable(explicitToJson: true)
class HTTPValidationError {
  const HTTPValidationError({
    this.detail,
  });

  factory HTTPValidationError.fromJson(Map<String, dynamic> json) =>
      _$HTTPValidationErrorFromJson(json);

  static const toJsonFactory = _$HTTPValidationErrorToJson;
  Map<String, dynamic> toJson() => _$HTTPValidationErrorToJson(this);

  @JsonKey(name: 'detail', defaultValue: <ValidationError>[])
  final List<ValidationError>? detail;
  static const fromJsonFactory = _$HTTPValidationErrorFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HTTPValidationError &&
            (identical(other.detail, detail) ||
                const DeepCollectionEquality().equals(other.detail, detail)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(detail) ^ runtimeType.hashCode;
}

extension $HTTPValidationErrorExtension on HTTPValidationError {
  HTTPValidationError copyWith({List<ValidationError>? detail}) {
    return HTTPValidationError(detail: detail ?? this.detail);
  }

  HTTPValidationError copyWithWrapped(
      {Wrapped<List<ValidationError>?>? detail}) {
    return HTTPValidationError(
        detail: (detail != null ? detail.value : this.detail));
  }
}

@JsonSerializable(explicitToJson: true)
class Information {
  const Information({
    required this.manager,
    required this.link,
    required this.description,
  });

  factory Information.fromJson(Map<String, dynamic> json) =>
      _$InformationFromJson(json);

  static const toJsonFactory = _$InformationToJson;
  Map<String, dynamic> toJson() => _$InformationToJson(this);

  @JsonKey(name: 'manager', defaultValue: '')
  final String manager;
  @JsonKey(name: 'link', defaultValue: '')
  final String link;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  static const fromJsonFactory = _$InformationFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Information &&
            (identical(other.manager, manager) ||
                const DeepCollectionEquality()
                    .equals(other.manager, manager)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(manager) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $InformationExtension on Information {
  Information copyWith({String? manager, String? link, String? description}) {
    return Information(
        manager: manager ?? this.manager,
        link: link ?? this.link,
        description: description ?? this.description);
  }

  Information copyWithWrapped(
      {Wrapped<String>? manager,
      Wrapped<String>? link,
      Wrapped<String>? description}) {
    return Information(
        manager: (manager != null ? manager.value : this.manager),
        link: (link != null ? link.value : this.link),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class InformationEdit {
  const InformationEdit({
    this.manager,
    this.link,
    this.description,
  });

  factory InformationEdit.fromJson(Map<String, dynamic> json) =>
      _$InformationEditFromJson(json);

  static const toJsonFactory = _$InformationEditToJson;
  Map<String, dynamic> toJson() => _$InformationEditToJson(this);

  @JsonKey(name: 'manager', defaultValue: '')
  final String? manager;
  @JsonKey(name: 'link', defaultValue: '')
  final String? link;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  static const fromJsonFactory = _$InformationEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is InformationEdit &&
            (identical(other.manager, manager) ||
                const DeepCollectionEquality()
                    .equals(other.manager, manager)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(manager) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $InformationEditExtension on InformationEdit {
  InformationEdit copyWith(
      {String? manager, String? link, String? description}) {
    return InformationEdit(
        manager: manager ?? this.manager,
        link: link ?? this.link,
        description: description ?? this.description);
  }

  InformationEdit copyWithWrapped(
      {Wrapped<String?>? manager,
      Wrapped<String?>? link,
      Wrapped<String?>? description}) {
    return InformationEdit(
        manager: (manager != null ? manager.value : this.manager),
        link: (link != null ? link.value : this.link),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class Item {
  const Item({
    required this.name,
    required this.suggestedCaution,
    required this.totalQuantity,
    required this.suggestedLendingDuration,
    required this.id,
    required this.loanerId,
    required this.loanedQuantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  static const toJsonFactory = _$ItemToJson;
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'suggested_caution', defaultValue: 0)
  final int suggestedCaution;
  @JsonKey(name: 'total_quantity', defaultValue: 0)
  final int totalQuantity;
  @JsonKey(name: 'suggested_lending_duration', defaultValue: 0.0)
  final double suggestedLendingDuration;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'loaner_id', defaultValue: '')
  final String loanerId;
  @JsonKey(name: 'loaned_quantity', defaultValue: 0)
  final int loanedQuantity;
  static const fromJsonFactory = _$ItemFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Item &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.suggestedCaution, suggestedCaution) ||
                const DeepCollectionEquality()
                    .equals(other.suggestedCaution, suggestedCaution)) &&
            (identical(other.totalQuantity, totalQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.totalQuantity, totalQuantity)) &&
            (identical(
                    other.suggestedLendingDuration, suggestedLendingDuration) ||
                const DeepCollectionEquality().equals(
                    other.suggestedLendingDuration,
                    suggestedLendingDuration)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality()
                    .equals(other.loanerId, loanerId)) &&
            (identical(other.loanedQuantity, loanedQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.loanedQuantity, loanedQuantity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(suggestedCaution) ^
      const DeepCollectionEquality().hash(totalQuantity) ^
      const DeepCollectionEquality().hash(suggestedLendingDuration) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(loanerId) ^
      const DeepCollectionEquality().hash(loanedQuantity) ^
      runtimeType.hashCode;
}

extension $ItemExtension on Item {
  Item copyWith(
      {String? name,
      int? suggestedCaution,
      int? totalQuantity,
      double? suggestedLendingDuration,
      String? id,
      String? loanerId,
      int? loanedQuantity}) {
    return Item(
        name: name ?? this.name,
        suggestedCaution: suggestedCaution ?? this.suggestedCaution,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration,
        id: id ?? this.id,
        loanerId: loanerId ?? this.loanerId,
        loanedQuantity: loanedQuantity ?? this.loanedQuantity);
  }

  Item copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<int>? suggestedCaution,
      Wrapped<int>? totalQuantity,
      Wrapped<double>? suggestedLendingDuration,
      Wrapped<String>? id,
      Wrapped<String>? loanerId,
      Wrapped<int>? loanedQuantity}) {
    return Item(
        name: (name != null ? name.value : this.name),
        suggestedCaution: (suggestedCaution != null
            ? suggestedCaution.value
            : this.suggestedCaution),
        totalQuantity:
            (totalQuantity != null ? totalQuantity.value : this.totalQuantity),
        suggestedLendingDuration: (suggestedLendingDuration != null
            ? suggestedLendingDuration.value
            : this.suggestedLendingDuration),
        id: (id != null ? id.value : this.id),
        loanerId: (loanerId != null ? loanerId.value : this.loanerId),
        loanedQuantity: (loanedQuantity != null
            ? loanedQuantity.value
            : this.loanedQuantity));
  }
}

@JsonSerializable(explicitToJson: true)
class ItemBase {
  const ItemBase({
    required this.name,
    required this.suggestedCaution,
    required this.totalQuantity,
    required this.suggestedLendingDuration,
  });

  factory ItemBase.fromJson(Map<String, dynamic> json) =>
      _$ItemBaseFromJson(json);

  static const toJsonFactory = _$ItemBaseToJson;
  Map<String, dynamic> toJson() => _$ItemBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'suggested_caution', defaultValue: 0)
  final int suggestedCaution;
  @JsonKey(name: 'total_quantity', defaultValue: 0)
  final int totalQuantity;
  @JsonKey(name: 'suggested_lending_duration', defaultValue: 0.0)
  final double suggestedLendingDuration;
  static const fromJsonFactory = _$ItemBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ItemBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.suggestedCaution, suggestedCaution) ||
                const DeepCollectionEquality()
                    .equals(other.suggestedCaution, suggestedCaution)) &&
            (identical(other.totalQuantity, totalQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.totalQuantity, totalQuantity)) &&
            (identical(
                    other.suggestedLendingDuration, suggestedLendingDuration) ||
                const DeepCollectionEquality().equals(
                    other.suggestedLendingDuration, suggestedLendingDuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(suggestedCaution) ^
      const DeepCollectionEquality().hash(totalQuantity) ^
      const DeepCollectionEquality().hash(suggestedLendingDuration) ^
      runtimeType.hashCode;
}

extension $ItemBaseExtension on ItemBase {
  ItemBase copyWith(
      {String? name,
      int? suggestedCaution,
      int? totalQuantity,
      double? suggestedLendingDuration}) {
    return ItemBase(
        name: name ?? this.name,
        suggestedCaution: suggestedCaution ?? this.suggestedCaution,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration);
  }

  ItemBase copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<int>? suggestedCaution,
      Wrapped<int>? totalQuantity,
      Wrapped<double>? suggestedLendingDuration}) {
    return ItemBase(
        name: (name != null ? name.value : this.name),
        suggestedCaution: (suggestedCaution != null
            ? suggestedCaution.value
            : this.suggestedCaution),
        totalQuantity:
            (totalQuantity != null ? totalQuantity.value : this.totalQuantity),
        suggestedLendingDuration: (suggestedLendingDuration != null
            ? suggestedLendingDuration.value
            : this.suggestedLendingDuration));
  }
}

@JsonSerializable(explicitToJson: true)
class ItemBorrowed {
  const ItemBorrowed({
    required this.itemId,
    required this.quantity,
  });

  factory ItemBorrowed.fromJson(Map<String, dynamic> json) =>
      _$ItemBorrowedFromJson(json);

  static const toJsonFactory = _$ItemBorrowedToJson;
  Map<String, dynamic> toJson() => _$ItemBorrowedToJson(this);

  @JsonKey(name: 'item_id', defaultValue: '')
  final String itemId;
  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  static const fromJsonFactory = _$ItemBorrowedFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ItemBorrowed &&
            (identical(other.itemId, itemId) ||
                const DeepCollectionEquality().equals(other.itemId, itemId)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(itemId) ^
      const DeepCollectionEquality().hash(quantity) ^
      runtimeType.hashCode;
}

extension $ItemBorrowedExtension on ItemBorrowed {
  ItemBorrowed copyWith({String? itemId, int? quantity}) {
    return ItemBorrowed(
        itemId: itemId ?? this.itemId, quantity: quantity ?? this.quantity);
  }

  ItemBorrowed copyWithWrapped(
      {Wrapped<String>? itemId, Wrapped<int>? quantity}) {
    return ItemBorrowed(
        itemId: (itemId != null ? itemId.value : this.itemId),
        quantity: (quantity != null ? quantity.value : this.quantity));
  }
}

@JsonSerializable(explicitToJson: true)
class ItemQuantity {
  const ItemQuantity({
    required this.quantity,
    required this.itemSimple,
  });

  factory ItemQuantity.fromJson(Map<String, dynamic> json) =>
      _$ItemQuantityFromJson(json);

  static const toJsonFactory = _$ItemQuantityToJson;
  Map<String, dynamic> toJson() => _$ItemQuantityToJson(this);

  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  @JsonKey(name: 'itemSimple')
  final ItemSimple itemSimple;
  static const fromJsonFactory = _$ItemQuantityFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ItemQuantity &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.itemSimple, itemSimple) ||
                const DeepCollectionEquality()
                    .equals(other.itemSimple, itemSimple)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(itemSimple) ^
      runtimeType.hashCode;
}

extension $ItemQuantityExtension on ItemQuantity {
  ItemQuantity copyWith({int? quantity, ItemSimple? itemSimple}) {
    return ItemQuantity(
        quantity: quantity ?? this.quantity,
        itemSimple: itemSimple ?? this.itemSimple);
  }

  ItemQuantity copyWithWrapped(
      {Wrapped<int>? quantity, Wrapped<ItemSimple>? itemSimple}) {
    return ItemQuantity(
        quantity: (quantity != null ? quantity.value : this.quantity),
        itemSimple: (itemSimple != null ? itemSimple.value : this.itemSimple));
  }
}

@JsonSerializable(explicitToJson: true)
class ItemSimple {
  const ItemSimple({
    required this.id,
    required this.name,
    required this.loanerId,
  });

  factory ItemSimple.fromJson(Map<String, dynamic> json) =>
      _$ItemSimpleFromJson(json);

  static const toJsonFactory = _$ItemSimpleToJson;
  Map<String, dynamic> toJson() => _$ItemSimpleToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'loaner_id', defaultValue: '')
  final String loanerId;
  static const fromJsonFactory = _$ItemSimpleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ItemSimple &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality()
                    .equals(other.loanerId, loanerId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(loanerId) ^
      runtimeType.hashCode;
}

extension $ItemSimpleExtension on ItemSimple {
  ItemSimple copyWith({String? id, String? name, String? loanerId}) {
    return ItemSimple(
        id: id ?? this.id,
        name: name ?? this.name,
        loanerId: loanerId ?? this.loanerId);
  }

  ItemSimple copyWithWrapped(
      {Wrapped<String>? id, Wrapped<String>? name, Wrapped<String>? loanerId}) {
    return ItemSimple(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        loanerId: (loanerId != null ? loanerId.value : this.loanerId));
  }
}

@JsonSerializable(explicitToJson: true)
class ItemUpdate {
  const ItemUpdate({
    this.name,
    this.suggestedCaution,
    this.totalQuantity,
    this.suggestedLendingDuration,
  });

  factory ItemUpdate.fromJson(Map<String, dynamic> json) =>
      _$ItemUpdateFromJson(json);

  static const toJsonFactory = _$ItemUpdateToJson;
  Map<String, dynamic> toJson() => _$ItemUpdateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'suggested_caution', defaultValue: 0)
  final int? suggestedCaution;
  @JsonKey(name: 'total_quantity', defaultValue: 0)
  final int? totalQuantity;
  @JsonKey(name: 'suggested_lending_duration', defaultValue: 0.0)
  final double? suggestedLendingDuration;
  static const fromJsonFactory = _$ItemUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ItemUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.suggestedCaution, suggestedCaution) ||
                const DeepCollectionEquality()
                    .equals(other.suggestedCaution, suggestedCaution)) &&
            (identical(other.totalQuantity, totalQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.totalQuantity, totalQuantity)) &&
            (identical(
                    other.suggestedLendingDuration, suggestedLendingDuration) ||
                const DeepCollectionEquality().equals(
                    other.suggestedLendingDuration, suggestedLendingDuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(suggestedCaution) ^
      const DeepCollectionEquality().hash(totalQuantity) ^
      const DeepCollectionEquality().hash(suggestedLendingDuration) ^
      runtimeType.hashCode;
}

extension $ItemUpdateExtension on ItemUpdate {
  ItemUpdate copyWith(
      {String? name,
      int? suggestedCaution,
      int? totalQuantity,
      double? suggestedLendingDuration}) {
    return ItemUpdate(
        name: name ?? this.name,
        suggestedCaution: suggestedCaution ?? this.suggestedCaution,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration);
  }

  ItemUpdate copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<int?>? suggestedCaution,
      Wrapped<int?>? totalQuantity,
      Wrapped<double?>? suggestedLendingDuration}) {
    return ItemUpdate(
        name: (name != null ? name.value : this.name),
        suggestedCaution: (suggestedCaution != null
            ? suggestedCaution.value
            : this.suggestedCaution),
        totalQuantity:
            (totalQuantity != null ? totalQuantity.value : this.totalQuantity),
        suggestedLendingDuration: (suggestedLendingDuration != null
            ? suggestedLendingDuration.value
            : this.suggestedLendingDuration));
  }
}

@JsonSerializable(explicitToJson: true)
class ListBase {
  const ListBase({
    required this.name,
    required this.description,
    required this.type,
    required this.sectionId,
    required this.members,
    this.program,
  });

  factory ListBase.fromJson(Map<String, dynamic> json) =>
      _$ListBaseFromJson(json);

  static const toJsonFactory = _$ListBaseToJson;
  Map<String, dynamic> toJson() => _$ListBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(
    name: 'type',
    toJson: listTypeToJson,
    fromJson: listTypeFromJson,
  )
  final enums.ListType type;
  @JsonKey(name: 'section_id', defaultValue: '')
  final String sectionId;
  @JsonKey(name: 'members', defaultValue: <ListMemberBase>[])
  final List<ListMemberBase> members;
  @JsonKey(name: 'program', defaultValue: '')
  final String? program;
  static const fromJsonFactory = _$ListBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ListBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.sectionId, sectionId) ||
                const DeepCollectionEquality()
                    .equals(other.sectionId, sectionId)) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality()
                    .equals(other.members, members)) &&
            (identical(other.program, program) ||
                const DeepCollectionEquality().equals(other.program, program)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(sectionId) ^
      const DeepCollectionEquality().hash(members) ^
      const DeepCollectionEquality().hash(program) ^
      runtimeType.hashCode;
}

extension $ListBaseExtension on ListBase {
  ListBase copyWith(
      {String? name,
      String? description,
      enums.ListType? type,
      String? sectionId,
      List<ListMemberBase>? members,
      String? program}) {
    return ListBase(
        name: name ?? this.name,
        description: description ?? this.description,
        type: type ?? this.type,
        sectionId: sectionId ?? this.sectionId,
        members: members ?? this.members,
        program: program ?? this.program);
  }

  ListBase copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<enums.ListType>? type,
      Wrapped<String>? sectionId,
      Wrapped<List<ListMemberBase>>? members,
      Wrapped<String?>? program}) {
    return ListBase(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        type: (type != null ? type.value : this.type),
        sectionId: (sectionId != null ? sectionId.value : this.sectionId),
        members: (members != null ? members.value : this.members),
        program: (program != null ? program.value : this.program));
  }
}

@JsonSerializable(explicitToJson: true)
class ListEdit {
  const ListEdit({
    this.name,
    this.description,
    this.type,
    this.members,
    this.program,
  });

  factory ListEdit.fromJson(Map<String, dynamic> json) =>
      _$ListEditFromJson(json);

  static const toJsonFactory = _$ListEditToJson;
  Map<String, dynamic> toJson() => _$ListEditToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(
    name: 'type',
    toJson: listTypeNullableToJson,
    fromJson: listTypeNullableFromJson,
  )
  final enums.ListType? type;
  @JsonKey(name: 'members', defaultValue: <ListMemberBase>[])
  final List<ListMemberBase>? members;
  @JsonKey(name: 'program', defaultValue: '')
  final String? program;
  static const fromJsonFactory = _$ListEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ListEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality()
                    .equals(other.members, members)) &&
            (identical(other.program, program) ||
                const DeepCollectionEquality().equals(other.program, program)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(members) ^
      const DeepCollectionEquality().hash(program) ^
      runtimeType.hashCode;
}

extension $ListEditExtension on ListEdit {
  ListEdit copyWith(
      {String? name,
      String? description,
      enums.ListType? type,
      List<ListMemberBase>? members,
      String? program}) {
    return ListEdit(
        name: name ?? this.name,
        description: description ?? this.description,
        type: type ?? this.type,
        members: members ?? this.members,
        program: program ?? this.program);
  }

  ListEdit copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? description,
      Wrapped<enums.ListType?>? type,
      Wrapped<List<ListMemberBase>?>? members,
      Wrapped<String?>? program}) {
    return ListEdit(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        type: (type != null ? type.value : this.type),
        members: (members != null ? members.value : this.members),
        program: (program != null ? program.value : this.program));
  }
}

@JsonSerializable(explicitToJson: true)
class ListMemberBase {
  const ListMemberBase({
    required this.userId,
    required this.role,
  });

  factory ListMemberBase.fromJson(Map<String, dynamic> json) =>
      _$ListMemberBaseFromJson(json);

  static const toJsonFactory = _$ListMemberBaseToJson;
  Map<String, dynamic> toJson() => _$ListMemberBaseToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'role', defaultValue: '')
  final String role;
  static const fromJsonFactory = _$ListMemberBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ListMemberBase &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(role) ^
      runtimeType.hashCode;
}

extension $ListMemberBaseExtension on ListMemberBase {
  ListMemberBase copyWith({String? userId, String? role}) {
    return ListMemberBase(
        userId: userId ?? this.userId, role: role ?? this.role);
  }

  ListMemberBase copyWithWrapped(
      {Wrapped<String>? userId, Wrapped<String>? role}) {
    return ListMemberBase(
        userId: (userId != null ? userId.value : this.userId),
        role: (role != null ? role.value : this.role));
  }
}

@JsonSerializable(explicitToJson: true)
class ListMemberComplete {
  const ListMemberComplete({
    required this.userId,
    required this.role,
    required this.user,
  });

  factory ListMemberComplete.fromJson(Map<String, dynamic> json) =>
      _$ListMemberCompleteFromJson(json);

  static const toJsonFactory = _$ListMemberCompleteToJson;
  Map<String, dynamic> toJson() => _$ListMemberCompleteToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'role', defaultValue: '')
  final String role;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  static const fromJsonFactory = _$ListMemberCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ListMemberComplete &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $ListMemberCompleteExtension on ListMemberComplete {
  ListMemberComplete copyWith(
      {String? userId, String? role, CoreUserSimple? user}) {
    return ListMemberComplete(
        userId: userId ?? this.userId,
        role: role ?? this.role,
        user: user ?? this.user);
  }

  ListMemberComplete copyWithWrapped(
      {Wrapped<String>? userId,
      Wrapped<String>? role,
      Wrapped<CoreUserSimple>? user}) {
    return ListMemberComplete(
        userId: (userId != null ? userId.value : this.userId),
        role: (role != null ? role.value : this.role),
        user: (user != null ? user.value : this.user));
  }
}

@JsonSerializable(explicitToJson: true)
class ListReturn {
  const ListReturn({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.section,
    required this.members,
    this.program,
  });

  factory ListReturn.fromJson(Map<String, dynamic> json) =>
      _$ListReturnFromJson(json);

  static const toJsonFactory = _$ListReturnToJson;
  Map<String, dynamic> toJson() => _$ListReturnToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(
    name: 'type',
    toJson: listTypeToJson,
    fromJson: listTypeFromJson,
  )
  final enums.ListType type;
  @JsonKey(name: 'section')
  final SectionComplete section;
  @JsonKey(name: 'members', defaultValue: <ListMemberComplete>[])
  final List<ListMemberComplete> members;
  @JsonKey(name: 'program', defaultValue: '')
  final String? program;
  static const fromJsonFactory = _$ListReturnFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ListReturn &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.section, section) ||
                const DeepCollectionEquality()
                    .equals(other.section, section)) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality()
                    .equals(other.members, members)) &&
            (identical(other.program, program) ||
                const DeepCollectionEquality().equals(other.program, program)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(section) ^
      const DeepCollectionEquality().hash(members) ^
      const DeepCollectionEquality().hash(program) ^
      runtimeType.hashCode;
}

extension $ListReturnExtension on ListReturn {
  ListReturn copyWith(
      {String? id,
      String? name,
      String? description,
      enums.ListType? type,
      SectionComplete? section,
      List<ListMemberComplete>? members,
      String? program}) {
    return ListReturn(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        type: type ?? this.type,
        section: section ?? this.section,
        members: members ?? this.members,
        program: program ?? this.program);
  }

  ListReturn copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<enums.ListType>? type,
      Wrapped<SectionComplete>? section,
      Wrapped<List<ListMemberComplete>>? members,
      Wrapped<String?>? program}) {
    return ListReturn(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        type: (type != null ? type.value : this.type),
        section: (section != null ? section.value : this.section),
        members: (members != null ? members.value : this.members),
        program: (program != null ? program.value : this.program));
  }
}

@JsonSerializable(explicitToJson: true)
class Loan {
  const Loan({
    required this.borrowerId,
    required this.loanerId,
    required this.start,
    required this.end,
    this.notes,
    this.caution,
    required this.id,
    required this.returned,
    required this.itemsQty,
    required this.borrower,
    required this.loaner,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);

  static const toJsonFactory = _$LoanToJson;
  Map<String, dynamic> toJson() => _$LoanToJson(this);

  @JsonKey(name: 'borrower_id', defaultValue: '')
  final String borrowerId;
  @JsonKey(name: 'loaner_id', defaultValue: '')
  final String loanerId;
  @JsonKey(name: 'start', toJson: _dateToJson)
  final DateTime start;
  @JsonKey(name: 'end', toJson: _dateToJson)
  final DateTime end;
  @JsonKey(name: 'notes', defaultValue: '')
  final String? notes;
  @JsonKey(name: 'caution', defaultValue: '')
  final String? caution;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'returned', defaultValue: false)
  final bool returned;
  @JsonKey(name: 'items_qty', defaultValue: <ItemQuantity>[])
  final List<ItemQuantity> itemsQty;
  @JsonKey(name: 'borrower')
  final CoreUserSimple borrower;
  @JsonKey(name: 'loaner')
  final Loaner loaner;
  static const fromJsonFactory = _$LoanFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loan &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality()
                    .equals(other.borrowerId, borrowerId)) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality()
                    .equals(other.loanerId, loanerId)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.caution, caution) ||
                const DeepCollectionEquality()
                    .equals(other.caution, caution)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.returned, returned) ||
                const DeepCollectionEquality()
                    .equals(other.returned, returned)) &&
            (identical(other.itemsQty, itemsQty) ||
                const DeepCollectionEquality()
                    .equals(other.itemsQty, itemsQty)) &&
            (identical(other.borrower, borrower) ||
                const DeepCollectionEquality()
                    .equals(other.borrower, borrower)) &&
            (identical(other.loaner, loaner) ||
                const DeepCollectionEquality().equals(other.loaner, loaner)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(borrowerId) ^
      const DeepCollectionEquality().hash(loanerId) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(caution) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(returned) ^
      const DeepCollectionEquality().hash(itemsQty) ^
      const DeepCollectionEquality().hash(borrower) ^
      const DeepCollectionEquality().hash(loaner) ^
      runtimeType.hashCode;
}

extension $LoanExtension on Loan {
  Loan copyWith(
      {String? borrowerId,
      String? loanerId,
      DateTime? start,
      DateTime? end,
      String? notes,
      String? caution,
      String? id,
      bool? returned,
      List<ItemQuantity>? itemsQty,
      CoreUserSimple? borrower,
      Loaner? loaner}) {
    return Loan(
        borrowerId: borrowerId ?? this.borrowerId,
        loanerId: loanerId ?? this.loanerId,
        start: start ?? this.start,
        end: end ?? this.end,
        notes: notes ?? this.notes,
        caution: caution ?? this.caution,
        id: id ?? this.id,
        returned: returned ?? this.returned,
        itemsQty: itemsQty ?? this.itemsQty,
        borrower: borrower ?? this.borrower,
        loaner: loaner ?? this.loaner);
  }

  Loan copyWithWrapped(
      {Wrapped<String>? borrowerId,
      Wrapped<String>? loanerId,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<String?>? notes,
      Wrapped<String?>? caution,
      Wrapped<String>? id,
      Wrapped<bool>? returned,
      Wrapped<List<ItemQuantity>>? itemsQty,
      Wrapped<CoreUserSimple>? borrower,
      Wrapped<Loaner>? loaner}) {
    return Loan(
        borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
        loanerId: (loanerId != null ? loanerId.value : this.loanerId),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        notes: (notes != null ? notes.value : this.notes),
        caution: (caution != null ? caution.value : this.caution),
        id: (id != null ? id.value : this.id),
        returned: (returned != null ? returned.value : this.returned),
        itemsQty: (itemsQty != null ? itemsQty.value : this.itemsQty),
        borrower: (borrower != null ? borrower.value : this.borrower),
        loaner: (loaner != null ? loaner.value : this.loaner));
  }
}

@JsonSerializable(explicitToJson: true)
class LoanCreation {
  const LoanCreation({
    required this.borrowerId,
    required this.loanerId,
    required this.start,
    required this.end,
    this.notes,
    this.caution,
    required this.itemsBorrowed,
  });

  factory LoanCreation.fromJson(Map<String, dynamic> json) =>
      _$LoanCreationFromJson(json);

  static const toJsonFactory = _$LoanCreationToJson;
  Map<String, dynamic> toJson() => _$LoanCreationToJson(this);

  @JsonKey(name: 'borrower_id', defaultValue: '')
  final String borrowerId;
  @JsonKey(name: 'loaner_id', defaultValue: '')
  final String loanerId;
  @JsonKey(name: 'start', toJson: _dateToJson)
  final DateTime start;
  @JsonKey(name: 'end', toJson: _dateToJson)
  final DateTime end;
  @JsonKey(name: 'notes', defaultValue: '')
  final String? notes;
  @JsonKey(name: 'caution', defaultValue: '')
  final String? caution;
  @JsonKey(name: 'items_borrowed', defaultValue: <ItemBorrowed>[])
  final List<ItemBorrowed> itemsBorrowed;
  static const fromJsonFactory = _$LoanCreationFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoanCreation &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality()
                    .equals(other.borrowerId, borrowerId)) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality()
                    .equals(other.loanerId, loanerId)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.caution, caution) ||
                const DeepCollectionEquality()
                    .equals(other.caution, caution)) &&
            (identical(other.itemsBorrowed, itemsBorrowed) ||
                const DeepCollectionEquality()
                    .equals(other.itemsBorrowed, itemsBorrowed)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(borrowerId) ^
      const DeepCollectionEquality().hash(loanerId) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(caution) ^
      const DeepCollectionEquality().hash(itemsBorrowed) ^
      runtimeType.hashCode;
}

extension $LoanCreationExtension on LoanCreation {
  LoanCreation copyWith(
      {String? borrowerId,
      String? loanerId,
      DateTime? start,
      DateTime? end,
      String? notes,
      String? caution,
      List<ItemBorrowed>? itemsBorrowed}) {
    return LoanCreation(
        borrowerId: borrowerId ?? this.borrowerId,
        loanerId: loanerId ?? this.loanerId,
        start: start ?? this.start,
        end: end ?? this.end,
        notes: notes ?? this.notes,
        caution: caution ?? this.caution,
        itemsBorrowed: itemsBorrowed ?? this.itemsBorrowed);
  }

  LoanCreation copyWithWrapped(
      {Wrapped<String>? borrowerId,
      Wrapped<String>? loanerId,
      Wrapped<DateTime>? start,
      Wrapped<DateTime>? end,
      Wrapped<String?>? notes,
      Wrapped<String?>? caution,
      Wrapped<List<ItemBorrowed>>? itemsBorrowed}) {
    return LoanCreation(
        borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
        loanerId: (loanerId != null ? loanerId.value : this.loanerId),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        notes: (notes != null ? notes.value : this.notes),
        caution: (caution != null ? caution.value : this.caution),
        itemsBorrowed:
            (itemsBorrowed != null ? itemsBorrowed.value : this.itemsBorrowed));
  }
}

@JsonSerializable(explicitToJson: true)
class LoanExtend {
  const LoanExtend({
    this.end,
    this.duration,
  });

  factory LoanExtend.fromJson(Map<String, dynamic> json) =>
      _$LoanExtendFromJson(json);

  static const toJsonFactory = _$LoanExtendToJson;
  Map<String, dynamic> toJson() => _$LoanExtendToJson(this);

  @JsonKey(name: 'end', toJson: _dateToJson)
  final DateTime? end;
  @JsonKey(name: 'duration', defaultValue: 0.0)
  final double? duration;
  static const fromJsonFactory = _$LoanExtendFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoanExtend &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(duration) ^
      runtimeType.hashCode;
}

extension $LoanExtendExtension on LoanExtend {
  LoanExtend copyWith({DateTime? end, double? duration}) {
    return LoanExtend(
        end: end ?? this.end, duration: duration ?? this.duration);
  }

  LoanExtend copyWithWrapped(
      {Wrapped<DateTime?>? end, Wrapped<double?>? duration}) {
    return LoanExtend(
        end: (end != null ? end.value : this.end),
        duration: (duration != null ? duration.value : this.duration));
  }
}

@JsonSerializable(explicitToJson: true)
class LoanUpdate {
  const LoanUpdate({
    this.borrowerId,
    this.start,
    this.end,
    this.notes,
    this.caution,
    this.returned,
    this.itemsBorrowed,
  });

  factory LoanUpdate.fromJson(Map<String, dynamic> json) =>
      _$LoanUpdateFromJson(json);

  static const toJsonFactory = _$LoanUpdateToJson;
  Map<String, dynamic> toJson() => _$LoanUpdateToJson(this);

  @JsonKey(name: 'borrower_id', defaultValue: '')
  final String? borrowerId;
  @JsonKey(name: 'start', toJson: _dateToJson)
  final DateTime? start;
  @JsonKey(name: 'end', toJson: _dateToJson)
  final DateTime? end;
  @JsonKey(name: 'notes', defaultValue: '')
  final String? notes;
  @JsonKey(name: 'caution', defaultValue: '')
  final String? caution;
  @JsonKey(name: 'returned', defaultValue: false)
  final bool? returned;
  @JsonKey(name: 'items_borrowed', defaultValue: <ItemBorrowed>[])
  final List<ItemBorrowed>? itemsBorrowed;
  static const fromJsonFactory = _$LoanUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoanUpdate &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality()
                    .equals(other.borrowerId, borrowerId)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.caution, caution) ||
                const DeepCollectionEquality()
                    .equals(other.caution, caution)) &&
            (identical(other.returned, returned) ||
                const DeepCollectionEquality()
                    .equals(other.returned, returned)) &&
            (identical(other.itemsBorrowed, itemsBorrowed) ||
                const DeepCollectionEquality()
                    .equals(other.itemsBorrowed, itemsBorrowed)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(borrowerId) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(caution) ^
      const DeepCollectionEquality().hash(returned) ^
      const DeepCollectionEquality().hash(itemsBorrowed) ^
      runtimeType.hashCode;
}

extension $LoanUpdateExtension on LoanUpdate {
  LoanUpdate copyWith(
      {String? borrowerId,
      DateTime? start,
      DateTime? end,
      String? notes,
      String? caution,
      bool? returned,
      List<ItemBorrowed>? itemsBorrowed}) {
    return LoanUpdate(
        borrowerId: borrowerId ?? this.borrowerId,
        start: start ?? this.start,
        end: end ?? this.end,
        notes: notes ?? this.notes,
        caution: caution ?? this.caution,
        returned: returned ?? this.returned,
        itemsBorrowed: itemsBorrowed ?? this.itemsBorrowed);
  }

  LoanUpdate copyWithWrapped(
      {Wrapped<String?>? borrowerId,
      Wrapped<DateTime?>? start,
      Wrapped<DateTime?>? end,
      Wrapped<String?>? notes,
      Wrapped<String?>? caution,
      Wrapped<bool?>? returned,
      Wrapped<List<ItemBorrowed>?>? itemsBorrowed}) {
    return LoanUpdate(
        borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end),
        notes: (notes != null ? notes.value : this.notes),
        caution: (caution != null ? caution.value : this.caution),
        returned: (returned != null ? returned.value : this.returned),
        itemsBorrowed:
            (itemsBorrowed != null ? itemsBorrowed.value : this.itemsBorrowed));
  }
}

@JsonSerializable(explicitToJson: true)
class Loaner {
  const Loaner({
    required this.name,
    required this.groupManagerId,
    required this.id,
  });

  factory Loaner.fromJson(Map<String, dynamic> json) => _$LoanerFromJson(json);

  static const toJsonFactory = _$LoanerToJson;
  Map<String, dynamic> toJson() => _$LoanerToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_manager_id', defaultValue: '')
  final String groupManagerId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$LoanerFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loaner &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality()
                    .equals(other.groupManagerId, groupManagerId)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupManagerId) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $LoanerExtension on Loaner {
  Loaner copyWith({String? name, String? groupManagerId, String? id}) {
    return Loaner(
        name: name ?? this.name,
        groupManagerId: groupManagerId ?? this.groupManagerId,
        id: id ?? this.id);
  }

  Loaner copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? groupManagerId,
      Wrapped<String>? id}) {
    return Loaner(
        name: (name != null ? name.value : this.name),
        groupManagerId: (groupManagerId != null
            ? groupManagerId.value
            : this.groupManagerId),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class LoanerBase {
  const LoanerBase({
    required this.name,
    required this.groupManagerId,
  });

  factory LoanerBase.fromJson(Map<String, dynamic> json) =>
      _$LoanerBaseFromJson(json);

  static const toJsonFactory = _$LoanerBaseToJson;
  Map<String, dynamic> toJson() => _$LoanerBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_manager_id', defaultValue: '')
  final String groupManagerId;
  static const fromJsonFactory = _$LoanerBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoanerBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality()
                    .equals(other.groupManagerId, groupManagerId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupManagerId) ^
      runtimeType.hashCode;
}

extension $LoanerBaseExtension on LoanerBase {
  LoanerBase copyWith({String? name, String? groupManagerId}) {
    return LoanerBase(
        name: name ?? this.name,
        groupManagerId: groupManagerId ?? this.groupManagerId);
  }

  LoanerBase copyWithWrapped(
      {Wrapped<String>? name, Wrapped<String>? groupManagerId}) {
    return LoanerBase(
        name: (name != null ? name.value : this.name),
        groupManagerId: (groupManagerId != null
            ? groupManagerId.value
            : this.groupManagerId));
  }
}

@JsonSerializable(explicitToJson: true)
class LoanerUpdate {
  const LoanerUpdate({
    this.name,
    this.groupManagerId,
  });

  factory LoanerUpdate.fromJson(Map<String, dynamic> json) =>
      _$LoanerUpdateFromJson(json);

  static const toJsonFactory = _$LoanerUpdateToJson;
  Map<String, dynamic> toJson() => _$LoanerUpdateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'group_manager_id', defaultValue: '')
  final String? groupManagerId;
  static const fromJsonFactory = _$LoanerUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoanerUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality()
                    .equals(other.groupManagerId, groupManagerId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupManagerId) ^
      runtimeType.hashCode;
}

extension $LoanerUpdateExtension on LoanerUpdate {
  LoanerUpdate copyWith({String? name, String? groupManagerId}) {
    return LoanerUpdate(
        name: name ?? this.name,
        groupManagerId: groupManagerId ?? this.groupManagerId);
  }

  LoanerUpdate copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<String?>? groupManagerId}) {
    return LoanerUpdate(
        name: (name != null ? name.value : this.name),
        groupManagerId: (groupManagerId != null
            ? groupManagerId.value
            : this.groupManagerId));
  }
}

@JsonSerializable(explicitToJson: true)
class MailMigrationRequest {
  const MailMigrationRequest({
    required this.newEmail,
  });

  factory MailMigrationRequest.fromJson(Map<String, dynamic> json) =>
      _$MailMigrationRequestFromJson(json);

  static const toJsonFactory = _$MailMigrationRequestToJson;
  Map<String, dynamic> toJson() => _$MailMigrationRequestToJson(this);

  @JsonKey(name: 'new_email', defaultValue: '')
  final String newEmail;
  static const fromJsonFactory = _$MailMigrationRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MailMigrationRequest &&
            (identical(other.newEmail, newEmail) ||
                const DeepCollectionEquality()
                    .equals(other.newEmail, newEmail)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(newEmail) ^ runtimeType.hashCode;
}

extension $MailMigrationRequestExtension on MailMigrationRequest {
  MailMigrationRequest copyWith({String? newEmail}) {
    return MailMigrationRequest(newEmail: newEmail ?? this.newEmail);
  }

  MailMigrationRequest copyWithWrapped({Wrapped<String>? newEmail}) {
    return MailMigrationRequest(
        newEmail: (newEmail != null ? newEmail.value : this.newEmail));
  }
}

@JsonSerializable(explicitToJson: true)
class Manager {
  const Manager({
    required this.name,
    required this.groupId,
    required this.id,
  });

  factory Manager.fromJson(Map<String, dynamic> json) =>
      _$ManagerFromJson(json);

  static const toJsonFactory = _$ManagerToJson;
  Map<String, dynamic> toJson() => _$ManagerToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$ManagerFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Manager &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality()
                    .equals(other.groupId, groupId)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $ManagerExtension on Manager {
  Manager copyWith({String? name, String? groupId, String? id}) {
    return Manager(
        name: name ?? this.name,
        groupId: groupId ?? this.groupId,
        id: id ?? this.id);
  }

  Manager copyWithWrapped(
      {Wrapped<String>? name, Wrapped<String>? groupId, Wrapped<String>? id}) {
    return Manager(
        name: (name != null ? name.value : this.name),
        groupId: (groupId != null ? groupId.value : this.groupId),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class ManagerBase {
  const ManagerBase({
    required this.name,
    required this.groupId,
  });

  factory ManagerBase.fromJson(Map<String, dynamic> json) =>
      _$ManagerBaseFromJson(json);

  static const toJsonFactory = _$ManagerBaseToJson;
  Map<String, dynamic> toJson() => _$ManagerBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$ManagerBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ManagerBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupId) ^
      runtimeType.hashCode;
}

extension $ManagerBaseExtension on ManagerBase {
  ManagerBase copyWith({String? name, String? groupId}) {
    return ManagerBase(
        name: name ?? this.name, groupId: groupId ?? this.groupId);
  }

  ManagerBase copyWithWrapped(
      {Wrapped<String>? name, Wrapped<String>? groupId}) {
    return ManagerBase(
        name: (name != null ? name.value : this.name),
        groupId: (groupId != null ? groupId.value : this.groupId));
  }
}

@JsonSerializable(explicitToJson: true)
class ManagerUpdate {
  const ManagerUpdate({
    this.name,
    this.groupId,
  });

  factory ManagerUpdate.fromJson(Map<String, dynamic> json) =>
      _$ManagerUpdateFromJson(json);

  static const toJsonFactory = _$ManagerUpdateToJson;
  Map<String, dynamic> toJson() => _$ManagerUpdateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String? groupId;
  static const fromJsonFactory = _$ManagerUpdateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ManagerUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupId) ^
      runtimeType.hashCode;
}

extension $ManagerUpdateExtension on ManagerUpdate {
  ManagerUpdate copyWith({String? name, String? groupId}) {
    return ManagerUpdate(
        name: name ?? this.name, groupId: groupId ?? this.groupId);
  }

  ManagerUpdate copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<String?>? groupId}) {
    return ManagerUpdate(
        name: (name != null ? name.value : this.name),
        groupId: (groupId != null ? groupId.value : this.groupId));
  }
}

@JsonSerializable(explicitToJson: true)
class Message {
  const Message({
    required this.context,
    required this.isVisible,
    this.title,
    this.content,
    this.actionModule,
    this.actionTable,
    this.deliveryDatetime,
    required this.expireOn,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static const toJsonFactory = _$MessageToJson;
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @JsonKey(name: 'context', defaultValue: '')
  final String context;
  @JsonKey(name: 'is_visible', defaultValue: false)
  final bool isVisible;
  @JsonKey(name: 'title', defaultValue: '')
  final String? title;
  @JsonKey(name: 'content', defaultValue: '')
  final String? content;
  @JsonKey(name: 'action_module', defaultValue: '')
  final String? actionModule;
  @JsonKey(name: 'action_table', defaultValue: '')
  final String? actionTable;
  @JsonKey(name: 'delivery_datetime')
  final DateTime? deliveryDatetime;
  @JsonKey(name: 'expire_on', toJson: _dateToJson)
  final DateTime expireOn;
  static const fromJsonFactory = _$MessageFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Message &&
            (identical(other.context, context) ||
                const DeepCollectionEquality()
                    .equals(other.context, context)) &&
            (identical(other.isVisible, isVisible) ||
                const DeepCollectionEquality()
                    .equals(other.isVisible, isVisible)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.actionModule, actionModule) ||
                const DeepCollectionEquality()
                    .equals(other.actionModule, actionModule)) &&
            (identical(other.actionTable, actionTable) ||
                const DeepCollectionEquality()
                    .equals(other.actionTable, actionTable)) &&
            (identical(other.deliveryDatetime, deliveryDatetime) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryDatetime, deliveryDatetime)) &&
            (identical(other.expireOn, expireOn) ||
                const DeepCollectionEquality()
                    .equals(other.expireOn, expireOn)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(context) ^
      const DeepCollectionEquality().hash(isVisible) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(actionModule) ^
      const DeepCollectionEquality().hash(actionTable) ^
      const DeepCollectionEquality().hash(deliveryDatetime) ^
      const DeepCollectionEquality().hash(expireOn) ^
      runtimeType.hashCode;
}

extension $MessageExtension on Message {
  Message copyWith(
      {String? context,
      bool? isVisible,
      String? title,
      String? content,
      String? actionModule,
      String? actionTable,
      DateTime? deliveryDatetime,
      DateTime? expireOn}) {
    return Message(
        context: context ?? this.context,
        isVisible: isVisible ?? this.isVisible,
        title: title ?? this.title,
        content: content ?? this.content,
        actionModule: actionModule ?? this.actionModule,
        actionTable: actionTable ?? this.actionTable,
        deliveryDatetime: deliveryDatetime ?? this.deliveryDatetime,
        expireOn: expireOn ?? this.expireOn);
  }

  Message copyWithWrapped(
      {Wrapped<String>? context,
      Wrapped<bool>? isVisible,
      Wrapped<String?>? title,
      Wrapped<String?>? content,
      Wrapped<String?>? actionModule,
      Wrapped<String?>? actionTable,
      Wrapped<DateTime?>? deliveryDatetime,
      Wrapped<DateTime>? expireOn}) {
    return Message(
        context: (context != null ? context.value : this.context),
        isVisible: (isVisible != null ? isVisible.value : this.isVisible),
        title: (title != null ? title.value : this.title),
        content: (content != null ? content.value : this.content),
        actionModule:
            (actionModule != null ? actionModule.value : this.actionModule),
        actionTable:
            (actionTable != null ? actionTable.value : this.actionTable),
        deliveryDatetime: (deliveryDatetime != null
            ? deliveryDatetime.value
            : this.deliveryDatetime),
        expireOn: (expireOn != null ? expireOn.value : this.expireOn));
  }
}

@JsonSerializable(explicitToJson: true)
class ModuleVisibility {
  const ModuleVisibility({
    required this.root,
    required this.allowedGroupIds,
  });

  factory ModuleVisibility.fromJson(Map<String, dynamic> json) =>
      _$ModuleVisibilityFromJson(json);

  static const toJsonFactory = _$ModuleVisibilityToJson;
  Map<String, dynamic> toJson() => _$ModuleVisibilityToJson(this);

  @JsonKey(name: 'root', defaultValue: '')
  final String root;
  @JsonKey(name: 'allowed_group_ids', defaultValue: <String>[])
  final List<String> allowedGroupIds;
  static const fromJsonFactory = _$ModuleVisibilityFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModuleVisibility &&
            (identical(other.root, root) ||
                const DeepCollectionEquality().equals(other.root, root)) &&
            (identical(other.allowedGroupIds, allowedGroupIds) ||
                const DeepCollectionEquality()
                    .equals(other.allowedGroupIds, allowedGroupIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(root) ^
      const DeepCollectionEquality().hash(allowedGroupIds) ^
      runtimeType.hashCode;
}

extension $ModuleVisibilityExtension on ModuleVisibility {
  ModuleVisibility copyWith({String? root, List<String>? allowedGroupIds}) {
    return ModuleVisibility(
        root: root ?? this.root,
        allowedGroupIds: allowedGroupIds ?? this.allowedGroupIds);
  }

  ModuleVisibility copyWithWrapped(
      {Wrapped<String>? root, Wrapped<List<String>>? allowedGroupIds}) {
    return ModuleVisibility(
        root: (root != null ? root.value : this.root),
        allowedGroupIds: (allowedGroupIds != null
            ? allowedGroupIds.value
            : this.allowedGroupIds));
  }
}

@JsonSerializable(explicitToJson: true)
class ModuleVisibilityCreate {
  const ModuleVisibilityCreate({
    required this.root,
    required this.allowedGroupId,
  });

  factory ModuleVisibilityCreate.fromJson(Map<String, dynamic> json) =>
      _$ModuleVisibilityCreateFromJson(json);

  static const toJsonFactory = _$ModuleVisibilityCreateToJson;
  Map<String, dynamic> toJson() => _$ModuleVisibilityCreateToJson(this);

  @JsonKey(name: 'root', defaultValue: '')
  final String root;
  @JsonKey(name: 'allowed_group_id', defaultValue: '')
  final String allowedGroupId;
  static const fromJsonFactory = _$ModuleVisibilityCreateFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModuleVisibilityCreate &&
            (identical(other.root, root) ||
                const DeepCollectionEquality().equals(other.root, root)) &&
            (identical(other.allowedGroupId, allowedGroupId) ||
                const DeepCollectionEquality()
                    .equals(other.allowedGroupId, allowedGroupId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(root) ^
      const DeepCollectionEquality().hash(allowedGroupId) ^
      runtimeType.hashCode;
}

extension $ModuleVisibilityCreateExtension on ModuleVisibilityCreate {
  ModuleVisibilityCreate copyWith({String? root, String? allowedGroupId}) {
    return ModuleVisibilityCreate(
        root: root ?? this.root,
        allowedGroupId: allowedGroupId ?? this.allowedGroupId);
  }

  ModuleVisibilityCreate copyWithWrapped(
      {Wrapped<String>? root, Wrapped<String>? allowedGroupId}) {
    return ModuleVisibilityCreate(
        root: (root != null ? root.value : this.root),
        allowedGroupId: (allowedGroupId != null
            ? allowedGroupId.value
            : this.allowedGroupId));
  }
}

@JsonSerializable(explicitToJson: true)
class OrderBase {
  const OrderBase({
    required this.userId,
    required this.deliveryId,
    required this.productsIds,
    required this.collectionSlot,
    required this.productsQuantity,
  });

  factory OrderBase.fromJson(Map<String, dynamic> json) =>
      _$OrderBaseFromJson(json);

  static const toJsonFactory = _$OrderBaseToJson;
  Map<String, dynamic> toJson() => _$OrderBaseToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'delivery_id', defaultValue: '')
  final String deliveryId;
  @JsonKey(name: 'products_ids', defaultValue: <String>[])
  final List<String> productsIds;
  @JsonKey(
    name: 'collection_slot',
    toJson: amapSlotTypeToJson,
    fromJson: amapSlotTypeFromJson,
  )
  final enums.AmapSlotType collectionSlot;
  @JsonKey(name: 'products_quantity', defaultValue: <int>[])
  final List<int> productsQuantity;
  static const fromJsonFactory = _$OrderBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderBase &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.deliveryId, deliveryId) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryId, deliveryId)) &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality()
                    .equals(other.productsIds, productsIds)) &&
            (identical(other.collectionSlot, collectionSlot) ||
                const DeepCollectionEquality()
                    .equals(other.collectionSlot, collectionSlot)) &&
            (identical(other.productsQuantity, productsQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.productsQuantity, productsQuantity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(deliveryId) ^
      const DeepCollectionEquality().hash(productsIds) ^
      const DeepCollectionEquality().hash(collectionSlot) ^
      const DeepCollectionEquality().hash(productsQuantity) ^
      runtimeType.hashCode;
}

extension $OrderBaseExtension on OrderBase {
  OrderBase copyWith(
      {String? userId,
      String? deliveryId,
      List<String>? productsIds,
      enums.AmapSlotType? collectionSlot,
      List<int>? productsQuantity}) {
    return OrderBase(
        userId: userId ?? this.userId,
        deliveryId: deliveryId ?? this.deliveryId,
        productsIds: productsIds ?? this.productsIds,
        collectionSlot: collectionSlot ?? this.collectionSlot,
        productsQuantity: productsQuantity ?? this.productsQuantity);
  }

  OrderBase copyWithWrapped(
      {Wrapped<String>? userId,
      Wrapped<String>? deliveryId,
      Wrapped<List<String>>? productsIds,
      Wrapped<enums.AmapSlotType>? collectionSlot,
      Wrapped<List<int>>? productsQuantity}) {
    return OrderBase(
        userId: (userId != null ? userId.value : this.userId),
        deliveryId: (deliveryId != null ? deliveryId.value : this.deliveryId),
        productsIds:
            (productsIds != null ? productsIds.value : this.productsIds),
        collectionSlot: (collectionSlot != null
            ? collectionSlot.value
            : this.collectionSlot),
        productsQuantity: (productsQuantity != null
            ? productsQuantity.value
            : this.productsQuantity));
  }
}

@JsonSerializable(explicitToJson: true)
class OrderEdit {
  const OrderEdit({
    this.productsIds,
    this.collectionSlot,
    this.productsQuantity,
  });

  factory OrderEdit.fromJson(Map<String, dynamic> json) =>
      _$OrderEditFromJson(json);

  static const toJsonFactory = _$OrderEditToJson;
  Map<String, dynamic> toJson() => _$OrderEditToJson(this);

  @JsonKey(name: 'products_ids', defaultValue: <String>[])
  final List<String>? productsIds;
  @JsonKey(
    name: 'collection_slot',
    toJson: amapSlotTypeNullableToJson,
    fromJson: amapSlotTypeNullableFromJson,
  )
  final enums.AmapSlotType? collectionSlot;
  @JsonKey(name: 'products_quantity', defaultValue: <int>[])
  final List<int>? productsQuantity;
  static const fromJsonFactory = _$OrderEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderEdit &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality()
                    .equals(other.productsIds, productsIds)) &&
            (identical(other.collectionSlot, collectionSlot) ||
                const DeepCollectionEquality()
                    .equals(other.collectionSlot, collectionSlot)) &&
            (identical(other.productsQuantity, productsQuantity) ||
                const DeepCollectionEquality()
                    .equals(other.productsQuantity, productsQuantity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(productsIds) ^
      const DeepCollectionEquality().hash(collectionSlot) ^
      const DeepCollectionEquality().hash(productsQuantity) ^
      runtimeType.hashCode;
}

extension $OrderEditExtension on OrderEdit {
  OrderEdit copyWith(
      {List<String>? productsIds,
      enums.AmapSlotType? collectionSlot,
      List<int>? productsQuantity}) {
    return OrderEdit(
        productsIds: productsIds ?? this.productsIds,
        collectionSlot: collectionSlot ?? this.collectionSlot,
        productsQuantity: productsQuantity ?? this.productsQuantity);
  }

  OrderEdit copyWithWrapped(
      {Wrapped<List<String>?>? productsIds,
      Wrapped<enums.AmapSlotType?>? collectionSlot,
      Wrapped<List<int>?>? productsQuantity}) {
    return OrderEdit(
        productsIds:
            (productsIds != null ? productsIds.value : this.productsIds),
        collectionSlot: (collectionSlot != null
            ? collectionSlot.value
            : this.collectionSlot),
        productsQuantity: (productsQuantity != null
            ? productsQuantity.value
            : this.productsQuantity));
  }
}

@JsonSerializable(explicitToJson: true)
class OrderReturn {
  const OrderReturn({
    required this.user,
    required this.deliveryId,
    required this.productsdetail,
    required this.collectionSlot,
    required this.orderId,
    required this.amount,
    required this.orderingDate,
    required this.deliveryDate,
  });

  factory OrderReturn.fromJson(Map<String, dynamic> json) =>
      _$OrderReturnFromJson(json);

  static const toJsonFactory = _$OrderReturnToJson;
  Map<String, dynamic> toJson() => _$OrderReturnToJson(this);

  @JsonKey(name: 'user')
  final CoreUserSimple user;
  @JsonKey(name: 'delivery_id', defaultValue: '')
  final String deliveryId;
  @JsonKey(name: 'productsdetail', defaultValue: <ProductQuantity>[])
  final List<ProductQuantity> productsdetail;
  @JsonKey(
    name: 'collection_slot',
    toJson: amapSlotTypeToJson,
    fromJson: amapSlotTypeFromJson,
  )
  final enums.AmapSlotType collectionSlot;
  @JsonKey(name: 'order_id', defaultValue: '')
  final String orderId;
  @JsonKey(name: 'amount', defaultValue: 0.0)
  final double amount;
  @JsonKey(name: 'ordering_date')
  final DateTime orderingDate;
  @JsonKey(name: 'delivery_date', toJson: _dateToJson)
  final DateTime deliveryDate;
  static const fromJsonFactory = _$OrderReturnFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is OrderReturn &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.deliveryId, deliveryId) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryId, deliveryId)) &&
            (identical(other.productsdetail, productsdetail) ||
                const DeepCollectionEquality()
                    .equals(other.productsdetail, productsdetail)) &&
            (identical(other.collectionSlot, collectionSlot) ||
                const DeepCollectionEquality()
                    .equals(other.collectionSlot, collectionSlot)) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality()
                    .equals(other.orderId, orderId)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.orderingDate, orderingDate) ||
                const DeepCollectionEquality()
                    .equals(other.orderingDate, orderingDate)) &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality()
                    .equals(other.deliveryDate, deliveryDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(deliveryId) ^
      const DeepCollectionEquality().hash(productsdetail) ^
      const DeepCollectionEquality().hash(collectionSlot) ^
      const DeepCollectionEquality().hash(orderId) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(orderingDate) ^
      const DeepCollectionEquality().hash(deliveryDate) ^
      runtimeType.hashCode;
}

extension $OrderReturnExtension on OrderReturn {
  OrderReturn copyWith(
      {CoreUserSimple? user,
      String? deliveryId,
      List<ProductQuantity>? productsdetail,
      enums.AmapSlotType? collectionSlot,
      String? orderId,
      double? amount,
      DateTime? orderingDate,
      DateTime? deliveryDate}) {
    return OrderReturn(
        user: user ?? this.user,
        deliveryId: deliveryId ?? this.deliveryId,
        productsdetail: productsdetail ?? this.productsdetail,
        collectionSlot: collectionSlot ?? this.collectionSlot,
        orderId: orderId ?? this.orderId,
        amount: amount ?? this.amount,
        orderingDate: orderingDate ?? this.orderingDate,
        deliveryDate: deliveryDate ?? this.deliveryDate);
  }

  OrderReturn copyWithWrapped(
      {Wrapped<CoreUserSimple>? user,
      Wrapped<String>? deliveryId,
      Wrapped<List<ProductQuantity>>? productsdetail,
      Wrapped<enums.AmapSlotType>? collectionSlot,
      Wrapped<String>? orderId,
      Wrapped<double>? amount,
      Wrapped<DateTime>? orderingDate,
      Wrapped<DateTime>? deliveryDate}) {
    return OrderReturn(
        user: (user != null ? user.value : this.user),
        deliveryId: (deliveryId != null ? deliveryId.value : this.deliveryId),
        productsdetail: (productsdetail != null
            ? productsdetail.value
            : this.productsdetail),
        collectionSlot: (collectionSlot != null
            ? collectionSlot.value
            : this.collectionSlot),
        orderId: (orderId != null ? orderId.value : this.orderId),
        amount: (amount != null ? amount.value : this.amount),
        orderingDate:
            (orderingDate != null ? orderingDate.value : this.orderingDate),
        deliveryDate:
            (deliveryDate != null ? deliveryDate.value : this.deliveryDate));
  }
}

@JsonSerializable(explicitToJson: true)
class PackTicketBase {
  const PackTicketBase({
    required this.price,
    required this.packSize,
    required this.raffleId,
  });

  factory PackTicketBase.fromJson(Map<String, dynamic> json) =>
      _$PackTicketBaseFromJson(json);

  static const toJsonFactory = _$PackTicketBaseToJson;
  Map<String, dynamic> toJson() => _$PackTicketBaseToJson(this);

  @JsonKey(name: 'price', defaultValue: 0.0)
  final double price;
  @JsonKey(name: 'pack_size', defaultValue: 0)
  final int packSize;
  @JsonKey(name: 'raffle_id', defaultValue: '')
  final String raffleId;
  static const fromJsonFactory = _$PackTicketBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PackTicketBase &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.packSize, packSize) ||
                const DeepCollectionEquality()
                    .equals(other.packSize, packSize)) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality()
                    .equals(other.raffleId, raffleId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(packSize) ^
      const DeepCollectionEquality().hash(raffleId) ^
      runtimeType.hashCode;
}

extension $PackTicketBaseExtension on PackTicketBase {
  PackTicketBase copyWith({double? price, int? packSize, String? raffleId}) {
    return PackTicketBase(
        price: price ?? this.price,
        packSize: packSize ?? this.packSize,
        raffleId: raffleId ?? this.raffleId);
  }

  PackTicketBase copyWithWrapped(
      {Wrapped<double>? price,
      Wrapped<int>? packSize,
      Wrapped<String>? raffleId}) {
    return PackTicketBase(
        price: (price != null ? price.value : this.price),
        packSize: (packSize != null ? packSize.value : this.packSize),
        raffleId: (raffleId != null ? raffleId.value : this.raffleId));
  }
}

@JsonSerializable(explicitToJson: true)
class PackTicketEdit {
  const PackTicketEdit({
    this.raffleId,
    this.price,
    this.packSize,
  });

  factory PackTicketEdit.fromJson(Map<String, dynamic> json) =>
      _$PackTicketEditFromJson(json);

  static const toJsonFactory = _$PackTicketEditToJson;
  Map<String, dynamic> toJson() => _$PackTicketEditToJson(this);

  @JsonKey(name: 'raffle_id', defaultValue: '')
  final String? raffleId;
  @JsonKey(name: 'price', defaultValue: 0.0)
  final double? price;
  @JsonKey(name: 'pack_size', defaultValue: 0)
  final int? packSize;
  static const fromJsonFactory = _$PackTicketEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PackTicketEdit &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality()
                    .equals(other.raffleId, raffleId)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.packSize, packSize) ||
                const DeepCollectionEquality()
                    .equals(other.packSize, packSize)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(raffleId) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(packSize) ^
      runtimeType.hashCode;
}

extension $PackTicketEditExtension on PackTicketEdit {
  PackTicketEdit copyWith({String? raffleId, double? price, int? packSize}) {
    return PackTicketEdit(
        raffleId: raffleId ?? this.raffleId,
        price: price ?? this.price,
        packSize: packSize ?? this.packSize);
  }

  PackTicketEdit copyWithWrapped(
      {Wrapped<String?>? raffleId,
      Wrapped<double?>? price,
      Wrapped<int?>? packSize}) {
    return PackTicketEdit(
        raffleId: (raffleId != null ? raffleId.value : this.raffleId),
        price: (price != null ? price.value : this.price),
        packSize: (packSize != null ? packSize.value : this.packSize));
  }
}

@JsonSerializable(explicitToJson: true)
class PackTicketSimple {
  const PackTicketSimple({
    required this.price,
    required this.packSize,
    required this.raffleId,
    required this.id,
  });

  factory PackTicketSimple.fromJson(Map<String, dynamic> json) =>
      _$PackTicketSimpleFromJson(json);

  static const toJsonFactory = _$PackTicketSimpleToJson;
  Map<String, dynamic> toJson() => _$PackTicketSimpleToJson(this);

  @JsonKey(name: 'price', defaultValue: 0.0)
  final double price;
  @JsonKey(name: 'pack_size', defaultValue: 0)
  final int packSize;
  @JsonKey(name: 'raffle_id', defaultValue: '')
  final String raffleId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$PackTicketSimpleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PackTicketSimple &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.packSize, packSize) ||
                const DeepCollectionEquality()
                    .equals(other.packSize, packSize)) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality()
                    .equals(other.raffleId, raffleId)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(packSize) ^
      const DeepCollectionEquality().hash(raffleId) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $PackTicketSimpleExtension on PackTicketSimple {
  PackTicketSimple copyWith(
      {double? price, int? packSize, String? raffleId, String? id}) {
    return PackTicketSimple(
        price: price ?? this.price,
        packSize: packSize ?? this.packSize,
        raffleId: raffleId ?? this.raffleId,
        id: id ?? this.id);
  }

  PackTicketSimple copyWithWrapped(
      {Wrapped<double>? price,
      Wrapped<int>? packSize,
      Wrapped<String>? raffleId,
      Wrapped<String>? id}) {
    return PackTicketSimple(
        price: (price != null ? price.value : this.price),
        packSize: (packSize != null ? packSize.value : this.packSize),
        raffleId: (raffleId != null ? raffleId.value : this.raffleId),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class PrizeBase {
  const PrizeBase({
    required this.name,
    required this.description,
    required this.raffleId,
    required this.quantity,
  });

  factory PrizeBase.fromJson(Map<String, dynamic> json) =>
      _$PrizeBaseFromJson(json);

  static const toJsonFactory = _$PrizeBaseToJson;
  Map<String, dynamic> toJson() => _$PrizeBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'raffle_id', defaultValue: '')
  final String raffleId;
  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  static const fromJsonFactory = _$PrizeBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrizeBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality()
                    .equals(other.raffleId, raffleId)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(raffleId) ^
      const DeepCollectionEquality().hash(quantity) ^
      runtimeType.hashCode;
}

extension $PrizeBaseExtension on PrizeBase {
  PrizeBase copyWith(
      {String? name, String? description, String? raffleId, int? quantity}) {
    return PrizeBase(
        name: name ?? this.name,
        description: description ?? this.description,
        raffleId: raffleId ?? this.raffleId,
        quantity: quantity ?? this.quantity);
  }

  PrizeBase copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<String>? raffleId,
      Wrapped<int>? quantity}) {
    return PrizeBase(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        raffleId: (raffleId != null ? raffleId.value : this.raffleId),
        quantity: (quantity != null ? quantity.value : this.quantity));
  }
}

@JsonSerializable(explicitToJson: true)
class PrizeEdit {
  const PrizeEdit({
    this.raffleId,
    this.description,
    this.name,
    this.quantity,
  });

  factory PrizeEdit.fromJson(Map<String, dynamic> json) =>
      _$PrizeEditFromJson(json);

  static const toJsonFactory = _$PrizeEditToJson;
  Map<String, dynamic> toJson() => _$PrizeEditToJson(this);

  @JsonKey(name: 'raffle_id', defaultValue: '')
  final String? raffleId;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'quantity', defaultValue: 0)
  final int? quantity;
  static const fromJsonFactory = _$PrizeEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrizeEdit &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality()
                    .equals(other.raffleId, raffleId)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(raffleId) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(quantity) ^
      runtimeType.hashCode;
}

extension $PrizeEditExtension on PrizeEdit {
  PrizeEdit copyWith(
      {String? raffleId, String? description, String? name, int? quantity}) {
    return PrizeEdit(
        raffleId: raffleId ?? this.raffleId,
        description: description ?? this.description,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity);
  }

  PrizeEdit copyWithWrapped(
      {Wrapped<String?>? raffleId,
      Wrapped<String?>? description,
      Wrapped<String?>? name,
      Wrapped<int?>? quantity}) {
    return PrizeEdit(
        raffleId: (raffleId != null ? raffleId.value : this.raffleId),
        description:
            (description != null ? description.value : this.description),
        name: (name != null ? name.value : this.name),
        quantity: (quantity != null ? quantity.value : this.quantity));
  }
}

@JsonSerializable(explicitToJson: true)
class PrizeSimple {
  const PrizeSimple({
    required this.name,
    required this.description,
    required this.raffleId,
    required this.quantity,
    required this.id,
  });

  factory PrizeSimple.fromJson(Map<String, dynamic> json) =>
      _$PrizeSimpleFromJson(json);

  static const toJsonFactory = _$PrizeSimpleToJson;
  Map<String, dynamic> toJson() => _$PrizeSimpleToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'raffle_id', defaultValue: '')
  final String raffleId;
  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$PrizeSimpleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PrizeSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality()
                    .equals(other.raffleId, raffleId)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(raffleId) ^
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $PrizeSimpleExtension on PrizeSimple {
  PrizeSimple copyWith(
      {String? name,
      String? description,
      String? raffleId,
      int? quantity,
      String? id}) {
    return PrizeSimple(
        name: name ?? this.name,
        description: description ?? this.description,
        raffleId: raffleId ?? this.raffleId,
        quantity: quantity ?? this.quantity,
        id: id ?? this.id);
  }

  PrizeSimple copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<String>? raffleId,
      Wrapped<int>? quantity,
      Wrapped<String>? id}) {
    return PrizeSimple(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        raffleId: (raffleId != null ? raffleId.value : this.raffleId),
        quantity: (quantity != null ? quantity.value : this.quantity),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class ProductComplete {
  const ProductComplete({
    required this.name,
    required this.price,
    required this.category,
    required this.id,
  });

  factory ProductComplete.fromJson(Map<String, dynamic> json) =>
      _$ProductCompleteFromJson(json);

  static const toJsonFactory = _$ProductCompleteToJson;
  Map<String, dynamic> toJson() => _$ProductCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'price', defaultValue: 0.0)
  final double price;
  @JsonKey(name: 'category', defaultValue: '')
  final String category;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$ProductCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProductComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $ProductCompleteExtension on ProductComplete {
  ProductComplete copyWith(
      {String? name, double? price, String? category, String? id}) {
    return ProductComplete(
        name: name ?? this.name,
        price: price ?? this.price,
        category: category ?? this.category,
        id: id ?? this.id);
  }

  ProductComplete copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<double>? price,
      Wrapped<String>? category,
      Wrapped<String>? id}) {
    return ProductComplete(
        name: (name != null ? name.value : this.name),
        price: (price != null ? price.value : this.price),
        category: (category != null ? category.value : this.category),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class ProductEdit {
  const ProductEdit({
    this.category,
    this.name,
    this.price,
  });

  factory ProductEdit.fromJson(Map<String, dynamic> json) =>
      _$ProductEditFromJson(json);

  static const toJsonFactory = _$ProductEditToJson;
  Map<String, dynamic> toJson() => _$ProductEditToJson(this);

  @JsonKey(name: 'category', defaultValue: '')
  final String? category;
  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'price', defaultValue: 0.0)
  final double? price;
  static const fromJsonFactory = _$ProductEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProductEdit &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(price) ^
      runtimeType.hashCode;
}

extension $ProductEditExtension on ProductEdit {
  ProductEdit copyWith({String? category, String? name, double? price}) {
    return ProductEdit(
        category: category ?? this.category,
        name: name ?? this.name,
        price: price ?? this.price);
  }

  ProductEdit copyWithWrapped(
      {Wrapped<String?>? category,
      Wrapped<String?>? name,
      Wrapped<double?>? price}) {
    return ProductEdit(
        category: (category != null ? category.value : this.category),
        name: (name != null ? name.value : this.name),
        price: (price != null ? price.value : this.price));
  }
}

@JsonSerializable(explicitToJson: true)
class ProductQuantity {
  const ProductQuantity({
    required this.quantity,
    required this.product,
  });

  factory ProductQuantity.fromJson(Map<String, dynamic> json) =>
      _$ProductQuantityFromJson(json);

  static const toJsonFactory = _$ProductQuantityToJson;
  Map<String, dynamic> toJson() => _$ProductQuantityToJson(this);

  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  @JsonKey(name: 'product')
  final ProductComplete product;
  static const fromJsonFactory = _$ProductQuantityFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProductQuantity &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)) &&
            (identical(other.product, product) ||
                const DeepCollectionEquality().equals(other.product, product)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(product) ^
      runtimeType.hashCode;
}

extension $ProductQuantityExtension on ProductQuantity {
  ProductQuantity copyWith({int? quantity, ProductComplete? product}) {
    return ProductQuantity(
        quantity: quantity ?? this.quantity, product: product ?? this.product);
  }

  ProductQuantity copyWithWrapped(
      {Wrapped<int>? quantity, Wrapped<ProductComplete>? product}) {
    return ProductQuantity(
        quantity: (quantity != null ? quantity.value : this.quantity),
        product: (product != null ? product.value : this.product));
  }
}

@JsonSerializable(explicitToJson: true)
class ProductSimple {
  const ProductSimple({
    required this.name,
    required this.price,
    required this.category,
  });

  factory ProductSimple.fromJson(Map<String, dynamic> json) =>
      _$ProductSimpleFromJson(json);

  static const toJsonFactory = _$ProductSimpleToJson;
  Map<String, dynamic> toJson() => _$ProductSimpleToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'price', defaultValue: 0.0)
  final double price;
  @JsonKey(name: 'category', defaultValue: '')
  final String category;
  static const fromJsonFactory = _$ProductSimpleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ProductSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(category) ^
      runtimeType.hashCode;
}

extension $ProductSimpleExtension on ProductSimple {
  ProductSimple copyWith({String? name, double? price, String? category}) {
    return ProductSimple(
        name: name ?? this.name,
        price: price ?? this.price,
        category: category ?? this.category);
  }

  ProductSimple copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<double>? price,
      Wrapped<String>? category}) {
    return ProductSimple(
        name: (name != null ? name.value : this.name),
        price: (price != null ? price.value : this.price),
        category: (category != null ? category.value : this.category));
  }
}

@JsonSerializable(explicitToJson: true)
class RaffleBase {
  const RaffleBase({
    required this.name,
    this.status,
    this.description,
    required this.groupId,
  });

  factory RaffleBase.fromJson(Map<String, dynamic> json) =>
      _$RaffleBaseFromJson(json);

  static const toJsonFactory = _$RaffleBaseToJson;
  Map<String, dynamic> toJson() => _$RaffleBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(
    name: 'status',
    toJson: raffleStatusTypeNullableToJson,
    fromJson: raffleStatusTypeNullableFromJson,
  )
  final enums.RaffleStatusType? status;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$RaffleBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RaffleBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(groupId) ^
      runtimeType.hashCode;
}

extension $RaffleBaseExtension on RaffleBase {
  RaffleBase copyWith(
      {String? name,
      enums.RaffleStatusType? status,
      String? description,
      String? groupId}) {
    return RaffleBase(
        name: name ?? this.name,
        status: status ?? this.status,
        description: description ?? this.description,
        groupId: groupId ?? this.groupId);
  }

  RaffleBase copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<enums.RaffleStatusType?>? status,
      Wrapped<String?>? description,
      Wrapped<String>? groupId}) {
    return RaffleBase(
        name: (name != null ? name.value : this.name),
        status: (status != null ? status.value : this.status),
        description:
            (description != null ? description.value : this.description),
        groupId: (groupId != null ? groupId.value : this.groupId));
  }
}

@JsonSerializable(explicitToJson: true)
class RaffleComplete {
  const RaffleComplete({
    required this.name,
    this.status,
    this.description,
    required this.groupId,
    required this.id,
  });

  factory RaffleComplete.fromJson(Map<String, dynamic> json) =>
      _$RaffleCompleteFromJson(json);

  static const toJsonFactory = _$RaffleCompleteToJson;
  Map<String, dynamic> toJson() => _$RaffleCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(
    name: 'status',
    toJson: raffleStatusTypeNullableToJson,
    fromJson: raffleStatusTypeNullableFromJson,
  )
  final enums.RaffleStatusType? status;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$RaffleCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RaffleComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality()
                    .equals(other.groupId, groupId)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $RaffleCompleteExtension on RaffleComplete {
  RaffleComplete copyWith(
      {String? name,
      enums.RaffleStatusType? status,
      String? description,
      String? groupId,
      String? id}) {
    return RaffleComplete(
        name: name ?? this.name,
        status: status ?? this.status,
        description: description ?? this.description,
        groupId: groupId ?? this.groupId,
        id: id ?? this.id);
  }

  RaffleComplete copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<enums.RaffleStatusType?>? status,
      Wrapped<String?>? description,
      Wrapped<String>? groupId,
      Wrapped<String>? id}) {
    return RaffleComplete(
        name: (name != null ? name.value : this.name),
        status: (status != null ? status.value : this.status),
        description:
            (description != null ? description.value : this.description),
        groupId: (groupId != null ? groupId.value : this.groupId),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class RaffleEdit {
  const RaffleEdit({
    this.name,
    this.description,
  });

  factory RaffleEdit.fromJson(Map<String, dynamic> json) =>
      _$RaffleEditFromJson(json);

  static const toJsonFactory = _$RaffleEditToJson;
  Map<String, dynamic> toJson() => _$RaffleEditToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  static const fromJsonFactory = _$RaffleEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RaffleEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $RaffleEditExtension on RaffleEdit {
  RaffleEdit copyWith({String? name, String? description}) {
    return RaffleEdit(
        name: name ?? this.name, description: description ?? this.description);
  }

  RaffleEdit copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<String?>? description}) {
    return RaffleEdit(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class RaffleStats {
  const RaffleStats({
    required this.ticketsSold,
    required this.amountRaised,
  });

  factory RaffleStats.fromJson(Map<String, dynamic> json) =>
      _$RaffleStatsFromJson(json);

  static const toJsonFactory = _$RaffleStatsToJson;
  Map<String, dynamic> toJson() => _$RaffleStatsToJson(this);

  @JsonKey(name: 'tickets_sold', defaultValue: 0)
  final int ticketsSold;
  @JsonKey(name: 'amount_raised', defaultValue: 0.0)
  final double amountRaised;
  static const fromJsonFactory = _$RaffleStatsFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RaffleStats &&
            (identical(other.ticketsSold, ticketsSold) ||
                const DeepCollectionEquality()
                    .equals(other.ticketsSold, ticketsSold)) &&
            (identical(other.amountRaised, amountRaised) ||
                const DeepCollectionEquality()
                    .equals(other.amountRaised, amountRaised)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ticketsSold) ^
      const DeepCollectionEquality().hash(amountRaised) ^
      runtimeType.hashCode;
}

extension $RaffleStatsExtension on RaffleStats {
  RaffleStats copyWith({int? ticketsSold, double? amountRaised}) {
    return RaffleStats(
        ticketsSold: ticketsSold ?? this.ticketsSold,
        amountRaised: amountRaised ?? this.amountRaised);
  }

  RaffleStats copyWithWrapped(
      {Wrapped<int>? ticketsSold, Wrapped<double>? amountRaised}) {
    return RaffleStats(
        ticketsSold:
            (ticketsSold != null ? ticketsSold.value : this.ticketsSold),
        amountRaised:
            (amountRaised != null ? amountRaised.value : this.amountRaised));
  }
}

@JsonSerializable(explicitToJson: true)
class ResetPasswordRequest {
  const ResetPasswordRequest({
    required this.resetToken,
    required this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  static const toJsonFactory = _$ResetPasswordRequestToJson;
  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

  @JsonKey(name: 'reset_token', defaultValue: '')
  final String resetToken;
  @JsonKey(name: 'new_password', defaultValue: '')
  final String newPassword;
  static const fromJsonFactory = _$ResetPasswordRequestFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ResetPasswordRequest &&
            (identical(other.resetToken, resetToken) ||
                const DeepCollectionEquality()
                    .equals(other.resetToken, resetToken)) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality()
                    .equals(other.newPassword, newPassword)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(resetToken) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $ResetPasswordRequestExtension on ResetPasswordRequest {
  ResetPasswordRequest copyWith({String? resetToken, String? newPassword}) {
    return ResetPasswordRequest(
        resetToken: resetToken ?? this.resetToken,
        newPassword: newPassword ?? this.newPassword);
  }

  ResetPasswordRequest copyWithWrapped(
      {Wrapped<String>? resetToken, Wrapped<String>? newPassword}) {
    return ResetPasswordRequest(
        resetToken: (resetToken != null ? resetToken.value : this.resetToken),
        newPassword:
            (newPassword != null ? newPassword.value : this.newPassword));
  }
}

@JsonSerializable(explicitToJson: true)
class RoomBase {
  const RoomBase({
    required this.name,
    required this.managerId,
  });

  factory RoomBase.fromJson(Map<String, dynamic> json) =>
      _$RoomBaseFromJson(json);

  static const toJsonFactory = _$RoomBaseToJson;
  Map<String, dynamic> toJson() => _$RoomBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'manager_id', defaultValue: '')
  final String managerId;
  static const fromJsonFactory = _$RoomBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RoomBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.managerId, managerId) ||
                const DeepCollectionEquality()
                    .equals(other.managerId, managerId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(managerId) ^
      runtimeType.hashCode;
}

extension $RoomBaseExtension on RoomBase {
  RoomBase copyWith({String? name, String? managerId}) {
    return RoomBase(
        name: name ?? this.name, managerId: managerId ?? this.managerId);
  }

  RoomBase copyWithWrapped(
      {Wrapped<String>? name, Wrapped<String>? managerId}) {
    return RoomBase(
        name: (name != null ? name.value : this.name),
        managerId: (managerId != null ? managerId.value : this.managerId));
  }
}

@JsonSerializable(explicitToJson: true)
class RoomComplete {
  const RoomComplete({
    required this.name,
    required this.managerId,
    required this.id,
  });

  factory RoomComplete.fromJson(Map<String, dynamic> json) =>
      _$RoomCompleteFromJson(json);

  static const toJsonFactory = _$RoomCompleteToJson;
  Map<String, dynamic> toJson() => _$RoomCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'manager_id', defaultValue: '')
  final String managerId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$RoomCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RoomComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.managerId, managerId) ||
                const DeepCollectionEquality()
                    .equals(other.managerId, managerId)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(managerId) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $RoomCompleteExtension on RoomComplete {
  RoomComplete copyWith({String? name, String? managerId, String? id}) {
    return RoomComplete(
        name: name ?? this.name,
        managerId: managerId ?? this.managerId,
        id: id ?? this.id);
  }

  RoomComplete copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? managerId,
      Wrapped<String>? id}) {
    return RoomComplete(
        name: (name != null ? name.value : this.name),
        managerId: (managerId != null ? managerId.value : this.managerId),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class SectionBase {
  const SectionBase({
    required this.name,
    required this.description,
  });

  factory SectionBase.fromJson(Map<String, dynamic> json) =>
      _$SectionBaseFromJson(json);

  static const toJsonFactory = _$SectionBaseToJson;
  Map<String, dynamic> toJson() => _$SectionBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  static const fromJsonFactory = _$SectionBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SectionBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $SectionBaseExtension on SectionBase {
  SectionBase copyWith({String? name, String? description}) {
    return SectionBase(
        name: name ?? this.name, description: description ?? this.description);
  }

  SectionBase copyWithWrapped(
      {Wrapped<String>? name, Wrapped<String>? description}) {
    return SectionBase(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class SectionComplete {
  const SectionComplete({
    required this.name,
    required this.description,
    required this.id,
  });

  factory SectionComplete.fromJson(Map<String, dynamic> json) =>
      _$SectionCompleteFromJson(json);

  static const toJsonFactory = _$SectionCompleteToJson;
  Map<String, dynamic> toJson() => _$SectionCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$SectionCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SectionComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $SectionCompleteExtension on SectionComplete {
  SectionComplete copyWith({String? name, String? description, String? id}) {
    return SectionComplete(
        name: name ?? this.name,
        description: description ?? this.description,
        id: id ?? this.id);
  }

  SectionComplete copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<String>? id}) {
    return SectionComplete(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class TicketComplete {
  const TicketComplete({
    required this.packId,
    required this.userId,
    this.winningPrize,
    required this.id,
    this.prize,
    required this.packTicket,
    required this.user,
  });

  factory TicketComplete.fromJson(Map<String, dynamic> json) =>
      _$TicketCompleteFromJson(json);

  static const toJsonFactory = _$TicketCompleteToJson;
  Map<String, dynamic> toJson() => _$TicketCompleteToJson(this);

  @JsonKey(name: 'pack_id', defaultValue: '')
  final String packId;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'winning_prize', defaultValue: '')
  final String? winningPrize;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'prize')
  final PrizeSimple? prize;
  @JsonKey(name: 'pack_ticket')
  final PackTicketSimple packTicket;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  static const fromJsonFactory = _$TicketCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TicketComplete &&
            (identical(other.packId, packId) ||
                const DeepCollectionEquality().equals(other.packId, packId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.winningPrize, winningPrize) ||
                const DeepCollectionEquality()
                    .equals(other.winningPrize, winningPrize)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.prize, prize) ||
                const DeepCollectionEquality().equals(other.prize, prize)) &&
            (identical(other.packTicket, packTicket) ||
                const DeepCollectionEquality()
                    .equals(other.packTicket, packTicket)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(packId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(winningPrize) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(prize) ^
      const DeepCollectionEquality().hash(packTicket) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $TicketCompleteExtension on TicketComplete {
  TicketComplete copyWith(
      {String? packId,
      String? userId,
      String? winningPrize,
      String? id,
      PrizeSimple? prize,
      PackTicketSimple? packTicket,
      CoreUserSimple? user}) {
    return TicketComplete(
        packId: packId ?? this.packId,
        userId: userId ?? this.userId,
        winningPrize: winningPrize ?? this.winningPrize,
        id: id ?? this.id,
        prize: prize ?? this.prize,
        packTicket: packTicket ?? this.packTicket,
        user: user ?? this.user);
  }

  TicketComplete copyWithWrapped(
      {Wrapped<String>? packId,
      Wrapped<String>? userId,
      Wrapped<String?>? winningPrize,
      Wrapped<String>? id,
      Wrapped<PrizeSimple?>? prize,
      Wrapped<PackTicketSimple>? packTicket,
      Wrapped<CoreUserSimple>? user}) {
    return TicketComplete(
        packId: (packId != null ? packId.value : this.packId),
        userId: (userId != null ? userId.value : this.userId),
        winningPrize:
            (winningPrize != null ? winningPrize.value : this.winningPrize),
        id: (id != null ? id.value : this.id),
        prize: (prize != null ? prize.value : this.prize),
        packTicket: (packTicket != null ? packTicket.value : this.packTicket),
        user: (user != null ? user.value : this.user));
  }
}

@JsonSerializable(explicitToJson: true)
class TicketSimple {
  const TicketSimple({
    required this.packId,
    required this.userId,
    this.winningPrize,
    required this.id,
  });

  factory TicketSimple.fromJson(Map<String, dynamic> json) =>
      _$TicketSimpleFromJson(json);

  static const toJsonFactory = _$TicketSimpleToJson;
  Map<String, dynamic> toJson() => _$TicketSimpleToJson(this);

  @JsonKey(name: 'pack_id', defaultValue: '')
  final String packId;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'winning_prize', defaultValue: '')
  final String? winningPrize;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$TicketSimpleFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TicketSimple &&
            (identical(other.packId, packId) ||
                const DeepCollectionEquality().equals(other.packId, packId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.winningPrize, winningPrize) ||
                const DeepCollectionEquality()
                    .equals(other.winningPrize, winningPrize)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(packId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(winningPrize) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $TicketSimpleExtension on TicketSimple {
  TicketSimple copyWith(
      {String? packId, String? userId, String? winningPrize, String? id}) {
    return TicketSimple(
        packId: packId ?? this.packId,
        userId: userId ?? this.userId,
        winningPrize: winningPrize ?? this.winningPrize,
        id: id ?? this.id);
  }

  TicketSimple copyWithWrapped(
      {Wrapped<String>? packId,
      Wrapped<String>? userId,
      Wrapped<String?>? winningPrize,
      Wrapped<String>? id}) {
    return TicketSimple(
        packId: (packId != null ? packId.value : this.packId),
        userId: (userId != null ? userId.value : this.userId),
        winningPrize:
            (winningPrize != null ? winningPrize.value : this.winningPrize),
        id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class TokenResponse {
  const TokenResponse({
    required this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.scopes,
    required this.refreshToken,
    this.idToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  static const toJsonFactory = _$TokenResponseToJson;
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  @JsonKey(name: 'access_token', defaultValue: '')
  final String accessToken;
  @JsonKey(name: 'token_type', defaultValue: '')
  final String? tokenType;
  @JsonKey(name: 'expires_in', defaultValue: 0)
  final int? expiresIn;
  @JsonKey(name: 'scopes', defaultValue: '')
  final String? scopes;
  @JsonKey(name: 'refresh_token', defaultValue: '')
  final String refreshToken;
  @JsonKey(name: 'id_token', defaultValue: '')
  final String? idToken;
  static const fromJsonFactory = _$TokenResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenResponse &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality()
                    .equals(other.tokenType, tokenType)) &&
            (identical(other.expiresIn, expiresIn) ||
                const DeepCollectionEquality()
                    .equals(other.expiresIn, expiresIn)) &&
            (identical(other.scopes, scopes) ||
                const DeepCollectionEquality().equals(other.scopes, scopes)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.idToken, idToken) ||
                const DeepCollectionEquality().equals(other.idToken, idToken)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(tokenType) ^
      const DeepCollectionEquality().hash(expiresIn) ^
      const DeepCollectionEquality().hash(scopes) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(idToken) ^
      runtimeType.hashCode;
}

extension $TokenResponseExtension on TokenResponse {
  TokenResponse copyWith(
      {String? accessToken,
      String? tokenType,
      int? expiresIn,
      String? scopes,
      String? refreshToken,
      String? idToken}) {
    return TokenResponse(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        scopes: scopes ?? this.scopes,
        refreshToken: refreshToken ?? this.refreshToken,
        idToken: idToken ?? this.idToken);
  }

  TokenResponse copyWithWrapped(
      {Wrapped<String>? accessToken,
      Wrapped<String?>? tokenType,
      Wrapped<int?>? expiresIn,
      Wrapped<String?>? scopes,
      Wrapped<String>? refreshToken,
      Wrapped<String?>? idToken}) {
    return TokenResponse(
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        tokenType: (tokenType != null ? tokenType.value : this.tokenType),
        expiresIn: (expiresIn != null ? expiresIn.value : this.expiresIn),
        scopes: (scopes != null ? scopes.value : this.scopes),
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        idToken: (idToken != null ? idToken.value : this.idToken));
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationError {
  const ValidationError({
    required this.loc,
    required this.msg,
    required this.type,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);

  static const toJsonFactory = _$ValidationErrorToJson;
  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);

  @JsonKey(name: 'loc', defaultValue: <Object>[])
  final List<Object> loc;
  @JsonKey(name: 'msg', defaultValue: '')
  final String msg;
  @JsonKey(name: 'type', defaultValue: '')
  final String type;
  static const fromJsonFactory = _$ValidationErrorFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ValidationError &&
            (identical(other.loc, loc) ||
                const DeepCollectionEquality().equals(other.loc, loc)) &&
            (identical(other.msg, msg) ||
                const DeepCollectionEquality().equals(other.msg, msg)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(loc) ^
      const DeepCollectionEquality().hash(msg) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $ValidationErrorExtension on ValidationError {
  ValidationError copyWith({List<Object>? loc, String? msg, String? type}) {
    return ValidationError(
        loc: loc ?? this.loc, msg: msg ?? this.msg, type: type ?? this.type);
  }

  ValidationError copyWithWrapped(
      {Wrapped<List<Object>>? loc,
      Wrapped<String>? msg,
      Wrapped<String>? type}) {
    return ValidationError(
        loc: (loc != null ? loc.value : this.loc),
        msg: (msg != null ? msg.value : this.msg),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class VoteBase {
  const VoteBase({
    required this.listId,
  });

  factory VoteBase.fromJson(Map<String, dynamic> json) =>
      _$VoteBaseFromJson(json);

  static const toJsonFactory = _$VoteBaseToJson;
  Map<String, dynamic> toJson() => _$VoteBaseToJson(this);

  @JsonKey(name: 'list_id', defaultValue: '')
  final String listId;
  static const fromJsonFactory = _$VoteBaseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VoteBase &&
            (identical(other.listId, listId) ||
                const DeepCollectionEquality().equals(other.listId, listId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(listId) ^ runtimeType.hashCode;
}

extension $VoteBaseExtension on VoteBase {
  VoteBase copyWith({String? listId}) {
    return VoteBase(listId: listId ?? this.listId);
  }

  VoteBase copyWithWrapped({Wrapped<String>? listId}) {
    return VoteBase(listId: (listId != null ? listId.value : this.listId));
  }
}

@JsonSerializable(explicitToJson: true)
class VoteStats {
  const VoteStats({
    required this.sectionId,
    required this.count,
  });

  factory VoteStats.fromJson(Map<String, dynamic> json) =>
      _$VoteStatsFromJson(json);

  static const toJsonFactory = _$VoteStatsToJson;
  Map<String, dynamic> toJson() => _$VoteStatsToJson(this);

  @JsonKey(name: 'section_id', defaultValue: '')
  final String sectionId;
  @JsonKey(name: 'count', defaultValue: 0)
  final int count;
  static const fromJsonFactory = _$VoteStatsFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VoteStats &&
            (identical(other.sectionId, sectionId) ||
                const DeepCollectionEquality()
                    .equals(other.sectionId, sectionId)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(sectionId) ^
      const DeepCollectionEquality().hash(count) ^
      runtimeType.hashCode;
}

extension $VoteStatsExtension on VoteStats {
  VoteStats copyWith({String? sectionId, int? count}) {
    return VoteStats(
        sectionId: sectionId ?? this.sectionId, count: count ?? this.count);
  }

  VoteStats copyWithWrapped({Wrapped<String>? sectionId, Wrapped<int>? count}) {
    return VoteStats(
        sectionId: (sectionId != null ? sectionId.value : this.sectionId),
        count: (count != null ? count.value : this.count));
  }
}

@JsonSerializable(explicitToJson: true)
class VoteStatus {
  const VoteStatus({
    required this.status,
  });

  factory VoteStatus.fromJson(Map<String, dynamic> json) =>
      _$VoteStatusFromJson(json);

  static const toJsonFactory = _$VoteStatusToJson;
  Map<String, dynamic> toJson() => _$VoteStatusToJson(this);

  @JsonKey(
    name: 'status',
    toJson: statusTypeToJson,
    fromJson: statusTypeFromJson,
  )
  final enums.StatusType status;
  static const fromJsonFactory = _$VoteStatusFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VoteStatus &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $VoteStatusExtension on VoteStatus {
  VoteStatus copyWith({enums.StatusType? status}) {
    return VoteStatus(status: status ?? this.status);
  }

  VoteStatus copyWithWrapped({Wrapped<enums.StatusType>? status}) {
    return VoteStatus(status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class VoterGroup {
  const VoterGroup({
    required this.groupId,
  });

  factory VoterGroup.fromJson(Map<String, dynamic> json) =>
      _$VoterGroupFromJson(json);

  static const toJsonFactory = _$VoterGroupToJson;
  Map<String, dynamic> toJson() => _$VoterGroupToJson(this);

  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$VoterGroupFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VoterGroup &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(groupId) ^ runtimeType.hashCode;
}

extension $VoterGroupExtension on VoterGroup {
  VoterGroup copyWith({String? groupId}) {
    return VoterGroup(groupId: groupId ?? this.groupId);
  }

  VoterGroup copyWithWrapped({Wrapped<String>? groupId}) {
    return VoterGroup(
        groupId: (groupId != null ? groupId.value : this.groupId));
  }
}

@JsonSerializable(explicitToJson: true)
class AppSchemasSchemasAmapCashComplete {
  const AppSchemasSchemasAmapCashComplete({
    required this.balance,
    required this.userId,
    required this.user,
  });

  factory AppSchemasSchemasAmapCashComplete.fromJson(
          Map<String, dynamic> json) =>
      _$AppSchemasSchemasAmapCashCompleteFromJson(json);

  static const toJsonFactory = _$AppSchemasSchemasAmapCashCompleteToJson;
  Map<String, dynamic> toJson() =>
      _$AppSchemasSchemasAmapCashCompleteToJson(this);

  @JsonKey(name: 'balance', defaultValue: 0.0)
  final double balance;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  static const fromJsonFactory = _$AppSchemasSchemasAmapCashCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AppSchemasSchemasAmapCashComplete &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality()
                    .equals(other.balance, balance)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $AppSchemasSchemasAmapCashCompleteExtension
    on AppSchemasSchemasAmapCashComplete {
  AppSchemasSchemasAmapCashComplete copyWith(
      {double? balance, String? userId, CoreUserSimple? user}) {
    return AppSchemasSchemasAmapCashComplete(
        balance: balance ?? this.balance,
        userId: userId ?? this.userId,
        user: user ?? this.user);
  }

  AppSchemasSchemasAmapCashComplete copyWithWrapped(
      {Wrapped<double>? balance,
      Wrapped<String>? userId,
      Wrapped<CoreUserSimple>? user}) {
    return AppSchemasSchemasAmapCashComplete(
        balance: (balance != null ? balance.value : this.balance),
        userId: (userId != null ? userId.value : this.userId),
        user: (user != null ? user.value : this.user));
  }
}

@JsonSerializable(explicitToJson: true)
class AppSchemasSchemasAmapCashEdit {
  const AppSchemasSchemasAmapCashEdit({
    required this.balance,
  });

  factory AppSchemasSchemasAmapCashEdit.fromJson(Map<String, dynamic> json) =>
      _$AppSchemasSchemasAmapCashEditFromJson(json);

  static const toJsonFactory = _$AppSchemasSchemasAmapCashEditToJson;
  Map<String, dynamic> toJson() => _$AppSchemasSchemasAmapCashEditToJson(this);

  @JsonKey(name: 'balance', defaultValue: 0.0)
  final double balance;
  static const fromJsonFactory = _$AppSchemasSchemasAmapCashEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AppSchemasSchemasAmapCashEdit &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(other.balance, balance)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^ runtimeType.hashCode;
}

extension $AppSchemasSchemasAmapCashEditExtension
    on AppSchemasSchemasAmapCashEdit {
  AppSchemasSchemasAmapCashEdit copyWith({double? balance}) {
    return AppSchemasSchemasAmapCashEdit(balance: balance ?? this.balance);
  }

  AppSchemasSchemasAmapCashEdit copyWithWrapped({Wrapped<double>? balance}) {
    return AppSchemasSchemasAmapCashEdit(
        balance: (balance != null ? balance.value : this.balance));
  }
}

@JsonSerializable(explicitToJson: true)
class AppSchemasSchemasCampaignResult {
  const AppSchemasSchemasCampaignResult({
    required this.listId,
    required this.count,
  });

  factory AppSchemasSchemasCampaignResult.fromJson(Map<String, dynamic> json) =>
      _$AppSchemasSchemasCampaignResultFromJson(json);

  static const toJsonFactory = _$AppSchemasSchemasCampaignResultToJson;
  Map<String, dynamic> toJson() =>
      _$AppSchemasSchemasCampaignResultToJson(this);

  @JsonKey(name: 'list_id', defaultValue: '')
  final String listId;
  @JsonKey(name: 'count', defaultValue: 0)
  final int count;
  static const fromJsonFactory = _$AppSchemasSchemasCampaignResultFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AppSchemasSchemasCampaignResult &&
            (identical(other.listId, listId) ||
                const DeepCollectionEquality().equals(other.listId, listId)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(listId) ^
      const DeepCollectionEquality().hash(count) ^
      runtimeType.hashCode;
}

extension $AppSchemasSchemasCampaignResultExtension
    on AppSchemasSchemasCampaignResult {
  AppSchemasSchemasCampaignResult copyWith({String? listId, int? count}) {
    return AppSchemasSchemasCampaignResult(
        listId: listId ?? this.listId, count: count ?? this.count);
  }

  AppSchemasSchemasCampaignResult copyWithWrapped(
      {Wrapped<String>? listId, Wrapped<int>? count}) {
    return AppSchemasSchemasCampaignResult(
        listId: (listId != null ? listId.value : this.listId),
        count: (count != null ? count.value : this.count));
  }
}

@JsonSerializable(explicitToJson: true)
class AppSchemasSchemasRaffleCashComplete {
  const AppSchemasSchemasRaffleCashComplete({
    required this.balance,
    required this.userId,
    required this.user,
  });

  factory AppSchemasSchemasRaffleCashComplete.fromJson(
          Map<String, dynamic> json) =>
      _$AppSchemasSchemasRaffleCashCompleteFromJson(json);

  static const toJsonFactory = _$AppSchemasSchemasRaffleCashCompleteToJson;
  Map<String, dynamic> toJson() =>
      _$AppSchemasSchemasRaffleCashCompleteToJson(this);

  @JsonKey(name: 'balance', defaultValue: 0.0)
  final double balance;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  static const fromJsonFactory = _$AppSchemasSchemasRaffleCashCompleteFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AppSchemasSchemasRaffleCashComplete &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality()
                    .equals(other.balance, balance)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $AppSchemasSchemasRaffleCashCompleteExtension
    on AppSchemasSchemasRaffleCashComplete {
  AppSchemasSchemasRaffleCashComplete copyWith(
      {double? balance, String? userId, CoreUserSimple? user}) {
    return AppSchemasSchemasRaffleCashComplete(
        balance: balance ?? this.balance,
        userId: userId ?? this.userId,
        user: user ?? this.user);
  }

  AppSchemasSchemasRaffleCashComplete copyWithWrapped(
      {Wrapped<double>? balance,
      Wrapped<String>? userId,
      Wrapped<CoreUserSimple>? user}) {
    return AppSchemasSchemasRaffleCashComplete(
        balance: (balance != null ? balance.value : this.balance),
        userId: (userId != null ? userId.value : this.userId),
        user: (user != null ? user.value : this.user));
  }
}

@JsonSerializable(explicitToJson: true)
class AppSchemasSchemasRaffleCashEdit {
  const AppSchemasSchemasRaffleCashEdit({
    required this.balance,
  });

  factory AppSchemasSchemasRaffleCashEdit.fromJson(Map<String, dynamic> json) =>
      _$AppSchemasSchemasRaffleCashEditFromJson(json);

  static const toJsonFactory = _$AppSchemasSchemasRaffleCashEditToJson;
  Map<String, dynamic> toJson() =>
      _$AppSchemasSchemasRaffleCashEditToJson(this);

  @JsonKey(name: 'balance', defaultValue: 0.0)
  final double balance;
  static const fromJsonFactory = _$AppSchemasSchemasRaffleCashEditFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AppSchemasSchemasRaffleCashEdit &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(other.balance, balance)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^ runtimeType.hashCode;
}

extension $AppSchemasSchemasRaffleCashEditExtension
    on AppSchemasSchemasRaffleCashEdit {
  AppSchemasSchemasRaffleCashEdit copyWith({double? balance}) {
    return AppSchemasSchemasRaffleCashEdit(balance: balance ?? this.balance);
  }

  AppSchemasSchemasRaffleCashEdit copyWithWrapped({Wrapped<double>? balance}) {
    return AppSchemasSchemasRaffleCashEdit(
        balance: (balance != null ? balance.value : this.balance));
  }
}

@JsonSerializable(explicitToJson: true)
class AppUtilsTypesStandardResponsesResult {
  const AppUtilsTypesStandardResponsesResult({
    this.success,
  });

  factory AppUtilsTypesStandardResponsesResult.fromJson(
          Map<String, dynamic> json) =>
      _$AppUtilsTypesStandardResponsesResultFromJson(json);

  static const toJsonFactory = _$AppUtilsTypesStandardResponsesResultToJson;
  Map<String, dynamic> toJson() =>
      _$AppUtilsTypesStandardResponsesResultToJson(this);

  @JsonKey(name: 'success', defaultValue: true)
  final bool? success;
  static const fromJsonFactory = _$AppUtilsTypesStandardResponsesResultFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AppUtilsTypesStandardResponsesResult &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $AppUtilsTypesStandardResponsesResultExtension
    on AppUtilsTypesStandardResponsesResult {
  AppUtilsTypesStandardResponsesResult copyWith({bool? success}) {
    return AppUtilsTypesStandardResponsesResult(
        success: success ?? this.success);
  }

  AppUtilsTypesStandardResponsesResult copyWithWrapped(
      {Wrapped<bool?>? success}) {
    return AppUtilsTypesStandardResponsesResult(
        success: (success != null ? success.value : this.success));
  }
}

String? accountTypeNullableToJson(enums.AccountType? accountType) {
  return accountType?.value;
}

String? accountTypeToJson(enums.AccountType accountType) {
  return accountType.value;
}

enums.AccountType accountTypeFromJson(
  Object? accountType, [
  enums.AccountType? defaultValue,
]) {
  return enums.AccountType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          accountType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.AccountType.swaggerGeneratedUnknown;
}

enums.AccountType? accountTypeNullableFromJson(
  Object? accountType, [
  enums.AccountType? defaultValue,
]) {
  if (accountType == null) {
    return null;
  }
  return enums.AccountType.values
          .firstWhereOrNull((e) => e.value == accountType) ??
      defaultValue;
}

String accountTypeExplodedListToJson(List<enums.AccountType>? accountType) {
  return accountType?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountTypeListToJson(List<enums.AccountType>? accountType) {
  if (accountType == null) {
    return [];
  }

  return accountType.map((e) => e.value!).toList();
}

List<enums.AccountType> accountTypeListFromJson(
  List? accountType, [
  List<enums.AccountType>? defaultValue,
]) {
  if (accountType == null) {
    return defaultValue ?? [];
  }

  return accountType.map((e) => accountTypeFromJson(e.toString())).toList();
}

List<enums.AccountType>? accountTypeNullableListFromJson(
  List? accountType, [
  List<enums.AccountType>? defaultValue,
]) {
  if (accountType == null) {
    return defaultValue;
  }

  return accountType.map((e) => accountTypeFromJson(e.toString())).toList();
}

String? amapSlotTypeNullableToJson(enums.AmapSlotType? amapSlotType) {
  return amapSlotType?.value;
}

String? amapSlotTypeToJson(enums.AmapSlotType amapSlotType) {
  return amapSlotType.value;
}

enums.AmapSlotType amapSlotTypeFromJson(
  Object? amapSlotType, [
  enums.AmapSlotType? defaultValue,
]) {
  return enums.AmapSlotType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          amapSlotType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.AmapSlotType.swaggerGeneratedUnknown;
}

enums.AmapSlotType? amapSlotTypeNullableFromJson(
  Object? amapSlotType, [
  enums.AmapSlotType? defaultValue,
]) {
  if (amapSlotType == null) {
    return null;
  }
  return enums.AmapSlotType.values
          .firstWhereOrNull((e) => e.value == amapSlotType) ??
      defaultValue;
}

String amapSlotTypeExplodedListToJson(List<enums.AmapSlotType>? amapSlotType) {
  return amapSlotType?.map((e) => e.value!).join(',') ?? '';
}

List<String> amapSlotTypeListToJson(List<enums.AmapSlotType>? amapSlotType) {
  if (amapSlotType == null) {
    return [];
  }

  return amapSlotType.map((e) => e.value!).toList();
}

List<enums.AmapSlotType> amapSlotTypeListFromJson(
  List? amapSlotType, [
  List<enums.AmapSlotType>? defaultValue,
]) {
  if (amapSlotType == null) {
    return defaultValue ?? [];
  }

  return amapSlotType.map((e) => amapSlotTypeFromJson(e.toString())).toList();
}

List<enums.AmapSlotType>? amapSlotTypeNullableListFromJson(
  List? amapSlotType, [
  List<enums.AmapSlotType>? defaultValue,
]) {
  if (amapSlotType == null) {
    return defaultValue;
  }

  return amapSlotType.map((e) => amapSlotTypeFromJson(e.toString())).toList();
}

String? calendarEventTypeNullableToJson(
    enums.CalendarEventType? calendarEventType) {
  return calendarEventType?.value;
}

String? calendarEventTypeToJson(enums.CalendarEventType calendarEventType) {
  return calendarEventType.value;
}

enums.CalendarEventType calendarEventTypeFromJson(
  Object? calendarEventType, [
  enums.CalendarEventType? defaultValue,
]) {
  return enums.CalendarEventType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          calendarEventType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.CalendarEventType.swaggerGeneratedUnknown;
}

enums.CalendarEventType? calendarEventTypeNullableFromJson(
  Object? calendarEventType, [
  enums.CalendarEventType? defaultValue,
]) {
  if (calendarEventType == null) {
    return null;
  }
  return enums.CalendarEventType.values
          .firstWhereOrNull((e) => e.value == calendarEventType) ??
      defaultValue;
}

String calendarEventTypeExplodedListToJson(
    List<enums.CalendarEventType>? calendarEventType) {
  return calendarEventType?.map((e) => e.value!).join(',') ?? '';
}

List<String> calendarEventTypeListToJson(
    List<enums.CalendarEventType>? calendarEventType) {
  if (calendarEventType == null) {
    return [];
  }

  return calendarEventType.map((e) => e.value!).toList();
}

List<enums.CalendarEventType> calendarEventTypeListFromJson(
  List? calendarEventType, [
  List<enums.CalendarEventType>? defaultValue,
]) {
  if (calendarEventType == null) {
    return defaultValue ?? [];
  }

  return calendarEventType
      .map((e) => calendarEventTypeFromJson(e.toString()))
      .toList();
}

List<enums.CalendarEventType>? calendarEventTypeNullableListFromJson(
  List? calendarEventType, [
  List<enums.CalendarEventType>? defaultValue,
]) {
  if (calendarEventType == null) {
    return defaultValue;
  }

  return calendarEventType
      .map((e) => calendarEventTypeFromJson(e.toString()))
      .toList();
}

String? deliveryStatusTypeNullableToJson(
    enums.DeliveryStatusType? deliveryStatusType) {
  return deliveryStatusType?.value;
}

String? deliveryStatusTypeToJson(enums.DeliveryStatusType deliveryStatusType) {
  return deliveryStatusType.value;
}

enums.DeliveryStatusType deliveryStatusTypeFromJson(
  Object? deliveryStatusType, [
  enums.DeliveryStatusType? defaultValue,
]) {
  return enums.DeliveryStatusType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          deliveryStatusType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.DeliveryStatusType.swaggerGeneratedUnknown;
}

enums.DeliveryStatusType? deliveryStatusTypeNullableFromJson(
  Object? deliveryStatusType, [
  enums.DeliveryStatusType? defaultValue,
]) {
  if (deliveryStatusType == null) {
    return null;
  }
  return enums.DeliveryStatusType.values
          .firstWhereOrNull((e) => e.value == deliveryStatusType) ??
      defaultValue;
}

String deliveryStatusTypeExplodedListToJson(
    List<enums.DeliveryStatusType>? deliveryStatusType) {
  return deliveryStatusType?.map((e) => e.value!).join(',') ?? '';
}

List<String> deliveryStatusTypeListToJson(
    List<enums.DeliveryStatusType>? deliveryStatusType) {
  if (deliveryStatusType == null) {
    return [];
  }

  return deliveryStatusType.map((e) => e.value!).toList();
}

List<enums.DeliveryStatusType> deliveryStatusTypeListFromJson(
  List? deliveryStatusType, [
  List<enums.DeliveryStatusType>? defaultValue,
]) {
  if (deliveryStatusType == null) {
    return defaultValue ?? [];
  }

  return deliveryStatusType
      .map((e) => deliveryStatusTypeFromJson(e.toString()))
      .toList();
}

List<enums.DeliveryStatusType>? deliveryStatusTypeNullableListFromJson(
  List? deliveryStatusType, [
  List<enums.DeliveryStatusType>? defaultValue,
]) {
  if (deliveryStatusType == null) {
    return defaultValue;
  }

  return deliveryStatusType
      .map((e) => deliveryStatusTypeFromJson(e.toString()))
      .toList();
}

String? floorsTypeNullableToJson(enums.FloorsType? floorsType) {
  return floorsType?.value;
}

String? floorsTypeToJson(enums.FloorsType floorsType) {
  return floorsType.value;
}

enums.FloorsType floorsTypeFromJson(
  Object? floorsType, [
  enums.FloorsType? defaultValue,
]) {
  return enums.FloorsType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          floorsType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.FloorsType.swaggerGeneratedUnknown;
}

enums.FloorsType? floorsTypeNullableFromJson(
  Object? floorsType, [
  enums.FloorsType? defaultValue,
]) {
  if (floorsType == null) {
    return null;
  }
  return enums.FloorsType.values
          .firstWhereOrNull((e) => e.value == floorsType) ??
      defaultValue;
}

String floorsTypeExplodedListToJson(List<enums.FloorsType>? floorsType) {
  return floorsType?.map((e) => e.value!).join(',') ?? '';
}

List<String> floorsTypeListToJson(List<enums.FloorsType>? floorsType) {
  if (floorsType == null) {
    return [];
  }

  return floorsType.map((e) => e.value!).toList();
}

List<enums.FloorsType> floorsTypeListFromJson(
  List? floorsType, [
  List<enums.FloorsType>? defaultValue,
]) {
  if (floorsType == null) {
    return defaultValue ?? [];
  }

  return floorsType.map((e) => floorsTypeFromJson(e.toString())).toList();
}

List<enums.FloorsType>? floorsTypeNullableListFromJson(
  List? floorsType, [
  List<enums.FloorsType>? defaultValue,
]) {
  if (floorsType == null) {
    return defaultValue;
  }

  return floorsType.map((e) => floorsTypeFromJson(e.toString())).toList();
}

String? listTypeNullableToJson(enums.ListType? listType) {
  return listType?.value;
}

String? listTypeToJson(enums.ListType listType) {
  return listType.value;
}

enums.ListType listTypeFromJson(
  Object? listType, [
  enums.ListType? defaultValue,
]) {
  return enums.ListType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          listType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.ListType.swaggerGeneratedUnknown;
}

enums.ListType? listTypeNullableFromJson(
  Object? listType, [
  enums.ListType? defaultValue,
]) {
  if (listType == null) {
    return null;
  }
  return enums.ListType.values.firstWhereOrNull((e) => e.value == listType) ??
      defaultValue;
}

String listTypeExplodedListToJson(List<enums.ListType>? listType) {
  return listType?.map((e) => e.value!).join(',') ?? '';
}

List<String> listTypeListToJson(List<enums.ListType>? listType) {
  if (listType == null) {
    return [];
  }

  return listType.map((e) => e.value!).toList();
}

List<enums.ListType> listTypeListFromJson(
  List? listType, [
  List<enums.ListType>? defaultValue,
]) {
  if (listType == null) {
    return defaultValue ?? [];
  }

  return listType.map((e) => listTypeFromJson(e.toString())).toList();
}

List<enums.ListType>? listTypeNullableListFromJson(
  List? listType, [
  List<enums.ListType>? defaultValue,
]) {
  if (listType == null) {
    return defaultValue;
  }

  return listType.map((e) => listTypeFromJson(e.toString())).toList();
}

String? raffleStatusTypeNullableToJson(
    enums.RaffleStatusType? raffleStatusType) {
  return raffleStatusType?.value;
}

String? raffleStatusTypeToJson(enums.RaffleStatusType raffleStatusType) {
  return raffleStatusType.value;
}

enums.RaffleStatusType raffleStatusTypeFromJson(
  Object? raffleStatusType, [
  enums.RaffleStatusType? defaultValue,
]) {
  return enums.RaffleStatusType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          raffleStatusType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.RaffleStatusType.swaggerGeneratedUnknown;
}

enums.RaffleStatusType? raffleStatusTypeNullableFromJson(
  Object? raffleStatusType, [
  enums.RaffleStatusType? defaultValue,
]) {
  if (raffleStatusType == null) {
    return null;
  }
  return enums.RaffleStatusType.values
          .firstWhereOrNull((e) => e.value == raffleStatusType) ??
      defaultValue;
}

String raffleStatusTypeExplodedListToJson(
    List<enums.RaffleStatusType>? raffleStatusType) {
  return raffleStatusType?.map((e) => e.value!).join(',') ?? '';
}

List<String> raffleStatusTypeListToJson(
    List<enums.RaffleStatusType>? raffleStatusType) {
  if (raffleStatusType == null) {
    return [];
  }

  return raffleStatusType.map((e) => e.value!).toList();
}

List<enums.RaffleStatusType> raffleStatusTypeListFromJson(
  List? raffleStatusType, [
  List<enums.RaffleStatusType>? defaultValue,
]) {
  if (raffleStatusType == null) {
    return defaultValue ?? [];
  }

  return raffleStatusType
      .map((e) => raffleStatusTypeFromJson(e.toString()))
      .toList();
}

List<enums.RaffleStatusType>? raffleStatusTypeNullableListFromJson(
  List? raffleStatusType, [
  List<enums.RaffleStatusType>? defaultValue,
]) {
  if (raffleStatusType == null) {
    return defaultValue;
  }

  return raffleStatusType
      .map((e) => raffleStatusTypeFromJson(e.toString()))
      .toList();
}

String? statusTypeNullableToJson(enums.StatusType? statusType) {
  return statusType?.value;
}

String? statusTypeToJson(enums.StatusType statusType) {
  return statusType.value;
}

enums.StatusType statusTypeFromJson(
  Object? statusType, [
  enums.StatusType? defaultValue,
]) {
  return enums.StatusType.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          statusType?.toString().toLowerCase()) ??
      defaultValue ??
      enums.StatusType.swaggerGeneratedUnknown;
}

enums.StatusType? statusTypeNullableFromJson(
  Object? statusType, [
  enums.StatusType? defaultValue,
]) {
  if (statusType == null) {
    return null;
  }
  return enums.StatusType.values
          .firstWhereOrNull((e) => e.value == statusType) ??
      defaultValue;
}

String statusTypeExplodedListToJson(List<enums.StatusType>? statusType) {
  return statusType?.map((e) => e.value!).join(',') ?? '';
}

List<String> statusTypeListToJson(List<enums.StatusType>? statusType) {
  if (statusType == null) {
    return [];
  }

  return statusType.map((e) => e.value!).toList();
}

List<enums.StatusType> statusTypeListFromJson(
  List? statusType, [
  List<enums.StatusType>? defaultValue,
]) {
  if (statusType == null) {
    return defaultValue ?? [];
  }

  return statusType.map((e) => statusTypeFromJson(e.toString())).toList();
}

List<enums.StatusType>? statusTypeNullableListFromJson(
  List? statusType, [
  List<enums.StatusType>? defaultValue,
]) {
  if (statusType == null) {
    return defaultValue;
  }

  return statusType.map((e) => statusTypeFromJson(e.toString())).toList();
}

String? appUtilsTypesBookingTypeDecisionNullableToJson(
    enums.AppUtilsTypesBookingTypeDecision? appUtilsTypesBookingTypeDecision) {
  return appUtilsTypesBookingTypeDecision?.value;
}

String? appUtilsTypesBookingTypeDecisionToJson(
    enums.AppUtilsTypesBookingTypeDecision appUtilsTypesBookingTypeDecision) {
  return appUtilsTypesBookingTypeDecision.value;
}

enums.AppUtilsTypesBookingTypeDecision appUtilsTypesBookingTypeDecisionFromJson(
  Object? appUtilsTypesBookingTypeDecision, [
  enums.AppUtilsTypesBookingTypeDecision? defaultValue,
]) {
  return enums.AppUtilsTypesBookingTypeDecision.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          appUtilsTypesBookingTypeDecision?.toString().toLowerCase()) ??
      defaultValue ??
      enums.AppUtilsTypesBookingTypeDecision.swaggerGeneratedUnknown;
}

enums.AppUtilsTypesBookingTypeDecision?
    appUtilsTypesBookingTypeDecisionNullableFromJson(
  Object? appUtilsTypesBookingTypeDecision, [
  enums.AppUtilsTypesBookingTypeDecision? defaultValue,
]) {
  if (appUtilsTypesBookingTypeDecision == null) {
    return null;
  }
  return enums.AppUtilsTypesBookingTypeDecision.values.firstWhereOrNull(
          (e) => e.value == appUtilsTypesBookingTypeDecision) ??
      defaultValue;
}

String appUtilsTypesBookingTypeDecisionExplodedListToJson(
    List<enums.AppUtilsTypesBookingTypeDecision>?
        appUtilsTypesBookingTypeDecision) {
  return appUtilsTypesBookingTypeDecision?.map((e) => e.value!).join(',') ?? '';
}

List<String> appUtilsTypesBookingTypeDecisionListToJson(
    List<enums.AppUtilsTypesBookingTypeDecision>?
        appUtilsTypesBookingTypeDecision) {
  if (appUtilsTypesBookingTypeDecision == null) {
    return [];
  }

  return appUtilsTypesBookingTypeDecision.map((e) => e.value!).toList();
}

List<enums.AppUtilsTypesBookingTypeDecision>
    appUtilsTypesBookingTypeDecisionListFromJson(
  List? appUtilsTypesBookingTypeDecision, [
  List<enums.AppUtilsTypesBookingTypeDecision>? defaultValue,
]) {
  if (appUtilsTypesBookingTypeDecision == null) {
    return defaultValue ?? [];
  }

  return appUtilsTypesBookingTypeDecision
      .map((e) => appUtilsTypesBookingTypeDecisionFromJson(e.toString()))
      .toList();
}

List<enums.AppUtilsTypesBookingTypeDecision>?
    appUtilsTypesBookingTypeDecisionNullableListFromJson(
  List? appUtilsTypesBookingTypeDecision, [
  List<enums.AppUtilsTypesBookingTypeDecision>? defaultValue,
]) {
  if (appUtilsTypesBookingTypeDecision == null) {
    return defaultValue;
  }

  return appUtilsTypesBookingTypeDecision
      .map((e) => appUtilsTypesBookingTypeDecisionFromJson(e.toString()))
      .toList();
}

String? appUtilsTypesCalendarTypesDecisionNullableToJson(
    enums.AppUtilsTypesCalendarTypesDecision?
        appUtilsTypesCalendarTypesDecision) {
  return appUtilsTypesCalendarTypesDecision?.value;
}

String? appUtilsTypesCalendarTypesDecisionToJson(
    enums.AppUtilsTypesCalendarTypesDecision
        appUtilsTypesCalendarTypesDecision) {
  return appUtilsTypesCalendarTypesDecision.value;
}

enums.AppUtilsTypesCalendarTypesDecision
    appUtilsTypesCalendarTypesDecisionFromJson(
  Object? appUtilsTypesCalendarTypesDecision, [
  enums.AppUtilsTypesCalendarTypesDecision? defaultValue,
]) {
  return enums.AppUtilsTypesCalendarTypesDecision.values.firstWhereOrNull((e) =>
          e.value.toString().toLowerCase() ==
          appUtilsTypesCalendarTypesDecision?.toString().toLowerCase()) ??
      defaultValue ??
      enums.AppUtilsTypesCalendarTypesDecision.swaggerGeneratedUnknown;
}

enums.AppUtilsTypesCalendarTypesDecision?
    appUtilsTypesCalendarTypesDecisionNullableFromJson(
  Object? appUtilsTypesCalendarTypesDecision, [
  enums.AppUtilsTypesCalendarTypesDecision? defaultValue,
]) {
  if (appUtilsTypesCalendarTypesDecision == null) {
    return null;
  }
  return enums.AppUtilsTypesCalendarTypesDecision.values.firstWhereOrNull(
          (e) => e.value == appUtilsTypesCalendarTypesDecision) ??
      defaultValue;
}

String appUtilsTypesCalendarTypesDecisionExplodedListToJson(
    List<enums.AppUtilsTypesCalendarTypesDecision>?
        appUtilsTypesCalendarTypesDecision) {
  return appUtilsTypesCalendarTypesDecision?.map((e) => e.value!).join(',') ??
      '';
}

List<String> appUtilsTypesCalendarTypesDecisionListToJson(
    List<enums.AppUtilsTypesCalendarTypesDecision>?
        appUtilsTypesCalendarTypesDecision) {
  if (appUtilsTypesCalendarTypesDecision == null) {
    return [];
  }

  return appUtilsTypesCalendarTypesDecision.map((e) => e.value!).toList();
}

List<enums.AppUtilsTypesCalendarTypesDecision>
    appUtilsTypesCalendarTypesDecisionListFromJson(
  List? appUtilsTypesCalendarTypesDecision, [
  List<enums.AppUtilsTypesCalendarTypesDecision>? defaultValue,
]) {
  if (appUtilsTypesCalendarTypesDecision == null) {
    return defaultValue ?? [];
  }

  return appUtilsTypesCalendarTypesDecision
      .map((e) => appUtilsTypesCalendarTypesDecisionFromJson(e.toString()))
      .toList();
}

List<enums.AppUtilsTypesCalendarTypesDecision>?
    appUtilsTypesCalendarTypesDecisionNullableListFromJson(
  List? appUtilsTypesCalendarTypesDecision, [
  List<enums.AppUtilsTypesCalendarTypesDecision>? defaultValue,
]) {
  if (appUtilsTypesCalendarTypesDecision == null) {
    return defaultValue;
  }

  return appUtilsTypesCalendarTypesDecision
      .map((e) => appUtilsTypesCalendarTypesDecisionFromJson(e.toString()))
      .toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
