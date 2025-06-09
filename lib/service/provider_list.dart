import 'package:myemapp/admin/notification_service.dart';
import 'package:myemapp/advert/notification_service.dart';
import 'package:myemapp/event/notification_service.dart';
import 'package:myemapp/vote/notification_service.dart';

final providers = {
  "admin": adminProviders,
  "advert": advertProviders,
  "event": eventProviders,
  "vote": voteProviders,
};
