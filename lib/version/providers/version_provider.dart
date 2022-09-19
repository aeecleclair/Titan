import 'package:myecl/tools/providers/single_notifier.dart';

class VersionNotifier extends SingleNotifier<String> {
  VersionNotifier(this._repository) : super(VersionInitial());

  final VersionRepository _repository;

  Future<void> getVersion() async {
    state = VersionLoading();
    try {
      state = VersionLoaded(await _repository.getVersion());
    } catch (e) {
      state = VersionError(e.toString());
    }
  }
}