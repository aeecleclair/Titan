import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isFeedAdminProvider = StateProvider<bool>((ref) {
  return hasUserPermission(ref, FeedPermissionsConstants.manageFeed);
});
