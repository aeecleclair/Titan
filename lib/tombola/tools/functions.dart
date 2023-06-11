import 'package:myecl/tombola/class/raffle_status_type.dart';

RaffleStatusType stringToRaffleStatusType(String raffleStatusType) {
  switch (raffleStatusType) {
    case 'creation':
      return RaffleStatusType.creation;
    case 'open':
      return RaffleStatusType.open;
    case 'locked':
      return RaffleStatusType.locked;
    default:
      return RaffleStatusType.creation;
  }
}

String raffleStatusTypeToString(RaffleStatusType raffleStatusType) {
  switch (raffleStatusType) {
    case RaffleStatusType.creation:
      return 'creation';
    case RaffleStatusType.open:
      return 'open';
    case RaffleStatusType.locked:
      return 'locked';
    default:
      return 'creation';
  }
}