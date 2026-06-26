import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Optional callback defined by the caller when opening the ticketEvent module.
/// If set, the ticketEvent template back button will call this instead of [QR.back].
class TicketsOnBackNotifier extends Notifier<VoidCallback?> {
  @override
  VoidCallback? build() => null;

  void setOnBack(VoidCallback? onBack) {
    state = onBack;
  }
}

final ticketsOnBackProvider =
    NotifierProvider<TicketsOnBackNotifier, VoidCallback?>(
      TicketsOnBackNotifier.new,
    );
