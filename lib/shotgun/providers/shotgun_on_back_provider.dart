import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Optional callback defined by the caller when opening the shotgun module.
/// If set, the shotgun template back button will call this instead of [QR.back].
final shotgunOnBackProvider = StateProvider<VoidCallback?>((ref) => null);
