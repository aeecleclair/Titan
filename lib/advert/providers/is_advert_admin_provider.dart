import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';
import 'package:titan/advert/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isAdvertiserProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userAnnouncerListProvider);
  return me.maybeWhen(data: (data) => data.isNotEmpty, orElse: () => false);
});

final isAdvertAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, AdvertPermissionConstants.manageAdvertisers);
});
