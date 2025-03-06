import 'package:myecl/admin/notification_service.dart';
import 'package:myecl/advert/notification_service.dart';
import 'package:myecl/amap/notification_service.dart';
import 'package:myecl/booking/notification_service.dart';
import 'package:myecl/event/notification_service.dart';
import 'package:myecl/loan/notification_service.dart';
import 'package:myecl/ph/notification_service.dart';
import 'package:myecl/vote/notification_service.dart';

final providers = {
  "admin": adminProviders,
  "advert": advertProviders,
  "amap": amapProviders,
  "booking": bookingProviders,
  "event": eventProviders,
  "loan": loanProviders,
  "vote": voteProviders,
  "ph": phProviders,
};
