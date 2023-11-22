import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String BASE_URL = dotenv.env[kDebugMode ? "DEBUG_HOST" : "RELEASE_HOST"]!;
