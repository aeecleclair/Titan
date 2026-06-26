import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class EventImageNotifier extends SingleNotifier<Image> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<Image> build() {
    return const AsyncValue.loading();
  }

  Future<bool> addEventImage(String id, Uint8List bytes) async {
    await repository.calendarEventsEventIdImagePost(eventId: id, image: bytes);
    state = AsyncData(Image.memory(bytes));
    return true;
  }

  void getEventImage(String id) async {
    final response = await repository.calendarEventsEventIdImageGet(
      eventId: id,
    );
    state = AsyncData(
      response.bodyBytes.isEmpty
          ? Image.asset(getTitanLogo())
          : Image.memory(response.bodyBytes),
    );
  }
}

final eventImageProvider =
    NotifierProvider<EventImageNotifier, AsyncValue<Image>>(
      EventImageNotifier.new,
    );
