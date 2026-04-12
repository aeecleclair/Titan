import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/recommendation/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isRecommendationAdminProvider = StateProvider<bool>((ref) {
  return hasUserPermission(
    ref,
    RecommendationPermissionConstants.manageRecommendations,
  );
});
