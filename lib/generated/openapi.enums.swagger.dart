import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum AccountType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('student')
  student('student'),
  @JsonValue('former_student')
  formerStudent('former_student'),
  @JsonValue('staff')
  staff('staff'),
  @JsonValue('association')
  association('association'),
  @JsonValue('external')
  $external('external'),
  @JsonValue('other_school_student')
  otherSchoolStudent('other_school_student'),
  @JsonValue('demo')
  demo('demo');

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
  @JsonValue('Asso indÃ©')
  assoInd('Asso indÃ©'),
  @JsonValue('HH')
  hh('HH'),
  @JsonValue('Strass')
  strass('Strass'),
  @JsonValue('Rewass')
  rewass('Rewass'),
  @JsonValue('Autre')
  autre('Autre');

  final String? value;

  const CalendarEventType(this.value);
}

enum CdrStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('pending')
  pending('pending'),
  @JsonValue('online')
  online('online'),
  @JsonValue('onsite')
  onsite('onsite'),
  @JsonValue('closed')
  closed('closed');

  final String? value;

  const CdrStatus(this.value);
}

enum Decision {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('approved')
  approved('approved'),
  @JsonValue('declined')
  declined('declined'),
  @JsonValue('pending')
  pending('pending');

  final String? value;

  const Decision(this.value);
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

enum Difficulty {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('discovery')
  discovery('discovery'),
  @JsonValue('sports')
  sports('sports'),
  @JsonValue('expert')
  expert('expert');

  final String? value;

  const Difficulty(this.value);
}

enum DocumentSignatureType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('material')
  material('material'),
  @JsonValue('numeric')
  numeric('numeric');

  final String? value;

  const DocumentSignatureType(this.value);
}

enum DocumentType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('idCard')
  idcard('idCard'),
  @JsonValue('medicalCertificate')
  medicalcertificate('medicalCertificate'),
  @JsonValue('studentCard')
  studentcard('studentCard'),
  @JsonValue('raidRules')
  raidrules('raidRules'),
  @JsonValue('parentAuthorization')
  parentauthorization('parentAuthorization');

  final String? value;

  const DocumentType(this.value);
}

enum DocumentValidation {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('pending')
  pending('pending'),
  @JsonValue('accepted')
  accepted('accepted'),
  @JsonValue('refused')
  refused('refused'),
  @JsonValue('temporary')
  temporary('temporary');

  final String? value;

  const DocumentValidation(this.value);
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

enum HistoryType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('transfer')
  transfer('transfer'),
  @JsonValue('received')
  received('received'),
  @JsonValue('given')
  given('given');

  final String? value;

  const HistoryType(this.value);
}

enum Kinds {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ComitÃ©')
  comit('ComitÃ©'),
  @JsonValue('Section AE')
  sectionAe('Section AE'),
  @JsonValue('Club AE')
  clubAe('Club AE'),
  @JsonValue('Section USE')
  sectionUse('Section USE'),
  @JsonValue('Club USE')
  clubUse('Club USE'),
  @JsonValue('Asso indÃ©')
  assoInd('Asso indÃ©');

  final String? value;

  const Kinds(this.value);
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

enum MeetingPlace {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('centrale')
  centrale('centrale'),
  @JsonValue('bellecour')
  bellecour('bellecour'),
  @JsonValue('anyway')
  anyway('anyway');

  final String? value;

  const MeetingPlace(this.value);
}

enum PaymentType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('cash')
  cash('cash'),
  @JsonValue('check')
  check('check'),
  @JsonValue('HelloAsso')
  helloasso('HelloAsso'),
  @JsonValue('card')
  card('card'),
  @JsonValue('archived')
  archived('archived');

  final String? value;

  const PaymentType(this.value);
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

enum Size {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('XS')
  xs('XS'),
  @JsonValue('S')
  s('S'),
  @JsonValue('M')
  m('M'),
  @JsonValue('L')
  l('L'),
  @JsonValue('XL')
  xl('XL'),
  @JsonValue('None')
  none('None');

  final String? value;

  const Size(this.value);
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

enum Topic {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('cinema')
  cinema('cinema'),
  @JsonValue('advert')
  advert('advert'),
  @JsonValue('amap')
  amap('amap'),
  @JsonValue('booking')
  booking('booking'),
  @JsonValue('event')
  event('event'),
  @JsonValue('loan')
  loan('loan'),
  @JsonValue('raffle')
  raffle('raffle'),
  @JsonValue('vote')
  vote('vote'),
  @JsonValue('ph')
  ph('ph'),
  @JsonValue('test')
  test('test');

  final String? value;

  const Topic(this.value);
}

enum TransactionStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('confirmed')
  confirmed('confirmed'),
  @JsonValue('canceled')
  canceled('canceled'),
  @JsonValue('refunded')
  refunded('refunded');

  final String? value;

  const TransactionStatus(this.value);
}

enum TransactionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('direct')
  direct('direct'),
  @JsonValue('request')
  request('request'),
  @JsonValue('refund')
  refund('refund');

  final String? value;

  const TransactionType(this.value);
}

enum TransferType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('hello_asso')
  helloAsso('hello_asso'),
  @JsonValue('check')
  check('check'),
  @JsonValue('cash')
  cash('cash'),
  @JsonValue('bank_transfer')
  bankTransfer('bank_transfer');

  final String? value;

  const TransferType(this.value);
}

enum WalletDeviceStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('inactive')
  inactive('inactive'),
  @JsonValue('active')
  active('active'),
  @JsonValue('revoked')
  revoked('revoked');

  final String? value;

  const WalletDeviceStatus(this.value);
}

enum WalletType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('user')
  user('user'),
  @JsonValue('store')
  store('store');

  final String? value;

  const WalletType(this.value);
}
