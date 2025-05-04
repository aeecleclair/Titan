// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'openapi.enums.swagger.dart' as enums;

part 'openapi.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class AccessToken {
  const AccessToken({required this.accessToken, required this.tokenType});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccessToken &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality().equals(
                  other.accessToken,
                  accessToken,
                )) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality().equals(
                  other.tokenType,
                  tokenType,
                )));
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
      tokenType: tokenType ?? this.tokenType,
    );
  }

  AccessToken copyWithWrapped({
    Wrapped<String>? accessToken,
    Wrapped<String>? tokenType,
  }) {
    return AccessToken(
      accessToken: (accessToken != null ? accessToken.value : this.accessToken),
      tokenType: (tokenType != null ? tokenType.value : this.tokenType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdminTransferInfo {
  const AdminTransferInfo({
    required this.amount,
    required this.transferType,
    this.creditedUserId,
  });

  factory AdminTransferInfo.fromJson(Map<String, dynamic> json) =>
      _$AdminTransferInfoFromJson(json);

  static const toJsonFactory = _$AdminTransferInfoToJson;
  Map<String, dynamic> toJson() => _$AdminTransferInfoToJson(this);

  @JsonKey(name: 'amount', defaultValue: 0)
  final int amount;
  @JsonKey(
    name: 'transfer_type',
    toJson: transferTypeToJson,
    fromJson: transferTypeFromJson,
  )
  final enums.TransferType transferType;
  @JsonKey(name: 'credited_user_id')
  final String? creditedUserId;
  static const fromJsonFactory = _$AdminTransferInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdminTransferInfo &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.transferType, transferType) ||
                const DeepCollectionEquality().equals(
                  other.transferType,
                  transferType,
                )) &&
            (identical(other.creditedUserId, creditedUserId) ||
                const DeepCollectionEquality().equals(
                  other.creditedUserId,
                  creditedUserId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(transferType) ^
      const DeepCollectionEquality().hash(creditedUserId) ^
      runtimeType.hashCode;
}

extension $AdminTransferInfoExtension on AdminTransferInfo {
  AdminTransferInfo copyWith({
    int? amount,
    enums.TransferType? transferType,
    String? creditedUserId,
  }) {
    return AdminTransferInfo(
      amount: amount ?? this.amount,
      transferType: transferType ?? this.transferType,
      creditedUserId: creditedUserId ?? this.creditedUserId,
    );
  }

  AdminTransferInfo copyWithWrapped({
    Wrapped<int>? amount,
    Wrapped<enums.TransferType>? transferType,
    Wrapped<String?>? creditedUserId,
  }) {
    return AdminTransferInfo(
      amount: (amount != null ? amount.value : this.amount),
      transferType:
          (transferType != null ? transferType.value : this.transferType),
      creditedUserId:
          (creditedUserId != null ? creditedUserId.value : this.creditedUserId),
    );
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
  @JsonKey(name: 'tags')
  final String? tags;
  static const fromJsonFactory = _$AdvertBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertBase &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(
                  other.content,
                  content,
                )) &&
            (identical(other.advertiserId, advertiserId) ||
                const DeepCollectionEquality().equals(
                  other.advertiserId,
                  advertiserId,
                )) &&
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
  AdvertBase copyWith({
    String? title,
    String? content,
    String? advertiserId,
    String? tags,
  }) {
    return AdvertBase(
      title: title ?? this.title,
      content: content ?? this.content,
      advertiserId: advertiserId ?? this.advertiserId,
      tags: tags ?? this.tags,
    );
  }

  AdvertBase copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String>? content,
    Wrapped<String>? advertiserId,
    Wrapped<String?>? tags,
  }) {
    return AdvertBase(
      title: (title != null ? title.value : this.title),
      content: (content != null ? content.value : this.content),
      advertiserId:
          (advertiserId != null ? advertiserId.value : this.advertiserId),
      tags: (tags != null ? tags.value : this.tags),
    );
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
  @JsonKey(name: 'tags')
  final String? tags;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'advertiser')
  final AdvertiserComplete advertiser;
  @JsonKey(name: 'date')
  final String? date;
  static const fromJsonFactory = _$AdvertReturnCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertReturnComplete &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(
                  other.content,
                  content,
                )) &&
            (identical(other.advertiserId, advertiserId) ||
                const DeepCollectionEquality().equals(
                  other.advertiserId,
                  advertiserId,
                )) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.advertiser, advertiser) ||
                const DeepCollectionEquality().equals(
                  other.advertiser,
                  advertiser,
                )) &&
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
  AdvertReturnComplete copyWith({
    String? title,
    String? content,
    String? advertiserId,
    String? tags,
    String? id,
    AdvertiserComplete? advertiser,
    String? date,
  }) {
    return AdvertReturnComplete(
      title: title ?? this.title,
      content: content ?? this.content,
      advertiserId: advertiserId ?? this.advertiserId,
      tags: tags ?? this.tags,
      id: id ?? this.id,
      advertiser: advertiser ?? this.advertiser,
      date: date ?? this.date,
    );
  }

  AdvertReturnComplete copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String>? content,
    Wrapped<String>? advertiserId,
    Wrapped<String?>? tags,
    Wrapped<String>? id,
    Wrapped<AdvertiserComplete>? advertiser,
    Wrapped<String?>? date,
  }) {
    return AdvertReturnComplete(
      title: (title != null ? title.value : this.title),
      content: (content != null ? content.value : this.content),
      advertiserId:
          (advertiserId != null ? advertiserId.value : this.advertiserId),
      tags: (tags != null ? tags.value : this.tags),
      id: (id != null ? id.value : this.id),
      advertiser: (advertiser != null ? advertiser.value : this.advertiser),
      date: (date != null ? date.value : this.date),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertUpdate {
  const AdvertUpdate({this.title, this.content, this.tags});

  factory AdvertUpdate.fromJson(Map<String, dynamic> json) =>
      _$AdvertUpdateFromJson(json);

  static const toJsonFactory = _$AdvertUpdateToJson;
  Map<String, dynamic> toJson() => _$AdvertUpdateToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'tags')
  final String? tags;
  static const fromJsonFactory = _$AdvertUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertUpdate &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(
                  other.content,
                  content,
                )) &&
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
      tags: tags ?? this.tags,
    );
  }

  AdvertUpdate copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? content,
    Wrapped<String?>? tags,
  }) {
    return AdvertUpdate(
      title: (title != null ? title.value : this.title),
      content: (content != null ? content.value : this.content),
      tags: (tags != null ? tags.value : this.tags),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertiserBase {
  const AdvertiserBase({required this.name, required this.groupManagerId});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertiserBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality().equals(
                  other.groupManagerId,
                  groupManagerId,
                )));
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
      groupManagerId: groupManagerId ?? this.groupManagerId,
    );
  }

  AdvertiserBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupManagerId,
  }) {
    return AdvertiserBase(
      name: (name != null ? name.value : this.name),
      groupManagerId:
          (groupManagerId != null ? groupManagerId.value : this.groupManagerId),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertiserComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality().equals(
                  other.groupManagerId,
                  groupManagerId,
                )) &&
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
  AdvertiserComplete copyWith({
    String? name,
    String? groupManagerId,
    String? id,
  }) {
    return AdvertiserComplete(
      name: name ?? this.name,
      groupManagerId: groupManagerId ?? this.groupManagerId,
      id: id ?? this.id,
    );
  }

  AdvertiserComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupManagerId,
    Wrapped<String>? id,
  }) {
    return AdvertiserComplete(
      name: (name != null ? name.value : this.name),
      groupManagerId:
          (groupManagerId != null ? groupManagerId.value : this.groupManagerId),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AdvertiserUpdate {
  const AdvertiserUpdate({this.name, this.groupManagerId});

  factory AdvertiserUpdate.fromJson(Map<String, dynamic> json) =>
      _$AdvertiserUpdateFromJson(json);

  static const toJsonFactory = _$AdvertiserUpdateToJson;
  Map<String, dynamic> toJson() => _$AdvertiserUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'group_manager_id')
  final String? groupManagerId;
  static const fromJsonFactory = _$AdvertiserUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AdvertiserUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality().equals(
                  other.groupManagerId,
                  groupManagerId,
                )));
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
      groupManagerId: groupManagerId ?? this.groupManagerId,
    );
  }

  AdvertiserUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? groupManagerId,
  }) {
    return AdvertiserUpdate(
      name: (name != null ? name.value : this.name),
      groupManagerId:
          (groupManagerId != null ? groupManagerId.value : this.groupManagerId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Applicant {
  const Applicant({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
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
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(name: 'phone')
  final String? phone;
  static const fromJsonFactory = _$ApplicantFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Applicant &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
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
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(phone) ^
      runtimeType.hashCode;
}

extension $ApplicantExtension on Applicant {
  Applicant copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
    String? email,
    int? promo,
    String? phone,
  }) {
    return Applicant(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
      email: email ?? this.email,
      promo: promo ?? this.promo,
      phone: phone ?? this.phone,
    );
  }

  Applicant copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
    Wrapped<String>? email,
    Wrapped<int?>? promo,
    Wrapped<String?>? phone,
  }) {
    return Applicant(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      email: (email != null ? email.value : this.email),
      promo: (promo != null ? promo.value : this.promo),
      phone: (phone != null ? phone.value : this.phone),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AssociationBase {
  const AssociationBase({
    required this.name,
    required this.kind,
    required this.mandateYear,
    this.description,
    this.associatedGroups,
    this.deactivated,
  });

  factory AssociationBase.fromJson(Map<String, dynamic> json) =>
      _$AssociationBaseFromJson(json);

  static const toJsonFactory = _$AssociationBaseToJson;
  Map<String, dynamic> toJson() => _$AssociationBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'kind', toJson: kindsToJson, fromJson: kindsFromJson)
  final enums.Kinds kind;
  @JsonKey(name: 'mandate_year', defaultValue: 0)
  final int mandateYear;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'associated_groups', defaultValue: null)
  final List<String>? associatedGroups;
  @JsonKey(name: 'deactivated', defaultValue: false)
  final bool? deactivated;
  static const fromJsonFactory = _$AssociationBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssociationBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.mandateYear, mandateYear) ||
                const DeepCollectionEquality().equals(
                  other.mandateYear,
                  mandateYear,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.associatedGroups, associatedGroups) ||
                const DeepCollectionEquality().equals(
                  other.associatedGroups,
                  associatedGroups,
                )) &&
            (identical(other.deactivated, deactivated) ||
                const DeepCollectionEquality().equals(
                  other.deactivated,
                  deactivated,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(mandateYear) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(associatedGroups) ^
      const DeepCollectionEquality().hash(deactivated) ^
      runtimeType.hashCode;
}

extension $AssociationBaseExtension on AssociationBase {
  AssociationBase copyWith({
    String? name,
    enums.Kinds? kind,
    int? mandateYear,
    String? description,
    List<String>? associatedGroups,
    bool? deactivated,
  }) {
    return AssociationBase(
      name: name ?? this.name,
      kind: kind ?? this.kind,
      mandateYear: mandateYear ?? this.mandateYear,
      description: description ?? this.description,
      associatedGroups: associatedGroups ?? this.associatedGroups,
      deactivated: deactivated ?? this.deactivated,
    );
  }

  AssociationBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<enums.Kinds>? kind,
    Wrapped<int>? mandateYear,
    Wrapped<String?>? description,
    Wrapped<List<String>?>? associatedGroups,
    Wrapped<bool?>? deactivated,
  }) {
    return AssociationBase(
      name: (name != null ? name.value : this.name),
      kind: (kind != null ? kind.value : this.kind),
      mandateYear: (mandateYear != null ? mandateYear.value : this.mandateYear),
      description: (description != null ? description.value : this.description),
      associatedGroups:
          (associatedGroups != null
              ? associatedGroups.value
              : this.associatedGroups),
      deactivated: (deactivated != null ? deactivated.value : this.deactivated),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AssociationComplete {
  const AssociationComplete({
    required this.name,
    required this.kind,
    required this.mandateYear,
    this.description,
    this.associatedGroups,
    this.deactivated,
    required this.id,
  });

  factory AssociationComplete.fromJson(Map<String, dynamic> json) =>
      _$AssociationCompleteFromJson(json);

  static const toJsonFactory = _$AssociationCompleteToJson;
  Map<String, dynamic> toJson() => _$AssociationCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'kind', toJson: kindsToJson, fromJson: kindsFromJson)
  final enums.Kinds kind;
  @JsonKey(name: 'mandate_year', defaultValue: 0)
  final int mandateYear;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'associated_groups', defaultValue: null)
  final List<String>? associatedGroups;
  @JsonKey(name: 'deactivated', defaultValue: false)
  final bool? deactivated;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$AssociationCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssociationComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.mandateYear, mandateYear) ||
                const DeepCollectionEquality().equals(
                  other.mandateYear,
                  mandateYear,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.associatedGroups, associatedGroups) ||
                const DeepCollectionEquality().equals(
                  other.associatedGroups,
                  associatedGroups,
                )) &&
            (identical(other.deactivated, deactivated) ||
                const DeepCollectionEquality().equals(
                  other.deactivated,
                  deactivated,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(mandateYear) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(associatedGroups) ^
      const DeepCollectionEquality().hash(deactivated) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $AssociationCompleteExtension on AssociationComplete {
  AssociationComplete copyWith({
    String? name,
    enums.Kinds? kind,
    int? mandateYear,
    String? description,
    List<String>? associatedGroups,
    bool? deactivated,
    String? id,
  }) {
    return AssociationComplete(
      name: name ?? this.name,
      kind: kind ?? this.kind,
      mandateYear: mandateYear ?? this.mandateYear,
      description: description ?? this.description,
      associatedGroups: associatedGroups ?? this.associatedGroups,
      deactivated: deactivated ?? this.deactivated,
      id: id ?? this.id,
    );
  }

  AssociationComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<enums.Kinds>? kind,
    Wrapped<int>? mandateYear,
    Wrapped<String?>? description,
    Wrapped<List<String>?>? associatedGroups,
    Wrapped<bool?>? deactivated,
    Wrapped<String>? id,
  }) {
    return AssociationComplete(
      name: (name != null ? name.value : this.name),
      kind: (kind != null ? kind.value : this.kind),
      mandateYear: (mandateYear != null ? mandateYear.value : this.mandateYear),
      description: (description != null ? description.value : this.description),
      associatedGroups:
          (associatedGroups != null
              ? associatedGroups.value
              : this.associatedGroups),
      deactivated: (deactivated != null ? deactivated.value : this.deactivated),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AssociationEdit {
  const AssociationEdit({
    this.name,
    this.kind,
    this.description,
    this.mandateYear,
  });

  factory AssociationEdit.fromJson(Map<String, dynamic> json) =>
      _$AssociationEditFromJson(json);

  static const toJsonFactory = _$AssociationEditToJson;
  Map<String, dynamic> toJson() => _$AssociationEditToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(
    name: 'kind',
    toJson: kindsNullableToJson,
    fromJson: kindsNullableFromJson,
  )
  final enums.Kinds? kind;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'mandate_year')
  final int? mandateYear;
  static const fromJsonFactory = _$AssociationEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssociationEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.kind, kind) ||
                const DeepCollectionEquality().equals(other.kind, kind)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.mandateYear, mandateYear) ||
                const DeepCollectionEquality().equals(
                  other.mandateYear,
                  mandateYear,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(kind) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(mandateYear) ^
      runtimeType.hashCode;
}

extension $AssociationEditExtension on AssociationEdit {
  AssociationEdit copyWith({
    String? name,
    enums.Kinds? kind,
    String? description,
    int? mandateYear,
  }) {
    return AssociationEdit(
      name: name ?? this.name,
      kind: kind ?? this.kind,
      description: description ?? this.description,
      mandateYear: mandateYear ?? this.mandateYear,
    );
  }

  AssociationEdit copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<enums.Kinds?>? kind,
    Wrapped<String?>? description,
    Wrapped<int?>? mandateYear,
  }) {
    return AssociationEdit(
      name: (name != null ? name.value : this.name),
      kind: (kind != null ? kind.value : this.kind),
      description: (description != null ? description.value : this.description),
      mandateYear: (mandateYear != null ? mandateYear.value : this.mandateYear),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AssociationGroupsEdit {
  const AssociationGroupsEdit({this.associatedGroups});

  factory AssociationGroupsEdit.fromJson(Map<String, dynamic> json) =>
      _$AssociationGroupsEditFromJson(json);

  static const toJsonFactory = _$AssociationGroupsEditToJson;
  Map<String, dynamic> toJson() => _$AssociationGroupsEditToJson(this);

  @JsonKey(name: 'associated_groups', defaultValue: null)
  final List<String>? associatedGroups;
  static const fromJsonFactory = _$AssociationGroupsEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AssociationGroupsEdit &&
            (identical(other.associatedGroups, associatedGroups) ||
                const DeepCollectionEquality().equals(
                  other.associatedGroups,
                  associatedGroups,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(associatedGroups) ^
      runtimeType.hashCode;
}

extension $AssociationGroupsEditExtension on AssociationGroupsEdit {
  AssociationGroupsEdit copyWith({List<String>? associatedGroups}) {
    return AssociationGroupsEdit(
      associatedGroups: associatedGroups ?? this.associatedGroups,
    );
  }

  AssociationGroupsEdit copyWithWrapped({
    Wrapped<List<String>?>? associatedGroups,
  }) {
    return AssociationGroupsEdit(
      associatedGroups:
          (associatedGroups != null
              ? associatedGroups.value
              : this.associatedGroups),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BatchResult {
  const BatchResult({required this.failed});

  factory BatchResult.fromJson(Map<String, dynamic> json) =>
      _$BatchResultFromJson(json);

  static const toJsonFactory = _$BatchResultToJson;
  Map<String, dynamic> toJson() => _$BatchResultToJson(this);

  @JsonKey(name: 'failed')
  final Map<String, dynamic> failed;
  static const fromJsonFactory = _$BatchResultFromJson;

  @override
  bool operator ==(Object other) {
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
    Map<String, dynamic> json,
  ) =>
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostFromJson(
        json,
      );

  static const toJsonFactory =
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostToJson(
        this,
      );

  @JsonKey(name: 'client_id', defaultValue: '')
  final String clientId;
  @JsonKey(name: 'redirect_uri')
  final String? redirectUri;
  @JsonKey(name: 'response_type', defaultValue: '')
  final String responseType;
  @JsonKey(name: 'scope')
  final String? scope;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'nonce')
  final String? nonce;
  @JsonKey(name: 'code_challenge')
  final String? codeChallenge;
  @JsonKey(name: 'code_challenge_method')
  final String? codeChallengeMethod;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  static const fromJsonFactory =
      _$BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other
                is BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality().equals(
                  other.clientId,
                  clientId,
                )) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality().equals(
                  other.redirectUri,
                  redirectUri,
                )) &&
            (identical(other.responseType, responseType) ||
                const DeepCollectionEquality().equals(
                  other.responseType,
                  responseType,
                )) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.nonce, nonce) ||
                const DeepCollectionEquality().equals(other.nonce, nonce)) &&
            (identical(other.codeChallenge, codeChallenge) ||
                const DeepCollectionEquality().equals(
                  other.codeChallenge,
                  codeChallenge,
                )) &&
            (identical(other.codeChallengeMethod, codeChallengeMethod) ||
                const DeepCollectionEquality().equals(
                  other.codeChallengeMethod,
                  codeChallengeMethod,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
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
  BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost copyWith({
    String? clientId,
    String? redirectUri,
    String? responseType,
    String? scope,
    String? state,
    String? nonce,
    String? codeChallenge,
    String? codeChallengeMethod,
    String? email,
    String? password,
  }) {
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
      password: password ?? this.password,
    );
  }

  BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost
  copyWithWrapped({
    Wrapped<String>? clientId,
    Wrapped<String?>? redirectUri,
    Wrapped<String>? responseType,
    Wrapped<String?>? scope,
    Wrapped<String?>? state,
    Wrapped<String?>? nonce,
    Wrapped<String?>? codeChallenge,
    Wrapped<String?>? codeChallengeMethod,
    Wrapped<String>? email,
    Wrapped<String>? password,
  }) {
    return BodyAuthorizeValidationAuthAuthorizationFlowAuthorizeValidationPost(
      clientId: (clientId != null ? clientId.value : this.clientId),
      redirectUri: (redirectUri != null ? redirectUri.value : this.redirectUri),
      responseType:
          (responseType != null ? responseType.value : this.responseType),
      scope: (scope != null ? scope.value : this.scope),
      state: (state != null ? state.value : this.state),
      nonce: (nonce != null ? nonce.value : this.nonce),
      codeChallenge:
          (codeChallenge != null ? codeChallenge.value : this.codeChallenge),
      codeChallengeMethod:
          (codeChallengeMethod != null
              ? codeChallengeMethod.value
              : this.codeChallengeMethod),
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost {
  const BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost({
    required this.image,
  });

  factory BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostFromJson(json);

  static const toJsonFactory =
      _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePostFromJson;

  @override
  bool operator ==(Object other) {
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
  BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost copyWith({
    String? image,
  }) {
    return BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost(
      image: image ?? this.image,
    );
  }

  BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost copyWithWrapped({
    Wrapped<String>? image,
  }) {
    return BodyCreateAdvertImageAdvertAdvertsAdvertIdPicturePost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost {
  const BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost({
    required this.image,
  });

  factory BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostFromJson(
        json,
      );

  static const toJsonFactory =
      _$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostToJson(
        this,
      );

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other
                is BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePostExtension
    on BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost {
  BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost
  copyWith({String? image}) {
    return BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost(
      image: image ?? this.image,
    );
  }

  BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost
  copyWithWrapped({Wrapped<String>? image}) {
    return BodyCreateAssociationLogoPhonebookAssociationsAssociationIdPicturePost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCampaignsLogoCampaignListsListIdLogoPost {
  const BodyCreateCampaignsLogoCampaignListsListIdLogoPost({
    required this.image,
  });

  factory BodyCreateCampaignsLogoCampaignListsListIdLogoPost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostFromJson(json);

  static const toJsonFactory =
      _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateCampaignsLogoCampaignListsListIdLogoPostFromJson;

  @override
  bool operator ==(Object other) {
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
      image: image ?? this.image,
    );
  }

  BodyCreateCampaignsLogoCampaignListsListIdLogoPost copyWithWrapped({
    Wrapped<String>? image,
  }) {
    return BodyCreateCampaignsLogoCampaignListsListIdLogoPost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost {
  const BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost({
    required this.image,
  });

  factory BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostFromJson(json);

  static const toJsonFactory =
      _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPostFromJson;

  @override
  bool operator ==(Object other) {
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
  BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost copyWith({
    String? image,
  }) {
    return BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost(
      image: image ?? this.image,
    );
  }

  BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost copyWithWrapped({
    Wrapped<String>? image,
  }) {
    return BodyCreateCampaignsLogoCinemaSessionsSessionIdPosterPost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost {
  const BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost({
    required this.image,
  });

  factory BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost.fromJson(
    Map<String, dynamic> json,
  ) =>
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
  bool operator ==(Object other) {
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
  BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost copyWith({
    String? image,
  }) {
    return BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost(
      image: image ?? this.image,
    );
  }

  BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost copyWithWrapped({
    Wrapped<String>? image,
  }) {
    return BodyCreateCurrentRaffleLogoTombolaRafflesRaffleIdLogoPost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost {
  const BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost({
    required this.image,
  });

  factory BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostFromJson(
    json,
  );

  static const toJsonFactory =
      _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostToJson(
        this,
      );

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePostFromJson;

  @override
  bool operator ==(Object other) {
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
  BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost copyWith({
    String? image,
  }) {
    return BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost(
      image: image ?? this.image,
    );
  }

  BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost copyWithWrapped({
    Wrapped<String>? image,
  }) {
    return BodyCreateCurrentUserProfilePictureUsersMeProfilePicturePost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreatePaperPdfAndCoverPhPaperIdPdfPost {
  const BodyCreatePaperPdfAndCoverPhPaperIdPdfPost({required this.pdf});

  factory BodyCreatePaperPdfAndCoverPhPaperIdPdfPost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostFromJson(json);

  static const toJsonFactory =
      _$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostToJson(this);

  @JsonKey(name: 'pdf', defaultValue: '')
  final String pdf;
  static const fromJsonFactory =
      _$BodyCreatePaperPdfAndCoverPhPaperIdPdfPostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyCreatePaperPdfAndCoverPhPaperIdPdfPost &&
            (identical(other.pdf, pdf) ||
                const DeepCollectionEquality().equals(other.pdf, pdf)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pdf) ^ runtimeType.hashCode;
}

extension $BodyCreatePaperPdfAndCoverPhPaperIdPdfPostExtension
    on BodyCreatePaperPdfAndCoverPhPaperIdPdfPost {
  BodyCreatePaperPdfAndCoverPhPaperIdPdfPost copyWith({String? pdf}) {
    return BodyCreatePaperPdfAndCoverPhPaperIdPdfPost(pdf: pdf ?? this.pdf);
  }

  BodyCreatePaperPdfAndCoverPhPaperIdPdfPost copyWithWrapped({
    Wrapped<String>? pdf,
  }) {
    return BodyCreatePaperPdfAndCoverPhPaperIdPdfPost(
      pdf: (pdf != null ? pdf.value : this.pdf),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost {
  const BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost({
    required this.image,
  });

  factory BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostFromJson(json);

  static const toJsonFactory =
      _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostToJson(this);

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePostFromJson;

  @override
  bool operator ==(Object other) {
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
  BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost copyWith({
    String? image,
  }) {
    return BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost(
      image: image ?? this.image,
    );
  }

  BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost copyWithWrapped({
    Wrapped<String>? image,
  }) {
    return BodyCreatePrizePictureTombolaPrizesPrizeIdPicturePost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost {
  const BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost({
    required this.image,
  });

  factory BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostFromJson(
        json,
      );

  static const toJsonFactory =
      _$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostToJson(
        this,
      );

  @JsonKey(name: 'image', defaultValue: '')
  final String image;
  static const fromJsonFactory =
      _$BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other
                is BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(image) ^ runtimeType.hashCode;
}

extension $BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePostExtension
    on
        BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost {
  BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost
  copyWith({String? image}) {
    return BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost(
      image: image ?? this.image,
    );
  }

  BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost
  copyWithWrapped({Wrapped<String>? image}) {
    return BodyCreateRecommendationImageRecommendationRecommendationsRecommendationIdPicturePost(
      image: (image != null ? image.value : this.image),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyIntrospectAuthIntrospectPost {
  const BodyIntrospectAuthIntrospectPost({
    required this.token,
    this.tokenTypeHint,
    this.clientId,
    this.clientSecret,
  });

  factory BodyIntrospectAuthIntrospectPost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyIntrospectAuthIntrospectPostFromJson(json);

  static const toJsonFactory = _$BodyIntrospectAuthIntrospectPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyIntrospectAuthIntrospectPostToJson(this);

  @JsonKey(name: 'token', defaultValue: '')
  final String token;
  @JsonKey(name: 'token_type_hint')
  final String? tokenTypeHint;
  @JsonKey(name: 'client_id')
  final String? clientId;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  static const fromJsonFactory = _$BodyIntrospectAuthIntrospectPostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyIntrospectAuthIntrospectPost &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.tokenTypeHint, tokenTypeHint) ||
                const DeepCollectionEquality().equals(
                  other.tokenTypeHint,
                  tokenTypeHint,
                )) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality().equals(
                  other.clientId,
                  clientId,
                )) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality().equals(
                  other.clientSecret,
                  clientSecret,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(tokenTypeHint) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(clientSecret) ^
      runtimeType.hashCode;
}

extension $BodyIntrospectAuthIntrospectPostExtension
    on BodyIntrospectAuthIntrospectPost {
  BodyIntrospectAuthIntrospectPost copyWith({
    String? token,
    String? tokenTypeHint,
    String? clientId,
    String? clientSecret,
  }) {
    return BodyIntrospectAuthIntrospectPost(
      token: token ?? this.token,
      tokenTypeHint: tokenTypeHint ?? this.tokenTypeHint,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
    );
  }

  BodyIntrospectAuthIntrospectPost copyWithWrapped({
    Wrapped<String>? token,
    Wrapped<String?>? tokenTypeHint,
    Wrapped<String?>? clientId,
    Wrapped<String?>? clientSecret,
  }) {
    return BodyIntrospectAuthIntrospectPost(
      token: (token != null ? token.value : this.token),
      tokenTypeHint:
          (tokenTypeHint != null ? tokenTypeHint.value : this.tokenTypeHint),
      clientId: (clientId != null ? clientId.value : this.clientId),
      clientSecret:
          (clientSecret != null ? clientSecret.value : this.clientSecret),
    );
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
    Map<String, dynamic> json,
  ) => _$BodyLoginForAccessTokenAuthSimpleTokenPostFromJson(json);

  static const toJsonFactory =
      _$BodyLoginForAccessTokenAuthSimpleTokenPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyLoginForAccessTokenAuthSimpleTokenPostToJson(this);

  @JsonKey(name: 'grant_type')
  final String? grantType;
  @JsonKey(name: 'username', defaultValue: '')
  final String username;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  @JsonKey(name: 'scope', defaultValue: '')
  final String? scope;
  @JsonKey(name: 'client_id')
  final String? clientId;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  static const fromJsonFactory =
      _$BodyLoginForAccessTokenAuthSimpleTokenPostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyLoginForAccessTokenAuthSimpleTokenPost &&
            (identical(other.grantType, grantType) ||
                const DeepCollectionEquality().equals(
                  other.grantType,
                  grantType,
                )) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality().equals(
                  other.clientId,
                  clientId,
                )) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality().equals(
                  other.clientSecret,
                  clientSecret,
                )));
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
  BodyLoginForAccessTokenAuthSimpleTokenPost copyWith({
    String? grantType,
    String? username,
    String? password,
    String? scope,
    String? clientId,
    String? clientSecret,
  }) {
    return BodyLoginForAccessTokenAuthSimpleTokenPost(
      grantType: grantType ?? this.grantType,
      username: username ?? this.username,
      password: password ?? this.password,
      scope: scope ?? this.scope,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
    );
  }

  BodyLoginForAccessTokenAuthSimpleTokenPost copyWithWrapped({
    Wrapped<String?>? grantType,
    Wrapped<String>? username,
    Wrapped<String>? password,
    Wrapped<String?>? scope,
    Wrapped<String?>? clientId,
    Wrapped<String?>? clientSecret,
  }) {
    return BodyLoginForAccessTokenAuthSimpleTokenPost(
      grantType: (grantType != null ? grantType.value : this.grantType),
      username: (username != null ? username.value : this.username),
      password: (password != null ? password.value : this.password),
      scope: (scope != null ? scope.value : this.scope),
      clientId: (clientId != null ? clientId.value : this.clientId),
      clientSecret:
          (clientSecret != null ? clientSecret.value : this.clientSecret),
    );
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
    Map<String, dynamic> json,
  ) => _$BodyPostAuthorizePageAuthAuthorizePostFromJson(json);

  static const toJsonFactory = _$BodyPostAuthorizePageAuthAuthorizePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyPostAuthorizePageAuthAuthorizePostToJson(this);

  @JsonKey(name: 'response_type', defaultValue: '')
  final String responseType;
  @JsonKey(name: 'client_id', defaultValue: '')
  final String clientId;
  @JsonKey(name: 'redirect_uri', defaultValue: '')
  final String redirectUri;
  @JsonKey(name: 'scope')
  final String? scope;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'nonce')
  final String? nonce;
  @JsonKey(name: 'code_challenge')
  final String? codeChallenge;
  @JsonKey(name: 'code_challenge_method')
  final String? codeChallengeMethod;
  static const fromJsonFactory =
      _$BodyPostAuthorizePageAuthAuthorizePostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyPostAuthorizePageAuthAuthorizePost &&
            (identical(other.responseType, responseType) ||
                const DeepCollectionEquality().equals(
                  other.responseType,
                  responseType,
                )) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality().equals(
                  other.clientId,
                  clientId,
                )) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality().equals(
                  other.redirectUri,
                  redirectUri,
                )) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.nonce, nonce) ||
                const DeepCollectionEquality().equals(other.nonce, nonce)) &&
            (identical(other.codeChallenge, codeChallenge) ||
                const DeepCollectionEquality().equals(
                  other.codeChallenge,
                  codeChallenge,
                )) &&
            (identical(other.codeChallengeMethod, codeChallengeMethod) ||
                const DeepCollectionEquality().equals(
                  other.codeChallengeMethod,
                  codeChallengeMethod,
                )));
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
  BodyPostAuthorizePageAuthAuthorizePost copyWith({
    String? responseType,
    String? clientId,
    String? redirectUri,
    String? scope,
    String? state,
    String? nonce,
    String? codeChallenge,
    String? codeChallengeMethod,
  }) {
    return BodyPostAuthorizePageAuthAuthorizePost(
      responseType: responseType ?? this.responseType,
      clientId: clientId ?? this.clientId,
      redirectUri: redirectUri ?? this.redirectUri,
      scope: scope ?? this.scope,
      state: state ?? this.state,
      nonce: nonce ?? this.nonce,
      codeChallenge: codeChallenge ?? this.codeChallenge,
      codeChallengeMethod: codeChallengeMethod ?? this.codeChallengeMethod,
    );
  }

  BodyPostAuthorizePageAuthAuthorizePost copyWithWrapped({
    Wrapped<String>? responseType,
    Wrapped<String>? clientId,
    Wrapped<String>? redirectUri,
    Wrapped<String?>? scope,
    Wrapped<String?>? state,
    Wrapped<String?>? nonce,
    Wrapped<String?>? codeChallenge,
    Wrapped<String?>? codeChallengeMethod,
  }) {
    return BodyPostAuthorizePageAuthAuthorizePost(
      responseType:
          (responseType != null ? responseType.value : this.responseType),
      clientId: (clientId != null ? clientId.value : this.clientId),
      redirectUri: (redirectUri != null ? redirectUri.value : this.redirectUri),
      scope: (scope != null ? scope.value : this.scope),
      state: (state != null ? state.value : this.state),
      nonce: (nonce != null ? nonce.value : this.nonce),
      codeChallenge:
          (codeChallenge != null ? codeChallenge.value : this.codeChallenge),
      codeChallengeMethod:
          (codeChallengeMethod != null
              ? codeChallengeMethod.value
              : this.codeChallengeMethod),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyReadAssociationsMembershipsMembershipsGet {
  const BodyReadAssociationsMembershipsMembershipsGet({
    this.excludedGroups,
    this.includedGroups,
    this.excludedAccountTypes,
    this.includedAccountTypes,
  });

  factory BodyReadAssociationsMembershipsMembershipsGet.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyReadAssociationsMembershipsMembershipsGetFromJson(json);

  static const toJsonFactory =
      _$BodyReadAssociationsMembershipsMembershipsGetToJson;
  Map<String, dynamic> toJson() =>
      _$BodyReadAssociationsMembershipsMembershipsGetToJson(this);

  @JsonKey(name: 'excluded_groups')
  final List<enums.GroupType>? excludedGroups;
  @JsonKey(name: 'included_groups')
  final List<enums.GroupType>? includedGroups;
  @JsonKey(name: 'excluded_account_types')
  final List<enums.AccountType>? excludedAccountTypes;
  @JsonKey(name: 'included_account_types')
  final List<enums.AccountType>? includedAccountTypes;
  static const fromJsonFactory =
      _$BodyReadAssociationsMembershipsMembershipsGetFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyReadAssociationsMembershipsMembershipsGet &&
            (identical(other.excludedGroups, excludedGroups) ||
                const DeepCollectionEquality().equals(
                  other.excludedGroups,
                  excludedGroups,
                )) &&
            (identical(other.includedGroups, includedGroups) ||
                const DeepCollectionEquality().equals(
                  other.includedGroups,
                  includedGroups,
                )) &&
            (identical(other.excludedAccountTypes, excludedAccountTypes) ||
                const DeepCollectionEquality().equals(
                  other.excludedAccountTypes,
                  excludedAccountTypes,
                )) &&
            (identical(other.includedAccountTypes, includedAccountTypes) ||
                const DeepCollectionEquality().equals(
                  other.includedAccountTypes,
                  includedAccountTypes,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(excludedGroups) ^
      const DeepCollectionEquality().hash(includedGroups) ^
      const DeepCollectionEquality().hash(excludedAccountTypes) ^
      const DeepCollectionEquality().hash(includedAccountTypes) ^
      runtimeType.hashCode;
}

extension $BodyReadAssociationsMembershipsMembershipsGetExtension
    on BodyReadAssociationsMembershipsMembershipsGet {
  BodyReadAssociationsMembershipsMembershipsGet copyWith({
    List<enums.GroupType>? excludedGroups,
    List<enums.GroupType>? includedGroups,
    List<enums.AccountType>? excludedAccountTypes,
    List<enums.AccountType>? includedAccountTypes,
  }) {
    return BodyReadAssociationsMembershipsMembershipsGet(
      excludedGroups: excludedGroups ?? this.excludedGroups,
      includedGroups: includedGroups ?? this.includedGroups,
      excludedAccountTypes: excludedAccountTypes ?? this.excludedAccountTypes,
      includedAccountTypes: includedAccountTypes ?? this.includedAccountTypes,
    );
  }

  BodyReadAssociationsMembershipsMembershipsGet copyWithWrapped({
    Wrapped<List<enums.GroupType>?>? excludedGroups,
    Wrapped<List<enums.GroupType>?>? includedGroups,
    Wrapped<List<enums.AccountType>?>? excludedAccountTypes,
    Wrapped<List<enums.AccountType>?>? includedAccountTypes,
  }) {
    return BodyReadAssociationsMembershipsMembershipsGet(
      excludedGroups:
          (excludedGroups != null ? excludedGroups.value : this.excludedGroups),
      includedGroups:
          (includedGroups != null ? includedGroups.value : this.includedGroups),
      excludedAccountTypes:
          (excludedAccountTypes != null
              ? excludedAccountTypes.value
              : this.excludedAccountTypes),
      includedAccountTypes:
          (includedAccountTypes != null
              ? includedAccountTypes.value
              : this.includedAccountTypes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyRecoverUserUsersRecoverPost {
  const BodyRecoverUserUsersRecoverPost({required this.email});

  factory BodyRecoverUserUsersRecoverPost.fromJson(Map<String, dynamic> json) =>
      _$BodyRecoverUserUsersRecoverPostFromJson(json);

  static const toJsonFactory = _$BodyRecoverUserUsersRecoverPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyRecoverUserUsersRecoverPostToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  static const fromJsonFactory = _$BodyRecoverUserUsersRecoverPostFromJson;

  @override
  bool operator ==(Object other) {
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
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyRegisterFirebaseDeviceNotificationDevicesPost {
  const BodyRegisterFirebaseDeviceNotificationDevicesPost({
    required this.firebaseToken,
  });

  factory BodyRegisterFirebaseDeviceNotificationDevicesPost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyRegisterFirebaseDeviceNotificationDevicesPostFromJson(json);

  static const toJsonFactory =
      _$BodyRegisterFirebaseDeviceNotificationDevicesPostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyRegisterFirebaseDeviceNotificationDevicesPostToJson(this);

  @JsonKey(name: 'firebase_token', defaultValue: '')
  final String firebaseToken;
  static const fromJsonFactory =
      _$BodyRegisterFirebaseDeviceNotificationDevicesPostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyRegisterFirebaseDeviceNotificationDevicesPost &&
            (identical(other.firebaseToken, firebaseToken) ||
                const DeepCollectionEquality().equals(
                  other.firebaseToken,
                  firebaseToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firebaseToken) ^ runtimeType.hashCode;
}

extension $BodyRegisterFirebaseDeviceNotificationDevicesPostExtension
    on BodyRegisterFirebaseDeviceNotificationDevicesPost {
  BodyRegisterFirebaseDeviceNotificationDevicesPost copyWith({
    String? firebaseToken,
  }) {
    return BodyRegisterFirebaseDeviceNotificationDevicesPost(
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
  }

  BodyRegisterFirebaseDeviceNotificationDevicesPost copyWithWrapped({
    Wrapped<String>? firebaseToken,
  }) {
    return BodyRegisterFirebaseDeviceNotificationDevicesPost(
      firebaseToken:
          (firebaseToken != null ? firebaseToken.value : this.firebaseToken),
    );
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

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'grant_type', defaultValue: '')
  final String grantType;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'redirect_uri')
  final String? redirectUri;
  @JsonKey(name: 'client_id')
  final String? clientId;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  @JsonKey(name: 'code_verifier')
  final String? codeVerifier;
  static const fromJsonFactory = _$BodyTokenAuthTokenPostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyTokenAuthTokenPost &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality().equals(
                  other.refreshToken,
                  refreshToken,
                )) &&
            (identical(other.grantType, grantType) ||
                const DeepCollectionEquality().equals(
                  other.grantType,
                  grantType,
                )) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality().equals(
                  other.redirectUri,
                  redirectUri,
                )) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality().equals(
                  other.clientId,
                  clientId,
                )) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality().equals(
                  other.clientSecret,
                  clientSecret,
                )) &&
            (identical(other.codeVerifier, codeVerifier) ||
                const DeepCollectionEquality().equals(
                  other.codeVerifier,
                  codeVerifier,
                )));
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
  BodyTokenAuthTokenPost copyWith({
    String? refreshToken,
    String? grantType,
    String? code,
    String? redirectUri,
    String? clientId,
    String? clientSecret,
    String? codeVerifier,
  }) {
    return BodyTokenAuthTokenPost(
      refreshToken: refreshToken ?? this.refreshToken,
      grantType: grantType ?? this.grantType,
      code: code ?? this.code,
      redirectUri: redirectUri ?? this.redirectUri,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      codeVerifier: codeVerifier ?? this.codeVerifier,
    );
  }

  BodyTokenAuthTokenPost copyWithWrapped({
    Wrapped<String?>? refreshToken,
    Wrapped<String>? grantType,
    Wrapped<String?>? code,
    Wrapped<String?>? redirectUri,
    Wrapped<String?>? clientId,
    Wrapped<String?>? clientSecret,
    Wrapped<String?>? codeVerifier,
  }) {
    return BodyTokenAuthTokenPost(
      refreshToken:
          (refreshToken != null ? refreshToken.value : this.refreshToken),
      grantType: (grantType != null ? grantType.value : this.grantType),
      code: (code != null ? code.value : this.code),
      redirectUri: (redirectUri != null ? redirectUri.value : this.redirectUri),
      clientId: (clientId != null ? clientId.value : this.clientId),
      clientSecret:
          (clientSecret != null ? clientSecret.value : this.clientSecret),
      codeVerifier:
          (codeVerifier != null ? codeVerifier.value : this.codeVerifier),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BodyUploadDocumentRaidDocumentDocumentTypePost {
  const BodyUploadDocumentRaidDocumentDocumentTypePost({required this.file});

  factory BodyUploadDocumentRaidDocumentDocumentTypePost.fromJson(
    Map<String, dynamic> json,
  ) => _$BodyUploadDocumentRaidDocumentDocumentTypePostFromJson(json);

  static const toJsonFactory =
      _$BodyUploadDocumentRaidDocumentDocumentTypePostToJson;
  Map<String, dynamic> toJson() =>
      _$BodyUploadDocumentRaidDocumentDocumentTypePostToJson(this);

  @JsonKey(name: 'file', defaultValue: '')
  final String file;
  static const fromJsonFactory =
      _$BodyUploadDocumentRaidDocumentDocumentTypePostFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BodyUploadDocumentRaidDocumentDocumentTypePost &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $BodyUploadDocumentRaidDocumentDocumentTypePostExtension
    on BodyUploadDocumentRaidDocumentDocumentTypePost {
  BodyUploadDocumentRaidDocumentDocumentTypePost copyWith({String? file}) {
    return BodyUploadDocumentRaidDocumentDocumentTypePost(
      file: file ?? this.file,
    );
  }

  BodyUploadDocumentRaidDocumentDocumentTypePost copyWithWrapped({
    Wrapped<String>? file,
  }) {
    return BodyUploadDocumentRaidDocumentDocumentTypePost(
      file: (file != null ? file.value : this.file),
    );
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
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  @JsonKey(name: 'entity')
  final String? entity;
  static const fromJsonFactory = _$BookingBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookingBase &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )) &&
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
  BookingBase copyWith({
    String? reason,
    DateTime? start,
    DateTime? end,
    DateTime? creation,
    String? note,
    String? roomId,
    bool? key,
    String? recurrenceRule,
    String? entity,
  }) {
    return BookingBase(
      reason: reason ?? this.reason,
      start: start ?? this.start,
      end: end ?? this.end,
      creation: creation ?? this.creation,
      note: note ?? this.note,
      roomId: roomId ?? this.roomId,
      key: key ?? this.key,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      entity: entity ?? this.entity,
    );
  }

  BookingBase copyWithWrapped({
    Wrapped<String>? reason,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<DateTime>? creation,
    Wrapped<String?>? note,
    Wrapped<String>? roomId,
    Wrapped<bool>? key,
    Wrapped<String?>? recurrenceRule,
    Wrapped<String?>? entity,
  }) {
    return BookingBase(
      reason: (reason != null ? reason.value : this.reason),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      creation: (creation != null ? creation.value : this.creation),
      note: (note != null ? note.value : this.note),
      roomId: (roomId != null ? roomId.value : this.roomId),
      key: (key != null ? key.value : this.key),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
      entity: (entity != null ? entity.value : this.entity),
    );
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

  @JsonKey(name: 'reason')
  final String? reason;
  @JsonKey(name: 'start')
  final String? start;
  @JsonKey(name: 'end')
  final String? end;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'room_id')
  final String? roomId;
  @JsonKey(name: 'key')
  final bool? key;
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  @JsonKey(name: 'entity')
  final String? entity;
  static const fromJsonFactory = _$BookingEditFromJson;

  @override
  bool operator ==(Object other) {
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
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )) &&
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
  BookingEdit copyWith({
    String? reason,
    String? start,
    String? end,
    String? note,
    String? roomId,
    bool? key,
    String? recurrenceRule,
    String? entity,
  }) {
    return BookingEdit(
      reason: reason ?? this.reason,
      start: start ?? this.start,
      end: end ?? this.end,
      note: note ?? this.note,
      roomId: roomId ?? this.roomId,
      key: key ?? this.key,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      entity: entity ?? this.entity,
    );
  }

  BookingEdit copyWithWrapped({
    Wrapped<String?>? reason,
    Wrapped<String?>? start,
    Wrapped<String?>? end,
    Wrapped<String?>? note,
    Wrapped<String?>? roomId,
    Wrapped<bool?>? key,
    Wrapped<String?>? recurrenceRule,
    Wrapped<String?>? entity,
  }) {
    return BookingEdit(
      reason: (reason != null ? reason.value : this.reason),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      note: (note != null ? note.value : this.note),
      roomId: (roomId != null ? roomId.value : this.roomId),
      key: (key != null ? key.value : this.key),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
      entity: (entity != null ? entity.value : this.entity),
    );
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
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  @JsonKey(name: 'entity')
  final String? entity;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'decision', toJson: decisionToJson, fromJson: decisionFromJson)
  final enums.Decision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'room')
  final RoomComplete room;
  static const fromJsonFactory = _$BookingReturnFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookingReturn &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality().equals(
                  other.decision,
                  decision,
                )) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(
                  other.applicantId,
                  applicantId,
                )) &&
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
  BookingReturn copyWith({
    String? reason,
    DateTime? start,
    DateTime? end,
    DateTime? creation,
    String? note,
    String? roomId,
    bool? key,
    String? recurrenceRule,
    String? entity,
    String? id,
    enums.Decision? decision,
    String? applicantId,
    RoomComplete? room,
  }) {
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
      room: room ?? this.room,
    );
  }

  BookingReturn copyWithWrapped({
    Wrapped<String>? reason,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<DateTime>? creation,
    Wrapped<String?>? note,
    Wrapped<String>? roomId,
    Wrapped<bool>? key,
    Wrapped<String?>? recurrenceRule,
    Wrapped<String?>? entity,
    Wrapped<String>? id,
    Wrapped<enums.Decision>? decision,
    Wrapped<String>? applicantId,
    Wrapped<RoomComplete>? room,
  }) {
    return BookingReturn(
      reason: (reason != null ? reason.value : this.reason),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      creation: (creation != null ? creation.value : this.creation),
      note: (note != null ? note.value : this.note),
      roomId: (roomId != null ? roomId.value : this.roomId),
      key: (key != null ? key.value : this.key),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
      entity: (entity != null ? entity.value : this.entity),
      id: (id != null ? id.value : this.id),
      decision: (decision != null ? decision.value : this.decision),
      applicantId: (applicantId != null ? applicantId.value : this.applicantId),
      room: (room != null ? room.value : this.room),
    );
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
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  @JsonKey(name: 'entity')
  final String? entity;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'decision', toJson: decisionToJson, fromJson: decisionFromJson)
  final enums.Decision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'room')
  final RoomComplete room;
  @JsonKey(name: 'applicant')
  final Applicant applicant;
  static const fromJsonFactory = _$BookingReturnApplicantFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookingReturnApplicant &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality().equals(
                  other.decision,
                  decision,
                )) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(
                  other.applicantId,
                  applicantId,
                )) &&
            (identical(other.room, room) ||
                const DeepCollectionEquality().equals(other.room, room)) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality().equals(
                  other.applicant,
                  applicant,
                )));
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
  BookingReturnApplicant copyWith({
    String? reason,
    DateTime? start,
    DateTime? end,
    DateTime? creation,
    String? note,
    String? roomId,
    bool? key,
    String? recurrenceRule,
    String? entity,
    String? id,
    enums.Decision? decision,
    String? applicantId,
    RoomComplete? room,
    Applicant? applicant,
  }) {
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
      applicant: applicant ?? this.applicant,
    );
  }

  BookingReturnApplicant copyWithWrapped({
    Wrapped<String>? reason,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<DateTime>? creation,
    Wrapped<String?>? note,
    Wrapped<String>? roomId,
    Wrapped<bool>? key,
    Wrapped<String?>? recurrenceRule,
    Wrapped<String?>? entity,
    Wrapped<String>? id,
    Wrapped<enums.Decision>? decision,
    Wrapped<String>? applicantId,
    Wrapped<RoomComplete>? room,
    Wrapped<Applicant>? applicant,
  }) {
    return BookingReturnApplicant(
      reason: (reason != null ? reason.value : this.reason),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      creation: (creation != null ? creation.value : this.creation),
      note: (note != null ? note.value : this.note),
      roomId: (roomId != null ? roomId.value : this.roomId),
      key: (key != null ? key.value : this.key),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
      entity: (entity != null ? entity.value : this.entity),
      id: (id != null ? id.value : this.id),
      decision: (decision != null ? decision.value : this.decision),
      applicantId: (applicantId != null ? applicantId.value : this.applicantId),
      room: (room != null ? room.value : this.room),
      applicant: (applicant != null ? applicant.value : this.applicant),
    );
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
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'room_id', defaultValue: '')
  final String roomId;
  @JsonKey(name: 'key', defaultValue: false)
  final bool key;
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  @JsonKey(name: 'entity')
  final String? entity;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'decision', toJson: decisionToJson, fromJson: decisionFromJson)
  final enums.Decision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'room')
  final RoomComplete room;
  @JsonKey(name: 'applicant')
  final CoreUserSimple applicant;
  static const fromJsonFactory = _$BookingReturnSimpleApplicantFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BookingReturnSimpleApplicant &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )) &&
            (identical(other.entity, entity) ||
                const DeepCollectionEquality().equals(other.entity, entity)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality().equals(
                  other.decision,
                  decision,
                )) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(
                  other.applicantId,
                  applicantId,
                )) &&
            (identical(other.room, room) ||
                const DeepCollectionEquality().equals(other.room, room)) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality().equals(
                  other.applicant,
                  applicant,
                )));
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
  BookingReturnSimpleApplicant copyWith({
    String? reason,
    DateTime? start,
    DateTime? end,
    DateTime? creation,
    String? note,
    String? roomId,
    bool? key,
    String? recurrenceRule,
    String? entity,
    String? id,
    enums.Decision? decision,
    String? applicantId,
    RoomComplete? room,
    CoreUserSimple? applicant,
  }) {
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
      applicant: applicant ?? this.applicant,
    );
  }

  BookingReturnSimpleApplicant copyWithWrapped({
    Wrapped<String>? reason,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<DateTime>? creation,
    Wrapped<String?>? note,
    Wrapped<String>? roomId,
    Wrapped<bool>? key,
    Wrapped<String?>? recurrenceRule,
    Wrapped<String?>? entity,
    Wrapped<String>? id,
    Wrapped<enums.Decision>? decision,
    Wrapped<String>? applicantId,
    Wrapped<RoomComplete>? room,
    Wrapped<CoreUserSimple>? applicant,
  }) {
    return BookingReturnSimpleApplicant(
      reason: (reason != null ? reason.value : this.reason),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      creation: (creation != null ? creation.value : this.creation),
      note: (note != null ? note.value : this.note),
      roomId: (roomId != null ? roomId.value : this.roomId),
      key: (key != null ? key.value : this.key),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
      entity: (entity != null ? entity.value : this.entity),
      id: (id != null ? id.value : this.id),
      decision: (decision != null ? decision.value : this.decision),
      applicantId: (applicantId != null ? applicantId.value : this.applicantId),
      room: (room != null ? room.value : this.room),
      applicant: (applicant != null ? applicant.value : this.applicant),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CashComplete {
  const CashComplete({
    required this.balance,
    required this.userId,
    required this.user,
  });

  factory CashComplete.fromJson(Map<String, dynamic> json) =>
      _$CashCompleteFromJson(json);

  static const toJsonFactory = _$CashCompleteToJson;
  Map<String, dynamic> toJson() => _$CashCompleteToJson(this);

  @JsonKey(name: 'balance', defaultValue: 0.0)
  final double balance;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  static const fromJsonFactory = _$CashCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CashComplete &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(
                  other.balance,
                  balance,
                )) &&
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

extension $CashCompleteExtension on CashComplete {
  CashComplete copyWith({
    double? balance,
    String? userId,
    CoreUserSimple? user,
  }) {
    return CashComplete(
      balance: balance ?? this.balance,
      userId: userId ?? this.userId,
      user: user ?? this.user,
    );
  }

  CashComplete copyWithWrapped({
    Wrapped<double>? balance,
    Wrapped<String>? userId,
    Wrapped<CoreUserSimple>? user,
  }) {
    return CashComplete(
      balance: (balance != null ? balance.value : this.balance),
      userId: (userId != null ? userId.value : this.userId),
      user: (user != null ? user.value : this.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CashEdit {
  const CashEdit({required this.balance});

  factory CashEdit.fromJson(Map<String, dynamic> json) =>
      _$CashEditFromJson(json);

  static const toJsonFactory = _$CashEditToJson;
  Map<String, dynamic> toJson() => _$CashEditToJson(this);

  @JsonKey(name: 'balance', defaultValue: 0.0)
  final double balance;
  static const fromJsonFactory = _$CashEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CashEdit &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(other.balance, balance)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^ runtimeType.hashCode;
}

extension $CashEditExtension on CashEdit {
  CashEdit copyWith({double? balance}) {
    return CashEdit(balance: balance ?? this.balance);
  }

  CashEdit copyWithWrapped({Wrapped<double>? balance}) {
    return CashEdit(balance: (balance != null ? balance.value : this.balance));
  }
}

@JsonSerializable(explicitToJson: true)
class CdrUser {
  const CdrUser({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
    this.curriculum,
    this.promo,
    required this.email,
    this.birthday,
    this.phone,
    this.floor,
  });

  factory CdrUser.fromJson(Map<String, dynamic> json) =>
      _$CdrUserFromJson(json);

  static const toJsonFactory = _$CdrUserToJson;
  Map<String, dynamic> toJson() => _$CdrUserToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  @JsonKey(name: 'curriculum')
  final CurriculumComplete? curriculum;
  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  static const fromJsonFactory = _$CdrUserFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CdrUser &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
            (identical(other.curriculum, curriculum) ||
                const DeepCollectionEquality().equals(
                  other.curriculum,
                  curriculum,
                )) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
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
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(curriculum) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(floor) ^
      runtimeType.hashCode;
}

extension $CdrUserExtension on CdrUser {
  CdrUser copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
    CurriculumComplete? curriculum,
    int? promo,
    String? email,
    String? birthday,
    String? phone,
    enums.FloorsType? floor,
  }) {
    return CdrUser(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
      curriculum: curriculum ?? this.curriculum,
      promo: promo ?? this.promo,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      floor: floor ?? this.floor,
    );
  }

  CdrUser copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
    Wrapped<CurriculumComplete?>? curriculum,
    Wrapped<int?>? promo,
    Wrapped<String>? email,
    Wrapped<String?>? birthday,
    Wrapped<String?>? phone,
    Wrapped<enums.FloorsType?>? floor,
  }) {
    return CdrUser(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      curriculum: (curriculum != null ? curriculum.value : this.curriculum),
      promo: (promo != null ? promo.value : this.promo),
      email: (email != null ? email.value : this.email),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      floor: (floor != null ? floor.value : this.floor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CdrUserPreview {
  const CdrUserPreview({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
    this.curriculum,
  });

  factory CdrUserPreview.fromJson(Map<String, dynamic> json) =>
      _$CdrUserPreviewFromJson(json);

  static const toJsonFactory = _$CdrUserPreviewToJson;
  Map<String, dynamic> toJson() => _$CdrUserPreviewToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  @JsonKey(name: 'curriculum')
  final CurriculumComplete? curriculum;
  static const fromJsonFactory = _$CdrUserPreviewFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CdrUserPreview &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
            (identical(other.curriculum, curriculum) ||
                const DeepCollectionEquality().equals(
                  other.curriculum,
                  curriculum,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(curriculum) ^
      runtimeType.hashCode;
}

extension $CdrUserPreviewExtension on CdrUserPreview {
  CdrUserPreview copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
    CurriculumComplete? curriculum,
  }) {
    return CdrUserPreview(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
      curriculum: curriculum ?? this.curriculum,
    );
  }

  CdrUserPreview copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
    Wrapped<CurriculumComplete?>? curriculum,
  }) {
    return CdrUserPreview(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      curriculum: (curriculum != null ? curriculum.value : this.curriculum),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CdrUserUpdate {
  const CdrUserUpdate({
    this.promo,
    this.nickname,
    this.email,
    this.birthday,
    this.phone,
    this.floor,
  });

  factory CdrUserUpdate.fromJson(Map<String, dynamic> json) =>
      _$CdrUserUpdateFromJson(json);

  static const toJsonFactory = _$CdrUserUpdateToJson;
  Map<String, dynamic> toJson() => _$CdrUserUpdateToJson(this);

  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  static const fromJsonFactory = _$CdrUserUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CdrUserUpdate &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(floor) ^
      runtimeType.hashCode;
}

extension $CdrUserUpdateExtension on CdrUserUpdate {
  CdrUserUpdate copyWith({
    int? promo,
    String? nickname,
    String? email,
    String? birthday,
    String? phone,
    enums.FloorsType? floor,
  }) {
    return CdrUserUpdate(
      promo: promo ?? this.promo,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      floor: floor ?? this.floor,
    );
  }

  CdrUserUpdate copyWithWrapped({
    Wrapped<int?>? promo,
    Wrapped<String?>? nickname,
    Wrapped<String?>? email,
    Wrapped<String?>? birthday,
    Wrapped<String?>? phone,
    Wrapped<enums.FloorsType?>? floor,
  }) {
    return CdrUserUpdate(
      promo: (promo != null ? promo.value : this.promo),
      nickname: (nickname != null ? nickname.value : this.nickname),
      email: (email != null ? email.value : this.email),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      floor: (floor != null ? floor.value : this.floor),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChangePasswordRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.oldPassword, oldPassword) ||
                const DeepCollectionEquality().equals(
                  other.oldPassword,
                  oldPassword,
                )) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality().equals(
                  other.newPassword,
                  newPassword,
                )));
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
  ChangePasswordRequest copyWith({
    String? email,
    String? oldPassword,
    String? newPassword,
  }) {
    return ChangePasswordRequest(
      email: email ?? this.email,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  ChangePasswordRequest copyWithWrapped({
    Wrapped<String>? email,
    Wrapped<String>? oldPassword,
    Wrapped<String>? newPassword,
  }) {
    return ChangePasswordRequest(
      email: (email != null ? email.value : this.email),
      oldPassword: (oldPassword != null ? oldPassword.value : this.oldPassword),
      newPassword: (newPassword != null ? newPassword.value : this.newPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CheckoutComplete {
  const CheckoutComplete({
    required this.id,
    required this.module,
    required this.name,
    required this.amount,
    required this.payments,
    this.paymentCompleted,
  });

  factory CheckoutComplete.fromJson(Map<String, dynamic> json) =>
      _$CheckoutCompleteFromJson(json);

  static const toJsonFactory = _$CheckoutCompleteToJson;
  Map<String, dynamic> toJson() => _$CheckoutCompleteToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'module', defaultValue: '')
  final String module;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'amount', defaultValue: 0)
  final int amount;
  @JsonKey(name: 'payments', defaultValue: <CheckoutPayment>[])
  final List<CheckoutPayment> payments;
  @JsonKey(name: 'payment_completed', defaultValue: false)
  final bool? paymentCompleted;
  static const fromJsonFactory = _$CheckoutCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CheckoutComplete &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.module, module) ||
                const DeepCollectionEquality().equals(other.module, module)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.payments, payments) ||
                const DeepCollectionEquality().equals(
                  other.payments,
                  payments,
                )) &&
            (identical(other.paymentCompleted, paymentCompleted) ||
                const DeepCollectionEquality().equals(
                  other.paymentCompleted,
                  paymentCompleted,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(module) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(payments) ^
      const DeepCollectionEquality().hash(paymentCompleted) ^
      runtimeType.hashCode;
}

extension $CheckoutCompleteExtension on CheckoutComplete {
  CheckoutComplete copyWith({
    String? id,
    String? module,
    String? name,
    int? amount,
    List<CheckoutPayment>? payments,
    bool? paymentCompleted,
  }) {
    return CheckoutComplete(
      id: id ?? this.id,
      module: module ?? this.module,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      payments: payments ?? this.payments,
      paymentCompleted: paymentCompleted ?? this.paymentCompleted,
    );
  }

  CheckoutComplete copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? module,
    Wrapped<String>? name,
    Wrapped<int>? amount,
    Wrapped<List<CheckoutPayment>>? payments,
    Wrapped<bool?>? paymentCompleted,
  }) {
    return CheckoutComplete(
      id: (id != null ? id.value : this.id),
      module: (module != null ? module.value : this.module),
      name: (name != null ? name.value : this.name),
      amount: (amount != null ? amount.value : this.amount),
      payments: (payments != null ? payments.value : this.payments),
      paymentCompleted:
          (paymentCompleted != null
              ? paymentCompleted.value
              : this.paymentCompleted),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CheckoutPayment {
  const CheckoutPayment({
    required this.id,
    required this.paidAmount,
    required this.checkoutId,
  });

  factory CheckoutPayment.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPaymentFromJson(json);

  static const toJsonFactory = _$CheckoutPaymentToJson;
  Map<String, dynamic> toJson() => _$CheckoutPaymentToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'paid_amount', defaultValue: 0)
  final int paidAmount;
  @JsonKey(name: 'checkout_id', defaultValue: '')
  final String checkoutId;
  static const fromJsonFactory = _$CheckoutPaymentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CheckoutPayment &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.paidAmount, paidAmount) ||
                const DeepCollectionEquality().equals(
                  other.paidAmount,
                  paidAmount,
                )) &&
            (identical(other.checkoutId, checkoutId) ||
                const DeepCollectionEquality().equals(
                  other.checkoutId,
                  checkoutId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(paidAmount) ^
      const DeepCollectionEquality().hash(checkoutId) ^
      runtimeType.hashCode;
}

extension $CheckoutPaymentExtension on CheckoutPayment {
  CheckoutPayment copyWith({String? id, int? paidAmount, String? checkoutId}) {
    return CheckoutPayment(
      id: id ?? this.id,
      paidAmount: paidAmount ?? this.paidAmount,
      checkoutId: checkoutId ?? this.checkoutId,
    );
  }

  CheckoutPayment copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<int>? paidAmount,
    Wrapped<String>? checkoutId,
  }) {
    return CheckoutPayment(
      id: (id != null ? id.value : this.id),
      paidAmount: (paidAmount != null ? paidAmount.value : this.paidAmount),
      checkoutId: (checkoutId != null ? checkoutId.value : this.checkoutId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CineSessionBase {
  const CineSessionBase({
    required this.start,
    required this.duration,
    required this.name,
    required this.overview,
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
  final String overview;
  @JsonKey(name: 'genre')
  final String? genre;
  @JsonKey(name: 'tagline')
  final String? tagline;
  static const fromJsonFactory = _$CineSessionBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CineSessionBase &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
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
  CineSessionBase copyWith({
    DateTime? start,
    int? duration,
    String? name,
    String? overview,
    String? genre,
    String? tagline,
  }) {
    return CineSessionBase(
      start: start ?? this.start,
      duration: duration ?? this.duration,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      genre: genre ?? this.genre,
      tagline: tagline ?? this.tagline,
    );
  }

  CineSessionBase copyWithWrapped({
    Wrapped<DateTime>? start,
    Wrapped<int>? duration,
    Wrapped<String>? name,
    Wrapped<String>? overview,
    Wrapped<String?>? genre,
    Wrapped<String?>? tagline,
  }) {
    return CineSessionBase(
      start: (start != null ? start.value : this.start),
      duration: (duration != null ? duration.value : this.duration),
      name: (name != null ? name.value : this.name),
      overview: (overview != null ? overview.value : this.overview),
      genre: (genre != null ? genre.value : this.genre),
      tagline: (tagline != null ? tagline.value : this.tagline),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CineSessionComplete {
  const CineSessionComplete({
    required this.start,
    required this.duration,
    required this.name,
    required this.overview,
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
  final String overview;
  @JsonKey(name: 'genre')
  final String? genre;
  @JsonKey(name: 'tagline')
  final String? tagline;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$CineSessionCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CineSessionComplete &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality().equals(
                  other.tagline,
                  tagline,
                )) &&
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
  CineSessionComplete copyWith({
    DateTime? start,
    int? duration,
    String? name,
    String? overview,
    String? genre,
    String? tagline,
    String? id,
  }) {
    return CineSessionComplete(
      start: start ?? this.start,
      duration: duration ?? this.duration,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      genre: genre ?? this.genre,
      tagline: tagline ?? this.tagline,
      id: id ?? this.id,
    );
  }

  CineSessionComplete copyWithWrapped({
    Wrapped<DateTime>? start,
    Wrapped<int>? duration,
    Wrapped<String>? name,
    Wrapped<String>? overview,
    Wrapped<String?>? genre,
    Wrapped<String?>? tagline,
    Wrapped<String>? id,
  }) {
    return CineSessionComplete(
      start: (start != null ? start.value : this.start),
      duration: (duration != null ? duration.value : this.duration),
      name: (name != null ? name.value : this.name),
      overview: (overview != null ? overview.value : this.overview),
      genre: (genre != null ? genre.value : this.genre),
      tagline: (tagline != null ? tagline.value : this.tagline),
      id: (id != null ? id.value : this.id),
    );
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

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'start')
  final String? start;
  @JsonKey(name: 'duration')
  final int? duration;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'genre')
  final String? genre;
  @JsonKey(name: 'tagline')
  final String? tagline;
  static const fromJsonFactory = _$CineSessionUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CineSessionUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
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
  CineSessionUpdate copyWith({
    String? name,
    String? start,
    int? duration,
    String? overview,
    String? genre,
    String? tagline,
  }) {
    return CineSessionUpdate(
      name: name ?? this.name,
      start: start ?? this.start,
      duration: duration ?? this.duration,
      overview: overview ?? this.overview,
      genre: genre ?? this.genre,
      tagline: tagline ?? this.tagline,
    );
  }

  CineSessionUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? start,
    Wrapped<int?>? duration,
    Wrapped<String?>? overview,
    Wrapped<String?>? genre,
    Wrapped<String?>? tagline,
  }) {
    return CineSessionUpdate(
      name: (name != null ? name.value : this.name),
      start: (start != null ? start.value : this.start),
      duration: (duration != null ? duration.value : this.duration),
      overview: (overview != null ? overview.value : this.overview),
      genre: (genre != null ? genre.value : this.genre),
      tagline: (tagline != null ? tagline.value : this.tagline),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreBatchDeleteMembership {
  const CoreBatchDeleteMembership({required this.groupId});

  factory CoreBatchDeleteMembership.fromJson(Map<String, dynamic> json) =>
      _$CoreBatchDeleteMembershipFromJson(json);

  static const toJsonFactory = _$CoreBatchDeleteMembershipToJson;
  Map<String, dynamic> toJson() => _$CoreBatchDeleteMembershipToJson(this);

  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$CoreBatchDeleteMembershipFromJson;

  @override
  bool operator ==(Object other) {
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
      groupId: (groupId != null ? groupId.value : this.groupId),
    );
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
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$CoreBatchMembershipFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreBatchMembership &&
            (identical(other.userEmails, userEmails) ||
                const DeepCollectionEquality().equals(
                  other.userEmails,
                  userEmails,
                )) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(
                  other.groupId,
                  groupId,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
  CoreBatchMembership copyWith({
    List<String>? userEmails,
    String? groupId,
    String? description,
  }) {
    return CoreBatchMembership(
      userEmails: userEmails ?? this.userEmails,
      groupId: groupId ?? this.groupId,
      description: description ?? this.description,
    );
  }

  CoreBatchMembership copyWithWrapped({
    Wrapped<List<String>>? userEmails,
    Wrapped<String>? groupId,
    Wrapped<String?>? description,
  }) {
    return CoreBatchMembership(
      userEmails: (userEmails != null ? userEmails.value : this.userEmails),
      groupId: (groupId != null ? groupId.value : this.groupId),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreBatchUserCreateRequest {
  const CoreBatchUserCreateRequest({required this.email});

  factory CoreBatchUserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CoreBatchUserCreateRequestFromJson(json);

  static const toJsonFactory = _$CoreBatchUserCreateRequestToJson;
  Map<String, dynamic> toJson() => _$CoreBatchUserCreateRequestToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  static const fromJsonFactory = _$CoreBatchUserCreateRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreBatchUserCreateRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $CoreBatchUserCreateRequestExtension on CoreBatchUserCreateRequest {
  CoreBatchUserCreateRequest copyWith({String? email}) {
    return CoreBatchUserCreateRequest(email: email ?? this.email);
  }

  CoreBatchUserCreateRequest copyWithWrapped({Wrapped<String>? email}) {
    return CoreBatchUserCreateRequest(
      email: (email != null ? email.value : this.email),
    );
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
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'members', defaultValue: null)
  final List<CoreUserSimple>? members;
  static const fromJsonFactory = _$CoreGroupFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreGroup &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
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
  CoreGroup copyWith({
    String? name,
    String? description,
    String? id,
    List<CoreUserSimple>? members,
  }) {
    return CoreGroup(
      name: name ?? this.name,
      description: description ?? this.description,
      id: id ?? this.id,
      members: members ?? this.members,
    );
  }

  CoreGroup copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<String>? id,
    Wrapped<List<CoreUserSimple>?>? members,
  }) {
    return CoreGroup(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      id: (id != null ? id.value : this.id),
      members: (members != null ? members.value : this.members),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreGroupCreate {
  const CoreGroupCreate({required this.name, this.description});

  factory CoreGroupCreate.fromJson(Map<String, dynamic> json) =>
      _$CoreGroupCreateFromJson(json);

  static const toJsonFactory = _$CoreGroupCreateToJson;
  Map<String, dynamic> toJson() => _$CoreGroupCreateToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$CoreGroupCreateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreGroupCreate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  CoreGroupCreate copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
  }) {
    return CoreGroupCreate(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
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
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$CoreGroupSimpleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreGroupSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
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
      id: id ?? this.id,
    );
  }

  CoreGroupSimple copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? description,
    Wrapped<String>? id,
  }) {
    return CoreGroupSimple(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreGroupUpdate {
  const CoreGroupUpdate({this.name, this.description});

  factory CoreGroupUpdate.fromJson(Map<String, dynamic> json) =>
      _$CoreGroupUpdateFromJson(json);

  static const toJsonFactory = _$CoreGroupUpdateToJson;
  Map<String, dynamic> toJson() => _$CoreGroupUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$CoreGroupUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreGroupUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  CoreGroupUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? description,
  }) {
    return CoreGroupUpdate(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreInformation {
  const CoreInformation({
    required this.ready,
    required this.version,
    required this.minimalTitanVersionCode,
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
  static const fromJsonFactory = _$CoreInformationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreInformation &&
            (identical(other.ready, ready) ||
                const DeepCollectionEquality().equals(other.ready, ready)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(
                  other.version,
                  version,
                )) &&
            (identical(
                  other.minimalTitanVersionCode,
                  minimalTitanVersionCode,
                ) ||
                const DeepCollectionEquality().equals(
                  other.minimalTitanVersionCode,
                  minimalTitanVersionCode,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ready) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(minimalTitanVersionCode) ^
      runtimeType.hashCode;
}

extension $CoreInformationExtension on CoreInformation {
  CoreInformation copyWith({
    bool? ready,
    String? version,
    int? minimalTitanVersionCode,
  }) {
    return CoreInformation(
      ready: ready ?? this.ready,
      version: version ?? this.version,
      minimalTitanVersionCode:
          minimalTitanVersionCode ?? this.minimalTitanVersionCode,
    );
  }

  CoreInformation copyWithWrapped({
    Wrapped<bool>? ready,
    Wrapped<String>? version,
    Wrapped<int>? minimalTitanVersionCode,
  }) {
    return CoreInformation(
      ready: (ready != null ? ready.value : this.ready),
      version: (version != null ? version.value : this.version),
      minimalTitanVersionCode:
          (minimalTitanVersionCode != null
              ? minimalTitanVersionCode.value
              : this.minimalTitanVersionCode),
    );
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
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$CoreMembershipFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreMembership &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(
                  other.groupId,
                  groupId,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
  CoreMembership copyWith({
    String? userId,
    String? groupId,
    String? description,
  }) {
    return CoreMembership(
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      description: description ?? this.description,
    );
  }

  CoreMembership copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? groupId,
    Wrapped<String?>? description,
  }) {
    return CoreMembership(
      userId: (userId != null ? userId.value : this.userId),
      groupId: (groupId != null ? groupId.value : this.groupId),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreMembershipDelete {
  const CoreMembershipDelete({required this.userId, required this.groupId});

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
  bool operator ==(Object other) {
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
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
    );
  }

  CoreMembershipDelete copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? groupId,
  }) {
    return CoreMembershipDelete(
      userId: (userId != null ? userId.value : this.userId),
      groupId: (groupId != null ? groupId.value : this.groupId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreSchool {
  const CoreSchool({
    required this.name,
    required this.emailRegex,
    required this.id,
  });

  factory CoreSchool.fromJson(Map<String, dynamic> json) =>
      _$CoreSchoolFromJson(json);

  static const toJsonFactory = _$CoreSchoolToJson;
  Map<String, dynamic> toJson() => _$CoreSchoolToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'email_regex', defaultValue: '')
  final String emailRegex;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$CoreSchoolFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreSchool &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.emailRegex, emailRegex) ||
                const DeepCollectionEquality().equals(
                  other.emailRegex,
                  emailRegex,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(emailRegex) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $CoreSchoolExtension on CoreSchool {
  CoreSchool copyWith({String? name, String? emailRegex, String? id}) {
    return CoreSchool(
      name: name ?? this.name,
      emailRegex: emailRegex ?? this.emailRegex,
      id: id ?? this.id,
    );
  }

  CoreSchool copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? emailRegex,
    Wrapped<String>? id,
  }) {
    return CoreSchool(
      name: (name != null ? name.value : this.name),
      emailRegex: (emailRegex != null ? emailRegex.value : this.emailRegex),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreSchoolBase {
  const CoreSchoolBase({required this.name, required this.emailRegex});

  factory CoreSchoolBase.fromJson(Map<String, dynamic> json) =>
      _$CoreSchoolBaseFromJson(json);

  static const toJsonFactory = _$CoreSchoolBaseToJson;
  Map<String, dynamic> toJson() => _$CoreSchoolBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'email_regex', defaultValue: '')
  final String emailRegex;
  static const fromJsonFactory = _$CoreSchoolBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreSchoolBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.emailRegex, emailRegex) ||
                const DeepCollectionEquality().equals(
                  other.emailRegex,
                  emailRegex,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(emailRegex) ^
      runtimeType.hashCode;
}

extension $CoreSchoolBaseExtension on CoreSchoolBase {
  CoreSchoolBase copyWith({String? name, String? emailRegex}) {
    return CoreSchoolBase(
      name: name ?? this.name,
      emailRegex: emailRegex ?? this.emailRegex,
    );
  }

  CoreSchoolBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? emailRegex,
  }) {
    return CoreSchoolBase(
      name: (name != null ? name.value : this.name),
      emailRegex: (emailRegex != null ? emailRegex.value : this.emailRegex),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreSchoolUpdate {
  const CoreSchoolUpdate({this.name, this.emailRegex});

  factory CoreSchoolUpdate.fromJson(Map<String, dynamic> json) =>
      _$CoreSchoolUpdateFromJson(json);

  static const toJsonFactory = _$CoreSchoolUpdateToJson;
  Map<String, dynamic> toJson() => _$CoreSchoolUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email_regex')
  final String? emailRegex;
  static const fromJsonFactory = _$CoreSchoolUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreSchoolUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.emailRegex, emailRegex) ||
                const DeepCollectionEquality().equals(
                  other.emailRegex,
                  emailRegex,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(emailRegex) ^
      runtimeType.hashCode;
}

extension $CoreSchoolUpdateExtension on CoreSchoolUpdate {
  CoreSchoolUpdate copyWith({String? name, String? emailRegex}) {
    return CoreSchoolUpdate(
      name: name ?? this.name,
      emailRegex: emailRegex ?? this.emailRegex,
    );
  }

  CoreSchoolUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? emailRegex,
  }) {
    return CoreSchoolUpdate(
      name: (name != null ? name.value : this.name),
      emailRegex: (emailRegex != null ? emailRegex.value : this.emailRegex),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUser {
  const CoreUser({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
    required this.email,
    this.birthday,
    this.promo,
    this.floor,
    this.phone,
    this.createdOn,
    this.groups,
    this.school,
  });

  factory CoreUser.fromJson(Map<String, dynamic> json) =>
      _$CoreUserFromJson(json);

  static const toJsonFactory = _$CoreUserToJson;
  Map<String, dynamic> toJson() => _$CoreUserToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'created_on')
  final String? createdOn;
  @JsonKey(name: 'groups', defaultValue: null)
  final List<CoreGroupSimple>? groups;
  @JsonKey(name: 'school')
  final CoreSchool? school;
  static const fromJsonFactory = _$CoreUserFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreUser &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.createdOn, createdOn) ||
                const DeepCollectionEquality().equals(
                  other.createdOn,
                  createdOn,
                )) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)) &&
            (identical(other.school, school) ||
                const DeepCollectionEquality().equals(other.school, school)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(floor) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(createdOn) ^
      const DeepCollectionEquality().hash(groups) ^
      const DeepCollectionEquality().hash(school) ^
      runtimeType.hashCode;
}

extension $CoreUserExtension on CoreUser {
  CoreUser copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
    String? email,
    String? birthday,
    int? promo,
    enums.FloorsType? floor,
    String? phone,
    String? createdOn,
    List<CoreGroupSimple>? groups,
    CoreSchool? school,
  }) {
    return CoreUser(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      promo: promo ?? this.promo,
      floor: floor ?? this.floor,
      phone: phone ?? this.phone,
      createdOn: createdOn ?? this.createdOn,
      groups: groups ?? this.groups,
      school: school ?? this.school,
    );
  }

  CoreUser copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
    Wrapped<String>? email,
    Wrapped<String?>? birthday,
    Wrapped<int?>? promo,
    Wrapped<enums.FloorsType?>? floor,
    Wrapped<String?>? phone,
    Wrapped<String?>? createdOn,
    Wrapped<List<CoreGroupSimple>?>? groups,
    Wrapped<CoreSchool?>? school,
  }) {
    return CoreUser(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      email: (email != null ? email.value : this.email),
      birthday: (birthday != null ? birthday.value : this.birthday),
      promo: (promo != null ? promo.value : this.promo),
      floor: (floor != null ? floor.value : this.floor),
      phone: (phone != null ? phone.value : this.phone),
      createdOn: (createdOn != null ? createdOn.value : this.createdOn),
      groups: (groups != null ? groups.value : this.groups),
      school: (school != null ? school.value : this.school),
    );
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
    this.floor,
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
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'activation_token', defaultValue: '')
  final String activationToken;
  @JsonKey(name: 'password', defaultValue: '')
  final String password;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  @JsonKey(name: 'promo')
  final int? promo;
  static const fromJsonFactory = _$CoreUserActivateRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreUserActivateRequest &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.activationToken, activationToken) ||
                const DeepCollectionEquality().equals(
                  other.activationToken,
                  activationToken,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
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
  CoreUserActivateRequest copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? activationToken,
    String? password,
    String? birthday,
    String? phone,
    enums.FloorsType? floor,
    int? promo,
  }) {
    return CoreUserActivateRequest(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      activationToken: activationToken ?? this.activationToken,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      floor: floor ?? this.floor,
      promo: promo ?? this.promo,
    );
  }

  CoreUserActivateRequest copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? activationToken,
    Wrapped<String>? password,
    Wrapped<String?>? birthday,
    Wrapped<String?>? phone,
    Wrapped<enums.FloorsType?>? floor,
    Wrapped<int?>? promo,
  }) {
    return CoreUserActivateRequest(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      activationToken:
          (activationToken != null
              ? activationToken.value
              : this.activationToken),
      password: (password != null ? password.value : this.password),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      floor: (floor != null ? floor.value : this.floor),
      promo: (promo != null ? promo.value : this.promo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserCreateRequest {
  const CoreUserCreateRequest({required this.email, this.acceptExternal});

  factory CoreUserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CoreUserCreateRequestFromJson(json);

  static const toJsonFactory = _$CoreUserCreateRequestToJson;
  Map<String, dynamic> toJson() => _$CoreUserCreateRequestToJson(this);

  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'accept_external')
  @deprecated
  final bool? acceptExternal;
  static const fromJsonFactory = _$CoreUserCreateRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreUserCreateRequest &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.acceptExternal, acceptExternal) ||
                const DeepCollectionEquality().equals(
                  other.acceptExternal,
                  acceptExternal,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(acceptExternal) ^
      runtimeType.hashCode;
}

extension $CoreUserCreateRequestExtension on CoreUserCreateRequest {
  CoreUserCreateRequest copyWith({String? email, bool? acceptExternal}) {
    return CoreUserCreateRequest(
      email: email ?? this.email,
      acceptExternal: acceptExternal ?? this.acceptExternal,
    );
  }

  CoreUserCreateRequest copyWithWrapped({
    Wrapped<String>? email,
    Wrapped<bool?>? acceptExternal,
  }) {
    return CoreUserCreateRequest(
      email: (email != null ? email.value : this.email),
      acceptExternal:
          (acceptExternal != null ? acceptExternal.value : this.acceptExternal),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserFusionRequest {
  const CoreUserFusionRequest({
    required this.userKeptEmail,
    required this.userDeletedEmail,
  });

  factory CoreUserFusionRequest.fromJson(Map<String, dynamic> json) =>
      _$CoreUserFusionRequestFromJson(json);

  static const toJsonFactory = _$CoreUserFusionRequestToJson;
  Map<String, dynamic> toJson() => _$CoreUserFusionRequestToJson(this);

  @JsonKey(name: 'user_kept_email', defaultValue: '')
  final String userKeptEmail;
  @JsonKey(name: 'user_deleted_email', defaultValue: '')
  final String userDeletedEmail;
  static const fromJsonFactory = _$CoreUserFusionRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreUserFusionRequest &&
            (identical(other.userKeptEmail, userKeptEmail) ||
                const DeepCollectionEquality().equals(
                  other.userKeptEmail,
                  userKeptEmail,
                )) &&
            (identical(other.userDeletedEmail, userDeletedEmail) ||
                const DeepCollectionEquality().equals(
                  other.userDeletedEmail,
                  userDeletedEmail,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userKeptEmail) ^
      const DeepCollectionEquality().hash(userDeletedEmail) ^
      runtimeType.hashCode;
}

extension $CoreUserFusionRequestExtension on CoreUserFusionRequest {
  CoreUserFusionRequest copyWith({
    String? userKeptEmail,
    String? userDeletedEmail,
  }) {
    return CoreUserFusionRequest(
      userKeptEmail: userKeptEmail ?? this.userKeptEmail,
      userDeletedEmail: userDeletedEmail ?? this.userDeletedEmail,
    );
  }

  CoreUserFusionRequest copyWithWrapped({
    Wrapped<String>? userKeptEmail,
    Wrapped<String>? userDeletedEmail,
  }) {
    return CoreUserFusionRequest(
      userKeptEmail:
          (userKeptEmail != null ? userKeptEmail.value : this.userKeptEmail),
      userDeletedEmail:
          (userDeletedEmail != null
              ? userDeletedEmail.value
              : this.userDeletedEmail),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserSimple {
  const CoreUserSimple({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
  });

  factory CoreUserSimple.fromJson(Map<String, dynamic> json) =>
      _$CoreUserSimpleFromJson(json);

  static const toJsonFactory = _$CoreUserSimpleToJson;
  Map<String, dynamic> toJson() => _$CoreUserSimpleToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  static const fromJsonFactory = _$CoreUserSimpleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreUserSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      runtimeType.hashCode;
}

extension $CoreUserSimpleExtension on CoreUserSimple {
  CoreUserSimple copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
  }) {
    return CoreUserSimple(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
    );
  }

  CoreUserSimple copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
  }) {
    return CoreUserSimple(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserUpdate {
  const CoreUserUpdate({this.nickname, this.birthday, this.phone, this.floor});

  factory CoreUserUpdate.fromJson(Map<String, dynamic> json) =>
      _$CoreUserUpdateFromJson(json);

  static const toJsonFactory = _$CoreUserUpdateToJson;
  Map<String, dynamic> toJson() => _$CoreUserUpdateToJson(this);

  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  static const fromJsonFactory = _$CoreUserUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreUserUpdate &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
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
  CoreUserUpdate copyWith({
    String? nickname,
    String? birthday,
    String? phone,
    enums.FloorsType? floor,
  }) {
    return CoreUserUpdate(
      nickname: nickname ?? this.nickname,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      floor: floor ?? this.floor,
    );
  }

  CoreUserUpdate copyWithWrapped({
    Wrapped<String?>? nickname,
    Wrapped<String?>? birthday,
    Wrapped<String?>? phone,
    Wrapped<enums.FloorsType?>? floor,
  }) {
    return CoreUserUpdate(
      nickname: (nickname != null ? nickname.value : this.nickname),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      floor: (floor != null ? floor.value : this.floor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CoreUserUpdateAdmin {
  const CoreUserUpdateAdmin({
    this.email,
    this.schoolId,
    this.accountType,
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

  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'school_id')
  final String? schoolId;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeNullableToJson,
    fromJson: accountTypeNullableFromJson,
  )
  final enums.AccountType? accountType;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'firstname')
  final String? firstname;
  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  static const fromJsonFactory = _$CoreUserUpdateAdminFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CoreUserUpdateAdmin &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(accountType) ^
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
  CoreUserUpdateAdmin copyWith({
    String? email,
    String? schoolId,
    enums.AccountType? accountType,
    String? name,
    String? firstname,
    int? promo,
    String? nickname,
    String? birthday,
    String? phone,
    enums.FloorsType? floor,
  }) {
    return CoreUserUpdateAdmin(
      email: email ?? this.email,
      schoolId: schoolId ?? this.schoolId,
      accountType: accountType ?? this.accountType,
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      promo: promo ?? this.promo,
      nickname: nickname ?? this.nickname,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      floor: floor ?? this.floor,
    );
  }

  CoreUserUpdateAdmin copyWithWrapped({
    Wrapped<String?>? email,
    Wrapped<String?>? schoolId,
    Wrapped<enums.AccountType?>? accountType,
    Wrapped<String?>? name,
    Wrapped<String?>? firstname,
    Wrapped<int?>? promo,
    Wrapped<String?>? nickname,
    Wrapped<String?>? birthday,
    Wrapped<String?>? phone,
    Wrapped<enums.FloorsType?>? floor,
  }) {
    return CoreUserUpdateAdmin(
      email: (email != null ? email.value : this.email),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      accountType: (accountType != null ? accountType.value : this.accountType),
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      promo: (promo != null ? promo.value : this.promo),
      nickname: (nickname != null ? nickname.value : this.nickname),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      floor: (floor != null ? floor.value : this.floor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CurriculumBase {
  const CurriculumBase({required this.name});

  factory CurriculumBase.fromJson(Map<String, dynamic> json) =>
      _$CurriculumBaseFromJson(json);

  static const toJsonFactory = _$CurriculumBaseToJson;
  Map<String, dynamic> toJson() => _$CurriculumBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  static const fromJsonFactory = _$CurriculumBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CurriculumBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $CurriculumBaseExtension on CurriculumBase {
  CurriculumBase copyWith({String? name}) {
    return CurriculumBase(name: name ?? this.name);
  }

  CurriculumBase copyWithWrapped({Wrapped<String>? name}) {
    return CurriculumBase(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class CurriculumComplete {
  const CurriculumComplete({required this.name, required this.id});

  factory CurriculumComplete.fromJson(Map<String, dynamic> json) =>
      _$CurriculumCompleteFromJson(json);

  static const toJsonFactory = _$CurriculumCompleteToJson;
  Map<String, dynamic> toJson() => _$CurriculumCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$CurriculumCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CurriculumComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $CurriculumCompleteExtension on CurriculumComplete {
  CurriculumComplete copyWith({String? name, String? id}) {
    return CurriculumComplete(name: name ?? this.name, id: id ?? this.id);
  }

  CurriculumComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
  }) {
    return CurriculumComplete(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CustomDataBase {
  const CustomDataBase({required this.$value});

  factory CustomDataBase.fromJson(Map<String, dynamic> json) =>
      _$CustomDataBaseFromJson(json);

  static const toJsonFactory = _$CustomDataBaseToJson;
  Map<String, dynamic> toJson() => _$CustomDataBaseToJson(this);

  @JsonKey(name: 'value', defaultValue: '')
  final String $value;
  static const fromJsonFactory = _$CustomDataBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CustomDataBase &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^ runtimeType.hashCode;
}

extension $CustomDataBaseExtension on CustomDataBase {
  CustomDataBase copyWith({String? $value}) {
    return CustomDataBase($value: $value ?? this.$value);
  }

  CustomDataBase copyWithWrapped({Wrapped<String>? $value}) {
    return CustomDataBase(
      $value: ($value != null ? $value.value : this.$value),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CustomDataComplete {
  const CustomDataComplete({
    required this.$value,
    required this.fieldId,
    required this.userId,
    required this.field,
  });

  factory CustomDataComplete.fromJson(Map<String, dynamic> json) =>
      _$CustomDataCompleteFromJson(json);

  static const toJsonFactory = _$CustomDataCompleteToJson;
  Map<String, dynamic> toJson() => _$CustomDataCompleteToJson(this);

  @JsonKey(name: 'value', defaultValue: '')
  final String $value;
  @JsonKey(name: 'field_id', defaultValue: '')
  final String fieldId;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'field')
  final CustomDataFieldComplete field;
  static const fromJsonFactory = _$CustomDataCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CustomDataComplete &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.fieldId, fieldId) ||
                const DeepCollectionEquality().equals(
                  other.fieldId,
                  fieldId,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.field, field) ||
                const DeepCollectionEquality().equals(other.field, field)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(fieldId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(field) ^
      runtimeType.hashCode;
}

extension $CustomDataCompleteExtension on CustomDataComplete {
  CustomDataComplete copyWith({
    String? $value,
    String? fieldId,
    String? userId,
    CustomDataFieldComplete? field,
  }) {
    return CustomDataComplete(
      $value: $value ?? this.$value,
      fieldId: fieldId ?? this.fieldId,
      userId: userId ?? this.userId,
      field: field ?? this.field,
    );
  }

  CustomDataComplete copyWithWrapped({
    Wrapped<String>? $value,
    Wrapped<String>? fieldId,
    Wrapped<String>? userId,
    Wrapped<CustomDataFieldComplete>? field,
  }) {
    return CustomDataComplete(
      $value: ($value != null ? $value.value : this.$value),
      fieldId: (fieldId != null ? fieldId.value : this.fieldId),
      userId: (userId != null ? userId.value : this.userId),
      field: (field != null ? field.value : this.field),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CustomDataFieldBase {
  const CustomDataFieldBase({required this.name});

  factory CustomDataFieldBase.fromJson(Map<String, dynamic> json) =>
      _$CustomDataFieldBaseFromJson(json);

  static const toJsonFactory = _$CustomDataFieldBaseToJson;
  Map<String, dynamic> toJson() => _$CustomDataFieldBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  static const fromJsonFactory = _$CustomDataFieldBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CustomDataFieldBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $CustomDataFieldBaseExtension on CustomDataFieldBase {
  CustomDataFieldBase copyWith({String? name}) {
    return CustomDataFieldBase(name: name ?? this.name);
  }

  CustomDataFieldBase copyWithWrapped({Wrapped<String>? name}) {
    return CustomDataFieldBase(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class CustomDataFieldComplete {
  const CustomDataFieldComplete({
    required this.name,
    required this.id,
    required this.productId,
  });

  factory CustomDataFieldComplete.fromJson(Map<String, dynamic> json) =>
      _$CustomDataFieldCompleteFromJson(json);

  static const toJsonFactory = _$CustomDataFieldCompleteToJson;
  Map<String, dynamic> toJson() => _$CustomDataFieldCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'product_id', defaultValue: '')
  final String productId;
  static const fromJsonFactory = _$CustomDataFieldCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CustomDataFieldComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(productId) ^
      runtimeType.hashCode;
}

extension $CustomDataFieldCompleteExtension on CustomDataFieldComplete {
  CustomDataFieldComplete copyWith({
    String? name,
    String? id,
    String? productId,
  }) {
    return CustomDataFieldComplete(
      name: name ?? this.name,
      id: id ?? this.id,
      productId: productId ?? this.productId,
    );
  }

  CustomDataFieldComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<String>? productId,
  }) {
    return CustomDataFieldComplete(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      productId: (productId != null ? productId.value : this.productId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DeliveryBase {
  const DeliveryBase({required this.deliveryDate, this.productsIds});

  factory DeliveryBase.fromJson(Map<String, dynamic> json) =>
      _$DeliveryBaseFromJson(json);

  static const toJsonFactory = _$DeliveryBaseToJson;
  Map<String, dynamic> toJson() => _$DeliveryBaseToJson(this);

  @JsonKey(name: 'delivery_date', toJson: _dateToJson)
  final DateTime deliveryDate;
  @JsonKey(name: 'products_ids', defaultValue: null)
  final List<String>? productsIds;
  static const fromJsonFactory = _$DeliveryBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeliveryBase &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality().equals(
                  other.deliveryDate,
                  deliveryDate,
                )) &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality().equals(
                  other.productsIds,
                  productsIds,
                )));
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
      productsIds: productsIds ?? this.productsIds,
    );
  }

  DeliveryBase copyWithWrapped({
    Wrapped<DateTime>? deliveryDate,
    Wrapped<List<String>?>? productsIds,
  }) {
    return DeliveryBase(
      deliveryDate:
          (deliveryDate != null ? deliveryDate.value : this.deliveryDate),
      productsIds: (productsIds != null ? productsIds.value : this.productsIds),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DeliveryProductsUpdate {
  const DeliveryProductsUpdate({required this.productsIds});

  factory DeliveryProductsUpdate.fromJson(Map<String, dynamic> json) =>
      _$DeliveryProductsUpdateFromJson(json);

  static const toJsonFactory = _$DeliveryProductsUpdateToJson;
  Map<String, dynamic> toJson() => _$DeliveryProductsUpdateToJson(this);

  @JsonKey(name: 'products_ids', defaultValue: <String>[])
  final List<String> productsIds;
  static const fromJsonFactory = _$DeliveryProductsUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeliveryProductsUpdate &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality().equals(
                  other.productsIds,
                  productsIds,
                )));
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
      productsIds: (productsIds != null ? productsIds.value : this.productsIds),
    );
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
  @JsonKey(name: 'products', defaultValue: null)
  final List<AppModulesAmapSchemasAmapProductComplete>? products;
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeliveryReturn &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality().equals(
                  other.deliveryDate,
                  deliveryDate,
                )) &&
            (identical(other.products, products) ||
                const DeepCollectionEquality().equals(
                  other.products,
                  products,
                )) &&
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
  DeliveryReturn copyWith({
    DateTime? deliveryDate,
    List<AppModulesAmapSchemasAmapProductComplete>? products,
    String? id,
    enums.DeliveryStatusType? status,
  }) {
    return DeliveryReturn(
      deliveryDate: deliveryDate ?? this.deliveryDate,
      products: products ?? this.products,
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }

  DeliveryReturn copyWithWrapped({
    Wrapped<DateTime>? deliveryDate,
    Wrapped<List<AppModulesAmapSchemasAmapProductComplete>?>? products,
    Wrapped<String>? id,
    Wrapped<enums.DeliveryStatusType>? status,
  }) {
    return DeliveryReturn(
      deliveryDate:
          (deliveryDate != null ? deliveryDate.value : this.deliveryDate),
      products: (products != null ? products.value : this.products),
      id: (id != null ? id.value : this.id),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DeliveryUpdate {
  const DeliveryUpdate({this.deliveryDate});

  factory DeliveryUpdate.fromJson(Map<String, dynamic> json) =>
      _$DeliveryUpdateFromJson(json);

  static const toJsonFactory = _$DeliveryUpdateToJson;
  Map<String, dynamic> toJson() => _$DeliveryUpdateToJson(this);

  @JsonKey(name: 'delivery_date')
  final String? deliveryDate;
  static const fromJsonFactory = _$DeliveryUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeliveryUpdate &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality().equals(
                  other.deliveryDate,
                  deliveryDate,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(deliveryDate) ^ runtimeType.hashCode;
}

extension $DeliveryUpdateExtension on DeliveryUpdate {
  DeliveryUpdate copyWith({String? deliveryDate}) {
    return DeliveryUpdate(deliveryDate: deliveryDate ?? this.deliveryDate);
  }

  DeliveryUpdate copyWithWrapped({Wrapped<String?>? deliveryDate}) {
    return DeliveryUpdate(
      deliveryDate:
          (deliveryDate != null ? deliveryDate.value : this.deliveryDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Document {
  const Document({
    required this.type,
    required this.name,
    required this.id,
    required this.uploadedAt,
    required this.validation,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  static const toJsonFactory = _$DocumentToJson;
  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @JsonKey(
    name: 'type',
    toJson: documentTypeToJson,
    fromJson: documentTypeFromJson,
  )
  final enums.DocumentType type;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'uploaded_at', toJson: _dateToJson)
  final DateTime uploadedAt;
  @JsonKey(
    name: 'validation',
    toJson: documentValidationToJson,
    fromJson: documentValidationFromJson,
  )
  final enums.DocumentValidation validation;
  static const fromJsonFactory = _$DocumentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Document &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.uploadedAt, uploadedAt) ||
                const DeepCollectionEquality().equals(
                  other.uploadedAt,
                  uploadedAt,
                )) &&
            (identical(other.validation, validation) ||
                const DeepCollectionEquality().equals(
                  other.validation,
                  validation,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(uploadedAt) ^
      const DeepCollectionEquality().hash(validation) ^
      runtimeType.hashCode;
}

extension $DocumentExtension on Document {
  Document copyWith({
    enums.DocumentType? type,
    String? name,
    String? id,
    DateTime? uploadedAt,
    enums.DocumentValidation? validation,
  }) {
    return Document(
      type: type ?? this.type,
      name: name ?? this.name,
      id: id ?? this.id,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      validation: validation ?? this.validation,
    );
  }

  Document copyWithWrapped({
    Wrapped<enums.DocumentType>? type,
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<DateTime>? uploadedAt,
    Wrapped<enums.DocumentValidation>? validation,
  }) {
    return Document(
      type: (type != null ? type.value : this.type),
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      uploadedAt: (uploadedAt != null ? uploadedAt.value : this.uploadedAt),
      validation: (validation != null ? validation.value : this.validation),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DocumentBase {
  const DocumentBase({required this.name});

  factory DocumentBase.fromJson(Map<String, dynamic> json) =>
      _$DocumentBaseFromJson(json);

  static const toJsonFactory = _$DocumentBaseToJson;
  Map<String, dynamic> toJson() => _$DocumentBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  static const fromJsonFactory = _$DocumentBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DocumentBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $DocumentBaseExtension on DocumentBase {
  DocumentBase copyWith({String? name}) {
    return DocumentBase(name: name ?? this.name);
  }

  DocumentBase copyWithWrapped({Wrapped<String>? name}) {
    return DocumentBase(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class DocumentComplete {
  const DocumentComplete({
    required this.name,
    required this.id,
    required this.sellerId,
  });

  factory DocumentComplete.fromJson(Map<String, dynamic> json) =>
      _$DocumentCompleteFromJson(json);

  static const toJsonFactory = _$DocumentCompleteToJson;
  Map<String, dynamic> toJson() => _$DocumentCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'seller_id', defaultValue: '')
  final String sellerId;
  static const fromJsonFactory = _$DocumentCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DocumentComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.sellerId, sellerId) ||
                const DeepCollectionEquality().equals(
                  other.sellerId,
                  sellerId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(sellerId) ^
      runtimeType.hashCode;
}

extension $DocumentCompleteExtension on DocumentComplete {
  DocumentComplete copyWith({String? name, String? id, String? sellerId}) {
    return DocumentComplete(
      name: name ?? this.name,
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
    );
  }

  DocumentComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<String>? sellerId,
  }) {
    return DocumentComplete(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      sellerId: (sellerId != null ? sellerId.value : this.sellerId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DocumentCreation {
  const DocumentCreation({required this.id});

  factory DocumentCreation.fromJson(Map<String, dynamic> json) =>
      _$DocumentCreationFromJson(json);

  static const toJsonFactory = _$DocumentCreationToJson;
  Map<String, dynamic> toJson() => _$DocumentCreationToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$DocumentCreationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DocumentCreation &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^ runtimeType.hashCode;
}

extension $DocumentCreationExtension on DocumentCreation {
  DocumentCreation copyWith({String? id}) {
    return DocumentCreation(id: id ?? this.id);
  }

  DocumentCreation copyWithWrapped({Wrapped<String>? id}) {
    return DocumentCreation(id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class EmergencyContact {
  const EmergencyContact({this.firstname, this.name, this.phone});

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  static const toJsonFactory = _$EmergencyContactToJson;
  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);

  @JsonKey(name: 'firstname')
  final String? firstname;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phone')
  final String? phone;
  static const fromJsonFactory = _$EmergencyContactFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EmergencyContact &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(phone) ^
      runtimeType.hashCode;
}

extension $EmergencyContactExtension on EmergencyContact {
  EmergencyContact copyWith({String? firstname, String? name, String? phone}) {
    return EmergencyContact(
      firstname: firstname ?? this.firstname,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  EmergencyContact copyWithWrapped({
    Wrapped<String?>? firstname,
    Wrapped<String?>? name,
    Wrapped<String?>? phone,
  }) {
    return EmergencyContact(
      firstname: (firstname != null ? firstname.value : this.firstname),
      name: (name != null ? name.value : this.name),
      phone: (phone != null ? phone.value : this.phone),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EventApplicant {
  const EventApplicant({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
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
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(name: 'phone')
  final String? phone;
  static const fromJsonFactory = _$EventApplicantFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventApplicant &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
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
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(phone) ^
      runtimeType.hashCode;
}

extension $EventApplicantExtension on EventApplicant {
  EventApplicant copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
    String? email,
    int? promo,
    String? phone,
  }) {
    return EventApplicant(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
      email: email ?? this.email,
      promo: promo ?? this.promo,
      phone: phone ?? this.phone,
    );
  }

  EventApplicant copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
    Wrapped<String>? email,
    Wrapped<int?>? promo,
    Wrapped<String?>? phone,
  }) {
    return EventApplicant(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      email: (email != null ? email.value : this.email),
      promo: (promo != null ? promo.value : this.promo),
      phone: (phone != null ? phone.value : this.phone),
    );
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
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  static const fromJsonFactory = _$EventBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality().equals(
                  other.organizer,
                  organizer,
                )) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )));
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
  EventBase copyWith({
    String? name,
    String? organizer,
    DateTime? start,
    DateTime? end,
    bool? allDay,
    String? location,
    enums.CalendarEventType? type,
    String? description,
    String? recurrenceRule,
  }) {
    return EventBase(
      name: name ?? this.name,
      organizer: organizer ?? this.organizer,
      start: start ?? this.start,
      end: end ?? this.end,
      allDay: allDay ?? this.allDay,
      location: location ?? this.location,
      type: type ?? this.type,
      description: description ?? this.description,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
    );
  }

  EventBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? organizer,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<bool>? allDay,
    Wrapped<String>? location,
    Wrapped<enums.CalendarEventType>? type,
    Wrapped<String>? description,
    Wrapped<String?>? recurrenceRule,
  }) {
    return EventBase(
      name: (name != null ? name.value : this.name),
      organizer: (organizer != null ? organizer.value : this.organizer),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      allDay: (allDay != null ? allDay.value : this.allDay),
      location: (location != null ? location.value : this.location),
      type: (type != null ? type.value : this.type),
      description: (description != null ? description.value : this.description),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
    );
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
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'decision', toJson: decisionToJson, fromJson: decisionFromJson)
  final enums.Decision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  static const fromJsonFactory = _$EventCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality().equals(
                  other.organizer,
                  organizer,
                )) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality().equals(
                  other.decision,
                  decision,
                )) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(
                  other.applicantId,
                  applicantId,
                )));
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
  EventComplete copyWith({
    String? name,
    String? organizer,
    DateTime? start,
    DateTime? end,
    bool? allDay,
    String? location,
    enums.CalendarEventType? type,
    String? description,
    String? recurrenceRule,
    String? id,
    enums.Decision? decision,
    String? applicantId,
  }) {
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
      applicantId: applicantId ?? this.applicantId,
    );
  }

  EventComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? organizer,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<bool>? allDay,
    Wrapped<String>? location,
    Wrapped<enums.CalendarEventType>? type,
    Wrapped<String>? description,
    Wrapped<String?>? recurrenceRule,
    Wrapped<String>? id,
    Wrapped<enums.Decision>? decision,
    Wrapped<String>? applicantId,
  }) {
    return EventComplete(
      name: (name != null ? name.value : this.name),
      organizer: (organizer != null ? organizer.value : this.organizer),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      allDay: (allDay != null ? allDay.value : this.allDay),
      location: (location != null ? location.value : this.location),
      type: (type != null ? type.value : this.type),
      description: (description != null ? description.value : this.description),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
      id: (id != null ? id.value : this.id),
      decision: (decision != null ? decision.value : this.decision),
      applicantId: (applicantId != null ? applicantId.value : this.applicantId),
    );
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

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'organizer')
  final String? organizer;
  @JsonKey(name: 'start')
  final String? start;
  @JsonKey(name: 'end')
  final String? end;
  @JsonKey(name: 'all_day')
  final bool? allDay;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(
    name: 'type',
    toJson: calendarEventTypeNullableToJson,
    fromJson: calendarEventTypeNullableFromJson,
  )
  final enums.CalendarEventType? type;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  static const fromJsonFactory = _$EventEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality().equals(
                  other.organizer,
                  organizer,
                )) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )));
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
  EventEdit copyWith({
    String? name,
    String? organizer,
    String? start,
    String? end,
    bool? allDay,
    String? location,
    enums.CalendarEventType? type,
    String? description,
    String? recurrenceRule,
  }) {
    return EventEdit(
      name: name ?? this.name,
      organizer: organizer ?? this.organizer,
      start: start ?? this.start,
      end: end ?? this.end,
      allDay: allDay ?? this.allDay,
      location: location ?? this.location,
      type: type ?? this.type,
      description: description ?? this.description,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
    );
  }

  EventEdit copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? organizer,
    Wrapped<String?>? start,
    Wrapped<String?>? end,
    Wrapped<bool?>? allDay,
    Wrapped<String?>? location,
    Wrapped<enums.CalendarEventType?>? type,
    Wrapped<String?>? description,
    Wrapped<String?>? recurrenceRule,
  }) {
    return EventEdit(
      name: (name != null ? name.value : this.name),
      organizer: (organizer != null ? organizer.value : this.organizer),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      allDay: (allDay != null ? allDay.value : this.allDay),
      location: (location != null ? location.value : this.location),
      type: (type != null ? type.value : this.type),
      description: (description != null ? description.value : this.description),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
    );
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
  @JsonKey(name: 'recurrence_rule')
  final String? recurrenceRule;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'decision', toJson: decisionToJson, fromJson: decisionFromJson)
  final enums.Decision decision;
  @JsonKey(name: 'applicant_id', defaultValue: '')
  final String applicantId;
  @JsonKey(name: 'applicant')
  final EventApplicant applicant;
  static const fromJsonFactory = _$EventReturnFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EventReturn &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.organizer, organizer) ||
                const DeepCollectionEquality().equals(
                  other.organizer,
                  organizer,
                )) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.allDay, allDay) ||
                const DeepCollectionEquality().equals(other.allDay, allDay)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality().equals(
                  other.location,
                  location,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                const DeepCollectionEquality().equals(
                  other.recurrenceRule,
                  recurrenceRule,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.decision, decision) ||
                const DeepCollectionEquality().equals(
                  other.decision,
                  decision,
                )) &&
            (identical(other.applicantId, applicantId) ||
                const DeepCollectionEquality().equals(
                  other.applicantId,
                  applicantId,
                )) &&
            (identical(other.applicant, applicant) ||
                const DeepCollectionEquality().equals(
                  other.applicant,
                  applicant,
                )));
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
  EventReturn copyWith({
    String? name,
    String? organizer,
    DateTime? start,
    DateTime? end,
    bool? allDay,
    String? location,
    enums.CalendarEventType? type,
    String? description,
    String? recurrenceRule,
    String? id,
    enums.Decision? decision,
    String? applicantId,
    EventApplicant? applicant,
  }) {
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
      applicant: applicant ?? this.applicant,
    );
  }

  EventReturn copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? organizer,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<bool>? allDay,
    Wrapped<String>? location,
    Wrapped<enums.CalendarEventType>? type,
    Wrapped<String>? description,
    Wrapped<String?>? recurrenceRule,
    Wrapped<String>? id,
    Wrapped<enums.Decision>? decision,
    Wrapped<String>? applicantId,
    Wrapped<EventApplicant>? applicant,
  }) {
    return EventReturn(
      name: (name != null ? name.value : this.name),
      organizer: (organizer != null ? organizer.value : this.organizer),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      allDay: (allDay != null ? allDay.value : this.allDay),
      location: (location != null ? location.value : this.location),
      type: (type != null ? type.value : this.type),
      description: (description != null ? description.value : this.description),
      recurrenceRule:
          (recurrenceRule != null ? recurrenceRule.value : this.recurrenceRule),
      id: (id != null ? id.value : this.id),
      decision: (decision != null ? decision.value : this.decision),
      applicantId: (applicantId != null ? applicantId.value : this.applicantId),
      applicant: (applicant != null ? applicant.value : this.applicant),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class FirebaseDevice {
  const FirebaseDevice({required this.userId, this.firebaseDeviceToken});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FirebaseDevice &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.firebaseDeviceToken, firebaseDeviceToken) ||
                const DeepCollectionEquality().equals(
                  other.firebaseDeviceToken,
                  firebaseDeviceToken,
                )));
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
      firebaseDeviceToken: firebaseDeviceToken ?? this.firebaseDeviceToken,
    );
  }

  FirebaseDevice copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String?>? firebaseDeviceToken,
  }) {
    return FirebaseDevice(
      userId: (userId != null ? userId.value : this.userId),
      firebaseDeviceToken:
          (firebaseDeviceToken != null
              ? firebaseDeviceToken.value
              : this.firebaseDeviceToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class FlappyBirdScoreBase {
  const FlappyBirdScoreBase({required this.$value});

  factory FlappyBirdScoreBase.fromJson(Map<String, dynamic> json) =>
      _$FlappyBirdScoreBaseFromJson(json);

  static const toJsonFactory = _$FlappyBirdScoreBaseToJson;
  Map<String, dynamic> toJson() => _$FlappyBirdScoreBaseToJson(this);

  @JsonKey(name: 'value', defaultValue: 0)
  final int $value;
  static const fromJsonFactory = _$FlappyBirdScoreBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FlappyBirdScoreBase &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^ runtimeType.hashCode;
}

extension $FlappyBirdScoreBaseExtension on FlappyBirdScoreBase {
  FlappyBirdScoreBase copyWith({int? $value}) {
    return FlappyBirdScoreBase($value: $value ?? this.$value);
  }

  FlappyBirdScoreBase copyWithWrapped({Wrapped<int>? $value}) {
    return FlappyBirdScoreBase(
      $value: ($value != null ? $value.value : this.$value),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class FlappyBirdScoreCompleteFeedBack {
  const FlappyBirdScoreCompleteFeedBack({
    required this.$value,
    required this.user,
    required this.creationTime,
    required this.position,
  });

  factory FlappyBirdScoreCompleteFeedBack.fromJson(Map<String, dynamic> json) =>
      _$FlappyBirdScoreCompleteFeedBackFromJson(json);

  static const toJsonFactory = _$FlappyBirdScoreCompleteFeedBackToJson;
  Map<String, dynamic> toJson() =>
      _$FlappyBirdScoreCompleteFeedBackToJson(this);

  @JsonKey(name: 'value', defaultValue: 0)
  final int $value;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  @JsonKey(name: 'creation_time')
  final DateTime creationTime;
  @JsonKey(name: 'position', defaultValue: 0)
  final int position;
  static const fromJsonFactory = _$FlappyBirdScoreCompleteFeedBackFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FlappyBirdScoreCompleteFeedBack &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.creationTime, creationTime) ||
                const DeepCollectionEquality().equals(
                  other.creationTime,
                  creationTime,
                )) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality().equals(
                  other.position,
                  position,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(creationTime) ^
      const DeepCollectionEquality().hash(position) ^
      runtimeType.hashCode;
}

extension $FlappyBirdScoreCompleteFeedBackExtension
    on FlappyBirdScoreCompleteFeedBack {
  FlappyBirdScoreCompleteFeedBack copyWith({
    int? $value,
    CoreUserSimple? user,
    DateTime? creationTime,
    int? position,
  }) {
    return FlappyBirdScoreCompleteFeedBack(
      $value: $value ?? this.$value,
      user: user ?? this.user,
      creationTime: creationTime ?? this.creationTime,
      position: position ?? this.position,
    );
  }

  FlappyBirdScoreCompleteFeedBack copyWithWrapped({
    Wrapped<int>? $value,
    Wrapped<CoreUserSimple>? user,
    Wrapped<DateTime>? creationTime,
    Wrapped<int>? position,
  }) {
    return FlappyBirdScoreCompleteFeedBack(
      $value: ($value != null ? $value.value : this.$value),
      user: (user != null ? user.value : this.user),
      creationTime:
          (creationTime != null ? creationTime.value : this.creationTime),
      position: (position != null ? position.value : this.position),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class FlappyBirdScoreInDB {
  const FlappyBirdScoreInDB({
    required this.$value,
    required this.user,
    required this.creationTime,
    required this.id,
    required this.userId,
  });

  factory FlappyBirdScoreInDB.fromJson(Map<String, dynamic> json) =>
      _$FlappyBirdScoreInDBFromJson(json);

  static const toJsonFactory = _$FlappyBirdScoreInDBToJson;
  Map<String, dynamic> toJson() => _$FlappyBirdScoreInDBToJson(this);

  @JsonKey(name: 'value', defaultValue: 0)
  final int $value;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  @JsonKey(name: 'creation_time')
  final DateTime creationTime;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  static const fromJsonFactory = _$FlappyBirdScoreInDBFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FlappyBirdScoreInDB &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.creationTime, creationTime) ||
                const DeepCollectionEquality().equals(
                  other.creationTime,
                  creationTime,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash($value) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(creationTime) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $FlappyBirdScoreInDBExtension on FlappyBirdScoreInDB {
  FlappyBirdScoreInDB copyWith({
    int? $value,
    CoreUserSimple? user,
    DateTime? creationTime,
    String? id,
    String? userId,
  }) {
    return FlappyBirdScoreInDB(
      $value: $value ?? this.$value,
      user: user ?? this.user,
      creationTime: creationTime ?? this.creationTime,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  FlappyBirdScoreInDB copyWithWrapped({
    Wrapped<int>? $value,
    Wrapped<CoreUserSimple>? user,
    Wrapped<DateTime>? creationTime,
    Wrapped<String>? id,
    Wrapped<String>? userId,
  }) {
    return FlappyBirdScoreInDB(
      $value: ($value != null ? $value.value : this.$value),
      user: (user != null ? user.value : this.user),
      creationTime:
          (creationTime != null ? creationTime.value : this.creationTime),
      id: (id != null ? id.value : this.id),
      userId: (userId != null ? userId.value : this.userId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GenerateTicketBase {
  const GenerateTicketBase({
    required this.name,
    required this.maxUse,
    required this.expiration,
  });

  factory GenerateTicketBase.fromJson(Map<String, dynamic> json) =>
      _$GenerateTicketBaseFromJson(json);

  static const toJsonFactory = _$GenerateTicketBaseToJson;
  Map<String, dynamic> toJson() => _$GenerateTicketBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'max_use', defaultValue: 0)
  final int maxUse;
  @JsonKey(name: 'expiration')
  final DateTime expiration;
  static const fromJsonFactory = _$GenerateTicketBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GenerateTicketBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.maxUse, maxUse) ||
                const DeepCollectionEquality().equals(other.maxUse, maxUse)) &&
            (identical(other.expiration, expiration) ||
                const DeepCollectionEquality().equals(
                  other.expiration,
                  expiration,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(maxUse) ^
      const DeepCollectionEquality().hash(expiration) ^
      runtimeType.hashCode;
}

extension $GenerateTicketBaseExtension on GenerateTicketBase {
  GenerateTicketBase copyWith({
    String? name,
    int? maxUse,
    DateTime? expiration,
  }) {
    return GenerateTicketBase(
      name: name ?? this.name,
      maxUse: maxUse ?? this.maxUse,
      expiration: expiration ?? this.expiration,
    );
  }

  GenerateTicketBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<int>? maxUse,
    Wrapped<DateTime>? expiration,
  }) {
    return GenerateTicketBase(
      name: (name != null ? name.value : this.name),
      maxUse: (maxUse != null ? maxUse.value : this.maxUse),
      expiration: (expiration != null ? expiration.value : this.expiration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GenerateTicketComplete {
  const GenerateTicketComplete({
    required this.name,
    required this.maxUse,
    required this.expiration,
    required this.id,
  });

  factory GenerateTicketComplete.fromJson(Map<String, dynamic> json) =>
      _$GenerateTicketCompleteFromJson(json);

  static const toJsonFactory = _$GenerateTicketCompleteToJson;
  Map<String, dynamic> toJson() => _$GenerateTicketCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'max_use', defaultValue: 0)
  final int maxUse;
  @JsonKey(name: 'expiration')
  final DateTime expiration;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$GenerateTicketCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GenerateTicketComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.maxUse, maxUse) ||
                const DeepCollectionEquality().equals(other.maxUse, maxUse)) &&
            (identical(other.expiration, expiration) ||
                const DeepCollectionEquality().equals(
                  other.expiration,
                  expiration,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(maxUse) ^
      const DeepCollectionEquality().hash(expiration) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $GenerateTicketCompleteExtension on GenerateTicketComplete {
  GenerateTicketComplete copyWith({
    String? name,
    int? maxUse,
    DateTime? expiration,
    String? id,
  }) {
    return GenerateTicketComplete(
      name: name ?? this.name,
      maxUse: maxUse ?? this.maxUse,
      expiration: expiration ?? this.expiration,
      id: id ?? this.id,
    );
  }

  GenerateTicketComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<int>? maxUse,
    Wrapped<DateTime>? expiration,
    Wrapped<String>? id,
  }) {
    return GenerateTicketComplete(
      name: (name != null ? name.value : this.name),
      maxUse: (maxUse != null ? maxUse.value : this.maxUse),
      expiration: (expiration != null ? expiration.value : this.expiration),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class HTTPValidationError {
  const HTTPValidationError({this.detail});

  factory HTTPValidationError.fromJson(Map<String, dynamic> json) =>
      _$HTTPValidationErrorFromJson(json);

  static const toJsonFactory = _$HTTPValidationErrorToJson;
  Map<String, dynamic> toJson() => _$HTTPValidationErrorToJson(this);

  @JsonKey(name: 'detail', defaultValue: null)
  final List<ValidationError>? detail;
  static const fromJsonFactory = _$HTTPValidationErrorFromJson;

  @override
  bool operator ==(Object other) {
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

  HTTPValidationError copyWithWrapped({
    Wrapped<List<ValidationError>?>? detail,
  }) {
    return HTTPValidationError(
      detail: (detail != null ? detail.value : this.detail),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class History {
  const History({
    required this.id,
    required this.type,
    required this.otherWalletName,
    required this.total,
    required this.creation,
    required this.status,
  });

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  static const toJsonFactory = _$HistoryToJson;
  Map<String, dynamic> toJson() => _$HistoryToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'type',
    toJson: historyTypeToJson,
    fromJson: historyTypeFromJson,
  )
  final enums.HistoryType type;
  @JsonKey(name: 'other_wallet_name', defaultValue: '')
  final String otherWalletName;
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(
    name: 'status',
    toJson: transactionStatusToJson,
    fromJson: transactionStatusFromJson,
  )
  final enums.TransactionStatus status;
  static const fromJsonFactory = _$HistoryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is History &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.otherWalletName, otherWalletName) ||
                const DeepCollectionEquality().equals(
                  other.otherWalletName,
                  otherWalletName,
                )) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(otherWalletName) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $HistoryExtension on History {
  History copyWith({
    String? id,
    enums.HistoryType? type,
    String? otherWalletName,
    int? total,
    DateTime? creation,
    enums.TransactionStatus? status,
  }) {
    return History(
      id: id ?? this.id,
      type: type ?? this.type,
      otherWalletName: otherWalletName ?? this.otherWalletName,
      total: total ?? this.total,
      creation: creation ?? this.creation,
      status: status ?? this.status,
    );
  }

  History copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<enums.HistoryType>? type,
    Wrapped<String>? otherWalletName,
    Wrapped<int>? total,
    Wrapped<DateTime>? creation,
    Wrapped<enums.TransactionStatus>? status,
  }) {
    return History(
      id: (id != null ? id.value : this.id),
      type: (type != null ? type.value : this.type),
      otherWalletName:
          (otherWalletName != null
              ? otherWalletName.value
              : this.otherWalletName),
      total: (total != null ? total.value : this.total),
      creation: (creation != null ? creation.value : this.creation),
      status: (status != null ? status.value : this.status),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Information &&
            (identical(other.manager, manager) ||
                const DeepCollectionEquality().equals(
                  other.manager,
                  manager,
                )) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
      description: description ?? this.description,
    );
  }

  Information copyWithWrapped({
    Wrapped<String>? manager,
    Wrapped<String>? link,
    Wrapped<String>? description,
  }) {
    return Information(
      manager: (manager != null ? manager.value : this.manager),
      link: (link != null ? link.value : this.link),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class InformationEdit {
  const InformationEdit({this.manager, this.link, this.description});

  factory InformationEdit.fromJson(Map<String, dynamic> json) =>
      _$InformationEditFromJson(json);

  static const toJsonFactory = _$InformationEditToJson;
  Map<String, dynamic> toJson() => _$InformationEditToJson(this);

  @JsonKey(name: 'manager')
  final String? manager;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$InformationEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InformationEdit &&
            (identical(other.manager, manager) ||
                const DeepCollectionEquality().equals(
                  other.manager,
                  manager,
                )) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
  InformationEdit copyWith({
    String? manager,
    String? link,
    String? description,
  }) {
    return InformationEdit(
      manager: manager ?? this.manager,
      link: link ?? this.link,
      description: description ?? this.description,
    );
  }

  InformationEdit copyWithWrapped({
    Wrapped<String?>? manager,
    Wrapped<String?>? link,
    Wrapped<String?>? description,
  }) {
    return InformationEdit(
      manager: (manager != null ? manager.value : this.manager),
      link: (link != null ? link.value : this.link),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IntrospectTokenResponse {
  const IntrospectTokenResponse({required this.active});

  factory IntrospectTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$IntrospectTokenResponseFromJson(json);

  static const toJsonFactory = _$IntrospectTokenResponseToJson;
  Map<String, dynamic> toJson() => _$IntrospectTokenResponseToJson(this);

  @JsonKey(name: 'active', defaultValue: false)
  final bool active;
  static const fromJsonFactory = _$IntrospectTokenResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IntrospectTokenResponse &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(active) ^ runtimeType.hashCode;
}

extension $IntrospectTokenResponseExtension on IntrospectTokenResponse {
  IntrospectTokenResponse copyWith({bool? active}) {
    return IntrospectTokenResponse(active: active ?? this.active);
  }

  IntrospectTokenResponse copyWithWrapped({Wrapped<bool>? active}) {
    return IntrospectTokenResponse(
      active: (active != null ? active.value : this.active),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class InviteToken {
  const InviteToken({required this.teamId, required this.token});

  factory InviteToken.fromJson(Map<String, dynamic> json) =>
      _$InviteTokenFromJson(json);

  static const toJsonFactory = _$InviteTokenToJson;
  Map<String, dynamic> toJson() => _$InviteTokenToJson(this);

  @JsonKey(name: 'team_id', defaultValue: '')
  final String teamId;
  @JsonKey(name: 'token', defaultValue: '')
  final String token;
  static const fromJsonFactory = _$InviteTokenFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is InviteToken &&
            (identical(other.teamId, teamId) ||
                const DeepCollectionEquality().equals(other.teamId, teamId)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(teamId) ^
      const DeepCollectionEquality().hash(token) ^
      runtimeType.hashCode;
}

extension $InviteTokenExtension on InviteToken {
  InviteToken copyWith({String? teamId, String? token}) {
    return InviteToken(
      teamId: teamId ?? this.teamId,
      token: token ?? this.token,
    );
  }

  InviteToken copyWithWrapped({
    Wrapped<String>? teamId,
    Wrapped<String>? token,
  }) {
    return InviteToken(
      teamId: (teamId != null ? teamId.value : this.teamId),
      token: (token != null ? token.value : this.token),
    );
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
  @JsonKey(name: 'suggested_lending_duration', defaultValue: 0)
  final int suggestedLendingDuration;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'loaner_id', defaultValue: '')
  final String loanerId;
  @JsonKey(name: 'loaned_quantity', defaultValue: 0)
  final int loanedQuantity;
  static const fromJsonFactory = _$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Item &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.suggestedCaution, suggestedCaution) ||
                const DeepCollectionEquality().equals(
                  other.suggestedCaution,
                  suggestedCaution,
                )) &&
            (identical(other.totalQuantity, totalQuantity) ||
                const DeepCollectionEquality().equals(
                  other.totalQuantity,
                  totalQuantity,
                )) &&
            (identical(
                  other.suggestedLendingDuration,
                  suggestedLendingDuration,
                ) ||
                const DeepCollectionEquality().equals(
                  other.suggestedLendingDuration,
                  suggestedLendingDuration,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality().equals(
                  other.loanerId,
                  loanerId,
                )) &&
            (identical(other.loanedQuantity, loanedQuantity) ||
                const DeepCollectionEquality().equals(
                  other.loanedQuantity,
                  loanedQuantity,
                )));
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
  Item copyWith({
    String? name,
    int? suggestedCaution,
    int? totalQuantity,
    int? suggestedLendingDuration,
    String? id,
    String? loanerId,
    int? loanedQuantity,
  }) {
    return Item(
      name: name ?? this.name,
      suggestedCaution: suggestedCaution ?? this.suggestedCaution,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      suggestedLendingDuration:
          suggestedLendingDuration ?? this.suggestedLendingDuration,
      id: id ?? this.id,
      loanerId: loanerId ?? this.loanerId,
      loanedQuantity: loanedQuantity ?? this.loanedQuantity,
    );
  }

  Item copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<int>? suggestedCaution,
    Wrapped<int>? totalQuantity,
    Wrapped<int>? suggestedLendingDuration,
    Wrapped<String>? id,
    Wrapped<String>? loanerId,
    Wrapped<int>? loanedQuantity,
  }) {
    return Item(
      name: (name != null ? name.value : this.name),
      suggestedCaution:
          (suggestedCaution != null
              ? suggestedCaution.value
              : this.suggestedCaution),
      totalQuantity:
          (totalQuantity != null ? totalQuantity.value : this.totalQuantity),
      suggestedLendingDuration:
          (suggestedLendingDuration != null
              ? suggestedLendingDuration.value
              : this.suggestedLendingDuration),
      id: (id != null ? id.value : this.id),
      loanerId: (loanerId != null ? loanerId.value : this.loanerId),
      loanedQuantity:
          (loanedQuantity != null ? loanedQuantity.value : this.loanedQuantity),
    );
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
  @JsonKey(name: 'suggested_lending_duration', defaultValue: 0)
  final int suggestedLendingDuration;
  static const fromJsonFactory = _$ItemBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ItemBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.suggestedCaution, suggestedCaution) ||
                const DeepCollectionEquality().equals(
                  other.suggestedCaution,
                  suggestedCaution,
                )) &&
            (identical(other.totalQuantity, totalQuantity) ||
                const DeepCollectionEquality().equals(
                  other.totalQuantity,
                  totalQuantity,
                )) &&
            (identical(
                  other.suggestedLendingDuration,
                  suggestedLendingDuration,
                ) ||
                const DeepCollectionEquality().equals(
                  other.suggestedLendingDuration,
                  suggestedLendingDuration,
                )));
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
  ItemBase copyWith({
    String? name,
    int? suggestedCaution,
    int? totalQuantity,
    int? suggestedLendingDuration,
  }) {
    return ItemBase(
      name: name ?? this.name,
      suggestedCaution: suggestedCaution ?? this.suggestedCaution,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      suggestedLendingDuration:
          suggestedLendingDuration ?? this.suggestedLendingDuration,
    );
  }

  ItemBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<int>? suggestedCaution,
    Wrapped<int>? totalQuantity,
    Wrapped<int>? suggestedLendingDuration,
  }) {
    return ItemBase(
      name: (name != null ? name.value : this.name),
      suggestedCaution:
          (suggestedCaution != null
              ? suggestedCaution.value
              : this.suggestedCaution),
      totalQuantity:
          (totalQuantity != null ? totalQuantity.value : this.totalQuantity),
      suggestedLendingDuration:
          (suggestedLendingDuration != null
              ? suggestedLendingDuration.value
              : this.suggestedLendingDuration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ItemBorrowed {
  const ItemBorrowed({required this.itemId, required this.quantity});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ItemBorrowed &&
            (identical(other.itemId, itemId) ||
                const DeepCollectionEquality().equals(other.itemId, itemId)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )));
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
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
    );
  }

  ItemBorrowed copyWithWrapped({
    Wrapped<String>? itemId,
    Wrapped<int>? quantity,
  }) {
    return ItemBorrowed(
      itemId: (itemId != null ? itemId.value : this.itemId),
      quantity: (quantity != null ? quantity.value : this.quantity),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ItemQuantity {
  const ItemQuantity({required this.quantity, required this.itemSimple});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ItemQuantity &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )) &&
            (identical(other.itemSimple, itemSimple) ||
                const DeepCollectionEquality().equals(
                  other.itemSimple,
                  itemSimple,
                )));
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
      itemSimple: itemSimple ?? this.itemSimple,
    );
  }

  ItemQuantity copyWithWrapped({
    Wrapped<int>? quantity,
    Wrapped<ItemSimple>? itemSimple,
  }) {
    return ItemQuantity(
      quantity: (quantity != null ? quantity.value : this.quantity),
      itemSimple: (itemSimple != null ? itemSimple.value : this.itemSimple),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ItemSimple &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality().equals(
                  other.loanerId,
                  loanerId,
                )));
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
      loanerId: loanerId ?? this.loanerId,
    );
  }

  ItemSimple copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? loanerId,
  }) {
    return ItemSimple(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      loanerId: (loanerId != null ? loanerId.value : this.loanerId),
    );
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

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'suggested_caution')
  final int? suggestedCaution;
  @JsonKey(name: 'total_quantity')
  final int? totalQuantity;
  @JsonKey(name: 'suggested_lending_duration')
  final int? suggestedLendingDuration;
  static const fromJsonFactory = _$ItemUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ItemUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.suggestedCaution, suggestedCaution) ||
                const DeepCollectionEquality().equals(
                  other.suggestedCaution,
                  suggestedCaution,
                )) &&
            (identical(other.totalQuantity, totalQuantity) ||
                const DeepCollectionEquality().equals(
                  other.totalQuantity,
                  totalQuantity,
                )) &&
            (identical(
                  other.suggestedLendingDuration,
                  suggestedLendingDuration,
                ) ||
                const DeepCollectionEquality().equals(
                  other.suggestedLendingDuration,
                  suggestedLendingDuration,
                )));
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
  ItemUpdate copyWith({
    String? name,
    int? suggestedCaution,
    int? totalQuantity,
    int? suggestedLendingDuration,
  }) {
    return ItemUpdate(
      name: name ?? this.name,
      suggestedCaution: suggestedCaution ?? this.suggestedCaution,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      suggestedLendingDuration:
          suggestedLendingDuration ?? this.suggestedLendingDuration,
    );
  }

  ItemUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<int?>? suggestedCaution,
    Wrapped<int?>? totalQuantity,
    Wrapped<int?>? suggestedLendingDuration,
  }) {
    return ItemUpdate(
      name: (name != null ? name.value : this.name),
      suggestedCaution:
          (suggestedCaution != null
              ? suggestedCaution.value
              : this.suggestedCaution),
      totalQuantity:
          (totalQuantity != null ? totalQuantity.value : this.totalQuantity),
      suggestedLendingDuration:
          (suggestedLendingDuration != null
              ? suggestedLendingDuration.value
              : this.suggestedLendingDuration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class KindsReturn {
  const KindsReturn({required this.kinds});

  factory KindsReturn.fromJson(Map<String, dynamic> json) =>
      _$KindsReturnFromJson(json);

  static const toJsonFactory = _$KindsReturnToJson;
  Map<String, dynamic> toJson() => _$KindsReturnToJson(this);

  @JsonKey(
    name: 'kinds',
    defaultValue: <enums.Kinds>[],
    toJson: kindsListToJson,
    fromJson: kindsListFromJson,
  )
  final List<enums.Kinds> kinds;
  static const fromJsonFactory = _$KindsReturnFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is KindsReturn &&
            (identical(other.kinds, kinds) ||
                const DeepCollectionEquality().equals(other.kinds, kinds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(kinds) ^ runtimeType.hashCode;
}

extension $KindsReturnExtension on KindsReturn {
  KindsReturn copyWith({List<enums.Kinds>? kinds}) {
    return KindsReturn(kinds: kinds ?? this.kinds);
  }

  KindsReturn copyWithWrapped({Wrapped<List<enums.Kinds>>? kinds}) {
    return KindsReturn(kinds: (kinds != null ? kinds.value : this.kinds));
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
  @JsonKey(name: 'type', toJson: listTypeToJson, fromJson: listTypeFromJson)
  final enums.ListType type;
  @JsonKey(name: 'section_id', defaultValue: '')
  final String sectionId;
  @JsonKey(name: 'members', defaultValue: <ListMemberBase>[])
  final List<ListMemberBase> members;
  @JsonKey(name: 'program')
  final String? program;
  static const fromJsonFactory = _$ListBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ListBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.sectionId, sectionId) ||
                const DeepCollectionEquality().equals(
                  other.sectionId,
                  sectionId,
                )) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality().equals(
                  other.members,
                  members,
                )) &&
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
  ListBase copyWith({
    String? name,
    String? description,
    enums.ListType? type,
    String? sectionId,
    List<ListMemberBase>? members,
    String? program,
  }) {
    return ListBase(
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      sectionId: sectionId ?? this.sectionId,
      members: members ?? this.members,
      program: program ?? this.program,
    );
  }

  ListBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<enums.ListType>? type,
    Wrapped<String>? sectionId,
    Wrapped<List<ListMemberBase>>? members,
    Wrapped<String?>? program,
  }) {
    return ListBase(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      type: (type != null ? type.value : this.type),
      sectionId: (sectionId != null ? sectionId.value : this.sectionId),
      members: (members != null ? members.value : this.members),
      program: (program != null ? program.value : this.program),
    );
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

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(
    name: 'type',
    toJson: listTypeNullableToJson,
    fromJson: listTypeNullableFromJson,
  )
  final enums.ListType? type;
  @JsonKey(name: 'members')
  final List<ListMemberBase>? members;
  @JsonKey(name: 'program')
  final String? program;
  static const fromJsonFactory = _$ListEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ListEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality().equals(
                  other.members,
                  members,
                )) &&
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
  ListEdit copyWith({
    String? name,
    String? description,
    enums.ListType? type,
    List<ListMemberBase>? members,
    String? program,
  }) {
    return ListEdit(
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      members: members ?? this.members,
      program: program ?? this.program,
    );
  }

  ListEdit copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? description,
    Wrapped<enums.ListType?>? type,
    Wrapped<List<ListMemberBase>?>? members,
    Wrapped<String?>? program,
  }) {
    return ListEdit(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      type: (type != null ? type.value : this.type),
      members: (members != null ? members.value : this.members),
      program: (program != null ? program.value : this.program),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ListMemberBase {
  const ListMemberBase({required this.userId, required this.role});

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
  bool operator ==(Object other) {
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
      userId: userId ?? this.userId,
      role: role ?? this.role,
    );
  }

  ListMemberBase copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? role,
  }) {
    return ListMemberBase(
      userId: (userId != null ? userId.value : this.userId),
      role: (role != null ? role.value : this.role),
    );
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
  bool operator ==(Object other) {
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
  ListMemberComplete copyWith({
    String? userId,
    String? role,
    CoreUserSimple? user,
  }) {
    return ListMemberComplete(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      user: user ?? this.user,
    );
  }

  ListMemberComplete copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? role,
    Wrapped<CoreUserSimple>? user,
  }) {
    return ListMemberComplete(
      userId: (userId != null ? userId.value : this.userId),
      role: (role != null ? role.value : this.role),
      user: (user != null ? user.value : this.user),
    );
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
  @JsonKey(name: 'type', toJson: listTypeToJson, fromJson: listTypeFromJson)
  final enums.ListType type;
  @JsonKey(name: 'section')
  final SectionComplete section;
  @JsonKey(name: 'members', defaultValue: <ListMemberComplete>[])
  final List<ListMemberComplete> members;
  @JsonKey(name: 'program')
  final String? program;
  static const fromJsonFactory = _$ListReturnFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ListReturn &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.section, section) ||
                const DeepCollectionEquality().equals(
                  other.section,
                  section,
                )) &&
            (identical(other.members, members) ||
                const DeepCollectionEquality().equals(
                  other.members,
                  members,
                )) &&
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
  ListReturn copyWith({
    String? id,
    String? name,
    String? description,
    enums.ListType? type,
    SectionComplete? section,
    List<ListMemberComplete>? members,
    String? program,
  }) {
    return ListReturn(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      section: section ?? this.section,
      members: members ?? this.members,
      program: program ?? this.program,
    );
  }

  ListReturn copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<enums.ListType>? type,
    Wrapped<SectionComplete>? section,
    Wrapped<List<ListMemberComplete>>? members,
    Wrapped<String?>? program,
  }) {
    return ListReturn(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      type: (type != null ? type.value : this.type),
      section: (section != null ? section.value : this.section),
      members: (members != null ? members.value : this.members),
      program: (program != null ? program.value : this.program),
    );
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
    required this.returnedDate,
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
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'caution')
  final String? caution;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'returned', defaultValue: false)
  final bool returned;
  @JsonKey(name: 'returned_date')
  final String returnedDate;
  @JsonKey(name: 'items_qty', defaultValue: <ItemQuantity>[])
  final List<ItemQuantity> itemsQty;
  @JsonKey(name: 'borrower')
  final CoreUserSimple borrower;
  @JsonKey(name: 'loaner')
  final Loaner loaner;
  static const fromJsonFactory = _$LoanFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Loan &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality().equals(
                  other.borrowerId,
                  borrowerId,
                )) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality().equals(
                  other.loanerId,
                  loanerId,
                )) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.caution, caution) ||
                const DeepCollectionEquality().equals(
                  other.caution,
                  caution,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.returned, returned) ||
                const DeepCollectionEquality().equals(
                  other.returned,
                  returned,
                )) &&
            (identical(other.returnedDate, returnedDate) ||
                const DeepCollectionEquality().equals(
                  other.returnedDate,
                  returnedDate,
                )) &&
            (identical(other.itemsQty, itemsQty) ||
                const DeepCollectionEquality().equals(
                  other.itemsQty,
                  itemsQty,
                )) &&
            (identical(other.borrower, borrower) ||
                const DeepCollectionEquality().equals(
                  other.borrower,
                  borrower,
                )) &&
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
      const DeepCollectionEquality().hash(returnedDate) ^
      const DeepCollectionEquality().hash(itemsQty) ^
      const DeepCollectionEquality().hash(borrower) ^
      const DeepCollectionEquality().hash(loaner) ^
      runtimeType.hashCode;
}

extension $LoanExtension on Loan {
  Loan copyWith({
    String? borrowerId,
    String? loanerId,
    DateTime? start,
    DateTime? end,
    String? notes,
    String? caution,
    String? id,
    bool? returned,
    String? returnedDate,
    List<ItemQuantity>? itemsQty,
    CoreUserSimple? borrower,
    Loaner? loaner,
  }) {
    return Loan(
      borrowerId: borrowerId ?? this.borrowerId,
      loanerId: loanerId ?? this.loanerId,
      start: start ?? this.start,
      end: end ?? this.end,
      notes: notes ?? this.notes,
      caution: caution ?? this.caution,
      id: id ?? this.id,
      returned: returned ?? this.returned,
      returnedDate: returnedDate ?? this.returnedDate,
      itemsQty: itemsQty ?? this.itemsQty,
      borrower: borrower ?? this.borrower,
      loaner: loaner ?? this.loaner,
    );
  }

  Loan copyWithWrapped({
    Wrapped<String>? borrowerId,
    Wrapped<String>? loanerId,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<String?>? notes,
    Wrapped<String?>? caution,
    Wrapped<String>? id,
    Wrapped<bool>? returned,
    Wrapped<String>? returnedDate,
    Wrapped<List<ItemQuantity>>? itemsQty,
    Wrapped<CoreUserSimple>? borrower,
    Wrapped<Loaner>? loaner,
  }) {
    return Loan(
      borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
      loanerId: (loanerId != null ? loanerId.value : this.loanerId),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      notes: (notes != null ? notes.value : this.notes),
      caution: (caution != null ? caution.value : this.caution),
      id: (id != null ? id.value : this.id),
      returned: (returned != null ? returned.value : this.returned),
      returnedDate:
          (returnedDate != null ? returnedDate.value : this.returnedDate),
      itemsQty: (itemsQty != null ? itemsQty.value : this.itemsQty),
      borrower: (borrower != null ? borrower.value : this.borrower),
      loaner: (loaner != null ? loaner.value : this.loaner),
    );
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
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'caution')
  final String? caution;
  @JsonKey(name: 'items_borrowed', defaultValue: <ItemBorrowed>[])
  final List<ItemBorrowed> itemsBorrowed;
  static const fromJsonFactory = _$LoanCreationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoanCreation &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality().equals(
                  other.borrowerId,
                  borrowerId,
                )) &&
            (identical(other.loanerId, loanerId) ||
                const DeepCollectionEquality().equals(
                  other.loanerId,
                  loanerId,
                )) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.caution, caution) ||
                const DeepCollectionEquality().equals(
                  other.caution,
                  caution,
                )) &&
            (identical(other.itemsBorrowed, itemsBorrowed) ||
                const DeepCollectionEquality().equals(
                  other.itemsBorrowed,
                  itemsBorrowed,
                )));
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
  LoanCreation copyWith({
    String? borrowerId,
    String? loanerId,
    DateTime? start,
    DateTime? end,
    String? notes,
    String? caution,
    List<ItemBorrowed>? itemsBorrowed,
  }) {
    return LoanCreation(
      borrowerId: borrowerId ?? this.borrowerId,
      loanerId: loanerId ?? this.loanerId,
      start: start ?? this.start,
      end: end ?? this.end,
      notes: notes ?? this.notes,
      caution: caution ?? this.caution,
      itemsBorrowed: itemsBorrowed ?? this.itemsBorrowed,
    );
  }

  LoanCreation copyWithWrapped({
    Wrapped<String>? borrowerId,
    Wrapped<String>? loanerId,
    Wrapped<DateTime>? start,
    Wrapped<DateTime>? end,
    Wrapped<String?>? notes,
    Wrapped<String?>? caution,
    Wrapped<List<ItemBorrowed>>? itemsBorrowed,
  }) {
    return LoanCreation(
      borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
      loanerId: (loanerId != null ? loanerId.value : this.loanerId),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      notes: (notes != null ? notes.value : this.notes),
      caution: (caution != null ? caution.value : this.caution),
      itemsBorrowed:
          (itemsBorrowed != null ? itemsBorrowed.value : this.itemsBorrowed),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LoanExtend {
  const LoanExtend({this.end, this.duration});

  factory LoanExtend.fromJson(Map<String, dynamic> json) =>
      _$LoanExtendFromJson(json);

  static const toJsonFactory = _$LoanExtendToJson;
  Map<String, dynamic> toJson() => _$LoanExtendToJson(this);

  @JsonKey(name: 'end')
  final String? end;
  @JsonKey(name: 'duration')
  final int? duration;
  static const fromJsonFactory = _$LoanExtendFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoanExtend &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality().equals(
                  other.duration,
                  duration,
                )));
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
  LoanExtend copyWith({String? end, int? duration}) {
    return LoanExtend(
      end: end ?? this.end,
      duration: duration ?? this.duration,
    );
  }

  LoanExtend copyWithWrapped({Wrapped<String?>? end, Wrapped<int?>? duration}) {
    return LoanExtend(
      end: (end != null ? end.value : this.end),
      duration: (duration != null ? duration.value : this.duration),
    );
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

  @JsonKey(name: 'borrower_id')
  final String? borrowerId;
  @JsonKey(name: 'start')
  final String? start;
  @JsonKey(name: 'end')
  final String? end;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'caution')
  final String? caution;
  @JsonKey(name: 'returned')
  final bool? returned;
  @JsonKey(name: 'items_borrowed')
  final List<ItemBorrowed>? itemsBorrowed;
  static const fromJsonFactory = _$LoanUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoanUpdate &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality().equals(
                  other.borrowerId,
                  borrowerId,
                )) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.caution, caution) ||
                const DeepCollectionEquality().equals(
                  other.caution,
                  caution,
                )) &&
            (identical(other.returned, returned) ||
                const DeepCollectionEquality().equals(
                  other.returned,
                  returned,
                )) &&
            (identical(other.itemsBorrowed, itemsBorrowed) ||
                const DeepCollectionEquality().equals(
                  other.itemsBorrowed,
                  itemsBorrowed,
                )));
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
  LoanUpdate copyWith({
    String? borrowerId,
    String? start,
    String? end,
    String? notes,
    String? caution,
    bool? returned,
    List<ItemBorrowed>? itemsBorrowed,
  }) {
    return LoanUpdate(
      borrowerId: borrowerId ?? this.borrowerId,
      start: start ?? this.start,
      end: end ?? this.end,
      notes: notes ?? this.notes,
      caution: caution ?? this.caution,
      returned: returned ?? this.returned,
      itemsBorrowed: itemsBorrowed ?? this.itemsBorrowed,
    );
  }

  LoanUpdate copyWithWrapped({
    Wrapped<String?>? borrowerId,
    Wrapped<String?>? start,
    Wrapped<String?>? end,
    Wrapped<String?>? notes,
    Wrapped<String?>? caution,
    Wrapped<bool?>? returned,
    Wrapped<List<ItemBorrowed>?>? itemsBorrowed,
  }) {
    return LoanUpdate(
      borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
      start: (start != null ? start.value : this.start),
      end: (end != null ? end.value : this.end),
      notes: (notes != null ? notes.value : this.notes),
      caution: (caution != null ? caution.value : this.caution),
      returned: (returned != null ? returned.value : this.returned),
      itemsBorrowed:
          (itemsBorrowed != null ? itemsBorrowed.value : this.itemsBorrowed),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Loaner &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality().equals(
                  other.groupManagerId,
                  groupManagerId,
                )) &&
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
      id: id ?? this.id,
    );
  }

  Loaner copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupManagerId,
    Wrapped<String>? id,
  }) {
    return Loaner(
      name: (name != null ? name.value : this.name),
      groupManagerId:
          (groupManagerId != null ? groupManagerId.value : this.groupManagerId),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LoanerBase {
  const LoanerBase({required this.name, required this.groupManagerId});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoanerBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality().equals(
                  other.groupManagerId,
                  groupManagerId,
                )));
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
      groupManagerId: groupManagerId ?? this.groupManagerId,
    );
  }

  LoanerBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupManagerId,
  }) {
    return LoanerBase(
      name: (name != null ? name.value : this.name),
      groupManagerId:
          (groupManagerId != null ? groupManagerId.value : this.groupManagerId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LoanerUpdate {
  const LoanerUpdate({this.name, this.groupManagerId});

  factory LoanerUpdate.fromJson(Map<String, dynamic> json) =>
      _$LoanerUpdateFromJson(json);

  static const toJsonFactory = _$LoanerUpdateToJson;
  Map<String, dynamic> toJson() => _$LoanerUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'group_manager_id')
  final String? groupManagerId;
  static const fromJsonFactory = _$LoanerUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoanerUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupManagerId, groupManagerId) ||
                const DeepCollectionEquality().equals(
                  other.groupManagerId,
                  groupManagerId,
                )));
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
      groupManagerId: groupManagerId ?? this.groupManagerId,
    );
  }

  LoanerUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? groupManagerId,
  }) {
    return LoanerUpdate(
      name: (name != null ? name.value : this.name),
      groupManagerId:
          (groupManagerId != null ? groupManagerId.value : this.groupManagerId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MailMigrationRequest {
  const MailMigrationRequest({required this.newEmail});

  factory MailMigrationRequest.fromJson(Map<String, dynamic> json) =>
      _$MailMigrationRequestFromJson(json);

  static const toJsonFactory = _$MailMigrationRequestToJson;
  Map<String, dynamic> toJson() => _$MailMigrationRequestToJson(this);

  @JsonKey(name: 'new_email', defaultValue: '')
  final String newEmail;
  static const fromJsonFactory = _$MailMigrationRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MailMigrationRequest &&
            (identical(other.newEmail, newEmail) ||
                const DeepCollectionEquality().equals(
                  other.newEmail,
                  newEmail,
                )));
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
      newEmail: (newEmail != null ? newEmail.value : this.newEmail),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Manager {
  const Manager({required this.name, required this.groupId, required this.id});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Manager &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(
                  other.groupId,
                  groupId,
                )) &&
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
      id: id ?? this.id,
    );
  }

  Manager copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupId,
    Wrapped<String>? id,
  }) {
    return Manager(
      name: (name != null ? name.value : this.name),
      groupId: (groupId != null ? groupId.value : this.groupId),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ManagerBase {
  const ManagerBase({required this.name, required this.groupId});

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
  bool operator ==(Object other) {
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
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
    );
  }

  ManagerBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupId,
  }) {
    return ManagerBase(
      name: (name != null ? name.value : this.name),
      groupId: (groupId != null ? groupId.value : this.groupId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ManagerUpdate {
  const ManagerUpdate({this.name, this.groupId});

  factory ManagerUpdate.fromJson(Map<String, dynamic> json) =>
      _$ManagerUpdateFromJson(json);

  static const toJsonFactory = _$ManagerUpdateToJson;
  Map<String, dynamic> toJson() => _$ManagerUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'group_id')
  final String? groupId;
  static const fromJsonFactory = _$ManagerUpdateFromJson;

  @override
  bool operator ==(Object other) {
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
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
    );
  }

  ManagerUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? groupId,
  }) {
    return ManagerUpdate(
      name: (name != null ? name.value : this.name),
      groupId: (groupId != null ? groupId.value : this.groupId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MemberComplete {
  const MemberComplete({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
    required this.email,
    this.phone,
    this.promo,
    required this.memberships,
  });

  factory MemberComplete.fromJson(Map<String, dynamic> json) =>
      _$MemberCompleteFromJson(json);

  static const toJsonFactory = _$MemberCompleteToJson;
  Map<String, dynamic> toJson() => _$MemberCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(name: 'memberships', defaultValue: <MembershipComplete>[])
  final List<MembershipComplete> memberships;
  static const fromJsonFactory = _$MemberCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MemberComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.memberships, memberships) ||
                const DeepCollectionEquality().equals(
                  other.memberships,
                  memberships,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(memberships) ^
      runtimeType.hashCode;
}

extension $MemberCompleteExtension on MemberComplete {
  MemberComplete copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
    String? email,
    String? phone,
    int? promo,
    List<MembershipComplete>? memberships,
  }) {
    return MemberComplete(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      promo: promo ?? this.promo,
      memberships: memberships ?? this.memberships,
    );
  }

  MemberComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
    Wrapped<String>? email,
    Wrapped<String?>? phone,
    Wrapped<int?>? promo,
    Wrapped<List<MembershipComplete>>? memberships,
  }) {
    return MemberComplete(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      email: (email != null ? email.value : this.email),
      phone: (phone != null ? phone.value : this.phone),
      promo: (promo != null ? promo.value : this.promo),
      memberships: (memberships != null ? memberships.value : this.memberships),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MembershipComplete {
  const MembershipComplete({
    required this.userId,
    required this.associationId,
    required this.mandateYear,
    required this.roleName,
    this.roleTags,
    required this.memberOrder,
    required this.id,
  });

  factory MembershipComplete.fromJson(Map<String, dynamic> json) =>
      _$MembershipCompleteFromJson(json);

  static const toJsonFactory = _$MembershipCompleteToJson;
  Map<String, dynamic> toJson() => _$MembershipCompleteToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'association_id', defaultValue: '')
  final String associationId;
  @JsonKey(name: 'mandate_year', defaultValue: 0)
  final int mandateYear;
  @JsonKey(name: 'role_name', defaultValue: '')
  final String roleName;
  @JsonKey(name: 'role_tags')
  final String? roleTags;
  @JsonKey(name: 'member_order', defaultValue: 0)
  final int memberOrder;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$MembershipCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MembershipComplete &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.associationId, associationId) ||
                const DeepCollectionEquality().equals(
                  other.associationId,
                  associationId,
                )) &&
            (identical(other.mandateYear, mandateYear) ||
                const DeepCollectionEquality().equals(
                  other.mandateYear,
                  mandateYear,
                )) &&
            (identical(other.roleName, roleName) ||
                const DeepCollectionEquality().equals(
                  other.roleName,
                  roleName,
                )) &&
            (identical(other.roleTags, roleTags) ||
                const DeepCollectionEquality().equals(
                  other.roleTags,
                  roleTags,
                )) &&
            (identical(other.memberOrder, memberOrder) ||
                const DeepCollectionEquality().equals(
                  other.memberOrder,
                  memberOrder,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(associationId) ^
      const DeepCollectionEquality().hash(mandateYear) ^
      const DeepCollectionEquality().hash(roleName) ^
      const DeepCollectionEquality().hash(roleTags) ^
      const DeepCollectionEquality().hash(memberOrder) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $MembershipCompleteExtension on MembershipComplete {
  MembershipComplete copyWith({
    String? userId,
    String? associationId,
    int? mandateYear,
    String? roleName,
    String? roleTags,
    int? memberOrder,
    String? id,
  }) {
    return MembershipComplete(
      userId: userId ?? this.userId,
      associationId: associationId ?? this.associationId,
      mandateYear: mandateYear ?? this.mandateYear,
      roleName: roleName ?? this.roleName,
      roleTags: roleTags ?? this.roleTags,
      memberOrder: memberOrder ?? this.memberOrder,
      id: id ?? this.id,
    );
  }

  MembershipComplete copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? associationId,
    Wrapped<int>? mandateYear,
    Wrapped<String>? roleName,
    Wrapped<String?>? roleTags,
    Wrapped<int>? memberOrder,
    Wrapped<String>? id,
  }) {
    return MembershipComplete(
      userId: (userId != null ? userId.value : this.userId),
      associationId:
          (associationId != null ? associationId.value : this.associationId),
      mandateYear: (mandateYear != null ? mandateYear.value : this.mandateYear),
      roleName: (roleName != null ? roleName.value : this.roleName),
      roleTags: (roleTags != null ? roleTags.value : this.roleTags),
      memberOrder: (memberOrder != null ? memberOrder.value : this.memberOrder),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MembershipEdit {
  const MembershipEdit({this.roleName, this.roleTags, this.memberOrder});

  factory MembershipEdit.fromJson(Map<String, dynamic> json) =>
      _$MembershipEditFromJson(json);

  static const toJsonFactory = _$MembershipEditToJson;
  Map<String, dynamic> toJson() => _$MembershipEditToJson(this);

  @JsonKey(name: 'role_name')
  final String? roleName;
  @JsonKey(name: 'role_tags')
  final String? roleTags;
  @JsonKey(name: 'member_order')
  final int? memberOrder;
  static const fromJsonFactory = _$MembershipEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MembershipEdit &&
            (identical(other.roleName, roleName) ||
                const DeepCollectionEquality().equals(
                  other.roleName,
                  roleName,
                )) &&
            (identical(other.roleTags, roleTags) ||
                const DeepCollectionEquality().equals(
                  other.roleTags,
                  roleTags,
                )) &&
            (identical(other.memberOrder, memberOrder) ||
                const DeepCollectionEquality().equals(
                  other.memberOrder,
                  memberOrder,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(roleName) ^
      const DeepCollectionEquality().hash(roleTags) ^
      const DeepCollectionEquality().hash(memberOrder) ^
      runtimeType.hashCode;
}

extension $MembershipEditExtension on MembershipEdit {
  MembershipEdit copyWith({
    String? roleName,
    String? roleTags,
    int? memberOrder,
  }) {
    return MembershipEdit(
      roleName: roleName ?? this.roleName,
      roleTags: roleTags ?? this.roleTags,
      memberOrder: memberOrder ?? this.memberOrder,
    );
  }

  MembershipEdit copyWithWrapped({
    Wrapped<String?>? roleName,
    Wrapped<String?>? roleTags,
    Wrapped<int?>? memberOrder,
  }) {
    return MembershipEdit(
      roleName: (roleName != null ? roleName.value : this.roleName),
      roleTags: (roleTags != null ? roleTags.value : this.roleTags),
      memberOrder: (memberOrder != null ? memberOrder.value : this.memberOrder),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MembershipSimple {
  const MembershipSimple({
    required this.name,
    required this.managerGroupId,
    required this.id,
  });

  factory MembershipSimple.fromJson(Map<String, dynamic> json) =>
      _$MembershipSimpleFromJson(json);

  static const toJsonFactory = _$MembershipSimpleToJson;
  Map<String, dynamic> toJson() => _$MembershipSimpleToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'manager_group_id', defaultValue: '')
  final String managerGroupId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$MembershipSimpleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MembershipSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.managerGroupId, managerGroupId) ||
                const DeepCollectionEquality().equals(
                  other.managerGroupId,
                  managerGroupId,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(managerGroupId) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $MembershipSimpleExtension on MembershipSimple {
  MembershipSimple copyWith({
    String? name,
    String? managerGroupId,
    String? id,
  }) {
    return MembershipSimple(
      name: name ?? this.name,
      managerGroupId: managerGroupId ?? this.managerGroupId,
      id: id ?? this.id,
    );
  }

  MembershipSimple copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? managerGroupId,
    Wrapped<String>? id,
  }) {
    return MembershipSimple(
      name: (name != null ? name.value : this.name),
      managerGroupId:
          (managerGroupId != null ? managerGroupId.value : this.managerGroupId),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MembershipUserMappingEmail {
  const MembershipUserMappingEmail({
    required this.userEmail,
    required this.startDate,
    required this.endDate,
  });

  factory MembershipUserMappingEmail.fromJson(Map<String, dynamic> json) =>
      _$MembershipUserMappingEmailFromJson(json);

  static const toJsonFactory = _$MembershipUserMappingEmailToJson;
  Map<String, dynamic> toJson() => _$MembershipUserMappingEmailToJson(this);

  @JsonKey(name: 'user_email', defaultValue: '')
  final String userEmail;
  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime endDate;
  static const fromJsonFactory = _$MembershipUserMappingEmailFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MembershipUserMappingEmail &&
            (identical(other.userEmail, userEmail) ||
                const DeepCollectionEquality().equals(
                  other.userEmail,
                  userEmail,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(other.endDate, endDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userEmail) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      runtimeType.hashCode;
}

extension $MembershipUserMappingEmailExtension on MembershipUserMappingEmail {
  MembershipUserMappingEmail copyWith({
    String? userEmail,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return MembershipUserMappingEmail(
      userEmail: userEmail ?? this.userEmail,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  MembershipUserMappingEmail copyWithWrapped({
    Wrapped<String>? userEmail,
    Wrapped<DateTime>? startDate,
    Wrapped<DateTime>? endDate,
  }) {
    return MembershipUserMappingEmail(
      userEmail: (userEmail != null ? userEmail.value : this.userEmail),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ModuleVisibility {
  const ModuleVisibility({
    required this.root,
    required this.allowedGroupIds,
    required this.allowedAccountTypes,
  });

  factory ModuleVisibility.fromJson(Map<String, dynamic> json) =>
      _$ModuleVisibilityFromJson(json);

  static const toJsonFactory = _$ModuleVisibilityToJson;
  Map<String, dynamic> toJson() => _$ModuleVisibilityToJson(this);

  @JsonKey(name: 'root', defaultValue: '')
  final String root;
  @JsonKey(name: 'allowed_group_ids', defaultValue: <String>[])
  final List<String> allowedGroupIds;
  @JsonKey(
    name: 'allowed_account_types',
    defaultValue: <enums.AccountType>[],
    toJson: accountTypeListToJson,
    fromJson: accountTypeListFromJson,
  )
  final List<enums.AccountType> allowedAccountTypes;
  static const fromJsonFactory = _$ModuleVisibilityFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ModuleVisibility &&
            (identical(other.root, root) ||
                const DeepCollectionEquality().equals(other.root, root)) &&
            (identical(other.allowedGroupIds, allowedGroupIds) ||
                const DeepCollectionEquality().equals(
                  other.allowedGroupIds,
                  allowedGroupIds,
                )) &&
            (identical(other.allowedAccountTypes, allowedAccountTypes) ||
                const DeepCollectionEquality().equals(
                  other.allowedAccountTypes,
                  allowedAccountTypes,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(root) ^
      const DeepCollectionEquality().hash(allowedGroupIds) ^
      const DeepCollectionEquality().hash(allowedAccountTypes) ^
      runtimeType.hashCode;
}

extension $ModuleVisibilityExtension on ModuleVisibility {
  ModuleVisibility copyWith({
    String? root,
    List<String>? allowedGroupIds,
    List<enums.AccountType>? allowedAccountTypes,
  }) {
    return ModuleVisibility(
      root: root ?? this.root,
      allowedGroupIds: allowedGroupIds ?? this.allowedGroupIds,
      allowedAccountTypes: allowedAccountTypes ?? this.allowedAccountTypes,
    );
  }

  ModuleVisibility copyWithWrapped({
    Wrapped<String>? root,
    Wrapped<List<String>>? allowedGroupIds,
    Wrapped<List<enums.AccountType>>? allowedAccountTypes,
  }) {
    return ModuleVisibility(
      root: (root != null ? root.value : this.root),
      allowedGroupIds:
          (allowedGroupIds != null
              ? allowedGroupIds.value
              : this.allowedGroupIds),
      allowedAccountTypes:
          (allowedAccountTypes != null
              ? allowedAccountTypes.value
              : this.allowedAccountTypes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ModuleVisibilityCreate {
  const ModuleVisibilityCreate({
    required this.root,
    this.allowedGroupId,
    this.allowedAccountType,
  });

  factory ModuleVisibilityCreate.fromJson(Map<String, dynamic> json) =>
      _$ModuleVisibilityCreateFromJson(json);

  static const toJsonFactory = _$ModuleVisibilityCreateToJson;
  Map<String, dynamic> toJson() => _$ModuleVisibilityCreateToJson(this);

  @JsonKey(name: 'root', defaultValue: '')
  final String root;
  @JsonKey(name: 'allowed_group_id')
  final String? allowedGroupId;
  @JsonKey(
    name: 'allowed_account_type',
    toJson: accountTypeNullableToJson,
    fromJson: accountTypeNullableFromJson,
  )
  final enums.AccountType? allowedAccountType;
  static const fromJsonFactory = _$ModuleVisibilityCreateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ModuleVisibilityCreate &&
            (identical(other.root, root) ||
                const DeepCollectionEquality().equals(other.root, root)) &&
            (identical(other.allowedGroupId, allowedGroupId) ||
                const DeepCollectionEquality().equals(
                  other.allowedGroupId,
                  allowedGroupId,
                )) &&
            (identical(other.allowedAccountType, allowedAccountType) ||
                const DeepCollectionEquality().equals(
                  other.allowedAccountType,
                  allowedAccountType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(root) ^
      const DeepCollectionEquality().hash(allowedGroupId) ^
      const DeepCollectionEquality().hash(allowedAccountType) ^
      runtimeType.hashCode;
}

extension $ModuleVisibilityCreateExtension on ModuleVisibilityCreate {
  ModuleVisibilityCreate copyWith({
    String? root,
    String? allowedGroupId,
    enums.AccountType? allowedAccountType,
  }) {
    return ModuleVisibilityCreate(
      root: root ?? this.root,
      allowedGroupId: allowedGroupId ?? this.allowedGroupId,
      allowedAccountType: allowedAccountType ?? this.allowedAccountType,
    );
  }

  ModuleVisibilityCreate copyWithWrapped({
    Wrapped<String>? root,
    Wrapped<String?>? allowedGroupId,
    Wrapped<enums.AccountType?>? allowedAccountType,
  }) {
    return ModuleVisibilityCreate(
      root: (root != null ? root.value : this.root),
      allowedGroupId:
          (allowedGroupId != null ? allowedGroupId.value : this.allowedGroupId),
      allowedAccountType:
          (allowedAccountType != null
              ? allowedAccountType.value
              : this.allowedAccountType),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OrderBase &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.deliveryId, deliveryId) ||
                const DeepCollectionEquality().equals(
                  other.deliveryId,
                  deliveryId,
                )) &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality().equals(
                  other.productsIds,
                  productsIds,
                )) &&
            (identical(other.collectionSlot, collectionSlot) ||
                const DeepCollectionEquality().equals(
                  other.collectionSlot,
                  collectionSlot,
                )) &&
            (identical(other.productsQuantity, productsQuantity) ||
                const DeepCollectionEquality().equals(
                  other.productsQuantity,
                  productsQuantity,
                )));
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
  OrderBase copyWith({
    String? userId,
    String? deliveryId,
    List<String>? productsIds,
    enums.AmapSlotType? collectionSlot,
    List<int>? productsQuantity,
  }) {
    return OrderBase(
      userId: userId ?? this.userId,
      deliveryId: deliveryId ?? this.deliveryId,
      productsIds: productsIds ?? this.productsIds,
      collectionSlot: collectionSlot ?? this.collectionSlot,
      productsQuantity: productsQuantity ?? this.productsQuantity,
    );
  }

  OrderBase copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? deliveryId,
    Wrapped<List<String>>? productsIds,
    Wrapped<enums.AmapSlotType>? collectionSlot,
    Wrapped<List<int>>? productsQuantity,
  }) {
    return OrderBase(
      userId: (userId != null ? userId.value : this.userId),
      deliveryId: (deliveryId != null ? deliveryId.value : this.deliveryId),
      productsIds: (productsIds != null ? productsIds.value : this.productsIds),
      collectionSlot:
          (collectionSlot != null ? collectionSlot.value : this.collectionSlot),
      productsQuantity:
          (productsQuantity != null
              ? productsQuantity.value
              : this.productsQuantity),
    );
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

  @JsonKey(name: 'products_ids')
  final List<String>? productsIds;
  @JsonKey(
    name: 'collection_slot',
    toJson: amapSlotTypeNullableToJson,
    fromJson: amapSlotTypeNullableFromJson,
  )
  final enums.AmapSlotType? collectionSlot;
  @JsonKey(name: 'products_quantity')
  final List<int>? productsQuantity;
  static const fromJsonFactory = _$OrderEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OrderEdit &&
            (identical(other.productsIds, productsIds) ||
                const DeepCollectionEquality().equals(
                  other.productsIds,
                  productsIds,
                )) &&
            (identical(other.collectionSlot, collectionSlot) ||
                const DeepCollectionEquality().equals(
                  other.collectionSlot,
                  collectionSlot,
                )) &&
            (identical(other.productsQuantity, productsQuantity) ||
                const DeepCollectionEquality().equals(
                  other.productsQuantity,
                  productsQuantity,
                )));
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
  OrderEdit copyWith({
    List<String>? productsIds,
    enums.AmapSlotType? collectionSlot,
    List<int>? productsQuantity,
  }) {
    return OrderEdit(
      productsIds: productsIds ?? this.productsIds,
      collectionSlot: collectionSlot ?? this.collectionSlot,
      productsQuantity: productsQuantity ?? this.productsQuantity,
    );
  }

  OrderEdit copyWithWrapped({
    Wrapped<List<String>?>? productsIds,
    Wrapped<enums.AmapSlotType?>? collectionSlot,
    Wrapped<List<int>?>? productsQuantity,
  }) {
    return OrderEdit(
      productsIds: (productsIds != null ? productsIds.value : this.productsIds),
      collectionSlot:
          (collectionSlot != null ? collectionSlot.value : this.collectionSlot),
      productsQuantity:
          (productsQuantity != null
              ? productsQuantity.value
              : this.productsQuantity),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OrderReturn &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.deliveryId, deliveryId) ||
                const DeepCollectionEquality().equals(
                  other.deliveryId,
                  deliveryId,
                )) &&
            (identical(other.productsdetail, productsdetail) ||
                const DeepCollectionEquality().equals(
                  other.productsdetail,
                  productsdetail,
                )) &&
            (identical(other.collectionSlot, collectionSlot) ||
                const DeepCollectionEquality().equals(
                  other.collectionSlot,
                  collectionSlot,
                )) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(
                  other.orderId,
                  orderId,
                )) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.orderingDate, orderingDate) ||
                const DeepCollectionEquality().equals(
                  other.orderingDate,
                  orderingDate,
                )) &&
            (identical(other.deliveryDate, deliveryDate) ||
                const DeepCollectionEquality().equals(
                  other.deliveryDate,
                  deliveryDate,
                )));
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
  OrderReturn copyWith({
    CoreUserSimple? user,
    String? deliveryId,
    List<ProductQuantity>? productsdetail,
    enums.AmapSlotType? collectionSlot,
    String? orderId,
    double? amount,
    DateTime? orderingDate,
    DateTime? deliveryDate,
  }) {
    return OrderReturn(
      user: user ?? this.user,
      deliveryId: deliveryId ?? this.deliveryId,
      productsdetail: productsdetail ?? this.productsdetail,
      collectionSlot: collectionSlot ?? this.collectionSlot,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      orderingDate: orderingDate ?? this.orderingDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
    );
  }

  OrderReturn copyWithWrapped({
    Wrapped<CoreUserSimple>? user,
    Wrapped<String>? deliveryId,
    Wrapped<List<ProductQuantity>>? productsdetail,
    Wrapped<enums.AmapSlotType>? collectionSlot,
    Wrapped<String>? orderId,
    Wrapped<double>? amount,
    Wrapped<DateTime>? orderingDate,
    Wrapped<DateTime>? deliveryDate,
  }) {
    return OrderReturn(
      user: (user != null ? user.value : this.user),
      deliveryId: (deliveryId != null ? deliveryId.value : this.deliveryId),
      productsdetail:
          (productsdetail != null ? productsdetail.value : this.productsdetail),
      collectionSlot:
          (collectionSlot != null ? collectionSlot.value : this.collectionSlot),
      orderId: (orderId != null ? orderId.value : this.orderId),
      amount: (amount != null ? amount.value : this.amount),
      orderingDate:
          (orderingDate != null ? orderingDate.value : this.orderingDate),
      deliveryDate:
          (deliveryDate != null ? deliveryDate.value : this.deliveryDate),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PackTicketBase &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.packSize, packSize) ||
                const DeepCollectionEquality().equals(
                  other.packSize,
                  packSize,
                )) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality().equals(
                  other.raffleId,
                  raffleId,
                )));
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
      raffleId: raffleId ?? this.raffleId,
    );
  }

  PackTicketBase copyWithWrapped({
    Wrapped<double>? price,
    Wrapped<int>? packSize,
    Wrapped<String>? raffleId,
  }) {
    return PackTicketBase(
      price: (price != null ? price.value : this.price),
      packSize: (packSize != null ? packSize.value : this.packSize),
      raffleId: (raffleId != null ? raffleId.value : this.raffleId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PackTicketEdit {
  const PackTicketEdit({this.raffleId, this.price, this.packSize});

  factory PackTicketEdit.fromJson(Map<String, dynamic> json) =>
      _$PackTicketEditFromJson(json);

  static const toJsonFactory = _$PackTicketEditToJson;
  Map<String, dynamic> toJson() => _$PackTicketEditToJson(this);

  @JsonKey(name: 'raffle_id')
  final String? raffleId;
  @JsonKey(name: 'price')
  final num? price;
  @JsonKey(name: 'pack_size')
  final int? packSize;
  static const fromJsonFactory = _$PackTicketEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PackTicketEdit &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality().equals(
                  other.raffleId,
                  raffleId,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.packSize, packSize) ||
                const DeepCollectionEquality().equals(
                  other.packSize,
                  packSize,
                )));
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
  PackTicketEdit copyWith({String? raffleId, num? price, int? packSize}) {
    return PackTicketEdit(
      raffleId: raffleId ?? this.raffleId,
      price: price ?? this.price,
      packSize: packSize ?? this.packSize,
    );
  }

  PackTicketEdit copyWithWrapped({
    Wrapped<String?>? raffleId,
    Wrapped<num?>? price,
    Wrapped<int?>? packSize,
  }) {
    return PackTicketEdit(
      raffleId: (raffleId != null ? raffleId.value : this.raffleId),
      price: (price != null ? price.value : this.price),
      packSize: (packSize != null ? packSize.value : this.packSize),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PackTicketSimple &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.packSize, packSize) ||
                const DeepCollectionEquality().equals(
                  other.packSize,
                  packSize,
                )) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality().equals(
                  other.raffleId,
                  raffleId,
                )) &&
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
  PackTicketSimple copyWith({
    double? price,
    int? packSize,
    String? raffleId,
    String? id,
  }) {
    return PackTicketSimple(
      price: price ?? this.price,
      packSize: packSize ?? this.packSize,
      raffleId: raffleId ?? this.raffleId,
      id: id ?? this.id,
    );
  }

  PackTicketSimple copyWithWrapped({
    Wrapped<double>? price,
    Wrapped<int>? packSize,
    Wrapped<String>? raffleId,
    Wrapped<String>? id,
  }) {
    return PackTicketSimple(
      price: (price != null ? price.value : this.price),
      packSize: (packSize != null ? packSize.value : this.packSize),
      raffleId: (raffleId != null ? raffleId.value : this.raffleId),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaperBase {
  const PaperBase({required this.name, required this.releaseDate});

  factory PaperBase.fromJson(Map<String, dynamic> json) =>
      _$PaperBaseFromJson(json);

  static const toJsonFactory = _$PaperBaseToJson;
  Map<String, dynamic> toJson() => _$PaperBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'release_date', toJson: _dateToJson)
  final DateTime releaseDate;
  static const fromJsonFactory = _$PaperBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaperBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      runtimeType.hashCode;
}

extension $PaperBaseExtension on PaperBase {
  PaperBase copyWith({String? name, DateTime? releaseDate}) {
    return PaperBase(
      name: name ?? this.name,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  PaperBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<DateTime>? releaseDate,
  }) {
    return PaperBase(
      name: (name != null ? name.value : this.name),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaperComplete {
  const PaperComplete({
    required this.name,
    required this.releaseDate,
    required this.id,
  });

  factory PaperComplete.fromJson(Map<String, dynamic> json) =>
      _$PaperCompleteFromJson(json);

  static const toJsonFactory = _$PaperCompleteToJson;
  Map<String, dynamic> toJson() => _$PaperCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'release_date', toJson: _dateToJson)
  final DateTime releaseDate;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$PaperCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaperComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $PaperCompleteExtension on PaperComplete {
  PaperComplete copyWith({String? name, DateTime? releaseDate, String? id}) {
    return PaperComplete(
      name: name ?? this.name,
      releaseDate: releaseDate ?? this.releaseDate,
      id: id ?? this.id,
    );
  }

  PaperComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<DateTime>? releaseDate,
    Wrapped<String>? id,
  }) {
    return PaperComplete(
      name: (name != null ? name.value : this.name),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaperUpdate {
  const PaperUpdate({this.name, this.releaseDate});

  factory PaperUpdate.fromJson(Map<String, dynamic> json) =>
      _$PaperUpdateFromJson(json);

  static const toJsonFactory = _$PaperUpdateToJson;
  Map<String, dynamic> toJson() => _$PaperUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  static const fromJsonFactory = _$PaperUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaperUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      runtimeType.hashCode;
}

extension $PaperUpdateExtension on PaperUpdate {
  PaperUpdate copyWith({String? name, String? releaseDate}) {
    return PaperUpdate(
      name: name ?? this.name,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  PaperUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? releaseDate,
  }) {
    return PaperUpdate(
      name: (name != null ? name.value : this.name),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Participant {
  const Participant({
    required this.name,
    required this.firstname,
    required this.birthday,
    required this.phone,
    required this.email,
    required this.id,
    required this.bikeSize,
    required this.tShirtSize,
    required this.situation,
    required this.validationProgress,
    required this.payment,
    required this.tShirtPayment,
    required this.numberOfDocument,
    required this.numberOfValidatedDocument,
    required this.address,
    this.otherSchool,
    this.company,
    this.diet,
    required this.idCard,
    required this.medicalCertificate,
    required this.securityFile,
    this.studentCard,
    this.raidRules,
    this.parentAuthorization,
    required this.attestationOnHonour,
    required this.isMinor,
  });

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  static const toJsonFactory = _$ParticipantToJson;
  Map<String, dynamic> toJson() => _$ParticipantToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'birthday', toJson: _dateToJson)
  final DateTime birthday;
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'bike_size', toJson: sizeToJson, fromJson: sizeFromJson)
  final enums.Size bikeSize;
  @JsonKey(name: 't_shirt_size', toJson: sizeToJson, fromJson: sizeFromJson)
  final enums.Size tShirtSize;
  @JsonKey(name: 'situation')
  final String situation;
  @JsonKey(name: 'validation_progress', defaultValue: 0.0)
  final double validationProgress;
  @JsonKey(name: 'payment', defaultValue: false)
  final bool payment;
  @JsonKey(name: 't_shirt_payment', defaultValue: false)
  final bool tShirtPayment;
  @JsonKey(name: 'number_of_document', defaultValue: 0)
  final int numberOfDocument;
  @JsonKey(name: 'number_of_validated_document', defaultValue: 0)
  final int numberOfValidatedDocument;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'other_school')
  final String? otherSchool;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'diet')
  final String? diet;
  @JsonKey(name: 'id_card')
  final Document idCard;
  @JsonKey(name: 'medical_certificate')
  final Document medicalCertificate;
  @JsonKey(name: 'security_file')
  final SecurityFile securityFile;
  @JsonKey(name: 'student_card')
  final Document? studentCard;
  @JsonKey(name: 'raid_rules')
  final Document? raidRules;
  @JsonKey(name: 'parent_authorization')
  final Document? parentAuthorization;
  @JsonKey(name: 'attestation_on_honour', defaultValue: false)
  final bool attestationOnHonour;
  @JsonKey(name: 'is_minor', defaultValue: false)
  final bool isMinor;
  static const fromJsonFactory = _$ParticipantFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Participant &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.bikeSize, bikeSize) ||
                const DeepCollectionEquality().equals(
                  other.bikeSize,
                  bikeSize,
                )) &&
            (identical(other.tShirtSize, tShirtSize) ||
                const DeepCollectionEquality().equals(
                  other.tShirtSize,
                  tShirtSize,
                )) &&
            (identical(other.situation, situation) ||
                const DeepCollectionEquality().equals(
                  other.situation,
                  situation,
                )) &&
            (identical(other.validationProgress, validationProgress) ||
                const DeepCollectionEquality().equals(
                  other.validationProgress,
                  validationProgress,
                )) &&
            (identical(other.payment, payment) ||
                const DeepCollectionEquality().equals(
                  other.payment,
                  payment,
                )) &&
            (identical(other.tShirtPayment, tShirtPayment) ||
                const DeepCollectionEquality().equals(
                  other.tShirtPayment,
                  tShirtPayment,
                )) &&
            (identical(other.numberOfDocument, numberOfDocument) ||
                const DeepCollectionEquality().equals(
                  other.numberOfDocument,
                  numberOfDocument,
                )) &&
            (identical(
                  other.numberOfValidatedDocument,
                  numberOfValidatedDocument,
                ) ||
                const DeepCollectionEquality().equals(
                  other.numberOfValidatedDocument,
                  numberOfValidatedDocument,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.otherSchool, otherSchool) ||
                const DeepCollectionEquality().equals(
                  other.otherSchool,
                  otherSchool,
                )) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.diet, diet) ||
                const DeepCollectionEquality().equals(other.diet, diet)) &&
            (identical(other.idCard, idCard) ||
                const DeepCollectionEquality().equals(other.idCard, idCard)) &&
            (identical(other.medicalCertificate, medicalCertificate) ||
                const DeepCollectionEquality().equals(
                  other.medicalCertificate,
                  medicalCertificate,
                )) &&
            (identical(other.securityFile, securityFile) ||
                const DeepCollectionEquality().equals(
                  other.securityFile,
                  securityFile,
                )) &&
            (identical(other.studentCard, studentCard) ||
                const DeepCollectionEquality().equals(
                  other.studentCard,
                  studentCard,
                )) &&
            (identical(other.raidRules, raidRules) ||
                const DeepCollectionEquality().equals(
                  other.raidRules,
                  raidRules,
                )) &&
            (identical(other.parentAuthorization, parentAuthorization) ||
                const DeepCollectionEquality().equals(
                  other.parentAuthorization,
                  parentAuthorization,
                )) &&
            (identical(other.attestationOnHonour, attestationOnHonour) ||
                const DeepCollectionEquality().equals(
                  other.attestationOnHonour,
                  attestationOnHonour,
                )) &&
            (identical(other.isMinor, isMinor) ||
                const DeepCollectionEquality().equals(other.isMinor, isMinor)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(bikeSize) ^
      const DeepCollectionEquality().hash(tShirtSize) ^
      const DeepCollectionEquality().hash(situation) ^
      const DeepCollectionEquality().hash(validationProgress) ^
      const DeepCollectionEquality().hash(payment) ^
      const DeepCollectionEquality().hash(tShirtPayment) ^
      const DeepCollectionEquality().hash(numberOfDocument) ^
      const DeepCollectionEquality().hash(numberOfValidatedDocument) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(otherSchool) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash(diet) ^
      const DeepCollectionEquality().hash(idCard) ^
      const DeepCollectionEquality().hash(medicalCertificate) ^
      const DeepCollectionEquality().hash(securityFile) ^
      const DeepCollectionEquality().hash(studentCard) ^
      const DeepCollectionEquality().hash(raidRules) ^
      const DeepCollectionEquality().hash(parentAuthorization) ^
      const DeepCollectionEquality().hash(attestationOnHonour) ^
      const DeepCollectionEquality().hash(isMinor) ^
      runtimeType.hashCode;
}

extension $ParticipantExtension on Participant {
  Participant copyWith({
    String? name,
    String? firstname,
    DateTime? birthday,
    String? phone,
    String? email,
    String? id,
    enums.Size? bikeSize,
    enums.Size? tShirtSize,
    String? situation,
    double? validationProgress,
    bool? payment,
    bool? tShirtPayment,
    int? numberOfDocument,
    int? numberOfValidatedDocument,
    String? address,
    String? otherSchool,
    String? company,
    String? diet,
    Document? idCard,
    Document? medicalCertificate,
    SecurityFile? securityFile,
    Document? studentCard,
    Document? raidRules,
    Document? parentAuthorization,
    bool? attestationOnHonour,
    bool? isMinor,
  }) {
    return Participant(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      id: id ?? this.id,
      bikeSize: bikeSize ?? this.bikeSize,
      tShirtSize: tShirtSize ?? this.tShirtSize,
      situation: situation ?? this.situation,
      validationProgress: validationProgress ?? this.validationProgress,
      payment: payment ?? this.payment,
      tShirtPayment: tShirtPayment ?? this.tShirtPayment,
      numberOfDocument: numberOfDocument ?? this.numberOfDocument,
      numberOfValidatedDocument:
          numberOfValidatedDocument ?? this.numberOfValidatedDocument,
      address: address ?? this.address,
      otherSchool: otherSchool ?? this.otherSchool,
      company: company ?? this.company,
      diet: diet ?? this.diet,
      idCard: idCard ?? this.idCard,
      medicalCertificate: medicalCertificate ?? this.medicalCertificate,
      securityFile: securityFile ?? this.securityFile,
      studentCard: studentCard ?? this.studentCard,
      raidRules: raidRules ?? this.raidRules,
      parentAuthorization: parentAuthorization ?? this.parentAuthorization,
      attestationOnHonour: attestationOnHonour ?? this.attestationOnHonour,
      isMinor: isMinor ?? this.isMinor,
    );
  }

  Participant copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<DateTime>? birthday,
    Wrapped<String>? phone,
    Wrapped<String>? email,
    Wrapped<String>? id,
    Wrapped<enums.Size>? bikeSize,
    Wrapped<enums.Size>? tShirtSize,
    Wrapped<String>? situation,
    Wrapped<double>? validationProgress,
    Wrapped<bool>? payment,
    Wrapped<bool>? tShirtPayment,
    Wrapped<int>? numberOfDocument,
    Wrapped<int>? numberOfValidatedDocument,
    Wrapped<String>? address,
    Wrapped<String?>? otherSchool,
    Wrapped<String?>? company,
    Wrapped<String?>? diet,
    Wrapped<Document>? idCard,
    Wrapped<Document>? medicalCertificate,
    Wrapped<SecurityFile>? securityFile,
    Wrapped<Document?>? studentCard,
    Wrapped<Document?>? raidRules,
    Wrapped<Document?>? parentAuthorization,
    Wrapped<bool>? attestationOnHonour,
    Wrapped<bool>? isMinor,
  }) {
    return Participant(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      email: (email != null ? email.value : this.email),
      id: (id != null ? id.value : this.id),
      bikeSize: (bikeSize != null ? bikeSize.value : this.bikeSize),
      tShirtSize: (tShirtSize != null ? tShirtSize.value : this.tShirtSize),
      situation: (situation != null ? situation.value : this.situation),
      validationProgress:
          (validationProgress != null
              ? validationProgress.value
              : this.validationProgress),
      payment: (payment != null ? payment.value : this.payment),
      tShirtPayment:
          (tShirtPayment != null ? tShirtPayment.value : this.tShirtPayment),
      numberOfDocument:
          (numberOfDocument != null
              ? numberOfDocument.value
              : this.numberOfDocument),
      numberOfValidatedDocument:
          (numberOfValidatedDocument != null
              ? numberOfValidatedDocument.value
              : this.numberOfValidatedDocument),
      address: (address != null ? address.value : this.address),
      otherSchool: (otherSchool != null ? otherSchool.value : this.otherSchool),
      company: (company != null ? company.value : this.company),
      diet: (diet != null ? diet.value : this.diet),
      idCard: (idCard != null ? idCard.value : this.idCard),
      medicalCertificate:
          (medicalCertificate != null
              ? medicalCertificate.value
              : this.medicalCertificate),
      securityFile:
          (securityFile != null ? securityFile.value : this.securityFile),
      studentCard: (studentCard != null ? studentCard.value : this.studentCard),
      raidRules: (raidRules != null ? raidRules.value : this.raidRules),
      parentAuthorization:
          (parentAuthorization != null
              ? parentAuthorization.value
              : this.parentAuthorization),
      attestationOnHonour:
          (attestationOnHonour != null
              ? attestationOnHonour.value
              : this.attestationOnHonour),
      isMinor: (isMinor != null ? isMinor.value : this.isMinor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ParticipantBase {
  const ParticipantBase({
    required this.name,
    required this.firstname,
    required this.birthday,
    required this.phone,
    required this.email,
  });

  factory ParticipantBase.fromJson(Map<String, dynamic> json) =>
      _$ParticipantBaseFromJson(json);

  static const toJsonFactory = _$ParticipantBaseToJson;
  Map<String, dynamic> toJson() => _$ParticipantBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'birthday', toJson: _dateToJson)
  final DateTime birthday;
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  static const fromJsonFactory = _$ParticipantBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ParticipantBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $ParticipantBaseExtension on ParticipantBase {
  ParticipantBase copyWith({
    String? name,
    String? firstname,
    DateTime? birthday,
    String? phone,
    String? email,
  }) {
    return ParticipantBase(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  ParticipantBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<DateTime>? birthday,
    Wrapped<String>? phone,
    Wrapped<String>? email,
  }) {
    return ParticipantBase(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ParticipantPreview {
  const ParticipantPreview({
    required this.name,
    required this.firstname,
    required this.birthday,
    required this.phone,
    required this.email,
    required this.id,
    required this.bikeSize,
    required this.tShirtSize,
    required this.situation,
    required this.validationProgress,
    required this.payment,
    required this.tShirtPayment,
    required this.numberOfDocument,
    required this.numberOfValidatedDocument,
  });

  factory ParticipantPreview.fromJson(Map<String, dynamic> json) =>
      _$ParticipantPreviewFromJson(json);

  static const toJsonFactory = _$ParticipantPreviewToJson;
  Map<String, dynamic> toJson() => _$ParticipantPreviewToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'birthday', toJson: _dateToJson)
  final DateTime birthday;
  @JsonKey(name: 'phone', defaultValue: '')
  final String phone;
  @JsonKey(name: 'email', defaultValue: '')
  final String email;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'bike_size', toJson: sizeToJson, fromJson: sizeFromJson)
  final enums.Size bikeSize;
  @JsonKey(name: 't_shirt_size', toJson: sizeToJson, fromJson: sizeFromJson)
  final enums.Size tShirtSize;
  @JsonKey(name: 'situation')
  final String situation;
  @JsonKey(name: 'validation_progress', defaultValue: 0.0)
  final double validationProgress;
  @JsonKey(name: 'payment', defaultValue: false)
  final bool payment;
  @JsonKey(name: 't_shirt_payment', defaultValue: false)
  final bool tShirtPayment;
  @JsonKey(name: 'number_of_document', defaultValue: 0)
  final int numberOfDocument;
  @JsonKey(name: 'number_of_validated_document', defaultValue: 0)
  final int numberOfValidatedDocument;
  static const fromJsonFactory = _$ParticipantPreviewFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ParticipantPreview &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.bikeSize, bikeSize) ||
                const DeepCollectionEquality().equals(
                  other.bikeSize,
                  bikeSize,
                )) &&
            (identical(other.tShirtSize, tShirtSize) ||
                const DeepCollectionEquality().equals(
                  other.tShirtSize,
                  tShirtSize,
                )) &&
            (identical(other.situation, situation) ||
                const DeepCollectionEquality().equals(
                  other.situation,
                  situation,
                )) &&
            (identical(other.validationProgress, validationProgress) ||
                const DeepCollectionEquality().equals(
                  other.validationProgress,
                  validationProgress,
                )) &&
            (identical(other.payment, payment) ||
                const DeepCollectionEquality().equals(
                  other.payment,
                  payment,
                )) &&
            (identical(other.tShirtPayment, tShirtPayment) ||
                const DeepCollectionEquality().equals(
                  other.tShirtPayment,
                  tShirtPayment,
                )) &&
            (identical(other.numberOfDocument, numberOfDocument) ||
                const DeepCollectionEquality().equals(
                  other.numberOfDocument,
                  numberOfDocument,
                )) &&
            (identical(
                  other.numberOfValidatedDocument,
                  numberOfValidatedDocument,
                ) ||
                const DeepCollectionEquality().equals(
                  other.numberOfValidatedDocument,
                  numberOfValidatedDocument,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(bikeSize) ^
      const DeepCollectionEquality().hash(tShirtSize) ^
      const DeepCollectionEquality().hash(situation) ^
      const DeepCollectionEquality().hash(validationProgress) ^
      const DeepCollectionEquality().hash(payment) ^
      const DeepCollectionEquality().hash(tShirtPayment) ^
      const DeepCollectionEquality().hash(numberOfDocument) ^
      const DeepCollectionEquality().hash(numberOfValidatedDocument) ^
      runtimeType.hashCode;
}

extension $ParticipantPreviewExtension on ParticipantPreview {
  ParticipantPreview copyWith({
    String? name,
    String? firstname,
    DateTime? birthday,
    String? phone,
    String? email,
    String? id,
    enums.Size? bikeSize,
    enums.Size? tShirtSize,
    String? situation,
    double? validationProgress,
    bool? payment,
    bool? tShirtPayment,
    int? numberOfDocument,
    int? numberOfValidatedDocument,
  }) {
    return ParticipantPreview(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      id: id ?? this.id,
      bikeSize: bikeSize ?? this.bikeSize,
      tShirtSize: tShirtSize ?? this.tShirtSize,
      situation: situation ?? this.situation,
      validationProgress: validationProgress ?? this.validationProgress,
      payment: payment ?? this.payment,
      tShirtPayment: tShirtPayment ?? this.tShirtPayment,
      numberOfDocument: numberOfDocument ?? this.numberOfDocument,
      numberOfValidatedDocument:
          numberOfValidatedDocument ?? this.numberOfValidatedDocument,
    );
  }

  ParticipantPreview copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<DateTime>? birthday,
    Wrapped<String>? phone,
    Wrapped<String>? email,
    Wrapped<String>? id,
    Wrapped<enums.Size>? bikeSize,
    Wrapped<enums.Size>? tShirtSize,
    Wrapped<String>? situation,
    Wrapped<double>? validationProgress,
    Wrapped<bool>? payment,
    Wrapped<bool>? tShirtPayment,
    Wrapped<int>? numberOfDocument,
    Wrapped<int>? numberOfValidatedDocument,
  }) {
    return ParticipantPreview(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      birthday: (birthday != null ? birthday.value : this.birthday),
      phone: (phone != null ? phone.value : this.phone),
      email: (email != null ? email.value : this.email),
      id: (id != null ? id.value : this.id),
      bikeSize: (bikeSize != null ? bikeSize.value : this.bikeSize),
      tShirtSize: (tShirtSize != null ? tShirtSize.value : this.tShirtSize),
      situation: (situation != null ? situation.value : this.situation),
      validationProgress:
          (validationProgress != null
              ? validationProgress.value
              : this.validationProgress),
      payment: (payment != null ? payment.value : this.payment),
      tShirtPayment:
          (tShirtPayment != null ? tShirtPayment.value : this.tShirtPayment),
      numberOfDocument:
          (numberOfDocument != null
              ? numberOfDocument.value
              : this.numberOfDocument),
      numberOfValidatedDocument:
          (numberOfValidatedDocument != null
              ? numberOfValidatedDocument.value
              : this.numberOfValidatedDocument),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ParticipantUpdate {
  const ParticipantUpdate({
    this.name,
    this.firstname,
    this.birthday,
    this.address,
    this.phone,
    this.email,
    this.bikeSize,
    this.tShirtSize,
    this.situation,
    this.otherSchool,
    this.company,
    this.diet,
    this.attestationOnHonour,
    this.idCardId,
    this.medicalCertificateId,
    this.securityFileId,
    this.studentCardId,
    this.raidRulesId,
    this.parentAuthorizationId,
  });

  factory ParticipantUpdate.fromJson(Map<String, dynamic> json) =>
      _$ParticipantUpdateFromJson(json);

  static const toJsonFactory = _$ParticipantUpdateToJson;
  Map<String, dynamic> toJson() => _$ParticipantUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'firstname')
  final String? firstname;
  @JsonKey(name: 'birthday')
  final String? birthday;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(
    name: 'bike_size',
    toJson: sizeNullableToJson,
    fromJson: sizeNullableFromJson,
  )
  final enums.Size? bikeSize;
  @JsonKey(
    name: 't_shirt_size',
    toJson: sizeNullableToJson,
    fromJson: sizeNullableFromJson,
  )
  final enums.Size? tShirtSize;
  @JsonKey(name: 'situation')
  final String? situation;
  @JsonKey(name: 'other_school')
  final String? otherSchool;
  @JsonKey(name: 'company')
  final String? company;
  @JsonKey(name: 'diet')
  final String? diet;
  @JsonKey(name: 'attestation_on_honour')
  final bool? attestationOnHonour;
  @JsonKey(name: 'id_card_id')
  final String? idCardId;
  @JsonKey(name: 'medical_certificate_id')
  final String? medicalCertificateId;
  @JsonKey(name: 'security_file_id')
  final String? securityFileId;
  @JsonKey(name: 'student_card_id')
  final String? studentCardId;
  @JsonKey(name: 'raid_rules_id')
  final String? raidRulesId;
  @JsonKey(name: 'parent_authorization_id')
  final String? parentAuthorizationId;
  static const fromJsonFactory = _$ParticipantUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ParticipantUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality().equals(
                  other.birthday,
                  birthday,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.bikeSize, bikeSize) ||
                const DeepCollectionEquality().equals(
                  other.bikeSize,
                  bikeSize,
                )) &&
            (identical(other.tShirtSize, tShirtSize) ||
                const DeepCollectionEquality().equals(
                  other.tShirtSize,
                  tShirtSize,
                )) &&
            (identical(other.situation, situation) ||
                const DeepCollectionEquality().equals(
                  other.situation,
                  situation,
                )) &&
            (identical(other.otherSchool, otherSchool) ||
                const DeepCollectionEquality().equals(
                  other.otherSchool,
                  otherSchool,
                )) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(
                  other.company,
                  company,
                )) &&
            (identical(other.diet, diet) ||
                const DeepCollectionEquality().equals(other.diet, diet)) &&
            (identical(other.attestationOnHonour, attestationOnHonour) ||
                const DeepCollectionEquality().equals(
                  other.attestationOnHonour,
                  attestationOnHonour,
                )) &&
            (identical(other.idCardId, idCardId) ||
                const DeepCollectionEquality().equals(
                  other.idCardId,
                  idCardId,
                )) &&
            (identical(other.medicalCertificateId, medicalCertificateId) ||
                const DeepCollectionEquality().equals(
                  other.medicalCertificateId,
                  medicalCertificateId,
                )) &&
            (identical(other.securityFileId, securityFileId) ||
                const DeepCollectionEquality().equals(
                  other.securityFileId,
                  securityFileId,
                )) &&
            (identical(other.studentCardId, studentCardId) ||
                const DeepCollectionEquality().equals(
                  other.studentCardId,
                  studentCardId,
                )) &&
            (identical(other.raidRulesId, raidRulesId) ||
                const DeepCollectionEquality().equals(
                  other.raidRulesId,
                  raidRulesId,
                )) &&
            (identical(other.parentAuthorizationId, parentAuthorizationId) ||
                const DeepCollectionEquality().equals(
                  other.parentAuthorizationId,
                  parentAuthorizationId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(bikeSize) ^
      const DeepCollectionEquality().hash(tShirtSize) ^
      const DeepCollectionEquality().hash(situation) ^
      const DeepCollectionEquality().hash(otherSchool) ^
      const DeepCollectionEquality().hash(company) ^
      const DeepCollectionEquality().hash(diet) ^
      const DeepCollectionEquality().hash(attestationOnHonour) ^
      const DeepCollectionEquality().hash(idCardId) ^
      const DeepCollectionEquality().hash(medicalCertificateId) ^
      const DeepCollectionEquality().hash(securityFileId) ^
      const DeepCollectionEquality().hash(studentCardId) ^
      const DeepCollectionEquality().hash(raidRulesId) ^
      const DeepCollectionEquality().hash(parentAuthorizationId) ^
      runtimeType.hashCode;
}

extension $ParticipantUpdateExtension on ParticipantUpdate {
  ParticipantUpdate copyWith({
    String? name,
    String? firstname,
    String? birthday,
    String? address,
    String? phone,
    String? email,
    enums.Size? bikeSize,
    enums.Size? tShirtSize,
    String? situation,
    String? otherSchool,
    String? company,
    String? diet,
    bool? attestationOnHonour,
    String? idCardId,
    String? medicalCertificateId,
    String? securityFileId,
    String? studentCardId,
    String? raidRulesId,
    String? parentAuthorizationId,
  }) {
    return ParticipantUpdate(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bikeSize: bikeSize ?? this.bikeSize,
      tShirtSize: tShirtSize ?? this.tShirtSize,
      situation: situation ?? this.situation,
      otherSchool: otherSchool ?? this.otherSchool,
      company: company ?? this.company,
      diet: diet ?? this.diet,
      attestationOnHonour: attestationOnHonour ?? this.attestationOnHonour,
      idCardId: idCardId ?? this.idCardId,
      medicalCertificateId: medicalCertificateId ?? this.medicalCertificateId,
      securityFileId: securityFileId ?? this.securityFileId,
      studentCardId: studentCardId ?? this.studentCardId,
      raidRulesId: raidRulesId ?? this.raidRulesId,
      parentAuthorizationId:
          parentAuthorizationId ?? this.parentAuthorizationId,
    );
  }

  ParticipantUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? firstname,
    Wrapped<String?>? birthday,
    Wrapped<String?>? address,
    Wrapped<String?>? phone,
    Wrapped<String?>? email,
    Wrapped<enums.Size?>? bikeSize,
    Wrapped<enums.Size?>? tShirtSize,
    Wrapped<String?>? situation,
    Wrapped<String?>? otherSchool,
    Wrapped<String?>? company,
    Wrapped<String?>? diet,
    Wrapped<bool?>? attestationOnHonour,
    Wrapped<String?>? idCardId,
    Wrapped<String?>? medicalCertificateId,
    Wrapped<String?>? securityFileId,
    Wrapped<String?>? studentCardId,
    Wrapped<String?>? raidRulesId,
    Wrapped<String?>? parentAuthorizationId,
  }) {
    return ParticipantUpdate(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      birthday: (birthday != null ? birthday.value : this.birthday),
      address: (address != null ? address.value : this.address),
      phone: (phone != null ? phone.value : this.phone),
      email: (email != null ? email.value : this.email),
      bikeSize: (bikeSize != null ? bikeSize.value : this.bikeSize),
      tShirtSize: (tShirtSize != null ? tShirtSize.value : this.tShirtSize),
      situation: (situation != null ? situation.value : this.situation),
      otherSchool: (otherSchool != null ? otherSchool.value : this.otherSchool),
      company: (company != null ? company.value : this.company),
      diet: (diet != null ? diet.value : this.diet),
      attestationOnHonour:
          (attestationOnHonour != null
              ? attestationOnHonour.value
              : this.attestationOnHonour),
      idCardId: (idCardId != null ? idCardId.value : this.idCardId),
      medicalCertificateId:
          (medicalCertificateId != null
              ? medicalCertificateId.value
              : this.medicalCertificateId),
      securityFileId:
          (securityFileId != null ? securityFileId.value : this.securityFileId),
      studentCardId:
          (studentCardId != null ? studentCardId.value : this.studentCardId),
      raidRulesId: (raidRulesId != null ? raidRulesId.value : this.raidRulesId),
      parentAuthorizationId:
          (parentAuthorizationId != null
              ? parentAuthorizationId.value
              : this.parentAuthorizationId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentBase {
  const PaymentBase({required this.total, required this.paymentType});

  factory PaymentBase.fromJson(Map<String, dynamic> json) =>
      _$PaymentBaseFromJson(json);

  static const toJsonFactory = _$PaymentBaseToJson;
  Map<String, dynamic> toJson() => _$PaymentBaseToJson(this);

  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  @JsonKey(
    name: 'payment_type',
    toJson: paymentTypeToJson,
    fromJson: paymentTypeFromJson,
  )
  final enums.PaymentType paymentType;
  static const fromJsonFactory = _$PaymentBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentBase &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.paymentType, paymentType) ||
                const DeepCollectionEquality().equals(
                  other.paymentType,
                  paymentType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(paymentType) ^
      runtimeType.hashCode;
}

extension $PaymentBaseExtension on PaymentBase {
  PaymentBase copyWith({int? total, enums.PaymentType? paymentType}) {
    return PaymentBase(
      total: total ?? this.total,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  PaymentBase copyWithWrapped({
    Wrapped<int>? total,
    Wrapped<enums.PaymentType>? paymentType,
  }) {
    return PaymentBase(
      total: (total != null ? total.value : this.total),
      paymentType: (paymentType != null ? paymentType.value : this.paymentType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentComplete {
  const PaymentComplete({
    required this.total,
    required this.paymentType,
    required this.id,
    required this.userId,
  });

  factory PaymentComplete.fromJson(Map<String, dynamic> json) =>
      _$PaymentCompleteFromJson(json);

  static const toJsonFactory = _$PaymentCompleteToJson;
  Map<String, dynamic> toJson() => _$PaymentCompleteToJson(this);

  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  @JsonKey(
    name: 'payment_type',
    toJson: paymentTypeToJson,
    fromJson: paymentTypeFromJson,
  )
  final enums.PaymentType paymentType;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  static const fromJsonFactory = _$PaymentCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentComplete &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.paymentType, paymentType) ||
                const DeepCollectionEquality().equals(
                  other.paymentType,
                  paymentType,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(paymentType) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $PaymentCompleteExtension on PaymentComplete {
  PaymentComplete copyWith({
    int? total,
    enums.PaymentType? paymentType,
    String? id,
    String? userId,
  }) {
    return PaymentComplete(
      total: total ?? this.total,
      paymentType: paymentType ?? this.paymentType,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  PaymentComplete copyWithWrapped({
    Wrapped<int>? total,
    Wrapped<enums.PaymentType>? paymentType,
    Wrapped<String>? id,
    Wrapped<String>? userId,
  }) {
    return PaymentComplete(
      total: (total != null ? total.value : this.total),
      paymentType: (paymentType != null ? paymentType.value : this.paymentType),
      id: (id != null ? id.value : this.id),
      userId: (userId != null ? userId.value : this.userId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentUrl {
  const PaymentUrl({required this.url});

  factory PaymentUrl.fromJson(Map<String, dynamic> json) =>
      _$PaymentUrlFromJson(json);

  static const toJsonFactory = _$PaymentUrlToJson;
  Map<String, dynamic> toJson() => _$PaymentUrlToJson(this);

  @JsonKey(name: 'url', defaultValue: '')
  final String url;
  static const fromJsonFactory = _$PaymentUrlFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentUrl &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(url) ^ runtimeType.hashCode;
}

extension $PaymentUrlExtension on PaymentUrl {
  PaymentUrl copyWith({String? url}) {
    return PaymentUrl(url: url ?? this.url);
  }

  PaymentUrl copyWithWrapped({Wrapped<String>? url}) {
    return PaymentUrl(url: (url != null ? url.value : this.url));
  }
}

@JsonSerializable(explicitToJson: true)
class PlantComplete {
  const PlantComplete({
    required this.id,
    required this.reference,
    required this.state,
    required this.speciesId,
    required this.propagationMethod,
    this.nbSeedsEnvelope,
    this.plantingDate,
    this.borrowerId,
    this.nickname,
    this.previousNote,
    this.currentNote,
    this.borrowingDate,
    this.ancestorId,
    this.confidential,
  });

  factory PlantComplete.fromJson(Map<String, dynamic> json) =>
      _$PlantCompleteFromJson(json);

  static const toJsonFactory = _$PlantCompleteToJson;
  Map<String, dynamic> toJson() => _$PlantCompleteToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'reference', defaultValue: '')
  final String reference;
  @JsonKey(
    name: 'state',
    toJson: plantStateToJson,
    fromJson: plantStateFromJson,
  )
  final enums.PlantState state;
  @JsonKey(name: 'species_id', defaultValue: '')
  final String speciesId;
  @JsonKey(
    name: 'propagation_method',
    toJson: propagationMethodToJson,
    fromJson: propagationMethodFromJson,
  )
  final enums.PropagationMethod propagationMethod;
  @JsonKey(name: 'nb_seeds_envelope', defaultValue: 0)
  final int? nbSeedsEnvelope;
  @JsonKey(name: 'planting_date')
  final String? plantingDate;
  @JsonKey(name: 'borrower_id')
  final String? borrowerId;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'previous_note')
  final String? previousNote;
  @JsonKey(name: 'current_note')
  final String? currentNote;
  @JsonKey(name: 'borrowing_date')
  final String? borrowingDate;
  @JsonKey(name: 'ancestor_id')
  final String? ancestorId;
  @JsonKey(name: 'confidential', defaultValue: false)
  final bool? confidential;
  static const fromJsonFactory = _$PlantCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlantComplete &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.speciesId, speciesId) ||
                const DeepCollectionEquality().equals(
                  other.speciesId,
                  speciesId,
                )) &&
            (identical(other.propagationMethod, propagationMethod) ||
                const DeepCollectionEquality().equals(
                  other.propagationMethod,
                  propagationMethod,
                )) &&
            (identical(other.nbSeedsEnvelope, nbSeedsEnvelope) ||
                const DeepCollectionEquality().equals(
                  other.nbSeedsEnvelope,
                  nbSeedsEnvelope,
                )) &&
            (identical(other.plantingDate, plantingDate) ||
                const DeepCollectionEquality().equals(
                  other.plantingDate,
                  plantingDate,
                )) &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality().equals(
                  other.borrowerId,
                  borrowerId,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.previousNote, previousNote) ||
                const DeepCollectionEquality().equals(
                  other.previousNote,
                  previousNote,
                )) &&
            (identical(other.currentNote, currentNote) ||
                const DeepCollectionEquality().equals(
                  other.currentNote,
                  currentNote,
                )) &&
            (identical(other.borrowingDate, borrowingDate) ||
                const DeepCollectionEquality().equals(
                  other.borrowingDate,
                  borrowingDate,
                )) &&
            (identical(other.ancestorId, ancestorId) ||
                const DeepCollectionEquality().equals(
                  other.ancestorId,
                  ancestorId,
                )) &&
            (identical(other.confidential, confidential) ||
                const DeepCollectionEquality().equals(
                  other.confidential,
                  confidential,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(reference) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(speciesId) ^
      const DeepCollectionEquality().hash(propagationMethod) ^
      const DeepCollectionEquality().hash(nbSeedsEnvelope) ^
      const DeepCollectionEquality().hash(plantingDate) ^
      const DeepCollectionEquality().hash(borrowerId) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(previousNote) ^
      const DeepCollectionEquality().hash(currentNote) ^
      const DeepCollectionEquality().hash(borrowingDate) ^
      const DeepCollectionEquality().hash(ancestorId) ^
      const DeepCollectionEquality().hash(confidential) ^
      runtimeType.hashCode;
}

extension $PlantCompleteExtension on PlantComplete {
  PlantComplete copyWith({
    String? id,
    String? reference,
    enums.PlantState? state,
    String? speciesId,
    enums.PropagationMethod? propagationMethod,
    int? nbSeedsEnvelope,
    String? plantingDate,
    String? borrowerId,
    String? nickname,
    String? previousNote,
    String? currentNote,
    String? borrowingDate,
    String? ancestorId,
    bool? confidential,
  }) {
    return PlantComplete(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      state: state ?? this.state,
      speciesId: speciesId ?? this.speciesId,
      propagationMethod: propagationMethod ?? this.propagationMethod,
      nbSeedsEnvelope: nbSeedsEnvelope ?? this.nbSeedsEnvelope,
      plantingDate: plantingDate ?? this.plantingDate,
      borrowerId: borrowerId ?? this.borrowerId,
      nickname: nickname ?? this.nickname,
      previousNote: previousNote ?? this.previousNote,
      currentNote: currentNote ?? this.currentNote,
      borrowingDate: borrowingDate ?? this.borrowingDate,
      ancestorId: ancestorId ?? this.ancestorId,
      confidential: confidential ?? this.confidential,
    );
  }

  PlantComplete copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? reference,
    Wrapped<enums.PlantState>? state,
    Wrapped<String>? speciesId,
    Wrapped<enums.PropagationMethod>? propagationMethod,
    Wrapped<int?>? nbSeedsEnvelope,
    Wrapped<String?>? plantingDate,
    Wrapped<String?>? borrowerId,
    Wrapped<String?>? nickname,
    Wrapped<String?>? previousNote,
    Wrapped<String?>? currentNote,
    Wrapped<String?>? borrowingDate,
    Wrapped<String?>? ancestorId,
    Wrapped<bool?>? confidential,
  }) {
    return PlantComplete(
      id: (id != null ? id.value : this.id),
      reference: (reference != null ? reference.value : this.reference),
      state: (state != null ? state.value : this.state),
      speciesId: (speciesId != null ? speciesId.value : this.speciesId),
      propagationMethod:
          (propagationMethod != null
              ? propagationMethod.value
              : this.propagationMethod),
      nbSeedsEnvelope:
          (nbSeedsEnvelope != null
              ? nbSeedsEnvelope.value
              : this.nbSeedsEnvelope),
      plantingDate:
          (plantingDate != null ? plantingDate.value : this.plantingDate),
      borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
      nickname: (nickname != null ? nickname.value : this.nickname),
      previousNote:
          (previousNote != null ? previousNote.value : this.previousNote),
      currentNote: (currentNote != null ? currentNote.value : this.currentNote),
      borrowingDate:
          (borrowingDate != null ? borrowingDate.value : this.borrowingDate),
      ancestorId: (ancestorId != null ? ancestorId.value : this.ancestorId),
      confidential:
          (confidential != null ? confidential.value : this.confidential),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PlantCreation {
  const PlantCreation({
    required this.speciesId,
    required this.propagationMethod,
    this.nbSeedsEnvelope,
    this.ancestorId,
    this.previousNote,
    this.confidential,
  });

  factory PlantCreation.fromJson(Map<String, dynamic> json) =>
      _$PlantCreationFromJson(json);

  static const toJsonFactory = _$PlantCreationToJson;
  Map<String, dynamic> toJson() => _$PlantCreationToJson(this);

  @JsonKey(name: 'species_id', defaultValue: '')
  final String speciesId;
  @JsonKey(
    name: 'propagation_method',
    toJson: propagationMethodToJson,
    fromJson: propagationMethodFromJson,
  )
  final enums.PropagationMethod propagationMethod;
  @JsonKey(name: 'nb_seeds_envelope', defaultValue: 0)
  final int? nbSeedsEnvelope;
  @JsonKey(name: 'ancestor_id')
  final String? ancestorId;
  @JsonKey(name: 'previous_note')
  final String? previousNote;
  @JsonKey(name: 'confidential', defaultValue: false)
  final bool? confidential;
  static const fromJsonFactory = _$PlantCreationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlantCreation &&
            (identical(other.speciesId, speciesId) ||
                const DeepCollectionEquality().equals(
                  other.speciesId,
                  speciesId,
                )) &&
            (identical(other.propagationMethod, propagationMethod) ||
                const DeepCollectionEquality().equals(
                  other.propagationMethod,
                  propagationMethod,
                )) &&
            (identical(other.nbSeedsEnvelope, nbSeedsEnvelope) ||
                const DeepCollectionEquality().equals(
                  other.nbSeedsEnvelope,
                  nbSeedsEnvelope,
                )) &&
            (identical(other.ancestorId, ancestorId) ||
                const DeepCollectionEquality().equals(
                  other.ancestorId,
                  ancestorId,
                )) &&
            (identical(other.previousNote, previousNote) ||
                const DeepCollectionEquality().equals(
                  other.previousNote,
                  previousNote,
                )) &&
            (identical(other.confidential, confidential) ||
                const DeepCollectionEquality().equals(
                  other.confidential,
                  confidential,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(speciesId) ^
      const DeepCollectionEquality().hash(propagationMethod) ^
      const DeepCollectionEquality().hash(nbSeedsEnvelope) ^
      const DeepCollectionEquality().hash(ancestorId) ^
      const DeepCollectionEquality().hash(previousNote) ^
      const DeepCollectionEquality().hash(confidential) ^
      runtimeType.hashCode;
}

extension $PlantCreationExtension on PlantCreation {
  PlantCreation copyWith({
    String? speciesId,
    enums.PropagationMethod? propagationMethod,
    int? nbSeedsEnvelope,
    String? ancestorId,
    String? previousNote,
    bool? confidential,
  }) {
    return PlantCreation(
      speciesId: speciesId ?? this.speciesId,
      propagationMethod: propagationMethod ?? this.propagationMethod,
      nbSeedsEnvelope: nbSeedsEnvelope ?? this.nbSeedsEnvelope,
      ancestorId: ancestorId ?? this.ancestorId,
      previousNote: previousNote ?? this.previousNote,
      confidential: confidential ?? this.confidential,
    );
  }

  PlantCreation copyWithWrapped({
    Wrapped<String>? speciesId,
    Wrapped<enums.PropagationMethod>? propagationMethod,
    Wrapped<int?>? nbSeedsEnvelope,
    Wrapped<String?>? ancestorId,
    Wrapped<String?>? previousNote,
    Wrapped<bool?>? confidential,
  }) {
    return PlantCreation(
      speciesId: (speciesId != null ? speciesId.value : this.speciesId),
      propagationMethod:
          (propagationMethod != null
              ? propagationMethod.value
              : this.propagationMethod),
      nbSeedsEnvelope:
          (nbSeedsEnvelope != null
              ? nbSeedsEnvelope.value
              : this.nbSeedsEnvelope),
      ancestorId: (ancestorId != null ? ancestorId.value : this.ancestorId),
      previousNote:
          (previousNote != null ? previousNote.value : this.previousNote),
      confidential:
          (confidential != null ? confidential.value : this.confidential),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PlantEdit {
  const PlantEdit({
    this.state,
    this.currentNote,
    this.confidential,
    this.plantingDate,
    this.borrowingDate,
    this.nickname,
  });

  factory PlantEdit.fromJson(Map<String, dynamic> json) =>
      _$PlantEditFromJson(json);

  static const toJsonFactory = _$PlantEditToJson;
  Map<String, dynamic> toJson() => _$PlantEditToJson(this);

  @JsonKey(
    name: 'state',
    toJson: plantStateNullableToJson,
    fromJson: plantStateNullableFromJson,
  )
  final enums.PlantState? state;
  @JsonKey(name: 'current_note')
  final String? currentNote;
  @JsonKey(name: 'confidential', defaultValue: false)
  final bool? confidential;
  @JsonKey(name: 'planting_date')
  final String? plantingDate;
  @JsonKey(name: 'borrowing_date')
  final String? borrowingDate;
  @JsonKey(name: 'nickname')
  final String? nickname;
  static const fromJsonFactory = _$PlantEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlantEdit &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.currentNote, currentNote) ||
                const DeepCollectionEquality().equals(
                  other.currentNote,
                  currentNote,
                )) &&
            (identical(other.confidential, confidential) ||
                const DeepCollectionEquality().equals(
                  other.confidential,
                  confidential,
                )) &&
            (identical(other.plantingDate, plantingDate) ||
                const DeepCollectionEquality().equals(
                  other.plantingDate,
                  plantingDate,
                )) &&
            (identical(other.borrowingDate, borrowingDate) ||
                const DeepCollectionEquality().equals(
                  other.borrowingDate,
                  borrowingDate,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(currentNote) ^
      const DeepCollectionEquality().hash(confidential) ^
      const DeepCollectionEquality().hash(plantingDate) ^
      const DeepCollectionEquality().hash(borrowingDate) ^
      const DeepCollectionEquality().hash(nickname) ^
      runtimeType.hashCode;
}

extension $PlantEditExtension on PlantEdit {
  PlantEdit copyWith({
    enums.PlantState? state,
    String? currentNote,
    bool? confidential,
    String? plantingDate,
    String? borrowingDate,
    String? nickname,
  }) {
    return PlantEdit(
      state: state ?? this.state,
      currentNote: currentNote ?? this.currentNote,
      confidential: confidential ?? this.confidential,
      plantingDate: plantingDate ?? this.plantingDate,
      borrowingDate: borrowingDate ?? this.borrowingDate,
      nickname: nickname ?? this.nickname,
    );
  }

  PlantEdit copyWithWrapped({
    Wrapped<enums.PlantState?>? state,
    Wrapped<String?>? currentNote,
    Wrapped<bool?>? confidential,
    Wrapped<String?>? plantingDate,
    Wrapped<String?>? borrowingDate,
    Wrapped<String?>? nickname,
  }) {
    return PlantEdit(
      state: (state != null ? state.value : this.state),
      currentNote: (currentNote != null ? currentNote.value : this.currentNote),
      confidential:
          (confidential != null ? confidential.value : this.confidential),
      plantingDate:
          (plantingDate != null ? plantingDate.value : this.plantingDate),
      borrowingDate:
          (borrowingDate != null ? borrowingDate.value : this.borrowingDate),
      nickname: (nickname != null ? nickname.value : this.nickname),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PlantSimple {
  const PlantSimple({
    required this.id,
    required this.reference,
    required this.state,
    required this.speciesId,
    required this.propagationMethod,
    this.nbSeedsEnvelope,
    this.plantingDate,
    this.borrowerId,
    this.nickname,
  });

  factory PlantSimple.fromJson(Map<String, dynamic> json) =>
      _$PlantSimpleFromJson(json);

  static const toJsonFactory = _$PlantSimpleToJson;
  Map<String, dynamic> toJson() => _$PlantSimpleToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'reference', defaultValue: '')
  final String reference;
  @JsonKey(
    name: 'state',
    toJson: plantStateToJson,
    fromJson: plantStateFromJson,
  )
  final enums.PlantState state;
  @JsonKey(name: 'species_id', defaultValue: '')
  final String speciesId;
  @JsonKey(
    name: 'propagation_method',
    toJson: propagationMethodToJson,
    fromJson: propagationMethodFromJson,
  )
  final enums.PropagationMethod propagationMethod;
  @JsonKey(name: 'nb_seeds_envelope', defaultValue: 0)
  final int? nbSeedsEnvelope;
  @JsonKey(name: 'planting_date')
  final String? plantingDate;
  @JsonKey(name: 'borrower_id')
  final String? borrowerId;
  @JsonKey(name: 'nickname')
  final String? nickname;
  static const fromJsonFactory = _$PlantSimpleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlantSimple &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.speciesId, speciesId) ||
                const DeepCollectionEquality().equals(
                  other.speciesId,
                  speciesId,
                )) &&
            (identical(other.propagationMethod, propagationMethod) ||
                const DeepCollectionEquality().equals(
                  other.propagationMethod,
                  propagationMethod,
                )) &&
            (identical(other.nbSeedsEnvelope, nbSeedsEnvelope) ||
                const DeepCollectionEquality().equals(
                  other.nbSeedsEnvelope,
                  nbSeedsEnvelope,
                )) &&
            (identical(other.plantingDate, plantingDate) ||
                const DeepCollectionEquality().equals(
                  other.plantingDate,
                  plantingDate,
                )) &&
            (identical(other.borrowerId, borrowerId) ||
                const DeepCollectionEquality().equals(
                  other.borrowerId,
                  borrowerId,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(reference) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(speciesId) ^
      const DeepCollectionEquality().hash(propagationMethod) ^
      const DeepCollectionEquality().hash(nbSeedsEnvelope) ^
      const DeepCollectionEquality().hash(plantingDate) ^
      const DeepCollectionEquality().hash(borrowerId) ^
      const DeepCollectionEquality().hash(nickname) ^
      runtimeType.hashCode;
}

extension $PlantSimpleExtension on PlantSimple {
  PlantSimple copyWith({
    String? id,
    String? reference,
    enums.PlantState? state,
    String? speciesId,
    enums.PropagationMethod? propagationMethod,
    int? nbSeedsEnvelope,
    String? plantingDate,
    String? borrowerId,
    String? nickname,
  }) {
    return PlantSimple(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      state: state ?? this.state,
      speciesId: speciesId ?? this.speciesId,
      propagationMethod: propagationMethod ?? this.propagationMethod,
      nbSeedsEnvelope: nbSeedsEnvelope ?? this.nbSeedsEnvelope,
      plantingDate: plantingDate ?? this.plantingDate,
      borrowerId: borrowerId ?? this.borrowerId,
      nickname: nickname ?? this.nickname,
    );
  }

  PlantSimple copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? reference,
    Wrapped<enums.PlantState>? state,
    Wrapped<String>? speciesId,
    Wrapped<enums.PropagationMethod>? propagationMethod,
    Wrapped<int?>? nbSeedsEnvelope,
    Wrapped<String?>? plantingDate,
    Wrapped<String?>? borrowerId,
    Wrapped<String?>? nickname,
  }) {
    return PlantSimple(
      id: (id != null ? id.value : this.id),
      reference: (reference != null ? reference.value : this.reference),
      state: (state != null ? state.value : this.state),
      speciesId: (speciesId != null ? speciesId.value : this.speciesId),
      propagationMethod:
          (propagationMethod != null
              ? propagationMethod.value
              : this.propagationMethod),
      nbSeedsEnvelope:
          (nbSeedsEnvelope != null
              ? nbSeedsEnvelope.value
              : this.nbSeedsEnvelope),
      plantingDate:
          (plantingDate != null ? plantingDate.value : this.plantingDate),
      borrowerId: (borrowerId != null ? borrowerId.value : this.borrowerId),
      nickname: (nickname != null ? nickname.value : this.nickname),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrizeBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality().equals(
                  other.raffleId,
                  raffleId,
                )) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )));
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
  PrizeBase copyWith({
    String? name,
    String? description,
    String? raffleId,
    int? quantity,
  }) {
    return PrizeBase(
      name: name ?? this.name,
      description: description ?? this.description,
      raffleId: raffleId ?? this.raffleId,
      quantity: quantity ?? this.quantity,
    );
  }

  PrizeBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<String>? raffleId,
    Wrapped<int>? quantity,
  }) {
    return PrizeBase(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      raffleId: (raffleId != null ? raffleId.value : this.raffleId),
      quantity: (quantity != null ? quantity.value : this.quantity),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PrizeEdit {
  const PrizeEdit({this.raffleId, this.description, this.name, this.quantity});

  factory PrizeEdit.fromJson(Map<String, dynamic> json) =>
      _$PrizeEditFromJson(json);

  static const toJsonFactory = _$PrizeEditToJson;
  Map<String, dynamic> toJson() => _$PrizeEditToJson(this);

  @JsonKey(name: 'raffle_id')
  final String? raffleId;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'quantity')
  final int? quantity;
  static const fromJsonFactory = _$PrizeEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrizeEdit &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality().equals(
                  other.raffleId,
                  raffleId,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )));
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
  PrizeEdit copyWith({
    String? raffleId,
    String? description,
    String? name,
    int? quantity,
  }) {
    return PrizeEdit(
      raffleId: raffleId ?? this.raffleId,
      description: description ?? this.description,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }

  PrizeEdit copyWithWrapped({
    Wrapped<String?>? raffleId,
    Wrapped<String?>? description,
    Wrapped<String?>? name,
    Wrapped<int?>? quantity,
  }) {
    return PrizeEdit(
      raffleId: (raffleId != null ? raffleId.value : this.raffleId),
      description: (description != null ? description.value : this.description),
      name: (name != null ? name.value : this.name),
      quantity: (quantity != null ? quantity.value : this.quantity),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PrizeSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.raffleId, raffleId) ||
                const DeepCollectionEquality().equals(
                  other.raffleId,
                  raffleId,
                )) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )) &&
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
  PrizeSimple copyWith({
    String? name,
    String? description,
    String? raffleId,
    int? quantity,
    String? id,
  }) {
    return PrizeSimple(
      name: name ?? this.name,
      description: description ?? this.description,
      raffleId: raffleId ?? this.raffleId,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  PrizeSimple copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<String>? raffleId,
    Wrapped<int>? quantity,
    Wrapped<String>? id,
  }) {
    return PrizeSimple(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      raffleId: (raffleId != null ? raffleId.value : this.raffleId),
      quantity: (quantity != null ? quantity.value : this.quantity),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductBase {
  const ProductBase({
    required this.nameFr,
    this.nameEn,
    this.descriptionFr,
    this.descriptionEn,
    required this.availableOnline,
    this.relatedMembership,
    this.tickets,
    required this.productConstraints,
    required this.documentConstraints,
  });

  factory ProductBase.fromJson(Map<String, dynamic> json) =>
      _$ProductBaseFromJson(json);

  static const toJsonFactory = _$ProductBaseToJson;
  Map<String, dynamic> toJson() => _$ProductBaseToJson(this);

  @JsonKey(name: 'name_fr', defaultValue: '')
  final String nameFr;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'description_fr')
  final String? descriptionFr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @JsonKey(name: 'available_online', defaultValue: false)
  final bool availableOnline;
  @JsonKey(name: 'related_membership')
  final MembershipSimple? relatedMembership;
  @JsonKey(name: 'tickets', defaultValue: null)
  final List<GenerateTicketBase>? tickets;
  @JsonKey(name: 'product_constraints', defaultValue: <String>[])
  final List<String> productConstraints;
  @JsonKey(name: 'document_constraints', defaultValue: <String>[])
  final List<String> documentConstraints;
  static const fromJsonFactory = _$ProductBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductBase &&
            (identical(other.nameFr, nameFr) ||
                const DeepCollectionEquality().equals(other.nameFr, nameFr)) &&
            (identical(other.nameEn, nameEn) ||
                const DeepCollectionEquality().equals(other.nameEn, nameEn)) &&
            (identical(other.descriptionFr, descriptionFr) ||
                const DeepCollectionEquality().equals(
                  other.descriptionFr,
                  descriptionFr,
                )) &&
            (identical(other.descriptionEn, descriptionEn) ||
                const DeepCollectionEquality().equals(
                  other.descriptionEn,
                  descriptionEn,
                )) &&
            (identical(other.availableOnline, availableOnline) ||
                const DeepCollectionEquality().equals(
                  other.availableOnline,
                  availableOnline,
                )) &&
            (identical(other.relatedMembership, relatedMembership) ||
                const DeepCollectionEquality().equals(
                  other.relatedMembership,
                  relatedMembership,
                )) &&
            (identical(other.tickets, tickets) ||
                const DeepCollectionEquality().equals(
                  other.tickets,
                  tickets,
                )) &&
            (identical(other.productConstraints, productConstraints) ||
                const DeepCollectionEquality().equals(
                  other.productConstraints,
                  productConstraints,
                )) &&
            (identical(other.documentConstraints, documentConstraints) ||
                const DeepCollectionEquality().equals(
                  other.documentConstraints,
                  documentConstraints,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nameFr) ^
      const DeepCollectionEquality().hash(nameEn) ^
      const DeepCollectionEquality().hash(descriptionFr) ^
      const DeepCollectionEquality().hash(descriptionEn) ^
      const DeepCollectionEquality().hash(availableOnline) ^
      const DeepCollectionEquality().hash(relatedMembership) ^
      const DeepCollectionEquality().hash(tickets) ^
      const DeepCollectionEquality().hash(productConstraints) ^
      const DeepCollectionEquality().hash(documentConstraints) ^
      runtimeType.hashCode;
}

extension $ProductBaseExtension on ProductBase {
  ProductBase copyWith({
    String? nameFr,
    String? nameEn,
    String? descriptionFr,
    String? descriptionEn,
    bool? availableOnline,
    MembershipSimple? relatedMembership,
    List<GenerateTicketBase>? tickets,
    List<String>? productConstraints,
    List<String>? documentConstraints,
  }) {
    return ProductBase(
      nameFr: nameFr ?? this.nameFr,
      nameEn: nameEn ?? this.nameEn,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      availableOnline: availableOnline ?? this.availableOnline,
      relatedMembership: relatedMembership ?? this.relatedMembership,
      tickets: tickets ?? this.tickets,
      productConstraints: productConstraints ?? this.productConstraints,
      documentConstraints: documentConstraints ?? this.documentConstraints,
    );
  }

  ProductBase copyWithWrapped({
    Wrapped<String>? nameFr,
    Wrapped<String?>? nameEn,
    Wrapped<String?>? descriptionFr,
    Wrapped<String?>? descriptionEn,
    Wrapped<bool>? availableOnline,
    Wrapped<MembershipSimple?>? relatedMembership,
    Wrapped<List<GenerateTicketBase>?>? tickets,
    Wrapped<List<String>>? productConstraints,
    Wrapped<List<String>>? documentConstraints,
  }) {
    return ProductBase(
      nameFr: (nameFr != null ? nameFr.value : this.nameFr),
      nameEn: (nameEn != null ? nameEn.value : this.nameEn),
      descriptionFr:
          (descriptionFr != null ? descriptionFr.value : this.descriptionFr),
      descriptionEn:
          (descriptionEn != null ? descriptionEn.value : this.descriptionEn),
      availableOnline:
          (availableOnline != null
              ? availableOnline.value
              : this.availableOnline),
      relatedMembership:
          (relatedMembership != null
              ? relatedMembership.value
              : this.relatedMembership),
      tickets: (tickets != null ? tickets.value : this.tickets),
      productConstraints:
          (productConstraints != null
              ? productConstraints.value
              : this.productConstraints),
      documentConstraints:
          (documentConstraints != null
              ? documentConstraints.value
              : this.documentConstraints),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductCompleteNoConstraint {
  const ProductCompleteNoConstraint({
    required this.nameFr,
    this.nameEn,
    this.descriptionFr,
    this.descriptionEn,
    required this.availableOnline,
    required this.id,
    required this.sellerId,
    this.variants,
    this.relatedMembership,
    required this.tickets,
  });

  factory ProductCompleteNoConstraint.fromJson(Map<String, dynamic> json) =>
      _$ProductCompleteNoConstraintFromJson(json);

  static const toJsonFactory = _$ProductCompleteNoConstraintToJson;
  Map<String, dynamic> toJson() => _$ProductCompleteNoConstraintToJson(this);

  @JsonKey(name: 'name_fr', defaultValue: '')
  final String nameFr;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'description_fr')
  final String? descriptionFr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @JsonKey(name: 'available_online', defaultValue: false)
  final bool availableOnline;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'seller_id', defaultValue: '')
  final String sellerId;
  @JsonKey(name: 'variants', defaultValue: null)
  final List<ProductVariantComplete>? variants;
  @JsonKey(name: 'related_membership')
  final MembershipSimple? relatedMembership;
  @JsonKey(name: 'tickets', defaultValue: <GenerateTicketComplete>[])
  final List<GenerateTicketComplete> tickets;
  static const fromJsonFactory = _$ProductCompleteNoConstraintFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductCompleteNoConstraint &&
            (identical(other.nameFr, nameFr) ||
                const DeepCollectionEquality().equals(other.nameFr, nameFr)) &&
            (identical(other.nameEn, nameEn) ||
                const DeepCollectionEquality().equals(other.nameEn, nameEn)) &&
            (identical(other.descriptionFr, descriptionFr) ||
                const DeepCollectionEquality().equals(
                  other.descriptionFr,
                  descriptionFr,
                )) &&
            (identical(other.descriptionEn, descriptionEn) ||
                const DeepCollectionEquality().equals(
                  other.descriptionEn,
                  descriptionEn,
                )) &&
            (identical(other.availableOnline, availableOnline) ||
                const DeepCollectionEquality().equals(
                  other.availableOnline,
                  availableOnline,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.sellerId, sellerId) ||
                const DeepCollectionEquality().equals(
                  other.sellerId,
                  sellerId,
                )) &&
            (identical(other.variants, variants) ||
                const DeepCollectionEquality().equals(
                  other.variants,
                  variants,
                )) &&
            (identical(other.relatedMembership, relatedMembership) ||
                const DeepCollectionEquality().equals(
                  other.relatedMembership,
                  relatedMembership,
                )) &&
            (identical(other.tickets, tickets) ||
                const DeepCollectionEquality().equals(other.tickets, tickets)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nameFr) ^
      const DeepCollectionEquality().hash(nameEn) ^
      const DeepCollectionEquality().hash(descriptionFr) ^
      const DeepCollectionEquality().hash(descriptionEn) ^
      const DeepCollectionEquality().hash(availableOnline) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(sellerId) ^
      const DeepCollectionEquality().hash(variants) ^
      const DeepCollectionEquality().hash(relatedMembership) ^
      const DeepCollectionEquality().hash(tickets) ^
      runtimeType.hashCode;
}

extension $ProductCompleteNoConstraintExtension on ProductCompleteNoConstraint {
  ProductCompleteNoConstraint copyWith({
    String? nameFr,
    String? nameEn,
    String? descriptionFr,
    String? descriptionEn,
    bool? availableOnline,
    String? id,
    String? sellerId,
    List<ProductVariantComplete>? variants,
    MembershipSimple? relatedMembership,
    List<GenerateTicketComplete>? tickets,
  }) {
    return ProductCompleteNoConstraint(
      nameFr: nameFr ?? this.nameFr,
      nameEn: nameEn ?? this.nameEn,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      availableOnline: availableOnline ?? this.availableOnline,
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      variants: variants ?? this.variants,
      relatedMembership: relatedMembership ?? this.relatedMembership,
      tickets: tickets ?? this.tickets,
    );
  }

  ProductCompleteNoConstraint copyWithWrapped({
    Wrapped<String>? nameFr,
    Wrapped<String?>? nameEn,
    Wrapped<String?>? descriptionFr,
    Wrapped<String?>? descriptionEn,
    Wrapped<bool>? availableOnline,
    Wrapped<String>? id,
    Wrapped<String>? sellerId,
    Wrapped<List<ProductVariantComplete>?>? variants,
    Wrapped<MembershipSimple?>? relatedMembership,
    Wrapped<List<GenerateTicketComplete>>? tickets,
  }) {
    return ProductCompleteNoConstraint(
      nameFr: (nameFr != null ? nameFr.value : this.nameFr),
      nameEn: (nameEn != null ? nameEn.value : this.nameEn),
      descriptionFr:
          (descriptionFr != null ? descriptionFr.value : this.descriptionFr),
      descriptionEn:
          (descriptionEn != null ? descriptionEn.value : this.descriptionEn),
      availableOnline:
          (availableOnline != null
              ? availableOnline.value
              : this.availableOnline),
      id: (id != null ? id.value : this.id),
      sellerId: (sellerId != null ? sellerId.value : this.sellerId),
      variants: (variants != null ? variants.value : this.variants),
      relatedMembership:
          (relatedMembership != null
              ? relatedMembership.value
              : this.relatedMembership),
      tickets: (tickets != null ? tickets.value : this.tickets),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductQuantity {
  const ProductQuantity({required this.quantity, required this.product});

  factory ProductQuantity.fromJson(Map<String, dynamic> json) =>
      _$ProductQuantityFromJson(json);

  static const toJsonFactory = _$ProductQuantityToJson;
  Map<String, dynamic> toJson() => _$ProductQuantityToJson(this);

  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  @JsonKey(name: 'product')
  final AppModulesAmapSchemasAmapProductComplete product;
  static const fromJsonFactory = _$ProductQuantityFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductQuantity &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )) &&
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
  ProductQuantity copyWith({
    int? quantity,
    AppModulesAmapSchemasAmapProductComplete? product,
  }) {
    return ProductQuantity(
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  ProductQuantity copyWithWrapped({
    Wrapped<int>? quantity,
    Wrapped<AppModulesAmapSchemasAmapProductComplete>? product,
  }) {
    return ProductQuantity(
      quantity: (quantity != null ? quantity.value : this.quantity),
      product: (product != null ? product.value : this.product),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductSimple &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )));
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
      category: category ?? this.category,
    );
  }

  ProductSimple copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<double>? price,
    Wrapped<String>? category,
  }) {
    return ProductSimple(
      name: (name != null ? name.value : this.name),
      price: (price != null ? price.value : this.price),
      category: (category != null ? category.value : this.category),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductVariantBase {
  const ProductVariantBase({
    required this.nameFr,
    this.nameEn,
    this.descriptionFr,
    this.descriptionEn,
    required this.price,
    required this.enabled,
    required this.unique,
    required this.allowedCurriculum,
    this.relatedMembershipAddedDuration,
  });

  factory ProductVariantBase.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantBaseFromJson(json);

  static const toJsonFactory = _$ProductVariantBaseToJson;
  Map<String, dynamic> toJson() => _$ProductVariantBaseToJson(this);

  @JsonKey(name: 'name_fr', defaultValue: '')
  final String nameFr;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'description_fr')
  final String? descriptionFr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @JsonKey(name: 'price', defaultValue: 0)
  final int price;
  @JsonKey(name: 'enabled', defaultValue: false)
  final bool enabled;
  @JsonKey(name: 'unique', defaultValue: false)
  final bool unique;
  @JsonKey(name: 'allowed_curriculum', defaultValue: <String>[])
  final List<String> allowedCurriculum;
  @JsonKey(name: 'related_membership_added_duration')
  final String? relatedMembershipAddedDuration;
  static const fromJsonFactory = _$ProductVariantBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductVariantBase &&
            (identical(other.nameFr, nameFr) ||
                const DeepCollectionEquality().equals(other.nameFr, nameFr)) &&
            (identical(other.nameEn, nameEn) ||
                const DeepCollectionEquality().equals(other.nameEn, nameEn)) &&
            (identical(other.descriptionFr, descriptionFr) ||
                const DeepCollectionEquality().equals(
                  other.descriptionFr,
                  descriptionFr,
                )) &&
            (identical(other.descriptionEn, descriptionEn) ||
                const DeepCollectionEquality().equals(
                  other.descriptionEn,
                  descriptionEn,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.unique, unique) ||
                const DeepCollectionEquality().equals(other.unique, unique)) &&
            (identical(other.allowedCurriculum, allowedCurriculum) ||
                const DeepCollectionEquality().equals(
                  other.allowedCurriculum,
                  allowedCurriculum,
                )) &&
            (identical(
                  other.relatedMembershipAddedDuration,
                  relatedMembershipAddedDuration,
                ) ||
                const DeepCollectionEquality().equals(
                  other.relatedMembershipAddedDuration,
                  relatedMembershipAddedDuration,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nameFr) ^
      const DeepCollectionEquality().hash(nameEn) ^
      const DeepCollectionEquality().hash(descriptionFr) ^
      const DeepCollectionEquality().hash(descriptionEn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(unique) ^
      const DeepCollectionEquality().hash(allowedCurriculum) ^
      const DeepCollectionEquality().hash(relatedMembershipAddedDuration) ^
      runtimeType.hashCode;
}

extension $ProductVariantBaseExtension on ProductVariantBase {
  ProductVariantBase copyWith({
    String? nameFr,
    String? nameEn,
    String? descriptionFr,
    String? descriptionEn,
    int? price,
    bool? enabled,
    bool? unique,
    List<String>? allowedCurriculum,
    String? relatedMembershipAddedDuration,
  }) {
    return ProductVariantBase(
      nameFr: nameFr ?? this.nameFr,
      nameEn: nameEn ?? this.nameEn,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      price: price ?? this.price,
      enabled: enabled ?? this.enabled,
      unique: unique ?? this.unique,
      allowedCurriculum: allowedCurriculum ?? this.allowedCurriculum,
      relatedMembershipAddedDuration:
          relatedMembershipAddedDuration ?? this.relatedMembershipAddedDuration,
    );
  }

  ProductVariantBase copyWithWrapped({
    Wrapped<String>? nameFr,
    Wrapped<String?>? nameEn,
    Wrapped<String?>? descriptionFr,
    Wrapped<String?>? descriptionEn,
    Wrapped<int>? price,
    Wrapped<bool>? enabled,
    Wrapped<bool>? unique,
    Wrapped<List<String>>? allowedCurriculum,
    Wrapped<String?>? relatedMembershipAddedDuration,
  }) {
    return ProductVariantBase(
      nameFr: (nameFr != null ? nameFr.value : this.nameFr),
      nameEn: (nameEn != null ? nameEn.value : this.nameEn),
      descriptionFr:
          (descriptionFr != null ? descriptionFr.value : this.descriptionFr),
      descriptionEn:
          (descriptionEn != null ? descriptionEn.value : this.descriptionEn),
      price: (price != null ? price.value : this.price),
      enabled: (enabled != null ? enabled.value : this.enabled),
      unique: (unique != null ? unique.value : this.unique),
      allowedCurriculum:
          (allowedCurriculum != null
              ? allowedCurriculum.value
              : this.allowedCurriculum),
      relatedMembershipAddedDuration:
          (relatedMembershipAddedDuration != null
              ? relatedMembershipAddedDuration.value
              : this.relatedMembershipAddedDuration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductVariantComplete {
  const ProductVariantComplete({
    required this.id,
    required this.productId,
    required this.nameFr,
    this.nameEn,
    this.descriptionFr,
    this.descriptionEn,
    required this.price,
    required this.enabled,
    required this.unique,
    this.allowedCurriculum,
    this.relatedMembershipAddedDuration,
  });

  factory ProductVariantComplete.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantCompleteFromJson(json);

  static const toJsonFactory = _$ProductVariantCompleteToJson;
  Map<String, dynamic> toJson() => _$ProductVariantCompleteToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'product_id', defaultValue: '')
  final String productId;
  @JsonKey(name: 'name_fr', defaultValue: '')
  final String nameFr;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'description_fr')
  final String? descriptionFr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @JsonKey(name: 'price', defaultValue: 0)
  final int price;
  @JsonKey(name: 'enabled', defaultValue: false)
  final bool enabled;
  @JsonKey(name: 'unique', defaultValue: false)
  final bool unique;
  @JsonKey(name: 'allowed_curriculum', defaultValue: null)
  final List<CurriculumComplete>? allowedCurriculum;
  @JsonKey(name: 'related_membership_added_duration')
  final String? relatedMembershipAddedDuration;
  static const fromJsonFactory = _$ProductVariantCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductVariantComplete &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality().equals(
                  other.productId,
                  productId,
                )) &&
            (identical(other.nameFr, nameFr) ||
                const DeepCollectionEquality().equals(other.nameFr, nameFr)) &&
            (identical(other.nameEn, nameEn) ||
                const DeepCollectionEquality().equals(other.nameEn, nameEn)) &&
            (identical(other.descriptionFr, descriptionFr) ||
                const DeepCollectionEquality().equals(
                  other.descriptionFr,
                  descriptionFr,
                )) &&
            (identical(other.descriptionEn, descriptionEn) ||
                const DeepCollectionEquality().equals(
                  other.descriptionEn,
                  descriptionEn,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.unique, unique) ||
                const DeepCollectionEquality().equals(other.unique, unique)) &&
            (identical(other.allowedCurriculum, allowedCurriculum) ||
                const DeepCollectionEquality().equals(
                  other.allowedCurriculum,
                  allowedCurriculum,
                )) &&
            (identical(
                  other.relatedMembershipAddedDuration,
                  relatedMembershipAddedDuration,
                ) ||
                const DeepCollectionEquality().equals(
                  other.relatedMembershipAddedDuration,
                  relatedMembershipAddedDuration,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(nameFr) ^
      const DeepCollectionEquality().hash(nameEn) ^
      const DeepCollectionEquality().hash(descriptionFr) ^
      const DeepCollectionEquality().hash(descriptionEn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(unique) ^
      const DeepCollectionEquality().hash(allowedCurriculum) ^
      const DeepCollectionEquality().hash(relatedMembershipAddedDuration) ^
      runtimeType.hashCode;
}

extension $ProductVariantCompleteExtension on ProductVariantComplete {
  ProductVariantComplete copyWith({
    String? id,
    String? productId,
    String? nameFr,
    String? nameEn,
    String? descriptionFr,
    String? descriptionEn,
    int? price,
    bool? enabled,
    bool? unique,
    List<CurriculumComplete>? allowedCurriculum,
    String? relatedMembershipAddedDuration,
  }) {
    return ProductVariantComplete(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      nameFr: nameFr ?? this.nameFr,
      nameEn: nameEn ?? this.nameEn,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      price: price ?? this.price,
      enabled: enabled ?? this.enabled,
      unique: unique ?? this.unique,
      allowedCurriculum: allowedCurriculum ?? this.allowedCurriculum,
      relatedMembershipAddedDuration:
          relatedMembershipAddedDuration ?? this.relatedMembershipAddedDuration,
    );
  }

  ProductVariantComplete copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? productId,
    Wrapped<String>? nameFr,
    Wrapped<String?>? nameEn,
    Wrapped<String?>? descriptionFr,
    Wrapped<String?>? descriptionEn,
    Wrapped<int>? price,
    Wrapped<bool>? enabled,
    Wrapped<bool>? unique,
    Wrapped<List<CurriculumComplete>?>? allowedCurriculum,
    Wrapped<String?>? relatedMembershipAddedDuration,
  }) {
    return ProductVariantComplete(
      id: (id != null ? id.value : this.id),
      productId: (productId != null ? productId.value : this.productId),
      nameFr: (nameFr != null ? nameFr.value : this.nameFr),
      nameEn: (nameEn != null ? nameEn.value : this.nameEn),
      descriptionFr:
          (descriptionFr != null ? descriptionFr.value : this.descriptionFr),
      descriptionEn:
          (descriptionEn != null ? descriptionEn.value : this.descriptionEn),
      price: (price != null ? price.value : this.price),
      enabled: (enabled != null ? enabled.value : this.enabled),
      unique: (unique != null ? unique.value : this.unique),
      allowedCurriculum:
          (allowedCurriculum != null
              ? allowedCurriculum.value
              : this.allowedCurriculum),
      relatedMembershipAddedDuration:
          (relatedMembershipAddedDuration != null
              ? relatedMembershipAddedDuration.value
              : this.relatedMembershipAddedDuration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductVariantEdit {
  const ProductVariantEdit({
    this.nameFr,
    this.nameEn,
    this.descriptionFr,
    this.descriptionEn,
    this.price,
    this.enabled,
    this.unique,
    this.allowedCurriculum,
    this.relatedMembershipAddedDuration,
  });

  factory ProductVariantEdit.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantEditFromJson(json);

  static const toJsonFactory = _$ProductVariantEditToJson;
  Map<String, dynamic> toJson() => _$ProductVariantEditToJson(this);

  @JsonKey(name: 'name_fr')
  final String? nameFr;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'description_fr')
  final String? descriptionFr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @JsonKey(name: 'unique')
  final bool? unique;
  @JsonKey(name: 'allowed_curriculum')
  final List<String>? allowedCurriculum;
  @JsonKey(name: 'related_membership_added_duration')
  final String? relatedMembershipAddedDuration;
  static const fromJsonFactory = _$ProductVariantEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductVariantEdit &&
            (identical(other.nameFr, nameFr) ||
                const DeepCollectionEquality().equals(other.nameFr, nameFr)) &&
            (identical(other.nameEn, nameEn) ||
                const DeepCollectionEquality().equals(other.nameEn, nameEn)) &&
            (identical(other.descriptionFr, descriptionFr) ||
                const DeepCollectionEquality().equals(
                  other.descriptionFr,
                  descriptionFr,
                )) &&
            (identical(other.descriptionEn, descriptionEn) ||
                const DeepCollectionEquality().equals(
                  other.descriptionEn,
                  descriptionEn,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.unique, unique) ||
                const DeepCollectionEquality().equals(other.unique, unique)) &&
            (identical(other.allowedCurriculum, allowedCurriculum) ||
                const DeepCollectionEquality().equals(
                  other.allowedCurriculum,
                  allowedCurriculum,
                )) &&
            (identical(
                  other.relatedMembershipAddedDuration,
                  relatedMembershipAddedDuration,
                ) ||
                const DeepCollectionEquality().equals(
                  other.relatedMembershipAddedDuration,
                  relatedMembershipAddedDuration,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nameFr) ^
      const DeepCollectionEquality().hash(nameEn) ^
      const DeepCollectionEquality().hash(descriptionFr) ^
      const DeepCollectionEquality().hash(descriptionEn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(unique) ^
      const DeepCollectionEquality().hash(allowedCurriculum) ^
      const DeepCollectionEquality().hash(relatedMembershipAddedDuration) ^
      runtimeType.hashCode;
}

extension $ProductVariantEditExtension on ProductVariantEdit {
  ProductVariantEdit copyWith({
    String? nameFr,
    String? nameEn,
    String? descriptionFr,
    String? descriptionEn,
    int? price,
    bool? enabled,
    bool? unique,
    List<String>? allowedCurriculum,
    String? relatedMembershipAddedDuration,
  }) {
    return ProductVariantEdit(
      nameFr: nameFr ?? this.nameFr,
      nameEn: nameEn ?? this.nameEn,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      price: price ?? this.price,
      enabled: enabled ?? this.enabled,
      unique: unique ?? this.unique,
      allowedCurriculum: allowedCurriculum ?? this.allowedCurriculum,
      relatedMembershipAddedDuration:
          relatedMembershipAddedDuration ?? this.relatedMembershipAddedDuration,
    );
  }

  ProductVariantEdit copyWithWrapped({
    Wrapped<String?>? nameFr,
    Wrapped<String?>? nameEn,
    Wrapped<String?>? descriptionFr,
    Wrapped<String?>? descriptionEn,
    Wrapped<int?>? price,
    Wrapped<bool?>? enabled,
    Wrapped<bool?>? unique,
    Wrapped<List<String>?>? allowedCurriculum,
    Wrapped<String?>? relatedMembershipAddedDuration,
  }) {
    return ProductVariantEdit(
      nameFr: (nameFr != null ? nameFr.value : this.nameFr),
      nameEn: (nameEn != null ? nameEn.value : this.nameEn),
      descriptionFr:
          (descriptionFr != null ? descriptionFr.value : this.descriptionFr),
      descriptionEn:
          (descriptionEn != null ? descriptionEn.value : this.descriptionEn),
      price: (price != null ? price.value : this.price),
      enabled: (enabled != null ? enabled.value : this.enabled),
      unique: (unique != null ? unique.value : this.unique),
      allowedCurriculum:
          (allowedCurriculum != null
              ? allowedCurriculum.value
              : this.allowedCurriculum),
      relatedMembershipAddedDuration:
          (relatedMembershipAddedDuration != null
              ? relatedMembershipAddedDuration.value
              : this.relatedMembershipAddedDuration),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PurchaseBase {
  const PurchaseBase({required this.quantity});

  factory PurchaseBase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseBaseFromJson(json);

  static const toJsonFactory = _$PurchaseBaseToJson;
  Map<String, dynamic> toJson() => _$PurchaseBaseToJson(this);

  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  static const fromJsonFactory = _$PurchaseBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PurchaseBase &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(quantity) ^ runtimeType.hashCode;
}

extension $PurchaseBaseExtension on PurchaseBase {
  PurchaseBase copyWith({int? quantity}) {
    return PurchaseBase(quantity: quantity ?? this.quantity);
  }

  PurchaseBase copyWithWrapped({Wrapped<int>? quantity}) {
    return PurchaseBase(
      quantity: (quantity != null ? quantity.value : this.quantity),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PurchaseComplete {
  const PurchaseComplete({
    required this.quantity,
    required this.userId,
    required this.productVariantId,
    required this.validated,
    required this.purchasedOn,
  });

  factory PurchaseComplete.fromJson(Map<String, dynamic> json) =>
      _$PurchaseCompleteFromJson(json);

  static const toJsonFactory = _$PurchaseCompleteToJson;
  Map<String, dynamic> toJson() => _$PurchaseCompleteToJson(this);

  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'product_variant_id', defaultValue: '')
  final String productVariantId;
  @JsonKey(name: 'validated', defaultValue: false)
  final bool validated;
  @JsonKey(name: 'purchased_on')
  final DateTime purchasedOn;
  static const fromJsonFactory = _$PurchaseCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PurchaseComplete &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.productVariantId, productVariantId) ||
                const DeepCollectionEquality().equals(
                  other.productVariantId,
                  productVariantId,
                )) &&
            (identical(other.validated, validated) ||
                const DeepCollectionEquality().equals(
                  other.validated,
                  validated,
                )) &&
            (identical(other.purchasedOn, purchasedOn) ||
                const DeepCollectionEquality().equals(
                  other.purchasedOn,
                  purchasedOn,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(productVariantId) ^
      const DeepCollectionEquality().hash(validated) ^
      const DeepCollectionEquality().hash(purchasedOn) ^
      runtimeType.hashCode;
}

extension $PurchaseCompleteExtension on PurchaseComplete {
  PurchaseComplete copyWith({
    int? quantity,
    String? userId,
    String? productVariantId,
    bool? validated,
    DateTime? purchasedOn,
  }) {
    return PurchaseComplete(
      quantity: quantity ?? this.quantity,
      userId: userId ?? this.userId,
      productVariantId: productVariantId ?? this.productVariantId,
      validated: validated ?? this.validated,
      purchasedOn: purchasedOn ?? this.purchasedOn,
    );
  }

  PurchaseComplete copyWithWrapped({
    Wrapped<int>? quantity,
    Wrapped<String>? userId,
    Wrapped<String>? productVariantId,
    Wrapped<bool>? validated,
    Wrapped<DateTime>? purchasedOn,
  }) {
    return PurchaseComplete(
      quantity: (quantity != null ? quantity.value : this.quantity),
      userId: (userId != null ? userId.value : this.userId),
      productVariantId:
          (productVariantId != null
              ? productVariantId.value
              : this.productVariantId),
      validated: (validated != null ? validated.value : this.validated),
      purchasedOn: (purchasedOn != null ? purchasedOn.value : this.purchasedOn),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PurchaseReturn {
  const PurchaseReturn({
    required this.quantity,
    required this.userId,
    required this.productVariantId,
    required this.validated,
    required this.purchasedOn,
    required this.price,
    required this.product,
    required this.seller,
  });

  factory PurchaseReturn.fromJson(Map<String, dynamic> json) =>
      _$PurchaseReturnFromJson(json);

  static const toJsonFactory = _$PurchaseReturnToJson;
  Map<String, dynamic> toJson() => _$PurchaseReturnToJson(this);

  @JsonKey(name: 'quantity', defaultValue: 0)
  final int quantity;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'product_variant_id', defaultValue: '')
  final String productVariantId;
  @JsonKey(name: 'validated', defaultValue: false)
  final bool validated;
  @JsonKey(name: 'purchased_on')
  final DateTime purchasedOn;
  @JsonKey(name: 'price', defaultValue: 0)
  final int price;
  @JsonKey(name: 'product')
  final AppModulesCdrSchemasCdrProductComplete product;
  @JsonKey(name: 'seller')
  final SellerComplete seller;
  static const fromJsonFactory = _$PurchaseReturnFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PurchaseReturn &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality().equals(
                  other.quantity,
                  quantity,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.productVariantId, productVariantId) ||
                const DeepCollectionEquality().equals(
                  other.productVariantId,
                  productVariantId,
                )) &&
            (identical(other.validated, validated) ||
                const DeepCollectionEquality().equals(
                  other.validated,
                  validated,
                )) &&
            (identical(other.purchasedOn, purchasedOn) ||
                const DeepCollectionEquality().equals(
                  other.purchasedOn,
                  purchasedOn,
                )) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.product, product) ||
                const DeepCollectionEquality().equals(
                  other.product,
                  product,
                )) &&
            (identical(other.seller, seller) ||
                const DeepCollectionEquality().equals(other.seller, seller)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(quantity) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(productVariantId) ^
      const DeepCollectionEquality().hash(validated) ^
      const DeepCollectionEquality().hash(purchasedOn) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(product) ^
      const DeepCollectionEquality().hash(seller) ^
      runtimeType.hashCode;
}

extension $PurchaseReturnExtension on PurchaseReturn {
  PurchaseReturn copyWith({
    int? quantity,
    String? userId,
    String? productVariantId,
    bool? validated,
    DateTime? purchasedOn,
    int? price,
    AppModulesCdrSchemasCdrProductComplete? product,
    SellerComplete? seller,
  }) {
    return PurchaseReturn(
      quantity: quantity ?? this.quantity,
      userId: userId ?? this.userId,
      productVariantId: productVariantId ?? this.productVariantId,
      validated: validated ?? this.validated,
      purchasedOn: purchasedOn ?? this.purchasedOn,
      price: price ?? this.price,
      product: product ?? this.product,
      seller: seller ?? this.seller,
    );
  }

  PurchaseReturn copyWithWrapped({
    Wrapped<int>? quantity,
    Wrapped<String>? userId,
    Wrapped<String>? productVariantId,
    Wrapped<bool>? validated,
    Wrapped<DateTime>? purchasedOn,
    Wrapped<int>? price,
    Wrapped<AppModulesCdrSchemasCdrProductComplete>? product,
    Wrapped<SellerComplete>? seller,
  }) {
    return PurchaseReturn(
      quantity: (quantity != null ? quantity.value : this.quantity),
      userId: (userId != null ? userId.value : this.userId),
      productVariantId:
          (productVariantId != null
              ? productVariantId.value
              : this.productVariantId),
      validated: (validated != null ? validated.value : this.validated),
      purchasedOn: (purchasedOn != null ? purchasedOn.value : this.purchasedOn),
      price: (price != null ? price.value : this.price),
      product: (product != null ? product.value : this.product),
      seller: (seller != null ? seller.value : this.seller),
    );
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
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$RaffleBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RaffleBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
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
  RaffleBase copyWith({
    String? name,
    enums.RaffleStatusType? status,
    String? description,
    String? groupId,
  }) {
    return RaffleBase(
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
      groupId: groupId ?? this.groupId,
    );
  }

  RaffleBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<enums.RaffleStatusType?>? status,
    Wrapped<String?>? description,
    Wrapped<String>? groupId,
  }) {
    return RaffleBase(
      name: (name != null ? name.value : this.name),
      status: (status != null ? status.value : this.status),
      description: (description != null ? description.value : this.description),
      groupId: (groupId != null ? groupId.value : this.groupId),
    );
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
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$RaffleCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RaffleComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(
                  other.groupId,
                  groupId,
                )) &&
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
  RaffleComplete copyWith({
    String? name,
    enums.RaffleStatusType? status,
    String? description,
    String? groupId,
    String? id,
  }) {
    return RaffleComplete(
      name: name ?? this.name,
      status: status ?? this.status,
      description: description ?? this.description,
      groupId: groupId ?? this.groupId,
      id: id ?? this.id,
    );
  }

  RaffleComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<enums.RaffleStatusType?>? status,
    Wrapped<String?>? description,
    Wrapped<String>? groupId,
    Wrapped<String>? id,
  }) {
    return RaffleComplete(
      name: (name != null ? name.value : this.name),
      status: (status != null ? status.value : this.status),
      description: (description != null ? description.value : this.description),
      groupId: (groupId != null ? groupId.value : this.groupId),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RaffleEdit {
  const RaffleEdit({this.name, this.description});

  factory RaffleEdit.fromJson(Map<String, dynamic> json) =>
      _$RaffleEditFromJson(json);

  static const toJsonFactory = _$RaffleEditToJson;
  Map<String, dynamic> toJson() => _$RaffleEditToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$RaffleEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RaffleEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  RaffleEdit copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? description,
  }) {
    return RaffleEdit(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RaffleStats {
  const RaffleStats({required this.ticketsSold, required this.amountRaised});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RaffleStats &&
            (identical(other.ticketsSold, ticketsSold) ||
                const DeepCollectionEquality().equals(
                  other.ticketsSold,
                  ticketsSold,
                )) &&
            (identical(other.amountRaised, amountRaised) ||
                const DeepCollectionEquality().equals(
                  other.amountRaised,
                  amountRaised,
                )));
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
      amountRaised: amountRaised ?? this.amountRaised,
    );
  }

  RaffleStats copyWithWrapped({
    Wrapped<int>? ticketsSold,
    Wrapped<double>? amountRaised,
  }) {
    return RaffleStats(
      ticketsSold: (ticketsSold != null ? ticketsSold.value : this.ticketsSold),
      amountRaised:
          (amountRaised != null ? amountRaised.value : this.amountRaised),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RaidDriveFoldersCreation {
  const RaidDriveFoldersCreation({required this.parentFolderId});

  factory RaidDriveFoldersCreation.fromJson(Map<String, dynamic> json) =>
      _$RaidDriveFoldersCreationFromJson(json);

  static const toJsonFactory = _$RaidDriveFoldersCreationToJson;
  Map<String, dynamic> toJson() => _$RaidDriveFoldersCreationToJson(this);

  @JsonKey(name: 'parent_folder_id', defaultValue: '')
  final String parentFolderId;
  static const fromJsonFactory = _$RaidDriveFoldersCreationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RaidDriveFoldersCreation &&
            (identical(other.parentFolderId, parentFolderId) ||
                const DeepCollectionEquality().equals(
                  other.parentFolderId,
                  parentFolderId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(parentFolderId) ^
      runtimeType.hashCode;
}

extension $RaidDriveFoldersCreationExtension on RaidDriveFoldersCreation {
  RaidDriveFoldersCreation copyWith({String? parentFolderId}) {
    return RaidDriveFoldersCreation(
      parentFolderId: parentFolderId ?? this.parentFolderId,
    );
  }

  RaidDriveFoldersCreation copyWithWrapped({Wrapped<String>? parentFolderId}) {
    return RaidDriveFoldersCreation(
      parentFolderId:
          (parentFolderId != null ? parentFolderId.value : this.parentFolderId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RaidInformation {
  const RaidInformation({
    this.raidStartDate,
    this.raidEndDate,
    this.raidRegisteringEndDate,
    this.paymentLink,
    this.contact,
    this.president,
    this.volunteerResponsible,
    this.securityResponsible,
    this.rescue,
    this.raidRulesId,
    this.raidInformationId,
  });

  factory RaidInformation.fromJson(Map<String, dynamic> json) =>
      _$RaidInformationFromJson(json);

  static const toJsonFactory = _$RaidInformationToJson;
  Map<String, dynamic> toJson() => _$RaidInformationToJson(this);

  @JsonKey(name: 'raid_start_date')
  final String? raidStartDate;
  @JsonKey(name: 'raid_end_date')
  final String? raidEndDate;
  @JsonKey(name: 'raid_registering_end_date')
  final String? raidRegisteringEndDate;
  @JsonKey(name: 'payment_link')
  final String? paymentLink;
  @JsonKey(name: 'contact')
  final String? contact;
  @JsonKey(name: 'president')
  final EmergencyContact? president;
  @JsonKey(name: 'volunteer_responsible')
  final EmergencyContact? volunteerResponsible;
  @JsonKey(name: 'security_responsible')
  final EmergencyContact? securityResponsible;
  @JsonKey(name: 'rescue')
  final EmergencyContact? rescue;
  @JsonKey(name: 'raid_rules_id')
  final String? raidRulesId;
  @JsonKey(name: 'raid_information_id')
  final String? raidInformationId;
  static const fromJsonFactory = _$RaidInformationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RaidInformation &&
            (identical(other.raidStartDate, raidStartDate) ||
                const DeepCollectionEquality().equals(
                  other.raidStartDate,
                  raidStartDate,
                )) &&
            (identical(other.raidEndDate, raidEndDate) ||
                const DeepCollectionEquality().equals(
                  other.raidEndDate,
                  raidEndDate,
                )) &&
            (identical(other.raidRegisteringEndDate, raidRegisteringEndDate) ||
                const DeepCollectionEquality().equals(
                  other.raidRegisteringEndDate,
                  raidRegisteringEndDate,
                )) &&
            (identical(other.paymentLink, paymentLink) ||
                const DeepCollectionEquality().equals(
                  other.paymentLink,
                  paymentLink,
                )) &&
            (identical(other.contact, contact) ||
                const DeepCollectionEquality().equals(
                  other.contact,
                  contact,
                )) &&
            (identical(other.president, president) ||
                const DeepCollectionEquality().equals(
                  other.president,
                  president,
                )) &&
            (identical(other.volunteerResponsible, volunteerResponsible) ||
                const DeepCollectionEquality().equals(
                  other.volunteerResponsible,
                  volunteerResponsible,
                )) &&
            (identical(other.securityResponsible, securityResponsible) ||
                const DeepCollectionEquality().equals(
                  other.securityResponsible,
                  securityResponsible,
                )) &&
            (identical(other.rescue, rescue) ||
                const DeepCollectionEquality().equals(other.rescue, rescue)) &&
            (identical(other.raidRulesId, raidRulesId) ||
                const DeepCollectionEquality().equals(
                  other.raidRulesId,
                  raidRulesId,
                )) &&
            (identical(other.raidInformationId, raidInformationId) ||
                const DeepCollectionEquality().equals(
                  other.raidInformationId,
                  raidInformationId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(raidStartDate) ^
      const DeepCollectionEquality().hash(raidEndDate) ^
      const DeepCollectionEquality().hash(raidRegisteringEndDate) ^
      const DeepCollectionEquality().hash(paymentLink) ^
      const DeepCollectionEquality().hash(contact) ^
      const DeepCollectionEquality().hash(president) ^
      const DeepCollectionEquality().hash(volunteerResponsible) ^
      const DeepCollectionEquality().hash(securityResponsible) ^
      const DeepCollectionEquality().hash(rescue) ^
      const DeepCollectionEquality().hash(raidRulesId) ^
      const DeepCollectionEquality().hash(raidInformationId) ^
      runtimeType.hashCode;
}

extension $RaidInformationExtension on RaidInformation {
  RaidInformation copyWith({
    String? raidStartDate,
    String? raidEndDate,
    String? raidRegisteringEndDate,
    String? paymentLink,
    String? contact,
    EmergencyContact? president,
    EmergencyContact? volunteerResponsible,
    EmergencyContact? securityResponsible,
    EmergencyContact? rescue,
    String? raidRulesId,
    String? raidInformationId,
  }) {
    return RaidInformation(
      raidStartDate: raidStartDate ?? this.raidStartDate,
      raidEndDate: raidEndDate ?? this.raidEndDate,
      raidRegisteringEndDate:
          raidRegisteringEndDate ?? this.raidRegisteringEndDate,
      paymentLink: paymentLink ?? this.paymentLink,
      contact: contact ?? this.contact,
      president: president ?? this.president,
      volunteerResponsible: volunteerResponsible ?? this.volunteerResponsible,
      securityResponsible: securityResponsible ?? this.securityResponsible,
      rescue: rescue ?? this.rescue,
      raidRulesId: raidRulesId ?? this.raidRulesId,
      raidInformationId: raidInformationId ?? this.raidInformationId,
    );
  }

  RaidInformation copyWithWrapped({
    Wrapped<String?>? raidStartDate,
    Wrapped<String?>? raidEndDate,
    Wrapped<String?>? raidRegisteringEndDate,
    Wrapped<String?>? paymentLink,
    Wrapped<String?>? contact,
    Wrapped<EmergencyContact?>? president,
    Wrapped<EmergencyContact?>? volunteerResponsible,
    Wrapped<EmergencyContact?>? securityResponsible,
    Wrapped<EmergencyContact?>? rescue,
    Wrapped<String?>? raidRulesId,
    Wrapped<String?>? raidInformationId,
  }) {
    return RaidInformation(
      raidStartDate:
          (raidStartDate != null ? raidStartDate.value : this.raidStartDate),
      raidEndDate: (raidEndDate != null ? raidEndDate.value : this.raidEndDate),
      raidRegisteringEndDate:
          (raidRegisteringEndDate != null
              ? raidRegisteringEndDate.value
              : this.raidRegisteringEndDate),
      paymentLink: (paymentLink != null ? paymentLink.value : this.paymentLink),
      contact: (contact != null ? contact.value : this.contact),
      president: (president != null ? president.value : this.president),
      volunteerResponsible:
          (volunteerResponsible != null
              ? volunteerResponsible.value
              : this.volunteerResponsible),
      securityResponsible:
          (securityResponsible != null
              ? securityResponsible.value
              : this.securityResponsible),
      rescue: (rescue != null ? rescue.value : this.rescue),
      raidRulesId: (raidRulesId != null ? raidRulesId.value : this.raidRulesId),
      raidInformationId:
          (raidInformationId != null
              ? raidInformationId.value
              : this.raidInformationId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RaidPrice {
  const RaidPrice({this.studentPrice, this.partnerPrice, this.tShirtPrice});

  factory RaidPrice.fromJson(Map<String, dynamic> json) =>
      _$RaidPriceFromJson(json);

  static const toJsonFactory = _$RaidPriceToJson;
  Map<String, dynamic> toJson() => _$RaidPriceToJson(this);

  @JsonKey(name: 'student_price')
  final int? studentPrice;
  @JsonKey(name: 'partner_price')
  final int? partnerPrice;
  @JsonKey(name: 't_shirt_price')
  final int? tShirtPrice;
  static const fromJsonFactory = _$RaidPriceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RaidPrice &&
            (identical(other.studentPrice, studentPrice) ||
                const DeepCollectionEquality().equals(
                  other.studentPrice,
                  studentPrice,
                )) &&
            (identical(other.partnerPrice, partnerPrice) ||
                const DeepCollectionEquality().equals(
                  other.partnerPrice,
                  partnerPrice,
                )) &&
            (identical(other.tShirtPrice, tShirtPrice) ||
                const DeepCollectionEquality().equals(
                  other.tShirtPrice,
                  tShirtPrice,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(studentPrice) ^
      const DeepCollectionEquality().hash(partnerPrice) ^
      const DeepCollectionEquality().hash(tShirtPrice) ^
      runtimeType.hashCode;
}

extension $RaidPriceExtension on RaidPrice {
  RaidPrice copyWith({int? studentPrice, int? partnerPrice, int? tShirtPrice}) {
    return RaidPrice(
      studentPrice: studentPrice ?? this.studentPrice,
      partnerPrice: partnerPrice ?? this.partnerPrice,
      tShirtPrice: tShirtPrice ?? this.tShirtPrice,
    );
  }

  RaidPrice copyWithWrapped({
    Wrapped<int?>? studentPrice,
    Wrapped<int?>? partnerPrice,
    Wrapped<int?>? tShirtPrice,
  }) {
    return RaidPrice(
      studentPrice:
          (studentPrice != null ? studentPrice.value : this.studentPrice),
      partnerPrice:
          (partnerPrice != null ? partnerPrice.value : this.partnerPrice),
      tShirtPrice: (tShirtPrice != null ? tShirtPrice.value : this.tShirtPrice),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Recommendation {
  const Recommendation({
    required this.title,
    this.code,
    required this.summary,
    required this.description,
    required this.id,
    required this.creation,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);

  static const toJsonFactory = _$RecommendationToJson;
  Map<String, dynamic> toJson() => _$RecommendationToJson(this);

  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'summary', defaultValue: '')
  final String summary;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'creation')
  final DateTime creation;
  static const fromJsonFactory = _$RecommendationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Recommendation &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.summary, summary) ||
                const DeepCollectionEquality().equals(
                  other.summary,
                  summary,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(summary) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(creation) ^
      runtimeType.hashCode;
}

extension $RecommendationExtension on Recommendation {
  Recommendation copyWith({
    String? title,
    String? code,
    String? summary,
    String? description,
    String? id,
    DateTime? creation,
  }) {
    return Recommendation(
      title: title ?? this.title,
      code: code ?? this.code,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      id: id ?? this.id,
      creation: creation ?? this.creation,
    );
  }

  Recommendation copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String?>? code,
    Wrapped<String>? summary,
    Wrapped<String>? description,
    Wrapped<String>? id,
    Wrapped<DateTime>? creation,
  }) {
    return Recommendation(
      title: (title != null ? title.value : this.title),
      code: (code != null ? code.value : this.code),
      summary: (summary != null ? summary.value : this.summary),
      description: (description != null ? description.value : this.description),
      id: (id != null ? id.value : this.id),
      creation: (creation != null ? creation.value : this.creation),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecommendationBase {
  const RecommendationBase({
    required this.title,
    this.code,
    required this.summary,
    required this.description,
  });

  factory RecommendationBase.fromJson(Map<String, dynamic> json) =>
      _$RecommendationBaseFromJson(json);

  static const toJsonFactory = _$RecommendationBaseToJson;
  Map<String, dynamic> toJson() => _$RecommendationBaseToJson(this);

  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'summary', defaultValue: '')
  final String summary;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  static const fromJsonFactory = _$RecommendationBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RecommendationBase &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.summary, summary) ||
                const DeepCollectionEquality().equals(
                  other.summary,
                  summary,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(summary) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $RecommendationBaseExtension on RecommendationBase {
  RecommendationBase copyWith({
    String? title,
    String? code,
    String? summary,
    String? description,
  }) {
    return RecommendationBase(
      title: title ?? this.title,
      code: code ?? this.code,
      summary: summary ?? this.summary,
      description: description ?? this.description,
    );
  }

  RecommendationBase copyWithWrapped({
    Wrapped<String>? title,
    Wrapped<String?>? code,
    Wrapped<String>? summary,
    Wrapped<String>? description,
  }) {
    return RecommendationBase(
      title: (title != null ? title.value : this.title),
      code: (code != null ? code.value : this.code),
      summary: (summary != null ? summary.value : this.summary),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RecommendationEdit {
  const RecommendationEdit({
    this.title,
    this.code,
    this.summary,
    this.description,
  });

  factory RecommendationEdit.fromJson(Map<String, dynamic> json) =>
      _$RecommendationEditFromJson(json);

  static const toJsonFactory = _$RecommendationEditToJson;
  Map<String, dynamic> toJson() => _$RecommendationEditToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'summary')
  final String? summary;
  @JsonKey(name: 'description')
  final String? description;
  static const fromJsonFactory = _$RecommendationEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RecommendationEdit &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.summary, summary) ||
                const DeepCollectionEquality().equals(
                  other.summary,
                  summary,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(summary) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $RecommendationEditExtension on RecommendationEdit {
  RecommendationEdit copyWith({
    String? title,
    String? code,
    String? summary,
    String? description,
  }) {
    return RecommendationEdit(
      title: title ?? this.title,
      code: code ?? this.code,
      summary: summary ?? this.summary,
      description: description ?? this.description,
    );
  }

  RecommendationEdit copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? code,
    Wrapped<String?>? summary,
    Wrapped<String?>? description,
  }) {
    return RecommendationEdit(
      title: (title != null ? title.value : this.title),
      code: (code != null ? code.value : this.code),
      summary: (summary != null ? summary.value : this.summary),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Refund {
  const Refund({
    required this.id,
    required this.total,
    required this.creation,
    required this.transactionId,
    this.sellerUserId,
    required this.creditedWalletId,
    required this.debitedWalletId,
    required this.transaction,
    required this.creditedWallet,
    required this.debitedWallet,
  });

  factory Refund.fromJson(Map<String, dynamic> json) => _$RefundFromJson(json);

  static const toJsonFactory = _$RefundToJson;
  Map<String, dynamic> toJson() => _$RefundToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(name: 'transaction_id', defaultValue: '')
  final String transactionId;
  @JsonKey(name: 'seller_user_id')
  final String? sellerUserId;
  @JsonKey(name: 'credited_wallet_id', defaultValue: '')
  final String creditedWalletId;
  @JsonKey(name: 'debited_wallet_id', defaultValue: '')
  final String debitedWalletId;
  @JsonKey(name: 'transaction')
  final Transaction transaction;
  @JsonKey(name: 'credited_wallet')
  final WalletInfo creditedWallet;
  @JsonKey(name: 'debited_wallet')
  final WalletInfo debitedWallet;
  static const fromJsonFactory = _$RefundFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Refund &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.transactionId, transactionId) ||
                const DeepCollectionEquality().equals(
                  other.transactionId,
                  transactionId,
                )) &&
            (identical(other.sellerUserId, sellerUserId) ||
                const DeepCollectionEquality().equals(
                  other.sellerUserId,
                  sellerUserId,
                )) &&
            (identical(other.creditedWalletId, creditedWalletId) ||
                const DeepCollectionEquality().equals(
                  other.creditedWalletId,
                  creditedWalletId,
                )) &&
            (identical(other.debitedWalletId, debitedWalletId) ||
                const DeepCollectionEquality().equals(
                  other.debitedWalletId,
                  debitedWalletId,
                )) &&
            (identical(other.transaction, transaction) ||
                const DeepCollectionEquality().equals(
                  other.transaction,
                  transaction,
                )) &&
            (identical(other.creditedWallet, creditedWallet) ||
                const DeepCollectionEquality().equals(
                  other.creditedWallet,
                  creditedWallet,
                )) &&
            (identical(other.debitedWallet, debitedWallet) ||
                const DeepCollectionEquality().equals(
                  other.debitedWallet,
                  debitedWallet,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(transactionId) ^
      const DeepCollectionEquality().hash(sellerUserId) ^
      const DeepCollectionEquality().hash(creditedWalletId) ^
      const DeepCollectionEquality().hash(debitedWalletId) ^
      const DeepCollectionEquality().hash(transaction) ^
      const DeepCollectionEquality().hash(creditedWallet) ^
      const DeepCollectionEquality().hash(debitedWallet) ^
      runtimeType.hashCode;
}

extension $RefundExtension on Refund {
  Refund copyWith({
    String? id,
    int? total,
    DateTime? creation,
    String? transactionId,
    String? sellerUserId,
    String? creditedWalletId,
    String? debitedWalletId,
    Transaction? transaction,
    WalletInfo? creditedWallet,
    WalletInfo? debitedWallet,
  }) {
    return Refund(
      id: id ?? this.id,
      total: total ?? this.total,
      creation: creation ?? this.creation,
      transactionId: transactionId ?? this.transactionId,
      sellerUserId: sellerUserId ?? this.sellerUserId,
      creditedWalletId: creditedWalletId ?? this.creditedWalletId,
      debitedWalletId: debitedWalletId ?? this.debitedWalletId,
      transaction: transaction ?? this.transaction,
      creditedWallet: creditedWallet ?? this.creditedWallet,
      debitedWallet: debitedWallet ?? this.debitedWallet,
    );
  }

  Refund copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<int>? total,
    Wrapped<DateTime>? creation,
    Wrapped<String>? transactionId,
    Wrapped<String?>? sellerUserId,
    Wrapped<String>? creditedWalletId,
    Wrapped<String>? debitedWalletId,
    Wrapped<Transaction>? transaction,
    Wrapped<WalletInfo>? creditedWallet,
    Wrapped<WalletInfo>? debitedWallet,
  }) {
    return Refund(
      id: (id != null ? id.value : this.id),
      total: (total != null ? total.value : this.total),
      creation: (creation != null ? creation.value : this.creation),
      transactionId:
          (transactionId != null ? transactionId.value : this.transactionId),
      sellerUserId:
          (sellerUserId != null ? sellerUserId.value : this.sellerUserId),
      creditedWalletId:
          (creditedWalletId != null
              ? creditedWalletId.value
              : this.creditedWalletId),
      debitedWalletId:
          (debitedWalletId != null
              ? debitedWalletId.value
              : this.debitedWalletId),
      transaction: (transaction != null ? transaction.value : this.transaction),
      creditedWallet:
          (creditedWallet != null ? creditedWallet.value : this.creditedWallet),
      debitedWallet:
          (debitedWallet != null ? debitedWallet.value : this.debitedWallet),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RefundInfo {
  const RefundInfo({required this.completeRefund, this.amount});

  factory RefundInfo.fromJson(Map<String, dynamic> json) =>
      _$RefundInfoFromJson(json);

  static const toJsonFactory = _$RefundInfoToJson;
  Map<String, dynamic> toJson() => _$RefundInfoToJson(this);

  @JsonKey(name: 'complete_refund', defaultValue: false)
  final bool completeRefund;
  @JsonKey(name: 'amount')
  final int? amount;
  static const fromJsonFactory = _$RefundInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RefundInfo &&
            (identical(other.completeRefund, completeRefund) ||
                const DeepCollectionEquality().equals(
                  other.completeRefund,
                  completeRefund,
                )) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(completeRefund) ^
      const DeepCollectionEquality().hash(amount) ^
      runtimeType.hashCode;
}

extension $RefundInfoExtension on RefundInfo {
  RefundInfo copyWith({bool? completeRefund, int? amount}) {
    return RefundInfo(
      completeRefund: completeRefund ?? this.completeRefund,
      amount: amount ?? this.amount,
    );
  }

  RefundInfo copyWithWrapped({
    Wrapped<bool>? completeRefund,
    Wrapped<int?>? amount,
  }) {
    return RefundInfo(
      completeRefund:
          (completeRefund != null ? completeRefund.value : this.completeRefund),
      amount: (amount != null ? amount.value : this.amount),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ResetPasswordRequest &&
            (identical(other.resetToken, resetToken) ||
                const DeepCollectionEquality().equals(
                  other.resetToken,
                  resetToken,
                )) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality().equals(
                  other.newPassword,
                  newPassword,
                )));
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
      newPassword: newPassword ?? this.newPassword,
    );
  }

  ResetPasswordRequest copyWithWrapped({
    Wrapped<String>? resetToken,
    Wrapped<String>? newPassword,
  }) {
    return ResetPasswordRequest(
      resetToken: (resetToken != null ? resetToken.value : this.resetToken),
      newPassword: (newPassword != null ? newPassword.value : this.newPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RoleTagsReturn {
  const RoleTagsReturn({required this.tags});

  factory RoleTagsReturn.fromJson(Map<String, dynamic> json) =>
      _$RoleTagsReturnFromJson(json);

  static const toJsonFactory = _$RoleTagsReturnToJson;
  Map<String, dynamic> toJson() => _$RoleTagsReturnToJson(this);

  @JsonKey(name: 'tags', defaultValue: <String>[])
  final List<String> tags;
  static const fromJsonFactory = _$RoleTagsReturnFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RoleTagsReturn &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tags) ^ runtimeType.hashCode;
}

extension $RoleTagsReturnExtension on RoleTagsReturn {
  RoleTagsReturn copyWith({List<String>? tags}) {
    return RoleTagsReturn(tags: tags ?? this.tags);
  }

  RoleTagsReturn copyWithWrapped({Wrapped<List<String>>? tags}) {
    return RoleTagsReturn(tags: (tags != null ? tags.value : this.tags));
  }
}

@JsonSerializable(explicitToJson: true)
class RoomBase {
  const RoomBase({required this.name, required this.managerId});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RoomBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.managerId, managerId) ||
                const DeepCollectionEquality().equals(
                  other.managerId,
                  managerId,
                )));
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
      name: name ?? this.name,
      managerId: managerId ?? this.managerId,
    );
  }

  RoomBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? managerId,
  }) {
    return RoomBase(
      name: (name != null ? name.value : this.name),
      managerId: (managerId != null ? managerId.value : this.managerId),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RoomComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.managerId, managerId) ||
                const DeepCollectionEquality().equals(
                  other.managerId,
                  managerId,
                )) &&
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
      id: id ?? this.id,
    );
  }

  RoomComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? managerId,
    Wrapped<String>? id,
  }) {
    return RoomComplete(
      name: (name != null ? name.value : this.name),
      managerId: (managerId != null ? managerId.value : this.managerId),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ScanInfo {
  const ScanInfo({
    required this.id,
    required this.tot,
    required this.iat,
    required this.key,
    required this.store,
    required this.signature,
    this.bypassMembership,
  });

  factory ScanInfo.fromJson(Map<String, dynamic> json) =>
      _$ScanInfoFromJson(json);

  static const toJsonFactory = _$ScanInfoToJson;
  Map<String, dynamic> toJson() => _$ScanInfoToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'tot', defaultValue: 0)
  final int tot;
  @JsonKey(name: 'iat')
  final DateTime iat;
  @JsonKey(name: 'key', defaultValue: '')
  final String key;
  @JsonKey(name: 'store', defaultValue: false)
  final bool store;
  @JsonKey(name: 'signature', defaultValue: '')
  final String signature;
  @JsonKey(name: 'bypass_membership', defaultValue: false)
  final bool? bypassMembership;
  static const fromJsonFactory = _$ScanInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ScanInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.tot, tot) ||
                const DeepCollectionEquality().equals(other.tot, tot)) &&
            (identical(other.iat, iat) ||
                const DeepCollectionEquality().equals(other.iat, iat)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.store, store) ||
                const DeepCollectionEquality().equals(other.store, store)) &&
            (identical(other.signature, signature) ||
                const DeepCollectionEquality().equals(
                  other.signature,
                  signature,
                )) &&
            (identical(other.bypassMembership, bypassMembership) ||
                const DeepCollectionEquality().equals(
                  other.bypassMembership,
                  bypassMembership,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(tot) ^
      const DeepCollectionEquality().hash(iat) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(store) ^
      const DeepCollectionEquality().hash(signature) ^
      const DeepCollectionEquality().hash(bypassMembership) ^
      runtimeType.hashCode;
}

extension $ScanInfoExtension on ScanInfo {
  ScanInfo copyWith({
    String? id,
    int? tot,
    DateTime? iat,
    String? key,
    bool? store,
    String? signature,
    bool? bypassMembership,
  }) {
    return ScanInfo(
      id: id ?? this.id,
      tot: tot ?? this.tot,
      iat: iat ?? this.iat,
      key: key ?? this.key,
      store: store ?? this.store,
      signature: signature ?? this.signature,
      bypassMembership: bypassMembership ?? this.bypassMembership,
    );
  }

  ScanInfo copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<int>? tot,
    Wrapped<DateTime>? iat,
    Wrapped<String>? key,
    Wrapped<bool>? store,
    Wrapped<String>? signature,
    Wrapped<bool?>? bypassMembership,
  }) {
    return ScanInfo(
      id: (id != null ? id.value : this.id),
      tot: (tot != null ? tot.value : this.tot),
      iat: (iat != null ? iat.value : this.iat),
      key: (key != null ? key.value : this.key),
      store: (store != null ? store.value : this.store),
      signature: (signature != null ? signature.value : this.signature),
      bypassMembership:
          (bypassMembership != null
              ? bypassMembership.value
              : this.bypassMembership),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SectionBase {
  const SectionBase({required this.name, required this.description});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SectionBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
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
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  SectionBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? description,
  }) {
    return SectionBase(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SectionComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
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
      id: id ?? this.id,
    );
  }

  SectionComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? description,
    Wrapped<String>? id,
  }) {
    return SectionComplete(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SecurityFile {
  const SecurityFile({
    this.allergy,
    required this.asthma,
    this.intensiveCareUnit,
    this.intensiveCareUnitWhen,
    this.ongoingTreatment,
    this.sicknesses,
    this.hospitalization,
    this.surgicalOperation,
    this.trauma,
    this.family,
    this.emergencyPersonFirstname,
    this.emergencyPersonName,
    this.emergencyPersonPhone,
    this.fileId,
    required this.validation,
    required this.id,
  });

  factory SecurityFile.fromJson(Map<String, dynamic> json) =>
      _$SecurityFileFromJson(json);

  static const toJsonFactory = _$SecurityFileToJson;
  Map<String, dynamic> toJson() => _$SecurityFileToJson(this);

  @JsonKey(name: 'allergy')
  final String? allergy;
  @JsonKey(name: 'asthma', defaultValue: false)
  final bool asthma;
  @JsonKey(name: 'intensive_care_unit')
  final bool? intensiveCareUnit;
  @JsonKey(name: 'intensive_care_unit_when')
  final String? intensiveCareUnitWhen;
  @JsonKey(name: 'ongoing_treatment')
  final String? ongoingTreatment;
  @JsonKey(name: 'sicknesses')
  final String? sicknesses;
  @JsonKey(name: 'hospitalization')
  final String? hospitalization;
  @JsonKey(name: 'surgical_operation')
  final String? surgicalOperation;
  @JsonKey(name: 'trauma')
  final String? trauma;
  @JsonKey(name: 'family')
  final String? family;
  @JsonKey(name: 'emergency_person_firstname')
  final String? emergencyPersonFirstname;
  @JsonKey(name: 'emergency_person_name')
  final String? emergencyPersonName;
  @JsonKey(name: 'emergency_person_phone')
  final String? emergencyPersonPhone;
  @JsonKey(name: 'file_id')
  final String? fileId;
  @JsonKey(
    name: 'validation',
    toJson: documentValidationToJson,
    fromJson: documentValidationFromJson,
  )
  final enums.DocumentValidation validation;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$SecurityFileFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SecurityFile &&
            (identical(other.allergy, allergy) ||
                const DeepCollectionEquality().equals(
                  other.allergy,
                  allergy,
                )) &&
            (identical(other.asthma, asthma) ||
                const DeepCollectionEquality().equals(other.asthma, asthma)) &&
            (identical(other.intensiveCareUnit, intensiveCareUnit) ||
                const DeepCollectionEquality().equals(
                  other.intensiveCareUnit,
                  intensiveCareUnit,
                )) &&
            (identical(other.intensiveCareUnitWhen, intensiveCareUnitWhen) ||
                const DeepCollectionEquality().equals(
                  other.intensiveCareUnitWhen,
                  intensiveCareUnitWhen,
                )) &&
            (identical(other.ongoingTreatment, ongoingTreatment) ||
                const DeepCollectionEquality().equals(
                  other.ongoingTreatment,
                  ongoingTreatment,
                )) &&
            (identical(other.sicknesses, sicknesses) ||
                const DeepCollectionEquality().equals(
                  other.sicknesses,
                  sicknesses,
                )) &&
            (identical(other.hospitalization, hospitalization) ||
                const DeepCollectionEquality().equals(
                  other.hospitalization,
                  hospitalization,
                )) &&
            (identical(other.surgicalOperation, surgicalOperation) ||
                const DeepCollectionEquality().equals(
                  other.surgicalOperation,
                  surgicalOperation,
                )) &&
            (identical(other.trauma, trauma) ||
                const DeepCollectionEquality().equals(other.trauma, trauma)) &&
            (identical(other.family, family) ||
                const DeepCollectionEquality().equals(other.family, family)) &&
            (identical(
                  other.emergencyPersonFirstname,
                  emergencyPersonFirstname,
                ) ||
                const DeepCollectionEquality().equals(
                  other.emergencyPersonFirstname,
                  emergencyPersonFirstname,
                )) &&
            (identical(other.emergencyPersonName, emergencyPersonName) ||
                const DeepCollectionEquality().equals(
                  other.emergencyPersonName,
                  emergencyPersonName,
                )) &&
            (identical(other.emergencyPersonPhone, emergencyPersonPhone) ||
                const DeepCollectionEquality().equals(
                  other.emergencyPersonPhone,
                  emergencyPersonPhone,
                )) &&
            (identical(other.fileId, fileId) ||
                const DeepCollectionEquality().equals(other.fileId, fileId)) &&
            (identical(other.validation, validation) ||
                const DeepCollectionEquality().equals(
                  other.validation,
                  validation,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(allergy) ^
      const DeepCollectionEquality().hash(asthma) ^
      const DeepCollectionEquality().hash(intensiveCareUnit) ^
      const DeepCollectionEquality().hash(intensiveCareUnitWhen) ^
      const DeepCollectionEquality().hash(ongoingTreatment) ^
      const DeepCollectionEquality().hash(sicknesses) ^
      const DeepCollectionEquality().hash(hospitalization) ^
      const DeepCollectionEquality().hash(surgicalOperation) ^
      const DeepCollectionEquality().hash(trauma) ^
      const DeepCollectionEquality().hash(family) ^
      const DeepCollectionEquality().hash(emergencyPersonFirstname) ^
      const DeepCollectionEquality().hash(emergencyPersonName) ^
      const DeepCollectionEquality().hash(emergencyPersonPhone) ^
      const DeepCollectionEquality().hash(fileId) ^
      const DeepCollectionEquality().hash(validation) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $SecurityFileExtension on SecurityFile {
  SecurityFile copyWith({
    String? allergy,
    bool? asthma,
    bool? intensiveCareUnit,
    String? intensiveCareUnitWhen,
    String? ongoingTreatment,
    String? sicknesses,
    String? hospitalization,
    String? surgicalOperation,
    String? trauma,
    String? family,
    String? emergencyPersonFirstname,
    String? emergencyPersonName,
    String? emergencyPersonPhone,
    String? fileId,
    enums.DocumentValidation? validation,
    String? id,
  }) {
    return SecurityFile(
      allergy: allergy ?? this.allergy,
      asthma: asthma ?? this.asthma,
      intensiveCareUnit: intensiveCareUnit ?? this.intensiveCareUnit,
      intensiveCareUnitWhen:
          intensiveCareUnitWhen ?? this.intensiveCareUnitWhen,
      ongoingTreatment: ongoingTreatment ?? this.ongoingTreatment,
      sicknesses: sicknesses ?? this.sicknesses,
      hospitalization: hospitalization ?? this.hospitalization,
      surgicalOperation: surgicalOperation ?? this.surgicalOperation,
      trauma: trauma ?? this.trauma,
      family: family ?? this.family,
      emergencyPersonFirstname:
          emergencyPersonFirstname ?? this.emergencyPersonFirstname,
      emergencyPersonName: emergencyPersonName ?? this.emergencyPersonName,
      emergencyPersonPhone: emergencyPersonPhone ?? this.emergencyPersonPhone,
      fileId: fileId ?? this.fileId,
      validation: validation ?? this.validation,
      id: id ?? this.id,
    );
  }

  SecurityFile copyWithWrapped({
    Wrapped<String?>? allergy,
    Wrapped<bool>? asthma,
    Wrapped<bool?>? intensiveCareUnit,
    Wrapped<String?>? intensiveCareUnitWhen,
    Wrapped<String?>? ongoingTreatment,
    Wrapped<String?>? sicknesses,
    Wrapped<String?>? hospitalization,
    Wrapped<String?>? surgicalOperation,
    Wrapped<String?>? trauma,
    Wrapped<String?>? family,
    Wrapped<String?>? emergencyPersonFirstname,
    Wrapped<String?>? emergencyPersonName,
    Wrapped<String?>? emergencyPersonPhone,
    Wrapped<String?>? fileId,
    Wrapped<enums.DocumentValidation>? validation,
    Wrapped<String>? id,
  }) {
    return SecurityFile(
      allergy: (allergy != null ? allergy.value : this.allergy),
      asthma: (asthma != null ? asthma.value : this.asthma),
      intensiveCareUnit:
          (intensiveCareUnit != null
              ? intensiveCareUnit.value
              : this.intensiveCareUnit),
      intensiveCareUnitWhen:
          (intensiveCareUnitWhen != null
              ? intensiveCareUnitWhen.value
              : this.intensiveCareUnitWhen),
      ongoingTreatment:
          (ongoingTreatment != null
              ? ongoingTreatment.value
              : this.ongoingTreatment),
      sicknesses: (sicknesses != null ? sicknesses.value : this.sicknesses),
      hospitalization:
          (hospitalization != null
              ? hospitalization.value
              : this.hospitalization),
      surgicalOperation:
          (surgicalOperation != null
              ? surgicalOperation.value
              : this.surgicalOperation),
      trauma: (trauma != null ? trauma.value : this.trauma),
      family: (family != null ? family.value : this.family),
      emergencyPersonFirstname:
          (emergencyPersonFirstname != null
              ? emergencyPersonFirstname.value
              : this.emergencyPersonFirstname),
      emergencyPersonName:
          (emergencyPersonName != null
              ? emergencyPersonName.value
              : this.emergencyPersonName),
      emergencyPersonPhone:
          (emergencyPersonPhone != null
              ? emergencyPersonPhone.value
              : this.emergencyPersonPhone),
      fileId: (fileId != null ? fileId.value : this.fileId),
      validation: (validation != null ? validation.value : this.validation),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SecurityFileBase {
  const SecurityFileBase({
    this.allergy,
    required this.asthma,
    this.intensiveCareUnit,
    this.intensiveCareUnitWhen,
    this.ongoingTreatment,
    this.sicknesses,
    this.hospitalization,
    this.surgicalOperation,
    this.trauma,
    this.family,
    this.emergencyPersonFirstname,
    this.emergencyPersonName,
    this.emergencyPersonPhone,
    this.fileId,
  });

  factory SecurityFileBase.fromJson(Map<String, dynamic> json) =>
      _$SecurityFileBaseFromJson(json);

  static const toJsonFactory = _$SecurityFileBaseToJson;
  Map<String, dynamic> toJson() => _$SecurityFileBaseToJson(this);

  @JsonKey(name: 'allergy')
  final String? allergy;
  @JsonKey(name: 'asthma', defaultValue: false)
  final bool asthma;
  @JsonKey(name: 'intensive_care_unit')
  final bool? intensiveCareUnit;
  @JsonKey(name: 'intensive_care_unit_when')
  final String? intensiveCareUnitWhen;
  @JsonKey(name: 'ongoing_treatment')
  final String? ongoingTreatment;
  @JsonKey(name: 'sicknesses')
  final String? sicknesses;
  @JsonKey(name: 'hospitalization')
  final String? hospitalization;
  @JsonKey(name: 'surgical_operation')
  final String? surgicalOperation;
  @JsonKey(name: 'trauma')
  final String? trauma;
  @JsonKey(name: 'family')
  final String? family;
  @JsonKey(name: 'emergency_person_firstname')
  final String? emergencyPersonFirstname;
  @JsonKey(name: 'emergency_person_name')
  final String? emergencyPersonName;
  @JsonKey(name: 'emergency_person_phone')
  final String? emergencyPersonPhone;
  @JsonKey(name: 'file_id')
  final String? fileId;
  static const fromJsonFactory = _$SecurityFileBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SecurityFileBase &&
            (identical(other.allergy, allergy) ||
                const DeepCollectionEquality().equals(
                  other.allergy,
                  allergy,
                )) &&
            (identical(other.asthma, asthma) ||
                const DeepCollectionEquality().equals(other.asthma, asthma)) &&
            (identical(other.intensiveCareUnit, intensiveCareUnit) ||
                const DeepCollectionEquality().equals(
                  other.intensiveCareUnit,
                  intensiveCareUnit,
                )) &&
            (identical(other.intensiveCareUnitWhen, intensiveCareUnitWhen) ||
                const DeepCollectionEquality().equals(
                  other.intensiveCareUnitWhen,
                  intensiveCareUnitWhen,
                )) &&
            (identical(other.ongoingTreatment, ongoingTreatment) ||
                const DeepCollectionEquality().equals(
                  other.ongoingTreatment,
                  ongoingTreatment,
                )) &&
            (identical(other.sicknesses, sicknesses) ||
                const DeepCollectionEquality().equals(
                  other.sicknesses,
                  sicknesses,
                )) &&
            (identical(other.hospitalization, hospitalization) ||
                const DeepCollectionEquality().equals(
                  other.hospitalization,
                  hospitalization,
                )) &&
            (identical(other.surgicalOperation, surgicalOperation) ||
                const DeepCollectionEquality().equals(
                  other.surgicalOperation,
                  surgicalOperation,
                )) &&
            (identical(other.trauma, trauma) ||
                const DeepCollectionEquality().equals(other.trauma, trauma)) &&
            (identical(other.family, family) ||
                const DeepCollectionEquality().equals(other.family, family)) &&
            (identical(
                  other.emergencyPersonFirstname,
                  emergencyPersonFirstname,
                ) ||
                const DeepCollectionEquality().equals(
                  other.emergencyPersonFirstname,
                  emergencyPersonFirstname,
                )) &&
            (identical(other.emergencyPersonName, emergencyPersonName) ||
                const DeepCollectionEquality().equals(
                  other.emergencyPersonName,
                  emergencyPersonName,
                )) &&
            (identical(other.emergencyPersonPhone, emergencyPersonPhone) ||
                const DeepCollectionEquality().equals(
                  other.emergencyPersonPhone,
                  emergencyPersonPhone,
                )) &&
            (identical(other.fileId, fileId) ||
                const DeepCollectionEquality().equals(other.fileId, fileId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(allergy) ^
      const DeepCollectionEquality().hash(asthma) ^
      const DeepCollectionEquality().hash(intensiveCareUnit) ^
      const DeepCollectionEquality().hash(intensiveCareUnitWhen) ^
      const DeepCollectionEquality().hash(ongoingTreatment) ^
      const DeepCollectionEquality().hash(sicknesses) ^
      const DeepCollectionEquality().hash(hospitalization) ^
      const DeepCollectionEquality().hash(surgicalOperation) ^
      const DeepCollectionEquality().hash(trauma) ^
      const DeepCollectionEquality().hash(family) ^
      const DeepCollectionEquality().hash(emergencyPersonFirstname) ^
      const DeepCollectionEquality().hash(emergencyPersonName) ^
      const DeepCollectionEquality().hash(emergencyPersonPhone) ^
      const DeepCollectionEquality().hash(fileId) ^
      runtimeType.hashCode;
}

extension $SecurityFileBaseExtension on SecurityFileBase {
  SecurityFileBase copyWith({
    String? allergy,
    bool? asthma,
    bool? intensiveCareUnit,
    String? intensiveCareUnitWhen,
    String? ongoingTreatment,
    String? sicknesses,
    String? hospitalization,
    String? surgicalOperation,
    String? trauma,
    String? family,
    String? emergencyPersonFirstname,
    String? emergencyPersonName,
    String? emergencyPersonPhone,
    String? fileId,
  }) {
    return SecurityFileBase(
      allergy: allergy ?? this.allergy,
      asthma: asthma ?? this.asthma,
      intensiveCareUnit: intensiveCareUnit ?? this.intensiveCareUnit,
      intensiveCareUnitWhen:
          intensiveCareUnitWhen ?? this.intensiveCareUnitWhen,
      ongoingTreatment: ongoingTreatment ?? this.ongoingTreatment,
      sicknesses: sicknesses ?? this.sicknesses,
      hospitalization: hospitalization ?? this.hospitalization,
      surgicalOperation: surgicalOperation ?? this.surgicalOperation,
      trauma: trauma ?? this.trauma,
      family: family ?? this.family,
      emergencyPersonFirstname:
          emergencyPersonFirstname ?? this.emergencyPersonFirstname,
      emergencyPersonName: emergencyPersonName ?? this.emergencyPersonName,
      emergencyPersonPhone: emergencyPersonPhone ?? this.emergencyPersonPhone,
      fileId: fileId ?? this.fileId,
    );
  }

  SecurityFileBase copyWithWrapped({
    Wrapped<String?>? allergy,
    Wrapped<bool>? asthma,
    Wrapped<bool?>? intensiveCareUnit,
    Wrapped<String?>? intensiveCareUnitWhen,
    Wrapped<String?>? ongoingTreatment,
    Wrapped<String?>? sicknesses,
    Wrapped<String?>? hospitalization,
    Wrapped<String?>? surgicalOperation,
    Wrapped<String?>? trauma,
    Wrapped<String?>? family,
    Wrapped<String?>? emergencyPersonFirstname,
    Wrapped<String?>? emergencyPersonName,
    Wrapped<String?>? emergencyPersonPhone,
    Wrapped<String?>? fileId,
  }) {
    return SecurityFileBase(
      allergy: (allergy != null ? allergy.value : this.allergy),
      asthma: (asthma != null ? asthma.value : this.asthma),
      intensiveCareUnit:
          (intensiveCareUnit != null
              ? intensiveCareUnit.value
              : this.intensiveCareUnit),
      intensiveCareUnitWhen:
          (intensiveCareUnitWhen != null
              ? intensiveCareUnitWhen.value
              : this.intensiveCareUnitWhen),
      ongoingTreatment:
          (ongoingTreatment != null
              ? ongoingTreatment.value
              : this.ongoingTreatment),
      sicknesses: (sicknesses != null ? sicknesses.value : this.sicknesses),
      hospitalization:
          (hospitalization != null
              ? hospitalization.value
              : this.hospitalization),
      surgicalOperation:
          (surgicalOperation != null
              ? surgicalOperation.value
              : this.surgicalOperation),
      trauma: (trauma != null ? trauma.value : this.trauma),
      family: (family != null ? family.value : this.family),
      emergencyPersonFirstname:
          (emergencyPersonFirstname != null
              ? emergencyPersonFirstname.value
              : this.emergencyPersonFirstname),
      emergencyPersonName:
          (emergencyPersonName != null
              ? emergencyPersonName.value
              : this.emergencyPersonName),
      emergencyPersonPhone:
          (emergencyPersonPhone != null
              ? emergencyPersonPhone.value
              : this.emergencyPersonPhone),
      fileId: (fileId != null ? fileId.value : this.fileId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SeedLibraryInformation {
  const SeedLibraryInformation({
    this.facebookUrl,
    this.forumUrl,
    this.description,
    this.contact,
  });

  factory SeedLibraryInformation.fromJson(Map<String, dynamic> json) =>
      _$SeedLibraryInformationFromJson(json);

  static const toJsonFactory = _$SeedLibraryInformationToJson;
  Map<String, dynamic> toJson() => _$SeedLibraryInformationToJson(this);

  @JsonKey(name: 'facebook_url', defaultValue: '')
  final String? facebookUrl;
  @JsonKey(name: 'forum_url', defaultValue: '')
  final String? forumUrl;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;
  @JsonKey(name: 'contact', defaultValue: '')
  final String? contact;
  static const fromJsonFactory = _$SeedLibraryInformationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SeedLibraryInformation &&
            (identical(other.facebookUrl, facebookUrl) ||
                const DeepCollectionEquality().equals(
                  other.facebookUrl,
                  facebookUrl,
                )) &&
            (identical(other.forumUrl, forumUrl) ||
                const DeepCollectionEquality().equals(
                  other.forumUrl,
                  forumUrl,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.contact, contact) ||
                const DeepCollectionEquality().equals(other.contact, contact)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(facebookUrl) ^
      const DeepCollectionEquality().hash(forumUrl) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(contact) ^
      runtimeType.hashCode;
}

extension $SeedLibraryInformationExtension on SeedLibraryInformation {
  SeedLibraryInformation copyWith({
    String? facebookUrl,
    String? forumUrl,
    String? description,
    String? contact,
  }) {
    return SeedLibraryInformation(
      facebookUrl: facebookUrl ?? this.facebookUrl,
      forumUrl: forumUrl ?? this.forumUrl,
      description: description ?? this.description,
      contact: contact ?? this.contact,
    );
  }

  SeedLibraryInformation copyWithWrapped({
    Wrapped<String?>? facebookUrl,
    Wrapped<String?>? forumUrl,
    Wrapped<String?>? description,
    Wrapped<String?>? contact,
  }) {
    return SeedLibraryInformation(
      facebookUrl: (facebookUrl != null ? facebookUrl.value : this.facebookUrl),
      forumUrl: (forumUrl != null ? forumUrl.value : this.forumUrl),
      description: (description != null ? description.value : this.description),
      contact: (contact != null ? contact.value : this.contact),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Seller {
  const Seller({
    required this.userId,
    required this.storeId,
    required this.canBank,
    required this.canSeeHistory,
    required this.canCancel,
    required this.canManageSellers,
    required this.user,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);

  static const toJsonFactory = _$SellerToJson;
  Map<String, dynamic> toJson() => _$SellerToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'store_id', defaultValue: '')
  final String storeId;
  @JsonKey(name: 'can_bank', defaultValue: false)
  final bool canBank;
  @JsonKey(name: 'can_see_history', defaultValue: false)
  final bool canSeeHistory;
  @JsonKey(name: 'can_cancel', defaultValue: false)
  final bool canCancel;
  @JsonKey(name: 'can_manage_sellers', defaultValue: false)
  final bool canManageSellers;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  static const fromJsonFactory = _$SellerFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Seller &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.storeId, storeId) ||
                const DeepCollectionEquality().equals(
                  other.storeId,
                  storeId,
                )) &&
            (identical(other.canBank, canBank) ||
                const DeepCollectionEquality().equals(
                  other.canBank,
                  canBank,
                )) &&
            (identical(other.canSeeHistory, canSeeHistory) ||
                const DeepCollectionEquality().equals(
                  other.canSeeHistory,
                  canSeeHistory,
                )) &&
            (identical(other.canCancel, canCancel) ||
                const DeepCollectionEquality().equals(
                  other.canCancel,
                  canCancel,
                )) &&
            (identical(other.canManageSellers, canManageSellers) ||
                const DeepCollectionEquality().equals(
                  other.canManageSellers,
                  canManageSellers,
                )) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(storeId) ^
      const DeepCollectionEquality().hash(canBank) ^
      const DeepCollectionEquality().hash(canSeeHistory) ^
      const DeepCollectionEquality().hash(canCancel) ^
      const DeepCollectionEquality().hash(canManageSellers) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $SellerExtension on Seller {
  Seller copyWith({
    String? userId,
    String? storeId,
    bool? canBank,
    bool? canSeeHistory,
    bool? canCancel,
    bool? canManageSellers,
    CoreUserSimple? user,
  }) {
    return Seller(
      userId: userId ?? this.userId,
      storeId: storeId ?? this.storeId,
      canBank: canBank ?? this.canBank,
      canSeeHistory: canSeeHistory ?? this.canSeeHistory,
      canCancel: canCancel ?? this.canCancel,
      canManageSellers: canManageSellers ?? this.canManageSellers,
      user: user ?? this.user,
    );
  }

  Seller copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? storeId,
    Wrapped<bool>? canBank,
    Wrapped<bool>? canSeeHistory,
    Wrapped<bool>? canCancel,
    Wrapped<bool>? canManageSellers,
    Wrapped<CoreUserSimple>? user,
  }) {
    return Seller(
      userId: (userId != null ? userId.value : this.userId),
      storeId: (storeId != null ? storeId.value : this.storeId),
      canBank: (canBank != null ? canBank.value : this.canBank),
      canSeeHistory:
          (canSeeHistory != null ? canSeeHistory.value : this.canSeeHistory),
      canCancel: (canCancel != null ? canCancel.value : this.canCancel),
      canManageSellers:
          (canManageSellers != null
              ? canManageSellers.value
              : this.canManageSellers),
      user: (user != null ? user.value : this.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SellerBase {
  const SellerBase({
    required this.name,
    required this.groupId,
    required this.order,
  });

  factory SellerBase.fromJson(Map<String, dynamic> json) =>
      _$SellerBaseFromJson(json);

  static const toJsonFactory = _$SellerBaseToJson;
  Map<String, dynamic> toJson() => _$SellerBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  @JsonKey(name: 'order', defaultValue: 0)
  final int order;
  static const fromJsonFactory = _$SellerBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SellerBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(
                  other.groupId,
                  groupId,
                )) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(order) ^
      runtimeType.hashCode;
}

extension $SellerBaseExtension on SellerBase {
  SellerBase copyWith({String? name, String? groupId, int? order}) {
    return SellerBase(
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      order: order ?? this.order,
    );
  }

  SellerBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupId,
    Wrapped<int>? order,
  }) {
    return SellerBase(
      name: (name != null ? name.value : this.name),
      groupId: (groupId != null ? groupId.value : this.groupId),
      order: (order != null ? order.value : this.order),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SellerComplete {
  const SellerComplete({
    required this.name,
    required this.groupId,
    required this.order,
    required this.id,
  });

  factory SellerComplete.fromJson(Map<String, dynamic> json) =>
      _$SellerCompleteFromJson(json);

  static const toJsonFactory = _$SellerCompleteToJson;
  Map<String, dynamic> toJson() => _$SellerCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  @JsonKey(name: 'order', defaultValue: 0)
  final int order;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$SellerCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SellerComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(
                  other.groupId,
                  groupId,
                )) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(order) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $SellerCompleteExtension on SellerComplete {
  SellerComplete copyWith({
    String? name,
    String? groupId,
    int? order,
    String? id,
  }) {
    return SellerComplete(
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      order: order ?? this.order,
      id: id ?? this.id,
    );
  }

  SellerComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? groupId,
    Wrapped<int>? order,
    Wrapped<String>? id,
  }) {
    return SellerComplete(
      name: (name != null ? name.value : this.name),
      groupId: (groupId != null ? groupId.value : this.groupId),
      order: (order != null ? order.value : this.order),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SellerCreation {
  const SellerCreation({
    required this.userId,
    required this.canBank,
    required this.canSeeHistory,
    required this.canCancel,
    required this.canManageSellers,
  });

  factory SellerCreation.fromJson(Map<String, dynamic> json) =>
      _$SellerCreationFromJson(json);

  static const toJsonFactory = _$SellerCreationToJson;
  Map<String, dynamic> toJson() => _$SellerCreationToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'can_bank', defaultValue: false)
  final bool canBank;
  @JsonKey(name: 'can_see_history', defaultValue: false)
  final bool canSeeHistory;
  @JsonKey(name: 'can_cancel', defaultValue: false)
  final bool canCancel;
  @JsonKey(name: 'can_manage_sellers', defaultValue: false)
  final bool canManageSellers;
  static const fromJsonFactory = _$SellerCreationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SellerCreation &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.canBank, canBank) ||
                const DeepCollectionEquality().equals(
                  other.canBank,
                  canBank,
                )) &&
            (identical(other.canSeeHistory, canSeeHistory) ||
                const DeepCollectionEquality().equals(
                  other.canSeeHistory,
                  canSeeHistory,
                )) &&
            (identical(other.canCancel, canCancel) ||
                const DeepCollectionEquality().equals(
                  other.canCancel,
                  canCancel,
                )) &&
            (identical(other.canManageSellers, canManageSellers) ||
                const DeepCollectionEquality().equals(
                  other.canManageSellers,
                  canManageSellers,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(canBank) ^
      const DeepCollectionEquality().hash(canSeeHistory) ^
      const DeepCollectionEquality().hash(canCancel) ^
      const DeepCollectionEquality().hash(canManageSellers) ^
      runtimeType.hashCode;
}

extension $SellerCreationExtension on SellerCreation {
  SellerCreation copyWith({
    String? userId,
    bool? canBank,
    bool? canSeeHistory,
    bool? canCancel,
    bool? canManageSellers,
  }) {
    return SellerCreation(
      userId: userId ?? this.userId,
      canBank: canBank ?? this.canBank,
      canSeeHistory: canSeeHistory ?? this.canSeeHistory,
      canCancel: canCancel ?? this.canCancel,
      canManageSellers: canManageSellers ?? this.canManageSellers,
    );
  }

  SellerCreation copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<bool>? canBank,
    Wrapped<bool>? canSeeHistory,
    Wrapped<bool>? canCancel,
    Wrapped<bool>? canManageSellers,
  }) {
    return SellerCreation(
      userId: (userId != null ? userId.value : this.userId),
      canBank: (canBank != null ? canBank.value : this.canBank),
      canSeeHistory:
          (canSeeHistory != null ? canSeeHistory.value : this.canSeeHistory),
      canCancel: (canCancel != null ? canCancel.value : this.canCancel),
      canManageSellers:
          (canManageSellers != null
              ? canManageSellers.value
              : this.canManageSellers),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SellerEdit {
  const SellerEdit({this.name, this.groupId, this.order});

  factory SellerEdit.fromJson(Map<String, dynamic> json) =>
      _$SellerEditFromJson(json);

  static const toJsonFactory = _$SellerEditToJson;
  Map<String, dynamic> toJson() => _$SellerEditToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'group_id')
  final String? groupId;
  @JsonKey(name: 'order')
  final int? order;
  static const fromJsonFactory = _$SellerEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SellerEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(
                  other.groupId,
                  groupId,
                )) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groupId) ^
      const DeepCollectionEquality().hash(order) ^
      runtimeType.hashCode;
}

extension $SellerEditExtension on SellerEdit {
  SellerEdit copyWith({String? name, String? groupId, int? order}) {
    return SellerEdit(
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      order: order ?? this.order,
    );
  }

  SellerEdit copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? groupId,
    Wrapped<int?>? order,
  }) {
    return SellerEdit(
      name: (name != null ? name.value : this.name),
      groupId: (groupId != null ? groupId.value : this.groupId),
      order: (order != null ? order.value : this.order),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SellerUpdate {
  const SellerUpdate({
    this.canBank,
    this.canSeeHistory,
    this.canCancel,
    this.canManageSellers,
  });

  factory SellerUpdate.fromJson(Map<String, dynamic> json) =>
      _$SellerUpdateFromJson(json);

  static const toJsonFactory = _$SellerUpdateToJson;
  Map<String, dynamic> toJson() => _$SellerUpdateToJson(this);

  @JsonKey(name: 'can_bank')
  final bool? canBank;
  @JsonKey(name: 'can_see_history')
  final bool? canSeeHistory;
  @JsonKey(name: 'can_cancel')
  final bool? canCancel;
  @JsonKey(name: 'can_manage_sellers')
  final bool? canManageSellers;
  static const fromJsonFactory = _$SellerUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SellerUpdate &&
            (identical(other.canBank, canBank) ||
                const DeepCollectionEquality().equals(
                  other.canBank,
                  canBank,
                )) &&
            (identical(other.canSeeHistory, canSeeHistory) ||
                const DeepCollectionEquality().equals(
                  other.canSeeHistory,
                  canSeeHistory,
                )) &&
            (identical(other.canCancel, canCancel) ||
                const DeepCollectionEquality().equals(
                  other.canCancel,
                  canCancel,
                )) &&
            (identical(other.canManageSellers, canManageSellers) ||
                const DeepCollectionEquality().equals(
                  other.canManageSellers,
                  canManageSellers,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(canBank) ^
      const DeepCollectionEquality().hash(canSeeHistory) ^
      const DeepCollectionEquality().hash(canCancel) ^
      const DeepCollectionEquality().hash(canManageSellers) ^
      runtimeType.hashCode;
}

extension $SellerUpdateExtension on SellerUpdate {
  SellerUpdate copyWith({
    bool? canBank,
    bool? canSeeHistory,
    bool? canCancel,
    bool? canManageSellers,
  }) {
    return SellerUpdate(
      canBank: canBank ?? this.canBank,
      canSeeHistory: canSeeHistory ?? this.canSeeHistory,
      canCancel: canCancel ?? this.canCancel,
      canManageSellers: canManageSellers ?? this.canManageSellers,
    );
  }

  SellerUpdate copyWithWrapped({
    Wrapped<bool?>? canBank,
    Wrapped<bool?>? canSeeHistory,
    Wrapped<bool?>? canCancel,
    Wrapped<bool?>? canManageSellers,
  }) {
    return SellerUpdate(
      canBank: (canBank != null ? canBank.value : this.canBank),
      canSeeHistory:
          (canSeeHistory != null ? canSeeHistory.value : this.canSeeHistory),
      canCancel: (canCancel != null ? canCancel.value : this.canCancel),
      canManageSellers:
          (canManageSellers != null
              ? canManageSellers.value
              : this.canManageSellers),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SignatureBase {
  const SignatureBase({required this.signatureType, this.numericSignatureId});

  factory SignatureBase.fromJson(Map<String, dynamic> json) =>
      _$SignatureBaseFromJson(json);

  static const toJsonFactory = _$SignatureBaseToJson;
  Map<String, dynamic> toJson() => _$SignatureBaseToJson(this);

  @JsonKey(
    name: 'signature_type',
    toJson: documentSignatureTypeToJson,
    fromJson: documentSignatureTypeFromJson,
  )
  final enums.DocumentSignatureType signatureType;
  @JsonKey(name: 'numeric_signature_id')
  final String? numericSignatureId;
  static const fromJsonFactory = _$SignatureBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SignatureBase &&
            (identical(other.signatureType, signatureType) ||
                const DeepCollectionEquality().equals(
                  other.signatureType,
                  signatureType,
                )) &&
            (identical(other.numericSignatureId, numericSignatureId) ||
                const DeepCollectionEquality().equals(
                  other.numericSignatureId,
                  numericSignatureId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(signatureType) ^
      const DeepCollectionEquality().hash(numericSignatureId) ^
      runtimeType.hashCode;
}

extension $SignatureBaseExtension on SignatureBase {
  SignatureBase copyWith({
    enums.DocumentSignatureType? signatureType,
    String? numericSignatureId,
  }) {
    return SignatureBase(
      signatureType: signatureType ?? this.signatureType,
      numericSignatureId: numericSignatureId ?? this.numericSignatureId,
    );
  }

  SignatureBase copyWithWrapped({
    Wrapped<enums.DocumentSignatureType>? signatureType,
    Wrapped<String?>? numericSignatureId,
  }) {
    return SignatureBase(
      signatureType:
          (signatureType != null ? signatureType.value : this.signatureType),
      numericSignatureId:
          (numericSignatureId != null
              ? numericSignatureId.value
              : this.numericSignatureId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SignatureComplete {
  const SignatureComplete({
    required this.signatureType,
    this.numericSignatureId,
    required this.userId,
    required this.documentId,
  });

  factory SignatureComplete.fromJson(Map<String, dynamic> json) =>
      _$SignatureCompleteFromJson(json);

  static const toJsonFactory = _$SignatureCompleteToJson;
  Map<String, dynamic> toJson() => _$SignatureCompleteToJson(this);

  @JsonKey(
    name: 'signature_type',
    toJson: documentSignatureTypeToJson,
    fromJson: documentSignatureTypeFromJson,
  )
  final enums.DocumentSignatureType signatureType;
  @JsonKey(name: 'numeric_signature_id')
  final String? numericSignatureId;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'document_id', defaultValue: '')
  final String documentId;
  static const fromJsonFactory = _$SignatureCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SignatureComplete &&
            (identical(other.signatureType, signatureType) ||
                const DeepCollectionEquality().equals(
                  other.signatureType,
                  signatureType,
                )) &&
            (identical(other.numericSignatureId, numericSignatureId) ||
                const DeepCollectionEquality().equals(
                  other.numericSignatureId,
                  numericSignatureId,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.documentId, documentId) ||
                const DeepCollectionEquality().equals(
                  other.documentId,
                  documentId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(signatureType) ^
      const DeepCollectionEquality().hash(numericSignatureId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(documentId) ^
      runtimeType.hashCode;
}

extension $SignatureCompleteExtension on SignatureComplete {
  SignatureComplete copyWith({
    enums.DocumentSignatureType? signatureType,
    String? numericSignatureId,
    String? userId,
    String? documentId,
  }) {
    return SignatureComplete(
      signatureType: signatureType ?? this.signatureType,
      numericSignatureId: numericSignatureId ?? this.numericSignatureId,
      userId: userId ?? this.userId,
      documentId: documentId ?? this.documentId,
    );
  }

  SignatureComplete copyWithWrapped({
    Wrapped<enums.DocumentSignatureType>? signatureType,
    Wrapped<String?>? numericSignatureId,
    Wrapped<String>? userId,
    Wrapped<String>? documentId,
  }) {
    return SignatureComplete(
      signatureType:
          (signatureType != null ? signatureType.value : this.signatureType),
      numericSignatureId:
          (numericSignatureId != null
              ? numericSignatureId.value
              : this.numericSignatureId),
      userId: (userId != null ? userId.value : this.userId),
      documentId: (documentId != null ? documentId.value : this.documentId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SpeciesBase {
  const SpeciesBase({
    required this.prefix,
    required this.name,
    required this.difficulty,
    required this.speciesType,
    this.card,
    this.nbSeedsRecommended,
    this.startSeason,
    this.endSeason,
    this.timeMaturation,
  });

  factory SpeciesBase.fromJson(Map<String, dynamic> json) =>
      _$SpeciesBaseFromJson(json);

  static const toJsonFactory = _$SpeciesBaseToJson;
  Map<String, dynamic> toJson() => _$SpeciesBaseToJson(this);

  @JsonKey(name: 'prefix', defaultValue: '')
  final String prefix;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'difficulty', defaultValue: 0)
  final int difficulty;
  @JsonKey(
    name: 'species_type',
    toJson: speciesTypeToJson,
    fromJson: speciesTypeFromJson,
  )
  final enums.SpeciesType speciesType;
  @JsonKey(name: 'card')
  final String? card;
  @JsonKey(name: 'nb_seeds_recommended')
  final int? nbSeedsRecommended;
  @JsonKey(name: 'start_season')
  final String? startSeason;
  @JsonKey(name: 'end_season')
  final String? endSeason;
  @JsonKey(name: 'time_maturation')
  final int? timeMaturation;
  static const fromJsonFactory = _$SpeciesBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SpeciesBase &&
            (identical(other.prefix, prefix) ||
                const DeepCollectionEquality().equals(other.prefix, prefix)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality().equals(
                  other.difficulty,
                  difficulty,
                )) &&
            (identical(other.speciesType, speciesType) ||
                const DeepCollectionEquality().equals(
                  other.speciesType,
                  speciesType,
                )) &&
            (identical(other.card, card) ||
                const DeepCollectionEquality().equals(other.card, card)) &&
            (identical(other.nbSeedsRecommended, nbSeedsRecommended) ||
                const DeepCollectionEquality().equals(
                  other.nbSeedsRecommended,
                  nbSeedsRecommended,
                )) &&
            (identical(other.startSeason, startSeason) ||
                const DeepCollectionEquality().equals(
                  other.startSeason,
                  startSeason,
                )) &&
            (identical(other.endSeason, endSeason) ||
                const DeepCollectionEquality().equals(
                  other.endSeason,
                  endSeason,
                )) &&
            (identical(other.timeMaturation, timeMaturation) ||
                const DeepCollectionEquality().equals(
                  other.timeMaturation,
                  timeMaturation,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(prefix) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(speciesType) ^
      const DeepCollectionEquality().hash(card) ^
      const DeepCollectionEquality().hash(nbSeedsRecommended) ^
      const DeepCollectionEquality().hash(startSeason) ^
      const DeepCollectionEquality().hash(endSeason) ^
      const DeepCollectionEquality().hash(timeMaturation) ^
      runtimeType.hashCode;
}

extension $SpeciesBaseExtension on SpeciesBase {
  SpeciesBase copyWith({
    String? prefix,
    String? name,
    int? difficulty,
    enums.SpeciesType? speciesType,
    String? card,
    int? nbSeedsRecommended,
    String? startSeason,
    String? endSeason,
    int? timeMaturation,
  }) {
    return SpeciesBase(
      prefix: prefix ?? this.prefix,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      speciesType: speciesType ?? this.speciesType,
      card: card ?? this.card,
      nbSeedsRecommended: nbSeedsRecommended ?? this.nbSeedsRecommended,
      startSeason: startSeason ?? this.startSeason,
      endSeason: endSeason ?? this.endSeason,
      timeMaturation: timeMaturation ?? this.timeMaturation,
    );
  }

  SpeciesBase copyWithWrapped({
    Wrapped<String>? prefix,
    Wrapped<String>? name,
    Wrapped<int>? difficulty,
    Wrapped<enums.SpeciesType>? speciesType,
    Wrapped<String?>? card,
    Wrapped<int?>? nbSeedsRecommended,
    Wrapped<String?>? startSeason,
    Wrapped<String?>? endSeason,
    Wrapped<int?>? timeMaturation,
  }) {
    return SpeciesBase(
      prefix: (prefix != null ? prefix.value : this.prefix),
      name: (name != null ? name.value : this.name),
      difficulty: (difficulty != null ? difficulty.value : this.difficulty),
      speciesType: (speciesType != null ? speciesType.value : this.speciesType),
      card: (card != null ? card.value : this.card),
      nbSeedsRecommended:
          (nbSeedsRecommended != null
              ? nbSeedsRecommended.value
              : this.nbSeedsRecommended),
      startSeason: (startSeason != null ? startSeason.value : this.startSeason),
      endSeason: (endSeason != null ? endSeason.value : this.endSeason),
      timeMaturation:
          (timeMaturation != null ? timeMaturation.value : this.timeMaturation),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SpeciesComplete {
  const SpeciesComplete({
    required this.prefix,
    required this.name,
    required this.difficulty,
    required this.speciesType,
    this.card,
    this.nbSeedsRecommended,
    this.startSeason,
    this.endSeason,
    this.timeMaturation,
    required this.id,
  });

  factory SpeciesComplete.fromJson(Map<String, dynamic> json) =>
      _$SpeciesCompleteFromJson(json);

  static const toJsonFactory = _$SpeciesCompleteToJson;
  Map<String, dynamic> toJson() => _$SpeciesCompleteToJson(this);

  @JsonKey(name: 'prefix', defaultValue: '')
  final String prefix;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'difficulty', defaultValue: 0)
  final int difficulty;
  @JsonKey(
    name: 'species_type',
    toJson: speciesTypeToJson,
    fromJson: speciesTypeFromJson,
  )
  final enums.SpeciesType speciesType;
  @JsonKey(name: 'card')
  final String? card;
  @JsonKey(name: 'nb_seeds_recommended')
  final int? nbSeedsRecommended;
  @JsonKey(name: 'start_season')
  final String? startSeason;
  @JsonKey(name: 'end_season')
  final String? endSeason;
  @JsonKey(name: 'time_maturation')
  final int? timeMaturation;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$SpeciesCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SpeciesComplete &&
            (identical(other.prefix, prefix) ||
                const DeepCollectionEquality().equals(other.prefix, prefix)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality().equals(
                  other.difficulty,
                  difficulty,
                )) &&
            (identical(other.speciesType, speciesType) ||
                const DeepCollectionEquality().equals(
                  other.speciesType,
                  speciesType,
                )) &&
            (identical(other.card, card) ||
                const DeepCollectionEquality().equals(other.card, card)) &&
            (identical(other.nbSeedsRecommended, nbSeedsRecommended) ||
                const DeepCollectionEquality().equals(
                  other.nbSeedsRecommended,
                  nbSeedsRecommended,
                )) &&
            (identical(other.startSeason, startSeason) ||
                const DeepCollectionEquality().equals(
                  other.startSeason,
                  startSeason,
                )) &&
            (identical(other.endSeason, endSeason) ||
                const DeepCollectionEquality().equals(
                  other.endSeason,
                  endSeason,
                )) &&
            (identical(other.timeMaturation, timeMaturation) ||
                const DeepCollectionEquality().equals(
                  other.timeMaturation,
                  timeMaturation,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(prefix) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(speciesType) ^
      const DeepCollectionEquality().hash(card) ^
      const DeepCollectionEquality().hash(nbSeedsRecommended) ^
      const DeepCollectionEquality().hash(startSeason) ^
      const DeepCollectionEquality().hash(endSeason) ^
      const DeepCollectionEquality().hash(timeMaturation) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $SpeciesCompleteExtension on SpeciesComplete {
  SpeciesComplete copyWith({
    String? prefix,
    String? name,
    int? difficulty,
    enums.SpeciesType? speciesType,
    String? card,
    int? nbSeedsRecommended,
    String? startSeason,
    String? endSeason,
    int? timeMaturation,
    String? id,
  }) {
    return SpeciesComplete(
      prefix: prefix ?? this.prefix,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      speciesType: speciesType ?? this.speciesType,
      card: card ?? this.card,
      nbSeedsRecommended: nbSeedsRecommended ?? this.nbSeedsRecommended,
      startSeason: startSeason ?? this.startSeason,
      endSeason: endSeason ?? this.endSeason,
      timeMaturation: timeMaturation ?? this.timeMaturation,
      id: id ?? this.id,
    );
  }

  SpeciesComplete copyWithWrapped({
    Wrapped<String>? prefix,
    Wrapped<String>? name,
    Wrapped<int>? difficulty,
    Wrapped<enums.SpeciesType>? speciesType,
    Wrapped<String?>? card,
    Wrapped<int?>? nbSeedsRecommended,
    Wrapped<String?>? startSeason,
    Wrapped<String?>? endSeason,
    Wrapped<int?>? timeMaturation,
    Wrapped<String>? id,
  }) {
    return SpeciesComplete(
      prefix: (prefix != null ? prefix.value : this.prefix),
      name: (name != null ? name.value : this.name),
      difficulty: (difficulty != null ? difficulty.value : this.difficulty),
      speciesType: (speciesType != null ? speciesType.value : this.speciesType),
      card: (card != null ? card.value : this.card),
      nbSeedsRecommended:
          (nbSeedsRecommended != null
              ? nbSeedsRecommended.value
              : this.nbSeedsRecommended),
      startSeason: (startSeason != null ? startSeason.value : this.startSeason),
      endSeason: (endSeason != null ? endSeason.value : this.endSeason),
      timeMaturation:
          (timeMaturation != null ? timeMaturation.value : this.timeMaturation),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SpeciesEdit {
  const SpeciesEdit({
    this.name,
    this.prefix,
    this.difficulty,
    this.card,
    this.speciesType,
    this.nbSeedsRecommended,
    this.startSeason,
    this.endSeason,
    this.timeMaturation,
  });

  factory SpeciesEdit.fromJson(Map<String, dynamic> json) =>
      _$SpeciesEditFromJson(json);

  static const toJsonFactory = _$SpeciesEditToJson;
  Map<String, dynamic> toJson() => _$SpeciesEditToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'prefix')
  final String? prefix;
  @JsonKey(name: 'difficulty')
  final int? difficulty;
  @JsonKey(name: 'card')
  final String? card;
  @JsonKey(
    name: 'species_type',
    toJson: speciesTypeNullableToJson,
    fromJson: speciesTypeNullableFromJson,
  )
  final enums.SpeciesType? speciesType;
  @JsonKey(name: 'nb_seeds_recommended')
  final int? nbSeedsRecommended;
  @JsonKey(name: 'start_season')
  final String? startSeason;
  @JsonKey(name: 'end_season')
  final String? endSeason;
  @JsonKey(name: 'time_maturation')
  final int? timeMaturation;
  static const fromJsonFactory = _$SpeciesEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SpeciesEdit &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.prefix, prefix) ||
                const DeepCollectionEquality().equals(other.prefix, prefix)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality().equals(
                  other.difficulty,
                  difficulty,
                )) &&
            (identical(other.card, card) ||
                const DeepCollectionEquality().equals(other.card, card)) &&
            (identical(other.speciesType, speciesType) ||
                const DeepCollectionEquality().equals(
                  other.speciesType,
                  speciesType,
                )) &&
            (identical(other.nbSeedsRecommended, nbSeedsRecommended) ||
                const DeepCollectionEquality().equals(
                  other.nbSeedsRecommended,
                  nbSeedsRecommended,
                )) &&
            (identical(other.startSeason, startSeason) ||
                const DeepCollectionEquality().equals(
                  other.startSeason,
                  startSeason,
                )) &&
            (identical(other.endSeason, endSeason) ||
                const DeepCollectionEquality().equals(
                  other.endSeason,
                  endSeason,
                )) &&
            (identical(other.timeMaturation, timeMaturation) ||
                const DeepCollectionEquality().equals(
                  other.timeMaturation,
                  timeMaturation,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(prefix) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(card) ^
      const DeepCollectionEquality().hash(speciesType) ^
      const DeepCollectionEquality().hash(nbSeedsRecommended) ^
      const DeepCollectionEquality().hash(startSeason) ^
      const DeepCollectionEquality().hash(endSeason) ^
      const DeepCollectionEquality().hash(timeMaturation) ^
      runtimeType.hashCode;
}

extension $SpeciesEditExtension on SpeciesEdit {
  SpeciesEdit copyWith({
    String? name,
    String? prefix,
    int? difficulty,
    String? card,
    enums.SpeciesType? speciesType,
    int? nbSeedsRecommended,
    String? startSeason,
    String? endSeason,
    int? timeMaturation,
  }) {
    return SpeciesEdit(
      name: name ?? this.name,
      prefix: prefix ?? this.prefix,
      difficulty: difficulty ?? this.difficulty,
      card: card ?? this.card,
      speciesType: speciesType ?? this.speciesType,
      nbSeedsRecommended: nbSeedsRecommended ?? this.nbSeedsRecommended,
      startSeason: startSeason ?? this.startSeason,
      endSeason: endSeason ?? this.endSeason,
      timeMaturation: timeMaturation ?? this.timeMaturation,
    );
  }

  SpeciesEdit copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? prefix,
    Wrapped<int?>? difficulty,
    Wrapped<String?>? card,
    Wrapped<enums.SpeciesType?>? speciesType,
    Wrapped<int?>? nbSeedsRecommended,
    Wrapped<String?>? startSeason,
    Wrapped<String?>? endSeason,
    Wrapped<int?>? timeMaturation,
  }) {
    return SpeciesEdit(
      name: (name != null ? name.value : this.name),
      prefix: (prefix != null ? prefix.value : this.prefix),
      difficulty: (difficulty != null ? difficulty.value : this.difficulty),
      card: (card != null ? card.value : this.card),
      speciesType: (speciesType != null ? speciesType.value : this.speciesType),
      nbSeedsRecommended:
          (nbSeedsRecommended != null
              ? nbSeedsRecommended.value
              : this.nbSeedsRecommended),
      startSeason: (startSeason != null ? startSeason.value : this.startSeason),
      endSeason: (endSeason != null ? endSeason.value : this.endSeason),
      timeMaturation:
          (timeMaturation != null ? timeMaturation.value : this.timeMaturation),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SpeciesTypesReturn {
  const SpeciesTypesReturn({required this.speciesType});

  factory SpeciesTypesReturn.fromJson(Map<String, dynamic> json) =>
      _$SpeciesTypesReturnFromJson(json);

  static const toJsonFactory = _$SpeciesTypesReturnToJson;
  Map<String, dynamic> toJson() => _$SpeciesTypesReturnToJson(this);

  @JsonKey(
    name: 'species_type',
    defaultValue: <enums.SpeciesType>[],
    toJson: speciesTypeListToJson,
    fromJson: speciesTypeListFromJson,
  )
  final List<enums.SpeciesType> speciesType;
  static const fromJsonFactory = _$SpeciesTypesReturnFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SpeciesTypesReturn &&
            (identical(other.speciesType, speciesType) ||
                const DeepCollectionEquality().equals(
                  other.speciesType,
                  speciesType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(speciesType) ^ runtimeType.hashCode;
}

extension $SpeciesTypesReturnExtension on SpeciesTypesReturn {
  SpeciesTypesReturn copyWith({List<enums.SpeciesType>? speciesType}) {
    return SpeciesTypesReturn(speciesType: speciesType ?? this.speciesType);
  }

  SpeciesTypesReturn copyWithWrapped({
    Wrapped<List<enums.SpeciesType>>? speciesType,
  }) {
    return SpeciesTypesReturn(
      speciesType: (speciesType != null ? speciesType.value : this.speciesType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Status {
  const Status({this.status});

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  static const toJsonFactory = _$StatusToJson;
  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @JsonKey(
    name: 'status',
    toJson: cdrStatusNullableToJson,
    fromJson: cdrStatusStatusNullableFromJson,
  )
  final enums.CdrStatus? status;
  static enums.CdrStatus? cdrStatusStatusNullableFromJson(Object? value) =>
      cdrStatusNullableFromJson(value, enums.CdrStatus.pending);

  static const fromJsonFactory = _$StatusFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Status &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $StatusExtension on Status {
  Status copyWith({enums.CdrStatus? status}) {
    return Status(status: status ?? this.status);
  }

  Status copyWithWrapped({Wrapped<enums.CdrStatus?>? status}) {
    return Status(status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class Store {
  const Store({
    required this.name,
    required this.id,
    required this.structureId,
    required this.walletId,
    required this.structure,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  static const toJsonFactory = _$StoreToJson;
  Map<String, dynamic> toJson() => _$StoreToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'structure_id', defaultValue: '')
  final String structureId;
  @JsonKey(name: 'wallet_id', defaultValue: '')
  final String walletId;
  @JsonKey(name: 'structure')
  final Structure structure;
  static const fromJsonFactory = _$StoreFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Store &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.structureId, structureId) ||
                const DeepCollectionEquality().equals(
                  other.structureId,
                  structureId,
                )) &&
            (identical(other.walletId, walletId) ||
                const DeepCollectionEquality().equals(
                  other.walletId,
                  walletId,
                )) &&
            (identical(other.structure, structure) ||
                const DeepCollectionEquality().equals(
                  other.structure,
                  structure,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(structureId) ^
      const DeepCollectionEquality().hash(walletId) ^
      const DeepCollectionEquality().hash(structure) ^
      runtimeType.hashCode;
}

extension $StoreExtension on Store {
  Store copyWith({
    String? name,
    String? id,
    String? structureId,
    String? walletId,
    Structure? structure,
  }) {
    return Store(
      name: name ?? this.name,
      id: id ?? this.id,
      structureId: structureId ?? this.structureId,
      walletId: walletId ?? this.walletId,
      structure: structure ?? this.structure,
    );
  }

  Store copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<String>? structureId,
    Wrapped<String>? walletId,
    Wrapped<Structure>? structure,
  }) {
    return Store(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      structureId: (structureId != null ? structureId.value : this.structureId),
      walletId: (walletId != null ? walletId.value : this.walletId),
      structure: (structure != null ? structure.value : this.structure),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class StoreBase {
  const StoreBase({required this.name});

  factory StoreBase.fromJson(Map<String, dynamic> json) =>
      _$StoreBaseFromJson(json);

  static const toJsonFactory = _$StoreBaseToJson;
  Map<String, dynamic> toJson() => _$StoreBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  static const fromJsonFactory = _$StoreBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StoreBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $StoreBaseExtension on StoreBase {
  StoreBase copyWith({String? name}) {
    return StoreBase(name: name ?? this.name);
  }

  StoreBase copyWithWrapped({Wrapped<String>? name}) {
    return StoreBase(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class StoreUpdate {
  const StoreUpdate({this.name});

  factory StoreUpdate.fromJson(Map<String, dynamic> json) =>
      _$StoreUpdateFromJson(json);

  static const toJsonFactory = _$StoreUpdateToJson;
  Map<String, dynamic> toJson() => _$StoreUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$StoreUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StoreUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $StoreUpdateExtension on StoreUpdate {
  StoreUpdate copyWith({String? name}) {
    return StoreUpdate(name: name ?? this.name);
  }

  StoreUpdate copyWithWrapped({Wrapped<String?>? name}) {
    return StoreUpdate(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class Structure {
  const Structure({
    required this.name,
    this.associationMembershipId,
    required this.managerUserId,
    required this.id,
    required this.managerUser,
    required this.associationMembership,
  });

  factory Structure.fromJson(Map<String, dynamic> json) =>
      _$StructureFromJson(json);

  static const toJsonFactory = _$StructureToJson;
  Map<String, dynamic> toJson() => _$StructureToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'association_membership_id')
  final String? associationMembershipId;
  @JsonKey(name: 'manager_user_id', defaultValue: '')
  final String managerUserId;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'manager_user')
  final CoreUserSimple managerUser;
  @JsonKey(name: 'association_membership')
  final MembershipSimple associationMembership;
  static const fromJsonFactory = _$StructureFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Structure &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(
                  other.associationMembershipId,
                  associationMembershipId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.associationMembershipId,
                  associationMembershipId,
                )) &&
            (identical(other.managerUserId, managerUserId) ||
                const DeepCollectionEquality().equals(
                  other.managerUserId,
                  managerUserId,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.managerUser, managerUser) ||
                const DeepCollectionEquality().equals(
                  other.managerUser,
                  managerUser,
                )) &&
            (identical(other.associationMembership, associationMembership) ||
                const DeepCollectionEquality().equals(
                  other.associationMembership,
                  associationMembership,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(associationMembershipId) ^
      const DeepCollectionEquality().hash(managerUserId) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(managerUser) ^
      const DeepCollectionEquality().hash(associationMembership) ^
      runtimeType.hashCode;
}

extension $StructureExtension on Structure {
  Structure copyWith({
    String? name,
    String? associationMembershipId,
    String? managerUserId,
    String? id,
    CoreUserSimple? managerUser,
    MembershipSimple? associationMembership,
  }) {
    return Structure(
      name: name ?? this.name,
      associationMembershipId:
          associationMembershipId ?? this.associationMembershipId,
      managerUserId: managerUserId ?? this.managerUserId,
      id: id ?? this.id,
      managerUser: managerUser ?? this.managerUser,
      associationMembership:
          associationMembership ?? this.associationMembership,
    );
  }

  Structure copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? associationMembershipId,
    Wrapped<String>? managerUserId,
    Wrapped<String>? id,
    Wrapped<CoreUserSimple>? managerUser,
    Wrapped<MembershipSimple>? associationMembership,
  }) {
    return Structure(
      name: (name != null ? name.value : this.name),
      associationMembershipId:
          (associationMembershipId != null
              ? associationMembershipId.value
              : this.associationMembershipId),
      managerUserId:
          (managerUserId != null ? managerUserId.value : this.managerUserId),
      id: (id != null ? id.value : this.id),
      managerUser: (managerUser != null ? managerUser.value : this.managerUser),
      associationMembership:
          (associationMembership != null
              ? associationMembership.value
              : this.associationMembership),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class StructureBase {
  const StructureBase({
    required this.name,
    this.associationMembershipId,
    required this.managerUserId,
  });

  factory StructureBase.fromJson(Map<String, dynamic> json) =>
      _$StructureBaseFromJson(json);

  static const toJsonFactory = _$StructureBaseToJson;
  Map<String, dynamic> toJson() => _$StructureBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'association_membership_id')
  final String? associationMembershipId;
  @JsonKey(name: 'manager_user_id', defaultValue: '')
  final String managerUserId;
  static const fromJsonFactory = _$StructureBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StructureBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(
                  other.associationMembershipId,
                  associationMembershipId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.associationMembershipId,
                  associationMembershipId,
                )) &&
            (identical(other.managerUserId, managerUserId) ||
                const DeepCollectionEquality().equals(
                  other.managerUserId,
                  managerUserId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(associationMembershipId) ^
      const DeepCollectionEquality().hash(managerUserId) ^
      runtimeType.hashCode;
}

extension $StructureBaseExtension on StructureBase {
  StructureBase copyWith({
    String? name,
    String? associationMembershipId,
    String? managerUserId,
  }) {
    return StructureBase(
      name: name ?? this.name,
      associationMembershipId:
          associationMembershipId ?? this.associationMembershipId,
      managerUserId: managerUserId ?? this.managerUserId,
    );
  }

  StructureBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String?>? associationMembershipId,
    Wrapped<String>? managerUserId,
  }) {
    return StructureBase(
      name: (name != null ? name.value : this.name),
      associationMembershipId:
          (associationMembershipId != null
              ? associationMembershipId.value
              : this.associationMembershipId),
      managerUserId:
          (managerUserId != null ? managerUserId.value : this.managerUserId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class StructureTranfert {
  const StructureTranfert({required this.newManagerUserId});

  factory StructureTranfert.fromJson(Map<String, dynamic> json) =>
      _$StructureTranfertFromJson(json);

  static const toJsonFactory = _$StructureTranfertToJson;
  Map<String, dynamic> toJson() => _$StructureTranfertToJson(this);

  @JsonKey(name: 'new_manager_user_id', defaultValue: '')
  final String newManagerUserId;
  static const fromJsonFactory = _$StructureTranfertFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StructureTranfert &&
            (identical(other.newManagerUserId, newManagerUserId) ||
                const DeepCollectionEquality().equals(
                  other.newManagerUserId,
                  newManagerUserId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(newManagerUserId) ^
      runtimeType.hashCode;
}

extension $StructureTranfertExtension on StructureTranfert {
  StructureTranfert copyWith({String? newManagerUserId}) {
    return StructureTranfert(
      newManagerUserId: newManagerUserId ?? this.newManagerUserId,
    );
  }

  StructureTranfert copyWithWrapped({Wrapped<String>? newManagerUserId}) {
    return StructureTranfert(
      newManagerUserId:
          (newManagerUserId != null
              ? newManagerUserId.value
              : this.newManagerUserId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class StructureUpdate {
  const StructureUpdate({this.name, this.associationMembershipId});

  factory StructureUpdate.fromJson(Map<String, dynamic> json) =>
      _$StructureUpdateFromJson(json);

  static const toJsonFactory = _$StructureUpdateToJson;
  Map<String, dynamic> toJson() => _$StructureUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'association_membership_id')
  final String? associationMembershipId;
  static const fromJsonFactory = _$StructureUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StructureUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(
                  other.associationMembershipId,
                  associationMembershipId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.associationMembershipId,
                  associationMembershipId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(associationMembershipId) ^
      runtimeType.hashCode;
}

extension $StructureUpdateExtension on StructureUpdate {
  StructureUpdate copyWith({String? name, String? associationMembershipId}) {
    return StructureUpdate(
      name: name ?? this.name,
      associationMembershipId:
          associationMembershipId ?? this.associationMembershipId,
    );
  }

  StructureUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? associationMembershipId,
  }) {
    return StructureUpdate(
      name: (name != null ? name.value : this.name),
      associationMembershipId:
          (associationMembershipId != null
              ? associationMembershipId.value
              : this.associationMembershipId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TOSSignature {
  const TOSSignature({required this.acceptedTosVersion});

  factory TOSSignature.fromJson(Map<String, dynamic> json) =>
      _$TOSSignatureFromJson(json);

  static const toJsonFactory = _$TOSSignatureToJson;
  Map<String, dynamic> toJson() => _$TOSSignatureToJson(this);

  @JsonKey(name: 'accepted_tos_version', defaultValue: 0)
  final int acceptedTosVersion;
  static const fromJsonFactory = _$TOSSignatureFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TOSSignature &&
            (identical(other.acceptedTosVersion, acceptedTosVersion) ||
                const DeepCollectionEquality().equals(
                  other.acceptedTosVersion,
                  acceptedTosVersion,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(acceptedTosVersion) ^
      runtimeType.hashCode;
}

extension $TOSSignatureExtension on TOSSignature {
  TOSSignature copyWith({int? acceptedTosVersion}) {
    return TOSSignature(
      acceptedTosVersion: acceptedTosVersion ?? this.acceptedTosVersion,
    );
  }

  TOSSignature copyWithWrapped({Wrapped<int>? acceptedTosVersion}) {
    return TOSSignature(
      acceptedTosVersion:
          (acceptedTosVersion != null
              ? acceptedTosVersion.value
              : this.acceptedTosVersion),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TOSSignatureResponse {
  const TOSSignatureResponse({
    required this.acceptedTosVersion,
    required this.latestTosVersion,
    required this.tosContent,
    required this.maxTransactionTotal,
    required this.maxWalletBalance,
  });

  factory TOSSignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$TOSSignatureResponseFromJson(json);

  static const toJsonFactory = _$TOSSignatureResponseToJson;
  Map<String, dynamic> toJson() => _$TOSSignatureResponseToJson(this);

  @JsonKey(name: 'accepted_tos_version', defaultValue: 0)
  final int acceptedTosVersion;
  @JsonKey(name: 'latest_tos_version', defaultValue: 0)
  final int latestTosVersion;
  @JsonKey(name: 'tos_content', defaultValue: '')
  final String tosContent;
  @JsonKey(name: 'max_transaction_total', defaultValue: 0)
  final int maxTransactionTotal;
  @JsonKey(name: 'max_wallet_balance', defaultValue: 0)
  final int maxWalletBalance;
  static const fromJsonFactory = _$TOSSignatureResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TOSSignatureResponse &&
            (identical(other.acceptedTosVersion, acceptedTosVersion) ||
                const DeepCollectionEquality().equals(
                  other.acceptedTosVersion,
                  acceptedTosVersion,
                )) &&
            (identical(other.latestTosVersion, latestTosVersion) ||
                const DeepCollectionEquality().equals(
                  other.latestTosVersion,
                  latestTosVersion,
                )) &&
            (identical(other.tosContent, tosContent) ||
                const DeepCollectionEquality().equals(
                  other.tosContent,
                  tosContent,
                )) &&
            (identical(other.maxTransactionTotal, maxTransactionTotal) ||
                const DeepCollectionEquality().equals(
                  other.maxTransactionTotal,
                  maxTransactionTotal,
                )) &&
            (identical(other.maxWalletBalance, maxWalletBalance) ||
                const DeepCollectionEquality().equals(
                  other.maxWalletBalance,
                  maxWalletBalance,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(acceptedTosVersion) ^
      const DeepCollectionEquality().hash(latestTosVersion) ^
      const DeepCollectionEquality().hash(tosContent) ^
      const DeepCollectionEquality().hash(maxTransactionTotal) ^
      const DeepCollectionEquality().hash(maxWalletBalance) ^
      runtimeType.hashCode;
}

extension $TOSSignatureResponseExtension on TOSSignatureResponse {
  TOSSignatureResponse copyWith({
    int? acceptedTosVersion,
    int? latestTosVersion,
    String? tosContent,
    int? maxTransactionTotal,
    int? maxWalletBalance,
  }) {
    return TOSSignatureResponse(
      acceptedTosVersion: acceptedTosVersion ?? this.acceptedTosVersion,
      latestTosVersion: latestTosVersion ?? this.latestTosVersion,
      tosContent: tosContent ?? this.tosContent,
      maxTransactionTotal: maxTransactionTotal ?? this.maxTransactionTotal,
      maxWalletBalance: maxWalletBalance ?? this.maxWalletBalance,
    );
  }

  TOSSignatureResponse copyWithWrapped({
    Wrapped<int>? acceptedTosVersion,
    Wrapped<int>? latestTosVersion,
    Wrapped<String>? tosContent,
    Wrapped<int>? maxTransactionTotal,
    Wrapped<int>? maxWalletBalance,
  }) {
    return TOSSignatureResponse(
      acceptedTosVersion:
          (acceptedTosVersion != null
              ? acceptedTosVersion.value
              : this.acceptedTosVersion),
      latestTosVersion:
          (latestTosVersion != null
              ? latestTosVersion.value
              : this.latestTosVersion),
      tosContent: (tosContent != null ? tosContent.value : this.tosContent),
      maxTransactionTotal:
          (maxTransactionTotal != null
              ? maxTransactionTotal.value
              : this.maxTransactionTotal),
      maxWalletBalance:
          (maxWalletBalance != null
              ? maxWalletBalance.value
              : this.maxWalletBalance),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Team {
  const Team({
    required this.name,
    required this.id,
    required this.number,
    required this.captain,
    required this.second,
    required this.difficulty,
    required this.meetingPlace,
    required this.validationProgress,
    required this.fileId,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  static const toJsonFactory = _$TeamToJson;
  Map<String, dynamic> toJson() => _$TeamToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'number')
  final int number;
  @JsonKey(name: 'captain')
  final Participant captain;
  @JsonKey(name: 'second')
  final Participant second;
  @JsonKey(
    name: 'difficulty',
    toJson: difficultyToJson,
    fromJson: difficultyFromJson,
  )
  final enums.Difficulty difficulty;
  @JsonKey(
    name: 'meeting_place',
    toJson: meetingPlaceToJson,
    fromJson: meetingPlaceFromJson,
  )
  final enums.MeetingPlace meetingPlace;
  @JsonKey(name: 'validation_progress', defaultValue: 0.0)
  final double validationProgress;
  @JsonKey(name: 'file_id')
  final String fileId;
  static const fromJsonFactory = _$TeamFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Team &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.captain, captain) ||
                const DeepCollectionEquality().equals(
                  other.captain,
                  captain,
                )) &&
            (identical(other.second, second) ||
                const DeepCollectionEquality().equals(other.second, second)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality().equals(
                  other.difficulty,
                  difficulty,
                )) &&
            (identical(other.meetingPlace, meetingPlace) ||
                const DeepCollectionEquality().equals(
                  other.meetingPlace,
                  meetingPlace,
                )) &&
            (identical(other.validationProgress, validationProgress) ||
                const DeepCollectionEquality().equals(
                  other.validationProgress,
                  validationProgress,
                )) &&
            (identical(other.fileId, fileId) ||
                const DeepCollectionEquality().equals(other.fileId, fileId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(captain) ^
      const DeepCollectionEquality().hash(second) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(meetingPlace) ^
      const DeepCollectionEquality().hash(validationProgress) ^
      const DeepCollectionEquality().hash(fileId) ^
      runtimeType.hashCode;
}

extension $TeamExtension on Team {
  Team copyWith({
    String? name,
    String? id,
    int? number,
    Participant? captain,
    Participant? second,
    enums.Difficulty? difficulty,
    enums.MeetingPlace? meetingPlace,
    double? validationProgress,
    String? fileId,
  }) {
    return Team(
      name: name ?? this.name,
      id: id ?? this.id,
      number: number ?? this.number,
      captain: captain ?? this.captain,
      second: second ?? this.second,
      difficulty: difficulty ?? this.difficulty,
      meetingPlace: meetingPlace ?? this.meetingPlace,
      validationProgress: validationProgress ?? this.validationProgress,
      fileId: fileId ?? this.fileId,
    );
  }

  Team copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<int>? number,
    Wrapped<Participant>? captain,
    Wrapped<Participant>? second,
    Wrapped<enums.Difficulty>? difficulty,
    Wrapped<enums.MeetingPlace>? meetingPlace,
    Wrapped<double>? validationProgress,
    Wrapped<String>? fileId,
  }) {
    return Team(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      number: (number != null ? number.value : this.number),
      captain: (captain != null ? captain.value : this.captain),
      second: (second != null ? second.value : this.second),
      difficulty: (difficulty != null ? difficulty.value : this.difficulty),
      meetingPlace:
          (meetingPlace != null ? meetingPlace.value : this.meetingPlace),
      validationProgress:
          (validationProgress != null
              ? validationProgress.value
              : this.validationProgress),
      fileId: (fileId != null ? fileId.value : this.fileId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TeamBase {
  const TeamBase({required this.name});

  factory TeamBase.fromJson(Map<String, dynamic> json) =>
      _$TeamBaseFromJson(json);

  static const toJsonFactory = _$TeamBaseToJson;
  Map<String, dynamic> toJson() => _$TeamBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  static const fromJsonFactory = _$TeamBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TeamBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^ runtimeType.hashCode;
}

extension $TeamBaseExtension on TeamBase {
  TeamBase copyWith({String? name}) {
    return TeamBase(name: name ?? this.name);
  }

  TeamBase copyWithWrapped({Wrapped<String>? name}) {
    return TeamBase(name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class TeamPreview {
  const TeamPreview({
    required this.name,
    required this.id,
    required this.number,
    required this.captain,
    required this.second,
    required this.difficulty,
    required this.meetingPlace,
    required this.validationProgress,
  });

  factory TeamPreview.fromJson(Map<String, dynamic> json) =>
      _$TeamPreviewFromJson(json);

  static const toJsonFactory = _$TeamPreviewToJson;
  Map<String, dynamic> toJson() => _$TeamPreviewToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'number')
  final int number;
  @JsonKey(name: 'captain')
  final ParticipantPreview captain;
  @JsonKey(name: 'second')
  final ParticipantPreview second;
  @JsonKey(
    name: 'difficulty',
    toJson: difficultyToJson,
    fromJson: difficultyFromJson,
  )
  final enums.Difficulty difficulty;
  @JsonKey(
    name: 'meeting_place',
    toJson: meetingPlaceToJson,
    fromJson: meetingPlaceFromJson,
  )
  final enums.MeetingPlace meetingPlace;
  @JsonKey(name: 'validation_progress', defaultValue: 0.0)
  final double validationProgress;
  static const fromJsonFactory = _$TeamPreviewFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TeamPreview &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.captain, captain) ||
                const DeepCollectionEquality().equals(
                  other.captain,
                  captain,
                )) &&
            (identical(other.second, second) ||
                const DeepCollectionEquality().equals(other.second, second)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality().equals(
                  other.difficulty,
                  difficulty,
                )) &&
            (identical(other.meetingPlace, meetingPlace) ||
                const DeepCollectionEquality().equals(
                  other.meetingPlace,
                  meetingPlace,
                )) &&
            (identical(other.validationProgress, validationProgress) ||
                const DeepCollectionEquality().equals(
                  other.validationProgress,
                  validationProgress,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(captain) ^
      const DeepCollectionEquality().hash(second) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(meetingPlace) ^
      const DeepCollectionEquality().hash(validationProgress) ^
      runtimeType.hashCode;
}

extension $TeamPreviewExtension on TeamPreview {
  TeamPreview copyWith({
    String? name,
    String? id,
    int? number,
    ParticipantPreview? captain,
    ParticipantPreview? second,
    enums.Difficulty? difficulty,
    enums.MeetingPlace? meetingPlace,
    double? validationProgress,
  }) {
    return TeamPreview(
      name: name ?? this.name,
      id: id ?? this.id,
      number: number ?? this.number,
      captain: captain ?? this.captain,
      second: second ?? this.second,
      difficulty: difficulty ?? this.difficulty,
      meetingPlace: meetingPlace ?? this.meetingPlace,
      validationProgress: validationProgress ?? this.validationProgress,
    );
  }

  TeamPreview copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<int>? number,
    Wrapped<ParticipantPreview>? captain,
    Wrapped<ParticipantPreview>? second,
    Wrapped<enums.Difficulty>? difficulty,
    Wrapped<enums.MeetingPlace>? meetingPlace,
    Wrapped<double>? validationProgress,
  }) {
    return TeamPreview(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      number: (number != null ? number.value : this.number),
      captain: (captain != null ? captain.value : this.captain),
      second: (second != null ? second.value : this.second),
      difficulty: (difficulty != null ? difficulty.value : this.difficulty),
      meetingPlace:
          (meetingPlace != null ? meetingPlace.value : this.meetingPlace),
      validationProgress:
          (validationProgress != null
              ? validationProgress.value
              : this.validationProgress),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TeamUpdate {
  const TeamUpdate({
    this.name,
    this.number,
    this.difficulty,
    this.meetingPlace,
  });

  factory TeamUpdate.fromJson(Map<String, dynamic> json) =>
      _$TeamUpdateFromJson(json);

  static const toJsonFactory = _$TeamUpdateToJson;
  Map<String, dynamic> toJson() => _$TeamUpdateToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'number')
  final int? number;
  @JsonKey(
    name: 'difficulty',
    toJson: difficultyNullableToJson,
    fromJson: difficultyNullableFromJson,
  )
  final enums.Difficulty? difficulty;
  @JsonKey(
    name: 'meeting_place',
    toJson: meetingPlaceNullableToJson,
    fromJson: meetingPlaceNullableFromJson,
  )
  final enums.MeetingPlace? meetingPlace;
  static const fromJsonFactory = _$TeamUpdateFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TeamUpdate &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.difficulty, difficulty) ||
                const DeepCollectionEquality().equals(
                  other.difficulty,
                  difficulty,
                )) &&
            (identical(other.meetingPlace, meetingPlace) ||
                const DeepCollectionEquality().equals(
                  other.meetingPlace,
                  meetingPlace,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(difficulty) ^
      const DeepCollectionEquality().hash(meetingPlace) ^
      runtimeType.hashCode;
}

extension $TeamUpdateExtension on TeamUpdate {
  TeamUpdate copyWith({
    String? name,
    int? number,
    enums.Difficulty? difficulty,
    enums.MeetingPlace? meetingPlace,
  }) {
    return TeamUpdate(
      name: name ?? this.name,
      number: number ?? this.number,
      difficulty: difficulty ?? this.difficulty,
      meetingPlace: meetingPlace ?? this.meetingPlace,
    );
  }

  TeamUpdate copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<int?>? number,
    Wrapped<enums.Difficulty?>? difficulty,
    Wrapped<enums.MeetingPlace?>? meetingPlace,
  }) {
    return TeamUpdate(
      name: (name != null ? name.value : this.name),
      number: (number != null ? number.value : this.number),
      difficulty: (difficulty != null ? difficulty.value : this.difficulty),
      meetingPlace:
          (meetingPlace != null ? meetingPlace.value : this.meetingPlace),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TheMovieDB {
  const TheMovieDB({
    required this.genres,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.runtime,
    required this.tagline,
  });

  factory TheMovieDB.fromJson(Map<String, dynamic> json) =>
      _$TheMovieDBFromJson(json);

  static const toJsonFactory = _$TheMovieDBToJson;
  Map<String, dynamic> toJson() => _$TheMovieDBToJson(this);

  @JsonKey(name: 'genres', defaultValue: <Object>[])
  final List<Object> genres;
  @JsonKey(name: 'overview', defaultValue: '')
  final String overview;
  @JsonKey(name: 'poster_path', defaultValue: '')
  final String posterPath;
  @JsonKey(name: 'title', defaultValue: '')
  final String title;
  @JsonKey(name: 'runtime', defaultValue: 0)
  final int runtime;
  @JsonKey(name: 'tagline', defaultValue: '')
  final String tagline;
  static const fromJsonFactory = _$TheMovieDBFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TheMovieDB &&
            (identical(other.genres, genres) ||
                const DeepCollectionEquality().equals(other.genres, genres)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.runtime, runtime) ||
                const DeepCollectionEquality().equals(
                  other.runtime,
                  runtime,
                )) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality().equals(other.tagline, tagline)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(genres) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(runtime) ^
      const DeepCollectionEquality().hash(tagline) ^
      runtimeType.hashCode;
}

extension $TheMovieDBExtension on TheMovieDB {
  TheMovieDB copyWith({
    List<Object>? genres,
    String? overview,
    String? posterPath,
    String? title,
    int? runtime,
    String? tagline,
  }) {
    return TheMovieDB(
      genres: genres ?? this.genres,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      title: title ?? this.title,
      runtime: runtime ?? this.runtime,
      tagline: tagline ?? this.tagline,
    );
  }

  TheMovieDB copyWithWrapped({
    Wrapped<List<Object>>? genres,
    Wrapped<String>? overview,
    Wrapped<String>? posterPath,
    Wrapped<String>? title,
    Wrapped<int>? runtime,
    Wrapped<String>? tagline,
  }) {
    return TheMovieDB(
      genres: (genres != null ? genres.value : this.genres),
      overview: (overview != null ? overview.value : this.overview),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      title: (title != null ? title.value : this.title),
      runtime: (runtime != null ? runtime.value : this.runtime),
      tagline: (tagline != null ? tagline.value : this.tagline),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Ticket {
  const Ticket({
    required this.id,
    required this.productVariant,
    required this.user,
    required this.scanLeft,
    required this.tags,
    required this.expiration,
    required this.name,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  static const toJsonFactory = _$TicketToJson;
  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'product_variant')
  final ProductVariantComplete productVariant;
  @JsonKey(name: 'user')
  final UserTicket user;
  @JsonKey(name: 'scan_left', defaultValue: 0)
  final int scanLeft;
  @JsonKey(name: 'tags', defaultValue: '')
  final String tags;
  @JsonKey(name: 'expiration')
  final DateTime expiration;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  static const fromJsonFactory = _$TicketFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Ticket &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.productVariant, productVariant) ||
                const DeepCollectionEquality().equals(
                  other.productVariant,
                  productVariant,
                )) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.scanLeft, scanLeft) ||
                const DeepCollectionEquality().equals(
                  other.scanLeft,
                  scanLeft,
                )) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.expiration, expiration) ||
                const DeepCollectionEquality().equals(
                  other.expiration,
                  expiration,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(productVariant) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(scanLeft) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(expiration) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $TicketExtension on Ticket {
  Ticket copyWith({
    String? id,
    ProductVariantComplete? productVariant,
    UserTicket? user,
    int? scanLeft,
    String? tags,
    DateTime? expiration,
    String? name,
  }) {
    return Ticket(
      id: id ?? this.id,
      productVariant: productVariant ?? this.productVariant,
      user: user ?? this.user,
      scanLeft: scanLeft ?? this.scanLeft,
      tags: tags ?? this.tags,
      expiration: expiration ?? this.expiration,
      name: name ?? this.name,
    );
  }

  Ticket copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<ProductVariantComplete>? productVariant,
    Wrapped<UserTicket>? user,
    Wrapped<int>? scanLeft,
    Wrapped<String>? tags,
    Wrapped<DateTime>? expiration,
    Wrapped<String>? name,
  }) {
    return Ticket(
      id: (id != null ? id.value : this.id),
      productVariant:
          (productVariant != null ? productVariant.value : this.productVariant),
      user: (user != null ? user.value : this.user),
      scanLeft: (scanLeft != null ? scanLeft.value : this.scanLeft),
      tags: (tags != null ? tags.value : this.tags),
      expiration: (expiration != null ? expiration.value : this.expiration),
      name: (name != null ? name.value : this.name),
    );
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
  @JsonKey(name: 'winning_prize')
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TicketComplete &&
            (identical(other.packId, packId) ||
                const DeepCollectionEquality().equals(other.packId, packId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.winningPrize, winningPrize) ||
                const DeepCollectionEquality().equals(
                  other.winningPrize,
                  winningPrize,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.prize, prize) ||
                const DeepCollectionEquality().equals(other.prize, prize)) &&
            (identical(other.packTicket, packTicket) ||
                const DeepCollectionEquality().equals(
                  other.packTicket,
                  packTicket,
                )) &&
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
  TicketComplete copyWith({
    String? packId,
    String? userId,
    String? winningPrize,
    String? id,
    PrizeSimple? prize,
    PackTicketSimple? packTicket,
    CoreUserSimple? user,
  }) {
    return TicketComplete(
      packId: packId ?? this.packId,
      userId: userId ?? this.userId,
      winningPrize: winningPrize ?? this.winningPrize,
      id: id ?? this.id,
      prize: prize ?? this.prize,
      packTicket: packTicket ?? this.packTicket,
      user: user ?? this.user,
    );
  }

  TicketComplete copyWithWrapped({
    Wrapped<String>? packId,
    Wrapped<String>? userId,
    Wrapped<String?>? winningPrize,
    Wrapped<String>? id,
    Wrapped<PrizeSimple?>? prize,
    Wrapped<PackTicketSimple>? packTicket,
    Wrapped<CoreUserSimple>? user,
  }) {
    return TicketComplete(
      packId: (packId != null ? packId.value : this.packId),
      userId: (userId != null ? userId.value : this.userId),
      winningPrize:
          (winningPrize != null ? winningPrize.value : this.winningPrize),
      id: (id != null ? id.value : this.id),
      prize: (prize != null ? prize.value : this.prize),
      packTicket: (packTicket != null ? packTicket.value : this.packTicket),
      user: (user != null ? user.value : this.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TicketScan {
  const TicketScan({required this.tag});

  factory TicketScan.fromJson(Map<String, dynamic> json) =>
      _$TicketScanFromJson(json);

  static const toJsonFactory = _$TicketScanToJson;
  Map<String, dynamic> toJson() => _$TicketScanToJson(this);

  @JsonKey(name: 'tag', defaultValue: '')
  final String tag;
  static const fromJsonFactory = _$TicketScanFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TicketScan &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tag) ^ runtimeType.hashCode;
}

extension $TicketScanExtension on TicketScan {
  TicketScan copyWith({String? tag}) {
    return TicketScan(tag: tag ?? this.tag);
  }

  TicketScan copyWithWrapped({Wrapped<String>? tag}) {
    return TicketScan(tag: (tag != null ? tag.value : this.tag));
  }
}

@JsonSerializable(explicitToJson: true)
class TicketSecret {
  const TicketSecret({required this.qrCodeSecret});

  factory TicketSecret.fromJson(Map<String, dynamic> json) =>
      _$TicketSecretFromJson(json);

  static const toJsonFactory = _$TicketSecretToJson;
  Map<String, dynamic> toJson() => _$TicketSecretToJson(this);

  @JsonKey(name: 'qr_code_secret', defaultValue: '')
  final String qrCodeSecret;
  static const fromJsonFactory = _$TicketSecretFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TicketSecret &&
            (identical(other.qrCodeSecret, qrCodeSecret) ||
                const DeepCollectionEquality().equals(
                  other.qrCodeSecret,
                  qrCodeSecret,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(qrCodeSecret) ^ runtimeType.hashCode;
}

extension $TicketSecretExtension on TicketSecret {
  TicketSecret copyWith({String? qrCodeSecret}) {
    return TicketSecret(qrCodeSecret: qrCodeSecret ?? this.qrCodeSecret);
  }

  TicketSecret copyWithWrapped({Wrapped<String>? qrCodeSecret}) {
    return TicketSecret(
      qrCodeSecret:
          (qrCodeSecret != null ? qrCodeSecret.value : this.qrCodeSecret),
    );
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
  @JsonKey(name: 'winning_prize')
  final String? winningPrize;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory = _$TicketSimpleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TicketSimple &&
            (identical(other.packId, packId) ||
                const DeepCollectionEquality().equals(other.packId, packId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.winningPrize, winningPrize) ||
                const DeepCollectionEquality().equals(
                  other.winningPrize,
                  winningPrize,
                )) &&
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
  TicketSimple copyWith({
    String? packId,
    String? userId,
    String? winningPrize,
    String? id,
  }) {
    return TicketSimple(
      packId: packId ?? this.packId,
      userId: userId ?? this.userId,
      winningPrize: winningPrize ?? this.winningPrize,
      id: id ?? this.id,
    );
  }

  TicketSimple copyWithWrapped({
    Wrapped<String>? packId,
    Wrapped<String>? userId,
    Wrapped<String?>? winningPrize,
    Wrapped<String>? id,
  }) {
    return TicketSimple(
      packId: (packId != null ? packId.value : this.packId),
      userId: (userId != null ? userId.value : this.userId),
      winningPrize:
          (winningPrize != null ? winningPrize.value : this.winningPrize),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenResponse {
  const TokenResponse({
    required this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.scope,
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
  @JsonKey(name: 'scope', defaultValue: '')
  final String? scope;
  @JsonKey(name: 'refresh_token', defaultValue: '')
  final String refreshToken;
  @JsonKey(name: 'id_token')
  final String? idToken;
  static const fromJsonFactory = _$TokenResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenResponse &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality().equals(
                  other.accessToken,
                  accessToken,
                )) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality().equals(
                  other.tokenType,
                  tokenType,
                )) &&
            (identical(other.expiresIn, expiresIn) ||
                const DeepCollectionEquality().equals(
                  other.expiresIn,
                  expiresIn,
                )) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality().equals(
                  other.refreshToken,
                  refreshToken,
                )) &&
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
      const DeepCollectionEquality().hash(scope) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(idToken) ^
      runtimeType.hashCode;
}

extension $TokenResponseExtension on TokenResponse {
  TokenResponse copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    String? scope,
    String? refreshToken,
    String? idToken,
  }) {
    return TokenResponse(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      scope: scope ?? this.scope,
      refreshToken: refreshToken ?? this.refreshToken,
      idToken: idToken ?? this.idToken,
    );
  }

  TokenResponse copyWithWrapped({
    Wrapped<String>? accessToken,
    Wrapped<String?>? tokenType,
    Wrapped<int?>? expiresIn,
    Wrapped<String?>? scope,
    Wrapped<String>? refreshToken,
    Wrapped<String?>? idToken,
  }) {
    return TokenResponse(
      accessToken: (accessToken != null ? accessToken.value : this.accessToken),
      tokenType: (tokenType != null ? tokenType.value : this.tokenType),
      expiresIn: (expiresIn != null ? expiresIn.value : this.expiresIn),
      scope: (scope != null ? scope.value : this.scope),
      refreshToken:
          (refreshToken != null ? refreshToken.value : this.refreshToken),
      idToken: (idToken != null ? idToken.value : this.idToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Transaction {
  const Transaction({
    required this.id,
    required this.debitedWalletId,
    required this.creditedWalletId,
    required this.transactionType,
    required this.sellerUserId,
    required this.total,
    required this.creation,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  static const toJsonFactory = _$TransactionToJson;
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'debited_wallet_id', defaultValue: '')
  final String debitedWalletId;
  @JsonKey(name: 'credited_wallet_id', defaultValue: '')
  final String creditedWalletId;
  @JsonKey(
    name: 'transaction_type',
    toJson: transactionTypeToJson,
    fromJson: transactionTypeFromJson,
  )
  final enums.TransactionType transactionType;
  @JsonKey(name: 'seller_user_id')
  final String sellerUserId;
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(
    name: 'status',
    toJson: transactionStatusToJson,
    fromJson: transactionStatusFromJson,
  )
  final enums.TransactionStatus status;
  static const fromJsonFactory = _$TransactionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Transaction &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.debitedWalletId, debitedWalletId) ||
                const DeepCollectionEquality().equals(
                  other.debitedWalletId,
                  debitedWalletId,
                )) &&
            (identical(other.creditedWalletId, creditedWalletId) ||
                const DeepCollectionEquality().equals(
                  other.creditedWalletId,
                  creditedWalletId,
                )) &&
            (identical(other.transactionType, transactionType) ||
                const DeepCollectionEquality().equals(
                  other.transactionType,
                  transactionType,
                )) &&
            (identical(other.sellerUserId, sellerUserId) ||
                const DeepCollectionEquality().equals(
                  other.sellerUserId,
                  sellerUserId,
                )) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(debitedWalletId) ^
      const DeepCollectionEquality().hash(creditedWalletId) ^
      const DeepCollectionEquality().hash(transactionType) ^
      const DeepCollectionEquality().hash(sellerUserId) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $TransactionExtension on Transaction {
  Transaction copyWith({
    String? id,
    String? debitedWalletId,
    String? creditedWalletId,
    enums.TransactionType? transactionType,
    String? sellerUserId,
    int? total,
    DateTime? creation,
    enums.TransactionStatus? status,
  }) {
    return Transaction(
      id: id ?? this.id,
      debitedWalletId: debitedWalletId ?? this.debitedWalletId,
      creditedWalletId: creditedWalletId ?? this.creditedWalletId,
      transactionType: transactionType ?? this.transactionType,
      sellerUserId: sellerUserId ?? this.sellerUserId,
      total: total ?? this.total,
      creation: creation ?? this.creation,
      status: status ?? this.status,
    );
  }

  Transaction copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? debitedWalletId,
    Wrapped<String>? creditedWalletId,
    Wrapped<enums.TransactionType>? transactionType,
    Wrapped<String>? sellerUserId,
    Wrapped<int>? total,
    Wrapped<DateTime>? creation,
    Wrapped<enums.TransactionStatus>? status,
  }) {
    return Transaction(
      id: (id != null ? id.value : this.id),
      debitedWalletId:
          (debitedWalletId != null
              ? debitedWalletId.value
              : this.debitedWalletId),
      creditedWalletId:
          (creditedWalletId != null
              ? creditedWalletId.value
              : this.creditedWalletId),
      transactionType:
          (transactionType != null
              ? transactionType.value
              : this.transactionType),
      sellerUserId:
          (sellerUserId != null ? sellerUserId.value : this.sellerUserId),
      total: (total != null ? total.value : this.total),
      creation: (creation != null ? creation.value : this.creation),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Transfer {
  const Transfer({
    required this.id,
    required this.type,
    required this.transferIdentifier,
    required this.approverUserId,
    required this.walletId,
    required this.total,
    required this.creation,
    required this.confirmed,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);

  static const toJsonFactory = _$TransferToJson;
  Map<String, dynamic> toJson() => _$TransferToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'type',
    toJson: transferTypeToJson,
    fromJson: transferTypeFromJson,
  )
  final enums.TransferType type;
  @JsonKey(name: 'transfer_identifier', defaultValue: '')
  final String transferIdentifier;
  @JsonKey(name: 'approver_user_id')
  final String approverUserId;
  @JsonKey(name: 'wallet_id', defaultValue: '')
  final String walletId;
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(name: 'confirmed', defaultValue: false)
  final bool confirmed;
  static const fromJsonFactory = _$TransferFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Transfer &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.transferIdentifier, transferIdentifier) ||
                const DeepCollectionEquality().equals(
                  other.transferIdentifier,
                  transferIdentifier,
                )) &&
            (identical(other.approverUserId, approverUserId) ||
                const DeepCollectionEquality().equals(
                  other.approverUserId,
                  approverUserId,
                )) &&
            (identical(other.walletId, walletId) ||
                const DeepCollectionEquality().equals(
                  other.walletId,
                  walletId,
                )) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.confirmed, confirmed) ||
                const DeepCollectionEquality().equals(
                  other.confirmed,
                  confirmed,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(transferIdentifier) ^
      const DeepCollectionEquality().hash(approverUserId) ^
      const DeepCollectionEquality().hash(walletId) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(confirmed) ^
      runtimeType.hashCode;
}

extension $TransferExtension on Transfer {
  Transfer copyWith({
    String? id,
    enums.TransferType? type,
    String? transferIdentifier,
    String? approverUserId,
    String? walletId,
    int? total,
    DateTime? creation,
    bool? confirmed,
  }) {
    return Transfer(
      id: id ?? this.id,
      type: type ?? this.type,
      transferIdentifier: transferIdentifier ?? this.transferIdentifier,
      approverUserId: approverUserId ?? this.approverUserId,
      walletId: walletId ?? this.walletId,
      total: total ?? this.total,
      creation: creation ?? this.creation,
      confirmed: confirmed ?? this.confirmed,
    );
  }

  Transfer copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<enums.TransferType>? type,
    Wrapped<String>? transferIdentifier,
    Wrapped<String>? approverUserId,
    Wrapped<String>? walletId,
    Wrapped<int>? total,
    Wrapped<DateTime>? creation,
    Wrapped<bool>? confirmed,
  }) {
    return Transfer(
      id: (id != null ? id.value : this.id),
      type: (type != null ? type.value : this.type),
      transferIdentifier:
          (transferIdentifier != null
              ? transferIdentifier.value
              : this.transferIdentifier),
      approverUserId:
          (approverUserId != null ? approverUserId.value : this.approverUserId),
      walletId: (walletId != null ? walletId.value : this.walletId),
      total: (total != null ? total.value : this.total),
      creation: (creation != null ? creation.value : this.creation),
      confirmed: (confirmed != null ? confirmed.value : this.confirmed),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransferInfo {
  const TransferInfo({required this.amount, required this.redirectUrl});

  factory TransferInfo.fromJson(Map<String, dynamic> json) =>
      _$TransferInfoFromJson(json);

  static const toJsonFactory = _$TransferInfoToJson;
  Map<String, dynamic> toJson() => _$TransferInfoToJson(this);

  @JsonKey(name: 'amount', defaultValue: 0)
  final int amount;
  @JsonKey(name: 'redirect_url', defaultValue: '')
  final String redirectUrl;
  static const fromJsonFactory = _$TransferInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TransferInfo &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.redirectUrl, redirectUrl) ||
                const DeepCollectionEquality().equals(
                  other.redirectUrl,
                  redirectUrl,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(redirectUrl) ^
      runtimeType.hashCode;
}

extension $TransferInfoExtension on TransferInfo {
  TransferInfo copyWith({int? amount, String? redirectUrl}) {
    return TransferInfo(
      amount: amount ?? this.amount,
      redirectUrl: redirectUrl ?? this.redirectUrl,
    );
  }

  TransferInfo copyWithWrapped({
    Wrapped<int>? amount,
    Wrapped<String>? redirectUrl,
  }) {
    return TransferInfo(
      amount: (amount != null ? amount.value : this.amount),
      redirectUrl: (redirectUrl != null ? redirectUrl.value : this.redirectUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserMembershipBase {
  const UserMembershipBase({
    required this.associationMembershipId,
    required this.startDate,
    required this.endDate,
  });

  factory UserMembershipBase.fromJson(Map<String, dynamic> json) =>
      _$UserMembershipBaseFromJson(json);

  static const toJsonFactory = _$UserMembershipBaseToJson;
  Map<String, dynamic> toJson() => _$UserMembershipBaseToJson(this);

  @JsonKey(name: 'association_membership_id', defaultValue: '')
  final String associationMembershipId;
  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime endDate;
  static const fromJsonFactory = _$UserMembershipBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserMembershipBase &&
            (identical(
                  other.associationMembershipId,
                  associationMembershipId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.associationMembershipId,
                  associationMembershipId,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(other.endDate, endDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(associationMembershipId) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      runtimeType.hashCode;
}

extension $UserMembershipBaseExtension on UserMembershipBase {
  UserMembershipBase copyWith({
    String? associationMembershipId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return UserMembershipBase(
      associationMembershipId:
          associationMembershipId ?? this.associationMembershipId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  UserMembershipBase copyWithWrapped({
    Wrapped<String>? associationMembershipId,
    Wrapped<DateTime>? startDate,
    Wrapped<DateTime>? endDate,
  }) {
    return UserMembershipBase(
      associationMembershipId:
          (associationMembershipId != null
              ? associationMembershipId.value
              : this.associationMembershipId),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserMembershipComplete {
  const UserMembershipComplete({
    required this.associationMembershipId,
    required this.startDate,
    required this.endDate,
    required this.id,
    required this.userId,
    required this.user,
  });

  factory UserMembershipComplete.fromJson(Map<String, dynamic> json) =>
      _$UserMembershipCompleteFromJson(json);

  static const toJsonFactory = _$UserMembershipCompleteToJson;
  Map<String, dynamic> toJson() => _$UserMembershipCompleteToJson(this);

  @JsonKey(name: 'association_membership_id', defaultValue: '')
  final String associationMembershipId;
  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime startDate;
  @JsonKey(name: 'end_date', toJson: _dateToJson)
  final DateTime endDate;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'user')
  final CoreUserSimple user;
  static const fromJsonFactory = _$UserMembershipCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserMembershipComplete &&
            (identical(
                  other.associationMembershipId,
                  associationMembershipId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.associationMembershipId,
                  associationMembershipId,
                )) &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(
                  other.endDate,
                  endDate,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(associationMembershipId) ^
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $UserMembershipCompleteExtension on UserMembershipComplete {
  UserMembershipComplete copyWith({
    String? associationMembershipId,
    DateTime? startDate,
    DateTime? endDate,
    String? id,
    String? userId,
    CoreUserSimple? user,
  }) {
    return UserMembershipComplete(
      associationMembershipId:
          associationMembershipId ?? this.associationMembershipId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      user: user ?? this.user,
    );
  }

  UserMembershipComplete copyWithWrapped({
    Wrapped<String>? associationMembershipId,
    Wrapped<DateTime>? startDate,
    Wrapped<DateTime>? endDate,
    Wrapped<String>? id,
    Wrapped<String>? userId,
    Wrapped<CoreUserSimple>? user,
  }) {
    return UserMembershipComplete(
      associationMembershipId:
          (associationMembershipId != null
              ? associationMembershipId.value
              : this.associationMembershipId),
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
      id: (id != null ? id.value : this.id),
      userId: (userId != null ? userId.value : this.userId),
      user: (user != null ? user.value : this.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserMembershipEdit {
  const UserMembershipEdit({this.startDate, this.endDate});

  factory UserMembershipEdit.fromJson(Map<String, dynamic> json) =>
      _$UserMembershipEditFromJson(json);

  static const toJsonFactory = _$UserMembershipEditToJson;
  Map<String, dynamic> toJson() => _$UserMembershipEditToJson(this);

  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  static const fromJsonFactory = _$UserMembershipEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserMembershipEdit &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )) &&
            (identical(other.endDate, endDate) ||
                const DeepCollectionEquality().equals(other.endDate, endDate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startDate) ^
      const DeepCollectionEquality().hash(endDate) ^
      runtimeType.hashCode;
}

extension $UserMembershipEditExtension on UserMembershipEdit {
  UserMembershipEdit copyWith({String? startDate, String? endDate}) {
    return UserMembershipEdit(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  UserMembershipEdit copyWithWrapped({
    Wrapped<String?>? startDate,
    Wrapped<String?>? endDate,
  }) {
    return UserMembershipEdit(
      startDate: (startDate != null ? startDate.value : this.startDate),
      endDate: (endDate != null ? endDate.value : this.endDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserStore {
  const UserStore({
    required this.name,
    required this.id,
    required this.structureId,
    required this.walletId,
    required this.structure,
    required this.canBank,
    required this.canSeeHistory,
    required this.canCancel,
    required this.canManageSellers,
  });

  factory UserStore.fromJson(Map<String, dynamic> json) =>
      _$UserStoreFromJson(json);

  static const toJsonFactory = _$UserStoreToJson;
  Map<String, dynamic> toJson() => _$UserStoreToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'structure_id', defaultValue: '')
  final String structureId;
  @JsonKey(name: 'wallet_id', defaultValue: '')
  final String walletId;
  @JsonKey(name: 'structure')
  final Structure structure;
  @JsonKey(name: 'can_bank', defaultValue: false)
  final bool canBank;
  @JsonKey(name: 'can_see_history', defaultValue: false)
  final bool canSeeHistory;
  @JsonKey(name: 'can_cancel', defaultValue: false)
  final bool canCancel;
  @JsonKey(name: 'can_manage_sellers', defaultValue: false)
  final bool canManageSellers;
  static const fromJsonFactory = _$UserStoreFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserStore &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.structureId, structureId) ||
                const DeepCollectionEquality().equals(
                  other.structureId,
                  structureId,
                )) &&
            (identical(other.walletId, walletId) ||
                const DeepCollectionEquality().equals(
                  other.walletId,
                  walletId,
                )) &&
            (identical(other.structure, structure) ||
                const DeepCollectionEquality().equals(
                  other.structure,
                  structure,
                )) &&
            (identical(other.canBank, canBank) ||
                const DeepCollectionEquality().equals(
                  other.canBank,
                  canBank,
                )) &&
            (identical(other.canSeeHistory, canSeeHistory) ||
                const DeepCollectionEquality().equals(
                  other.canSeeHistory,
                  canSeeHistory,
                )) &&
            (identical(other.canCancel, canCancel) ||
                const DeepCollectionEquality().equals(
                  other.canCancel,
                  canCancel,
                )) &&
            (identical(other.canManageSellers, canManageSellers) ||
                const DeepCollectionEquality().equals(
                  other.canManageSellers,
                  canManageSellers,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(structureId) ^
      const DeepCollectionEquality().hash(walletId) ^
      const DeepCollectionEquality().hash(structure) ^
      const DeepCollectionEquality().hash(canBank) ^
      const DeepCollectionEquality().hash(canSeeHistory) ^
      const DeepCollectionEquality().hash(canCancel) ^
      const DeepCollectionEquality().hash(canManageSellers) ^
      runtimeType.hashCode;
}

extension $UserStoreExtension on UserStore {
  UserStore copyWith({
    String? name,
    String? id,
    String? structureId,
    String? walletId,
    Structure? structure,
    bool? canBank,
    bool? canSeeHistory,
    bool? canCancel,
    bool? canManageSellers,
  }) {
    return UserStore(
      name: name ?? this.name,
      id: id ?? this.id,
      structureId: structureId ?? this.structureId,
      walletId: walletId ?? this.walletId,
      structure: structure ?? this.structure,
      canBank: canBank ?? this.canBank,
      canSeeHistory: canSeeHistory ?? this.canSeeHistory,
      canCancel: canCancel ?? this.canCancel,
      canManageSellers: canManageSellers ?? this.canManageSellers,
    );
  }

  UserStore copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<String>? structureId,
    Wrapped<String>? walletId,
    Wrapped<Structure>? structure,
    Wrapped<bool>? canBank,
    Wrapped<bool>? canSeeHistory,
    Wrapped<bool>? canCancel,
    Wrapped<bool>? canManageSellers,
  }) {
    return UserStore(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      structureId: (structureId != null ? structureId.value : this.structureId),
      walletId: (walletId != null ? walletId.value : this.walletId),
      structure: (structure != null ? structure.value : this.structure),
      canBank: (canBank != null ? canBank.value : this.canBank),
      canSeeHistory:
          (canSeeHistory != null ? canSeeHistory.value : this.canSeeHistory),
      canCancel: (canCancel != null ? canCancel.value : this.canCancel),
      canManageSellers:
          (canManageSellers != null
              ? canManageSellers.value
              : this.canManageSellers),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserTicket {
  const UserTicket({
    required this.name,
    required this.firstname,
    this.nickname,
    required this.id,
    required this.accountType,
    required this.schoolId,
    this.promo,
    this.floor,
    this.createdOn,
  });

  factory UserTicket.fromJson(Map<String, dynamic> json) =>
      _$UserTicketFromJson(json);

  static const toJsonFactory = _$UserTicketToJson;
  Map<String, dynamic> toJson() => _$UserTicketToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'firstname', defaultValue: '')
  final String firstname;
  @JsonKey(name: 'nickname')
  final String? nickname;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(
    name: 'account_type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType accountType;
  @JsonKey(name: 'school_id', defaultValue: '')
  final String schoolId;
  @JsonKey(name: 'promo')
  final int? promo;
  @JsonKey(
    name: 'floor',
    toJson: floorsTypeNullableToJson,
    fromJson: floorsTypeNullableFromJson,
  )
  final enums.FloorsType? floor;
  @JsonKey(name: 'created_on')
  final String? createdOn;
  static const fromJsonFactory = _$UserTicketFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserTicket &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.firstname, firstname) ||
                const DeepCollectionEquality().equals(
                  other.firstname,
                  firstname,
                )) &&
            (identical(other.nickname, nickname) ||
                const DeepCollectionEquality().equals(
                  other.nickname,
                  nickname,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accountType, accountType) ||
                const DeepCollectionEquality().equals(
                  other.accountType,
                  accountType,
                )) &&
            (identical(other.schoolId, schoolId) ||
                const DeepCollectionEquality().equals(
                  other.schoolId,
                  schoolId,
                )) &&
            (identical(other.promo, promo) ||
                const DeepCollectionEquality().equals(other.promo, promo)) &&
            (identical(other.floor, floor) ||
                const DeepCollectionEquality().equals(other.floor, floor)) &&
            (identical(other.createdOn, createdOn) ||
                const DeepCollectionEquality().equals(
                  other.createdOn,
                  createdOn,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(firstname) ^
      const DeepCollectionEquality().hash(nickname) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(accountType) ^
      const DeepCollectionEquality().hash(schoolId) ^
      const DeepCollectionEquality().hash(promo) ^
      const DeepCollectionEquality().hash(floor) ^
      const DeepCollectionEquality().hash(createdOn) ^
      runtimeType.hashCode;
}

extension $UserTicketExtension on UserTicket {
  UserTicket copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    enums.AccountType? accountType,
    String? schoolId,
    int? promo,
    enums.FloorsType? floor,
    String? createdOn,
  }) {
    return UserTicket(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      schoolId: schoolId ?? this.schoolId,
      promo: promo ?? this.promo,
      floor: floor ?? this.floor,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  UserTicket copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? firstname,
    Wrapped<String?>? nickname,
    Wrapped<String>? id,
    Wrapped<enums.AccountType>? accountType,
    Wrapped<String>? schoolId,
    Wrapped<int?>? promo,
    Wrapped<enums.FloorsType?>? floor,
    Wrapped<String?>? createdOn,
  }) {
    return UserTicket(
      name: (name != null ? name.value : this.name),
      firstname: (firstname != null ? firstname.value : this.firstname),
      nickname: (nickname != null ? nickname.value : this.nickname),
      id: (id != null ? id.value : this.id),
      accountType: (accountType != null ? accountType.value : this.accountType),
      schoolId: (schoolId != null ? schoolId.value : this.schoolId),
      promo: (promo != null ? promo.value : this.promo),
      floor: (floor != null ? floor.value : this.floor),
      createdOn: (createdOn != null ? createdOn.value : this.createdOn),
    );
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
  bool operator ==(Object other) {
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
      loc: loc ?? this.loc,
      msg: msg ?? this.msg,
      type: type ?? this.type,
    );
  }

  ValidationError copyWithWrapped({
    Wrapped<List<Object>>? loc,
    Wrapped<String>? msg,
    Wrapped<String>? type,
  }) {
    return ValidationError(
      loc: (loc != null ? loc.value : this.loc),
      msg: (msg != null ? msg.value : this.msg),
      type: (type != null ? type.value : this.type),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VoteBase {
  const VoteBase({required this.listId});

  factory VoteBase.fromJson(Map<String, dynamic> json) =>
      _$VoteBaseFromJson(json);

  static const toJsonFactory = _$VoteBaseToJson;
  Map<String, dynamic> toJson() => _$VoteBaseToJson(this);

  @JsonKey(name: 'list_id', defaultValue: '')
  final String listId;
  static const fromJsonFactory = _$VoteBaseFromJson;

  @override
  bool operator ==(Object other) {
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
  const VoteStats({required this.sectionId, required this.count});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VoteStats &&
            (identical(other.sectionId, sectionId) ||
                const DeepCollectionEquality().equals(
                  other.sectionId,
                  sectionId,
                )) &&
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
      sectionId: sectionId ?? this.sectionId,
      count: count ?? this.count,
    );
  }

  VoteStats copyWithWrapped({Wrapped<String>? sectionId, Wrapped<int>? count}) {
    return VoteStats(
      sectionId: (sectionId != null ? sectionId.value : this.sectionId),
      count: (count != null ? count.value : this.count),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VoteStatus {
  const VoteStatus({required this.status});

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
  bool operator ==(Object other) {
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
  const VoterGroup({required this.groupId});

  factory VoterGroup.fromJson(Map<String, dynamic> json) =>
      _$VoterGroupFromJson(json);

  static const toJsonFactory = _$VoterGroupToJson;
  Map<String, dynamic> toJson() => _$VoterGroupToJson(this);

  @JsonKey(name: 'group_id', defaultValue: '')
  final String groupId;
  static const fromJsonFactory = _$VoterGroupFromJson;

  @override
  bool operator ==(Object other) {
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
      groupId: (groupId != null ? groupId.value : this.groupId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Wallet {
  const Wallet({
    required this.id,
    required this.type,
    required this.balance,
    required this.store,
    required this.user,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  static const toJsonFactory = _$WalletToJson;
  Map<String, dynamic> toJson() => _$WalletToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'type', toJson: walletTypeToJson, fromJson: walletTypeFromJson)
  final enums.WalletType type;
  @JsonKey(name: 'balance', defaultValue: 0)
  final int balance;
  @JsonKey(name: 'store')
  final Store store;
  @JsonKey(name: 'user')
  final CoreUser user;
  static const fromJsonFactory = _$WalletFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Wallet &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(
                  other.balance,
                  balance,
                )) &&
            (identical(other.store, store) ||
                const DeepCollectionEquality().equals(other.store, store)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(store) ^
      const DeepCollectionEquality().hash(user) ^
      runtimeType.hashCode;
}

extension $WalletExtension on Wallet {
  Wallet copyWith({
    String? id,
    enums.WalletType? type,
    int? balance,
    Store? store,
    CoreUser? user,
  }) {
    return Wallet(
      id: id ?? this.id,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      store: store ?? this.store,
      user: user ?? this.user,
    );
  }

  Wallet copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<enums.WalletType>? type,
    Wrapped<int>? balance,
    Wrapped<Store>? store,
    Wrapped<CoreUser>? user,
  }) {
    return Wallet(
      id: (id != null ? id.value : this.id),
      type: (type != null ? type.value : this.type),
      balance: (balance != null ? balance.value : this.balance),
      store: (store != null ? store.value : this.store),
      user: (user != null ? user.value : this.user),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WalletDevice {
  const WalletDevice({
    required this.name,
    required this.id,
    required this.walletId,
    required this.creation,
    required this.status,
  });

  factory WalletDevice.fromJson(Map<String, dynamic> json) =>
      _$WalletDeviceFromJson(json);

  static const toJsonFactory = _$WalletDeviceToJson;
  Map<String, dynamic> toJson() => _$WalletDeviceToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'wallet_id', defaultValue: '')
  final String walletId;
  @JsonKey(name: 'creation')
  final DateTime creation;
  @JsonKey(
    name: 'status',
    toJson: walletDeviceStatusToJson,
    fromJson: walletDeviceStatusFromJson,
  )
  final enums.WalletDeviceStatus status;
  static const fromJsonFactory = _$WalletDeviceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WalletDevice &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.walletId, walletId) ||
                const DeepCollectionEquality().equals(
                  other.walletId,
                  walletId,
                )) &&
            (identical(other.creation, creation) ||
                const DeepCollectionEquality().equals(
                  other.creation,
                  creation,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(walletId) ^
      const DeepCollectionEquality().hash(creation) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $WalletDeviceExtension on WalletDevice {
  WalletDevice copyWith({
    String? name,
    String? id,
    String? walletId,
    DateTime? creation,
    enums.WalletDeviceStatus? status,
  }) {
    return WalletDevice(
      name: name ?? this.name,
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      creation: creation ?? this.creation,
      status: status ?? this.status,
    );
  }

  WalletDevice copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? id,
    Wrapped<String>? walletId,
    Wrapped<DateTime>? creation,
    Wrapped<enums.WalletDeviceStatus>? status,
  }) {
    return WalletDevice(
      name: (name != null ? name.value : this.name),
      id: (id != null ? id.value : this.id),
      walletId: (walletId != null ? walletId.value : this.walletId),
      creation: (creation != null ? creation.value : this.creation),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WalletDeviceCreation {
  const WalletDeviceCreation({
    required this.name,
    required this.ed25519PublicKey,
  });

  factory WalletDeviceCreation.fromJson(Map<String, dynamic> json) =>
      _$WalletDeviceCreationFromJson(json);

  static const toJsonFactory = _$WalletDeviceCreationToJson;
  Map<String, dynamic> toJson() => _$WalletDeviceCreationToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'ed25519_public_key', defaultValue: '')
  final String ed25519PublicKey;
  static const fromJsonFactory = _$WalletDeviceCreationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WalletDeviceCreation &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.ed25519PublicKey, ed25519PublicKey) ||
                const DeepCollectionEquality().equals(
                  other.ed25519PublicKey,
                  ed25519PublicKey,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(ed25519PublicKey) ^
      runtimeType.hashCode;
}

extension $WalletDeviceCreationExtension on WalletDeviceCreation {
  WalletDeviceCreation copyWith({String? name, String? ed25519PublicKey}) {
    return WalletDeviceCreation(
      name: name ?? this.name,
      ed25519PublicKey: ed25519PublicKey ?? this.ed25519PublicKey,
    );
  }

  WalletDeviceCreation copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? ed25519PublicKey,
  }) {
    return WalletDeviceCreation(
      name: (name != null ? name.value : this.name),
      ed25519PublicKey:
          (ed25519PublicKey != null
              ? ed25519PublicKey.value
              : this.ed25519PublicKey),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WalletInfo {
  const WalletInfo({
    required this.id,
    required this.type,
    required this.ownerName,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) =>
      _$WalletInfoFromJson(json);

  static const toJsonFactory = _$WalletInfoToJson;
  Map<String, dynamic> toJson() => _$WalletInfoToJson(this);

  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'type', toJson: walletTypeToJson, fromJson: walletTypeFromJson)
  final enums.WalletType type;
  @JsonKey(name: 'owner_name')
  final String ownerName;
  static const fromJsonFactory = _$WalletInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WalletInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.ownerName, ownerName) ||
                const DeepCollectionEquality().equals(
                  other.ownerName,
                  ownerName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(ownerName) ^
      runtimeType.hashCode;
}

extension $WalletInfoExtension on WalletInfo {
  WalletInfo copyWith({String? id, enums.WalletType? type, String? ownerName}) {
    return WalletInfo(
      id: id ?? this.id,
      type: type ?? this.type,
      ownerName: ownerName ?? this.ownerName,
    );
  }

  WalletInfo copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<enums.WalletType>? type,
    Wrapped<String>? ownerName,
  }) {
    return WalletInfo(
      id: (id != null ? id.value : this.id),
      type: (type != null ? type.value : this.type),
      ownerName: (ownerName != null ? ownerName.value : this.ownerName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppCoreMembershipsSchemasMembershipsMembershipBase {
  const AppCoreMembershipsSchemasMembershipsMembershipBase({
    required this.name,
    required this.managerGroupId,
  });

  factory AppCoreMembershipsSchemasMembershipsMembershipBase.fromJson(
    Map<String, dynamic> json,
  ) => _$AppCoreMembershipsSchemasMembershipsMembershipBaseFromJson(json);

  static const toJsonFactory =
      _$AppCoreMembershipsSchemasMembershipsMembershipBaseToJson;
  Map<String, dynamic> toJson() =>
      _$AppCoreMembershipsSchemasMembershipsMembershipBaseToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'manager_group_id', defaultValue: '')
  final String managerGroupId;
  static const fromJsonFactory =
      _$AppCoreMembershipsSchemasMembershipsMembershipBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppCoreMembershipsSchemasMembershipsMembershipBase &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.managerGroupId, managerGroupId) ||
                const DeepCollectionEquality().equals(
                  other.managerGroupId,
                  managerGroupId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(managerGroupId) ^
      runtimeType.hashCode;
}

extension $AppCoreMembershipsSchemasMembershipsMembershipBaseExtension
    on AppCoreMembershipsSchemasMembershipsMembershipBase {
  AppCoreMembershipsSchemasMembershipsMembershipBase copyWith({
    String? name,
    String? managerGroupId,
  }) {
    return AppCoreMembershipsSchemasMembershipsMembershipBase(
      name: name ?? this.name,
      managerGroupId: managerGroupId ?? this.managerGroupId,
    );
  }

  AppCoreMembershipsSchemasMembershipsMembershipBase copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? managerGroupId,
  }) {
    return AppCoreMembershipsSchemasMembershipsMembershipBase(
      name: (name != null ? name.value : this.name),
      managerGroupId:
          (managerGroupId != null ? managerGroupId.value : this.managerGroupId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppModulesAmapSchemasAmapProductComplete {
  const AppModulesAmapSchemasAmapProductComplete({
    required this.name,
    required this.price,
    required this.category,
    required this.id,
  });

  factory AppModulesAmapSchemasAmapProductComplete.fromJson(
    Map<String, dynamic> json,
  ) => _$AppModulesAmapSchemasAmapProductCompleteFromJson(json);

  static const toJsonFactory = _$AppModulesAmapSchemasAmapProductCompleteToJson;
  Map<String, dynamic> toJson() =>
      _$AppModulesAmapSchemasAmapProductCompleteToJson(this);

  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'price', defaultValue: 0.0)
  final double price;
  @JsonKey(name: 'category', defaultValue: '')
  final String category;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  static const fromJsonFactory =
      _$AppModulesAmapSchemasAmapProductCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppModulesAmapSchemasAmapProductComplete &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )) &&
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

extension $AppModulesAmapSchemasAmapProductCompleteExtension
    on AppModulesAmapSchemasAmapProductComplete {
  AppModulesAmapSchemasAmapProductComplete copyWith({
    String? name,
    double? price,
    String? category,
    String? id,
  }) {
    return AppModulesAmapSchemasAmapProductComplete(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      id: id ?? this.id,
    );
  }

  AppModulesAmapSchemasAmapProductComplete copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<double>? price,
    Wrapped<String>? category,
    Wrapped<String>? id,
  }) {
    return AppModulesAmapSchemasAmapProductComplete(
      name: (name != null ? name.value : this.name),
      price: (price != null ? price.value : this.price),
      category: (category != null ? category.value : this.category),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppModulesAmapSchemasAmapProductEdit {
  const AppModulesAmapSchemasAmapProductEdit({
    this.category,
    this.name,
    this.price,
  });

  factory AppModulesAmapSchemasAmapProductEdit.fromJson(
    Map<String, dynamic> json,
  ) => _$AppModulesAmapSchemasAmapProductEditFromJson(json);

  static const toJsonFactory = _$AppModulesAmapSchemasAmapProductEditToJson;
  Map<String, dynamic> toJson() =>
      _$AppModulesAmapSchemasAmapProductEditToJson(this);

  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final num? price;
  static const fromJsonFactory = _$AppModulesAmapSchemasAmapProductEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppModulesAmapSchemasAmapProductEdit &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )) &&
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

extension $AppModulesAmapSchemasAmapProductEditExtension
    on AppModulesAmapSchemasAmapProductEdit {
  AppModulesAmapSchemasAmapProductEdit copyWith({
    String? category,
    String? name,
    num? price,
  }) {
    return AppModulesAmapSchemasAmapProductEdit(
      category: category ?? this.category,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  AppModulesAmapSchemasAmapProductEdit copyWithWrapped({
    Wrapped<String?>? category,
    Wrapped<String?>? name,
    Wrapped<num?>? price,
  }) {
    return AppModulesAmapSchemasAmapProductEdit(
      category: (category != null ? category.value : this.category),
      name: (name != null ? name.value : this.name),
      price: (price != null ? price.value : this.price),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppModulesCampaignSchemasCampaignResult {
  const AppModulesCampaignSchemasCampaignResult({
    required this.listId,
    required this.count,
  });

  factory AppModulesCampaignSchemasCampaignResult.fromJson(
    Map<String, dynamic> json,
  ) => _$AppModulesCampaignSchemasCampaignResultFromJson(json);

  static const toJsonFactory = _$AppModulesCampaignSchemasCampaignResultToJson;
  Map<String, dynamic> toJson() =>
      _$AppModulesCampaignSchemasCampaignResultToJson(this);

  @JsonKey(name: 'list_id', defaultValue: '')
  final String listId;
  @JsonKey(name: 'count', defaultValue: 0)
  final int count;
  static const fromJsonFactory =
      _$AppModulesCampaignSchemasCampaignResultFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppModulesCampaignSchemasCampaignResult &&
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

extension $AppModulesCampaignSchemasCampaignResultExtension
    on AppModulesCampaignSchemasCampaignResult {
  AppModulesCampaignSchemasCampaignResult copyWith({
    String? listId,
    int? count,
  }) {
    return AppModulesCampaignSchemasCampaignResult(
      listId: listId ?? this.listId,
      count: count ?? this.count,
    );
  }

  AppModulesCampaignSchemasCampaignResult copyWithWrapped({
    Wrapped<String>? listId,
    Wrapped<int>? count,
  }) {
    return AppModulesCampaignSchemasCampaignResult(
      listId: (listId != null ? listId.value : this.listId),
      count: (count != null ? count.value : this.count),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppModulesCdrSchemasCdrProductComplete {
  const AppModulesCdrSchemasCdrProductComplete({
    required this.nameFr,
    this.nameEn,
    this.descriptionFr,
    this.descriptionEn,
    required this.availableOnline,
    required this.id,
    required this.sellerId,
    this.variants,
    this.relatedMembership,
    this.productConstraints,
    this.documentConstraints,
    this.tickets,
  });

  factory AppModulesCdrSchemasCdrProductComplete.fromJson(
    Map<String, dynamic> json,
  ) => _$AppModulesCdrSchemasCdrProductCompleteFromJson(json);

  static const toJsonFactory = _$AppModulesCdrSchemasCdrProductCompleteToJson;
  Map<String, dynamic> toJson() =>
      _$AppModulesCdrSchemasCdrProductCompleteToJson(this);

  @JsonKey(name: 'name_fr', defaultValue: '')
  final String nameFr;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'description_fr')
  final String? descriptionFr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @JsonKey(name: 'available_online', defaultValue: false)
  final bool availableOnline;
  @JsonKey(name: 'id', defaultValue: '')
  final String id;
  @JsonKey(name: 'seller_id', defaultValue: '')
  final String sellerId;
  @JsonKey(name: 'variants', defaultValue: null)
  final List<ProductVariantComplete>? variants;
  @JsonKey(name: 'related_membership')
  final MembershipSimple? relatedMembership;
  @JsonKey(name: 'product_constraints', defaultValue: null)
  final List<ProductCompleteNoConstraint>? productConstraints;
  @JsonKey(name: 'document_constraints', defaultValue: null)
  final List<DocumentComplete>? documentConstraints;
  @JsonKey(name: 'tickets', defaultValue: null)
  final List<GenerateTicketComplete>? tickets;
  static const fromJsonFactory =
      _$AppModulesCdrSchemasCdrProductCompleteFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppModulesCdrSchemasCdrProductComplete &&
            (identical(other.nameFr, nameFr) ||
                const DeepCollectionEquality().equals(other.nameFr, nameFr)) &&
            (identical(other.nameEn, nameEn) ||
                const DeepCollectionEquality().equals(other.nameEn, nameEn)) &&
            (identical(other.descriptionFr, descriptionFr) ||
                const DeepCollectionEquality().equals(
                  other.descriptionFr,
                  descriptionFr,
                )) &&
            (identical(other.descriptionEn, descriptionEn) ||
                const DeepCollectionEquality().equals(
                  other.descriptionEn,
                  descriptionEn,
                )) &&
            (identical(other.availableOnline, availableOnline) ||
                const DeepCollectionEquality().equals(
                  other.availableOnline,
                  availableOnline,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.sellerId, sellerId) ||
                const DeepCollectionEquality().equals(
                  other.sellerId,
                  sellerId,
                )) &&
            (identical(other.variants, variants) ||
                const DeepCollectionEquality().equals(
                  other.variants,
                  variants,
                )) &&
            (identical(other.relatedMembership, relatedMembership) ||
                const DeepCollectionEquality().equals(
                  other.relatedMembership,
                  relatedMembership,
                )) &&
            (identical(other.productConstraints, productConstraints) ||
                const DeepCollectionEquality().equals(
                  other.productConstraints,
                  productConstraints,
                )) &&
            (identical(other.documentConstraints, documentConstraints) ||
                const DeepCollectionEquality().equals(
                  other.documentConstraints,
                  documentConstraints,
                )) &&
            (identical(other.tickets, tickets) ||
                const DeepCollectionEquality().equals(other.tickets, tickets)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nameFr) ^
      const DeepCollectionEquality().hash(nameEn) ^
      const DeepCollectionEquality().hash(descriptionFr) ^
      const DeepCollectionEquality().hash(descriptionEn) ^
      const DeepCollectionEquality().hash(availableOnline) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(sellerId) ^
      const DeepCollectionEquality().hash(variants) ^
      const DeepCollectionEquality().hash(relatedMembership) ^
      const DeepCollectionEquality().hash(productConstraints) ^
      const DeepCollectionEquality().hash(documentConstraints) ^
      const DeepCollectionEquality().hash(tickets) ^
      runtimeType.hashCode;
}

extension $AppModulesCdrSchemasCdrProductCompleteExtension
    on AppModulesCdrSchemasCdrProductComplete {
  AppModulesCdrSchemasCdrProductComplete copyWith({
    String? nameFr,
    String? nameEn,
    String? descriptionFr,
    String? descriptionEn,
    bool? availableOnline,
    String? id,
    String? sellerId,
    List<ProductVariantComplete>? variants,
    MembershipSimple? relatedMembership,
    List<ProductCompleteNoConstraint>? productConstraints,
    List<DocumentComplete>? documentConstraints,
    List<GenerateTicketComplete>? tickets,
  }) {
    return AppModulesCdrSchemasCdrProductComplete(
      nameFr: nameFr ?? this.nameFr,
      nameEn: nameEn ?? this.nameEn,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      availableOnline: availableOnline ?? this.availableOnline,
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      variants: variants ?? this.variants,
      relatedMembership: relatedMembership ?? this.relatedMembership,
      productConstraints: productConstraints ?? this.productConstraints,
      documentConstraints: documentConstraints ?? this.documentConstraints,
      tickets: tickets ?? this.tickets,
    );
  }

  AppModulesCdrSchemasCdrProductComplete copyWithWrapped({
    Wrapped<String>? nameFr,
    Wrapped<String?>? nameEn,
    Wrapped<String?>? descriptionFr,
    Wrapped<String?>? descriptionEn,
    Wrapped<bool>? availableOnline,
    Wrapped<String>? id,
    Wrapped<String>? sellerId,
    Wrapped<List<ProductVariantComplete>?>? variants,
    Wrapped<MembershipSimple?>? relatedMembership,
    Wrapped<List<ProductCompleteNoConstraint>?>? productConstraints,
    Wrapped<List<DocumentComplete>?>? documentConstraints,
    Wrapped<List<GenerateTicketComplete>?>? tickets,
  }) {
    return AppModulesCdrSchemasCdrProductComplete(
      nameFr: (nameFr != null ? nameFr.value : this.nameFr),
      nameEn: (nameEn != null ? nameEn.value : this.nameEn),
      descriptionFr:
          (descriptionFr != null ? descriptionFr.value : this.descriptionFr),
      descriptionEn:
          (descriptionEn != null ? descriptionEn.value : this.descriptionEn),
      availableOnline:
          (availableOnline != null
              ? availableOnline.value
              : this.availableOnline),
      id: (id != null ? id.value : this.id),
      sellerId: (sellerId != null ? sellerId.value : this.sellerId),
      variants: (variants != null ? variants.value : this.variants),
      relatedMembership:
          (relatedMembership != null
              ? relatedMembership.value
              : this.relatedMembership),
      productConstraints:
          (productConstraints != null
              ? productConstraints.value
              : this.productConstraints),
      documentConstraints:
          (documentConstraints != null
              ? documentConstraints.value
              : this.documentConstraints),
      tickets: (tickets != null ? tickets.value : this.tickets),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppModulesCdrSchemasCdrProductEdit {
  const AppModulesCdrSchemasCdrProductEdit({
    this.nameFr,
    this.nameEn,
    this.descriptionFr,
    this.descriptionEn,
    this.description,
    this.availableOnline,
    this.relatedMembership,
    this.productConstraints,
    this.documentConstraints,
  });

  factory AppModulesCdrSchemasCdrProductEdit.fromJson(
    Map<String, dynamic> json,
  ) => _$AppModulesCdrSchemasCdrProductEditFromJson(json);

  static const toJsonFactory = _$AppModulesCdrSchemasCdrProductEditToJson;
  Map<String, dynamic> toJson() =>
      _$AppModulesCdrSchemasCdrProductEditToJson(this);

  @JsonKey(name: 'name_fr')
  final String? nameFr;
  @JsonKey(name: 'name_en')
  final String? nameEn;
  @JsonKey(name: 'description_fr')
  final String? descriptionFr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'available_online')
  final bool? availableOnline;
  @JsonKey(name: 'related_membership')
  final MembershipSimple? relatedMembership;
  @JsonKey(name: 'product_constraints')
  final List<String>? productConstraints;
  @JsonKey(name: 'document_constraints')
  final List<String>? documentConstraints;
  static const fromJsonFactory = _$AppModulesCdrSchemasCdrProductEditFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppModulesCdrSchemasCdrProductEdit &&
            (identical(other.nameFr, nameFr) ||
                const DeepCollectionEquality().equals(other.nameFr, nameFr)) &&
            (identical(other.nameEn, nameEn) ||
                const DeepCollectionEquality().equals(other.nameEn, nameEn)) &&
            (identical(other.descriptionFr, descriptionFr) ||
                const DeepCollectionEquality().equals(
                  other.descriptionFr,
                  descriptionFr,
                )) &&
            (identical(other.descriptionEn, descriptionEn) ||
                const DeepCollectionEquality().equals(
                  other.descriptionEn,
                  descriptionEn,
                )) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.availableOnline, availableOnline) ||
                const DeepCollectionEquality().equals(
                  other.availableOnline,
                  availableOnline,
                )) &&
            (identical(other.relatedMembership, relatedMembership) ||
                const DeepCollectionEquality().equals(
                  other.relatedMembership,
                  relatedMembership,
                )) &&
            (identical(other.productConstraints, productConstraints) ||
                const DeepCollectionEquality().equals(
                  other.productConstraints,
                  productConstraints,
                )) &&
            (identical(other.documentConstraints, documentConstraints) ||
                const DeepCollectionEquality().equals(
                  other.documentConstraints,
                  documentConstraints,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(nameFr) ^
      const DeepCollectionEquality().hash(nameEn) ^
      const DeepCollectionEquality().hash(descriptionFr) ^
      const DeepCollectionEquality().hash(descriptionEn) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(availableOnline) ^
      const DeepCollectionEquality().hash(relatedMembership) ^
      const DeepCollectionEquality().hash(productConstraints) ^
      const DeepCollectionEquality().hash(documentConstraints) ^
      runtimeType.hashCode;
}

extension $AppModulesCdrSchemasCdrProductEditExtension
    on AppModulesCdrSchemasCdrProductEdit {
  AppModulesCdrSchemasCdrProductEdit copyWith({
    String? nameFr,
    String? nameEn,
    String? descriptionFr,
    String? descriptionEn,
    String? description,
    bool? availableOnline,
    MembershipSimple? relatedMembership,
    List<String>? productConstraints,
    List<String>? documentConstraints,
  }) {
    return AppModulesCdrSchemasCdrProductEdit(
      nameFr: nameFr ?? this.nameFr,
      nameEn: nameEn ?? this.nameEn,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      description: description ?? this.description,
      availableOnline: availableOnline ?? this.availableOnline,
      relatedMembership: relatedMembership ?? this.relatedMembership,
      productConstraints: productConstraints ?? this.productConstraints,
      documentConstraints: documentConstraints ?? this.documentConstraints,
    );
  }

  AppModulesCdrSchemasCdrProductEdit copyWithWrapped({
    Wrapped<String?>? nameFr,
    Wrapped<String?>? nameEn,
    Wrapped<String?>? descriptionFr,
    Wrapped<String?>? descriptionEn,
    Wrapped<String?>? description,
    Wrapped<bool?>? availableOnline,
    Wrapped<MembershipSimple?>? relatedMembership,
    Wrapped<List<String>?>? productConstraints,
    Wrapped<List<String>?>? documentConstraints,
  }) {
    return AppModulesCdrSchemasCdrProductEdit(
      nameFr: (nameFr != null ? nameFr.value : this.nameFr),
      nameEn: (nameEn != null ? nameEn.value : this.nameEn),
      descriptionFr:
          (descriptionFr != null ? descriptionFr.value : this.descriptionFr),
      descriptionEn:
          (descriptionEn != null ? descriptionEn.value : this.descriptionEn),
      description: (description != null ? description.value : this.description),
      availableOnline:
          (availableOnline != null
              ? availableOnline.value
              : this.availableOnline),
      relatedMembership:
          (relatedMembership != null
              ? relatedMembership.value
              : this.relatedMembership),
      productConstraints:
          (productConstraints != null
              ? productConstraints.value
              : this.productConstraints),
      documentConstraints:
          (documentConstraints != null
              ? documentConstraints.value
              : this.documentConstraints),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppModulesPhonebookSchemasPhonebookMembershipBase {
  const AppModulesPhonebookSchemasPhonebookMembershipBase({
    required this.userId,
    required this.associationId,
    required this.mandateYear,
    required this.roleName,
    this.roleTags,
    required this.memberOrder,
  });

  factory AppModulesPhonebookSchemasPhonebookMembershipBase.fromJson(
    Map<String, dynamic> json,
  ) => _$AppModulesPhonebookSchemasPhonebookMembershipBaseFromJson(json);

  static const toJsonFactory =
      _$AppModulesPhonebookSchemasPhonebookMembershipBaseToJson;
  Map<String, dynamic> toJson() =>
      _$AppModulesPhonebookSchemasPhonebookMembershipBaseToJson(this);

  @JsonKey(name: 'user_id', defaultValue: '')
  final String userId;
  @JsonKey(name: 'association_id', defaultValue: '')
  final String associationId;
  @JsonKey(name: 'mandate_year', defaultValue: 0)
  final int mandateYear;
  @JsonKey(name: 'role_name', defaultValue: '')
  final String roleName;
  @JsonKey(name: 'role_tags')
  final String? roleTags;
  @JsonKey(name: 'member_order', defaultValue: 0)
  final int memberOrder;
  static const fromJsonFactory =
      _$AppModulesPhonebookSchemasPhonebookMembershipBaseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppModulesPhonebookSchemasPhonebookMembershipBase &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.associationId, associationId) ||
                const DeepCollectionEquality().equals(
                  other.associationId,
                  associationId,
                )) &&
            (identical(other.mandateYear, mandateYear) ||
                const DeepCollectionEquality().equals(
                  other.mandateYear,
                  mandateYear,
                )) &&
            (identical(other.roleName, roleName) ||
                const DeepCollectionEquality().equals(
                  other.roleName,
                  roleName,
                )) &&
            (identical(other.roleTags, roleTags) ||
                const DeepCollectionEquality().equals(
                  other.roleTags,
                  roleTags,
                )) &&
            (identical(other.memberOrder, memberOrder) ||
                const DeepCollectionEquality().equals(
                  other.memberOrder,
                  memberOrder,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(associationId) ^
      const DeepCollectionEquality().hash(mandateYear) ^
      const DeepCollectionEquality().hash(roleName) ^
      const DeepCollectionEquality().hash(roleTags) ^
      const DeepCollectionEquality().hash(memberOrder) ^
      runtimeType.hashCode;
}

extension $AppModulesPhonebookSchemasPhonebookMembershipBaseExtension
    on AppModulesPhonebookSchemasPhonebookMembershipBase {
  AppModulesPhonebookSchemasPhonebookMembershipBase copyWith({
    String? userId,
    String? associationId,
    int? mandateYear,
    String? roleName,
    String? roleTags,
    int? memberOrder,
  }) {
    return AppModulesPhonebookSchemasPhonebookMembershipBase(
      userId: userId ?? this.userId,
      associationId: associationId ?? this.associationId,
      mandateYear: mandateYear ?? this.mandateYear,
      roleName: roleName ?? this.roleName,
      roleTags: roleTags ?? this.roleTags,
      memberOrder: memberOrder ?? this.memberOrder,
    );
  }

  AppModulesPhonebookSchemasPhonebookMembershipBase copyWithWrapped({
    Wrapped<String>? userId,
    Wrapped<String>? associationId,
    Wrapped<int>? mandateYear,
    Wrapped<String>? roleName,
    Wrapped<String?>? roleTags,
    Wrapped<int>? memberOrder,
  }) {
    return AppModulesPhonebookSchemasPhonebookMembershipBase(
      userId: (userId != null ? userId.value : this.userId),
      associationId:
          (associationId != null ? associationId.value : this.associationId),
      mandateYear: (mandateYear != null ? mandateYear.value : this.mandateYear),
      roleName: (roleName != null ? roleName.value : this.roleName),
      roleTags: (roleTags != null ? roleTags.value : this.roleTags),
      memberOrder: (memberOrder != null ? memberOrder.value : this.memberOrder),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AppTypesStandardResponsesResult {
  const AppTypesStandardResponsesResult({this.success});

  factory AppTypesStandardResponsesResult.fromJson(Map<String, dynamic> json) =>
      _$AppTypesStandardResponsesResultFromJson(json);

  static const toJsonFactory = _$AppTypesStandardResponsesResultToJson;
  Map<String, dynamic> toJson() =>
      _$AppTypesStandardResponsesResultToJson(this);

  @JsonKey(name: 'success', defaultValue: true)
  final bool? success;
  static const fromJsonFactory = _$AppTypesStandardResponsesResultFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppTypesStandardResponsesResult &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $AppTypesStandardResponsesResultExtension
    on AppTypesStandardResponsesResult {
  AppTypesStandardResponsesResult copyWith({bool? success}) {
    return AppTypesStandardResponsesResult(success: success ?? this.success);
  }

  AppTypesStandardResponsesResult copyWithWrapped({Wrapped<bool?>? success}) {
    return AppTypesStandardResponsesResult(
      success: (success != null ? success.value : this.success),
    );
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
  return enums.AccountType.values.firstWhereOrNull(
        (e) => e.value == accountType,
      ) ??
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
  return enums.AccountType.values.firstWhereOrNull(
        (e) => e.value == accountType,
      ) ??
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
  return enums.AmapSlotType.values.firstWhereOrNull(
        (e) => e.value == amapSlotType,
      ) ??
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
  return enums.AmapSlotType.values.firstWhereOrNull(
        (e) => e.value == amapSlotType,
      ) ??
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
  enums.CalendarEventType? calendarEventType,
) {
  return calendarEventType?.value;
}

String? calendarEventTypeToJson(enums.CalendarEventType calendarEventType) {
  return calendarEventType.value;
}

enums.CalendarEventType calendarEventTypeFromJson(
  Object? calendarEventType, [
  enums.CalendarEventType? defaultValue,
]) {
  return enums.CalendarEventType.values.firstWhereOrNull(
        (e) => e.value == calendarEventType,
      ) ??
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
  return enums.CalendarEventType.values.firstWhereOrNull(
        (e) => e.value == calendarEventType,
      ) ??
      defaultValue;
}

String calendarEventTypeExplodedListToJson(
  List<enums.CalendarEventType>? calendarEventType,
) {
  return calendarEventType?.map((e) => e.value!).join(',') ?? '';
}

List<String> calendarEventTypeListToJson(
  List<enums.CalendarEventType>? calendarEventType,
) {
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

String? cdrStatusNullableToJson(enums.CdrStatus? cdrStatus) {
  return cdrStatus?.value;
}

String? cdrStatusToJson(enums.CdrStatus cdrStatus) {
  return cdrStatus.value;
}

enums.CdrStatus cdrStatusFromJson(
  Object? cdrStatus, [
  enums.CdrStatus? defaultValue,
]) {
  return enums.CdrStatus.values.firstWhereOrNull((e) => e.value == cdrStatus) ??
      defaultValue ??
      enums.CdrStatus.swaggerGeneratedUnknown;
}

enums.CdrStatus? cdrStatusNullableFromJson(
  Object? cdrStatus, [
  enums.CdrStatus? defaultValue,
]) {
  if (cdrStatus == null) {
    return null;
  }
  return enums.CdrStatus.values.firstWhereOrNull((e) => e.value == cdrStatus) ??
      defaultValue;
}

String cdrStatusExplodedListToJson(List<enums.CdrStatus>? cdrStatus) {
  return cdrStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> cdrStatusListToJson(List<enums.CdrStatus>? cdrStatus) {
  if (cdrStatus == null) {
    return [];
  }

  return cdrStatus.map((e) => e.value!).toList();
}

List<enums.CdrStatus> cdrStatusListFromJson(
  List? cdrStatus, [
  List<enums.CdrStatus>? defaultValue,
]) {
  if (cdrStatus == null) {
    return defaultValue ?? [];
  }

  return cdrStatus.map((e) => cdrStatusFromJson(e.toString())).toList();
}

List<enums.CdrStatus>? cdrStatusNullableListFromJson(
  List? cdrStatus, [
  List<enums.CdrStatus>? defaultValue,
]) {
  if (cdrStatus == null) {
    return defaultValue;
  }

  return cdrStatus.map((e) => cdrStatusFromJson(e.toString())).toList();
}

String? decisionNullableToJson(enums.Decision? decision) {
  return decision?.value;
}

String? decisionToJson(enums.Decision decision) {
  return decision.value;
}

enums.Decision decisionFromJson(
  Object? decision, [
  enums.Decision? defaultValue,
]) {
  return enums.Decision.values.firstWhereOrNull((e) => e.value == decision) ??
      defaultValue ??
      enums.Decision.swaggerGeneratedUnknown;
}

enums.Decision? decisionNullableFromJson(
  Object? decision, [
  enums.Decision? defaultValue,
]) {
  if (decision == null) {
    return null;
  }
  return enums.Decision.values.firstWhereOrNull((e) => e.value == decision) ??
      defaultValue;
}

String decisionExplodedListToJson(List<enums.Decision>? decision) {
  return decision?.map((e) => e.value!).join(',') ?? '';
}

List<String> decisionListToJson(List<enums.Decision>? decision) {
  if (decision == null) {
    return [];
  }

  return decision.map((e) => e.value!).toList();
}

List<enums.Decision> decisionListFromJson(
  List? decision, [
  List<enums.Decision>? defaultValue,
]) {
  if (decision == null) {
    return defaultValue ?? [];
  }

  return decision.map((e) => decisionFromJson(e.toString())).toList();
}

List<enums.Decision>? decisionNullableListFromJson(
  List? decision, [
  List<enums.Decision>? defaultValue,
]) {
  if (decision == null) {
    return defaultValue;
  }

  return decision.map((e) => decisionFromJson(e.toString())).toList();
}

String? deliveryStatusTypeNullableToJson(
  enums.DeliveryStatusType? deliveryStatusType,
) {
  return deliveryStatusType?.value;
}

String? deliveryStatusTypeToJson(enums.DeliveryStatusType deliveryStatusType) {
  return deliveryStatusType.value;
}

enums.DeliveryStatusType deliveryStatusTypeFromJson(
  Object? deliveryStatusType, [
  enums.DeliveryStatusType? defaultValue,
]) {
  return enums.DeliveryStatusType.values.firstWhereOrNull(
        (e) => e.value == deliveryStatusType,
      ) ??
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
  return enums.DeliveryStatusType.values.firstWhereOrNull(
        (e) => e.value == deliveryStatusType,
      ) ??
      defaultValue;
}

String deliveryStatusTypeExplodedListToJson(
  List<enums.DeliveryStatusType>? deliveryStatusType,
) {
  return deliveryStatusType?.map((e) => e.value!).join(',') ?? '';
}

List<String> deliveryStatusTypeListToJson(
  List<enums.DeliveryStatusType>? deliveryStatusType,
) {
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

String? difficultyNullableToJson(enums.Difficulty? difficulty) {
  return difficulty?.value;
}

String? difficultyToJson(enums.Difficulty difficulty) {
  return difficulty.value;
}

enums.Difficulty difficultyFromJson(
  Object? difficulty, [
  enums.Difficulty? defaultValue,
]) {
  return enums.Difficulty.values.firstWhereOrNull(
        (e) => e.value == difficulty,
      ) ??
      defaultValue ??
      enums.Difficulty.swaggerGeneratedUnknown;
}

enums.Difficulty? difficultyNullableFromJson(
  Object? difficulty, [
  enums.Difficulty? defaultValue,
]) {
  if (difficulty == null) {
    return null;
  }
  return enums.Difficulty.values.firstWhereOrNull(
        (e) => e.value == difficulty,
      ) ??
      defaultValue;
}

String difficultyExplodedListToJson(List<enums.Difficulty>? difficulty) {
  return difficulty?.map((e) => e.value!).join(',') ?? '';
}

List<String> difficultyListToJson(List<enums.Difficulty>? difficulty) {
  if (difficulty == null) {
    return [];
  }

  return difficulty.map((e) => e.value!).toList();
}

List<enums.Difficulty> difficultyListFromJson(
  List? difficulty, [
  List<enums.Difficulty>? defaultValue,
]) {
  if (difficulty == null) {
    return defaultValue ?? [];
  }

  return difficulty.map((e) => difficultyFromJson(e.toString())).toList();
}

List<enums.Difficulty>? difficultyNullableListFromJson(
  List? difficulty, [
  List<enums.Difficulty>? defaultValue,
]) {
  if (difficulty == null) {
    return defaultValue;
  }

  return difficulty.map((e) => difficultyFromJson(e.toString())).toList();
}

String? documentSignatureTypeNullableToJson(
  enums.DocumentSignatureType? documentSignatureType,
) {
  return documentSignatureType?.value;
}

String? documentSignatureTypeToJson(
  enums.DocumentSignatureType documentSignatureType,
) {
  return documentSignatureType.value;
}

enums.DocumentSignatureType documentSignatureTypeFromJson(
  Object? documentSignatureType, [
  enums.DocumentSignatureType? defaultValue,
]) {
  return enums.DocumentSignatureType.values.firstWhereOrNull(
        (e) => e.value == documentSignatureType,
      ) ??
      defaultValue ??
      enums.DocumentSignatureType.swaggerGeneratedUnknown;
}

enums.DocumentSignatureType? documentSignatureTypeNullableFromJson(
  Object? documentSignatureType, [
  enums.DocumentSignatureType? defaultValue,
]) {
  if (documentSignatureType == null) {
    return null;
  }
  return enums.DocumentSignatureType.values.firstWhereOrNull(
        (e) => e.value == documentSignatureType,
      ) ??
      defaultValue;
}

String documentSignatureTypeExplodedListToJson(
  List<enums.DocumentSignatureType>? documentSignatureType,
) {
  return documentSignatureType?.map((e) => e.value!).join(',') ?? '';
}

List<String> documentSignatureTypeListToJson(
  List<enums.DocumentSignatureType>? documentSignatureType,
) {
  if (documentSignatureType == null) {
    return [];
  }

  return documentSignatureType.map((e) => e.value!).toList();
}

List<enums.DocumentSignatureType> documentSignatureTypeListFromJson(
  List? documentSignatureType, [
  List<enums.DocumentSignatureType>? defaultValue,
]) {
  if (documentSignatureType == null) {
    return defaultValue ?? [];
  }

  return documentSignatureType
      .map((e) => documentSignatureTypeFromJson(e.toString()))
      .toList();
}

List<enums.DocumentSignatureType>? documentSignatureTypeNullableListFromJson(
  List? documentSignatureType, [
  List<enums.DocumentSignatureType>? defaultValue,
]) {
  if (documentSignatureType == null) {
    return defaultValue;
  }

  return documentSignatureType
      .map((e) => documentSignatureTypeFromJson(e.toString()))
      .toList();
}

String? documentTypeNullableToJson(enums.DocumentType? documentType) {
  return documentType?.value;
}

String? documentTypeToJson(enums.DocumentType documentType) {
  return documentType.value;
}

enums.DocumentType documentTypeFromJson(
  Object? documentType, [
  enums.DocumentType? defaultValue,
]) {
  return enums.DocumentType.values.firstWhereOrNull(
        (e) => e.value == documentType,
      ) ??
      defaultValue ??
      enums.DocumentType.swaggerGeneratedUnknown;
}

enums.DocumentType? documentTypeNullableFromJson(
  Object? documentType, [
  enums.DocumentType? defaultValue,
]) {
  if (documentType == null) {
    return null;
  }
  return enums.DocumentType.values.firstWhereOrNull(
        (e) => e.value == documentType,
      ) ??
      defaultValue;
}

String documentTypeExplodedListToJson(List<enums.DocumentType>? documentType) {
  return documentType?.map((e) => e.value!).join(',') ?? '';
}

List<String> documentTypeListToJson(List<enums.DocumentType>? documentType) {
  if (documentType == null) {
    return [];
  }

  return documentType.map((e) => e.value!).toList();
}

List<enums.DocumentType> documentTypeListFromJson(
  List? documentType, [
  List<enums.DocumentType>? defaultValue,
]) {
  if (documentType == null) {
    return defaultValue ?? [];
  }

  return documentType.map((e) => documentTypeFromJson(e.toString())).toList();
}

List<enums.DocumentType>? documentTypeNullableListFromJson(
  List? documentType, [
  List<enums.DocumentType>? defaultValue,
]) {
  if (documentType == null) {
    return defaultValue;
  }

  return documentType.map((e) => documentTypeFromJson(e.toString())).toList();
}

String? documentValidationNullableToJson(
  enums.DocumentValidation? documentValidation,
) {
  return documentValidation?.value;
}

String? documentValidationToJson(enums.DocumentValidation documentValidation) {
  return documentValidation.value;
}

enums.DocumentValidation documentValidationFromJson(
  Object? documentValidation, [
  enums.DocumentValidation? defaultValue,
]) {
  return enums.DocumentValidation.values.firstWhereOrNull(
        (e) => e.value == documentValidation,
      ) ??
      defaultValue ??
      enums.DocumentValidation.swaggerGeneratedUnknown;
}

enums.DocumentValidation? documentValidationNullableFromJson(
  Object? documentValidation, [
  enums.DocumentValidation? defaultValue,
]) {
  if (documentValidation == null) {
    return null;
  }
  return enums.DocumentValidation.values.firstWhereOrNull(
        (e) => e.value == documentValidation,
      ) ??
      defaultValue;
}

String documentValidationExplodedListToJson(
  List<enums.DocumentValidation>? documentValidation,
) {
  return documentValidation?.map((e) => e.value!).join(',') ?? '';
}

List<String> documentValidationListToJson(
  List<enums.DocumentValidation>? documentValidation,
) {
  if (documentValidation == null) {
    return [];
  }

  return documentValidation.map((e) => e.value!).toList();
}

List<enums.DocumentValidation> documentValidationListFromJson(
  List? documentValidation, [
  List<enums.DocumentValidation>? defaultValue,
]) {
  if (documentValidation == null) {
    return defaultValue ?? [];
  }

  return documentValidation
      .map((e) => documentValidationFromJson(e.toString()))
      .toList();
}

List<enums.DocumentValidation>? documentValidationNullableListFromJson(
  List? documentValidation, [
  List<enums.DocumentValidation>? defaultValue,
]) {
  if (documentValidation == null) {
    return defaultValue;
  }

  return documentValidation
      .map((e) => documentValidationFromJson(e.toString()))
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
  return enums.FloorsType.values.firstWhereOrNull(
        (e) => e.value == floorsType,
      ) ??
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
  return enums.FloorsType.values.firstWhereOrNull(
        (e) => e.value == floorsType,
      ) ??
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

String? groupTypeNullableToJson(enums.GroupType? groupType) {
  return groupType?.value;
}

String? groupTypeToJson(enums.GroupType groupType) {
  return groupType.value;
}

enums.GroupType groupTypeFromJson(
  Object? groupType, [
  enums.GroupType? defaultValue,
]) {
  return enums.GroupType.values.firstWhereOrNull((e) => e.value == groupType) ??
      defaultValue ??
      enums.GroupType.swaggerGeneratedUnknown;
}

enums.GroupType? groupTypeNullableFromJson(
  Object? groupType, [
  enums.GroupType? defaultValue,
]) {
  if (groupType == null) {
    return null;
  }
  return enums.GroupType.values.firstWhereOrNull((e) => e.value == groupType) ??
      defaultValue;
}

String groupTypeExplodedListToJson(List<enums.GroupType>? groupType) {
  return groupType?.map((e) => e.value!).join(',') ?? '';
}

List<String> groupTypeListToJson(List<enums.GroupType>? groupType) {
  if (groupType == null) {
    return [];
  }

  return groupType.map((e) => e.value!).toList();
}

List<enums.GroupType> groupTypeListFromJson(
  List? groupType, [
  List<enums.GroupType>? defaultValue,
]) {
  if (groupType == null) {
    return defaultValue ?? [];
  }

  return groupType.map((e) => groupTypeFromJson(e.toString())).toList();
}

List<enums.GroupType>? groupTypeNullableListFromJson(
  List? groupType, [
  List<enums.GroupType>? defaultValue,
]) {
  if (groupType == null) {
    return defaultValue;
  }

  return groupType.map((e) => groupTypeFromJson(e.toString())).toList();
}

String? historyTypeNullableToJson(enums.HistoryType? historyType) {
  return historyType?.value;
}

String? historyTypeToJson(enums.HistoryType historyType) {
  return historyType.value;
}

enums.HistoryType historyTypeFromJson(
  Object? historyType, [
  enums.HistoryType? defaultValue,
]) {
  return enums.HistoryType.values.firstWhereOrNull(
        (e) => e.value == historyType,
      ) ??
      defaultValue ??
      enums.HistoryType.swaggerGeneratedUnknown;
}

enums.HistoryType? historyTypeNullableFromJson(
  Object? historyType, [
  enums.HistoryType? defaultValue,
]) {
  if (historyType == null) {
    return null;
  }
  return enums.HistoryType.values.firstWhereOrNull(
        (e) => e.value == historyType,
      ) ??
      defaultValue;
}

String historyTypeExplodedListToJson(List<enums.HistoryType>? historyType) {
  return historyType?.map((e) => e.value!).join(',') ?? '';
}

List<String> historyTypeListToJson(List<enums.HistoryType>? historyType) {
  if (historyType == null) {
    return [];
  }

  return historyType.map((e) => e.value!).toList();
}

List<enums.HistoryType> historyTypeListFromJson(
  List? historyType, [
  List<enums.HistoryType>? defaultValue,
]) {
  if (historyType == null) {
    return defaultValue ?? [];
  }

  return historyType.map((e) => historyTypeFromJson(e.toString())).toList();
}

List<enums.HistoryType>? historyTypeNullableListFromJson(
  List? historyType, [
  List<enums.HistoryType>? defaultValue,
]) {
  if (historyType == null) {
    return defaultValue;
  }

  return historyType.map((e) => historyTypeFromJson(e.toString())).toList();
}

String? kindsNullableToJson(enums.Kinds? kinds) {
  return kinds?.value;
}

String? kindsToJson(enums.Kinds kinds) {
  return kinds.value;
}

enums.Kinds kindsFromJson(Object? kinds, [enums.Kinds? defaultValue]) {
  return enums.Kinds.values.firstWhereOrNull((e) => e.value == kinds) ??
      defaultValue ??
      enums.Kinds.swaggerGeneratedUnknown;
}

enums.Kinds? kindsNullableFromJson(Object? kinds, [enums.Kinds? defaultValue]) {
  if (kinds == null) {
    return null;
  }
  return enums.Kinds.values.firstWhereOrNull((e) => e.value == kinds) ??
      defaultValue;
}

String kindsExplodedListToJson(List<enums.Kinds>? kinds) {
  return kinds?.map((e) => e.value!).join(',') ?? '';
}

List<String> kindsListToJson(List<enums.Kinds>? kinds) {
  if (kinds == null) {
    return [];
  }

  return kinds.map((e) => e.value!).toList();
}

List<enums.Kinds> kindsListFromJson(
  List? kinds, [
  List<enums.Kinds>? defaultValue,
]) {
  if (kinds == null) {
    return defaultValue ?? [];
  }

  return kinds.map((e) => kindsFromJson(e.toString())).toList();
}

List<enums.Kinds>? kindsNullableListFromJson(
  List? kinds, [
  List<enums.Kinds>? defaultValue,
]) {
  if (kinds == null) {
    return defaultValue;
  }

  return kinds.map((e) => kindsFromJson(e.toString())).toList();
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
  return enums.ListType.values.firstWhereOrNull((e) => e.value == listType) ??
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

String? meetingPlaceNullableToJson(enums.MeetingPlace? meetingPlace) {
  return meetingPlace?.value;
}

String? meetingPlaceToJson(enums.MeetingPlace meetingPlace) {
  return meetingPlace.value;
}

enums.MeetingPlace meetingPlaceFromJson(
  Object? meetingPlace, [
  enums.MeetingPlace? defaultValue,
]) {
  return enums.MeetingPlace.values.firstWhereOrNull(
        (e) => e.value == meetingPlace,
      ) ??
      defaultValue ??
      enums.MeetingPlace.swaggerGeneratedUnknown;
}

enums.MeetingPlace? meetingPlaceNullableFromJson(
  Object? meetingPlace, [
  enums.MeetingPlace? defaultValue,
]) {
  if (meetingPlace == null) {
    return null;
  }
  return enums.MeetingPlace.values.firstWhereOrNull(
        (e) => e.value == meetingPlace,
      ) ??
      defaultValue;
}

String meetingPlaceExplodedListToJson(List<enums.MeetingPlace>? meetingPlace) {
  return meetingPlace?.map((e) => e.value!).join(',') ?? '';
}

List<String> meetingPlaceListToJson(List<enums.MeetingPlace>? meetingPlace) {
  if (meetingPlace == null) {
    return [];
  }

  return meetingPlace.map((e) => e.value!).toList();
}

List<enums.MeetingPlace> meetingPlaceListFromJson(
  List? meetingPlace, [
  List<enums.MeetingPlace>? defaultValue,
]) {
  if (meetingPlace == null) {
    return defaultValue ?? [];
  }

  return meetingPlace.map((e) => meetingPlaceFromJson(e.toString())).toList();
}

List<enums.MeetingPlace>? meetingPlaceNullableListFromJson(
  List? meetingPlace, [
  List<enums.MeetingPlace>? defaultValue,
]) {
  if (meetingPlace == null) {
    return defaultValue;
  }

  return meetingPlace.map((e) => meetingPlaceFromJson(e.toString())).toList();
}

String? paymentTypeNullableToJson(enums.PaymentType? paymentType) {
  return paymentType?.value;
}

String? paymentTypeToJson(enums.PaymentType paymentType) {
  return paymentType.value;
}

enums.PaymentType paymentTypeFromJson(
  Object? paymentType, [
  enums.PaymentType? defaultValue,
]) {
  return enums.PaymentType.values.firstWhereOrNull(
        (e) => e.value == paymentType,
      ) ??
      defaultValue ??
      enums.PaymentType.swaggerGeneratedUnknown;
}

enums.PaymentType? paymentTypeNullableFromJson(
  Object? paymentType, [
  enums.PaymentType? defaultValue,
]) {
  if (paymentType == null) {
    return null;
  }
  return enums.PaymentType.values.firstWhereOrNull(
        (e) => e.value == paymentType,
      ) ??
      defaultValue;
}

String paymentTypeExplodedListToJson(List<enums.PaymentType>? paymentType) {
  return paymentType?.map((e) => e.value!).join(',') ?? '';
}

List<String> paymentTypeListToJson(List<enums.PaymentType>? paymentType) {
  if (paymentType == null) {
    return [];
  }

  return paymentType.map((e) => e.value!).toList();
}

List<enums.PaymentType> paymentTypeListFromJson(
  List? paymentType, [
  List<enums.PaymentType>? defaultValue,
]) {
  if (paymentType == null) {
    return defaultValue ?? [];
  }

  return paymentType.map((e) => paymentTypeFromJson(e.toString())).toList();
}

List<enums.PaymentType>? paymentTypeNullableListFromJson(
  List? paymentType, [
  List<enums.PaymentType>? defaultValue,
]) {
  if (paymentType == null) {
    return defaultValue;
  }

  return paymentType.map((e) => paymentTypeFromJson(e.toString())).toList();
}

String? plantStateNullableToJson(enums.PlantState? plantState) {
  return plantState?.value;
}

String? plantStateToJson(enums.PlantState plantState) {
  return plantState.value;
}

enums.PlantState plantStateFromJson(
  Object? plantState, [
  enums.PlantState? defaultValue,
]) {
  return enums.PlantState.values.firstWhereOrNull(
        (e) => e.value == plantState,
      ) ??
      defaultValue ??
      enums.PlantState.swaggerGeneratedUnknown;
}

enums.PlantState? plantStateNullableFromJson(
  Object? plantState, [
  enums.PlantState? defaultValue,
]) {
  if (plantState == null) {
    return null;
  }
  return enums.PlantState.values.firstWhereOrNull(
        (e) => e.value == plantState,
      ) ??
      defaultValue;
}

String plantStateExplodedListToJson(List<enums.PlantState>? plantState) {
  return plantState?.map((e) => e.value!).join(',') ?? '';
}

List<String> plantStateListToJson(List<enums.PlantState>? plantState) {
  if (plantState == null) {
    return [];
  }

  return plantState.map((e) => e.value!).toList();
}

List<enums.PlantState> plantStateListFromJson(
  List? plantState, [
  List<enums.PlantState>? defaultValue,
]) {
  if (plantState == null) {
    return defaultValue ?? [];
  }

  return plantState.map((e) => plantStateFromJson(e.toString())).toList();
}

List<enums.PlantState>? plantStateNullableListFromJson(
  List? plantState, [
  List<enums.PlantState>? defaultValue,
]) {
  if (plantState == null) {
    return defaultValue;
  }

  return plantState.map((e) => plantStateFromJson(e.toString())).toList();
}

String? propagationMethodNullableToJson(
  enums.PropagationMethod? propagationMethod,
) {
  return propagationMethod?.value;
}

String? propagationMethodToJson(enums.PropagationMethod propagationMethod) {
  return propagationMethod.value;
}

enums.PropagationMethod propagationMethodFromJson(
  Object? propagationMethod, [
  enums.PropagationMethod? defaultValue,
]) {
  return enums.PropagationMethod.values.firstWhereOrNull(
        (e) => e.value == propagationMethod,
      ) ??
      defaultValue ??
      enums.PropagationMethod.swaggerGeneratedUnknown;
}

enums.PropagationMethod? propagationMethodNullableFromJson(
  Object? propagationMethod, [
  enums.PropagationMethod? defaultValue,
]) {
  if (propagationMethod == null) {
    return null;
  }
  return enums.PropagationMethod.values.firstWhereOrNull(
        (e) => e.value == propagationMethod,
      ) ??
      defaultValue;
}

String propagationMethodExplodedListToJson(
  List<enums.PropagationMethod>? propagationMethod,
) {
  return propagationMethod?.map((e) => e.value!).join(',') ?? '';
}

List<String> propagationMethodListToJson(
  List<enums.PropagationMethod>? propagationMethod,
) {
  if (propagationMethod == null) {
    return [];
  }

  return propagationMethod.map((e) => e.value!).toList();
}

List<enums.PropagationMethod> propagationMethodListFromJson(
  List? propagationMethod, [
  List<enums.PropagationMethod>? defaultValue,
]) {
  if (propagationMethod == null) {
    return defaultValue ?? [];
  }

  return propagationMethod
      .map((e) => propagationMethodFromJson(e.toString()))
      .toList();
}

List<enums.PropagationMethod>? propagationMethodNullableListFromJson(
  List? propagationMethod, [
  List<enums.PropagationMethod>? defaultValue,
]) {
  if (propagationMethod == null) {
    return defaultValue;
  }

  return propagationMethod
      .map((e) => propagationMethodFromJson(e.toString()))
      .toList();
}

String? raffleStatusTypeNullableToJson(
  enums.RaffleStatusType? raffleStatusType,
) {
  return raffleStatusType?.value;
}

String? raffleStatusTypeToJson(enums.RaffleStatusType raffleStatusType) {
  return raffleStatusType.value;
}

enums.RaffleStatusType raffleStatusTypeFromJson(
  Object? raffleStatusType, [
  enums.RaffleStatusType? defaultValue,
]) {
  return enums.RaffleStatusType.values.firstWhereOrNull(
        (e) => e.value == raffleStatusType,
      ) ??
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
  return enums.RaffleStatusType.values.firstWhereOrNull(
        (e) => e.value == raffleStatusType,
      ) ??
      defaultValue;
}

String raffleStatusTypeExplodedListToJson(
  List<enums.RaffleStatusType>? raffleStatusType,
) {
  return raffleStatusType?.map((e) => e.value!).join(',') ?? '';
}

List<String> raffleStatusTypeListToJson(
  List<enums.RaffleStatusType>? raffleStatusType,
) {
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

String? sizeNullableToJson(enums.Size? size) {
  return size?.value;
}

String? sizeToJson(enums.Size size) {
  return size.value;
}

enums.Size sizeFromJson(Object? size, [enums.Size? defaultValue]) {
  return enums.Size.values.firstWhereOrNull((e) => e.value == size) ??
      defaultValue ??
      enums.Size.swaggerGeneratedUnknown;
}

enums.Size? sizeNullableFromJson(Object? size, [enums.Size? defaultValue]) {
  if (size == null) {
    return null;
  }
  return enums.Size.values.firstWhereOrNull((e) => e.value == size) ??
      defaultValue;
}

String sizeExplodedListToJson(List<enums.Size>? size) {
  return size?.map((e) => e.value!).join(',') ?? '';
}

List<String> sizeListToJson(List<enums.Size>? size) {
  if (size == null) {
    return [];
  }

  return size.map((e) => e.value!).toList();
}

List<enums.Size> sizeListFromJson(
  List? size, [
  List<enums.Size>? defaultValue,
]) {
  if (size == null) {
    return defaultValue ?? [];
  }

  return size.map((e) => sizeFromJson(e.toString())).toList();
}

List<enums.Size>? sizeNullableListFromJson(
  List? size, [
  List<enums.Size>? defaultValue,
]) {
  if (size == null) {
    return defaultValue;
  }

  return size.map((e) => sizeFromJson(e.toString())).toList();
}

String? speciesTypeNullableToJson(enums.SpeciesType? speciesType) {
  return speciesType?.value;
}

String? speciesTypeToJson(enums.SpeciesType speciesType) {
  return speciesType.value;
}

enums.SpeciesType speciesTypeFromJson(
  Object? speciesType, [
  enums.SpeciesType? defaultValue,
]) {
  return enums.SpeciesType.values.firstWhereOrNull(
        (e) => e.value == speciesType,
      ) ??
      defaultValue ??
      enums.SpeciesType.swaggerGeneratedUnknown;
}

enums.SpeciesType? speciesTypeNullableFromJson(
  Object? speciesType, [
  enums.SpeciesType? defaultValue,
]) {
  if (speciesType == null) {
    return null;
  }
  return enums.SpeciesType.values.firstWhereOrNull(
        (e) => e.value == speciesType,
      ) ??
      defaultValue;
}

String speciesTypeExplodedListToJson(List<enums.SpeciesType>? speciesType) {
  return speciesType?.map((e) => e.value!).join(',') ?? '';
}

List<String> speciesTypeListToJson(List<enums.SpeciesType>? speciesType) {
  if (speciesType == null) {
    return [];
  }

  return speciesType.map((e) => e.value!).toList();
}

List<enums.SpeciesType> speciesTypeListFromJson(
  List? speciesType, [
  List<enums.SpeciesType>? defaultValue,
]) {
  if (speciesType == null) {
    return defaultValue ?? [];
  }

  return speciesType.map((e) => speciesTypeFromJson(e.toString())).toList();
}

List<enums.SpeciesType>? speciesTypeNullableListFromJson(
  List? speciesType, [
  List<enums.SpeciesType>? defaultValue,
]) {
  if (speciesType == null) {
    return defaultValue;
  }

  return speciesType.map((e) => speciesTypeFromJson(e.toString())).toList();
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
  return enums.StatusType.values.firstWhereOrNull(
        (e) => e.value == statusType,
      ) ??
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
  return enums.StatusType.values.firstWhereOrNull(
        (e) => e.value == statusType,
      ) ??
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

String? topicNullableToJson(enums.Topic? topic) {
  return topic?.value;
}

String? topicToJson(enums.Topic topic) {
  return topic.value;
}

enums.Topic topicFromJson(Object? topic, [enums.Topic? defaultValue]) {
  return enums.Topic.values.firstWhereOrNull((e) => e.value == topic) ??
      defaultValue ??
      enums.Topic.swaggerGeneratedUnknown;
}

enums.Topic? topicNullableFromJson(Object? topic, [enums.Topic? defaultValue]) {
  if (topic == null) {
    return null;
  }
  return enums.Topic.values.firstWhereOrNull((e) => e.value == topic) ??
      defaultValue;
}

String topicExplodedListToJson(List<enums.Topic>? topic) {
  return topic?.map((e) => e.value!).join(',') ?? '';
}

List<String> topicListToJson(List<enums.Topic>? topic) {
  if (topic == null) {
    return [];
  }

  return topic.map((e) => e.value!).toList();
}

List<enums.Topic> topicListFromJson(
  List? topic, [
  List<enums.Topic>? defaultValue,
]) {
  if (topic == null) {
    return defaultValue ?? [];
  }

  return topic.map((e) => topicFromJson(e.toString())).toList();
}

List<enums.Topic>? topicNullableListFromJson(
  List? topic, [
  List<enums.Topic>? defaultValue,
]) {
  if (topic == null) {
    return defaultValue;
  }

  return topic.map((e) => topicFromJson(e.toString())).toList();
}

String? transactionStatusNullableToJson(
  enums.TransactionStatus? transactionStatus,
) {
  return transactionStatus?.value;
}

String? transactionStatusToJson(enums.TransactionStatus transactionStatus) {
  return transactionStatus.value;
}

enums.TransactionStatus transactionStatusFromJson(
  Object? transactionStatus, [
  enums.TransactionStatus? defaultValue,
]) {
  return enums.TransactionStatus.values.firstWhereOrNull(
        (e) => e.value == transactionStatus,
      ) ??
      defaultValue ??
      enums.TransactionStatus.swaggerGeneratedUnknown;
}

enums.TransactionStatus? transactionStatusNullableFromJson(
  Object? transactionStatus, [
  enums.TransactionStatus? defaultValue,
]) {
  if (transactionStatus == null) {
    return null;
  }
  return enums.TransactionStatus.values.firstWhereOrNull(
        (e) => e.value == transactionStatus,
      ) ??
      defaultValue;
}

String transactionStatusExplodedListToJson(
  List<enums.TransactionStatus>? transactionStatus,
) {
  return transactionStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> transactionStatusListToJson(
  List<enums.TransactionStatus>? transactionStatus,
) {
  if (transactionStatus == null) {
    return [];
  }

  return transactionStatus.map((e) => e.value!).toList();
}

List<enums.TransactionStatus> transactionStatusListFromJson(
  List? transactionStatus, [
  List<enums.TransactionStatus>? defaultValue,
]) {
  if (transactionStatus == null) {
    return defaultValue ?? [];
  }

  return transactionStatus
      .map((e) => transactionStatusFromJson(e.toString()))
      .toList();
}

List<enums.TransactionStatus>? transactionStatusNullableListFromJson(
  List? transactionStatus, [
  List<enums.TransactionStatus>? defaultValue,
]) {
  if (transactionStatus == null) {
    return defaultValue;
  }

  return transactionStatus
      .map((e) => transactionStatusFromJson(e.toString()))
      .toList();
}

String? transactionTypeNullableToJson(enums.TransactionType? transactionType) {
  return transactionType?.value;
}

String? transactionTypeToJson(enums.TransactionType transactionType) {
  return transactionType.value;
}

enums.TransactionType transactionTypeFromJson(
  Object? transactionType, [
  enums.TransactionType? defaultValue,
]) {
  return enums.TransactionType.values.firstWhereOrNull(
        (e) => e.value == transactionType,
      ) ??
      defaultValue ??
      enums.TransactionType.swaggerGeneratedUnknown;
}

enums.TransactionType? transactionTypeNullableFromJson(
  Object? transactionType, [
  enums.TransactionType? defaultValue,
]) {
  if (transactionType == null) {
    return null;
  }
  return enums.TransactionType.values.firstWhereOrNull(
        (e) => e.value == transactionType,
      ) ??
      defaultValue;
}

String transactionTypeExplodedListToJson(
  List<enums.TransactionType>? transactionType,
) {
  return transactionType?.map((e) => e.value!).join(',') ?? '';
}

List<String> transactionTypeListToJson(
  List<enums.TransactionType>? transactionType,
) {
  if (transactionType == null) {
    return [];
  }

  return transactionType.map((e) => e.value!).toList();
}

List<enums.TransactionType> transactionTypeListFromJson(
  List? transactionType, [
  List<enums.TransactionType>? defaultValue,
]) {
  if (transactionType == null) {
    return defaultValue ?? [];
  }

  return transactionType
      .map((e) => transactionTypeFromJson(e.toString()))
      .toList();
}

List<enums.TransactionType>? transactionTypeNullableListFromJson(
  List? transactionType, [
  List<enums.TransactionType>? defaultValue,
]) {
  if (transactionType == null) {
    return defaultValue;
  }

  return transactionType
      .map((e) => transactionTypeFromJson(e.toString()))
      .toList();
}

String? transferTypeNullableToJson(enums.TransferType? transferType) {
  return transferType?.value;
}

String? transferTypeToJson(enums.TransferType transferType) {
  return transferType.value;
}

enums.TransferType transferTypeFromJson(
  Object? transferType, [
  enums.TransferType? defaultValue,
]) {
  return enums.TransferType.values.firstWhereOrNull(
        (e) => e.value == transferType,
      ) ??
      defaultValue ??
      enums.TransferType.swaggerGeneratedUnknown;
}

enums.TransferType? transferTypeNullableFromJson(
  Object? transferType, [
  enums.TransferType? defaultValue,
]) {
  if (transferType == null) {
    return null;
  }
  return enums.TransferType.values.firstWhereOrNull(
        (e) => e.value == transferType,
      ) ??
      defaultValue;
}

String transferTypeExplodedListToJson(List<enums.TransferType>? transferType) {
  return transferType?.map((e) => e.value!).join(',') ?? '';
}

List<String> transferTypeListToJson(List<enums.TransferType>? transferType) {
  if (transferType == null) {
    return [];
  }

  return transferType.map((e) => e.value!).toList();
}

List<enums.TransferType> transferTypeListFromJson(
  List? transferType, [
  List<enums.TransferType>? defaultValue,
]) {
  if (transferType == null) {
    return defaultValue ?? [];
  }

  return transferType.map((e) => transferTypeFromJson(e.toString())).toList();
}

List<enums.TransferType>? transferTypeNullableListFromJson(
  List? transferType, [
  List<enums.TransferType>? defaultValue,
]) {
  if (transferType == null) {
    return defaultValue;
  }

  return transferType.map((e) => transferTypeFromJson(e.toString())).toList();
}

String? walletDeviceStatusNullableToJson(
  enums.WalletDeviceStatus? walletDeviceStatus,
) {
  return walletDeviceStatus?.value;
}

String? walletDeviceStatusToJson(enums.WalletDeviceStatus walletDeviceStatus) {
  return walletDeviceStatus.value;
}

enums.WalletDeviceStatus walletDeviceStatusFromJson(
  Object? walletDeviceStatus, [
  enums.WalletDeviceStatus? defaultValue,
]) {
  return enums.WalletDeviceStatus.values.firstWhereOrNull(
        (e) => e.value == walletDeviceStatus,
      ) ??
      defaultValue ??
      enums.WalletDeviceStatus.swaggerGeneratedUnknown;
}

enums.WalletDeviceStatus? walletDeviceStatusNullableFromJson(
  Object? walletDeviceStatus, [
  enums.WalletDeviceStatus? defaultValue,
]) {
  if (walletDeviceStatus == null) {
    return null;
  }
  return enums.WalletDeviceStatus.values.firstWhereOrNull(
        (e) => e.value == walletDeviceStatus,
      ) ??
      defaultValue;
}

String walletDeviceStatusExplodedListToJson(
  List<enums.WalletDeviceStatus>? walletDeviceStatus,
) {
  return walletDeviceStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> walletDeviceStatusListToJson(
  List<enums.WalletDeviceStatus>? walletDeviceStatus,
) {
  if (walletDeviceStatus == null) {
    return [];
  }

  return walletDeviceStatus.map((e) => e.value!).toList();
}

List<enums.WalletDeviceStatus> walletDeviceStatusListFromJson(
  List? walletDeviceStatus, [
  List<enums.WalletDeviceStatus>? defaultValue,
]) {
  if (walletDeviceStatus == null) {
    return defaultValue ?? [];
  }

  return walletDeviceStatus
      .map((e) => walletDeviceStatusFromJson(e.toString()))
      .toList();
}

List<enums.WalletDeviceStatus>? walletDeviceStatusNullableListFromJson(
  List? walletDeviceStatus, [
  List<enums.WalletDeviceStatus>? defaultValue,
]) {
  if (walletDeviceStatus == null) {
    return defaultValue;
  }

  return walletDeviceStatus
      .map((e) => walletDeviceStatusFromJson(e.toString()))
      .toList();
}

String? walletTypeNullableToJson(enums.WalletType? walletType) {
  return walletType?.value;
}

String? walletTypeToJson(enums.WalletType walletType) {
  return walletType.value;
}

enums.WalletType walletTypeFromJson(
  Object? walletType, [
  enums.WalletType? defaultValue,
]) {
  return enums.WalletType.values.firstWhereOrNull(
        (e) => e.value == walletType,
      ) ??
      defaultValue ??
      enums.WalletType.swaggerGeneratedUnknown;
}

enums.WalletType? walletTypeNullableFromJson(
  Object? walletType, [
  enums.WalletType? defaultValue,
]) {
  if (walletType == null) {
    return null;
  }
  return enums.WalletType.values.firstWhereOrNull(
        (e) => e.value == walletType,
      ) ??
      defaultValue;
}

String walletTypeExplodedListToJson(List<enums.WalletType>? walletType) {
  return walletType?.map((e) => e.value!).join(',') ?? '';
}

List<String> walletTypeListToJson(List<enums.WalletType>? walletType) {
  if (walletType == null) {
    return [];
  }

  return walletType.map((e) => e.value!).toList();
}

List<enums.WalletType> walletTypeListFromJson(
  List? walletType, [
  List<enums.WalletType>? defaultValue,
]) {
  if (walletType == null) {
    return defaultValue ?? [];
  }

  return walletType.map((e) => walletTypeFromJson(e.toString())).toList();
}

List<enums.WalletType>? walletTypeNullableListFromJson(
  List? walletType, [
  List<enums.WalletType>? defaultValue,
]) {
  if (walletType == null) {
    return defaultValue;
  }

  return walletType.map((e) => walletTypeFromJson(e.toString())).toList();
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
