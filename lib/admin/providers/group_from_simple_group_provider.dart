import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/providers/single_map_provider.dart';

class GroupFromSimpleGroupNotifier
    extends SingleMapNotifier<String, CoreGroup> {
  @override
  Map<String, AsyncValue<CoreGroup>?> build() {
    return {};
  }
}

final groupFromSimpleGroupProvider =
    NotifierProvider<
      GroupFromSimpleGroupNotifier,
      Map<String, AsyncValue<CoreGroup>?>
    >(() => GroupFromSimpleGroupNotifier());
