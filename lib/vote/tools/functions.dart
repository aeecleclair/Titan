import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/repositories/status_repository.dart';

ListType stringToListType(String type) {
  switch (type) {
    case 'Serio':
      return ListType.serio;
    case 'Pipo':
      return ListType.pipo;
    case 'Blank':
      return ListType.blank;
    default:
      return ListType.blank;
  }
}


Status stringToStatus(String status) {
  switch (status) {
    case 'waiting':
      return Status.waiting;
    case 'open':
      return Status.open;
    case 'closed':
      return Status.closed;
    case 'counting':
      return Status.counting;
    default:
      return Status.waiting;
  }
}

String statusToString(Status status) {
  switch (status) {
    case Status.waiting:
      return 'Waiting';
    case Status.open:
      return 'Open';
    case Status.closed:
      return 'Closed';
    case Status.counting:
      return 'Counting';
    case Status.published:
      return 'Published';
    default:
      return 'Waiting';
  }
}