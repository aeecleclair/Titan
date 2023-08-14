import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';

final isAdvertAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userAnnouncerListProvider);
  return me.when(data: (data) =>  data.isNotEmpty , error: (e,s) => false, loading: () => false);
});
