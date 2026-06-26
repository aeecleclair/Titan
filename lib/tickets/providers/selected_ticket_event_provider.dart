import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedTicketEventIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setId(String? id) {
    state = id;
  }
}

final selectedTicketEventIdProvider =
    NotifierProvider<SelectedTicketEventIdNotifier, String?>(
      SelectedTicketEventIdNotifier.new,
    );
