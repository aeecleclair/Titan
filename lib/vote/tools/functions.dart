import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/repositories/status_repository.dart';

ListType stringToListType(String type) {
  switch (type) {
    case 'Serio':
      return ListType.serious;
    case 'Pipo':
      return ListType.fake;
    case 'Blank':
      return ListType.blank;
    default:
      return ListType.blank;
  }
}

String listTypeToString(ListType? type) {
  switch (type) {
    case ListType.serious:
      return 'Serio';
    case ListType.fake:
      return 'Pipo';
    case ListType.blank:
      return 'Blank';
    default:
      return '';
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
    case 'published':
      return Status.published;
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
  }
}
