import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';

final isAdvertAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userAnnouncerListProvider);
  return me.maybeWhen(data: (data) => data.isNotEmpty, orElse: () => false);
});
