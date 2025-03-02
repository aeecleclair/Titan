import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String BASE_URL = dotenv.env[kDebugMode ? "DEV_HOST" : "RELEASE_HOST"]!;
