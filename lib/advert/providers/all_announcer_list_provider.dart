import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/advert/class/announcer.dart';
import 'package:titan/advert/providers/announcer_list_provider.dart';

final allAnnouncerList = Provider<List<Announcer>>((ref) {
  final announcersProvider = ref.watch(announcerListProvider);
  return announcersProvider.maybeWhen(
    data: (announcers) => announcers,
    orElse: () => [],
  );
});
