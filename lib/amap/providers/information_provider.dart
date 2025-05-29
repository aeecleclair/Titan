import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/information.dart';
import 'package:myecl/amap/repositories/information_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class InformationNotifier extends SingleNotifier<Information> {
  final InformationRepository informationRepository;
  InformationNotifier({required this.informationRepository})
    : super(const AsyncLoading());
  Future<AsyncValue<Information>> loadInformation() async {
    return await load(informationRepository.getInformation);
  }

  Future<bool> createInformation(Information information) async {
    return await add(informationRepository.createInformation, information);
  }

  Future<bool> updateInformation(Information information) async {
    return await update(informationRepository.updateInformation, information);
  }

  Future<bool> deleteInformation(Information information) async {
    return await delete(
      informationRepository.deleteInformation,
      information,
      "",
    );
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
