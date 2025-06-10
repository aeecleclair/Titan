import 'package:titan/raffle/class/raffle_status_type.dart';

RaffleStatusType stringToRaffleStatusType(String raffleStatusType) {
  switch (raffleStatusType) {
    case 'creation':
      return RaffleStatusType.creation;
    case 'open':
      return RaffleStatusType.open;
    case 'lock':
      return RaffleStatusType.lock;
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
    case RaffleStatusType.lock:
      return 'lock';
  }
}
