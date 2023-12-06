import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

final allGroupList = Provider<List<CoreGroupSimple>>((ref) {
  return ref
      .watch(allGroupListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
