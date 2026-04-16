import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class TicketEventByIdNotifier extends StateNotifier<AsyncValue<TicketEvent>> {
  TicketEventByIdNotifier({required String token, required String id})
    : _id = id,
      super(const AsyncValue.loading()) {
    _repository = TicketsRepository()..setToken(token);
  }

  final String _id;
  late final TicketsRepository _repository;

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final ticketEvent = await _repository.getTicketEventById(_id);
      state = AsyncValue.data(ticketEvent);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final ticketEventByIdProvider =
    StateNotifierProvider.family<
      TicketEventByIdNotifier,
      AsyncValue<TicketEvent>,
      String
    >((ref, id) {
      final token = ref.watch(tokenProvider);
      final notifier = TicketEventByIdNotifier(token: token, id: id);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.load();
      });
      return notifier;
    });

class PublicTicketEventByIdNotifier
    extends StateNotifier<AsyncValue<TicketEvent>> {
  PublicTicketEventByIdNotifier({required String token, required String id})
    : _id = id,
      super(const AsyncValue.loading()) {
    _repository = TicketsRepository()..setToken(token);
  }

  final String _id;
  late final TicketsRepository _repository;

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
      final token = ref.watch(tokenProvider);
      final notifier = PublicTicketEventByIdNotifier(token: token, id: id);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.load();
      });
      return notifier;
    });
