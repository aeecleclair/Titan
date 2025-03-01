import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class InformationNotifier extends SingleNotifier2<Information> {
  final Openapi informationRepository;
  InformationNotifier({required this.informationRepository})
      : super(const AsyncLoading());

  Future<AsyncValue<Information>> loadInformation() async {
    return await load(informationRepository.amapInformationGet);
  }

  Future<bool> updateInformation(Information information) async {
    return await update(
      () => informationRepository.amapInformationPatch(
        body: InformationEdit(
          manager: information.manager,
          link: information.link,
          description: information.description,
        ),
      ),
      information,
    );
  }
}

final informationProvider =
    StateNotifierProvider<InformationNotifier, AsyncValue<Information>>((ref) {
  final informationRepository = ref.watch(repositoryProvider);
  InformationNotifier informationNotifier =
      InformationNotifier(informationRepository: informationRepository);
  tokenExpireWrapperAuth(ref, () async {
    informationNotifier.loadInformation();
  });
  return informationNotifier;
});
