import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/providers/announcer_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

final allAdvertiserList = Provider<List<AdvertiserComplete>>((ref) {
  final advertisersProvider = ref.watch(advertiserListProvider);
  return advertisersProvider.maybeWhen(
      data: (advertisers) => advertisers, orElse: () => []);
});
