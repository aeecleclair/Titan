import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plausible_analytics/plausible_analytics.dart';

final serverUrl = dotenv.env["PLAUSIBLE_HOST"];
final domain = dotenv.env["PLAUSIBLE_DOMAIN"];

final Plausible? plausible = kDebugMode ? null : Plausible(serverUrl!, domain!);
