import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/repositories/user_information_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class TicketIdNotifier extends SingleNotifier<String> {
  final UserInformationRepository ticketIdRepository;
  TicketIdNotifier(this.ticketIdRepository) : super(const AsyncValue.loading());

  void setTicketId(String i) {
    state = AsyncValue.data(i);
  }
}

final ticketIdProvider =
    StateNotifierProvider<TicketIdNotifier, AsyncValue<String>>((ref) {
      final userInformationRepository = ref.watch(
        userInformationRepositoryProvider,
      );
      TicketIdNotifier notifier = TicketIdNotifier(userInformationRepository);
      return notifier;
    });
