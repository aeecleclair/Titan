import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';

final isUserAdmin = StateProvider<bool>((ref) {
  final admins = ref.watch(userAnnouncerListProvider);
  final adminName = admins.when(
      data: (admins) => admins.map((e) => e.name).toList(),
      loading: () => [],
      error: (error, stackTrace) => []);
  return adminName.isNotEmpty;
});
