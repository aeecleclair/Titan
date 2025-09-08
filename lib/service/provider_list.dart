import 'package:titan/admin/notification_service.dart';
import 'package:titan/advert/notification_service.dart';
import 'package:titan/amap/notification_service.dart';
import 'package:titan/booking/notification_service.dart';
import 'package:titan/event/notification_service.dart';
import 'package:titan/loan/notification_service.dart';
import 'package:titan/ph/notification_service.dart';
import 'package:titan/raffle/notification_service.dart';
import 'package:titan/vote/notification_service.dart';

final providers = {
  "admin": adminProviders,
  "advert": advertProviders,
  "amap": amapProviders,
  "booking": bookingProviders,
  "event": eventProviders,
  "loan": loanProviders,
  "raffle": raffleProviders,
  "vote": voteProviders,
  "ph": phProviders,
};
