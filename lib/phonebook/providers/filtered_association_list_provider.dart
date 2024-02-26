import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/repositories/association_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class FilteredAssociationListNotifier extends ListNotifier<Association> {
  final AssociationRepository associationRepository = AssociationRepository();
  FilteredAssociationListNotifier({
    required String token,
    required this.associationList,})
      : super(const AsyncValue.loading()) {
    associationRepository.setToken(token);
  }
    
  late final AsyncValue<List<Association>> associationList;

  Future<AsyncValue<List<Association>>> loadAssociations() async {
    return await loadList(() async => associationRepository.getAssociationList());
  }

  void filterAssociationList(String filter) async {
    associationList.maybeWhen(
      data: (d) {
        state = AsyncValue.data(d.where((association) => association.name.toLowerCase().contains(filter.toLowerCase())).toList());
      },
      orElse: () => state = const AsyncLoading());
  }

  void setAssociationList(List<Association> associationList) {
    state.whenData(
      (d) {
        state =
            AsyncValue.data(associationList);
      },
    );
  }
}

final filteredAssociationListProvider =
    StateNotifierProvider<FilteredAssociationListNotifier, AsyncValue<List<Association>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final associationList = ref.watch(associationListProvider);
  FilteredAssociationListNotifier notifier = FilteredAssociationListNotifier(token: token, associationList: associationList);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAssociations();
  });
  return notifier;
});
