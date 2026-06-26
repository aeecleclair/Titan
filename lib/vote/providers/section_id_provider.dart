import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/vote/providers/sections_provider.dart';

final sectionIdProvider = NotifierProvider<SectionIdProvider, String>(
  SectionIdProvider.new,
);

class SectionIdProvider extends Notifier<String> {
  @override
  String build() {
    final deliveries = ref.watch(sectionList);
    if (deliveries.isEmpty) {
      return "";
    } else {
      return deliveries.first.id;
    }
  }

  void setId(String i) {
    state = i;
  }
}
