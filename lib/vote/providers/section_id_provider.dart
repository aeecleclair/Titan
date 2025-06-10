import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/vote/providers/sections_provider.dart';

final sectionIdProvider = StateNotifierProvider<SectionIdProvider, String>((
  ref,
) {
  final deliveries = ref.watch(sectionList);
  if (deliveries.isEmpty) {
    return SectionIdProvider("");
  } else {
    return SectionIdProvider(deliveries.first.id);
  }
});

class SectionIdProvider extends StateNotifier<String> {
  SectionIdProvider(super.id);

  void setId(String i) {
    state = i;
  }
}
