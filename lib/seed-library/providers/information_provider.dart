import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/class/information.dart';
import 'package:titan/seed-library/repositories/information_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class InformationNotifier extends SingleNotifier<Information> {
  final InformationRepository informationRepository;
  InformationNotifier({required this.informationRepository})
    : super(const AsyncLoading());
  Future<AsyncValue<Information>> loadInformation() async {
    return await load(informationRepository.getInformation);
  }

  Future<bool> updateInformation(Information information) async {
    return await update(informationRepository.updateInformation, information);
  }
}

final informationProvider =
    StateNotifierProvider<InformationNotifier, AsyncValue<Information>>((ref) {
      final informationRepository = ref.watch(informationRepositoryProvider);
      InformationNotifier informationNotifier = InformationNotifier(
        informationRepository: informationRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        informationNotifier.loadInformation();
      });
      return informationNotifier;
    });

final syncInformationProvider = StateProvider<Information>((ref) {
  final info = ref.watch(informationProvider);
  return info.maybeWhen(data: (data) => data, orElse: Information.empty);
});
