import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class InformationNotifier extends SingleNotifierAPI<Information> {
  Openapi get informationRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<Information> build() {
    loadInformation();
    return const AsyncLoading();
  }

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
    NotifierProvider<InformationNotifier, AsyncValue<Information>>(
      InformationNotifier.new,
    );
