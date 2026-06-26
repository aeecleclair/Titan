import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketIdNotifier extends SingleNotifier<String> {
  Openapi get ticketIdRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<String> build() {
    return const AsyncValue.loading();
  }

  void setTicketId(String i) {
    state = AsyncValue.data(i);
  }
}

final ticketIdProvider = NotifierProvider<TicketIdNotifier, AsyncValue<String>>(
  TicketIdNotifier.new,
);
