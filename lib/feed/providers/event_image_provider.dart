import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/repositories/event_image_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class EventImageNotifier extends SingleNotifier<Image> {
  final eventImageRepository = EventImageRepository();
  EventImageNotifier({required String token})
    : super(const AsyncValue.loading()) {
    eventImageRepository.setToken(token);
  }

  Future<bool> addEventImage(String id, Uint8List bytes) async {
    final image = await eventImageRepository.addEventImage(bytes, id);
    if (image.toString() != "") {
      state = AsyncData(image);
      return true;
    }
    return false;
  }
}

final eventImageProvider =
    StateNotifierProvider<EventImageNotifier, AsyncValue<Image>>((ref) {
      final token = ref.watch(tokenProvider);
      return EventImageNotifier(token: token);
    });
