import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class StructureManagerProvider extends Notifier<CoreUserSimple> {
  @override
  CoreUserSimple build() {
    return CoreUserSimple.empty();
  }

  void setUser(CoreUserSimple user) {
    state = user;
  }
}

final structureManagerProvider =
    NotifierProvider<StructureManagerProvider, CoreUserSimple>(
      () => StructureManagerProvider(),
    );
