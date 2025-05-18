import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/amap/adapters/information.dart';

class InformationNotifier extends SingleNotifierAPI<Information> {
  final Openapi informationRepository;
  InformationNotifier({required this.informationRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<Information>> loadInformation() async {
    return await load(informationRepository.amapInformationGet);
  }

  Future<bool> updateInformation(Information information) async {
    return await update(
      () => informationRepository.amapInformationPatch(
        body: information.toInformationEdit(),
      ),
      information,
    );
  }
}

final informationProvider =
    StateNotifierProvider<InformationNotifier, AsyncValue<Information>>((ref) {
  final informationRepository = ref.watch(repositoryProvider);
  return InformationNotifier(informationRepository: informationRepository)
    ..loadInformation();
});
