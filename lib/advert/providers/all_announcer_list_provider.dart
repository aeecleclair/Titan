import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';

final allAnnouncerList = Provider<List<Announcer>>((ref) {
  final deliveryProvider = ref.watch(announcerListProvider);
  return deliveryProvider.maybeWhen(data: (loans) => loans, orElse: () => []);
});
