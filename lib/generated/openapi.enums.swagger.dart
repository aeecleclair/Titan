import 'package:json_annotation/json_annotation.dart';

enum AccountType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('39691052-2ae5-4e12-99d0-7a9f5f2b0136')
  value_396910522ae54e1299d07a9f5f2b0136(
      '39691052-2ae5-4e12-99d0-7a9f5f2b0136'),
  @JsonValue('ab4c7503-41b3-11ee-8177-089798f1a4a5')
  ab4c750341b311ee8177089798f1a4a5('ab4c7503-41b3-11ee-8177-089798f1a4a5'),
  @JsonValue('703056c4-be9d-475c-aa51-b7fc62a96aaa')
  value_703056c4Be9d475cAa51B7fc62a96aaa(
      '703056c4-be9d-475c-aa51-b7fc62a96aaa'),
  @JsonValue('29751438-103c-42f2-b09b-33fbb20758a7')
  value_29751438103c42f2B09b33fbb20758a7(
      '29751438-103c-42f2-b09b-33fbb20758a7');

  final String? value;

  const AccountType(this.value);
}

enum AmapSlotType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('midi')
  midi('midi'),
  @JsonValue('soir')
  soir('soir');

  final String? value;

  const AmapSlotType(this.value);
}

enum CalendarEventType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Event AE')
  eventAe('Event AE'),
  @JsonValue('Event USE')
  eventUse('Event USE'),
  @JsonValue('Asso indé')
  assoInd('Asso indé'),
  @JsonValue('HH')
  hh('HH'),
  @JsonValue('Strass')
  strass('Strass'),
  @JsonValue('Soirée')
  soirE('Soirée'),
  @JsonValue('Autre')
  autre('Autre');

  final String? value;

  const CalendarEventType(this.value);
}

enum CapsMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('single')
  single('single'),
  @JsonValue('cd')
  cd('cd'),
  @JsonValue('capacks')
  capacks('capacks'),
  @JsonValue('semi_capacks')
  semiCapacks('semi_capacks');

  final String? value;

  const CapsMode(this.value);
}

enum DeliveryStatusType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('creation')
  creation('creation'),
  @JsonValue('orderable')
  orderable('orderable'),
  @JsonValue('locked')
  locked('locked'),
  @JsonValue('delivered')
  delivered('delivered'),
  @JsonValue('archived')
  archived('archived');

  final String? value;

  const DeliveryStatusType(this.value);
}

enum FloorsType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Autre')
  autre('Autre'),
  @JsonValue('Adoma')
  adoma('Adoma'),
  @JsonValue('Exte')
  exte('Exte'),
  @JsonValue('T1')
  t1('T1'),
  @JsonValue('T2')
  t2('T2'),
  @JsonValue('T3')
  t3('T3'),
  @JsonValue('T4')
  t4('T4'),
  @JsonValue('T56')
  t56('T56'),
  @JsonValue('U1')
  u1('U1'),
  @JsonValue('U2')
  u2('U2'),
  @JsonValue('U3')
  u3('U3'),
  @JsonValue('U4')
  u4('U4'),
  @JsonValue('U56')
  u56('U56'),
  @JsonValue('V1')
  v1('V1'),
  @JsonValue('V2')
  v2('V2'),
  @JsonValue('V3')
  v3('V3'),
  @JsonValue('V45')
  v45('V45'),
  @JsonValue('V6')
  v6('V6'),
  @JsonValue('X1')
  x1('X1'),
  @JsonValue('X2')
  x2('X2'),
  @JsonValue('X3')
  x3('X3'),
  @JsonValue('X4')
  x4('X4'),
  @JsonValue('X5')
  x5('X5'),
  @JsonValue('X6')
  x6('X6');

  final String? value;

  const FloorsType(this.value);
}

enum ListType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Serio')
  serio('Serio'),
  @JsonValue('Pipo')
  pipo('Pipo'),
  @JsonValue('Blank')
  blank('Blank');

  final String? value;

  const ListType(this.value);
}

enum RaffleStatusType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('creation')
  creation('creation'),
  @JsonValue('open')
  open('open'),
  @JsonValue('lock')
  lock('lock');

  final String? value;

  const RaffleStatusType(this.value);
}

enum StatusType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('waiting')
  waiting('waiting'),
  @JsonValue('open')
  open('open'),
  @JsonValue('closed')
  closed('closed'),
  @JsonValue('counting')
  counting('counting'),
  @JsonValue('published')
  published('published');

  final String? value;

  const StatusType(this.value);
}

enum AppUtilsTypesBookingTypeDecision {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('approved')
  approved('approved'),
  @JsonValue('declined')
  declined('declined'),
  @JsonValue('pending')
  pending('pending');

  final String? value;

  const AppUtilsTypesBookingTypeDecision(this.value);
}

enum AppUtilsTypesCalendarTypesDecision {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('approved')
  approved('approved'),
  @JsonValue('declined')
  declined('declined'),
  @JsonValue('pending')
  pending('pending');

  final String? value;

  const AppUtilsTypesCalendarTypesDecision(this.value);
}
