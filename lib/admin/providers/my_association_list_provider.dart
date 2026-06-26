import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class MyAssociationListNotifier extends ListNotifierAPI<Association> {
  Openapi get associationRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Association>> build() {
    loadAssociations();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Association>>> loadAssociations() async {
    return await loadList(associationRepository.associationsMeGet);
  }
}

final asyncMyAssociationListProvider =
    NotifierProvider<MyAssociationListNotifier, AsyncValue<List<Association>>>(
      () => MyAssociationListNotifier(),
    );

final myAssociationListProvider = Provider<List<Association>>((ref) {
  final asyncMyAssociationList = ref.watch(asyncMyAssociationListProvider);
  return asyncMyAssociationList.maybeWhen(
    data: (associations) => associations,
    orElse: () => [],
  );
});
