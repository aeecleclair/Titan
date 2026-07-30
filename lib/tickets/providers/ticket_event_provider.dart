import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class TicketEventByIdNotifier extends StateNotifier<AsyncValue<TicketEvent>> {
  TicketEventByIdNotifier({required this._repository, required this._id})
    : super(const AsyncValue.loading());

  final TicketsRepository _repository;
  final String _id;

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final ticketEvent = await _repository.getTicketEventById(_id);
      state = AsyncValue.data(ticketEvent);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void setEvent(TicketEvent event) {
    state = AsyncValue.data(event);
  }
}

final ticketEventByIdProvider =
    StateNotifierProvider.family<
      TicketEventByIdNotifier,
      AsyncValue<TicketEvent>,
      String
    >((ref, id) {
      final repository = ref.watch(ticketsRepositoryProvider);
      final notifier = TicketEventByIdNotifier(repository: repository, id: id);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.load();
      });
      return notifier;
    });

class PublicTicketEventByIdNotifier
    extends StateNotifier<AsyncValue<TicketEvent>> {
  PublicTicketEventByIdNotifier({required this._repository, required this._id})
    : super(const AsyncValue.loading());

  final TicketsRepository _repository;
  final String _id;

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final ticketEvent = await _repository.getPublicTicketEventById(_id);
      state = AsyncValue.data(ticketEvent);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final publicTicketEventByIdProvider =
    StateNotifierProvider.family<
      PublicTicketEventByIdNotifier,
      AsyncValue<TicketEvent>,
      String
    >((ref, id) {
      final repository = ref.watch(ticketsRepositoryProvider);
      final notifier = PublicTicketEventByIdNotifier(
        repository: repository,
        id: id,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.load();
      });
      return notifier;
    });
