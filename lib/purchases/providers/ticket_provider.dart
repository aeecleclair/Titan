import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketNotifier extends SingleNotifier<AppModulesCdrSchemasCdrTicket> {
  Openapi get ticketRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<AppModulesCdrSchemasCdrTicket> build() {
    return const AsyncValue.loading();
  }

  void setTicket(AppModulesCdrSchemasCdrTicket i) {
    state = AsyncValue.data(i);
  }

  Future<AsyncValue<TicketSecret>> loadTicketSecret() async {
    return state.maybeWhen(
      orElse: () async {
        return AsyncValue.error(
          'AppModulesCdrSchemasCdrTicket is not loaded',
          StackTrace.current,
        );
      },
      data: (value) async {
        final response = await ticketRepository
            .cdrUsersMeTicketsTicketIdSecretGet(ticketId: value.id);
        if (response.isSuccessful) {
          return AsyncValue.data(response.body!);
        }
        return AsyncValue.error(response.error.toString(), StackTrace.current);
      },
    );
  }
}

final ticketProvider =
    NotifierProvider<TicketNotifier, AsyncValue<AppModulesCdrSchemasCdrTicket>>(
      TicketNotifier.new,
    );
