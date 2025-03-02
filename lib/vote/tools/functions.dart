import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

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

String listTypeToString(ListType? type) {
  switch (type) {
    case ListType.serio:
      return 'Serio';
    case ListType.pipo:
      return 'Pipo';
    case ListType.blank:
      return 'Blank';
    default:
      return '';
  }
}

VoteStatus stringToVoteStatus(String votesVoteStatus) {
  switch (votesVoteStatus) {
    case 'waiting':
      return VoteStatus(status: StatusType.waiting);
    case 'open':
      return VoteStatus(status: StatusType.open);
    case 'closed':
      return VoteStatus(status: StatusType.closed);
    case 'counting':
      return VoteStatus(status: StatusType.counting);
    case 'published':
      return VoteStatus(status: StatusType.published);
    default:
      return VoteStatus(status: StatusType.swaggerGeneratedUnknown);
  }
}

String votesVoteStatusToString(VoteStatus votesVoteStatus) {
  switch (votesVoteStatus.status) {
    case StatusType.waiting:
      return 'Waiting';
    case StatusType.open:
      return 'Open';
    case StatusType.closed:
      return 'Closed';
    case StatusType.counting:
      return 'Counting';
    case StatusType.published:
      return 'Published';
    case StatusType.swaggerGeneratedUnknown:
      return '';
  }
}
