import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketChangeOverNotifier extends Notifier<AsyncValue<void>> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<bool> requestChangeOver(String ticketId, String email) async {
    state = const AsyncValue.loading();
    try {
      final response = await repository
          .ticketsUserMeTicketsChangeOverRequestPost(
            body: TicketChangeOverInvitation(ticketId: ticketId, email: email),
          );
      if (!response.isSuccessful) {
        throw Exception(response.error?.toString() ?? 'Change over failed');
      }
      state = const AsyncValue.data(null);
      return true;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e.toString(), stackTrace);
      return false;
    }
  }
}

final ticketChangeOverProvider =
    NotifierProvider<TicketChangeOverNotifier, AsyncValue<void>>(
      TicketChangeOverNotifier.new,
    );
