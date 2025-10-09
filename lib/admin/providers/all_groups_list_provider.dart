import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';

final allGroupList = Provider<List<SimpleGroup>>((ref) {
  return ref
      .watch(allGroupListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
