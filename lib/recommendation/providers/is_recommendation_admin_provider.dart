import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isRecommendationAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups
      .map((e) => e.id)
      .contains("53a669d6-84b1-4352-8d7c-421c1fbd9c6a");
});
