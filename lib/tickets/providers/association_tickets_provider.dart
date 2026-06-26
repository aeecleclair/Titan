import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

/// The ticket events an association runs, so another module can offer them as
/// an existing ticketing to point at.
class AssociationTicketEventListNotifier extends ListNotifierAPI<EventSimple> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<EventSimple>> build() {
    return const AsyncValue.data([]);
  }

  Future<AsyncValue<List<EventSimple>>> loadTicketEvents(
    String? associationId,
  ) async {
    if (associationId == null) {
      state = const AsyncValue.data([]);
      return state;
    }
    return await loadList(
      () => repository.ticketsAdminAssociationAssociationIdEventsGet(
        associationId: associationId,
      ),
    );
  }
}

final associationTicketEventListProvider =
    NotifierProvider<
      AssociationTicketEventListNotifier,
      AsyncValue<List<EventSimple>>
    >(AssociationTicketEventListNotifier.new);
