import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/repositories/association_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class MyAssociationListNotifier extends ListNotifier<Association> {
  final AssociationRepository associationRepository;
  MyAssociationListNotifier({required this.associationRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Association>>> loadAssociations() async {
    return await loadList(associationRepository.getMyAssociations);
  }
}

final asyncMyAssociationListProvider =
    StateNotifierProvider<
      MyAssociationListNotifier,
      AsyncValue<List<Association>>
    >((ref) {
      final associationRepository = ref.watch(associationRepositoryProvider);
      MyAssociationListNotifier provider = MyAssociationListNotifier(
        associationRepository: associationRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadAssociations();
      });
      return provider;
    });

final myAssociationListProvider = Provider<List<Association>>((ref) {
  final asyncMyAssociationList = ref.watch(asyncMyAssociationListProvider);
  return asyncMyAssociationList.maybeWhen(
    data: (associations) => associations,
    orElse: () => [],
  );
});
