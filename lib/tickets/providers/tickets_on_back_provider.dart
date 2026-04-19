import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Optional callback defined by the caller when opening the ticketEvent module.
/// If set, the ticketEvent template back button will call this instead of [QR.back].
final ticketsOnBackProvider = StateProvider<VoidCallback?>((ref) => null);
